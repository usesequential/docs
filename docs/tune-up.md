# Tune-up

> Tune-up lists nine steps that tune the judge to your product, and shows the next step you can take.

Each step makes the judge fit your product better, or shows how far you can trust it.

## At a glance

| What | Tune-up |
|---|---|
| Levels | 4: "Default judge", "Your questions", "Calibrated" and "Tuned" |
| Tracks | 3: "Your questions", "Calibration" and "Agent and team" |
| Steps | 9. The ring counts the steps that are done, for example "Tune-up · 4 of 9" |
| Where to find it | The ring in the left rail, the Tune-up panel, the Brief card "Next in Tune-up", Settings › Recording & data, and the palette command "Tune-up: what next?" |
| Who can see it | Every role: owners, admins, members and viewers |
| Whose progress | One Tune-up for each project. Your whole team shares it |
| Which checks count | The checks of the last 90 days |

## The nine steps

| Step | Track | What you do | Done when | Who can do it |
|---|---|---|---|---|
| "The judge reads your sessions" | Your questions | Nothing. The judge reads each session after it ends | The judge has read at least one session of the project | Nobody: the judge does it |
| "Put one question in your words" | Your questions | Change the wording of one built-in question: "Change a question" | A built-in question that is on has your own wording | Owners and admins. A member can click "Propose a change" |
| "Add a question only your product has" | Your questions | Add a question of your own: "Add a question". Owners and admins can also click "Add starter questions" | One of your own questions is on | Owners and admins. A member can click "Propose a question" |
| "Check the judge on 5 sessions" | Calibration | Answer "Was the judge right?" on 5 sessions: "Check 5 sessions" | People's checks cover 5 or more different sessions in the last 90 days | Every role |
| "Calibrate one question" | Calibration | Check more sessions until one question has 20 checks: "Check 5 sessions" | A question that is on says "Calibrated" for its current wording | Every role |
| "Change a weak question, then check it again" | Calibration | Change a weak question: "Open the weakest question". Then check its new wording on 5 sessions | Your team changed the wording of a question. Its earlier wording has 5 or more checks, and its current wording has 5 or more checks | Owners and admins change the question. A member can click "Propose a change". Then every role can check it |
| "Connect your agent with review" | Agent and team | Connect an agent that can review sessions: "Connect your agent" | A live agent connection can review sessions of the project | Owners, admins and members |
| "Let your agent check 20 sessions" | Agent and team | Give your agent the check prompt: "Copy agent prompt" | Agent checks cover 20 different sessions in the last 90 days | Owners, admins and members |
| "A teammate checks 5 sessions" | Agent and team | Invite a teammate: "Invite people" | 2 people each checked 5 or more different sessions in the last 90 days | Every role |

Your next step is the first step in this table that is not done and that you can do. Everyone in the project sees the same steps as done. The buttons change with your role. For checks, see [Check the judge and read Calibration](/docs/feedback-and-calibration).

### What counts for each step

- Sequential reads where the project stands each time. It keeps no progress on the server. So a step that was done can be not done again, for example when its checks become older than 90 days.
- The judge step counts a session that the judge read at any time.
- The question steps count only questions that are on. A change to the Name or the Attention weight (optional) of a question is not a new wording.
- "Check the judge on 5 sessions" and "A teammate checks 5 sessions" count people's checks under any wording. Checks in Ask do not count. An agent's checks do not count.
- "Calibrate one question": a question says "Calibrated" when its current wording has 20 or more checks, and the judge is not surer than it turns out to be right. Sequential compares the stated likelihood of the judge's answers with how often people agreed.
- "Change a weak question, then check it again" counts only a change that someone in your project made. A new built-in wording from Sequential does not count.
- "Connect your agent with review" needs a live connection that reaches the project and that can review sessions.
- "Let your agent check 20 sessions" counts only agent checks. The panel says: "Agent checks count only for “Let your agent check 20 sessions”."

## Levels

Tune-up has four levels. The panel shows the highest level that is on, for example "Level 3 · Calibrated". When no level is on, it says "No level yet".

### The level rules

| Level | Name | It comes on when |
|---|---|---|
| 1 | "Default judge" | Step 1 is done |
| 2 | "Your questions" | Steps 2 and 3 are done |
| 3 | "Calibrated" | Steps 4 and 5 are done |
| 4 | "Tuned" | Steps 6 and 7 are done, and level 3 is on |

- Levels 1, 2 and 3 do not depend on each other. For example, level 3 can be on while level 2 is off.
- Level 4 needs level 3.
- Steps 8 and 9 are in no level.
- When a new level comes on, a green message says, for example, "Tune-up: level 3, Calibrated."
- Each browser shows the message for a level one time only. The first time that a browser reads Tune-up for a project, it says nothing.
- A level that goes off and comes on again is not said again.
- While Tune-up is hidden, or the browser blocks site data, no level message shows.

## Where you find Tune-up

- The ring in the left rail. Click it to open the Tune-up panel.
- The card "Next in Tune-up" on the Brief.
- The section "Tune-up" in Settings › Recording & data.
- The command "Tune-up: what next?" in [Ask or jump (⌘K)](/docs/search-or-jump-to).

### The ring's words

- The ring is at the foot of the left rail, under Help. It shows when a project is open.
- Its green arc shows the steps that are done, out of 9. The label says, for example, "Tune-up · 4 of 9". A screen reader says "Tune-up, 4 of 9 steps".
- The ring has no dot, no badge and no motion. It changes only when a step changes.
- When Sequential cannot read Tune-up, the ring shows no number. A screen reader says "Tune-up, cannot be read now".
- While the trial's terms are not accepted, a screen reader says "Tune-up, waits for the trial terms".
- At 9 of 9, the ring leaves the rail. Tune-up stays in Settings.
- Sequential reads Tune-up again when you open another project, when you open the panel and when you open the Settings section. It also reads again when the trial's terms are accepted.

