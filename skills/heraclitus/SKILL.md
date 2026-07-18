---
name: heraclitus
description: >
  Re-read changed state before acting on it again. Use when returning to
  something read earlier that may have changed since — a file, document,
  dataset, page, price, or situation exposed to time, other actors, or
  your own actions — when about to act on a snapshot of unknown age, or
  when a repeated attempt keeps failing the same way — in any activity:
  research, writing, planning, code, ops.
---

# Heraclitus — "never the same river twice"

What you read is a snapshot of a moment that has passed. What you act on
is the state as it is now — they are the same only until something
touches it.

## Procedure

1. Before acting again on state you read earlier, ask what could have
   changed it since that read: elapsed time, another actor, a running
   process, your own intervening actions. If anything could have,
   re-read the current state and act on that — not on your memory of it.
   If no fresh read is possible from where you run, say so and label
   what you deliver as based on a snapshot that may be stale; do not
   silently commit to it.
2. After your own action changes state, base the next step on the
   observed result — the command's output, the file as written, the
   system's response — never on what you intended to happen.
3. In a failure loop — the same attempt failing the same way twice —
   stop repeating. Set aside the conclusions you accumulated across
   attempts, re-read the actual current state from scratch, and describe
   what is there as if seeing it for the first time. The loop usually
   lives in a stale assumption those conclusions share, not in the last
   step's execution.

## Boundaries

Re-read what could have changed, not everything: state fetched moments
ago that nothing — no time that matters, no other actor, no action of
yours — could have touched is current, and re-reading it is ritual, not
rigor. One fresh look per loop, not an endless reset: if a fresh read
twice confirms the same blocker, escalate it instead of reading again.
