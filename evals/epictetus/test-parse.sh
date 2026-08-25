#!/usr/bin/env bash
# Tests the three extractors of run-eval.sh on a real capture, no LLM.
set -euo pipefail
cd "$(dirname "$0")"
source ./run-eval.sh --lib-only

TMP_REFUSED="$(mktemp)"; trap 'rm -f "$TMP_REFUSED"' EXIT

skills=$(extract_skills fixtures/sample-run.jsonl)
[ "$skills" = "philososkills:epictetus" ] || { echo "FAIL extract_skills: '$skills'"; exit 1; }

text=$(extract_final_text fixtures/sample-run.jsonl)
[ "$text" = "DONE" ] || { echo "FAIL extract_final_text: '$text'"; exit 1; }

# A run the CLI refused must extract as nothing, so run_one writes an "error"
# verdict. Without this the refusal text goes to the judge as the assistant's
# answer, and every negative scenario (no verification seen) scores pass — a
# rate-limited batch then reports green. Happened 2026-08-24.
refused='{"type":"result","subtype":"success","is_error":true,"result":"You'"'"'ve hit your session limit · resets 5pm (Europe/Paris)"}'
dead=$(echo "$refused" > "$TMP_REFUSED"; extract_final_text "$TMP_REFUSED")
[ -z "$dead" ] || { echo "FAIL extract_final_text on a refused run: '$dead'"; exit 1; }

tools=$(extract_tool_calls fixtures/sample-run.jsonl)
echo "$tools" | grep -q "^Skill: " || { echo "FAIL extract_tool_calls: '$tools'"; exit 1; }

echo "PASS (4/4)"
