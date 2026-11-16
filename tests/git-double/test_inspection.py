"""Isolated CLI checks with real Git objects; no network or project mutations."""
from datetime import date
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


SCRIPT = Path(__file__).resolve().parents[2] / 'scripts/git-double'
MACHINE = 'machine-of-goals'
VERSION_PATH = '.double-rules/machine-of-goals/machine-of-goals-version.md'
CHANGELOG_PATH = '.double-rules/machine-of-goals/machine-of-goals-changelog.md'


class Inspection(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.group = Path(self.temp.name).resolve()
        self.root = self.group / 'fork with spaces'
        self.root.mkdir()
        self.git('init', '-q')
        self.git('config', 'user.email', 'inspection@example.invalid')
        self.git('config', 'user.name', 'Inspection')
        self.write('.double/agents/.keep', '')
        self.write('scripts/double-release/release_common.py', '# source layout\n')
        self.write('knowledge/double-project/double-project.md', self.knowledge('double-project', 'Double source fixture'))
        self.write('.double-rules/double-rules.md',
                   '# Project\n\n## Common Rules\n\n'
                   '- [version](machine-of-goals/machine-of-goals-version.md)\n'
                   '- [changelog](machine-of-goals/machine-of-goals-changelog.md)\n')
        self.write(VERSION_PATH, self.knowledge(MACHINE + '-version', '`1.2.3`'))
        self.entry = '### 1.2.3-rc — 2026-11-09\n\n- A change.'
        self.write(CHANGELOG_PATH, self.knowledge(MACHINE + '-changelog', self.entry))
        self.git('add', '.')
        self.git('commit', '-qm', 'fixture')

    def knowledge(self, identity, value, status='stable', observed=None):
        return (f'---\nid: {identity}\nkind: knowledge-artifact\nstatus: {status}\n'
                f'observed-at: {observed or date.today().isoformat()}\nttl: one year\n'
                f'type: static\n---\n\n# Knowledge\n\n## Value\n\n{value}\n')

    def write(self, name, text):
        path = self.root / name
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text)
        return path

    def git(self, *args):
        return subprocess.run(['git', '-C', str(self.root), *args],
                              capture_output=True, text=True, check=True).stdout.strip()

    def snapshot(self):
        # Includes refs, objects, logs, index, config, exclude and worktree bytes.
        return {str(p.relative_to(self.root)): hashlib.sha256(p.read_bytes()).hexdigest()
                for p in self.root.rglob('*') if p.is_file()}

    def cli(self, command, expected=0, cwd=None, extra=()):
        before = self.snapshot()
        result = subprocess.run([sys.executable, str(SCRIPT), command,
                                 '--machine', MACHINE, '--json', *extra],
                                cwd=cwd or self.root, capture_output=True, text=True)
        self.assertEqual(result.returncode, expected, result.stdout + result.stderr)
        report = json.loads(result.stdout)
        self.assertEqual(report['exit_code'], expected)
        self.assertEqual(before, self.snapshot(), 'inspection changed repository bytes')
        return report

    def tag(self, name='machine-of-goals-1.2.3-rc', annotation=None):
        self.git('tag', '-a', '--cleanup=verbatim', '-m', annotation or self.entry, name)

    def test_missing_remote_preserves_local_version(self):
        report = self.cli('versions', expected=2)
        machine = report['machines'][0]
        self.assertEqual(machine['local']['value'], '1.2.3')
        self.assertEqual(machine['local']['path'], str(self.root / VERSION_PATH))
        self.assertEqual(machine['remote'], {'stable': None, 'rc': None})
        self.assertEqual(report['sources']['remote_tags']['state'], 'unavailable')
        self.assertEqual(report['sources']['remote_tags']['errors'][0]['code'], 'remote-selection')
        subdir = self.root / 'knowledge'
        self.assertEqual(self.cli('versions', expected=2, cwd=subdir)['machines'], report['machines'])

    def test_versions_does_not_read_head_or_cached_tags(self):
        self.tag()
        self.write(VERSION_PATH, self.knowledge(MACHINE + '-version', '`2.0.0`'))
        report = self.cli('versions', expected=2)
        self.assertEqual(report['machines'][0]['local']['value'], '2.0.0')
        self.assertIsNone(report['machines'][0]['remote']['stable'])

    def test_non_double_consumer_context_rejected(self):
        (self.root / 'knowledge/double-project/double-project.md').unlink()
        report = self.cli('versions', expected=2)
        self.assertEqual(report['sources']['versions']['state'], 'unavailable')
        self.assertIsNone(report['machines'][0]['local'])

    def parent_rule(self, value='`9.0.0`'):
        index = self.group / '.double-rules/double-rules.md'
        index.parent.mkdir(exist_ok=True)
        index.write_text('## Common Rules\n\n- [version](group-version.md)\n')
        path = index.parent / 'group-version.md'
        path.write_text(self.knowledge(MACHINE + '-version', value))
        return path

    def test_nearest_scope_conflict_and_expired_sources_fall_back(self):
        parent = self.parent_rule()
        # Valid project knowledge takes priority over group knowledge.
        self.assertEqual(self.cli('versions', expected=2)['machines'][0]['local']['value'], '1.2.3')
        self.write(VERSION_PATH, self.knowledge(MACHINE + '-version', '`1.2.3`', observed='2000-01-01'))
        local = self.cli('versions', expected=2)['machines'][0]['local']
        self.assertEqual(local['path'], str(parent))
        self.write(VERSION_PATH, self.knowledge(MACHINE + '-version', '`1.2.3`'))
        self.write('.double-rules/duplicate.md', self.knowledge(MACHINE + '-version', '`8.0.0`'))
        with (self.root / '.double-rules/double-rules.md').open('a') as stream:
            stream.write('- [duplicate](duplicate.md)\n')
        self.assertEqual(self.cli('versions', expected=2)['machines'][0]['local']['path'], str(parent))

    def test_indexed_setting_value_and_default_fallback(self):
        self.write('.double-rules/settings.md', self.knowledge('version-setting',
                   '[machine version](machine-of-goals/machine-of-goals-version.md)'))
        self.write('.double-rules/double-rules.md', '## Common Rules\n\n- [setting](settings.md)\n- [broken](missing.md)\n')
        self.assertEqual(self.cli('versions', expected=2)['machines'][0]['local']['value'], '1.2.3')
        self.write(VERSION_PATH, self.knowledge(MACHINE + '-version', '`1.2.3`', status='draft'))
        default = f'knowledge/{MACHINE}-version/{MACHINE}-version.md'
        self.write(default, self.knowledge(MACHINE + '-version', '`3.0.0`'))
        self.assertEqual(self.cli('versions', expected=2)['machines'][0]['local']['value'], '3.0.0')

    def test_conflicting_setting_ids_do_not_supply_versions(self):
        self.parent_rule()
        for name in ('first', 'second'):
            self.write(f'.double-rules/{name}.md', self.knowledge('same-setting',
                       '[version](machine-of-goals/machine-of-goals-version.md)'))
        self.write('.double-rules/double-rules.md',
                   '## Common Rules\n\n- [one](first.md)\n- [two](second.md)\n')
        self.assertEqual(self.cli('versions', expected=2)['machines'][0]['local']['value'], '9.0.0')

    def test_missing_local_knowledge_preserves_error(self):
        (self.root / VERSION_PATH).unlink()
        report = self.cli('versions', expected=2)
        self.assertIsNone(report['machines'][0]['local'])
        self.assertEqual(report['sources']['versions']['errors'][0]['code'], 'knowledge-unavailable')

    def test_invalid_numeric_duplicate_is_skipped_and_same_path_is_deduplicated(self):
        self.write('.double-rules/invalid.md', self.knowledge(MACHINE + '-version', '`invalid`'))
        with (self.root / '.double-rules/double-rules.md').open('a') as stream:
            stream.write('- [invalid](invalid.md)\n'
                         '- [same](machine-of-goals/../machine-of-goals/machine-of-goals-version.md)\n')
        self.assertEqual(self.cli('versions', expected=2)['machines'][0]['local']['value'], '1.2.3')

    def test_valid_annotated_rc_uses_tagged_tree_not_dirty_worktree(self):
        self.tag()
        self.write(VERSION_PATH, self.knowledge(MACHINE + '-version', '`7.0.0`'))
        self.write(CHANGELOG_PATH, self.knowledge(MACHINE + '-changelog', 'broken current changelog'))
        item = self.cli('tags')['machines'][0]['local_tags'][0]
        self.assertEqual(item['version'], '1.2.3')
        self.assertEqual(item['channel'], 'rc')
        self.assertEqual(item['annotation'], self.entry)
        self.assertEqual(item['commit'], self.git('rev-parse', 'HEAD'))
        self.assertNotEqual(item['oid'], item['commit'])
        self.assertEqual(item['issues'], [])

    def test_stable_lightweight_and_noncommit_tags(self):
        entry = '### 1.2.3 — 2026-11-09\n\n- Stable change.'
        self.write(CHANGELOG_PATH, self.knowledge(MACHINE + '-changelog', entry))
        self.git('add', '.')
        self.git('commit', '-qm', 'stable')
        self.tag('machine-of-goals-1.2.3', entry)
        self.assertEqual(self.cli('tags')['machines'][0]['local_tags'][0]['channel'], 'stable')
        self.git('tag', 'machine-of-goals-1.2.4-rc')
        blob = self.git('rev-parse', 'HEAD:' + VERSION_PATH)
        self.git('tag', 'machine-of-goals-1.2.5-rc', blob)
        items = self.cli('tags', expected=1)['machines'][0]['local_tags']
        self.assertIsNone(items[1]['tag_object_oid'])
        self.assertIsNone(items[2]['commit'])
        self.assertIn('not resolve', items[2]['issues'][-1]['message'])

    def test_bad_annotation_and_numeric_version_mismatch(self):
        self.tag(annotation='Wrong annotation')
        self.tag('machine-of-goals-2.0.0-rc')
        items = self.cli('tags', expected=1)['machines'][0]['local_tags']
        self.assertIn('annotation disagrees', items[0]['issues'][0]['message'])
        self.assertTrue(any('numeric version' in issue['message'] for issue in items[1]['issues']))

    def test_strict_tagged_sources_do_not_use_parent_or_worktree(self):
        self.parent_rule()
        self.write('.double-rules/double-rules.md', '## Common Rules\n\n- [version](missing.md)\n')
        self.git('add', '.')
        self.git('commit', '-qm', 'broken tagged source')
        self.tag()
        self.write('.double-rules/missing.md', self.knowledge(MACHINE + '-version', '`1.2.3`'))
        item = self.cli('tags', expected=1)['machines'][0]['local_tags'][0]
        self.assertTrue(any('Broken project knowledge link' in issue['message'] for issue in item['issues']))

    def test_tagged_external_knowledge_link_is_rejected(self):
        self.parent_rule()
        self.write('.double-rules/double-rules.md',
                   '## Common Rules\n\n- [version](../../.double-rules/group-version.md)\n')
        self.git('add', '.')
        self.git('commit', '-qm', 'external knowledge')
        self.tag()
        item = self.cli('tags', expected=1)['machines'][0]['local_tags'][0]
        self.assertTrue(any('inside the tagged tree' in issue['message'] for issue in item['issues']))

    def test_tagged_symlink_knowledge_is_rejected(self):
        source = self.root / VERSION_PATH
        text = source.read_text()
        source.unlink()
        self.write('.double-rules/real-version.md', text)
        source.symlink_to('../real-version.md')
        self.git('add', '.')
        self.git('commit', '-qm', 'symlink knowledge')
        self.tag()
        item = self.cli('tags', expected=1)['machines'][0]['local_tags'][0]
        self.assertTrue(any('not a regular file' in issue['message'] for issue in item['issues']))

    def test_signed_annotation_uses_release_text_normalization(self):
        # Matching the release-note signature exclusion is not signature verification.
        self.tag(annotation=self.entry + '\n-----BEGIN SSH SIGNATURE-----\nfixture\n')
        item = self.cli('tags')['machines'][0]['local_tags'][0]
        self.assertEqual(item['annotation'], self.entry)

    def test_human_output_contains_annotation_and_provenance(self):
        self.tag()
        before = self.snapshot()
        result = subprocess.run([sys.executable, str(SCRIPT), 'tags', '--machine', MACHINE],
                                cwd=self.root, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn(self.entry.splitlines()[0], result.stdout)
        self.assertIn(VERSION_PATH, result.stdout)
        self.assertEqual(before, self.snapshot())

    def test_duplicate_and_channel_mismatched_changelog_entries(self):
        for suffix, content in [('duplicate', self.entry + '\n\n' + self.entry),
                                ('wrongchannel', self.entry.replace('1.2.3-rc', '1.2.3'))]:
            with self.subTest(suffix=suffix):
                self.write(CHANGELOG_PATH, self.knowledge(MACHINE + '-changelog', content))
                self.git('add', '.')
                self.git('commit', '-qm', suffix)
                # Each repository is reused but each tag result is checked by name.
                tag = 'machine-of-goals-1.2.3' + ('-rc' if suffix == 'duplicate' else '-dev')
                self.tag(tag)
                item = next(x for x in self.cli('tags', expected=1)['machines'][0]['local_tags'] if x['name'] == tag)
                self.assertTrue(any('exactly one' in issue['message'] for issue in item['issues']))

    def test_unknown_tag_names_are_counted(self):
        self.git('tag', 'unrelated')
        report = self.cli('tags')
        self.assertEqual(report['sources']['local_tags']['unrecognized_tags'], 1)
        self.assertEqual(report['machines'][0]['local_tags'], [])

    def test_operational_error_is_json_and_unknown_machine_is_usage_error(self):
        result = subprocess.run([sys.executable, str(SCRIPT), 'tags', '--json'],
                                cwd=self.group, text=True, capture_output=True)
        self.assertEqual(result.returncode, 2)
        self.assertEqual(json.loads(result.stdout)['sources']['local_tags']['state'], 'unavailable')
        result = subprocess.run([sys.executable, str(SCRIPT), 'tags', '--machine', 'unknown'],
                                cwd=self.root, text=True, capture_output=True)
        self.assertEqual(result.returncode, 2)


if __name__ == '__main__':
    unittest.main()
