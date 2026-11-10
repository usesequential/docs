# Sessions and session ids

> A session is all events with the same session id, plus the recording filed under that id. Your SDK sets the id. Replays, Evidence and Ask need it.

> **In short**
>
> - A session is all the events that carry the same session id, plus the recording filed under that id.
> - Your SDK sets the id. Sequential does not guess sessions from timing or from users.
> - Events and recording join only on exactly the same id. Do not change the id when your code forwards events.
> - An event with no session id still counts as an event, but has no replay and is never judged.
> - Your SDK decides when a session ends. An id that the recorder creates lasts as long as the tab.

## What a session is

A session is one visit, as your analytics SDK defines it. For example: a person opens your pricing page, starts a trial, invites a teammate and leaves. That is one session.

Sequential groups events by the session id that each event carries. It files recordings under the same value. These features work per session and depend on the id: [Evidence](/docs/watch), Workbench › Sessions and Ask. Workbench › Sessions has one row per id. On the session page, What they did and The judge's reading also depend on it.

Sequential judges a session one time only. Background judging needs a session id and at least 3 events that are not System events. The session also needs 30 minutes with no new event, and its last event in the past 7 days. All the conditions: [What a session needs to be judged](#what-a-session-needs-to-be-judged).

## Where the session id comes from

Sequential stores the id exactly as sent. On the web, the Sequential recorder can set an id if your SDK has none ([Session replay (web)](/docs/session-replay)).

### Session id per SDK

On iOS and Android, PostHog's SDK sends the events and the recording under the same session id, with no recorder ([Mobile apps](/docs/mobile)).

| Source | Session id stored | If the SDK has none |
|---|---|---|
| Sequential SDK | Its own id, on every event | — |
| PostHog (web and mobile) | PostHog's `$session_id` | On the web, the recorder's id, which the recorder registers with PostHog. None on mobile |
| Amplitude | Amplitude's `session_id`, stored as text | None. The recorder does not register its id with Amplitude |
| Mixpanel | `$session_id`. Mixpanel's browser SDK does not set it by default | The recorder's id, which the recorder registers as a super property |
| Pendo | Pendo's session id | The recorder's id, sent as visitor metadata |
| Smartlook compatibility script | The script's own id | — |

### How the recorder picks the id

On the web, the recorder files the recording under the session id that your analytics SDK already uses. On a Mixpanel site, sessions come from the web recorder, or from a `$session_id` super property that you register yourself.

1. The recorder loads the [recording settings](/docs/recording-settings) of your project first. If recording is off for the project, or the page is excluded, the recorder stops and sets no id.
2. For up to 2 seconds, it looks for a session id from PostHog, Amplitude, Mixpanel, Pendo, the Smartlook script or the Sequential SDK, in that order. It takes the first id it finds. The Sequential SDK stores its id in the storage of the browser tab before it starts the recorder, so the two start on the same id.
3. If it finds none, it reuses the session id in the storage of the browser tab.
4. If there is still no id, the recorder creates one. It registers the id with PostHog, Mixpanel and Pendo, so their events carry it from then on.
5. While it records, the recorder checks every second if the PostHog, Amplitude, Mixpanel, Pendo, Smartlook or Sequential SDK id has changed. If it has, the recorder closes the recording under the old id and continues under the new id. The part under the old id keeps the user id that it had before the change, also after a `reset()` at sign-out.

The Sequential SDK starts a new session after 30 idle minutes, after 24 hours, or when you call `sequential.reset()`. For example, you can call it at log-out. If this happens while a page stays open, the recorder follows the new id within a second.

The recorder takes the id of the Sequential SDK only if no other analytics SDK on the page gives one. If PostHog, Amplitude, Pendo, the Smartlook script or a Mixpanel `$session_id` is also there, the recorder takes that id. Then the events of the Sequential SDK do not join the recording. For example, this can happen during a migration.

More about the recorder: [Session replay (web)](/docs/session-replay).

### When a session ends, per SDK

Your SDK decides when a session ends and a new id starts.

| Source | When a new session starts |
|---|---|
| Sequential SDK | On the first event after 30 minutes with no event, 24 hours after the session started, or when you call `sequential.reset()`. Each browser tab keeps its own session. The recorder follows each change within a second. |
| Smartlook compatibility script | After 30 minutes with no event. |
| PostHog, Amplitude and Pendo | Their own rules. The recorder follows each change within a second. |
| Mixpanel | The `$session_id` super property. If you do not register your own, the session uses the recorder's id. Then a tab that stays open all day is one session. |
| An id that the recorder created | No idle limit. The id lasts as long as the tab. |

### Sampling and early stops

Each browser tab has one sampling decision per session id. So in one tab, a session never has some pages kept and others dropped.

- A session that spans several tabs is sampled in each tab separately.
- If the browser blocks storage, every page load is sampled separately.
- A session that sampling leaves out still gets its id. It has no recording.

A recorded session can also stop early:

- Each page load stops recording after the Longest recording of the project.
- Sequential stops accepting the recording of a session when it reaches Largest recording.
- Both are under Recording in Settings › Recording & data. See [Recording settings](/docs/recording-settings). The defaults are 60 minutes and 25 MB.
- If a single-page app moves to an excluded page, recording stops until the next page load.

## Check your sessions

1. In the rail, click **Workbench**.

2. Click **Sessions**.

   Result: It lists the sessions in the Window. The Window is at the top of the page.

3. Check the **Recording** column of each row.

   Result: If you cannot play a recording now, the column shows its state in place of "Ready". Hold the pointer on the state to read why. All states: [What the Recording column and the session page say](#what-the-recording-column-and-the-session-page-say).

Done when: the row reads "Ready", with a play mark. This means that a recording exists under exactly that id and you can play it.

> **When the ids do not match**
>
> If your own code forwards the events, do not change the session id. The events and the recording must use exactly the same id. When the ids differ:
>
> - In Workbench › Sessions, the Recording column of the events' session reads "None".
> - On Evidence, its card reads "No recording".
> - The recording gets no row, because no event carries its id.
>
> Why the ids can differ: [Common problems](#common-problems).

### What the Recording column and the session page say

| Message | Where | What it means | What to do |
|---|---|---|---|
| "None" | Recording column | Sequential has no recording under that id, or the recording expired and Sequential removed its index. | — |
| "Processing" | Recording column | A recording exists. A row that shows "Processing" is asked again near the time when the recording should be ready. | — |
| "Expired" | Recording column | A recording exists. If Sequential has an index of its recording, and the session is older than the replay period of the project, the row shows "Expired". | — |
| "Unplayable" | Recording column | A recording exists. "Unplayable" means that Sequential never received the full recording, so the player cannot play it. | — |
| "Not known" | Recording column, with "Sequential did not send the state of this recording with the list. The player asks for it when you open the session." | A row shows this when it gets no state with the list. | — |
| "No recording" | An Evidence card | On Evidence, a card shows the state of the recording in place of its moment. | — |
| "Sequential has the recording of this session, but no event of the site or app carries its id. So this page has no session details and no judge’s reading for it." | The session page, above the player | The ids do not match. Its session page still plays the recording. | — |
| "This session is not here." | The session page | Shown only when Sequential has no events and no recording for the id. | — |

The sessions of each page get their state with the page. If the read of the states fails or takes too long, a row gets no state. A row also gets none when Sequential finds no part of the recording near the dates of the list.

In Evidence, Workbench › Sessions and on a person's page, the app then asks Sequential for the state of such a row, and the row changes when the answer comes. Ask results and the sample sessions of a case get their state with the answer.

### What a row on Workbench › Sessions shows

For the columns, see [Find and replay sessions](/docs/sessions-and-replay). The list shows no session id.

The time, the Duration and the Pages of a row count only the events in your window. From 9 October 2026, a filter decides which sessions are listed, not which of their events count. Duration is the time from the first event to the last. So if a session crosses the edge of the window, the row shows only the part in the window.

### More checks in a replay

1. To see the events of a session in Workbench › Events, open the full page of the session.
2. Click **All events of this session**.
3. Look at the address of the full page. It is `/sessions/` and then the session id.
4. Check What they did under the player. For a session with a recording, it lists the events that your SDK sent from 5 minutes before the recording starts to 5 minutes after it ends. It shows at most the first 2,000. For a session without a recording, the list comes from search: the newest 1,000 events of the session in the last 30 days, at most.

## Events without a session

If an event arrives with no session id, Sequential stores it with an empty id. The event still counts as an event on Workbench › Events, Funnels, Flows and Retention, and on People. But the empty id is never a session:

| Effect | What happens |
|---|---|
| Not in the list | Evidence, Workbench › Sessions and the agent tool `list_sessions` never show a row for it. |
| Not counted as a session | The visits column on People, such as "Visits, 7 days", and the Sessions column on Workbench › Accounts do not count it. |
| No replay link | Sequential cannot match it to a recording. |
| Never judged | Evidence, Ask and background judging skip it. |

To find these events, open Workbench › Events and filter on Session id with "is not set (not in a session)".

### Why an event has no session id

- Mixpanel in a browser where the recorder has never registered an id. For example: no recorder, recording off, only excluded pages visited, or events sent on a first visit before the recorder registers its id.
- Events that your server sends with the [backend SDK](/docs/backend-sdk) without the browser context of the request, or with a context that Sequential drops because it belongs to a different visitor.
- Profile-only updates that some SDKs send outside a session, such as calls to Amplitude's Identify API.

An Amplitude `session_id` of -1 is not an event without a session: see the FAQ.

## What a session needs to be judged

Background judging is the source of the judgments on Evidence. It picks up a session only if all these conditions are true:

- It has a session id.
- It has at least 3 events that are not System events.
- It has had no new event for 30 minutes.
- Its last event is in the past 7 days. Sequential never judges older sessions automatically. This is also true when background judging is turned on again.
- Background judging is on for your project and on your Sequential server.

If more events arrive later under the same id, Sequential does not add them to the judgment. This is important for ids that last a long time, such as the recorder's own id.

Background judging is on by default. Owners and admins turn it off or on under Settings › Recording & data › Judging, with "Judge new sessions automatically" ([Evidence: the sessions worth a look](/docs/watch)).

### When the judgment arrives

Your Sequential server must also allow background judging. If it is off, Settings › Recording & data says why, under Background judging.

Background judging reads events, so it does not need a recording. Events that are not System events are page views, clicks, mobile gestures, form submits, identifies, errors, rage and dead clicks, or custom events ([Events](/docs/events)).

Sequential looks for sessions to judge every 5 minutes. So the earliest judgment arrives 30–35 minutes after the last event. It takes longer in these cases:

- Many sessions are waiting. Each check picks up at most 500 sessions per project.
- Your project has used its daily judging allowance. Then sessions wait until it resets at midnight UTC.

## Common problems

### Symptoms, causes and fixes

| Symptom | Cause | Fix |
|---|---|---|
| A session has no judgment | It misses a condition: a session id, at least 3 events that are not System events, 30 minutes with no new event, a last event in the past 7 days, background judging on. Or its judgment has not arrived yet. A short session is never judged later. If a session has fewer than 3 non-System events after 30 idle minutes, later events do not change this. | See [What a session needs to be judged](#what-a-session-needs-to-be-judged), [When the judgment arrives](#when-the-judgment-arrives) and [Why is a session marked too short?](#why-is-a-session-marked-too-short) |
| A session has events but no replay | The events and the recording use different ids. Or sampling left the session out: it still gets its id, but has no recording. Or the recording expired, or its id has another format. An event with no session id has no replay link. | See [Check your sessions](#check-your-sessions), [Sampling and early stops](#sampling-and-early-stops), [What the Recording column and the session page say](#what-the-recording-column-and-the-session-page-say) and [Events without a session](#events-without-a-session). |
| A new session starts on each page load | If the browser blocks site storage, the Sequential SDK starts a new session on each page load. The recorder creates its own id. So the events of that visitor do not join their recording. | See [Sampling and early stops](#sampling-and-early-stops). |
| Sequential SDK events do not join the recording while another analytics SDK runs | Another analytics SDK takes the recording: PostHog, Amplitude, Pendo, Smartlook or Mixpanel also runs. The recorder takes the id of the Sequential SDK only if no other analytics SDK on the page gives one. | See [How the recorder picks the id](#how-the-recorder-picks-the-id). |
| A Mixpanel session lasts all day | You do not register your own `$session_id`. See the Mixpanel row of [When a session ends, per SDK](#when-a-session-ends-per-sdk). | See [End Mixpanel sessions after idle time](#end-mixpanel-sessions-after-idle-time). |
| Mixpanel events join an old session | After the recorder runs, events on excluded pages or with recording off go into the last recorded session. | See [Why do Mixpanel events join an old session?](#why-do-mixpanel-events-join-an-old-session) |
| A session with an id in another format has events but no replay | Session ids have a fixed format. Sequential refuses recordings under any other id. | Use at most 128 letters, digits, dots, underscores, colons or hyphens. A UUID works. |
| One session -1 holds the events of all users | Amplitude -1 is a real session. Sequential joins all users' -1 events into one session and can judge it. | Do not send `session_id` -1. To find it, see [Why does an Amplitude site have a session -1?](#why-does-an-amplitude-site-have-a-session-1) |
| Server events are in no replay and no judgment | Without the browser context, the event is in no session, so it is in no replay and no judgment. | With the [backend SDK](/docs/backend-sdk), send the browser context of the request with each event. |

For other problems, see [Troubleshooting](/docs/troubleshooting).

## Limits

- Workbench › Sessions loads 50 sessions at a time. Evidence also loads 50 at a time ([Find and replay sessions](/docs/sessions-and-replay#limits)).
- Ask reads at most 2,000 sessions. It takes the newest 2,000 of the last 7 days, and ignores the rest.

## FAQ

### Why is a session marked too short?

Some sessions have 3 or more events, but fewer than 3 that are not System events. After 30 minutes with no new event, Sequential marks such a session too short. It never judges the session, even if more events arrive later under the same id.

### What do Ask and the judge's reading need?

- Ask looks only at sessions with a session id and at least 3 events of any kind. Of those in the last 7 days, it takes the newest 2,000.
- The judge's reading on the session page shows the judgment from background judging. It does not need a recording. For a session with fewer than 3 events, it says "The judge reads sessions with 3 events or more." Before the judge reads a session, it says "This one has no reading yet."

More: [Judgments](/docs/judgments).

### Why do Mixpanel events join an old session?

Mixpanel keeps the id that the recorder registers as a super property. All tabs of your site share this id. Mixpanel keeps it across visits. So after the recorder has run in a browser, the Mixpanel events that it does not cover still have a session id.

These events carry the id that the recorder registered most recently, so they go into that older session:

- events sent while the recorder starts in a new tab
- events on excluded pages
- events after you turn recording off

### End Mixpanel sessions after idle time

1. Register a `$session_id` super property with Mixpanel.
2. Change it when a visit ends. The recorder finds the change.

Use an id of at most 128 characters. Use only letters, digits, dots, underscores, colons or hyphens. A UUID works. Sequential refuses recordings under any other id, so the session has events but no replay ([A session with an id in another format has events but no replay](#msg-session-id-format)).

More about Mixpanel: [Mixpanel](/docs/mixpanel).

### Why does an Amplitude site have a session -1?

Amplitude uses a `session_id` of -1 to mark events outside a session. Sequential does not treat these events as events without a session. It stores -1 like any other id.

- All such events, from all users, form one session in Workbench › Sessions, with the session id -1.
- Unlike events without a session id, this is a session. Sequential can judge it, and Ask can return it.
- If you send Amplitude events yourself, do not send `session_id` at all. Do not send -1.

To check your site, look for the session -1. In Workbench › Events, add the filter Session id is `-1`.

## Related pages

- [How Sequential works](/docs/how-it-works)
- [Events](/docs/events)
- [User ids and identity](/docs/users-and-identity)
- [Judgments](/docs/judgments)
- [Find and replay sessions](/docs/sessions-and-replay)
