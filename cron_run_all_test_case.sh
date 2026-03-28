#!/usr/bin/env bash

# cron_run_all_test_case.sh
# Usage: call this script from cron to execute run_all_test_case.py periodically.

set -euo pipefail

# Works relative to script location so cron can execute from anywhere.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Ensure a python interpreter is available
type python3 >/dev/null 2>&1 || { echo "python3 not found" >&2; exit 1; }

# Optional: virtualenv activation
# if [ -f "$SCRIPT_DIR/.venv/bin/activate" ]; then
#   source "$SCRIPT_DIR/.venv/bin/activate"
# fi

# Run the test script
/usr/bin/env python3 run_all_test_case.py
