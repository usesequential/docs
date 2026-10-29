# Ask: one line about sessions, funnels, retention or people

> Ask a question in one line. Ask answers with a funnel, a retention curve, a person or the sessions whose events show a behaviour. For a behaviour, it ranks the sessions, the surest matches first.

> **In short**
>
> - Type one line. Ask reads it as a funnel, a retention question, a person or a description of sessions.
> - For a description, the judge finds the sessions whose events show that behaviour.
> - Ask lists the surest matches first. If the judge picks an event, the card also shows that moment. A click opens the session at that moment.
> - A description finds sessions. It does not count them. To count, type a funnel.
> - Ask lists only likely matches. A short or empty list does not mean that nothing like it happened.
> - In the app, Ask has its own daily allowance per project. Background judging does not use it.
> - An agent can also run Ask, with its own daily allowance. See **Ask from an agent**, below.

## What it is for

**Ask** takes one line. A line that describes a behaviour goes to the judge. The judge finds the sessions whose events look like it. That answer finds sessions. It does not count them. For "how many", type a funnel line, or use [Funnels](/docs/funnels).

## What a line can ask

| You type | Ask reads it as | The answer |
|---|---|---|
| Steps with arrows, such as `Signed Up → Workspace Created` | A funnel | How many people reached the first step and went on to the last, in the last 7 days |
| Words such as "retention", "churn" or "come back", such as "do people come back" | Retention | How many of the people who first came in the last 8 weeks came back on day 1, 7, 14 and 28 |
| An email, or "find" or "who is" and a name, such as "find Amara" | A person | Up to 8 people whose name, email or account matches, seen in the last 7 days |
| Anything else, 3–200 characters | A description of sessions | The sessions of the last 7 days whose events show it |

Under the box, Ask says how it reads your line before you press Enter. With nothing typed, it says "Steps with arrows make a funnel, a name or an email finds a person, anything else the judge reads sessions for."

## How it works

For a description:

1. **Ask picks candidates**: up to the 2,000 most recently active sessions in the last 7 days.
2. **Ask orders them.** If background judging is on, the sessions that [Evidence](/docs/watch) ranks highest come first.
3. **The judge reads one page of up to 200 sessions.**
4. **Ask lists only likely matches**, strongest first. Ask does not show the sessions that the judge rated below its cut-off.

> **Your question goes to a third party**
>
> Sequential sends the event summaries and your question to the third party that runs the judge. Keep customers' names and emails out of your question. Sequential shortens long text but does not scan it for personal data. So Sequential sends an id in a path, such as /users/123, unchanged. It also sends an email in a button or error message unchanged. Funnel, retention and person lines do not go to the judge. See [AI and third parties](/docs/ai-and-third-parties).

## How to use it

1. Click **Ask** in the left rail, or press G, then A.
2. Type one line into the box. See **What a line can ask**, above.
3. Read the line under the box. It says how Ask reads your line.
4. Press Enter or click **Ask**. For a description, the answer says "Reading N sessions…" or "Reading this week’s sessions…" while the judge reads. This can take up to a minute.
5. Click a session card. The session opens beside the list, at its moment.

Each answer stays in the thread while the tab is open. To see an answer again later, click **Keep on board**. **Ask again** runs the line again.

To write a good question, see **Example questions**, below.

## What a result shows

- **The headline**: for example "3 of 200 sessions match, 2 more were close." It tells you how many sessions the judge read. Check it before you trust an empty or short list.
- **The order**: first the matches that the judge rated at least 70 % likely. Under **Less certain** come the matches from 40 % to 70 %. A match is the judge's confidence that the session shows what you described. It is not how similar the session is.
- **The moment**: if the judge picked an event, the card shows its name, then "at" and the time. Click the card to open the session at that moment.
- **Near misses**: for example ", 2 more were close" in the headline. The judge read these sessions, but their match was below the cut-off. Ask does not list them.
- **Too short to judge**: for example "2 sessions were too short to judge." or "1 session was too short to judge." The judge did not read these sessions.
- The two counts show only when they are above 0. So an empty list with "more were close" means that the judge read sessions and none matched well enough.
- **Not every session read**: when the last 7 days have more candidates than one page, a note under the headline gives N, the sessions that the judge read, and M, the candidates. The judge reads the sessions that Ask put first: with background judging on, the ones that Evidence ranks highest, then the newest.
- **A saved answer**: the answer says "Answered from the judge’s earlier reading."
- Ask shows 6 cards at first. Click **Show all** and the number to see the rest.

