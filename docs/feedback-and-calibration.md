# Feedback and calibration of the AI judge

> Mark the AI judge's readings Right or Wrong on the session page, beside a list or in Workbench › Sessions. See where your team disagrees, and whether the stated probability is correct on your sessions.

> **In short**
>
> - A **Right** or **Wrong** records whether the judge's reading was right. It never re-judges a session and never changes where a session ranks.
> - Each reading on the session page has **Right** and **Wrong**: what they came to do, the outcome, the friction, each signal that is on, and **Worth watching**.
> - **How often people agree with the judge**, on the **Questions** page, can name the answer that people called wrong most often in the last 30 days.
> - The same section checks if a question is right as often as it says. It says so after 20 checks on the current wording.
> - If you reword one question, the agreement counts restart for every question.

## What it is for

Sequential judges each session with enough activity against your project's questions: the list on the **Questions** page, in the left rail.

Feedback shows if those judgments are correct on your sessions, and which questions need new wording.

### Questions feedback answers

- "The judge said this session was worth watching. Was it?"
- "How often does the team disagree with the judge's **Worth watching** reading?"
- "When a question says 80 %, is it right about 80 % of the time on our sessions, with our wording?"
- "We reworded a question last month. Is the new wording better calibrated than the old one?"

## How it works

This page calls a **Right** or **Wrong** on a reading a check. Three views read the checks:

| View | Where | Whose checks | Covers |
|---|---|---|---|
| Your score | The session page, under the readings: "You have checked 12 readings in this project and agreed with 9." | Yours | The current wording, and your **Ask** matches |
| Wrong answers | A card of **How often people agree with the judge**: "In the last 30 days, people called “Abandoned” wrong 4 of 9 times." | Everyone's | The last 30 days |
| Agreement | **How often people agree with the judge**, on the **Questions** page | Everyone's | The last 90 days |

### What a check stores, and which readings get checks

- Sequential stores each check with the answer that the judge showed, the stated probability and the wording that the judge used.
- Each reading on the session page gets checks: **Came to**, **Outcome**, **Friction**, each signal that is on, and **Worth watching** or **Not worth watching**. So each question that people check has evidence.
- A signal that the judge leans toward, but is not sure of, is named under the readings. It has no **Right** or **Wrong**.
- The session beside a list has **Right** and **Wrong** only on **Came to** and **Outcome**. In **Workbench** › **Sessions**, the column **The judge’s reading** has them on **Came to**, else on **Outcome**.
- In **Ask**, each session of an answer has "A match for your question?" with **Right** and **Wrong**. Sequential stores this check with the first 200 characters of your search. It counts in your score, but not in **How often people agree with the judge**.

### Who can give and read feedback

- Anyone who can open the project can give checks: owners, admins, members and viewers.
- Every role can read the **Questions** page and **How often people agree with the judge** on it.
- Only owners and admins can edit the questions.

> **A new wording restarts the counts**
>
> Sequential tracks one wording for all the questions together, not one for each question. If you reword one question, the agreement counts restart for every question. Your score restarts too. An update to the built-in questions does the same on a project that has not customised it.

### What starts a new wording

Sequential links every judgment and every check to the exact wording that the judge read.

A change to anything the judge reads starts a new wording:

- a question's text or criteria
- its options or levels
- its option keys
- adding or removing a question that is on
- turning a question on or off

A question that is turned off is not part of the wording.

The judge never sees these, so a change to them keeps the current wording:

- the **Name** of a question
- **The summary says**
- **Attention weight (optional)**
- question order

There is one exception. Sequential sends an answer's name to the judge when its **Pick it when** is blank. Sequential always sends a level's name.

## Give feedback on a session

1. Click **Evidence** in the left rail, or press G, then S.
2. Click the card of the session. The session opens beside the list.
3. Click **Open full**, or press O. **The judge's reading** is beside the recording.
4. Watch the session. Decide if each reading was right.
5. Click **Right** or **Wrong** beside the reading. The page then says, for example, "Saved: “Worth watching” was right."

If Sequential cannot save your click, the page says "Not saved:" and the reason.

In the session beside the list, you can also click **Right** or **Wrong** for **Came to** and **Outcome**. There the buttons are small icons, and the note beside them says "Saved" or "Not saved". Hover over "Not saved" to see the reason.

### Exact check behaviour

- After your first check, the line under the readings says, for example, "You have checked 12 readings in this project and agreed with 9." The link **How often people agree with the judge** opens that section of the **Questions** page.
- **How often people agree with the judge** compares your checks with the stated probability. Beside each reading, a word says how sure the judge was, from "unsure" to "almost certain". Hover over it to see the percent, for example "The judge gave this answer 41%".
- Select a reading, then press E for **Right** or X for **Wrong**.
- If you click the other answer, your latest check replaces the earlier one.
- You cannot clear a check. A second click on the same answer does nothing.
- If Sequential no longer has the wording that the judge read, the page says "The questions changed since this session was read, so this reading can no longer be checked."

## Read the answers people called wrong

In the left rail, select **Questions**. Under the questions, **How often people agree with the judge** shows a card for each question that people checked. A card can name the answer that people called wrong most often in the last 30 days.

### More about the wrong answers

- For example: "In the last 30 days, people called “Abandoned” wrong 4 of 9 times."
- The line only reports. It has no controls.
- The line names an answer in the question's own words. For a yes-or-no question, it says "Yes" or "No".
- A card shows the line only when the question has a check under the current wording.

## Read How often people agree with the judge

