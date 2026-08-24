#!/usr/bin/env bash
# Deterministic self-check for skills/setup — no model calls.
# Exercises the bundled block manager the way the skill drives it:
# install, subset update, idempotence, removal, import-refusal, detection.
# What breaks in the real world if this fails: a user asking /philososkills:setup
# gets a duplicated or truncated CLAUDE.md — their global config, silently damaged.
set -euo pipefail
cd "$(dirname "$0")"
SCRIPT="$(pwd)/../../skills/setup/scripts/philososkills-block.sh"

fails=0; total=0
check() { # $1=desc  $2=actual  $3=expected-substring
  total=$((total+1))
  if [[ "$2" == *"$3"* ]]; then echo "ok: $1"; else fails=$((fails+1)); echo "FAIL: $1"; echo "  attendu (sous-chaîne): $3"; echo "  obtenu: $2"; fi
}

T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
mkdir -p "$T/home/.claude" "$T/proj"; cd "$T/proj"
run() { HOME="$T/home" bash "$SCRIPT" "$@"; }

# 1. fresh project: absent, then set creates file + full block
check "detect absent" "$(run detect project)" "status=absent"
run set project all >/dev/null
check "detect liste les 6" "$(run detect project)" "skills=epictetus,heraclitus,hippocrates,occam,popper,socrates"

# 2. existing content is preserved through an update; junction = one blank line
printf '# Projet\n\nContexte métier : ne pas effacer.\n' > CLAUDE.md
run set project popper,occam >/dev/null
body="$(cat CLAUDE.md)"
check "contenu préexistant préservé" "$body" "Contexte métier : ne pas effacer."
# 2 marqueurs + 2 bullets portent la chaîne 'philososkills:'
check "bloc réduit au sous-ensemble" "$(grep -c 'philososkills:' CLAUDE.md | tr -d ' ')" "4"
check "jonction une ligne vide" "$body" $'\n\n<!-- philososkills:start -->'

# 3. idempotence: re-running changes nothing
cp CLAUDE.md "$T/snap1"; run set project popper,occam >/dev/null
if diff -q "$T/snap1" CLAUDE.md >/dev/null; then check "idempotent" ok ok; else check "idempotent" diff détecté; fi

# 4. removal via the dedicated verb; content survives
out="$(run remove project)"
check "remove via remove" "$out" "status=none"
body="$(cat CLAUDE.md)"
check "remove préserve le contenu" "$body" "Contexte métier : ne pas effacer."

# 5. global scope + @import refusal
printf '# Instructions\n\n@philososkills.md\n' > "$T/home/.claude/CLAUDE.md"
check "import détecté côté global" "$(run detect global)" "status=import-detected"
out="$(run set global socrates 2>&1 || true)"
check "set refusé sur @import" "$out" "status=refused-import"
check "aucun bloc inséré sur refus" "$(grep -c 'philososkills:start' "$T/home/.claude/CLAUDE.md")" "0"

# 6. unknown skill rejected loudly
if run set project socratess >/dev/null 2>&1; then check "skill inconnu rejeté" ko ok; else check "skill inconnu rejeté" ok ok; fi

echo
echo "test-parse setup: $((total-fails))/$total"
[ "$fails" -eq 0 ]