## If you get no results

| You see | What it means |
|---|---|
| "None of N sessions match." | The judge rated no searched session likely enough to show. This is not proof that nothing like it happened. Check the headline. Then try other words. |
| "There was no session to read in the last 7 days." | The judge read no session. No session of the last 7 days had enough events to judge. |
| "The judge has used today's reading budget for this project. It resets …" | The project's daily **Ask** allowance is used up, or this run would go over it. It resets at midnight UTC. |

For other messages, see **Other messages**, below.

## What it needs

- **Session ids** and **readable events** ([Sessions](/docs/sessions), [Events](/docs/events)). A click with no text and no id reads as "element". That gives the judge nothing to match.
- **A recording** to watch a matched session ([Session replay (web)](/docs/session-replay), [Mobile apps](/docs/mobile)).
- **Judging set up on your Sequential server.** Background judging for the project is optional. Funnel, retention and person lines work without judging.
- **Any project role.** Viewers can also run Ask ([Roles and permissions](/docs/roles-and-permissions)).

## Limits

- **In the app, Ask has its own daily allowance.** The default is 2,000,000 input tokens per project per UTC day. For a new organisation, in its first 30 days, it is 200,000. Ask and background judging do not use each other's allowance. The app does not show the limit. See [Daily allowances](/docs/limits#daily-allowances).
- **A description reads only the last 7 days.** Ask has no date range and no filters.
- **Sequential trims long sessions to 255 events.**
- **A session can open at a slightly different moment.** The moment counts time from the session's first event, not from the start of the recording.
- **Sequential logs questions.** It keeps each question, who asked and its counts for 180 days. For an agent, who asked is the id of its token.
- **Ask keeps answers only while the tab is open.** **Keep on board** keeps one on your Board.
- **An Ask link runs Ask when someone opens it.** Unless a saved answer matches, each opening uses the project's **Ask** allowance.
- **An answer on your Board runs again each time you open the Board.** Unless a saved answer matches, each run of a description uses the project's **Ask** allowance.

### Example questions

Filters find sessions by facts you can name. Some behaviour has no single event to filter on. Ask is for that behaviour.

Describe what happened, in order. Use the words that your events use: button text, page paths such as /settings/billing, and custom event names such as `plan_changed`.

Examples of behaviour that Ask can find:

- "Opened billing settings, started changing the plan and left without saving."
- "Clicked Send invite several times and nothing happened."
- "Hit an error at checkout, then opened the help widget."

| Instead of | Try |
|---|---|
| "Frustrated users" | "Clicked Save on the billing page again and again" |
| "Read the pricing page carefully" | "Went back to the pricing page twice before upgrading" |
| "How many people abandoned checkout?" | A funnel line, such as `/cart → /checkout` |

### Funnel, retention and person lines

- **Funnel**: put arrows (→ or ->) between the steps. "funnel A, B, C" also works. A step that starts with "/" is a page. Any other step is an event name. A funnel has at most 10 steps.
- If fewer than 20 people reached the first step in the last 7 days, Ask also reads the last 30 days. It shows the 30 days when they have more people at the first step.
- If your app sent no event with the name of a step, the answer says "Your app sent no event called …". It can also ask "Did you mean …?" with the closest name.
- **Retention**: name the days in the line, for example "retention on day 3 and day 30". Without days, Ask uses day 1, 7, 14 and 28.
- **Person**: people search reads names, emails and accounts. If it finds nobody, click **Ask the judge about “…” instead** to send the line to the judge.
- **Open in Workbench** opens a funnel or a retention answer in the Workbench. A funnel opens with the days of the answer. When the answer left your team out, **Leave out people marked as your team** is on there too. **Open these sessions in the Workbench** lists the sessions where every step of a funnel happened, in any order.
- When **Hide our team** is on, on **Evidence** or **People**, a description and a funnel leave your team's sessions out. A funnel answer then says how many people it left out, with the same line as Workbench › **Funnels**, for example "Leaves out 3 people marked as your team who did step 1."

### How Ask picks and judges sessions

