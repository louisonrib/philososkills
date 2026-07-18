# philososkills

Agents fail in patterns. They assert two-year-old training data as
today's fact, declare work "done and verified" without having run the
verification, edit a file from the memory of an hour-old read, delete
the config line that held everything up, ship a framework when you
asked for a script, and burn an evening working around a blocker they
should have escalated in one message.

philososkills is six Claude Code skills that install a discipline
against each of these failure modes. Each skill is named after the
philosophical maxim that coined the behavior — the name is a mnemonic;
the body is a concrete procedure the agent follows at the moment that
matters.

| Skill | You've seen this | What the skill makes the agent do |
|---|---|---|
| `socrates`<br>*"I know that I know nothing"* | The integration guide cites an API that changed two years ago — asserted as current.<br>The briefing note quotes a regulation from memory, and the law has moved since. | Verify time-sensitive, load-bearing claims against a live source before asserting — or label them unverified instead of dressing memory up as fact; state its own limits. |
| `popper`<br>*conjectures and refutations* | "Done — everything works!" The tests were never run.<br>The report names a cause without ever checking the rival explanation. | Attempt to refute its own work before delivering it; claim only what the checks actually performed support. |
| `heraclitus`<br>*"never the same river twice"* | The same failed fix retried a fifth time, harder.<br>A booking confirmed tonight on last month's availability export. | Re-read state that may have changed before acting on it again; in a failure loop, drop the accumulated conclusions and look at the actual state fresh. |
| `hippocrates`<br>*primum non nocere* | The "useless" config block deleted — and production down.<br>Forty lapsed members purged from the register, permanently — and there was no export. | Establish why something exists before changing or deleting it; require explicit confirmation before anything irreversible; prefer the reversible route. |
| `occam`<br>*the razor* | You asked for a forty-line script; you got a plugin architecture.<br>You asked for a weekly status routine; you got a form tool, a dashboard, and an analytics export. | Deliver the simplest version that fully meets the need; cut speculative complexity — never requested features. |
| `epictetus`<br>*the dichotomy of control* | Blocked on credentials it doesn't have, the agent invents a workaround.<br>Asked to lock in a date that is someone else's call, it just decides — to spare them the bother. | Classify the obstacle: act on what is within its control, escalate the rest cleanly, once — no unsanctioned workarounds, no deciding for the owner. |

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
