# Questions: what the judge asks

> The questions are what the judge asks of each session it reads. Add your own, try them on a recent session, then save them for sessions judged after that.

> **At a glance**
>
> - **Who can:** Only owners and admins edit the questions. An agent can propose a change; an owner or admin applies it.
> - **Default:** Sequential ships [12 default questions](#which-questions-does-sequential-ship). Add your own yes-or-no questions, at most 24 in all.
> - **Takes effect:** What the judge reads: only for sessions judged after you save. Weights and order: at once.
> - **Before you start:** Custom events named for your moments, such as `invite_sent` ([What it needs](#what-it-needs)).
> - **You get:** Answers on each session page. Answers with a weight give an attention score: 0.35 or more needs a look.
> - **Know this:** The judge asks every question that is on. It reads a text digest of each session, not the recording.
> - **Know this:** Ask only what the session can answer: one thing per question, about what happened.

## Edit the questions

1. In the rail, click **Questions**.

   Result: The page shows the project that is open.

2. Click **Edit questions**.

   Result: For members and viewers, Edit questions is off ([Roles and permissions](/docs/roles-and-permissions)).

3. Change the fields of a question. Or, to add a yes-or-no question, click **Add a signal**. From 7 November 2026, the last card on the Questions page, "Add a question only your product has", also has **Add a signal**.

4. Fill in **Name** and **The judge asks**. Yes when and No when are optional.

5. To test the draft before you save, use [Try on a session](#try-on-a-session). Nothing is saved.

6. Click **Save**, or press ⌘S (Ctrl S on other computers).

   Result: A message says, for example, "Saved as version 4. The judge asks the new questions of new sessions; past sessions keep their answers."

7. To drop your edits, click **Discard**.

### The card for a question only your product has

From 7 November 2026, the last card on the Questions page says "Add a question only your product has" and, for example, "For example: “Did the person find the price before they left?”"

- Owners and admins see "Add a signal". It opens the editor with a new yes-or-no question. At the limit, the card says, for example, "That is 24 questions, the most the judge asks. Remove one to add another."
- Members see "Ask your agent to propose it. An owner or admin applies it." and "Ask your agent". If agent proposals are not available in the project, members see "An owner or admin adds questions."
- Viewers do not see the card.
- From 8 November 2026, owners and admins also see "Add starter questions". It says "Pick the kind of app. Its starter questions open in the editor, and nothing is saved until you save." Pick a kind, and its starter questions open in the editor. A starter question that is already in your list is left out. Sequential does not save the kind.

> **Changes are forward-only**
>
> After you change what the judge reads, sessions judged earlier keep their answers. Sequential does not judge them again. The app has no action to judge them again. Their session page says "The questions changed since; this reading is from the earlier version."

### Which edits apply when

| Edit | Applies to |
|---|---|
| The judge asks, Yes when, No when, Pick it when, Place it here when, the name of a level, the name of an answer without Pick it when, adding, removing, turning a question on or off | Sessions judged from now on. A new order of levels also applies from now on. |
| Attention weight (optional) | At once, for past sessions too |
| Name of a question or an answer, The summary says | Past sessions too, if the same save changes nothing that the judge reads. Else, sessions judged from now on. |
| Order of the questions | At once |

The list of changes above Save says which case applies. For example: "Renames “Rage clicks” to “Angry clicks”, also on past sessions."

From 7 November 2026, rewording a question starts new Calibration counts for that question only. The other questions keep their counts ([Calibration](#calibration)).

### Save conflicts

If someone else saved after you started, Save fails. A banner says, for example, "Ana changed the questions 2 minutes ago (now version 8), so yours were not saved. Start again from theirs, or save again to put yours in their place."

- Under What they changed, the banner lists their changes.
- Start again from theirs drops your edits and opens their version.
- If you click Save again, your version replaces theirs.

### Fill in a question

| Kind | The fields |
|---|---|
| Signal | Name, The judge asks, Yes when (optional), No when (optional), Attention weight (optional) |
| One answer from a list | Name, The judge asks, and per answer: Answer 1 and Pick it when (optional). Add an answer adds one. |
| Scale | Name, The judge asks, and per level: Level 0 and Place it here when (optional) and The summary says (optional). Add a level adds one on top. Attention weight (optional). |
| Moment | Name, First, the judge asks, Yes when, No when, Then, at which event |

In the editor, you can add yes-or-no questions only. You can change the questions of the other kinds, but not add them.

- Name is what the question is called on sessions. The judge does not read it.
- Each field shows its character count and its limit.
- A note beside a field says what to fix. Save does not save while a note is open.
- In the editor, under a saved question, the page shows its id, for example "Stored as `outcome`". A new question takes its id from its name until you save.
- A saved question keeps its id, and a saved answer keeps its key. A saved key stays the same when you rename the answer. To change what an answer means, add a new answer. Do not rename the old one.

Some questions do a job in the product. For example, a card says "Sets each session’s intent." or "Marks where people struggled." You can turn such a question off. You cannot remove it.

The other controls in the editor:

| To | Use |
|---|---|
| Stop asking a question but keep it | Its Asked switch. It then reads Off. |
| Move a question in its group | The up and down buttons, Alt+↑ and Alt+↓, or drag the handle onto another question of the same kind |
| Move a level of a scale | The up and down buttons beside the level |
| Remove a question | Remove. It is off for a question that does a job in the product: "This question does a job in the product. Turn it off instead." |
| Remove an answer or a level | The × beside it. A list keeps at least 2 answers, and a scale at least 2 levels. |

#### Messages while you edit and save

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Only an owner or admin can change the questions; you are a member here." | The tooltip of Edit questions. For members and viewers, Edit questions is off. | An example: you need the owner or admin role to edit. See [Roles and permissions](/docs/roles-and-permissions). | — |
| "An agent may still propose a change; an owner or admin applies it." | For members and viewers, after the reason why they cannot edit | An agent can still send a proposal. An owner or admin applies it. | — |
| "12 of 24 questions · 12 asked · 3 of 5 moments" | The bar at the bottom | An example: the bar counts the questions. | — |
| "Rewords “Hit an error”. The judge asks it the new way from now on." | The number of changes in the bar, when you open it | An example: one sentence per change. | — |
| "Nothing changed, so nothing was saved." | After a save | Nothing changed. | — |
| "Leave without saving your edits to the questions?" | The browser, when you leave the page with unsaved edits | Your edits are not saved yet. | — |

### Versions and restore

Each save that changes something makes a new version. The [Audit log](/docs/audit-log) records each save, reset and restore.

History lists the last 20 versions, newest first. Each line says what changed, and who changed it. For example: "Version 7, 2 hours ago: Added Invite sent. Changed by Ana." A version from a proposal says, for example, "An agent (Claude Code) proposed it; Ana applied it." The current version shows Now.

To bring back an earlier version:

1. Click **Restore** on its line.

2. Click **Yes, bring back version 3**.

Result: Sequential saves that version as a new version. The history keeps both. Sequential does not judge any session again.

With unsaved edits, Restore is off: "Save or discard your edits first."

Owners and admins see Restore defaults when the questions are this project's own. To go back to the default questions:

1. Click **Restore defaults**.

2. Click **Yes, go back to the defaults**.

A project on the defaults gets each new default that Sequential ships. A project with its own questions keeps them until it restores the defaults.

## How the judge uses your questions

[How Sequential works](/docs/how-it-works) explains how a session's events reach the judge. The page shows the questions in four groups:

| Group | What the judge answers |
|---|---|
| What they came to do and how it ended | One answer from a list of 2 to 30 answers |
| How hard it was | One level of a scale of 2 to 7 levels, lowest first |
| Signals | Yes, no or unclear |
| Moments | First whether it happened, then the event where it did. At most 5 moments. |

A signal is yes when the judge gives yes a chance of "70%" or more. It is unclear from "40%" to "70%". Below "40%", it is no.

The answers show on the session page, which you open from [Evidence](/docs/watch).

Answers with a weight decide which sessions need a look ([How is the attention score computed?](#how-is-the-attention-score-computed)).

### What the judge reads

The judge does not watch the recording. It reads a text digest of the session's events ([How Sequential works](/docs/how-it-works)). The digest of a session contains:

- Labelled events: pages, clicks, form submits, errors, failed requests, rage and dead clicks, and your custom events.
- A few session facts.
- Error counts, when the recording measured them ([DevTools in session replays](/docs/devtools)).

From each question that is on, the judge reads:

- The judge asks, or First, the judge asks and Then, at which event.
- Yes when and No when.
- For each answer: its key and Pick it when. If Pick it when is empty, the judge reads the answer's name.
- For each level: its name and Place it here when.

The judge never reads these parts: Name, Attention weight (optional), The summary says, and the order of the questions. They only change how Sequential shows and ranks the answers.

To see the keys, click Show keys above the questions. It is off by default. The line beside it says "Keys are the names agents and the API use for each question and answer." With it on, each question shows its key beside its name. Each answer of a list also shows its key. The levels of a scale have no keys.

If The judge asks does not name `events` or `session` in backticks, Sequential adds "Judge from `events`." to its end. The judge reads this text too. If you name `events` yourself, as the default wording does, Sequential adds nothing.

The card does not show the words "judging from `events`". The judge still reads them. The stored text does not change.

## Try on a session

The judge reads one recent session with your draft.

1. In the editor, change the questions ([Edit the questions](#edit-the-questions)).

2. Under the questions, choose a session in the Try on a session list.

   Result: The list shows at most 15 recent sessions that the judge read, newest first. Each has at least 3 events. A row shows when it started, the page, the events and the outcome. For example: "2 hours ago · /pricing · 12 events, completed".

3. Click **Try it**.

   Result: The result shows the attention score with your draft, and the score of today.

4. Read the table of answers.

   Result: A table shows Question, With your draft and Today. A row in bold answers differently from today.

### How Try on a session works in detail

- Before you try, a line says how many of these sessions need a look with your draft's weights. Sequential works this out from the stored answers. Nothing is judged or charged.
- Each person can try at most 10 times a minute.
- Tries spend from a daily allowance of their own. It is separate from background judging. It resets at midnight UTC.

#### Messages from Try on a session

| Message | Where | What it means | What to do |
|---|---|---|---|
| "That is 10 tries this minute, the most there is. Try again in 20 seconds." | — | You tried 10 times this minute. | — |
| "Today’s judging budget for tries is used up, so nothing was judged." | — | The daily allowance of tries is used up. The page also shows the time it starts again. | — |
| "Sequential cannot read the judging budget right now, so nothing was judged or charged. Try again shortly." | — | Sequential cannot read the allowance. The try does not run and spends nothing. | — |
| "Fix the notes beside the questions first." | — | A note beside a question is open, so Try it is off. | — |
| "The judge is not set up on this server, so drafts cannot be tried here." | — | The server has no judge. | — |
| "No judged session in the last days to try it on. Once the judge has read a few sessions, they show here." | — | No session was judged recently. | — |

## Read the questions

On Questions, the line under the title gives the number of questions the judge asks and the version. It also says if the questions are "this project’s own" or "Sequential’s defaults".

Each card shows the name, the question, the answers or levels, and the Yes when and No when lines. A question that is off shows Off. A card with a weight says how much it counts. For example: "It counts for 45% of the weight in which sessions need a look."

## Write questions the judge can answer

Add questions for your product's own moments. For example:

- Did the admin send an invite after opening the team page?
- Did they start a plan change and then leave?

If the session cannot answer a question, the judge still gives an answer. That answer looks like a measurement. So ask only what the session can answer.

### Three tests for a question

| Test | Why |
|---|---|
| Answerable from the session | The judge sees labelled events, a few session facts and error counts. The session does not contain an answer to "Did they read the documentation carefully?". |
| One thing per question | "Did they hit an error and give up?" asks about two facts. No single answer fits both. The default questions ask them separately, as Hit an error and Outcome. |
| About what happened, not a feeling | "Was the user frustrated?" asks for a feeling. "Did they click the same control again and again?" asks for something that happened. |

The judge reads The judge asks, Yes when, No when, Pick it when and Place it here when, never Name or The summary says ([What the judge reads](#what-the-judge-reads)).

If a question asks about a cause, name the evidence for it, as in [the Hit an error example](#what-does-a-question-that-names-its-evidence-look-like). Give each answer a one-line Pick it when. Add a "none of these" answer to each list.

Good wording cannot fix bad evidence. If every screen reaches Sequential under the same name, good questions still get confident wrong answers.

### What it needs

- At least 3 events per session that the judge can read. System events do not count. Sequential does not judge shorter sessions.
- Custom events named for your moments ([Send custom events](/docs/custom-events)).
- Error capture for questions that name the error counts ([DevTools in session replays](/docs/devtools)). Without it, the counts are absent, not zero.
- Background judging: Judge new sessions automatically, under Settings › Recording & data › Judging. It is on by default. Owners and admins change it.

Your Sequential server must also allow automatic judging. If background judging is off, your questions stay saved. Sequential judges no session in the background until it is on again.

## Proposals from an agent

An agent can propose a change to the questions. Nothing changes until an owner or admin applies the proposal.

1. Give the agent a token with the scope `insights:propose` ([Programmatic access](/docs/limits#programmatic-access)). It also needs `sessions:explore`.

2. Let the agent read the questions with `get_rubric` and send a proposal with `propose_rubric`.

3. In the rail, click **Questions**.

   Result: The proposal shows at the top, under Proposed. The line under the title says, for example, "1 proposed edit waits for you."

4. Read the proposal card.

   Result: It shows the token's name and when it came, and one sentence per change. New and reworded questions show in full.

5. As an owner or admin, click **Apply** or **Reject**. Or put the focus on the card and press E or X.

Result: After Apply, a message says, for example, "Applied. The judge asks the new questions from now on (version 5)."

### For agents: reading and proposing questions

The agent reads the questions with `get_rubric`. Then it calls `propose_rubric` with the whole new set of questions and the version that it read. It can also propose to go back to a version of the history. It can ask for a test on one session.

From 29 October 2026, if `get_rubric` withheld a text, the agent can send the withheld value back unchanged at the same place. Sequential then keeps the text that the questions have at that place, and the agent never sees it. Sequential refuses a withheld value at a place that has no text, for example in a new question.

From 1 November 2026, the same applies to a text that `get_rubric` shows as `{"observed": …}`: sent back at the same place, it keeps the text that the questions have there, also when the agent changed the text in it. At a place that has no text, Sequential refuses it. To change a text, the agent writes the new text as a plain string.

From 9 November 2026, `get_rubric` also says: "An id or key can be sent back as shown or as a plain string."

A proposal card says what the proposal changes, one sentence per change. For example: "Adds “Invite sent”. The judge asks it of new sessions; past sessions are not judged again."

Proposal limits:

- A proposal ends after 14 days, or when someone changes the questions after the agent read them.
- If the questions changed since the agent read them, the card says "Written against version 3; the questions are now at version 4. Applying it may be refused."
- A new proposal from the same token replaces its open proposal.
- By default, each project gets at most 5 proposals a day and at most 10 tests on a session a day. From 29 October 2026, only a proposal that Sequential stores counts toward the 5. A refused proposal does not.
- When Sequential refuses a text in a proposal, it tells the agent where the text is in the questions, never the text itself. It also gives the reason and a hint, for example to write the text as what the visitor did or saw, not as a command. When only the texts of one question read together were refused, it names that question. A proposal with too many texts to check is refused with the number of texts and the limit. Then the agent can propose part of the change now and the rest later.
- From 29 October 2026, Sequential checks the new and changed texts of a proposal with a question made for questions. It asks if a text tries to make the judge, or an agent that reads it, do something other than judge the session on its evidence, for example ignore its rules, call tools or send data. The check knows that questions are written for the judge, and that labels are often short phrases such as Contact sales.
- Each test spends from the daily allowance of Try on a session.

### Keep your questions up to date with your product

This card on Questions gives you a prompt for your own agent. The agent reads your sessions and sends one proposal.

For the line on the card, only a connection that you made on the consent page counts. A project access token (`sq_pat_…`) does not count.

1. On the card, click **Copy prompt**.

   Result: Copy prompt always puts the whole prompt on the clipboard.

2. Paste it into your agent.

   Result: The proposal then shows under Proposed.

### What the card and the prompt say in each case

The card shows at all times, also after you change the questions. It does not show while you edit the questions. The line on the card depends on your role and on your own agent connections.

| Your case | What the card shows |
|---|---|
| You have a live agent connection with `insights:propose` and `sessions:explore`. | The card says "Your agent can read your sessions and suggest changes so that these questions continue to fit your product. Copy this prompt into it. Nothing changes until you apply a suggestion here." For a member, it ends "Nothing changes until an owner or admin applies a suggestion here." |
| You have no live agent connection. | The card tells you to connect your agent, then copy the prompt into it. On the consent page, select "Also: it proposes questions". Connect your agent to use this prompt opens the connect steps on Agents. The card also shows this line when Sequential cannot read your connections. |
| You have a live agent connection, but it does not have both permissions. | The card says what the connection cannot do, for example "its connection cannot propose questions". A connection keeps the permissions that it got when you connected it. Click Connect your agent again, and on the consent page select "Also: it proposes questions". Then disconnect the old connection on Agents. |
| You are a viewer. | A viewer's agent cannot send a proposal. A member, admin or owner can connect an agent that does. The card shows the prompt, but no Copy prompt. |
| The project does not take proposals. | The card says "Agent suggestions are not available in this project, so an agent cannot send one." It shows the prompt, but no Copy prompt. |
| A proposal waits. | The card stays. A line above it says "A suggestion waits above. Review it there; the prompt below is for the next one." |

Under the line, Prompt for your agent shows the first lines of the prompt. Show the whole prompt opens all of it, and Show less closes it again.

The prompt tells the agent to read the questions and your project's data, and to send one proposal with at most 3 changes. It tells the agent not to test the proposal on a session, because that test is paid, and not to apply anything. From 1 November 2026, the prompt starts with a line that names the open project by its slug, for example "Use the Sequential tools on the project "shop": pass project "shop" to every call that takes a project argument."

From 1 November 2026, when the organisation has more than one project that is not archived, a box above the prompt says "Ask for suggestions for every project in" and the name of the organisation. When you select it, the label is Prompt for your agent, all projects, and the prompt tells the agent to list the projects with `list_projects` and do steps 1 to 4 for each project, one at a time. The agent sends one proposal for each project and gives you every apply_url with its project. Each proposal shows on the Questions page of its own project. On a connection to one project, the agent says "This connection reaches one project only; connect again with All projects to cover the others" and goes on with that project.

## Calibration

To check a reading of the judge, answer Right or Wrong on the session page. Your answer does not judge the session again.

The section Calibration is under the questions on Questions. It shows one card per question that people checked ([Check the judge](/docs/feedback-and-calibration)). Each card shows how often people agree with the judge on that question, for example "People agreed with 41 of the 52 readings they checked (78.8%)."

## FAQ

### Which questions does Sequential ship?

The default questions are generic. For example, Outcome asks how the session ended, and Hit an error asks if an error stopped the user. Sequential ships these 12 questions. Four of them have a weight.

| Group | Question | Weight |
|---|---|---|
| What they came to do and how it ended | Intent | – |
| What they came to do and how it ended | Outcome | – |
| How hard it was | Friction | 0.25 |
| Signals | Rage clicks | – |
| Signals | Hit an error | 0.15 |
| Signals | Product bug | 0.15 |
| Signals | Form left unfinished | – |
| Signals | Went in circles | – |
| Signals | Worth watching | 0.45 |
| Moments | Where they struggled | – |
| Moments | What they came to do | – |
| Moments | Where they gave up | – |

The default weights add up to 1. So Worth watching counts for "45%" of the weight.

From 9 November 2026, the default questions are a new version. Only "Where they gave up" changed. The person gave up only when they abandon the task: they leave, or they stop after a struggle and do not come back to it. A pause after which the person goes on is not giving up. This applies to projects on the default questions. Sessions judged before keep their answers, and Sequential does not judge them again by itself. Their session page says "The questions changed since; this reading is from the earlier version." Checks of "Where they gave up" made before count under its earlier wording. Checks of the other questions keep their counts.

### How is the attention score computed?

Signals and scales can have an Attention weight (optional), from 0 to 1. Each judged session gets an attention score from these weights. A session with a score of 0.35 or more needs a look.

- For a signal, Sequential multiplies the weight by the chance of yes.
- For a scale, Sequential multiplies the weight by the level, divided by the number of levels minus 1. The top level adds the full weight. The lowest level adds nothing.
- Sequential adds the results of all questions that are on.

The help under the field says, for example, "A sure yes adds 0.45 to a session’s attention score; a 50/50 answer adds 0.225."

- Weights need not add up to 1. A card shows its weight as a share of all the weights that are on.
- A weight change re-ranks past sessions at once. Nothing is judged again.
- If the weights of the questions that are on add up to less than 0.35, a banner says that no session could need a look.

### What does a question that names its evidence look like?

The first shipped Hit an error question read: "Judging from `events`, does a software error stop the user from completing an action?"

That question did not tell the judge to read the error counts. The current wording adds "and the session's error counts (`js_errors`, `failed_requests`, `console_errors`; absent when not measured)". Now the question names its evidence, and says that a count can be absent.

### Which events does the judge drop from a long session?

- The judge reads at most 255 events per session. In a longer session, Sequential drops mobile gestures first, then plain clicks, then custom events, before any other kind. Errors and failed requests stay longest. Of each kind, the earlier events stay.
- Sequential drops a custom-event property before judging if a whole part of its key is a personal-looking word, such as `name` or `account`. These words are email, name, user, account, address, phone, card, token and similar. This includes ordinary keys such as `plan_name`, `step_name` or `account_type`. Use the event name, or a key that avoids those words.
- Put the fact that your question needs in the event name, such as `invite_sent` or `plan_change_started`.

[How the judge works](/docs/judgments) describes the digest.

### Earlier wordings and a clearer wording

From 8 November 2026, the card of a question on the Questions page can show more about its checks.

- Earlier wordings: each earlier wording of the question, with its text and its own result, for example "84% right · 25 checks". Under 20 checks, it says, for example, "7 checks, too few to rate". When Sequential no longer keeps the text, it says "An earlier wording. Its text is no longer kept."
- When people said Wrong 3 times or more on the current wording in the last 90 days, the card says, for example, "The judge was wrong 3 times on this question. Ask your agent for a clearer wording." With "Copy agent prompt", you copy a prompt that asks your agent to propose a clearer wording. When your agent cannot propose changes, owners and admins see "Change the question", and other roles see "An owner or admin changes questions."
- The card can also show "Why people said Wrong (4)": the reasons that people gave after Wrong, each with the answer of the judge and when, for example "“It missed the retry” · The judge said Buy · 3 days ago", and "Open the session". From 8 November 2026, each reason also names its writer, for example "— Mia", "— A member" when the writer chose no name, or "— A former member". Owners, admins and members see this list. Viewers do not.

### How does Calibration count checks?

On a session page, each reading of the judge has Right and Wrong. Press E for Right or X for Wrong on the reading that has the focus. A Calibration card says, for example, "People agreed with 41 of the 52 readings they checked (78.8%)."

- It counts the last 90 days. For each person, session and question, it counts only the latest answer of that person.
- When at least 5 checks fall where the judge was "70%" sure or more, the card says how often people agreed then.
- Until there are 20 checks in ranges with at least 5 checks each, the card says "Too few checks yet to say whether its confidence holds up." With more, it says if the judge is surer than it is right, right more often than it says, or about as often right as it says.
- In a card, As a table shows the checks per range of the judge's sureness.
- A card can also name the answer that people called wrong most often in the last 30 days.

Each wording keeps its own counts. From 7 November 2026, a save starts a new wording only for each question whose text, criteria, options or levels changed. The other questions keep their counts. Checks under an earlier wording show apart, for example "Under an earlier wording: 12 checks, 75% agreed. Kept apart from today’s." A change to a name, a weight, a summary line or the order keeps the counts.

## Limits

| Limit | Value |
|---|---|
| Sets of questions | One set of questions per project. You cannot copy the questions to another project. |
| Questions | At most 24 questions. Moments: at most 5. At least one question must stay on. A list has 2 to 30 answers, and a scale 2 to 7 levels. |
| Text | Name: at most 40 characters. The judge asks: at most 300 characters. Each criterion and each summary line: at most 200 characters. |
| Try on a session | At most 10 tries a minute per person, within a daily allowance of its own. |
| Proposals | A proposal ends after 14 days. A new proposal from the same token replaces its open proposal. By default, each project gets at most 5 proposals a day and at most 10 tests on a session a day. |
| Events the judge reads | At most 255 events per session ([which events it drops](#which-events-does-the-judge-drop-from-a-long-session)). |
| History | The last 20 versions. |

## Next steps

- [How the judge works](/docs/judgments): what the judge stores about each session.
- [Evidence](/docs/watch): open the sessions that need a look.
- [Check the judge](/docs/feedback-and-calibration): answer Right or Wrong on a reading, and read Calibration.
- [Send custom events](/docs/custom-events): name the moments that your questions ask about.
- [Audit log](/docs/audit-log): see each save, reset and restore of the questions.