### The Tune-up panel

- The panel opens only when you click the ring, a link or the palette command. It never opens by itself.
- At the top, four bars show the levels, and a line names the level, for example "Level 3 · Calibrated".
- Under them are the three tracks. The panel opens at your next step.
- Each step shows why it helps, its progress, who can do it if you cannot, and one main button. For example: "3 of 5 sessions checked.", "Goal: 7 of 20 checks.", "4 of 20 sessions checked by your agent.", "1 of 2 people checked 5 sessions."
- For owners, admins and members, a step that changes a question also has "Copy agent prompt": the prompt that asks your agent to propose the change.
- "Change a question" and "Add a question" open the question editor on Questions. "Open the weakest question" shows the question where the judge is surer than right with the most checks. If there is none, it shows the question with the lowest agreement rate, of those with 5 or more checks.
- "Invite people" opens the invite dialog. The dialog says when your organisation does not let you invite.
- "Check 5 sessions" opens the first of up to 5 sessions from this week that you did not check. If there is none, it says "No session to check this week: you have checked every one the judge read." In the queue, [Call it first](/docs/feedback-and-calibration#call-it-first) can ask you one question before the judge's reading shows.
- When a question has a new wording with fewer than 5 checks, the Calibration track says, for example, "Goal has a new wording. Its earlier wording had 8 checks."
- The foot says, for example, "Counts since 9 Aug. Agent checks count only for “Let your agent check 20 sessions”." The date is the start of the 90 days, or a later day if Sequential keeps checks only from that day. If Sequential cannot tell the day, the line has no date.
- The foot also has a link to [Check the judge and read Calibration](/docs/feedback-and-calibration) and the button "Hide Tune-up".
- Press Escape, click the close button, click outside the panel or go to another page to close it.

### The Brief card: Next in Tune-up

The Brief can show the card "Next in Tune-up". It is in the place of the setup checklist.

- It shows one step: your next step, with why it helps, its progress and one main button.
- Where your agent can help, it also has "Ask your agent".
- It shows only when all of these are true: the setup checklist does not show, the project has data, Tune-up is below level 4, Tune-up is not hidden, the card is not hidden, and there is a step that you can do.
- "Hide" on the card hides the card in this browser. The ring stays.

### The Settings section

- Settings › Recording & data has the section "Tune-up". It has the same levels and steps as the panel, but no "Hide Tune-up".
- It stays when the ring has left the rail: at 9 of 9, or after "Hide Tune-up".
- At 9 of 9, it says "All 9 steps are done."
- After "Hide Tune-up", it says "Tune-up is hidden in this browser." Click "Show Tune-up in the menu" to show the ring again.
- It reads Tune-up again each time it opens.
- In Ask or jump (⌘K), the words "tune-up" and "level" find Recording & data.

### The palette command

- When a project is open, Ask or jump (⌘K) has the command "Tune-up: what next?" under Commands.
- It opens the Tune-up panel at your next step.
- Words such as "tune up", "calibration", "level" or "next step" find it.

## Hide Tune-up

"Hide Tune-up", at the foot of the panel, hides the ring and the Brief card in this browser, for this project.

### What the two Hide buttons do

- "Hide Tune-up" closes the panel and hides the ring and the Brief card. Level messages stop too.
- To undo it, open Settings › Recording & data and click "Show Tune-up in the menu".
- "Hide" on the Brief card hides only the card. The ring stays. No button shows the card again.
- Both buttons work per browser and per project. Your teammates and your other browsers still see Tune-up. Sequential keeps these choices only in the browser.
- When the browser blocks site data, it cannot keep the choice, and Tune-up shows again.

## When Tune-up cannot be read

Sequential never shows a guessed state. If it cannot read Tune-up, it says so.

### What "cannot be read now" means

- Sequential asks the server for where the project stands. If that request fails, the panel and the Settings section show no steps. They say "Tune-up cannot be read now. Try again." Click "Try again".
- The request fails, for example, when the network fails, when too many requests arrive or when the server has an error.
- The ring then shows no number, and Sequential keeps no earlier answer.
- While a trial's terms are not accepted, Sequential does not ask. The panel says "This trial’s data stays closed until its terms are accepted."

#### Messages of Tune-up

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Tune-up cannot be read now. Try again." | The panel and the Settings section | Sequential cannot read where the project stands now. | Click "Try again". |
| "This trial’s data stays closed until its terms are accepted." | The panel and the Settings section | The trial's terms are not accepted. Sequential does not read Tune-up. | — |
| "Tune-up: level 3, Calibrated." | A green message, when a new level comes on | An example. Each browser shows the message for a level one time only. | — |
| "Goal has a new wording. Its earlier wording had 8 checks." | The Calibration track of the panel | An example. The question has a new wording with fewer than 5 checks. | — |
| "Tune-up is hidden in this browser." | The Settings section | Someone clicked "Hide Tune-up" in this browser. | Click "Show Tune-up in the menu". |
| "All 9 steps are done." | The Settings section | All 9 steps are done. The ring is no longer in the rail. | — |

## Next steps

- [Check the judge and read Calibration](/docs/feedback-and-calibration): give checks and read how often people agree with the judge.
- [Questions](/docs/rubric): change a question or add one.
- [Roles and permissions](/docs/roles-and-permissions): what each role can do.
- [Sign-up and invitations](/docs/sign-up-and-invitations): invite a teammate.
