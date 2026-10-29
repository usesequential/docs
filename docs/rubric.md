# Questions: what the judge asks

> The questions are what the judge asks of each session it reads. They are on the Questions page. Add your own, try them on a recent session, then save them for sessions judged after that.

> **In short**
>
> - Each project has one set of up to 24 questions, on the **Questions** page in the rail. The judge asks each question that is on of every session it reads.
> - Sequential ships 12 default questions. Add your own yes-or-no questions for your product's own moments.
> - **Try on a session** runs your draft on one recent session before you save. Nothing is saved.
> - A change to what the judge reads applies only to sessions judged after you save. Sequential does not judge earlier sessions again. Weights and order apply at once.
> - Only owners and admins edit the questions.

## What it is for

The default questions are generic. For example, **Outcome** asks how the session ended, and **Hit an error** asks if an error stopped the user. Add questions for your product's own moments. For example:

- Did the admin send an invite after opening the team page?
- Did they start a plan change and then leave?

The answers show on the session page, which you open from [Evidence](/docs/watch). Answers with a weight decide which sessions need a look.

## How it works

The judge does not watch the recording. It reads a text digest of the session's events. [How Sequential works](/docs/how-it-works) explains the steps.

The page shows the questions in four groups:

| Group | What the judge answers |
|---|---|
| **What they came to do and how it ended** | One answer from a list of 2 to 30 answers |
| **How hard it was** | One level of a scale of 2 to 7 levels, lowest first |
| **Signals** | Yes, no or unclear |
| **Moments** | First whether it happened, then the event where it did. Up to 5 moments. |

- A signal is yes when the judge gives yes a chance of "70%" or more. It is unclear from "40%" to "70%". Below "40%", it is no.
- Some questions do a job in the product. For example, a card says "Sets each session’s intent." or "Marks where people struggled." You can turn such a question off. You cannot remove it.

## Read the questions

1. In the rail, select **Questions**. The page shows the project that is open.
2. Read the line under the title. It gives the number of questions the judge asks and the version. It also says if the questions are "this project’s own" or "Sequential’s defaults".
3. Read the cards. Each card shows the name, the question, the answers or levels, and the **Yes when** and **No when** lines. A question that is off shows **Off**.
4. A card with a weight says how much it counts. For example: "It counts for 45% of the weight in which sessions need a look."
5. To see the keys, click **Show keys** above the questions. It is off by default. The line beside it says "Keys are the names agents and the API use for each question and answer."

With **Show keys** on, each question shows its key beside its name. Each answer of a list also shows its key. The levels of a scale have no keys.

The card does not show the words "judging from `events`". The judge still reads them. The stored text does not change.

## Edit the questions

You need the owner or admin role. For members and viewers, **Edit questions** is off. Its tooltip says, for example, "Only an owner or admin can change the questions; you are a member here." See [Roles and permissions](/docs/roles-and-permissions).

1. Click **Edit questions**.
2. Change the fields of a question. Or click **Add a signal** to add a yes-or-no question.
3. Fill in **Name** and **The judge asks**. **Yes when** and **No when** are optional.
4. To test the draft, use **Try on a session**. See Try on a session, below.
5. Click **Save**, or press ⌘S (Ctrl S on other computers).
6. To drop your edits, click **Discard**.

The bar at the bottom counts the questions. For example: "12 of 24 questions · 12 asked · 3 of 5 moments". Open the number of changes to read one sentence per change. For example: "Rewords “Hit an error”. The judge asks it the new way from now on."

After a save, a message says "Saved as version 4. The judge asks the new questions of new sessions; past sessions keep their answers." If nothing changed, it says "Nothing changed, so nothing was saved."

If you leave the page with unsaved edits, the browser asks "Leave without saving your edits to the questions?"

## Write questions the judge can answer

If the session cannot answer a question, the judge still gives an answer. That answer looks like a measurement. So ask only what the session can answer. Ask one thing per question. Ask about what happened. If you ask about a cause, name the evidence.