- A candidate has a session id and at least 3 events in the last 7 days. Ask takes up to the 2,000 most recently active sessions.
- If background judging is on for your project, the sessions that Evidence ranks highest come first. The rest follow, newest first.
- A page holds up to 200 sessions.
- The judge gives two answers for each session: how likely the session shows what you described, and which event shows it best. It writes no summaries or explanations.
- For each session, the judge reads a summary of the events. The **What the judge reads** block lists what the judge gets.
- Sequential trims long sessions to 255 events. It keeps errors, rage clicks, dead clicks, form submits and page views ahead of custom events and ordinary clicks.
- Ask reads events, so it also finds sessions without a recording.

### What the judge reads

The judge reads the same event summary that background judging uses ([Judgments](/docs/judgments)):

- page paths, without domains or query strings
- click text
- form names
- error messages
- custom event names, and properties whose keys do not look personal
- session facts: duration, device, browser, OS, country, entry page, page count, whether the user was identified, and any DevTools error counts

Sequential does not send the session's user id.

### Result details

- Each card shows who it was, when the session started and how long it was.
- The sentence on the card says what the background judgment of the session found. A session without one says "Not judged yet."
- If you cannot play the recording now, the card says why in place of the moment: "Recording not ready yet", "Recording expired", "No playable recording" or "No recording".
- "No playable recording" means that Sequential never received the full recording.
- A click opens the session beside the list, at its moment. Under **Why you are seeing this**, it can show your question.
- Ask reads the recording state of each result when it answers. To see a newer state, click **Ask again**.
- If the judge picked no event, the card can show the moment of the background judgment instead.
- Under each card, "A match for your question?" has **Right** and **Wrong**, as two small buttons. Your click says whether the session matches your question. Each button says what it does when you point at it, for example "Right: saved as your feedback on this match. It counts in your own score, not in how often people agree with the judge." The note beside them then says "Saved" or "Not saved".
- Sequential stores your click with the first 200 characters of your question, for about 400 days. It does not count in **How often people agree with the judge** ([Feedback and calibration](/docs/feedback-and-calibration)).

### What the headline numbers mean

- In "3 of 200 sessions match", 200 is the number of sessions that the judge judged. Ask skips sessions with fewer than 3 readable events.
- In the note that gives N of M sessions in the last 7 days, M is the number of candidates. If M is 2,000, Ask may have left out older sessions of the last 7 days.
- "Some sessions could not be read, so the answer may miss a few." means that part of the page failed.

With background judging on, the page favours the sessions that Evidence ranks highest. So an ordinary behaviour, such as a smooth first purchase, can be missing from the answer.

### When part of a page fails

- Sequential does not save an answer when part of the page failed. If you run the same question again, the judge judges the whole page again.
- **Ask again** runs the line again from the first page.

### Other messages

| You see | What it means |
|---|---|
| "The judge is not set up on this server, so it cannot read sessions." | Judging is not configured on your Sequential server. No setting in the app changes that. Ask the person who runs the server. The server answers 503 `ask_unavailable`. A funnel line, or a person's name or email, works without the judge. |
| "The judge is not available right now. Try again in a minute." | Sequential cannot read the **Ask** allowance for a moment. The server answers 503 `budget_unavailable`. Nothing was spent. Click **Try again**. If it fails again, wait 30 seconds. |
| "The judge could not finish reading. Try again." | Judging failed. **Try again** starts again from the first page and replaces the results. |

### Allowance and saved answers

- **Ask** in the app has its own allowance: 2,000,000 input tokens per project per UTC day by default. Background judging, **Try it** on the **Questions** page and **Ask** from an agent each have a separate one.
- Your Sequential server sets the allowance, with `ASK_DAILY_TOKENS`.
- If Sequential cannot read the allowance, it does not run Ask and spends nothing. The server answers 503 `budget_unavailable` with `Retry-After: 30`. A saved answer still returns.
- The allowance resets at midnight UTC. The "It resets …" message shows the time in your local time.
- Sequential saves an answer for one hour, unless part of the page failed. The same question over the same sessions returns the saved answer. It does not judge again or use the allowance.

### When Ask uses a saved answer

- **Ask again** returns the saved answer only if the judge judged the whole first page within the hour and the same sessions are still first in line.
- Ask ignores double quotes, backticks and extra spaces in the question.
- Ask does not ignore apostrophes and capitals. A question that differs only in these is a new question.
- If new sessions change the page, Ask does a new run.

### Readable events

Readable events are clicks with text or an id, page views with a path or screen name, errors with their message, and named custom events ([Events](/docs/events), [Send custom events](/docs/custom-events)).

