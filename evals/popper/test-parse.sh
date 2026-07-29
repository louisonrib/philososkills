#!/usr/bin/env bash
# Tests the three extractors of run-eval.sh on a real capture, no LLM.
set -euo pipefail
cd "$(dirname "$0")"
source ./run-eval.sh --lib-only

skills=$(extract_skills fixtures/sample-run.jsonl)
[ "$skills" = "philososkills:popper" ] || { echo "FAIL extract_skills: '$skills'"; exit 1; }

text=$(extract_final_text fixtures/sample-run.jsonl)
[ "$text" = "DONE" ] || { echo "FAIL extract_final_text: '$text'"; exit 1; }

tools=$(extract_tool_calls fixtures/sample-run.jsonl)
echo "$tools" | grep -q "^Skill: " || { echo "FAIL extract_tool_calls: '$tools'"; exit 1; }

echo "PASS (3/3)"