Good wording cannot fix bad evidence. If every screen reaches Sequential under the same name, good questions still get confident wrong answers.

> **Changes are forward-only**
>
> After you change what the judge reads, sessions judged earlier keep their answers. Sequential does not judge them again. The app has no action to judge them again. Their session page says "The questions changed since; this reading is from the earlier version."

A change to what the judge reads also starts new agreement counts for every question. Make related changes in one save. See How often people agree with the judge, below.

## What it needs

- **Custom events** named for your moments, such as `invite_sent`. See [Send custom events](/docs/custom-events).
- **At least 3 events per session** that the judge can read. System events do not count. Sequential does not judge shorter sessions.
- **Error capture** for questions that name the error counts. See [DevTools in replays](/docs/devtools). Without it, the counts are absent, not zero.
- **Background judging.** The switch is **Judge new sessions automatically**, under **Settings** › **Recording & data** › **Judging**. It is on by default. Owners and admins change it. Your Sequential server must also allow automatic judging.

If background judging is off, your questions stay saved. Sequential judges no session in the background until it is on again.

## Limits

- One set of questions per project. You cannot copy the questions to another project.
- Up to 24 questions, and up to 5 moments. At least one question must stay on.
- **Name**: up to 40 characters. **The judge asks**: up to 300 characters. Each criterion and each summary line: up to 200 characters.
- In the editor, you can add yes-or-no questions only. You can change the questions of the other kinds, but not add them.
- A question that does a job in the product cannot be removed. Turn it off.
- **Try on a session**: up to 10 tries a minute per person, within a daily allowance of its own.
- **History** lists the last 20 versions.
- The judge reads at most 255 events per session. In a longer session, it drops plain clicks first, then custom events.
- Sequential drops a custom-event property before judging if a whole part of its key is a personal-looking word, such as `name` or `account`.
- A saved question keeps its id, and a saved answer keeps its key. To change what an answer means, add a new answer.

### The default questions

Sequential ships these 12 questions. Four of them have a weight.

| Group | Question | Weight |
|---|---|---|
| What they came to do and how it ended | **Intent** | – |
| What they came to do and how it ended | **Outcome** | – |
| How hard it was | **Friction** | 0.25 |
| Signals | **Rage clicks** | – |
| Signals | **Hit an error** | 0.15 |
| Signals | **Product bug** | 0.15 |
| Signals | **Form left unfinished** | – |
| Signals | **Went in circles** | – |
| Signals | **Worth watching** | 0.45 |
| Moments | **Where they struggled** | – |
| Moments | **What they came to do** | – |
| Moments | **Where they gave up** | – |

The weights add up to 1. So **Worth watching** counts for "45%" of the weight.

### Fill in a question

| Kind | The fields |
|---|---|
| Signal | **Name**, **The judge asks**, **Yes when** (optional), **No when** (optional), **Attention weight (optional)** |
| One answer from a list | **Name**, **The judge asks**, and per answer **Answer 1**, **Pick it when** (optional). **Add an answer** adds one. |
| Scale | **Name**, **The judge asks**, and per level **Level 0**, **Place it here when** (optional), **The summary says** (optional). **Add a level** adds one on top. **Attention weight (optional)**. |
| Moment | **Name**, **First, the judge asks**, **Yes when**, **No when**, **Then, at which event** |

- **Name** is what the question is called on sessions. The judge does not read it.
- Each field shows its character count and its limit.
- A note beside a field says what to fix. **Save** does not save while a note is open.
- In the editor, under a saved question, the page shows its id, for example "Stored as `outcome`". A new question takes its id from its name until you save.

### What the judge reads

The digest of a session contains:

- Labelled events: pages, clicks, form submits, errors, failed requests, rage and dead clicks, and your custom events.
- A few session facts.
- Error counts, when the recording measured them.

From each question that is on, the judge reads:

- **The judge asks**, or **First, the judge asks** and **Then, at which event**.
- **Yes when** and **No when**.
- For each answer: **Pick it when**. If it is empty, the judge reads the answer's name.
- For each level: its name and **Place it here when**.

The judge never reads these parts: **Name**, **Attention weight (optional)**, **The summary says**, and the order of the questions. They only change how Sequential shows and ranks the answers.

### How the weight works

Signals and scales can have an **Attention weight (optional)**, from 0 to 1. Each judged session gets an attention score from these weights. A session with a score of 0.35 or more needs a look.

- For a signal, Sequential multiplies the weight by the chance of yes.
- For a scale, Sequential multiplies the weight by the level, divided by the number of levels minus 1. The top level adds the full weight. The lowest level adds nothing.
- Sequential adds the results of all questions that are on.

The help under the field says, for example, "A sure yes adds 0.45 to a session’s attention score; a 50/50 answer adds 0.225."

- Weights need not add up to 1. A card shows its weight as a share of all the weights that are on.
- A weight change re-ranks past sessions at once. Nothing is judged again.
- If the weights of the questions that are on add up to less than 0.35, a banner says that no session could need a look.

### Other controls in the editor

| To | Use |
|---|---|
| Stop asking a question but keep it | Its **Asked** switch. It then reads **Off**. |
| Move a question in its group | The up and down buttons, Alt+↑ and Alt+↓, or drag the handle onto another question of the same kind |
| Move a level of a scale | The up and down buttons beside the level |
| Remove a question | **Remove**. It is off for a question that does a job in the product: "This question does a job in the product. Turn it off instead." |
| Remove an answer or a level | The × beside it. A list keeps at least 2 answers, and a scale at least 2 levels. |

### Save conflicts

If someone else saved after you started, **Save** fails. A banner says, for example, "Ana changed the questions 2 minutes ago (now version 8), so yours were not saved. Start again from theirs, or save again to put yours in their place."

- Under **What they changed**, the banner lists their changes.
- **Start again from theirs** drops your edits and opens their version.
- If you click **Save** again, your version replaces theirs.

### How often people agree with the judge

On a session page, each reading of the judge has **Right** and **Wrong**. Press e for right or x for wrong on the reading that has the focus. Your answer does not judge the session again. See [Feedback and calibration](/docs/feedback-and-calibration).

The section **How often people agree with the judge** is under the questions on **Questions**. It shows one card per question that people checked.

- It counts the last 90 days. For each person, session and question, it counts only the latest answer of that person.
- A card says, for example, "People agreed with 41 of the 52 readings they checked (78.8%)."
- When at least 5 checks fall where the judge was "70%" sure or more, the card says how often people agreed then.
- Until there are 20 checks in ranges with at least 5 checks each, the card says "Too few checks yet to say whether its confidence holds up." With more, it says if the judge is surer than it is right, right more often than it says, or about as often right as it says.
- **As a table** shows the checks per range of the judge's sureness.
- A card can also name the answer that people called wrong most often in the last 30 days.

Each wording keeps its own counts. A save that changes what the judge reads starts a new wording for all the questions. Checks under an earlier wording show apart, for example "Under an earlier wording: 12 checks, 75% agreed. Kept apart from today’s." A change to a name, a weight, a summary line or the order keeps the counts.

### Which edits apply when

| Edit | Applies to |
|---|---|
| **The judge asks**, **Yes when**, **No when**, **Pick it when**, **Place it here when**, the name of a level, the name of an answer without **Pick it when**, adding, removing, turning a question on or off | Sessions judged from now on. A new order of levels also applies from now on. |
| **Attention weight (optional)** | At once, for past sessions too |
| **Name** of a question or an answer, **The summary says** | Past sessions too, if the same save changes nothing that the judge reads. Else, sessions judged from now on. |
| Order of the questions | At once |

The list of changes above **Save** says which case applies. For example: "Renames “Rage clicks” to “Angry clicks”, also on past sessions."

## Proposals from an agent

