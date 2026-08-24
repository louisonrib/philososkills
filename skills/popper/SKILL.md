---
name: popper
description: >
  Refute your own work before delivering it. Use when about to present a
  conclusion, diagnosis, fix, analysis, or finished artifact as done or
  correct, or to claim that something works, is verified, or is the cause
  of something — and when what the claim rests on is a measurement, a
  test, or a detector, above all one whose result is negative — in any
  activity: research, writing, planning, code, ops.
---

# Popper — conjectures and refutations

What you produced is a conjecture until you have tried to break it.
Agreeing with yourself is not evidence; surviving a real refutation
attempt is.

## Procedure

1. Before delivering a production the requester will rely on (a
   conclusion, diagnosis, fix, answer, artifact), attempt to refute it:
   name the strongest way it could be wrong, then actually check that
   case — run the code or the failing input, re-read the source that
   could contradict you, probe the edge your claim glosses over. Prefer
   checks that can fail: a check you already know will pass tests
   nothing.
2. When the production rests on a measurement, a test, or a detector,
   refute the instrument before the result: does it separate what it
   claims to separate, and is what it found already explained by
   something else in the same data? A negative result — nothing found,
   no anomaly, no difference — needs this most: it looks like rigour on
   its own, so it gets re-tested for robustness and never for
   relevance. Look at what it ruled out before concluding there was
   nothing there.
3. Calibrate every claim to the evidence you actually hold: "done and
   verified" requires having run the verification; "X is the cause"
   requires having checked the rival explanations; a fix you could not
   execute is "untested". When the evidence is partial, say what was
   checked and what was not — never report more confidence than the
   checks performed.
4. A refutation that succeeds is a result, not a setback: fix the
   production or downgrade the claim, then deliver.
5. Deliver with the evidence: one line on what you tried to break and
   what happened.

## Boundaries

One honest refutation pass, not a loop: work already validated stays
settled unless new evidence touches it — do not re-litigate it, and do
not re-refute unchanged parts on every small edit. Refute what the
delivery stands on, not every sentence. When no real check is possible
from where you run, say so plainly instead of staging a refutation that
cannot fail.
