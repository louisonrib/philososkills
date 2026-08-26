---
name: setup-philososkills
description: >
  Install, change, or remove the always-on philososkills protocols in the
  memory file this harness loads every session — CLAUDE.md, or AGENTS.md
  outside Claude Code. Use when the user wants the disciplines applied in
  every session without invoking them, asks to set up or uninstall
  philososkills globally or in one project, wants to change which
  disciplines are always active, reports that the skills never trigger on
  their own, or asks how the always-on rules differ from installing the
  plugin.
---

# Setup — the philososkills protocols in every session

The six disciplines — socrates, popper, heraclitus, hippocrates, occam,
epictetus — load when they are invoked or when their description fires. This
skill puts them in the memory file the harness reads at the start of every
session, so they apply without waiting for a trigger.

**Whole protocols, not a summary.** A line that names a discipline is a
pointer, and a pointer cannot make an agent apply a procedure it has not
read. The six cost roughly 3 500 tokens in every session; the user pays that
on every turn, so tell them before you write.

What this skill installs lives between two markers, and only what sits
between them belongs to it:

    <!-- philososkills:start -->
    …one entry per chosen discipline…
    <!-- philososkills:end -->

## Which file

You know which harness you are running in, and that settles the name:
**Claude Code reads `CLAUDE.md`; every other harness reads `AGENTS.md`.**

Scope is the user's choice:

- **global** — `~/.claude/CLAUDE.md` under Claude Code, the harness's own
  global file otherwise (Codex: `~/.codex/AGENTS.md`). Applies everywhere.
- **project** — `./CLAUDE.md` or `./AGENTS.md`, committed with the repo, so
  it reaches everyone who clones it.

When the user has not chosen, the files already there decide, in this order:
a global one that exists takes it, then a project one, and if neither exists
propose creating the global — the disciplines govern how the agent works, not
what the codebase is.

## What to write

**Under Claude Code, six import lines.** An `@` line inlines the file it
names, so the protocol arrives whole and follows the installed plugin as it
updates:

    @~/.claude/plugins/marketplaces/philososkills/skills/socrates/SKILL.md

Locate the six `SKILL.md` on this machine before writing any path — an
install through `npx skills` puts them elsewhere — and choose a path with no
version number in it. The marketplace clone above updates in place; the
plugin cache (`…/cache/philososkills/philososkills/<version>/…`) is a fresh
directory at every release, so a line pointing there loads nothing after the
next update.

**Everywhere else, the protocol text itself.** `AGENTS.md` has no import
mechanism — neither the convention nor Codex defines one — so copy the body
of each chosen `SKILL.md` between the markers, each under its own heading.
That copy is a snapshot: tell the user to re-run this skill after a plugin
update.

## Procedure

1. **Read the target file before writing anything** — and every file it
   imports with an `@` line, because an import's filename does not say what
   it carries. Look for the protocols themselves, never for a filename that
   looks like it would hold them. Say what you found, and read both scopes
   when the user has not chosen yet.
   - Nothing there → you will create it.
   - Both markers present, in order → the block is yours; report which
     disciplines it carries.
   - The protocols already load — imported by a line of their own, copied in
     as prose, or sitting inside a file the target imports → name where they
     are and stop. A block would load them a second time. Ask whether to
     adopt what is there into a block, or to leave the file alone.
   - One marker without the other → a hand edit lost one. Report it and stop;
     repairing it is the user's call, and guessing where the block ended
     would delete their text.
2. Ask only what reading did not settle:
   - **Scope** — global, or this project?
   - **Disciplines** — all six, or a subset? Default proposal: all six.
3. **Reach an existing file only through `Edit`** — one exact-match edit, so a
   surprise stops you instead of overwriting the file.
   - Block already present → one `Edit` replacing it, markers included, where
     it stands. Leave it where the user put it: they may have placed it above
     something that reads it.
   - No block → one `Edit` appending it after the file's last line.
   - Withdrawing everything → one `Edit` removing the block and its markers.
   - No file at all → `Write` is the only option, and there is nothing to
     lose: a heading and the block.
4. Show the user the block you wrote, tell them what it costs per session,
   and tell them it takes effect from the next session. The protocols still
   load on invocation whether or not the block is there.

## Boundaries

One scope per invocation: global is the user's machine-wide choice, project
belongs to the repository and may be committed like any tracked file — settle
which before creating a file that does not exist. When the file is not in a
state you can edit with certainty, say what you saw and hand it back: a
memory file is the user's standing instructions, and a wrong write there is
not a formatting slip.
