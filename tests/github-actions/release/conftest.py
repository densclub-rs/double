"""Isolated release fixtures; real publication and Telegram sends are forbidden."""
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / 'scripts'))


def pytest_addoption(parser):
    parser.addoption('--release-tag', default=None, help='Also validate this exact tag in the caller checkout')


def pytest_configure(config):
    # Capture the caller checkout before any test changes its working directory.
    config.release_checkout = Path.cwd()
