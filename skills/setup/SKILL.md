---
name: setup
description: >
  Install, change, or remove the always-on philososkills rules in a
  CLAUDE.md. Use when the user wants the disciplines applied in every session
  without invoking them, asks to set up or uninstall philososkills in a
  global or project CLAUDE.md, wants to change which disciplines are always
  active, reports that the skills never trigger on their own, or asks how the
  always-on rules differ from installing the plugin.
---

# Setup — wire philososkills into a CLAUDE.md

The six disciplines live as full protocols in this plugin and load when
invoked. This skill writes their compressed one-line versions into a
CLAUDE.md so they apply permanently, without waiting for a trigger.

Scopes: **global** is `~/.claude/CLAUDE.md`, **project** is `./CLAUDE.md`.
The rules live between two markers, and only what sits between them belongs
to this skill:

    <!-- philososkills:start -->
    …one bullet per chosen discipline, copied verbatim from below…
    <!-- philososkills:end -->

## Procedure

1. **Read the target file before writing anything** and say what you found.
   Read both scopes when the user has not chosen yet.
   - No file → you will create it.
   - Both markers present, in order → the block is yours; report which
     disciplines it currently carries.
   - The rules are already there as ordinary prose, with no markers → say so
     and stop. Adding a block would leave the same six rules in the file
     twice, in two wordings. Ask whether to adopt the existing lines into a
     block (replacing them) or to leave the file alone.
   - A line imports a philososkills file (`@…philososkills…`) → its owner
     wired that deliberately. Report it and stop unless asked.
   - One marker without the other → a hand edit lost one. Report it and stop;
     repairing it is the user's call, and guessing where the block ended
     would delete their text.
2. Ask only what reading did not settle:
   - **Scope** — global (every session) or this project?
   - **Disciplines** — all six, or a subset? Default proposal: all six.
3. **Reach an existing file only through `Edit`** — one exact-match edit, so a
   surprise stops you instead of overwriting the file.
   - Block already present → one `Edit` replacing the old block, markers
     included, where it stands. Do not move it: the user may have placed it
     above something that reads it.
   - No block → one `Edit` appending it after the file's last line.
   - Withdrawing everything → one `Edit` removing the block and its markers.
   - No file at all → `Write` is the only option, and there is nothing to
     lose: a `# CLAUDE.md` heading and the block.
4. Show the user the block you wrote, and tell them it takes effect from the
   next session. The full protocols still load on invocation
   (`/philososkills:<skill>`) whether or not the block is there.

## The lines

Copy these verbatim — one bullet per chosen discipline, nothing reworded.

- Before asserting any time-sensitive fact (versions, prices, laws, availability), or building on an inference of your own, a negative result, or a premise you were handed, apply `philososkills:socrates` — verify against a live source, or hold the claim to what was actually observed.
- Before delivering any conclusion or artifact as done or correct, apply `philososkills:popper` — refute the instrument before the result, and calibrate the claim to the checks actually performed.
- Before re-acting on previously read state, or after a repeated failure, apply `philososkills:heraclitus` — re-read the current state and break the loop with a fresh look.
- Before changing anything whose purpose is not established, or doing anything irreversible, apply `philososkills:hippocrates` — establish why it exists and require explicit confirmation.
- For any production whose size is yours to choose, apply `philososkills:occam` — deliver the simplest version that fully meets the need.
- When blocked, apply `philososkills:epictetus` — act on what is within your control and escalate the rest cleanly, once.

## Boundaries

One scope per invocation: global is the user's machine-wide choice, project
belongs to the repository and may be committed like any tracked file — settle
which before creating a file that does not exist. When the file is not in a
state you can edit with certainty, say what you saw and hand it back: a
CLAUDE.md is the user's standing instructions, and a wrong write there is not
a formatting slip.
