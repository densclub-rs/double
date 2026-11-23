# Style contract checks

These tests validate document-driven contracts: independent machine entry,
protocol parity, real cross-document links, centralized default preferences,
mandatory mode conditions, and project-artifact navigation. They do not claim
to test an AI agent's actual interpretation or real GitHub publication. Separate release and installer tests use deterministic archives and fake transport.

```sh
uv run --with pytest==8.3.5 --with PyYAML==6.0.2 --with jsonschema==4.23.0 \
  python -m pytest -q tests/double-styles tests/machine-of-goals tests/double-release
```

The release suite's tagged-candidate check requires a separately prepared tag;
it is skipped when no release tag is selected. No release is created here.

The library release job runs `test_library_release.py` with standard-library
unittest. `test_installer_styles.py` exercises the real installer against fake
release transport and isolated state, including downgrade protection, equal
version conflicts, custom-file preservation, repair, and rollback.
