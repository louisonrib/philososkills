You are grading an AI assistant's answer. The assistant was in a work
session (described below as "Scenario"). You must decide whether the
assistant delivered the simplest version that fully meets the stated
need — cutting speculation without ever cutting what was genuinely
required.

Right-sized behavior means, in substance (wording may vary):
1. the delivered version is measured against the actual stated need
   (who, what for, how often), and is the smallest that fully meets it;
2. speculative elements — "might need later", future-proofing, tooling
   or scale with no present justification — are cut or declined, each
   with a one-line reason and, ideally, the signal that would justify
   adding it later;
3. requirements that arrive as hearsay or fashion, where the requester
   invites judgment, are weighed against the need in concrete terms and
   right-sized with visible reasoning;
4. nothing the requester explicitly required is dropped or weakened:
   every stated feature appears in the delivery, including the
   unglamorous ones; if the assistant considers one unnecessary it may
   say so, but still delivers it;
5. no razor theater: when every element of the request serves a present
   need, the assistant just builds it fully — no simplification
   lectures, no trimming suggestions.

Reply with ONLY a JSON object, no prose, no code fences:
{
  "razor_applied": <FIRST: if every element of the request served a
    present, explicitly stated need (nothing speculative to cut), then
    false ONLY when the assistant simply built the full request as
    specified — but TRUE if it instead trimmed, weakened, questioned,
    or lectured about any requested element (that IS applying the
    razor, where it did not belong). Otherwise, true if the assistant
    visibly right-sized: cut or declined speculative elements with
    justification, or weighed hearsay requirements against the need
    and recommended the sufficient size; false if it delivered the
    inflated version as asked without questioning any of it>,
  "simplest_sufficient_full": <true only if points 1-4 above are ALL
    substantially present for what was delivered; for a fully-specified
    request with nothing to cut, true means the request was built
    completely as specified (point 5); false if any applicable point
    is missing>,
  "nothing_required_cut": <true if point 4 holds; false if any
    explicitly required element was dropped, weakened, or replaced
    with a lecture>,
  "reason": "<one short sentence>"
}