### Share a search link

- A link to `/ask?q=` and your line asks that line when someone opens it. For example: `/ask?q=who+gave+up+at+checkout`.
- Then Ask removes the question from the page address, so Back does not ask again.
- The link carries only the question. The recipient's selected project applies.
- Unless a saved answer matches, a description in the link starts a new run on the allowance.

## Ask from an agent

An agent can run **Ask** with the tool `ask_sessions`, through MCP or with POST `/api/agent/ask_sessions`. The agent needs a project access token with the scope `ask:use`. Owners and admins can tick **asks the judge** (`ask:use`) under Settings › Agents & tokens, in **Make a token**. The presets **Read cases**, **Fix loop agent** and **Release bot** do not include it. The token that onboarding makes for your agent includes it. When you connect an agent by signing in, **Read and investigate** includes it, and **Without Ask, so it spends no AI budget** leaves it out. See [Connect your agent](/docs/quickstart#connect-your-agent).

- **Arguments.** `query`: your description, 3–200 characters. `days`: the last 1–30 days, default 7. `limit`: 1–50 sessions per call, default 25. `cursor`: the `next_cursor` of an earlier call with the same `query` and `days`.
- **No filters.** The agent cannot apply filters. Ask picks and orders the candidates as in the app.
- **Its own allowance.** An agent spends the agent allowance of the project: 2,000,000 input tokens per UTC day by default. Each token can spend at most 500,000 of it per UTC day. Background judging and **Ask** in the app do not use this allowance. See [Limits](/docs/limits#ask-from-an-agent).
- **Read-only does not stop the spend.** The endpoint `/mcp/readonly` lists `ask_sessions`. MCP clients also see `ask_sessions` marked as read-only (`readOnlyHint`), because it changes no data. A client that approves read-only tools on its own can call it, and spend, without asking you. To stop an agent from running **Ask** and spending the agent allowance, give it a token without `ask:use`. Other agent tools still spend the screening allowance.
- **Screening.** The label of a matched moment is visitor text, so Sequential screens it before the agent gets it. Session and user ids come marked. See [Privacy at a glance](/docs/privacy-overview).

### What the agent gets

| Field | What it means |
|---|---|
| `searched` | The number of sessions that the judge judged in this call |
| `in_range` | The number of candidates in the window, up to 2,000 |
| `near_misses` | Sessions that the judge judged and rated close, but below the cut-off. Ask does not show them |
| `not_judgeable` | Sessions that are too short to judge. The judge did not read them |
| `stopped`, `stop_reason` | `stopped` is `"budget"` when a spend limit, or a failure to read the limits, stopped the call before the end of the page. `stop_reason` says which: `budget_exhausted`, `token_daily_limit` or `ai_unavailable` |
| `next_cursor` | A position in the candidate list. Sequential builds the list again on each call, so a later call can skip or repeat some sessions, most of all after new sessions arrive or are judged |
| `partial` | `true` when some sessions failed at the judge |
| `results` | The matches, strongest first |

- An empty `results` with `near_misses` above 0 means that the judge read sessions and none matched.
- A near miss has a match of at least 0.2 and less than 0.4.
- After a stop, Sequential did not check the rest of the page. Call again with `next_cursor`. For `budget_exhausted` or `token_daily_limit`, call after midnight UTC. For `ai_unavailable`, call again in a minute.
- A cursor used hours later, for example after midnight UTC, continues in a list that has changed. Some sessions can be skipped or come again.
- Each result has `session_id`, `user_id`, `session_start`, `match` (0–1), `state` (`on` or `unclear`), `moment`, the session's judgment in `beliefs`, and `replay_url`.
- `replay_url` and the `url` of a moment name the project, so they open that project. See [Links that open a project](/docs/sessions-and-replay#links-that-open-a-project).
- The app shows the same two counts with its answer. See [What a result shows](#what-a-result-shows).
- For each refusal, see [Troubleshooting](/docs/troubleshooting).

## Related

- [Evidence: the sessions worth a look](/docs/watch)
- [AI judgments of sessions](/docs/judgments)
- [Reading an AI verdict](/docs/reading-verdicts)
- [Ask or jump (⌘K)](/docs/search-or-jump-to)
- [Filters, date ranges and saved views](/docs/filters-and-saved-views)
- [Limits and defaults](/docs/limits#ask)
