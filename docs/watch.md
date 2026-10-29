# Evidence: the sessions worth a look

> Evidence puts the sessions of the last 7 days in lanes, the worst first. Each card says what the judge read and opens the session at its moment.

> **In short**
>
> - **Evidence** shows the sessions of the last 7 days, with the judge's reading on each one.
> - The sessions are in lanes. **Broke for the user** comes first, then **Struggled**.
> - Each card says in one sentence what the judge read. It also shows the moment to watch, for example "Struggled at 0:42".
> - Press J and K to select a card. Press Enter, or click **Watch ↵**, to watch it beside the list. Press O to open its full page.
> - Background judging is on by default for each project. Owners and admins turn it off or on under **Settings** › **Recording & data** › **Judging**.
> - Evidence itself uses no allowance. It only reads stored judgments.

## What it is for

**Evidence** shows what people did in your product, with the judge's reading laid over it. It puts the sessions that need a look first. It opens each session at the most useful moment.

## How it works

Sequential judges ended sessions in the background. The judge answers your project's questions about the events of each session ([Judgments](/docs/judgments)). The judge never watches the recording itself.

Evidence puts each judged session in a lane. The lane comes from the judge's friction answer and from the problems of the session. In a lane, the session with the highest attention score comes first. The attention score adds up the weighted answers of the judge.

## When sessions appear

Sequential picks up a session for judging when 30 minutes have passed with no new event. Sequential checks every 5 minutes. So a session usually gets its reading 30–35 minutes after its last event.

Sequential judges a session automatically only if all of these are true:

- Its events carry a session id ([Sessions](/docs/sessions)).
- It has at least 3 events. System events do not count.
- Its last event is within the past 7 days.
- Background judging is on for the project, and your Sequential server allows it.

> **Older sessions are never judged automatically**
>
> Sequential never judges a session automatically if its last event is more than 7 days old. This also applies when you turn judging on for a project.

## How to use it

1. Click **Evidence** in the rail, or press G, then S.
2. Read the line under the title. It says how many sessions the judge read in the last 7 days, and how many are in each lane.
3. Optional: click a filter: **Gave up**, **Hit an error** or **Had trouble**.
4. Read a card. The sentence says what the judge read. The pill and the moment say why the session is in its lane.
5. Press J or K to select a card. Then press Enter, or click **Watch ↵**. The session opens beside the list, at its moment.
6. Play the recording. Under it, **The judge's moments** lists the moments that the judge found. Click a moment to go to it.
7. Press O, or click **Open full**, to open the full page of the session. There you mark each reading of the judge **Right** or **Wrong**.

You can also click a card. It opens beside the list in the same way.

| Key | What it does |
|---|---|
| J | Selects the next session |
| K | Selects the previous session |
| Enter | Opens the selected session beside the list |
| O | Opens the full page of the selected session |
| Esc | Clears the selection |

Nothing is selected until you press J or K. When a session is open beside the list, J and K also change the session that it shows.

## The lanes

Evidence shows the lanes in this order:

| Lane | What it holds |
|---|---|
| **Broke for the user** | The session had a JavaScript error or a failed request, and the person struggled. |
| **Struggled** | The person struggled, or clicked in anger (rage clicks or dead clicks). A session with an error or a failed request where the person did not struggle is also here. |
| **The judge was unsure** | The judge could not tell what the person came to do, or how the session ended. No signal of the judge fired. |
| **Minor** | The other judged sessions. Nothing broke and nobody struggled much. |
| **Not judged** | The sessions that the judge did not read. The lane says "Too short (under 3 events), not read yet, or the judge could not read them." |

**Minor** and **Not judged** start folded. Click the heading of a lane to fold or unfold it.

The person struggled when the session sits at or above the middle of the **Friction** scale. Sequential uses your current questions for this. With the default questions, that is between **Minor hesitation** and **Noticeable struggle**.

Errors and failed requests come from the recording and from the error events that your SDK sent. Rage clicks and dead clicks come from their events. Sequential counts only the problems in the last 7 days. A request that the page or the browser stopped is not a failed request.

