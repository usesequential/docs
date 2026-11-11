# How Sequential works

> Your SDK sends events. About 30 minutes after a session's last event, the judge reads it. Problems in the events open cases, and Sequential measures each fix.

> **Key facts**
>
> - Your existing SDK sends events. You do not add a second analytics SDK.
> - The recording and the events share a session id. The ids must match exactly.
> - About 30 minutes after a session's last event, the AI judge reads its events, not the video.
> - Problems in the events open cases. The judge only ranks a case. It does not open one.
> - When a release names a case, Sequential counts sessions before and after it.

## What it needs

- Events with a session id, from a [supported SDK](/docs/install). The judge does not read a session that has a recording but no analytics events.
- For web replays with PostHog, Mixpanel, Amplitude or Pendo: the [recorder](/docs/session-replay).
- [Named custom events](/docs/custom-events), such as `checkout_completed`, for the moments that matter in your product. They give the judge named milestones. Without them, it sees only generic activity.
- Background judging on for the project. It is on by default. Your Sequential server must also allow it. Owners and admins turn it on or off in Settings › Recording & data › Judging › Judge new sessions automatically. Other roles can read the setting but not change it.
- A release that [names the case](/docs/findings#mark-a-release), to measure a fix.

## From event to measured fix

1. Your SDK sends events. Each event carries a key that names your project.
2. Sequential stores each event with the name your SDK gave it and one of ten classes, such as Page view, Click or Custom.
3. Optional: the recorder uploads the recording. Sequential judges sessions without a recording from their stored events, as for any session.
4. Sequential joins the events and the recording to the session by session id.
5. The judge reads the session's events against your project's [questions](/docs/rubric) (background judging). It starts after 30 minutes with no new events.
6. Every 15 minutes by default, Sequential checks the events for problems. A problem that passes the bar opens a case. See [How a case opens](#how-a-case-opens).
7. You [hand off the case](/docs/findings#hand-off-a-case) to an agent and link the fix: a pull request, commit or issue.
8. When a [release names the case](/docs/findings#mark-a-release), an hourly job counts sessions before and after that release.

### Which SDKs and keys Sequential accepts

- Sequential accepts events from PostHog, Mixpanel, Amplitude, Pendo, the Smartlook compatibility script, Sequential's own SDK and its [backend SDK for Node](/docs/backend-sdk).
- Each SDK sends its events in its own format.
- Each project has its own ingest key for each source.
- On the routes of the browser and mobile SDKs, Sequential rejects HTTP libraries and server-side SDKs as bot traffic. Examples: posthog-node, curl, axios.
- PostHog's mobile SDKs for iOS, Android, React Native and Flutter are not rejected.
- The backend SDK has its own route and a server key. That route does not reject HTTP clients.

See [What each SDK supports](/docs/support-matrix).

### How Sequential classifies events

- The ten classes are Page view, Click, Form submit, Identify, Error, Rage click, Dead click, Custom and System.
- If Sequential has no rule for a name, the event becomes Custom. This includes your own events and vendor events that Sequential does not list.
- Known vendor housekeeping events become System. For example: page-leave and web-vitals events.
- Sequential stores System events but hides them by default.

See [Events](/docs/events).

### How the recorder shares the session id

- The recorder reads the session id of your analytics SDK: PostHog, Amplitude, Mixpanel, Pendo, the Smartlook compatibility script or Sequential's own SDK.
- If the SDK has no session id, the recorder makes one. It registers that id with PostHog, Mixpanel or Pendo, so their events carry it too.
- The ids must match exactly. If your SDK and the recorder report different session ids, the recording loses its events.

See [Session replay (web)](/docs/session-replay) and [Mobile apps](/docs/mobile).

### What the judge returns

- Sequential sends a short text digest of the session's events, with your project's questions, to the judge.
- The judge answers each question with probabilities. Sequential stores these numbers.
- A signal reads as yes at a chance of "70%" or more, and as unclear from "40%".
- Sequential builds the sentences you read from these numbers. The judge writes no prose.

See [Questions: what the judge asks](/docs/rubric) and [Judgments](/docs/judgments).

### What the digest contains

The judge never watches the video. It reads a digest of your stored events.

- The judge sees pages, clicks, form submits, errors, failed requests, rage and dead clicks, and your custom events. A custom event comes with a short summary of its properties.
- The digest carries paths, not hosts. It cuts every web address in any text to its path.
- The digest shortens labels.
- The digest includes no user id and no email.
- The digest drops a custom-event property when a whole part of its key is a personal-looking word, such as email, name or phone. See [AI and third parties](/docs/ai-and-third-parties).
- From the recording, the judge takes only the error counts that the recording measured: JS errors, failed requests and console errors.
- If the recording did not measure a count, the digest leaves it out. Sequential never sends a missing count as zero. See [DevTools in replays](/docs/devtools).
- In a very long session, the digest can leave out late custom events. See [Why a judgment is late, missing, incomplete or out of date](#exact-limit-behaviours).

## Where you see the results

| Where | What it shows | When |
|---|---|---|
| The app | Your events. | About 60 seconds after they arrive. |
| [Evidence](/docs/watch) | The week's sessions, in the lanes Broke for the user, Struggled and Minor. | After the judge reads a session, usually 30–35 minutes after its last event. |
| The session page | The judge's reading. Each reading has Right and Wrong. | Usually 30–35 minutes after the session's last event. |
| [Cases](/docs/findings) | The problems found in the events. Each case has a stage, such as New or Measuring. | At the next check for problems, every 15 minutes by default. |
| A case: Did the fix work? | Sessions that hit the problem before and after the release that names the case. | Every hour, after a release names the case. |
| [Questions](/docs/rubric) | What the judge asks, and Calibration: how often people agree with the judge. | When people answer Right or Wrong. |

A judgment can come later, or not at all. See [Why a judgment is late, missing, incomplete or out of date](#exact-limit-behaviours).

A Right or Wrong mark does not judge the session again. It measures the judge: the judge's reading asks "Was the judge right?". See [Feedback and calibration](/docs/feedback-and-calibration).

### How a case opens

The judge does not open cases. Sequential checks the events for problems every 15 minutes by default. Judgments only rank the cases.

| Problem | Opens a case at |
|---|---|
| From the first session: a JS error in your own code, or a failed request with a 5xx status or with no status, such as a network failure or a timeout | One session from any person. |
| From repeats: dead clicks, rage clicks, dead ends and requests with a 4xx status | The same problem in at least 3 sessions from at least 2 people in the last 7 days. |
| A dead end that people leave with Back | At least 6 sessions from at least 4 people, and at least "20%" of the sessions that visited the page. |

Never a case:

- an error from a browser extension
- an error only in code that the browser itself puts into the page (from 1 November 2026)
- a known browser notice that is not an error of the site
- an error or request on a known ad, analytics or tag host
- a request that the page or the browser stopped

See [Cases](/docs/findings).

### From hand-off to a measured fix

Each case moves along five steps: New, Handed off, Fix linked, Shipped, Measured. See [The stages](/docs/findings#the-stages).

| Stage | What it means |
|---|---|
| New | Nobody has picked this up yet. |
| Handed off | The brief left Sequential. No fix is linked yet. |
| Fix linked | A fix is linked. It is not in a release yet. |
| Shipped | A release claims to fix it. Measuring starts soon. |
| Measuring | The fix shipped. Sequential is counting sessions before and after. |
| Fixed | No new occurrence since the fix, with enough traffic to tell. |
| Improved | The rate fell since the fix, but not to zero. |
| No change | The fix shipped. The rate did not change enough to tell. |
| Worse | The rate rose since the fix. |
| Regressed | It was fixed, or quiet since the fix, then it came back. |
| Not measured | There is nothing to compare yet. |
| Quiet since the fix | From 4 November 2026, for a case from your server. No occurrence in the 28 days after the fix, but it happened too rarely before it to prove it fixed. Sequential keeps watching your server for it. |

1. On the case, click **Copy brief for an agent**, or **Hand to an agent** when a webhook is set up ([Hand off a case](/docs/findings#hand-off-a-case)).

   Result: The case moves to Handed off.

2. Under **Fix**, paste the URL of the pull request, commit or issue. Click **Link**.

3. Name the case in the release that ships the fix. An owner or an admin can also click **The fix is live** on the case. Then Sequential measures it. See [Record that the fix is live](/docs/findings#record-that-the-fix-is-live).

- Sequential counts the sessions with an event on the case's page, and from 4 November 2026 also the sessions that hit the problem in that window. Of these, it counts the sessions that hit the problem.
- The before window is up to 14 days before the release. Sequential counts it once and keeps it.
- The after window is up to 28 days after the release.
- A fixed case is watched for 30 days for a return. A case that is quiet since the fix is watched for as long as it is open.
- "Did the fix work?" says how many sessions after the release it needs to decide. The counts and the percent before and after are in the case's How counted text, for example "Before 2.4.0: 41 of 1,203 (3.4%) sessions hit it." From 9 November 2026, when the summary at the top of the case page shows the before and after bars, the card says the stage in words, for example "The rate fell since the fix, but not to zero.", and does not repeat the bars.
- If a count fails, Sequential keeps the previous result. A failed count never becomes 0.
- A case from your server alone has no sessions. Sequential counts its occurrences per day instead.

See [Mark a release](/docs/findings#mark-a-release).

## Limits

- The judge reads each session once. It does not see events that arrive later.
- A session needs at least 3 events that the judge can read. System events do not count.
- Judging looks back 7 days. When background judging is turned on, Sequential does not judge sessions that ended before that.
- The judge never reads events without a session id.
- Dead clicks, rage clicks, dead ends and requests with a 4xx status need the same problem in at least 3 sessions from at least 2 people in the last 7 days. See [How a case opens](#how-a-case-opens).
- Background judging stops when its daily allowance is used up, until the reset at midnight UTC. See [Limits](/docs/limits).
- A case needs a release that names it. Without one, Sequential does not measure the fix.

### Why a judgment is late, missing, incomplete or out of date

| Limit | What happens |
|---|---|
| Timing and throughput | A judgment comes no sooner than 30 minutes after the last event of the session. Sequential checks for sessions to judge every 5 minutes. So the judgment usually comes 30–35 minutes after the last event. A judgment takes longer when many sessions wait in the queue. It also takes longer when the daily allowance is used up. Each check picks up at most 500 sessions per project. |
| Daily allowance | Background judging has its own daily allowance. Ask, agents and Try on a session each use a separate one ([Limits](/docs/limits)). When the allowance is used up, background judging stops until the reset at midnight UTC. Then it judges the newest sessions first. From 5 November 2026, a waiting session is not tried again every hour. A session whose last event is more than 7 days old is not judged. |
| Automatic judging on the server | If your Sequential server does not allow automatic judging, the project switch alone does not start it. Ask the person who runs your Sequential server. |
| Short sessions | A session with fewer than 3 events that the judge can read is too short. System events do not count. The judge never reads it. |
| Lasting failures | If judging fails for a lasting reason, Sequential marks the session failed and does not try it again. That session never gets a judgment. For example: the session is still too large after Sequential shortens it. |
| Other server-side SDKs | Other server-side SDKs are rejected. On the routes of the browser and mobile SDKs, Sequential treats events from posthog-node, curl or axios as bot traffic. To send events from your own server, use the [backend SDK](/docs/backend-sdk). |
| Very long sessions | Sequential shortens very long sessions. The judge reads at most 255 events per session, so it can miss a late milestone. |
| Shortening | The judge leaves out mobile gestures first, then plain clicks, then custom events. Errors and failed requests stay longest. Of each kind, the earlier events stay. |
| The questions | A change to the questions does not judge old sessions again. It applies only to sessions judged from then on. A job judges with the questions as they are when the job runs. The session page of an earlier session says "The questions changed since; this reading is from the earlier version." |

## Related pages

- [What is Sequential](/docs/what-is-sequential): the product in short.
- [Quickstart](/docs/quickstart): your first hour.
- [Sessions and session ids](/docs/sessions): what one session id joins.
- [AI judgments of sessions](/docs/judgments): what the judge stores.
- [Feedback and calibration](/docs/feedback-and-calibration): what Right and Wrong measure.
