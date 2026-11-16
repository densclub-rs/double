"""Remote protocol/comparison fixtures. No real network or credentials."""
import contextlib
import io
import json
from pathlib import Path
import subprocess
import types
import unittest
from unittest.mock import patch

import test_inspection as fixtures


class RemoteInspection(unittest.TestCase):
    setUp = fixtures.Inspection.setUp
    knowledge = fixtures.Inspection.knowledge
    write = fixtures.Inspection.write
    git = fixtures.Inspection.git
    snapshot = fixtures.Inspection.snapshot
    tag = fixtures.Inspection.tag

    def module(self):
        module = types.ModuleType('git_double_test')
        module.__file__ = str(fixtures.SCRIPT)
        exec(compile(fixtures.SCRIPT.read_text(), str(fixtures.SCRIPT), 'exec'), module.__dict__)
        return module

    def remote_tag(self, version='1.2.3-rc', oid=None, commit=None):
        module = self.module()
        name = fixtures.MACHINE + '-' + version
        channel = module.parse_release_tag(name)[2]
        return {'name': name, 'ref': 'refs/tags/' + name, 'machine': fixtures.MACHINE,
                'version': version.removesuffix('-rc').removesuffix('-dev'), 'channel': channel,
                'oid': oid or 'a' * 40, 'commit': commit, 'annotation': None}

    def release(self, version='1.2.3-rc', draft=False, prerelease=True):
        return {'machine': fixtures.MACHINE, 'id': 1, 'name': 'Release',
                'tag': fixtures.MACHINE + '-' + version, 'draft': draft,
                'prerelease': prerelease, 'published_at': None if draft else '2026-11-09T00:00:00Z',
                'url': 'https://github.com/example/fork/releases/1', 'assets': []}

    def report(self, command, tags=(), releases=(), state=None, extra=()):
        module = self.module()
        self.git('config', 'remote.origin.url', 'git@github.com:example/fork.git')
        before = self.snapshot()
        state = state or {'state': 'ok', 'errors': [], 'draft_visibility': 'unknown'}
        args = module.inspection_arguments([command, '--machine', fixtures.MACHINE, *extra])
        with patch.object(module.Path, 'cwd', return_value=self.root), \
                patch.object(module, 'read_remote_tags', return_value=list(tags)), \
                patch.object(module, 'read_releases', return_value=(list(releases), state)):
            report = module.inspection_report(args)
        self.assertEqual(before, self.snapshot())
        return report

    def test_versions_stable_and_newer_rc(self):
        tags = [self.remote_tag('1.2.2'), self.remote_tag('1.2.3-rc'), self.remote_tag('9.0.0-dev')]
        report = self.report('versions', tags=tags)
        item = report['machines'][0]
        self.assertEqual(report['exit_code'], 0)
        self.assertEqual(item['remote']['stable']['version'], '1.2.2')
        self.assertEqual(item['remote']['rc']['version'], '1.2.3')

    def test_channel_summary_numeric_order_rc_suppression_and_ambiguity(self):
        module = self.module()
        tags = [self.remote_tag('1.9.0'), self.remote_tag('1.10.0'), self.remote_tag('1.10.0-rc')]
        self.assertEqual(module.version_summary(tags)['stable']['version'], '1.10.0')
        self.assertIsNone(module.version_summary(tags)['rc'])
        self.assertEqual(module.version_summary([self.remote_tag()])['rc']['version'], '1.2.3')
        with self.assertRaises(module.SourceError):
            module.version_summary([self.remote_tag('1.2.3'), self.remote_tag('01.2.3')])

    def test_remote_versions_mismatch_missing_and_error_are_distinct(self):
        self.assertEqual(self.report('versions', tags=[self.remote_tag('1.0.0')])['exit_code'], 1)
        report = self.report('versions')
        self.assertEqual(report['machines'][0]['issues'][0]['code'], 'version-tag-missing')
        module = self.module()
        args = module.inspection_arguments(['versions', '--machine', fixtures.MACHINE])
        with patch.object(module.Path, 'cwd', return_value=self.root), \
                patch.object(module, 'read_remote_tags', side_effect=module.SourceError('authentication', 'Access failed')):
            report = module.inspection_report(args)
        self.assertEqual(report['exit_code'], 2)
        self.assertEqual(report['machines'][0]['local']['value'], '1.2.3')
        self.assertFalse(report['machines'][0]['issues'])

    def test_compare_agreement_and_conflicts(self):
        self.tag()
        name = fixtures.MACHINE + '-1.2.3-rc'
        commit = self.git('rev-parse', 'HEAD')
        tag = self.remote_tag(oid=self.git('rev-parse', name), commit=commit)
        report = self.report('compare', tags=[tag], releases=[self.release()])
        self.assertEqual(report['exit_code'], 0)
        self.assertFalse(report['machines'][0]['issues'])
        tag['oid'], tag['commit'] = 'b' * 40, 'c' * 40
        report = self.report('compare', tags=[tag], releases=[self.release(prerelease=False)])
        codes = {issue['code'] for issue in report['machines'][0]['issues']}
        self.assertTrue({'tag-object-conflict', 'tag-target-conflict', 'release-channel-mismatch'} <= codes)

    def test_compare_local_remote_only_draft_and_orphan_release(self):
        self.tag()
        report = self.report('compare', tags=[self.remote_tag('1.3.0-rc')],
                             releases=[self.release('1.3.0-rc', draft=True), self.release('1.0.0')])
        codes = {issue['code'] for issue in report['machines'][0]['issues']}
        self.assertTrue({'local-only-tag', 'remote-only-tag', 'release-missing', 'release-tag-missing'} <= codes)

    def test_partial_release_inventory_never_proves_absence(self):
        state = {'state': 'incomplete', 'errors': [{'code': 'rate-limit', 'message': 'Limited'}],
                 'draft_visibility': 'unknown'}
        report = self.report('compare', tags=[self.remote_tag()], releases=[self.release()], state=state)
        self.assertEqual(report['exit_code'], 2)
        self.assertEqual(len(report['machines'][0]['releases']), 1)
        self.assertNotIn('release-missing', {issue['code'] for issue in report['machines'][0]['issues']})

    def test_explicit_repo_and_remote_mismatch_is_error(self):
        report = self.report('compare', extra=('--repo', 'different/repo'))
        self.assertEqual(report['sources']['releases']['state'], 'unavailable')
        self.assertEqual(report['sources']['releases']['errors'][0]['code'], 'repository-selection')

    def test_remote_tag_listing_does_not_choose_between_numeric_aliases(self):
        report = self.report('remote-tags', tags=[self.remote_tag('1.2.3'), self.remote_tag('01.2.3')])
        self.assertEqual(report['exit_code'], 0)
        self.assertEqual(len(report['machines'][0]['remote_tags']), 2)

    def test_unsupported_versions_context_does_not_call_remote_transport(self):
        module = self.module()
        (self.root / 'knowledge/double-project/double-project.md').unlink()
        args = module.inspection_arguments(['versions', '--machine', fixtures.MACHINE])
        with patch.object(module.Path, 'cwd', return_value=self.root), \
                patch.object(module, 'read_remote_tags') as read:
            report = module.inspection_report(args)
        read.assert_not_called()
        self.assertEqual(report['sources']['versions']['errors'][0]['code'], 'unsupported-context')

    def test_release_inventory_deadline_and_malformed_record(self):
        module = self.module()
        with patch.object(module.time, 'monotonic', side_effect=[0, 121]):
            items, state = module.read_releases('example/fork')
        self.assertFalse(items)
        self.assertEqual(state['errors'][0]['code'], 'timeout')
        with patch.object(module, 'release_page', return_value=[{'draft': False}]):
            items, state = module.read_releases('example/fork')
        self.assertEqual(state['errors'][0]['code'], 'malformed-response')

    def test_remote_advertisement_retains_object_and_peeled_commit(self):
        module = self.module()
        name = 'refs/tags/' + fixtures.MACHINE + '-1.2.3-rc'
        text = 'a' * 40 + '\t' + name + '\n' + 'b' * 40 + '\t' + name + '^{}\n'
        item = module.parse_remote_tags(text)[0]
        self.assertEqual(item['oid'], 'a' * 40)
        self.assertEqual(item['commit'], 'b' * 40)
        self.assertIsNone(module.parse_remote_tags(text.splitlines()[0])[0]['commit'])
        with self.assertRaises(module.SourceError):
            module.parse_remote_tags('not an advertisement')
        with self.assertRaises(module.SourceError):
            module.parse_remote_tags('a' * 40 + '\t' + name + '^{}\n')

    def test_remote_selection_rejects_credentials_schemes_and_ambiguity(self):
        module = self.module()
        self.assertEqual(module.normalized_remote('git@github.com:example/fork.git'), 'https://github.com/example/fork')
        self.assertEqual(module.normalized_remote('ssh://git@github.com/example/fork.git'), 'https://github.com/example/fork')
        for value in ('file:///tmp/repo', 'ext::arbitrary', 'https://user:secret@github.com/example/fork',
                      'https://github.com/example/fork?token=secret', 'ssh://other/repo'):
            with self.subTest(value=value), self.assertRaises(module.SourceError):
                module.normalized_remote(value)
        self.git('config', '--add', 'remote.origin.url', 'https://github.com/example/one')
        self.git('config', '--add', 'remote.origin.url', 'https://github.com/example/two')
        with self.assertRaises(module.SourceError):
            module.remote_address(self.root, 'origin')

    def test_transport_isolated_and_token_never_in_arguments(self):
        module = self.module()
        seen = {}

        def run(argv, **kwargs):
            seen.update({'argv': argv, **kwargs})
            self.assertTrue(Path(kwargs['cwd']).is_dir())
            return subprocess.CompletedProcess(argv, 0, stdout='', stderr='')

        with patch.object(module, 'github_token', return_value='protected-fixture-token'), \
                patch.dict(module.os.environ, {'GIT_CONFIG_PARAMETERS': 'unsafe', 'GIT_DIR': '/wrong',
                                              'GIT_TRACE_CURL': '1'}), \
                patch.object(module.subprocess, 'run', side_effect=run):
            module.read_remote_tags('https://github.com/example/fork')
        env = seen['env']
        self.assertNotIn('protected-fixture-token', ' '.join(seen['argv']))
        self.assertNotIn('GIT_DIR', env)
        self.assertNotIn('GIT_CONFIG_PARAMETERS', env)
        self.assertNotIn('GIT_TRACE_CURL', env)
        self.assertEqual(env['GIT_CONFIG_GLOBAL'], module.os.devnull)
        self.assertEqual(env['GIT_TERMINAL_PROMPT'], '0')
        self.assertNotEqual(Path(seen['cwd']), self.root)
        self.assertNotIn('shell', seen)
        self.assertIn('ls-remote', seen['argv'])

    def test_release_pagination_and_partial_failure(self):
        module = self.module()
        raw = {'id': 1, 'name': 'Release', 'tag_name': fixtures.MACHINE + '-1.2.3-rc',
               'draft': False, 'prerelease': True, 'assets': [], 'html_url': 'https://github.com/example/fork',
               'published_at': '2026-11-09T00:00:00Z'}
        page = [dict(raw, id=number + 1) for number in range(100)]
        with patch.object(module, 'release_page', side_effect=[page, []]) as read:
            items, state = module.read_releases('example/fork')
        self.assertEqual(read.call_count, 2)
        self.assertEqual(len(items), 100)
        self.assertEqual(state['state'], 'ok')
        with patch.object(module, 'release_page', side_effect=[page, module.SourceError('rate-limit', 'Limited')]):
            items, state = module.read_releases('example/fork')
        self.assertEqual(len(items), 100)
        self.assertEqual(state['state'], 'incomplete')

    def test_release_metadata_assets_and_api_errors(self):
        module = self.module()
        raw = {'id': 7, 'name': 'Named release', 'tag_name': fixtures.MACHINE + '-1.2.3',
               'draft': True, 'prerelease': False, 'published_at': None,
               'html_url': 'https://github.com/example/fork/releases/7',
               'assets': [{'name': 'package.tar.gz', 'size': 42,
                           'browser_download_url': 'https://github.com/example/fork/package.tar.gz'}]}
        self.assertEqual(module.release_record(raw)['assets'][0]['size'], 42)
        with patch.object(module, 'run_remote_read', return_value='not json'):
            with self.assertRaises(module.SourceError):
                module.release_page('example/fork', 1, 30)
        for text, code in [('HTTP 404 private secret', 'unavailable'),
                           ('HTTP 403 secret', 'authentication'), ('rate limit secret', 'rate-limit'),
                           ('Could not resolve host: secret', 'network-dns')]:
            error = module.remote_failure(text)
            self.assertEqual(error.code, code)
            self.assertNotIn('secret', str(error))

    def test_timeout_dependency_and_json_human_output(self):
        module = self.module()
        for error, code in [(FileNotFoundError(), 'dependency'),
                            (subprocess.TimeoutExpired('git', 30), 'timeout')]:
            with patch.object(module.subprocess, 'run', side_effect=error):
                with self.assertRaises(module.SourceError) as raised:
                    module.run_remote_read(['git', 'ls-remote'])
                self.assertEqual(raised.exception.code, code)
        report = self.report('versions', tags=[self.remote_tag('1.2.3')])
        with contextlib.redirect_stdout(io.StringIO()) as output:
            module.emit(report, False)
        self.assertIn('stable: ' + fixtures.MACHINE + '-1.2.3', output.getvalue())
        with contextlib.redirect_stdout(io.StringIO()) as output:
            module.emit(report, True)
        self.assertEqual(json.loads(output.getvalue())['command'], 'versions')


if __name__ == '__main__':
    unittest.main()
