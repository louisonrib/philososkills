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
matters. A seventh skill, `setup-philososkills`, loads the six into your
agent's memory file so they apply without being invoked.

| Skill | You've seen this | What the skill makes the agent do |
|---|---|---|
| `socrates`<br>*"I know that I know nothing"* | An API that changed two years ago, asserted as current; one failed request generalised into "the site is unreadable". | Verify claims with a clock on them against a live source — and hold an inference, a negative, or a handed-down premise to what was actually observed. |
| `popper`<br>*conjectures and refutations* | "Done — everything works!" — the tests were never run; "no anomalies found" — from a detector that measured something else. | Refute its own work before delivering it — the instrument before the result; claim only what was actually checked. |
| `heraclitus`<br>*"never the same river twice"* | The same failed fix retried a fifth time; a booking confirmed on last month's export. | Re-read what may have changed; in a failure loop, look at the state fresh. |
| `hippocrates`<br>*primum non nocere* | The "useless" config block deleted — production down; forty members purged, no export. | Establish why it exists before touching it; explicit confirmation before the irreversible. |
| `occam`<br>*the razor* | A forty-line script requested, a plugin architecture delivered — or a dashboard suite for a weekly status routine. | Deliver the simplest version that fully meets the need; cut speculation, never requested features. |
| `epictetus`<br>*the dichotomy of control* | A workaround invented for missing credentials; someone else's decision made "to spare them the bother". | Act on what it controls; escalate the rest cleanly, once. |

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

A skill fires on its own description, and that is the fragile link: a
protocol the agent never loads is a protocol it never applies. To have all
six in context from the first turn, run `/philososkills:setup-philososkills`.

It reads all four candidates — `CLAUDE.md` and `AGENTS.md`, global and
project — reports what each one already holds, and asks which to write to:
one, several, or one it creates for you. Its block is idempotent, so
re-running updates it and never duplicates it. When a file is in a state it
cannot edit with certainty, it says what it saw and hands that one back.

By hand, under Claude Code, it is six lines in your `CLAUDE.md`, pointing
wherever your install put the skills. `npx skills add` puts them here:

```
@~/.claude/skills/socrates/SKILL.md
@~/.claude/skills/popper/SKILL.md
@~/.claude/skills/heraclitus/SKILL.md
@~/.claude/skills/hippocrates/SKILL.md
@~/.claude/skills/occam/SKILL.md
@~/.claude/skills/epictetus/SKILL.md
```

A marketplace install puts them under
`~/.claude/plugins/marketplaces/philososkills/skills/<name>/SKILL.md`
instead. An `@` line inlines the file it names, so the whole protocol reaches
the session rather than a reminder that it exists, and either path follows
the install as it updates. Leave a line out to keep that discipline on
description-triggering alone. The six together add about 3 500 tokens to
every session — the price of not depending on a trigger.

`AGENTS.md` defines no import mechanism, so outside Claude Code the skill
copies the protocol text in instead, and you re-run it after a plugin update.

## Evals

Each of the six disciplines ships with its own eval harness in
[`evals/`](evals). Needs `jq` and the `claude` CLI.

```
cd evals/socrates && ./run-eval.sh         # RUNS=5, 50 model calls
cd evals/socrates && RUNS=1 ./run-eval.sh  # smoke
cd evals/socrates && ./test-parse.sh       # extractors only, no model calls
```

A harness replays each scenario N times, has a judge grade every run
against a written rubric
([`judge-rubric.md`](evals/socrates/judge-rubric.md)), and passes a
scenario only if at least `PASS_MIN` runs pass — one deviant output is
model variance, not necessarily a defect. Sessions are neutralised
(`--setting-sources ""`, and the plugin loaded session-only via
`--plugin-dir`) so nothing installed locally contaminates the
measurement — an always-on block included, since that flag loads no
memory file at all; host MCP servers are the known exception. Invoking the
skill never passes a run on its own — a scenario is graded on the
behavior that followed. And every skill has a **negative** scenario
that fails if the skill fires where it doesn't belong: overcorrection
is a failure mode the rubrics name and grade, one per skill
(*no verification theater*, *no gate theater*, *no razor theater*, *no
escalation theater*).

**What this measures:** behavioural conformity — the skill triggers
when it should, stays quiet when it shouldn't, and follows its own
protocol. **What it does not measure:** whether the skill improves the
outcome of real work. Recorded runs:
[`evals/RESULTS.md`](evals/RESULTS.md).

## License

MIT
