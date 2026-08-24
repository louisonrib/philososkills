#!/usr/bin/env bash
# Managed-block installer for the philososkills one-liners.
# Idempotent: `set` inserts or replaces the fenced block in place; an empty
# skill list removes it. Only content between the markers is ever touched.
#
# Usage:
#   philososkills-block.sh detect <global|project>
#   philososkills-block.sh set     <global|project> <all|socrates,popper,...>
#   philososkills-block.sh remove  <global|project>
set -euo pipefail

START='<!-- philososkills:start -->'
END='<!-- philososkills:end -->'

cmd="${1:-}"; scope="${2:-}"; arg="${3:-}"

target_file() {
  if [ "$scope" = "global" ]; then printf '%s\n' "$HOME/.claude/CLAUDE.md"
  else printf '%s\n' "CLAUDE.md"; fi
}

line_for() {
  case "$1" in
    socrates)
      echo '- Before asserting any time-sensitive fact (versions, prices, laws, availability), or building on'
      echo '  an inference of your own, a negative result, or a premise you were handed, apply'
      echo '  `philososkills:socrates` — verify against a live source, or hold the claim to what was actually'
      echo '  observed.' ;;
    popper)
      echo '- Before delivering any conclusion or artifact as done or correct, apply `philososkills:popper` —'
      echo '  refute the instrument before the result, and calibrate the claim to the checks actually'
      echo '  performed.' ;;
    heraclitus)
      echo '- Before re-acting on previously read state, or after a repeated failure, apply'
      echo '  `philososkills:heraclitus` — re-read the current state and break the loop with a fresh look.' ;;
    hippocrates)
      echo '- Before changing anything whose purpose is not established, or doing anything irreversible, apply'
      echo '  `philososkills:hippocrates` — establish why it exists and require explicit confirmation.' ;;
    occam)
      echo '- For any production whose size is yours to choose, apply `philososkills:occam` — deliver the'
      echo '  simplest version that fully meets the need.' ;;
    epictetus)
      echo '- When blocked, apply `philososkills:epictetus` — act on what is within your control and escalate'
      echo '  the rest cleanly, once.' ;;
    *)
      echo "unknown skill: $1 (expected one of: socrates popper heraclitus hippocrates occam epictetus)" >&2
      exit 2 ;;
  esac
}

build_block() { # $1 = comma-separated skills or "all"
  local list="$1" s
  [ "$list" = "all" ] && list="socrates,popper,heraclitus,hippocrates,occam,epictetus"
  printf '%s\n' "$START"
  IFS=',' read -r -a arr <<< "$list"
  for s in "${arr[@]}"; do line_for "$(echo "$s" | tr -d ' ')"; done
  printf '%s\n' "$END"
}

strip_block() { # stdin -> stdout without any managed block
  awk -v s="$START" -v e="$END" '
    index($0, s) { skip=1; next }
    index($0, e) { skip=0; next }
    skip==0 { print }
  '
}

extract_block() { # stdin -> only the managed block's content (markers excluded)
  awk -v s="$START" -v e="$END" '
    index($0, s) { keep=1; next }
    index($0, e) { keep=0; next }
    keep==1 { print }
  '
}

trim_end_blank_lines() { # stdin -> stdout without trailing empty lines
  awk '{ lines[NR] = $0 }
    END {
      while (NR > 0 && lines[NR] == "") NR--
      for (i = 1; i <= NR; i++) print lines[i]
    }'
}

do_detect() {
  local f; f="$(target_file)"
  if [ ! -f "$f" ]; then
    echo "status=absent file=$f"
  elif grep -qF "$START" "$f" 2>/dev/null; then
    local sk; sk=$(extract_block < "$f" \
      | grep -o 'philososkills:[a-z]*' | sed 's/philososkills://' | sort -u | paste -sd, - || true)
    echo "status=managed-block file=$f skills=${sk:-none}"
  elif grep -Eq '@[^[:space:]]*philososkills' "$f" 2>/dev/null; then
    echo "status=import-detected file=$f (dedicated file imported à la RTK — leave to the user)"
  else
    echo "status=none file=$f"
  fi
}

do_set() {
  [ -n "$arg" ] || { echo "usage: set <global|project> <all|skill,skill,...>" >&2; exit 2; }
  local f; f="$(target_file)"
  # refuse to double-load: an @import already brings the rules in every session
  if [ -f "$f" ] && ! grep -qF "$START" "$f" && grep -Eq '@[^[:space:]]*philososkills' "$f"; then
    echo "status=refused-import file=$f (rules already load via @import — remove it first or edit the imported file)" >&2
    exit 3
  fi
  local block newcontent
  block="$(build_block "$arg")"
  if [ -f "$f" ]; then
    newcontent="$(strip_block < "$f" | trim_end_blank_lines)"
    if [ -n "$newcontent" ]; then
      printf '%s\n\n%s\n' "$newcontent" "$block" > "$f.tmp" && mv "$f.tmp" "$f"
    else
      printf '%s\n' "$block" > "$f.tmp" && mv "$f.tmp" "$f"
    fi
  else
    { echo "# CLAUDE.md"; echo; echo "$block"; } > "$f"
  fi
  do_detect
}

do_remove() {
  local f; f="$(target_file)"
  [ -f "$f" ] || { echo "status=absent file=$f"; return 0; }
  grep -qF "$START" "$f" || { do_detect; return 0; }
  printf '%s\n' "$(strip_block < "$f" | trim_end_blank_lines)" > "$f"
  do_detect
}

case "$cmd" in
  detect) do_detect ;;
  set)    do_set ;;
  remove) do_remove ;;
  *) echo "usage: philososkills-block.sh <detect|set|remove> <global|project> [skills]" >&2; exit 2 ;;
esac
