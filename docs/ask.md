# Ask: one line about sessions, funnels, retention or people

> Ask a question in one line. Ask answers with a funnel, a retention curve, a person or the sessions whose events show a behaviour.

> **At a glance**
>
> - **Who can:** [Any project role](/docs/roles-and-permissions). Viewers can also run Ask. An agent needs the scope `ask:use` ([Ask from an agent](#ask-from-an-agent)).
> - **Before you start:** Session ids, [readable events](#what-it-needs) and, to watch a match, a recording. For a description, judging set up on your Sequential server.
> - **You get:** For a description: the likely matches among up to 200 sessions of the last 7 days that the judge reads, surest first.
> - **Know this:** A description finds sessions. It does not count them. For "how many", type a funnel line, or use [Funnels](/docs/funnels).
> - **Know this:** A short or empty list does not mean that nothing like it happened. Check the headline first.

> **Key facts**
>
> - For a description, your question and the event summaries go to [the third party that runs the judge](#your-question-goes-to-a-third-party). Funnel, retention and person lines do not.
> - In the app, Ask has its own daily allowance per project. Unless a saved answer matches, each description uses it.
> - Ask links and answers on your Board run again when opened. Read-only does not stop [an agent's spend](#ask-from-an-agent).

## What a line can ask

Type one line.

| You type | Ask reads it as | The answer |
|---|---|---|
| Steps with arrows (→ or ->), such as `Signed Up → Workspace Created` | A funnel | How many people reached the first step and went on to the last, in the last 7 days |
| Words such as "retention", "churn" or "come back", such as "do people come back" | Retention | How many of the people who first came in the last 8 weeks came back on day 1, 7, 14 and 28 |
| An email, or "find" or "who is" and a name, such as "find Amara" | A person | Up to 8 people whose name, email or account matches, seen in the last 7 days |
| Anything else, 3–200 characters | A description of sessions | The sessions of the last 7 days whose events show it |

Under the box, Ask says how it reads your line before you press Enter. With nothing typed, it says "Steps with arrows make a funnel, a name or an email finds a person, anything else the judge reads sessions for."

- Funnel: put arrows (→ or ->) between the steps. "funnel A, B, C" also works. A step that starts with "/" is a page. Any other step is an event name. A funnel has at most 10 steps.
- Retention: name the days in the line, for example "retention on day 3 and day 30". Without days, Ask uses day 1, 7, 14 and 28.

### Funnel, retention and person lines

- If fewer than 20 people reached the first step in the last 7 days, Ask also reads the last 30 days. It shows the 30 days when they have more people at the first step.
- If your app sent no event with the name of a step, the answer says "Your app sent no event called …". It can also ask "Did you mean …?" with the closest name.
- Person: people search reads names, emails and accounts. If it finds nobody, click Ask the judge about “…” instead to send the line to the judge.
- Open in Workbench opens a funnel or a retention answer in the Workbench. A funnel opens with the days of the answer. When the answer left your team out, "Leave out people marked as your team" is on there too. Open these sessions in the Workbench lists the sessions where every step of a funnel happened, in any order.
- When Hide our team is on, on Evidence or People, a description and a funnel leave your team's sessions out. A funnel answer then says how many people it left out, with the same line as Workbench › Funnels, for example "Leaves out 3 people marked as your team who did step 1."

## Your question goes to a third party

> **Important**
>
> Sequential sends the event summaries and your question to the third party that runs the judge. Keep customers' names and emails out of your question. Sequential shortens long text but does not scan it for personal data. So Sequential sends an id in a path, such as /users/123, unchanged. It also sends an email in a button or error message unchanged. Funnel, retention and person lines do not go to the judge. See [AI and third parties](/docs/ai-and-third-parties).

## How to use it

1. Click **Ask** in the left rail, or press G, then A.

2. Type one line into the box.

3. Read the line under the box.

   Result: It says how Ask reads your line.

4. Press Enter or click **Ask**.

   Result: For a description, the answer says "Reading N sessions…" or "Reading this week’s sessions…" while the judge reads. This can take up to a minute.

5. Click a session card.

   Result: The session opens beside the list, at its moment.

Each answer stays in the thread. Ask keeps answers only while the tab is open. To see an answer again later, click Keep on board: it keeps the answer on your Board. Ask again runs the line again.

### What it needs

- Session ids and readable events ([Sessions](/docs/sessions), [Events](/docs/events)). A click with no text and no id reads as "element". That gives the judge nothing to match.
- A recording to watch a matched session ([Session replay (web)](/docs/session-replay), [Mobile apps](/docs/mobile)).
- Judging set up on your Sequential server. Background judging for the project is optional. Funnel, retention and person lines work without judging. If judging is not configured on your Sequential server, the server answers 503 `ask_unavailable`.

Readable events are clicks with text or an id, page views with a path or screen name, errors with their message, and named custom events ([Events](/docs/events), [Send custom events](/docs/custom-events)).

### Share a search link

A link to `/ask?q=` and your line asks that line when someone opens it. For example: `/ask?q=who+gave+up+at+checkout`.

- Then Ask removes the question from the page address, so Back does not ask again.
- The link carries only the question. The recipient's selected project applies.
- Unless a saved answer matches, a description in the link starts a new run on the allowance.

## Write a good description

Filters find sessions by facts you can name. Some behaviour has no single event to filter on. Ask is for that behaviour. Describe what happened, in order.

| Instead of | Try |
|---|---|
| "Frustrated users" | "Clicked Save on the billing page again and again" |
| "Read the pricing page carefully" | "Went back to the pricing page twice before upgrading" |
| "How many people abandoned checkout?" | A funnel line, such as `/cart → /checkout` |

### Example questions

Use the words that your events use: button text, page paths such as /settings/billing, and custom event names such as `plan_changed`.

Examples of behaviour that Ask can find:

- "Opened billing settings, started changing the plan and left without saving."
- "Clicked Send invite several times and nothing happened."
- "Hit an error at checkout, then opened the help widget."

## What a result shows

| You see | What it tells you |
|---|---|
| The headline, for example "3 of 200 sessions match, 2 more were close." | How many sessions the judge read. Check it before you trust an empty or short list. |
| A match | The judge's confidence that the session shows what you described. It is not how similar the session is. |
| The first cards | The matches that the judge rated at least 70 % likely |
| Less certain | The matches from 40 % to 70 %. Below 40 %, the cut-off, Ask lists no session. |
| The moment: the event name, then "at" and the time | The event that the judge picked. Click the card to open the session at that moment. |
| "Answered from the judge’s earlier reading." | A saved answer |
| Show all and the number | Ask shows 6 cards at first. Click it to see the rest. |

The near-miss and too-short counts show only when they are above 0. So an empty list with "more were close" means that the judge read sessions and none matched well enough.

### What a session card shows

- Each card shows who it was, when the session started and how long it was.
- The sentence on the card says what the background judgment of the session found. A session without one says "Not judged yet."
- If you cannot play the recording now, the card says why in place of the moment: "Recording not ready yet", "Recording expired", "No playable recording" or "No recording".
- "No playable recording" means that Sequential never received the full recording.
- A click opens the session beside the list, at its moment. Under "Why you are seeing this", it can show your question.
- A session can open at a slightly different moment. The moment counts time from the session's first event, not from the start of the recording.
- Ask reads the recording state of each result when it answers. To see a newer state, click Ask again.
- If the judge picked no event, the card can show the moment of the background judgment instead.
- Under each card, "A match for your question?" has Right and Wrong, as two small buttons. Your click says whether the session matches your question. Each button says what it does when you point at it, for example "Right: saved as your feedback on this match. It counts in your own score, not in how often people agree with the judge." The note beside them then says "Saved" or "Not saved".
- Sequential stores your click with the first 200 characters of your question, for about 400 days. It does not count in Calibration ([Check the judge and read Calibration](/docs/feedback-and-calibration)).

### How Ask picks and judges sessions

For a description:

1. Ask picks candidates: up to the 2,000 most recently active sessions in the last 7 days.
2. Ask orders them. If background judging is on, the sessions that [Evidence](/docs/watch) ranks highest come first.
3. The judge reads one batch of up to 200 sessions.
4. Ask lists only likely matches, strongest first. Ask does not show the sessions that the judge rated below its cut-off.

In detail:

- A candidate has a session id and at least 3 events in the last 7 days. Ask takes up to the 2,000 most recently active sessions.
- If background judging is on for your project, the sessions that Evidence ranks highest come first. The rest follow, newest first.
- A batch holds up to 200 sessions.
- The judge gives two answers for each session: how likely the session shows what you described, and which event shows it best. It writes no summaries or explanations.
- Ask reads events, so it also finds sessions without a recording.

What the headline numbers mean:

- In "3 of 200 sessions match", 200 is the number of sessions that the judge judged. Ask skips sessions with fewer than 3 readable events.
- Near misses, for example ", 2 more were close" in the headline: the judge read these sessions, but their match was below the cut-off: at least 20 % and less than 40 % (0.2 to 0.4). The headline counts them. Ask does not list them.
- Too short to judge, for example "2 sessions were too short to judge." or "1 session was too short to judge.": the judge did not read these sessions.
- Not every session read: a note under the headline gives N of M sessions in the last 7 days. It shows when the last 7 days have more candidates than one batch of up to 200 sessions. N is the sessions that the judge read, M the number of candidates. If M is 2,000, Ask may have left out older sessions of the last 7 days.
- The judge reads the sessions that Ask put first: with background judging on, the ones that Evidence ranks highest, then the newest.
- "Some sessions could not be read, so the answer may miss a few." means that part of the batch failed.

With background judging on, the batch favours the sessions that Evidence ranks highest. So an ordinary behaviour, such as a smooth first purchase, can be missing from the answer.

When part of a batch fails:

- Sequential does not save an answer when part of the batch failed. If you run the same question again, the judge judges the whole batch again.
- Ask again runs the line again from the first batch.

What the judge reads: for each session, a summary of the events. It is the same event summary that background judging uses ([How the judge works](/docs/judgments)):

- page paths, without domains or query strings
- click text
- form names
- error messages
- custom event names, and properties whose keys do not look personal
- session facts: duration, device, browser, OS, country, entry page, page count, whether the user was identified, and any DevTools error counts

Sequential does not send the session's user id.

Sequential trims long sessions to 255 events. It keeps errors, rage clicks, dead clicks, form submits and page views ahead of custom events and ordinary clicks.

## If you get no results

| Message | What it means | What to do |
|---|---|---|
| "None of N sessions match." | The judge rated no searched session likely enough to show. This is not proof that nothing like it happened. | Check the headline. Then try other words. |
| "There was no session to read in the last 7 days." | The judge read no session. No session of the last 7 days had enough events to judge. | See [What it needs](#what-it-needs). |
| "The judge has used today's reading budget for this project. It resets …" | The project's daily Ask allowance is used up, or this run would go over it. It resets at midnight UTC. The "It resets …" message shows the time in your local time. | — |
| "The judge is not set up on this server, so it cannot read sessions." | Judging is not configured on your Sequential server. No setting in the app changes that. A funnel line, or a person's name or email, works without the judge. | Ask the person who runs the server. |
| "The judge is not available right now. Try again in a minute." | Sequential cannot read the Ask allowance for a moment. Nothing was spent. | Click Try again. If it fails again, wait 30 seconds. |
| "The judge could not finish reading. Try again." | Judging failed. | Try again starts again from the first batch and replaces the results. |

## Limits and spend

See also [Limits and defaults](/docs/limits#ask).

| Limit | What happens |
|---|---|
| Ask's allowance in the app | The default is 2,000,000 input tokens per project per UTC day. For a new organisation, in its first 30 days, it is 200,000. It resets at midnight UTC. Ask and background judging do not use each other's allowance. The app does not show the limit. See [Daily allowances](/docs/limits#daily-allowances). |
| Ask links | An Ask link runs Ask when someone opens it. Unless a saved answer matches, each opening uses the project's Ask allowance. See [Share a search link](#share-a-search-link). |
| Answers on your Board | An answer on your Board runs again each time you open the Board. Unless a saved answer matches, each run of a description uses the project's Ask allowance. |
| Window | A description reads only the last 7 days. Ask has no date range and no filters ([Filters, date ranges and saved views](/docs/filters-and-saved-views)). |
| Long sessions | Sequential trims long sessions to 255 events. |
| Question log | Sequential logs questions. It keeps each question, who asked and its counts for 180 days. For an agent, who asked is the id of its token. |

### Allowance and saved answers

- Ask in the app has its own allowance: 2,000,000 input tokens per project per UTC day by default. Background judging, Try on a session on the Questions page and Ask from an agent each have a separate one.
- Your Sequential server sets the allowance, with `ASK_DAILY_TOKENS`.
- If Sequential cannot read the allowance, it does not run Ask and spends nothing. The server answers 503 `budget_unavailable` with `Retry-After: 30`. A saved answer still returns.
- When the message is "The judge is not available right now. Try again in a minute.", Sequential cannot read the Ask allowance for a moment. The server answers 503 `budget_unavailable`. Nothing was spent.
- The allowance resets at midnight UTC.
- Sequential saves an answer for one hour, unless part of the batch failed. The same question over the same sessions returns the saved answer. It does not judge again or use the allowance.

When Ask uses a saved answer:

- Ask again returns the saved answer only if the judge judged the whole first batch within the hour and the same sessions are still first in line.
- Ask ignores double quotes, backticks and extra spaces in the question.
- Ask does not ignore apostrophes and capitals. A question that differs only in these is a new question.
- If new sessions change the batch, Ask does a new run.

## Ask from an agent

An agent can also run Ask through the tool `ask_sessions` (MCP or POST `/api/agent/ask_sessions`). It needs the scope `ask:use`, in a project access token (`sq_pat_…`) or in a connection by signing in.

An agent spends the agent allowance of the project: 2,000,000 input tokens per UTC day by default. Each token can spend at most 500,000 of it per UTC day. See [Limits](/docs/limits#ask-from-an-agent).

> **Read-only does not stop the spend**
>
> The endpoint `/mcp/readonly` lists `ask_sessions`. MCP clients also see `ask_sessions` marked as read-only (`readOnlyHint`), because it changes no data. A client that approves read-only tools on its own can call it, and spend, without asking you. To stop an agent from running Ask and spending the agent allowance, give it a token without `ask:use`. Other agent tools still spend the [screening allowance](/docs/limits#daily-allowances).

Which tokens and connections have `ask:use` ([Connect your agent](/docs/quickstart#connect-your-agent)):

| Token or connection | Has `ask:use` |
|---|---|
| A token from "Make a token", under Settings › Agents & tokens (owners and admins) | Yes, if you select "asks the judge" (`ask:use`) |
| The presets "Read cases", "Fix loop agent", "Release bot" and "CLI and CI" | No |
| The token that onboarding makes for your agent | Yes |
| A connection by signing in, with "Read and investigate" | Yes |
| A connection by signing in, with "Without Ask, so it spends no AI budget" | No |

### What the agent gets

- Allowance: an agent spends the agent allowance of the project: 2,000,000 input tokens per UTC day by default. Each token can spend at most 500,000 of it per UTC day. Background judging and Ask in the app do not use this allowance. See [Limits](/docs/limits#ask-from-an-agent).
- Screening: the label of a matched moment is visitor text, so Sequential screens it before the agent gets it. Session and user ids come marked. See [Privacy at a glance](/docs/privacy-overview).
- Arguments: `query`: your description, 3–200 characters. `days`: the last 1–30 days, default 7. `limit`: 1–50 sessions per call, default 25. `cursor`: the `next_cursor` of an earlier call with the same `query` and `days`.
- No filters: the agent cannot apply filters. Ask picks and orders the candidates as in the app.

| Field | What it means |
|---|---|
| `searched` | The number of sessions that the judge judged in this call |
| `in_range` | The number of candidates in the window, up to 2,000 |
| `near_misses` | Sessions that the judge judged and rated close, but below the cut-off. Ask does not show them |
| `not_judgeable` | Sessions that are too short to judge. The judge did not read them |
| `stopped`, `stop_reason` | `stopped` is `"budget"` when a spend limit, or a failure to read the limits, stopped the call before the end of the batch. `stop_reason` says which: `budget_exhausted`, `token_daily_limit` or `ai_unavailable` |
| `next_cursor` | A position in the candidate list. Sequential builds the list again on each call, so a later call can skip or repeat some sessions, most of all after new sessions arrive or are judged |
| `partial` | `true` when some sessions failed at the judge |
| `results` | The matches, strongest first |

- An empty `results` with `near_misses` above 0 means that the judge read sessions and none matched.
- A near miss has a match of at least 0.2 and less than 0.4.
- After a stop, Sequential did not check the rest of the batch. Call again with `next_cursor`. For `budget_exhausted` or `token_daily_limit`, call after midnight UTC. For `ai_unavailable`, call again in a minute.
- A cursor used hours later, for example after midnight UTC, continues in a list that has changed. Some sessions can be skipped or come again.
- Each result has `session_id`, `user_id`, `session_start`, `match` (0–1), `state` (`on` or `unclear`), `moment`, the session's judgment in `beliefs`, and `replay_url`.
- `replay_url` and the `url` of a moment name the project, so they open that project. See [Links that open a project](/docs/sessions-and-replay#links-that-open-a-project).
- The app shows the same two counts with its answer. See [What a result shows](#what-a-result-shows).
- For each refusal, see [Troubleshooting](/docs/troubleshooting).

## Next steps

- [Evidence: the sessions worth a look](/docs/watch): the ranking that Ask reads first, with background judging on.
- [How the judge works](/docs/judgments): how background judging reads a session.
- [Reading a verdict](/docs/reading-verdicts): read a verdict and its percent.
- [Ask or jump (⌘K)](/docs/search-or-jump-to): ask or jump from the ⌘K box.
