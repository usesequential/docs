# Reading an AI verdict

> A verdict is the AI judge's forecast of how likely each answer is. Learn what it means, why "unclear" is not a failure, and how to check it in the replay.

> **In short**
>
> - A verdict is a probability, not a case. A 90 % answer should be wrong about one time in ten.
> - "Unclear" means the events did not settle the question. It is not "no" and it is not an error.
> - The judge reads your events and a few facts, never the recording. Missing events give weak verdicts. Wrong events give confident wrong ones.
> - **Ask** leaves out sessions judged less than 40 % likely to match. **Evidence** and the judge's reading of a session hide yes-or-no answers below 40 %. A short or empty result does not mean that nothing happened.
> - The replay shows what really happened. Check a verdict there, then mark each reading **Right** or **Wrong**.

> **Answers below 40 % are not shown**
>
> - **Ask** does not return sessions that the judge rated less than 40 % likely to match.
> - **Evidence** cards and the judge's reading of a session leave out yes-or-no answers judged less than 40 % likely.
> - For a likelihood between 40 % and 70 %, the judge's reading names the answer after "The judge leans toward, but is not sure of:". From 60 %, an **Evidence** card shows it as **Maybe:** and the answer.
>
> A missing answer means that the judge rated it unlikely, not that it skipped it. There are two exceptions:
>
> - An **Evidence** card shows at most three **Maybe:** pills.
> - An **Evidence** card never shows **Worth watching** as a pill, because that answer drives the ranking instead. The judge's reading of a session shows it as **Worth watching** or **Not worth watching**.

## A verdict is a probability

A verdict is the judge's answer to one of your project's [questions](/docs/rubric). The judge says how likely each answer is.

To see how often a question is right, open **How often people agree with the judge** on the **Questions** page ([Feedback and calibration](/docs/feedback-and-calibration)).

### What a verdict holds

Sequential does not decide what happened in a session.

- For a choice question such as **Intent**, the verdict is its most likely option, with that likelihood.
- For a yes-or-no question such as **Hit an error**, the verdict is the likelihood of yes.

The session that you look at can be the one time in ten that a 90 % answer is wrong.

### What Calibration compares

**Calibration** compares the stated confidence with your team's **Right** and **Wrong**, on your sessions and your wording.

- **Right** or **Wrong** on a reading of a session rates the question of that reading. So each question that people check has evidence.
- **How often people agree with the judge** shows one card for each question that people checked in the last 90 days. Checks under an earlier wording stay apart from today's.

## Unclear means the judge could not tell

Unclear means that the session's events did not settle the question. The evidence was not there, or it pointed both ways.

- Unclear is an answer. It is not an error and it is not no. Sequential keeps "I don't know" and "I don't think so" apart on purpose.
- Unclear is a reason to look, not to skip. On **Evidence**, Sequential does not drop these sessions. When the judge could not tell what the person came to do, or how the session ended, and no signal fired, the session goes in the lane **The judge was unsure** ([Evidence: the sessions worth a look](/docs/watch)).

### Why unclear is not no

Unclear does not say that the user failed or that your product broke.

Take **Hit an error** on a session where someone clicked "Save" again and again, and nothing measured errors. The honest answer is "can't tell". The default question is worded to get that answer.

If Sequential sent a zero for errors that nobody counted, the judge would tend to answer no. The evidence does not support that answer.

On **Evidence**, the sessions that the judge could not place stay in their own lane, **The judge was unsure**.

## Verdicts depend on your events

The judge reads a short text version of the session's events and a few facts. It never watches the recording. If your events do not say something, the judge cannot know it.

Wrong events are worse than missing events. The judge cannot tell a mislabelled event from a true one.

### What weak events look like to the judge

- A click with no text or id reads as "element". A page view with no path or screen name reads as "(unnamed screen)" ([Events](/docs/events)).
- Without a custom event such as `invite_sent`, the judge can only infer whether someone finished ([Send custom events](/docs/custom-events)).
- If an event is mislabelled, the judge answers from wrong information, with the same confidence.

### How a long session is cut

