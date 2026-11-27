"""Check the generated document header in every machine artifact template."""
from pathlib import Path
import re

import pytest
import yaml


TEMPLATES = Path(__file__).resolve().parents[2] / '.double/templates'
PRESERVED_PLAN = TEMPLATES / 'machine-of-goals/plan-template.md'


@pytest.mark.parametrize('template', sorted(set(TEMPLATES.glob('*/*-template.md')) - {PRESERVED_PLAN}),
                         ids=lambda path: path.stem)
def test_new_artifact_starts_as_draft(template):
    examples = re.findall(r'^(`{3,4})(md|yaml)\n(.*?)^\1$', template.read_text(), re.M | re.S)
    headers = []
    for _, language, body in examples:
        if language == 'yaml':
            headers.append(body)
        elif body.startswith('---\n'):
            headers.append(body[4:].split('\n---\n', 1)[0])

    assert headers, f'Missing generated artifact example in {template}'
    for header in headers:
        assert yaml.safe_load(header)['status'] == 'draft'
