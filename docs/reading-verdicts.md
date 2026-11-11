# Reading a verdict

> A verdict is the AI judge's forecast of how likely each answer is. Learn what it means, why "unclear" is not a failure, and how to check it in the replay.

> **Key facts**
>
> - A verdict is a likelihood, not a case. A 90 % answer should be wrong about one time in ten.
> - "Unclear" means the events did not settle the question. It is not "no" and it is not an error.
> - The judge reads your events and a few facts, never the recording. Missing events give weak verdicts. Wrong events give confident wrong ones. If Sequential did not measure the error counts, it never sends a zero in their place.
> - Ask leaves out sessions judged less than 40 % likely to match. Evidence and the judge's reading of a session hide yes-or-no answers below 40 %. A short or empty result does not mean that nothing happened.
> - The replay shows what really happened. Check a verdict there, then answer Right or Wrong on each reading.

## Check a verdict

1. Click **Evidence** in the left rail, or press G, then S.

2. Click the card of the session.

   Result: The session opens in the peek, at its moment.

3. Click **Open full**, or press O, to open the full page of the session.

   Result: The judge's reading is beside the recording.

4. Press play.

   Result: Under the recording, "The judge's moments" lists the moments that the judge found.

5. Click a moment to go to it.

   **If the moment is wrong**

   Go back a few seconds. Or click the event in "What they did" under the recording.

   The judge's moments count from the session's first event, not the start of the recording. The replay can start early or late for this reason. A moment after the end of the recording reads "after the recording ended". It is not a button.

6. Compare what you saw with the judge's reading.

   Result: In the judge's reading, a word beside each reading says how sure the judge was, from "unsure" to "almost certain". Hover over it to see the percent.

7. Click **Right** or **Wrong** on each reading.

Result: Your answer counts towards Calibration: how often people agree with the judge, question by question. It never re-judges the session.

### When the recording cannot play, and other ways to answer

When the recording cannot play:

- If you cannot play the recording now, the player says why. Examples are "This session was not recorded." and "The recording is still being put together."
- In that case, a click on a moment marks its event in "What they did". Check the events instead of the replay.

When the replay makes the answer obvious but the reading was unclear or wrong:

