---
name: setup-philososkills
description: >
  Install, change, or remove the always-on philososkills protocols in the
  memory file an agent loads every session — CLAUDE.md, AGENTS.md, or both.
  Use when the user wants the disciplines applied in every session without
  invoking them, asks to set up or uninstall philososkills globally or in one
  project, wants to change which disciplines are always active, reports that
  the skills never trigger on their own, or asks how the always-on rules
  differ from installing the plugin.
---

# Setup — the philososkills protocols in every session

The six disciplines — socrates, popper, heraclitus, hippocrates, occam,
epictetus — load when they are invoked or when their description fires. This
skill puts them in a memory file that is read at the start of every session,
so they apply without waiting for a trigger.

**Whole protocols, not a summary.** A line that names a discipline is a
pointer, and a pointer cannot make an agent apply a procedure it has not
read. The six cost roughly 3 500 tokens in every session; the user pays that
on every turn, so tell them before you write.

What this skill installs lives between two markers, and only what sits
between them belongs to it:

    <!-- philososkills:start -->
    …one entry per chosen discipline…
    <!-- philososkills:end -->

## Where it can go

Four candidates. **The user picks; you propose.**

|  | global | project |
|---|---|---|
| **`CLAUDE.md`** — Claude Code | `~/.claude/CLAUDE.md` | `./CLAUDE.md` |
| **`AGENTS.md`** — every other harness | the harness's own (Codex: `~/.codex/AGENTS.md`) | `./AGENTS.md` |

Any combination is legitimate, several at once included: someone running two
harnesses on one repo wants both names, and someone with machine-wide
defaults who also commits the rules for their team wants both scopes. Say one
thing when they take a project target: it is committed like any tracked file,
and an import path in it resolves only on a machine where philososkills sits
at that same path.

**A file that already exists is not a decision.** A global `CLAUDE.md` sits on
nearly every machine — let one settle the target and the project scope is
never offered at all. **A file that is absent is not a reason to skip it**:
offer to create it. Every cell above stays on the table until the user takes
it off.

## What to write

**The target file decides the form, not the harness you run in** — you may be
asked to write an `AGENTS.md` for a harness that is not you.

**`CLAUDE.md` takes import lines.** Claude Code resolves `@` by inlining the
file named, so the protocol arrives whole and follows the install as it
updates:

    @~/.claude/skills/socrates/SKILL.md

**`AGENTS.md` takes the protocol text itself.** It has no import mechanism —
neither the convention nor Codex defines one — so copy the body of each
chosen `SKILL.md` between the markers, each under its own heading. That copy
is a snapshot: tell the user to re-run this skill after an update.

### Finding the six

You were told this skill's own directory when it loaded, and **the six sit
beside it** — one directory each, with a `SKILL.md` inside. That holds however
philososkills was installed:

- `npx skills add` → `~/.claude/skills/<name>/SKILL.md`, a symlink into
  `~/.agents/skills/`; imports resolve through it.
- plugin → `~/.claude/plugins/marketplaces/<marketplace>/skills/<name>/SKILL.md`.

Prefer a path with no version number in it, and read each of the six to
confirm it is there before writing its path. If your own directory sits under
a plugin **cache** (`…/cache/philososkills/philososkills/<version>/…`), write
the marketplace clone's path instead: the cache is a fresh directory at every
release, so a line pointing there loads nothing after the next update.

**A broken `@` line fails silently.** The path stays in the file as ordinary
text, nothing warns, and the protocol simply never arrives. That is why each
path is read before it is written — and why a user who moves, uninstalls, or
switches the kind of install should re-run this skill.

## Procedure

1. **Locate the six**, as above, and confirm each file exists.
2. **Read all four candidates** — global and project, `CLAUDE.md` and
   `AGENTS.md` — and every file they import with an `@` line, because an
   import's filename does not say what it carries. Look for the protocols
   themselves, never for a filename that looks like it would hold them. Each
   candidate is in one of four states:
   - absent → it can be created.
   - both markers present, in order → the block is yours; note which
     disciplines it carries.
   - the protocols already load there — imported by a line of their own,
     copied in as prose, or sitting inside a file it imports → note where. A
     block would load them twice, so ask before adopting or replacing them.
   - one marker without the other → a hand edit lost one. Report it and leave
     that file alone; repairing it is the user's call, and guessing where the
     block ended would delete their text.
3. **Report all four states, then ask two things:**
   - **Which targets** — give the concrete paths, marking those that would be
     created. One, another, or several.
   - **Which disciplines** — all six, or a subset? Default proposal: all six.
4. **Reach an existing file only through `Edit`** — one exact-match edit, so a
   surprise stops you instead of overwriting the file.
   - Block already present → one `Edit` replacing it, markers included, where
     it stands. Leave it where the user put it: they may have placed it above
     something that reads it.
   - No block → one `Edit` appending it after the file's last line.
   - Withdrawing everything → one `Edit` removing the block and its markers.
   - File absent → `Write` is the only option, and there is nothing to lose:
     a heading and the block.
5. Show each block you wrote and where, tell the user what it costs per
   session, and tell them it takes effect from the next session. The protocols
   still load on invocation whether or not a block is there.

## Boundaries

A memory file is the user's standing instructions, and a wrong write there is
not a formatting slip: when one is not in a state you can edit with certainty,
say what you saw and hand that file back — the other targets can still
proceed. A project file is committed like any tracked file, so say so before
creating one in a repository.
