# Evidence: the sessions worth a look

> Evidence puts the sessions of the last 7 days in lanes, the worst first. Each card says what the judge read and opens the session at its moment.

> **At a glance**
>
> - **Before you start:** Sequential judges a session automatically only if its events carry a session id ([Sessions](/docs/sessions)) and it has at least 3 events. [System events](/docs/events#hidden-system-events) do not count.
> - **Default:** Background judging is on for each project. Owners and admins turn it off or on (Settings › Recording & data › Judging).
> - **You get:** The judgment of a session, usually 30–35 minutes after its last event.
> - **Know this:** A session whose last event is more than 7 days old is never judged automatically.
> - **Know this:** Evidence itself uses no [allowance](#which-actions-use-an-allowance). It only reads stored [judgments](/docs/judgments).

## Watch the sessions worth a look

Evidence shows the last 7 days: today and the 6 days before, as whole UTC days.

1. Click **Evidence** in the rail, or press G, then S.

2. Read the summary under the Evidence title.

   Result: From 8 November 2026, its headline says what broke or struggled, for example "3 broke for the user · 5 struggled". A bar splits the week into its lanes. The scope line names the window and how many sessions the judge read, for example "7 calendar days to today · Judged 229 of 283". See [The summary](#the-summary).

3. Optional: click a filter: Gave up, Hit an error or Had trouble ([What each filter shows](#what-each-filter-shows)).

4. Read the cards from the top ([Read a session](#read-a-session)).

5. Click a card.

   Result: The session opens in the peek, at its [moment](#moments-and-their-names).

6. Play the recording, or click a moment under it.

7. Press O, or click **Open full**, to open the full page of the session.

8. On the full page, check each reading of the judge: **Right** or **Wrong** ([Feedback and calibration](/docs/feedback-and-calibration)).

Result: Right and Wrong show how far the judge can be trusted.

Or use the keys. Nothing is selected until you press J or K.

| Key | What it does |
|---|---|
| J | Selects the next session |
| K | Selects the previous session |
| Enter, or click Watch ↵ | Opens the selected session in the peek |
| O | Opens the full page of the selected session |
| Esc | Clears the selection |
| J or K, when a session is open in the peek | Also changes the session that it shows |

### What each filter shows

| Filter | Shows a session when |
|---|---|
| All | Always. It reads "Loaded" while more sessions remain. |
| Gave up | The judge says the outcome is Abandoned or Switched to support. |
| Hit an error | The session had a JavaScript error or a failed request. Or the outcome is Blocked by an error, or the signal Hit an error is on. |
| Had trouble | The session is in the lane Broke for the user or Struggled. Or the friction level is Noticeable struggle or higher. Or the session had rage clicks, or a rage click or dead click signal is on. |

Had trouble holds more sessions than the lane Struggled. From 8 November 2026, the chips show no counts. A filter shows only the loaded sessions. While a filter is on and more sessions remain, a line under the filters says how many are loaded.

Hide our team leaves out the sessions of the people that are marked as your team.

### The summary

From 8 November 2026, the summary under the Evidence title has a headline, a bar with a legend, and a scope line.

The headline is one of these:

| Headline | When |
|---|---|
| "3 broke for the user · 5 struggled", "3 broke for the user · nobody struggled" or "Nothing broke for the user · 5 struggled" | The judge read sessions, and some broke for the user or struggled |
| "Nothing broke and nobody struggled." | The judge read sessions, and none broke or struggled |
| "None of the 12 sessions is judged." or "The one session is not judged." | The judge read no session of the week |
| "No session is judged." | The judge read no session, and Sequential could not count the others |
| "No session was recorded." or "Every session was your team’s." | The week has no session, or only your team's |
| "Judging is off for this project." | An owner or admin turned judging off. Those who can turn it on also see "Turn it on" |

- The bar splits the week into Broke, Struggled, Unsure, Minor and Not judged. Click a part of the legend to open its lane, when the lane is on the page. This also selects the filter All.
- The scope line starts with "7 calendar days to today". It can add "Your team’s 4 left out", and how many sessions the judge read: for example "Judged 229 of 283", "Judged all 283" or "Judged the one session". If Sequential could not count the week, it says "Total not counted".
- Click "How counted ▾" for the sentence that the page showed before, word for word.

## Read the lanes

In each lane, the session with the highest [attention score](#how-the-attention-score-is-calculated) comes first.

| Lane, in order | What it holds |
|---|---|
| Broke for the user | The session had a JavaScript error or a failed request, and the person struggled. |
| Struggled | The person struggled, or clicked in anger (rage clicks or dead clicks). A session with an error or a failed request where the person did not struggle is also here. |
| The judge was unsure | The judge could not tell what the person came to do, or how the session ended. No [signal](/docs/judgments) of the judge fired. |
| Minor | The other judged sessions. Nothing broke and nobody struggled much. The lane starts folded. |
| Not judged | The sessions that the judge did not read. The lane says "Too short (under 3 events), not read yet, or the judge could not read them." The lane starts folded. |

Click the heading of a lane to fold or unfold it.

### How Sequential picks the lane

Evidence puts each judged session in a lane. The lane comes from the judge's friction level and from the problems of the session.

The person struggled when the session sits at or above the middle of the Friction scale. Sequential uses your current questions for this. With the default questions, that is between Minor hesitation and Noticeable struggle.

Errors and failed requests come from the recording and from the error events that your SDK sent. Rage clicks and dead clicks come from their events. Sequential counts only the problems in the last 7 days. A request that the page or the browser stopped is not a failed request.

A session in the lane Broke for the user comes before every session in the lane Struggled, on every page. Sessions that are not judged come after every judged session.

Each lane heading shows its name and its number of sessions in the last 7 days. When fewer sessions are loaded, the heading also says "N loaded". The lane headings count the whole 7 days only when the filter All is selected.

### How the attention score is calculated

The attention score sets the order inside each lane. It adds up the weighted answers of the judge. The default questions weight four of them:

| Question | Default Attention weight |
|---|---|
| Worth watching | 0.45 |
| Friction | 0.25 |
| Hit an error | 0.15 |
| Product bug | 0.15 |

- A weighted yes-or-no question adds its weight times the probability of yes.
- A weighted scale adds its weight times how far up the scale the session sits.
- Evidence uses your current weights each time it loads. So a weight change re-orders every judged session at once, without a new judgment.
- A question without a weight does not count toward the order.

## Read a session

The pill and the moment say why the session is in its lane.

| On a card | What it is |
|---|---|
| The person | Your own sessions read "You". |
| The country flag | Shows when Sequential knows the country. |
| The time | When the session started, and how long the person was active. |
| The verdict sentence | What the judge read. For example "Came to use a feature and moved through 6 pages. 2 requests failed, went in circles." |
| One pill | Broke or Struggled. A card without one of these shows the [friction level](#how-sequential-picks-the-lane), when the sentence does not already say it. |
| "Maybe:" pills | Up to three pills such as "Maybe: Went in circles". The judge leans toward these signals, but is not sure of them. |
| The moment, on the right | The moment to watch, for example "Struggled at 0:42". The moment of a card is where the person struggled. If there is no such moment, it is where the person gave up. A moment where the person gave up has no play mark, because the recording can end before it. |
| The state of the recording, on the right | Shows in place of the moment, when you cannot play the recording ([What does a card show when the recording cannot play?](#what-does-a-card-show-when-the-recording-cannot-play)). |

### Moments and their names

Each card says in one sentence what the judge read. It also shows the moment to watch, for example "Struggled at 0:42".

A moment has a name from your questions. With the default questions, the names are:

| Moment | Name on Evidence |
|---|---|
| Where they struggled | Struggled. Hesitated when the friction level is Minor hesitation. Hardest moment when the session was Smooth. |
| Where they gave up | Gave up. Last action when the outcome is Still going at the end. |
| What they came to do | Reached the goal |

A moment of a question without a role shows the name of the question.

A card shows a moment where the person gave up only if it means something. On a session that is still going, a drop-off near the end is only the recording ending. So the card leaves it out.

A moment after the end of the recording shows "after the recording ended" in The judge's moments. It is not a button. A session without a recording still shows its moments. A click then marks the event in the list of what the person did.

A moment can open late. The time of a moment counts from the first event of the session. The player counts from the start of the recording. If the recording started later, the player opens that much later.

### What you see when you open a session

When you open a session in the peek, you see:

- "Why you are seeing this", when the reason adds something to the rest.
- The person, when the session started, how long it was, the country and the browser. Click the name to open the person.
- Ask your agent, after the name. It gives your coding agent a prompt about this session, at the time of the player ([Ask your agent](/docs/sessions-and-replay#ask-your-agent)).
- The verdict sentence. Also "The judge was unsure about this session.", when it applies.
- Came to and Outcome, each with Right and Wrong as two small buttons. Check the other readings on the full page.
- The pills: the lane, the friction level and the "Maybe:" signals.
- The player, stopped at the moment of the card. Under it, The judge's moments lists the moments that the judge found: each moment with its time, in time order. Click a moment to go to it. Under that, what the person did, and the DevTools of the recording.

Click Open full to open the full page at the current time.

The full page shows the recording, its timeline and a column beside it. The column has two tabs:

- The judge's reading: the lane, the verdict sentence and each reading of the judge. Each reading has a word for how sure the judge was, and Right and Wrong ([Judgments](/docs/judgments)).
- Around this session: the other sessions of the person, and the changes recorded on the day of the session ([Changes](/docs/changes)).

Under the reading you find:

- The judge's moments.
- What went wrong, when something did.
- All events of this session.

When the judge read fewer events than the session has, the page says "Read … from N of M events" ([Limits and allowances](#limits-and-allowances)).

At the top is Back. Beside it are three buttons: Share, Events and DevTools.

| Control | What it does |
|---|---|
| Back | Goes back to the page that you came from, with its filters. If you opened the session from a link, the button is Evidence and opens the list. |
| Earlier and Later, or the keys [ and ] | Open the other sessions of the same person. Alt+P and Alt+N also open the earlier and later session of the same person. |
| Ask your agent, after Later | Gives your coding agent a prompt about this session. The prompt names the session, the time of the player and the page at that time ([Ask your agent](/docs/sessions-and-replay#ask-your-agent)). |
| Share, or the key c | Copies a link to this session at the current moment. The message says, for example, "Link copied. It starts at 1:23." The link holds only the session and the time. It opens the player paused at that moment. |
| Events, or the key e | Shows or folds what the person did, in the panel under the player. When a reading of the judge has the focus, e answers Right for that reading instead. |
| DevTools, or the key d | Shows or folds the DevTools tabs in that panel. It opens on the tab that you used last, or on the first tab with a problem. If the page had errors or failed requests, the button says so, for example "3 errors" or "2 failed". |

## Improve the ranking

| Do this | How |
|---|---|
| Make events readable | Send clicks with text or an id, page views with a path or screen name, and errors with their message ([Events](/docs/events)). |
| Name your milestones | Custom events such as `invite_sent` or `plan_changed` show if the person reached their goal ([Send custom events](/docs/custom-events)). |
| Keep DevTools capture on | The judge also reads the session's error counts, when the recording measured them. In the default questions, Outcome, Friction, Hit an error and Product bug read the session's error counts. Only recorded sessions have error counts ([DevTools in replays](/docs/devtools)). |
| Tune the weights | Owners and admins set the Attention weight of a yes-or-no or scale question on the Questions page ([Customise the questions](/docs/rubric)). |
| Ask your product's questions | [Customise the questions](/docs/rubric) |

## How background judging works

The judge answers your project's questions about the events of each ended session ([Judgments](/docs/judgments)), and never watches the recording itself.

### When sessions appear

Sequential judges ended sessions in the background. Sequential picks up a session for judging when 30 minutes have passed with no new event. Sequential checks every 5 minutes.

Sequential judges a session automatically only if all of these are true:

- Its events carry a session id ([Sessions](/docs/sessions)).
- It has at least 3 events. System events do not count.
- Its last event is within the past 7 days.
- Background judging is on for the project ([When background judging is off](#when-background-judging-is-off)).
- Your Sequential server allows it ([How can my Sequential server change Evidence?](#how-can-my-sequential-server-change-evidence)).

For a longer wait, see [Why does a session take longer than 35 minutes to appear?](#why-does-a-session-take-longer-than-35-minutes-to-appear)

### When background judging is off

When background judging is off, new sessions are not judged, so they show in the lane Not judged. When it is switched off for this project, the line under the Evidence title says "Judging is off for this project, so new sessions are not judged." Owners and admins also read "Turn it on in Settings › Recording & data › Judging."

The switch is Settings › Recording & data › Judging › Judge new sessions automatically. Owners and admins change it. Other roles can read it, but cannot change it.

From 8 November 2026, under the switch, the page says "The judge reads a text summary of each session and writes a reading for each one." Then rows follow. Off: "New readings stop. The ones made stay." On again: "Sessions that ended in the last 7 days and have no reading get judged, also those recorded while it was off." Cases: "The judge never opens one." Sent to: "Sequential’s AI provider, a sub-processor". The old help is under Read the full text ▾.

When you turn it off, judgments that Sequential made before stay. When you turn it back on, Sequential also judges the unjudged sessions from the past 7 days.

Sequential never judges a session automatically if its last event is more than 7 days old. This also applies when you turn judging on for a project.

## When Evidence is empty

When Evidence is empty, the line under the message says why the judge did not read the sessions ([Why sessions are not judged](#why-sessions-are-not-judged)).

| You see | What it means | What to do |
|---|---|---|
| "Nothing the judge could read in the 7 calendar days to today." | Every session was too short, is waiting to be read, or the judge could not read it. | Read the line under the message. Wait about 30–35 minutes after activity. |
| "No session in the 7 calendar days to today." | Sequential received no session in these days. | Check that the recorder sends data. |
| "Nothing broke for anyone in the 7 calendar days to today." | The lane Broke for the user is empty. | Nothing. |
| "No session here matches this filter." | The lane has no session for the filter. | Click the filter All. |

### Why sessions are not judged

The sentence under How counted ▾ counts the sessions of the last 7 days. For example: "The judge read 66 of the 139 sessions in the 7 calendar days to today: 0 broke for the user, 9 struggled, 51 minor. It was unsure about 6."

- When some sessions were not judged, the line adds why, with one sentence for each reason.
- When Hide our team leaves out the sessions of your team, the line says how many it left out.

| Message | Where | What it means | What to do |
|---|---|---|---|
| "N visits were too short to judge (under 3 events)." | — | These sessions have fewer than 3 events that the judge can read (System events and unknown event types do not count). The judge does not read them. | — |
| "N visits were too short to judge (under 3 events) or had an event in the last 30 minutes." | — | These sessions are too short, or their last event was less than 30 minutes ago. | — |
| "N sessions are waiting to be read. The judge reads a session about 30 minutes after its last event." | — | These sessions are ready for the judge. Sequential checks every 5 minutes. | — |
| "The judge could not read N sessions. Sequential does not try them again." | — | The judge returned an error for these sessions. They stay in the lane Not judged. | — |
| "Judging is off for this project, so new sessions are not judged." | — | See [When background judging is off](#when-background-judging-is-off). | — |
| "N visits are not judged: too short (under 3 events), not read yet, or the judge could not read them." | — | Sequential could not count the reasons just now. | — |
| "N visits are not judged: too short (under 3 events) or not read yet." | — | Sequential could not read which sessions wait for the judge. | — |

## FAQ

### What are examples of sessions worth a look?

Nobody watches every recording. Filters only find what you already know to look for. Evidence shows what people did in your product, with the judgment of each session laid over it. It puts the sessions that need a look first. It opens each session at the most useful moment. Evidence shows sessions like these:

- A trial user hit a failed request on the billing page and gave up.
- A new admin moved between settings and the invite screen many times, but did not send an invite.
- A checkout hit an error twice. Then the person asked support for help.

### Why does a session take longer than 35 minutes to appear?

Each check queues at most 500 sessions per project. On a busy project, a session can take longer than 35 minutes to appear.

When the day's judging allowance has run out, a session also waits longer ([Which actions use an allowance?](#which-actions-use-an-allowance)). Background judging then stops until the allowance resets at midnight UTC. Then it judges the newest sessions first, until the allowance runs out again.

From 5 November 2026, Sequential does not try the waiting sessions again every hour. A session whose last event is more than 7 days old is not judged.

### Does a judgment change later?

No. Background judging judges each session once. It does not add later events to the judgment. Nothing in the app changes a stored judgment. Judge this recording now, on the full page, shows a new reading on that page only ([Which actions use an allowance?](#which-actions-use-an-allowance)).

### How do I see more sessions, or older ones?

Click Show more to load the next 50. At the end, the list says "That is every session in the 7 calendar days to today." Show more unsure sessions adds up to 50 more to the lane The judge was unsure.

To find older sessions, use Workbench › Sessions.

### What does a card show when the recording cannot play?

Sequential judges and ranks a session whether it has a recording or not. A card shows the state of the recording in place of its moment. See [Session replay (web)](/docs/session-replay) and [Mobile apps](/docs/mobile).

| Message | Where | What it means | What to do |
|---|---|---|---|
| "No recording" | — | The session was not recorded. | — |
| "Ready by 14:05" | — | The recording is still being put together. | — |
| "Recording not ready yet" | — | The recording is still being put together. | — |
| "Recording expired" | — | The session is older than the time that the project keeps recordings. | — |
| "No playable recording" | — | Sequential never received all of the recording. | — |

### How can my Sequential server change Evidence?

Your Sequential server can also keep background judging off for every project. When your Sequential server keeps background judging off, Evidence does not say so.

When your Sequential server cannot do this for lists (leave out the sessions of your team), the switch Hide our team reads "Hide our team in Ask".

### Which actions use an allowance?

| What | Allowance |
|---|---|
| Evidence itself: load, filter, a new [weight](#how-the-attention-score-is-calculated) | None |
| Background judging | A daily allowance per project |
| [Ask](/docs/ask) | Its own daily allowance |
| Try it on the [Questions page](/docs/rubric) | Its own daily allowance |
| Judge this recording now on the full page of a session ([Does a judgment change later?](#does-a-judgment-change-later)) | Its own daily allowance |

## Limits and allowances

- The last 7 days only. Evidence has no date range.
- 50 at a time. Evidence loads 50 sessions at a time. The unsure lane shows its first 13 sessions.
- A filter shows only the loaded sessions ([What each filter shows](#what-each-filter-shows)).
- Judged once ([Does a judgment change later?](#does-a-judgment-change-later)).
- Long sessions are trimmed. The judge reads at most 255 events.
- A moment can open late ([Moments and their names](#moments-and-their-names)).
- If the daily judging allowance runs out, background judging stops until the allowance resets at midnight UTC ([Which actions use an allowance?](#which-actions-use-an-allowance)).
- Each check queues at most 500 sessions per project.

## Next steps

- [Judgments](/docs/judgments)
- [Reading a verdict](/docs/reading-verdicts)
- [Customise the questions](/docs/rubric)
- [Feedback and calibration](/docs/feedback-and-calibration)
- [Ask](/docs/ask)
- [Find and replay sessions](/docs/sessions-and-replay)