An agent can propose a change to the questions. Nothing changes until an owner or admin applies the proposal.

1. Give the agent a token with the scope `insights:propose`. It also needs `sessions:explore`.
2. The agent reads the questions with `get_rubric`. Then it calls `propose_rubric` with the whole new set of questions and the version that it read. It can also propose to go back to a version of the history. It can ask for a test on one session. From 29 October 2026, if `get_rubric` withheld a text, the agent can send the withheld value back unchanged at the same place. Sequential then keeps the text that the questions have at that place, and the agent never sees it. Sequential refuses a withheld value at a place that has no text, for example in a new question.
3. The proposal shows at the top of **Questions**, under **Proposed**. The card shows the token's name and when it came. The line under the title says, for example, "1 proposed edit waits for you."
4. The card says what the proposal changes, one sentence per change. For example: "Adds “Invite sent”. The judge asks it of new sessions; past sessions are not judged again." New and reworded questions show in full.
5. An owner or admin clicks **Apply** or **Reject**. Or put the focus on the card and press e or x.

### Let your agent suggest questions

This card on **Questions** gives you a prompt for your own agent. Sequential shows it only when all of these are true:

- The questions are Sequential's defaults. Nobody changed them, or someone reset them.
- The project takes proposals, and no proposal waits.
- You are not editing the questions.
- You have your own live agent connection with `insights:propose` and `sessions:explore`. An access token does not count.

The card says "Your agent can read your sessions and suggest questions that fit your product. Copy this prompt into it. Nothing changes until you apply a suggestion here." For a member, it ends "Nothing changes until an owner or admin applies a suggestion here."

Under the line, **Prompt for your agent** shows the whole prompt. **Copy prompt** puts it on the clipboard. The prompt tells the agent to read the questions and your project's data, and to send one proposal with at most 3 changes. It tells the agent not to test the proposal on a session, because that test is paid, and not to apply anything. Paste it into your agent. The proposal then shows under **Proposed**.

After **Apply**, a message says, for example, "Applied. The judge asks the new questions from now on (version 5)." Members and viewers read, after the reason why they cannot edit: "An agent may still propose a change; an owner or admin applies it."

### Proposal limits

- A proposal ends after 14 days, or when someone changes the questions after the agent read them.
- If the questions changed since the agent read them, the card says "Written against version 3; the questions are now at version 4. Applying it may be refused."
- A new proposal from the same token replaces its open proposal.
- By default, each project gets at most 5 proposals a day and at most 10 tests on a session a day. From 29 October 2026, only a proposal that Sequential stores counts toward the 5. A refused proposal does not.
- When Sequential refuses a text in a proposal, it tells the agent where the text is in the questions, never the text itself. It also gives the reason and a hint, for example to write the text as what the visitor did or saw, not as a command. When only the texts of one question read together were refused, it names that question. A proposal with too many texts to check is refused with the number of texts and the limit. Then the agent can propose part of the change now and the rest later.
- From 29 October 2026, Sequential checks the new and changed texts of a proposal with a question made for questions. It asks if a text tries to make the judge, or an agent that reads it, do something other than judge the session on its evidence, for example ignore its rules, call tools or send data. The check knows that questions are written for the judge, and that labels are often short phrases such as Contact sales.
- Each test spends from the daily allowance of **Try on a session**.

### Versions and restore

Each save that changes something makes a new version. The [Audit log](/docs/audit-log) records each save, reset and restore.

**History** lists the last 20 versions, newest first. Each line says what changed, and who changed it. For example: "Version 7, 2 hours ago: Added Invite sent. Changed by Ana." A version from a proposal says, for example, "An agent (Claude Code) proposed it; Ana applied it." The current version shows **Now**.

To bring back an earlier version:

1. Click **Restore** on its line.
2. Click **Yes, bring back version 3**.

Sequential saves that version as a new version. The history keeps both. Sequential does not judge any session again. With unsaved edits, **Restore** is off: "Save or discard your edits first."

To go back to the default questions:

1. Click **Restore defaults**. Owners and admins see it when the questions are this project's own.
2. Click **Yes, go back to the defaults**.

A project on the defaults gets each new default that Sequential ships. A project with its own questions keeps them until it restores the defaults.

### Try on a session

**Try on a session** is in the editor, under the questions. The judge reads one recent session with your draft. Sequential saves nothing.

- The list shows up to 15 recent sessions that the judge read, newest first. Each has at least 3 events. A row shows when it started, the page, the events and the outcome. For example: "2 hours ago · /pricing · 12 events, completed".
- Before you try, a line says how many of these sessions need a look with your draft's weights. Sequential works this out from the stored answers. Nothing is judged or charged.
- Click **Try it**. The result shows the attention score with your draft, and the score of today.
- A table shows **Question**, **With your draft** and **Today**. A row in bold answers differently from today.
- Each person can try up to 10 times a minute. Then: "That is 10 tries this minute, the most there is. Try again in 20 seconds."
- Tries spend from a daily allowance of their own. It is separate from background judging. It resets at midnight UTC. When it is used up, the page says "Today’s judging budget for tries is used up, so nothing was judged." with the time it starts again.
- If Sequential cannot read the allowance, the try does not run and spends nothing: "Sequential cannot read the judging budget right now, so nothing was judged or charged. Try again shortly."
- While a note beside a question is open, **Try it** is off: "Fix the notes beside the questions first."
- If the server has no judge: "The judge is not set up on this server, so drafts cannot be tried here."
- If no session was judged recently: "No judged session in the last days to try it on. Once the judge has read a few sessions, they show here."

### Three tests for a question

The judge answers every question it gets.

- **Answerable from the session.** The judge sees labelled events, a few session facts and error counts. The session does not contain an answer to "Did they read the documentation carefully?".
- **One thing per question.** "Did they hit an error and give up?" asks about two facts. No single answer fits both. The default questions ask them separately, as **Hit an error** and **Outcome**.
- **About what happened, not a feeling.** "Was the user frustrated?" asks for a feeling. "Did they click the same control again and again?" asks for something that happened.

If a question asks about a cause, name the evidence for it. Give each answer a one-line **Pick it when**. Add a "none of these" answer to each list. See Example: name the evidence, below.

### Example: name the evidence

The first shipped **Hit an error** question read: "Judging from `events`, does a software error stop the user from completing an action?"

That question did not tell the judge to read the error counts. The current wording adds "and the session's error counts (`js_errors`, `failed_requests`, `console_errors`; absent when not measured)". Now the question names its evidence, and says that a count can be absent.

### Answer keys and added text

- The judge reads the key of an answer. To see the keys, click **Show keys** on the **Questions** page. A saved key stays the same when you rename the answer. To change what an answer means, add a new answer. Do not rename the old one.
- If **The judge asks** does not name `events` or `session` in backticks, Sequential adds "Judge from `events`." to its end. The judge reads this text too.
- If you name `events` yourself, as the default wording does, Sequential adds nothing.

### What the judge drops or cuts

- The judge reads at most 255 events per session. In a longer session, Sequential drops plain clicks first. Then it drops custom events, before any other kind. Errors and failed requests stay longest. Of each kind, the earlier events stay.
- A property is dropped when a whole part of its key is a personal-looking word: email, name, user, account, address, phone, card, token and similar. This includes ordinary keys such as `plan_name`, `step_name` or `account_type`. Use the event name, or a key that avoids those words.
- Put the fact that your question needs in the event name, such as `invite_sent` or `plan_change_started`.

## Related

- [How Sequential works](/docs/how-it-works)
- [Judgments](/docs/judgments)
- [Evidence](/docs/watch)
- [Feedback and calibration](/docs/feedback-and-calibration)
- [Send custom events](/docs/custom-events)
- [Roles and permissions](/docs/roles-and-permissions)
- [Audit log](/docs/audit-log)
- [DevTools in replays](/docs/devtools)
