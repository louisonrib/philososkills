---
name: setup
description: >
  Install or update the always-on philososkills rules in a CLAUDE.md. Use
  when the user wants philososkills to load automatically in every session,
  asks to set up, install, configure or uninstall philososkills in their
  global or project CLAUDE.md, wants to change which disciplines are always
  active, reports that the skills never trigger on their own, or asks what
  the difference is between installing the plugin and having the rules
  permanently loaded.
---

# Setup — wire philososkills into a CLAUDE.md

By default the plugin loads the full protocols into every session through its
SessionStart hook. This skill manages the **lightweight alternative**: a
compressed one-line block in a CLAUDE.md, for users who would rather spend
~200 tokens than ~3k, or who want only a subset of the disciplines. It is
idempotent: a fenced managed block (`<!-- philososkills:start -->` … `end`)
is updated in place, never duplicated.

## Procedure

1. Detect the current state first — run from this skill's directory:

       scripts/philososkills-block.sh detect <global|project>

   (`global` → `~/.claude/CLAUDE.md`, `project` → `./CLAUDE.md`). Run it for
   both scopes when the user has not made the choice yet, and tell them what
   you found. Possible statuses: `absent`, `none`, `managed-block`
   (already installed — report which disciplines), `import-detected` (a
   dedicated file is imported à la RTK — its owner wired it deliberately;
   do not touch it unless asked).
2. Ask only what detection did not settle:
   - **Scope** — global (every session) or this project?
   - **Disciplines** — all six, or a subset? Default proposal: all six.
3. Apply — same directory:

       scripts/philososkills-block.sh set <global|project> <all|name,name,...>

   Re-running with a different subset updates the block in place; withdrawing
   everything is `remove <global|project>`. On `status=refused-import`: the
   target already loads philososkills through an `@import`; tell the user, and
   let them choose between removing the import line themselves or keeping it.
4. Verify with `detect`, then show the user the resulting block.
5. Close with: takes effect from the next session; the full protocols still
   load on invocation (`/philososkills:<skill>`); the block is the compressed
   form of the README one-liners.

## Boundaries

Only lines between the two markers are managed — never edit anything else in
a CLAUDE.md, never touch `@import` lines, never create a CLAUDE.md without
the user having agreed to the scope. One scope per invocation: global setup
is the user's machine-wide choice, project setup belongs to the repository
and may be committed like any tracked file.