Open **How often people agree with the judge** under the questions on the **Questions** page. A question gets a card when it has at least one check in the last 90 days. A card says, for example, "People agreed with 41 of the 52 readings they checked (78.8%)." For each question, the section checks: when it said 90 %, was it right about 90 % of the time on your sessions, with your current wording?

A card says whether the judge's confidence holds up only after 20 checks on the current wording, in ranges with at least 5 checks each. Before that, it says "Too few checks yet to say whether its confidence holds up."

### What the page shows at each count

| What the page has | What you see |
|---|---|
| No checks | "Nobody has said yet whether the judge’s readings were right. Open a session and answer “Was the judge right?”; how often people agree shows here, question by question." |
| Fewer than 20 checks in ranges of 5 or more, on the current wording | The count line, and "Too few checks yet to say whether its confidence holds up." |
| 20 checks or more in such ranges | One of three sentences about the judge's confidence |

### Sentences, the chart and earlier wordings

- **Sentences**: each sentence compares the stated probability with how often people agreed.
  - "Its confidence holds up: it is about as often right as it says."
  - "It is surer than it turns out to be right. Read its confident answers with care, or sharpen the question."
  - "It is right more often than it says."
- When at least 5 checks fall where the judge was 70 % sure or more, the card also says how often people agreed then.
- **Chart**: across, how sure the judge said it was; up, how often people agreed. On the dashed line, the judge is as often right as it says it is sure. A range with fewer than 5 checks shows a hollow dot. **As a table** shows the checks per range.
- **Earlier wordings**: each earlier wording has its own line with its own counts, for example "Under an earlier wording: 12 checks, 75% agreed. Kept apart from today’s." The page never pools earlier wordings into the current wording's figures.

## Improve a question

Act when a question is over-confident or under-confident repeatedly, not after one wrong session.

The usual cause of a bad result is wording that asks for something the judge cannot see. The judge reads your labelled events, a few session facts and, when they were measured, error counts. It never sees the replay.

1. Wait until the card of the current wording says whether its confidence holds up. A line about wrong answers is a reason to look, not proof.
2. Check the question against the three tests in [Questions](/docs/rubric).
3. If the question asks about a cause, name the evidence for that cause.
4. Optional, for owners and admins: click **Edit questions**, then test the draft in **Try on a session**. Each try spends from a daily allowance.
5. Click **Save**. The change applies to sessions judged from now on.
6. Keep checking readings on session pages. Compare the new wording's card with the earlier wording's line.

### The three tests and Try on a session

- To fix a bad result, reword the question.
- The three tests in [Questions](/docs/rubric):
  - Can the judge answer it from the session?
  - Does it ask one thing?
  - Does it ask about something the judge can observe, not infer?
- In **Try on a session**, pick a session, then click **Try it**.

### Other questions and name-only edits

- The advice in step 3 applies to every question. To test a new wording quickly, use **Try on a session** on sessions whose outcome you already know.
- If only the text on screen reads badly, edit the question's **Name** or **The summary says**. Neither starts a new wording, so Sequential keeps the counts.
- Answer and level names are different: see "What starts a new wording" above.

### Example: naming the evidence

This example is from Sequential's own testing. The first built-in "Hit an error" question asked: "Judging from `events`, does a software error stop the user from completing an action?"

On a session with rage clicks and no error data, the judge, under that wording, leaned clearly towards yes. It reasoned from behaviour to a cause it could not see.

The current wording adds "and the session's error counts (…; absent when not measured)". With that, the same session comes back as can't-tell.

### What happens to sessions judged before a save

- Sessions already judged keep their stored judgment. Their session page says "The questions changed since; this reading is from the earlier version."
- Their readings, and **Right** and **Wrong** on them, keep the earlier judgment.
- Every question's agreement counts start again. The old wording gets its own line.
- A check on a session judged before the save counts toward the earlier wording. So the new wording's checks come from sessions judged after the save.

## What it needs

- **Judged sessions.** Sequential judges a session about 30 minutes after it ends, if it has at least three meaningful events. Shorter sessions get no readings and no checks.
- **Evidence the judge can read.** Mark milestones with [custom events](/docs/custom-events). If your questions ask about errors, turn on [DevTools capture](/docs/devtools).

## Limits

- **Evidence** cards have no **Right** or **Wrong**. The session beside the list and **Workbench** › **Sessions** have them only on **Came to** and **Outcome**. Check the other readings on the session page.
- After a rewording, readings judged before the save show neither **Right** nor **Wrong** as chosen, even if you checked them. Sequential keeps your check under the earlier wording.
- If you click **Right** or **Wrong** on such a reading, your score changes on screen. When you reload the page, the change is gone.
- The line about wrong answers counts every wording in its 30 days. So it can reflect a replaced wording.
- Sequential does not judge sessions again after a change to the questions.
- You cannot change the numbers that **How often people agree with the judge** uses for your project.
- If you add, remove, turn on or turn off a question, the agreement counts also restart for every question.
- You cannot clear a check. A second click on the same answer does nothing.

### More about the limits

- Sequential sets these numbers: 20 checks before a card judges the confidence, 5 checks for a range to count, and a difference of more than 10 points between what the judge said and how often people agreed.
- Your score is a count, not a calibration measure. It covers the current wording, and your checks on **Ask** matches.
- A change to **Attention weight (optional)** keeps the wording. It does change which sessions need a look on **Evidence**, so it changes which sessions people check.

## Related

- [Questions](/docs/rubric)
- [Reading a verdict](/docs/reading-verdicts)
- [Evidence: the sessions worth a look](/docs/watch)
- [Judgments](/docs/judgments)
- [Ask](/docs/ask)
- [Roles and permissions](/docs/roles-and-permissions)
