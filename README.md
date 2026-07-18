# philososkills

Six Claude Code skills for agent self-discipline. Each skill is named
after the philosophical maxim that coined the behavior — the name is a
mnemonic; the body is a concrete procedure the agent follows.

| Skill | Maxim | What the agent does |
|---|---|---|
| `socrates` | "I know that I know nothing" | Verifies time-sensitive, load-bearing claims against live sources before asserting them; labels what it cannot verify instead of dressing memory up as fact; states its own limits. |
| `popper` | Conjectures and refutations | Attempts to refute its own work before delivering it; claims only what the evidence held supports — "verified" requires having run the verification. |
| `heraclitus` | "Never the same river twice" | Re-reads state that may have changed before acting on it again; in a failure loop, discards accumulated conclusions and looks at the actual state fresh. |
| `hippocrates` | Primum non nocere | Establishes why something exists before changing or deleting it; requires explicit confirmation before irreversible or destructive actions; prefers reversible routes. |
| `occam` | The razor | Delivers the simplest version that fully meets the need; cuts speculative complexity — never requested features. |
| `epictetus` | The dichotomy of control | Classifies obstacles: acts on what is within its control, escalates the rest cleanly — no unsanctioned workarounds, no thrashing, no deciding for the owner. |

## Install

From this repo's self-hosted marketplace, inside Claude Code:

```
/plugin marketplace add louisonrib/philososkills
/plugin install philososkills@philososkills
```

Or with the cross-agent skills CLI:

```
npx skills add louisonrib/philososkills
```

## Use

Each skill triggers on its own when the situation calls for it — the
descriptions target the moments that matter: a claim with a clock on
it, an irreversible action, a failure loop, a blocker outside your
agent's control. You can also invoke any skill explicitly:

```
/philososkills:socrates — review this draft's factual claims before I send it
/philososkills:occam — trim this plan with me before I build it
```

## Always-on opt-in

If you want one of these disciplines applied permanently in a project,
add its one-liner to that project's `CLAUDE.md`:

- **socrates** — `Before asserting any time-sensitive fact (versions, prices, laws, availability), apply philososkills:socrates — verify against a live source or label the claim as unverified.`
- **popper** — `Before delivering any conclusion or artifact as done or correct, apply philososkills:popper — attempt to refute it and calibrate the claim to the checks actually performed.`
- **heraclitus** — `Before re-acting on previously read state, or after a repeated failure, apply philososkills:heraclitus — re-read the current state and break the loop with a fresh look.`
- **hippocrates** — `Before changing anything whose purpose is not established, or doing anything irreversible, apply philososkills:hippocrates — establish why it exists and require explicit confirmation.`
- **occam** — `For any production whose size is yours to choose, apply philososkills:occam — deliver the simplest version that fully meets the need.`
- **epictetus** — `When blocked, apply philososkills:epictetus — act on what is within your control and escalate the rest cleanly, once.`

## License

MIT