Sequential does not judge a session with fewer than 3 meaningful events. It cuts a longer session to at most 255 events, by kind:

1. The cut drops plain clicks first.
2. Then it drops custom events.
3. Then it drops identify events.

Errors, rage clicks, dead clicks, form submits and page views survive longest. The judge also gets u-turns (where someone went back). The cut keeps them longer than form submits.

To see if a verdict was cut, read the line under the judge's reading of the session. It says "Read", then when, then "from" the count of events that the judge read, of all the events, for example "from 255 of 312 events". When nothing was cut, it says "from all" and the count.

## Missing error counts stay missing

The session's error counts are JavaScript errors, failed requests and console errors, from the recording's DevTools capture ([DevTools in replays](/docs/devtools)). If Sequential did not measure them, it never sends a zero in their place.

| What Sequential knows | What the judge reads |
|---|---|
| It counted all of it | The exact count, zero included |
| It found some, but could not count all of it | "at least N" |
| Anything else | Nothing |

### When a count is missing

The default questions that use these counts are **Outcome**, **Friction**, **Hit an error** and **Product bug**. These questions tell the judge that a missing count means "not measured", not "nothing went wrong".

"Anything else" includes these cases:

- The capture was off.
- Your SDK does not report it.
- There is no recording.
- The session is from before the counts existed.
- An incomplete count found none.

## Check customised questions

The default cause questions name their evidence: the session's error counts. If a cause question does not name its evidence, the judge reasons from behaviour. That answer can sound certain.

Customised questions keep their saved wording. It does not get later changes to the defaults.

1. Open each cause question on the **Questions** page. Check that it names the error counts in the same words as the defaults:

   "the session's error counts (`js_errors`, `failed_requests`, `console_errors`; absent when not measured)"

2. If a question does not name them, add that text.

An owner or admin can reset the questions to the defaults instead ([Customise the questions](/docs/rubric)).

### Reset to the defaults

If you are an owner or admin, you can click **Restore defaults** on the **Questions** page, then **Yes, go back to the defaults**. This replaces your questions with the defaults. The button shows only while the project has its own questions.

### Why a struggling session can still rank high

Some questions ask about a cause. For example: did an error stop the user, or is something in your product broken?

If a user struggles and nothing measured errors, the question tells the judge that the counts are missing, not zero. With no count, the judge cannot say that an error happened. It also cannot say that no error happened.

The session can still rank high. **Worth watching** asks whether a product manager should see the session, not why it went wrong.

The judge answers what it is asked.

## Check a verdict

1. Click **Evidence** in the left rail, or press G, then S.
2. Click the card of the session. The session opens beside the list, at its moment.
3. Click **Open full**, or press O, to open the full page of the session. **The judge's reading** is beside the recording.
4. Press play. Under the recording, **The judge's moments** lists the moments that the judge found. Click a moment to go to it.
5. If the moment is wrong, go back a few seconds. Or click the event in **What they did** under the recording.
6. Compare what you saw with the judge's reading.
7. If the replay makes the answer obvious but the reading was unclear or wrong, look at what the events said.
8. Mark each reading **Right** or **Wrong**. Your answer counts towards **How often people agree with the judge**. It never re-judges the session.

### Buttons, moments and what to look for

- Beside each reading, a word says how sure the judge was, from "unsure" to "almost certain". Hover over it to see the percent.
- In step 7, look for a click with no text, a milestone with no event, or errors that nobody measured.
- If you cannot play the recording now, the player says why. Examples are "This session was not recorded." and "The recording is still being put together." A click on a moment then marks its event in **What they did**. Check the events instead of the replay.
- The judge's moments count from the session's first event, not the start of the recording. The replay can start early or late for this reason.
- A moment after the end of the recording reads "after the recording ended". It is not a button.
- Select a reading, then press E for **Right** or X for **Wrong**. The page then says, for example, "Saved: “Abandoned” was wrong."
- When the questions changed since the judge read the session, the line under the reading says "The questions changed since; this reading is from the earlier version."
- In the session beside the list, **Came to** and **Outcome** also have **Right** and **Wrong**, as two small buttons. There the note says "Saved" or "Not saved".