- Look at what the events said. Look for a click with no text, a milestone with no event, or errors that nobody measured ([Verdicts depend on your events](#verdicts-depend-on-your-events)).

When the questions changed since the judge read the session:

- The line under the reading says "The questions changed since; this reading is from the earlier version."

When you answer:

- Select a reading, then press E for Right or X for Wrong. The page then says, for example, "Saved: “Abandoned” was wrong."
- In the session in the peek, Came to and Outcome also have Right and Wrong, as two small buttons. There the note says "Saved" or "Not saved".

## Judge a recording now

The judge's reading, on the full page of a session, has the button Judge this recording now. When the page already shows a reading, the button says Judge again. It asks the judge for a reading now, with your current questions. From 11 November 2026, a viewer gets **Show a judgement already made** instead. It shows a judgement that the judge already made for these events, and starts no new one. Under it, the page says: "Judging a recording needs a member role or higher; a viewer can read judgements already made." A viewer never gets Judge again. For staff who view as a customer, the button is off, with "Viewing as a customer is read-only: judging spends the customer’s allowance, so it is not offered here."

The new reading replaces the stored reading on this page until you leave the page. Evidence, the lists and the stored judgment keep the stored reading.

### How to judge a recording now

1. Open the full page of the session.

   Result: The button shows only when the recording can play.

2. Wait until "What they did" has loaded.

   Result: Until then, the line under the button says "Ready once “What they did” has loaded."

3. Click **Judge this recording now**, or **Judge again**.

   Result: While the judge reads, the button says Judging…. This can take up to 45 seconds.

4. Read the new reading.

   Result: The line under it says, for example, "Judged just now from all 42 events. Lists and the automatic reading keep theirs; this one is for this page."

Result: You can check the new reading with Right or Wrong, as any other reading.

### What Judge this recording now uses and sends

| Topic | What happens |
|---|---|
| Who can use it | Owners, admins and members. It needs access to the recordings of the project. From 11 November 2026, a viewer gets Show a judgement already made: it shows a judgement already made, and never starts a new one. |
| Allowance | It uses the project's daily allowance for judging on demand. Background judging, Ask and Try on a session each have their own allowance. The line under the button says "Uses this project’s allowance for judging on demand today. An answer already made for these events is free." |
| Saved answers | Sequential keeps the judge's answer for the same events and questions for up to 7 days. The first click can return that answer, free. The line under the reading then says that it is "the judge’s earlier answer for this recording (nothing was spent)". |
| Judge again | Judge again asks for a fresh answer only after a reading made on this page. After a fresh answer from Judge again, the session gets the next fresh answer 10 minutes later at the earliest. Before then, the line says "This is the reading made at …: a session can be judged again 10 minutes after its last fresh reading." |
| What it sends | Your browser builds a digest from the session's events that "What they did" loads, whatever its search or chips show: the event lines and a few session facts. It sends no custom-event properties, no error counts and no user id. The server scans the text again before the judge reads it. See [AI and third parties](/docs/ai-and-third-parties). |
| Moments | The moments of the new reading count on the player's timeline. Each moment that can play is a button. |
| Events needed | The judge needs at least 3 events that it reads. With fewer, the page says "Judging on demand needs 3 events the judge reads; this session has fewer." |

### Messages from Judge this recording now

| Message | Where | What it means | What to do |
|---|---|---|---|
| "On-demand judging has used today’s allowance for this project. It starts again …" | — | The allowance for judging on demand is used for today. It resets at midnight UTC. Background judging is not affected. | — |
| "Sequential cannot check today’s judging allowance right now, so it judged nothing and charged nothing. Try again shortly." | — | Sequential cannot read the allowance. Nothing was spent. | Click Try again. |
| "Judging on demand is switched off on this server." | — | Judging is not set up on your Sequential server. | — |
| "The judge could not read this session this time. Nothing was charged for a failed reading. Try again." | — | The judge failed. | Click Try again. |
| "This session has no recording on the server, so there is nothing to judge." | — | Sequential has no recording of this session. | — |
| "Too many requests for this project right now. Try again …" | — | The project sent too many requests. | The message says when to click Try again. |
| "The judge did not answer within 45 seconds; it may still finish. Try again." | — | The page stopped waiting. | Click Try again. |
| "Your role cannot watch recordings in this project, so it cannot judge them." | — | Your role has no access to the recordings of this project. | — |
| "Judging on demand sends what “What they did” shows, which did not load. Try it again there." | — | "What they did" did not load, so there is nothing to send. | — |

## Verdicts depend on your events

The judge reads a short text version of the session's events and a few facts. It never watches the recording. If your events do not say something, the judge cannot know it.

Wrong events are worse than missing events. The judge cannot tell a mislabelled event from a true one.

What weak events look like to the judge:

- A click with no text or id reads as "element". A page view with no path or screen name reads as "(unnamed screen)" ([Events and event classes](/docs/events)).
- Without a custom event such as `invite_sent`, the judge can only infer whether someone finished ([Send custom events](/docs/custom-events)).
- If an event is mislabelled, the judge answers from wrong information, and it is just as sure.

### How a long session is trimmed

Sequential does not judge a session with fewer than 3 meaningful events. It trims a longer session to at most 255 events, by kind:

1. The trim drops mobile gestures and plain clicks first.
2. Then it drops custom events.
3. Then it drops identify events.

Errors, rage clicks, dead clicks, form submits and page views survive longest. The judge also gets u-turns (where someone went back). The trim keeps them longer than form submits.

To see if a verdict was trimmed, read the line under the judge's reading of the session. It says "Read", then when, then "from" the count of events that the judge read, of all the events, for example "from 255 of 312 events". When nothing was trimmed, it says "from all" and the count.

The full trim order is in [How the judge works](/docs/judgments).

### Missing error counts stay missing

The session's error counts are JavaScript errors, failed requests and console errors, from the recording's DevTools capture ([DevTools in session replays](/docs/devtools)). If Sequential did not measure them, it never sends a zero in their place.

### When a count is missing

| What Sequential knows | What the judge reads |
|---|---|
| It counted all of it | The exact count, zero included |
| It found some, but could not count all of it | "at least N" |
| Anything else | Nothing |

"Anything else" includes these cases:

- The capture was off.
- Your SDK does not report it.
- There is no recording.
- The session is from before the counts existed.
- An incomplete count found none.

### Make customised questions name the error counts

The default cause questions name their evidence: the session's error counts. The default questions that use these counts are Outcome, Friction, Hit an error and Product bug. These questions tell the judge that a missing count means "not measured", not "nothing went wrong".

If a cause question does not name its evidence, the judge reasons from behaviour. That answer can sound certain. Customised questions keep their saved wording. It does not get later changes to the defaults.

1. Open each cause question on the **Questions** page. Make sure that it names the error counts in the same words as the defaults:

   "the session's error counts (`js_errors`, `failed_requests`, `console_errors`; absent when not measured)"

2. If a question does not name them, add that text.

FAQ: [Why can a struggling session still rank high?](#why-can-a-struggling-session-still-rank-high)

### Reset to the defaults

An owner or admin can reset the questions to the defaults instead of the 2 steps in Make customised questions name the error counts ([Questions: what the judge asks](/docs/rubric)).

To do it, click "Restore defaults" on the Questions page, then "Yes, go back to the defaults". This replaces your questions with the defaults. The button shows only while the project has its own questions.

## A verdict is a likelihood

A verdict is the judge's answer to one of your project's [questions](/docs/rubric). The judge says how likely each answer is. Sequential does not decide what happened in a session.

- For a choice question such as Intent, the verdict is its most likely option, with that likelihood.
- For a yes-or-no question such as Hit an error, the verdict is the likelihood of yes.

The session that you look at can be the one time in ten that a 90 % answer is wrong.

To see how often people agree with the judge on each question, open Calibration on the Questions page ([Check the judge and read Calibration](/docs/feedback-and-calibration)).

## Answers below 40 % are not shown

| Where | What is left out | How a leaning answer shows |
|---|---|---|
| Ask | Sessions that the judge rated less than 40 % likely to match | — |
| Evidence cards | Yes-or-no answers judged less than 40 % likely | From 60 %, an Evidence card shows it as "Maybe:" and the answer |
| The judge's reading of a session | Yes-or-no answers judged less than 40 % likely | From 9 November 2026, a signal with a likelihood between 40 % and 70 % is a reading of its own, with Right and Wrong |

A missing answer means that the judge rated it unlikely, not that it skipped it. There are two exceptions, both on Evidence cards ([When does a missing answer not mean unlikely?](#when-does-a-missing-answer-not-mean-unlikely)).

## Unclear means the judge could not tell

Unclear means that the session's events did not settle the question. The evidence was not there, or it pointed both ways.

Unclear is an answer. It is not an error and it is not no. Unclear is a reason to look, not to skip. On Evidence, Sequential does not drop these sessions.

When the judge could not tell what the person came to do, or how the session ended, and no signal fired, the session goes in the lane "The judge was unsure" ([Evidence: the sessions worth a look](/docs/watch)).

FAQ: [Why is unclear not no?](#why-is-unclear-not-no)

## Limits

- Sequential does not judge a session with fewer than 3 meaningful events.
- Sequential trims a long session to at most 255 events before the judge reads it. The trim can remove a milestone such as `invite_sent`.
- Without DevTools capture, questions about errors rest on the error events that your SDK sends.
- Calibration has evidence only for the questions that people check with Right or Wrong.

## FAQ

### What does Calibration compare?

Calibration compares the stated likelihood with your team's Right and Wrong, on your sessions and your wording.

- Right or Wrong on a reading of a session rates the question of that reading. So each question that people check has evidence.
- Calibration shows one card for each question that people checked in the last 90 days. Checks under an earlier wording stay apart from today's.

### When does a missing answer not mean unlikely?

There are two exceptions to the rule that a missing answer means that the judge rated it unlikely:

- An Evidence card shows at most three "Maybe:" pills.
- An Evidence card never shows Worth watching as a pill, because that answer drives the ranking instead. The judge's reading of a session shows it as Worth watching or Not worth watching.

### Why is unclear not no?

Sequential keeps "I don't know" and "I don't think so" apart on purpose. Unclear does not say that the user failed or that your product broke.

Take Hit an error on a session where someone clicked "Save" again and again, and nothing measured errors. The honest answer is "can't tell". The default question is worded to get that answer.

If Sequential sent a zero for errors that nobody counted, the judge would tend to answer no. The evidence does not support that answer.

On Evidence, the sessions that the judge could not place stay in their own lane, "The judge was unsure".

### Why can a struggling session still rank high?

Some questions ask about a cause. For example: did an error stop the user, or is something in your product broken?

If a user struggles and nothing measured errors, the question tells the judge that the counts are missing, not zero. With no count, the judge cannot say that an error happened. It also cannot say that no error happened.

The session can still rank high. Worth watching asks whether a product manager should see the session, not why it went wrong.

The judge answers what it is asked.

## Related pages

- [How the judge works](/docs/judgments): what the judge reads and how it answers.
- [Evidence: the sessions worth a look](/docs/watch): the sessions in their lanes.
- [Ask: one line about sessions, funnels, retention or people](/docs/ask): ask a question in one line.
- [Questions: what the judge asks](/docs/rubric): change the questions.
- [Check the judge and read Calibration](/docs/feedback-and-calibration): how often people agree with the judge, question by question.
- [DevTools in session replays](/docs/devtools): the error counts that the judge reads.
