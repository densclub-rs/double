"""Exercise release selection without invoking GitHub."""
import importlib.util
import json
from pathlib import Path
from types import SimpleNamespace
from unittest.mock import patch

import pytest

SCRIPT = Path(__file__).resolve().parents[2] / 'scripts/double-release/clean-releases.py'
spec = importlib.util.spec_from_file_location('clean_releases', SCRIPT)
clean = importlib.util.module_from_spec(spec)
spec.loader.exec_module(clean)


def release(tag, published, draft=False):
    return {'tag_name': tag, 'published_at': published, 'draft': draft}


def test_preview_and_apply_keep_latest_and_never_delete_tags(capsys):
    pages = [[release('machine-of-ideas-0.2.6', '2026-10-29T16:00:00Z'),
              release('unrelated-1.0.0', '2026-10-30T16:00:00Z'),
              release('machine-of-goals-0.0.15-rc', '2026-10-29T17:00:00Z')],
             [release('machine-of-ideas-0.2.5', '2026-10-14T16:00:00Z'),
              release('machine-of-ideas-0.2.7', None, draft=True)]]
    calls = []

    def run(args, **kwargs):
        calls.append(args)
        return SimpleNamespace(stdout=json.dumps(pages))

    with patch.object(clean.subprocess, 'run', side_effect=run), patch('sys.argv', ['clean']):
        clean.main()
    assert len(calls) == 1
    assert 'delete machine-of-ideas-0.2.5' in capsys.readouterr().out

    calls.clear()
    with patch.object(clean.subprocess, 'run', side_effect=run), patch('sys.argv', ['clean', '--apply']):
        clean.main()
    assert calls[1:] == [['gh', 'release', 'delete', 'machine-of-ideas-0.2.5',
                          '--repo', 'densclub-rs/double', '--yes']]


def test_missing_publication_date_blocks_all_deletions():
    pages = [[release('double-agent-0.0.9', None)]]
    with patch.object(clean.subprocess, 'run', return_value=SimpleNamespace(stdout=json.dumps(pages))) as run:
        with patch('sys.argv', ['clean', '--apply']), pytest.raises(ValueError):
            clean.main()
    assert run.call_count == 1