## Judge a recording now

On the full page of a session, **The judge's reading** has the button **Judge this recording now**. When the page already shows a reading, the button says **Judge again**. It asks the judge for a reading now, with your current questions.

1. Open the full page of the session. The button shows only when the recording can play.
2. Wait until **What they did** has loaded. Until then, the line under the button says "Ready once “What they did” has loaded."
3. Click **Judge this recording now**, or **Judge again**. While the judge reads, the button says **Judging…**. This can take up to 45 seconds.
4. Read the new reading. The line under it says, for example, "Judged just now from all 42 events. Lists and the automatic reading keep theirs; this one is for this page."

The new reading replaces the stored reading on this page until you leave the page. **Evidence**, the lists and the stored judgment keep the stored reading. You can mark the new reading **Right** or **Wrong**, as any other reading.

### What Judge this recording now uses and sends

- **Who can use it.** Every role: owners, admins, members and viewers. It needs access to the recordings of the project.
- **Allowance.** It uses the project's daily allowance for judging on demand. Background judging, **Ask** and **Try it** each have their own allowance. The line under the button says "Uses this project’s allowance for judging on demand today. An answer already made for these events is free."
- **Saved answers.** Sequential keeps the judge's answer for the same events and questions for up to 7 days. The first click can return that answer, free. The line under the reading then says that it is "the judge’s earlier answer for this recording (nothing was spent)".
- **Judge again** asks for a fresh answer only after a reading made on this page. After a fresh answer from **Judge again**, the session gets the next fresh answer 10 minutes later at the earliest. Before then, the line says "This is the reading made at …: a session can be judged again 10 minutes after its last fresh reading."
- **What it sends.** Your browser builds a digest from the session's events that **What they did** loads, whatever its search or chips show: the event lines and a few session facts. It sends no custom-event properties, no error counts and no user id. The server scans the text again before the judge reads it. See [AI and third parties](/docs/ai-and-third-parties).
- **Moments.** The moments of the new reading count on the player's timeline. Each moment that can play is a button.
- The judge needs at least 3 events that it reads. With fewer, the page says "Judging on demand needs 3 events the judge reads; this session has fewer."

### Messages from Judge this recording now

| You see | What it means |
|---|---|
| "On-demand judging has used today’s allowance for this project. It starts again …" | The allowance for judging on demand is used for today. It resets at midnight UTC. Background judging is not affected |
| "Sequential cannot check today’s judging allowance right now, so it judged nothing and charged nothing. Try again shortly." | Sequential cannot read the allowance. Nothing was spent. Click **Try again** |
| "Judging on demand is switched off on this server." | Judging is not set up on your Sequential server |
| "The judge could not read this session this time. Nothing was charged for a failed reading. Try again." | The judge failed. Click **Try again** |
| "This session has no recording on the server, so there is nothing to judge." | Sequential has no recording of this session |
| "Too many requests for this project right now. Try again …" | The project sent too many requests. The message says when to click **Try again** |
| "The judge did not answer within 45 seconds; it may still finish. Try again." | The page stopped waiting. Click **Try again** |
| "Your role cannot watch recordings in this project, so it cannot judge them." | Your role has no access to the recordings of this project |
| "Judging on demand sends what “What they did” shows, which did not load. Try it again there." | **What they did** did not load, so there is nothing to send |

## Limits

- Sequential does not judge a session with fewer than 3 meaningful events.
- Sequential cuts a long session to at most 255 events before the judge reads it. The cut can remove a milestone such as `invite_sent`.
- Without DevTools capture, questions about errors rest on the error events that your SDK sends.
- **How often people agree with the judge** has evidence only for the questions that people mark **Right** or **Wrong**.

## Related

- [AI judgments of sessions](/docs/judgments)
- [Evidence: the sessions worth a look](/docs/watch)
- [Ask: one line about sessions, funnels, retention or people](/docs/ask)
- [Questions: what the judge asks](/docs/rubric)
- [Feedback and calibration](/docs/feedback-and-calibration)
- [DevTools in replays](/docs/devtools)