In each lane, the session with the highest attention score comes first. A session in **Broke for the user** comes before every session in **Struggled**, on every page. Sessions that are not judged come after every judged session.

Each lane heading shows its name and its number of sessions in the last 7 days. When fewer sessions are loaded, the heading also says "N loaded".

## What a card shows

- The person. Your own sessions read **You**.
- The country flag, when Sequential knows the country.
- When the session started, and how long the person was active.
- The verdict sentence, for example "Came to use a feature and moved through 6 pages. 2 requests failed, went in circles."
- One pill: **Broke** or **Struggled**. A card without one of these shows the friction level, when the sentence does not already say it.
- Up to three pills such as "Maybe: Went in circles". The judge leans toward these signals, but is not sure of them.
- On the right: the moment to watch, for example "Struggled at 0:42". Or the state of the recording, when you cannot play it.

The moment of a card is where the person struggled. If there is no such moment, it is where the person gave up. A moment where the person gave up has no play mark, because the recording can end before it.

## Beside the list

When you open a session beside the list, you see:

- "Why you are seeing this", when the reason adds something to the rest.
- The person, when the session started, how long it was, the country and the browser. Click the name to open the person.
- **Ask your agent**, after the name. It gives your coding agent a prompt about this session, at the time of the player. See [Ask your agent](/docs/sessions-and-replay#ask-your-agent).
- The verdict sentence. Also "The judge was unsure about this session.", when it applies.
- **Came to** and **Outcome**, each with **Right** and **Wrong** as two small buttons. Check the other readings on the full page.
- The pills: the lane, the friction level and the "Maybe:" signals.
- The player, stopped at the moment of the card.
- **The judge's moments**: each moment with its time, in time order. Click a moment to go to it.
- Under it, what the person did, and the DevTools of the recording.

Click **Open full** to open the full page at the current time.

## The full page

The full page shows the recording, its timeline and a column beside it. The column has two tabs:

- **The judge's reading**: the lane, the verdict sentence and each reading of the judge. Each reading has a word for how sure the judge was, and **Right** and **Wrong**. See [Judgments](/docs/judgments).
- **Around this session**: the other visits of the person, and the changes recorded on the day of the session. See [Changes](/docs/changes).

Under the reading you find **The judge's moments**, **What went wrong** (when something did) and **All events of this session**. **Earlier** and **Later** open the other sessions of the same person. Press [ and ] to do the same. **Ask your agent**, after **Later**, gives your coding agent a prompt about this session. The prompt names the session, the time of the player and the page at that time. See [Ask your agent](/docs/sessions-and-replay#ask-your-agent). At the top, **Back** goes back to the page that you came from, with its filters. If you opened the session from a link, the button is **Evidence** and opens the list.

Beside it are three buttons:

- **Share**, or the key c, copies a link to this session at the current moment. The message says, for example, "Link copied. It starts at 1:23." The link holds only the session and the time. It opens the player paused at that moment.
- **Events**, or the key e, shows or folds what the person did, in the panel under the player. When a reading of the judge has the focus, e marks that reading **Right** instead.
- **DevTools**, or the key d, shows or folds the DevTools tabs in that panel. It opens on the tab that you used last, or on the first tab with a problem. If the page had errors or failed requests, the button says so, for example "3 errors" or "2 failed".

Alt+P and Alt+N also open the earlier and later session of the same person.

## When Evidence is empty

| You see | What it means | What to do |
|---|---|---|
| "Nothing the judge could read in the 7 calendar days to today." | Every session was too short, is waiting to be read, or the judge could not read it. | Read the line under it. Wait about 30–35 minutes after activity. |
| "No session in the 7 calendar days to today." | Sequential received no session in these days. | Check that the recorder sends data. |
| "Nothing broke for anyone in the 7 calendar days to today." | The **Broke for the user** lane is empty. | Nothing. |
| "No session here matches this filter." | The lane has no session for the filter. | Click **All**. |

The line under an empty list says why the judge did not read the sessions. See [The line under the title](#the-line-under-the-title), below.

## When background judging is off

New sessions are not judged, so they show in **Not judged**. When background judging is switched off for this project, the line under the Evidence title says "Judging is off for this project, so new sessions are not judged." When the switch is off, owners and admins also read "Turn it on in Settings › Recording & data › Judging." When your Sequential server keeps background judging off, Evidence does not say so.

The switch is **Judge new sessions automatically**, under **Settings** › **Recording & data** › **Judging**. It is on by default. Owners and admins change it. Other roles can read it, but cannot change it. When you turn it off, verdicts that Sequential made before stay. When you turn it back on, Sequential also judges the unjudged sessions from the past 7 days.

Your Sequential server can also keep background judging off for every project.

## Allowances

| What | Allowance |
|---|---|
| **Evidence** itself: load, filter, a new weight | None. |
| Background judging | A daily allowance per project. |
| [Ask](/docs/ask) | Its own daily allowance. |
| **Try it** on the **Questions** page | Its own daily allowance. |
| **Judge this recording now** on the full page of a session | Its own daily allowance. |

## Limits

- **The last 7 days only.** Evidence shows today and the 6 days before, as whole UTC days. It has no date range. To find older sessions, use Workbench › **Sessions**.
- **50 at a time.** Evidence loads 50 sessions at a time. Click **Show more** to load the next 50. At the end, the list says "That is every session in the 7 calendar days to today."
- **The unsure lane** shows its first 13 sessions. **Show more unsure sessions** adds up to 50 more.
- **The filter counts cover only the loaded sessions.** While more sessions remain, **All** reads **Loaded**. A line under the filters then says how many are loaded. The lane headings count the whole 7 days only when **All** is selected.
- **Judged once.** Background judging judges each session once. It does not add later events to the judgment. Nothing in the app changes a stored judgment. **Judge this recording now**, on the full page, shows a new reading on that page only.
- **Long sessions are trimmed.** The judge reads at most 255 events. The full page says "Read … from N of M events" when the judge read fewer.
- **A moment can open late.** The time of a moment counts from the first event of the session. The player counts from the start of the recording. If the recording started later, the player opens that much later.
- If the daily judging allowance runs out, new sessions wait. Sequential tries them again every hour. The allowance resets each UTC day.
- Each check queues at most 500 sessions per project. On a busy project, a session can take longer than 35 minutes to appear.

### Why Evidence, with examples

Nobody watches every recording. Filters only find what you already know to look for. Evidence shows sessions like these:

- A trial user hit a failed request on the billing page and gave up.
- A new admin moved between settings and the invite screen many times, but did not send an invite.
- A checkout hit an error twice. Then the customer asked support for help.

### How the attention score is calculated

The attention score sets the order inside each lane. The default questions weight four of them:

| Question | Default **Attention weight** |
|---|---|
| Worth watching | 0.45 |
| Friction | 0.25 |
| Hit an error | 0.15 |
| Product bug | 0.15 |

- A weighted yes-or-no question adds its weight times the probability of yes.
- A weighted scale adds its weight times how far up the scale the session sits.
- Evidence uses your current weights each time it loads. So a weight change re-orders every judged session at once, without a new judgment.
- A question without a weight does not count toward the order.

Owners and admins set the **Attention weight** of a question on the **Questions** page ([Customise the questions](/docs/rubric)).

### The line under the title

The line counts the sessions of the last 7 days. For example: "The judge read 66 of the 139 sessions in the 7 calendar days to today: 0 broke for the user, 9 struggled, 51 minor. It was unsure about 6."

- When some sessions were not judged, the line adds why, with one sentence for each reason. See the table below.
- When **Hide our team** leaves out the sessions of your team, the line says how many it left out.

| The line says | What it means |
|---|---|
| "N visits were too short to judge (under 3 events)." | These sessions have fewer than 3 events that the judge can read (System events and unknown event types do not count). The judge does not read them. |
| "N visits were too short to judge (under 3 events) or had an event in the last 30 minutes." | These sessions are too short, or their last event was less than 30 minutes ago. |
| "N sessions are waiting to be read. The judge reads a session about 30 minutes after its last event." | These sessions are ready for the judge. Sequential checks every 5 minutes. |
| "The judge could not read N sessions. Sequential does not try them again." | The judge returned an error for these sessions. They stay in **Not judged**. |
| "Judging is off for this project, so new sessions are not judged." | See [When background judging is off](#when-background-judging-is-off). |
| "N visits are not judged: too short (under 3 events), not read yet, or the judge could not read them." | Sequential could not count the reasons just now. |
| "N visits are not judged: too short (under 3 events) or not read yet." | Sequential could not read which sessions wait for the judge. |

### The filters

| Filter | Shows a session when |
|---|---|
| **All** | Always. It reads **Loaded** while more sessions remain. |
| **Gave up** | The judge says the outcome is **Abandoned** or **Switched to support**. |
| **Hit an error** | The session had a JavaScript error or a failed request. Or the outcome is **Blocked by an error**, or the **Hit an error** signal is on. |
| **Had trouble** | The session is in **Broke for the user** or **Struggled**. Or the friction level is **Noticeable struggle** or higher. Or the session had rage clicks, or a rage click or dead click signal is on. |

**Had trouble** holds more sessions than the **Struggled** lane. Each chip shows how many loaded sessions match it.

**Hide our team** leaves out the sessions of the people that are marked as your team. When your Sequential server cannot do this for lists, the switch reads **Hide our team in Ask**.

### Moments and their names

A moment has a name from your questions. With the default questions, the names are:

| Moment | Name on Evidence |
|---|---|
| Where they struggled | **Struggled**. **Hesitated** when the friction level is **Minor hesitation**. **Hardest moment** when the session was **Smooth**. |
| Where they gave up | **Gave up**. **Last action** when the outcome is **Still going at the end**. |
| What they came to do | **Reached the goal** |

A moment of a question without a role shows the name of the question.

A card shows a moment where the person gave up only if it means something. On a session that is still going, a drop-off near the end is only the recording ending. So the card leaves it out.

In **The judge's moments**, a moment after the end of the recording shows "after the recording ended". It is not a button. A session without a recording still shows its moments. A click then marks the event in the list of what the person did.

### Recordings you cannot play

Sequential judges and ranks a session whether it has a recording or not. A card shows the state of the recording in place of its moment:

- **No recording**: the session was not recorded.
- "Ready by 14:05", or **Recording not ready yet**: the recording is still being put together.
- **Recording expired**: the session is older than the time that the project keeps recordings.
- **No playable recording**: Sequential never received all of the recording.

See [Session replay (web)](/docs/session-replay) and [Mobile apps](/docs/mobile).

### When a session takes longer to appear

- On a busy project, a session can take longer. Each check queues at most 500 sessions.
- When the day's judging allowance has run out, a session also waits longer. See [Allowances](#allowances).

### How to improve the ranking

The judge also reads the session's error counts, when the recording measured them.

- **Make events readable.** Send clicks with text or an id, page views with a path or screen name, and errors with their message ([Events](/docs/events)).
- **Name your milestones.** Custom events such as `invite_sent` or `plan_changed` show if the person reached their goal ([Send custom events](/docs/custom-events)).
- **Keep DevTools capture on.** In the default questions, Outcome, Friction, Hit an error and Product bug read the session's error counts. Only recorded sessions have error counts ([DevTools in replays](/docs/devtools)).
- **Tune the weights.** Owners and admins set the **Attention weight** of a yes-or-no or scale question on the **Questions** page.
- **Ask your product's questions** ([Customise the questions](/docs/rubric)).
- **Mark the readings.** **Right** and **Wrong** on the full page show how far the judge can be trusted ([Feedback and calibration](/docs/feedback-and-calibration)).

## Related

- [Judgments](/docs/judgments)
- [Reading a verdict](/docs/reading-verdicts)
- [Customise the questions](/docs/rubric)
- [Feedback and calibration](/docs/feedback-and-calibration)
- [Ask](/docs/ask)
- [Find and replay sessions](/docs/sessions-and-replay)
