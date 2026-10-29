# How Sequential works

> Your SDK sends events. Sequential joins them to the session by session id. About half an hour after a session ends, the judge reads it. Problems in the events open cases, and Sequential measures each fix.

> **In short**
>
> - Your existing SDK sends events to Sequential. You do not add a second analytics SDK.
> - Sequential gives each event one of nine classes and stores it.
> - The recording and the events share a session id.
> - About 30 minutes after the last event of a session, the judge reads its events against your project's questions.
> - Problems in the events, such as errors and failed requests, open cases. The judge's reading ranks a case. It does not open one.
> - When a release names a case, Sequential counts sessions before and after it.

## From event to measured fix

1. **Your SDK sends events.** Each event carries a key that names your project.
2. **Sequential classifies and stores each event.** Each event keeps the name your SDK gave it. It also gets one of nine classes, such as Page view, Click or Custom.
3. **The recorder uploads the recording.** This step is optional.
4. **The events and the recording share a session id.** Matching ids join the events to the recording.
5. **The judge reads the session's events.** It starts when a session has no new events for 30 minutes. The session must have at least 3 events that the judge can read.
6. **Sequential finds problems in the events.** A problem that passes the bar opens a case on **Cases**.
7. **You hand off the case and link the fix.** Copy the brief for an agent, or hand it to an agent. Then link the pull request, commit or issue.
8. **Sequential measures the fix.** When a release names the case, an hourly job counts sessions before and after that release.

### Which SDKs and keys Sequential accepts

- Sequential accepts events from PostHog, Mixpanel, Amplitude, Pendo, the Smartlook compatibility script, Sequential's own SDK and its [backend SDK for Node](/docs/backend-sdk).
- Each SDK sends its events in its own format.
- Each project has its own ingest key for each source.
- On the routes of the browser and mobile SDKs, Sequential rejects HTTP libraries and server-side SDKs as bot traffic. Examples: posthog-node, curl, axios.
- PostHog's mobile SDKs for iOS, Android, React Native and Flutter are not rejected.
- The backend SDK has its own route and a server key. That route does not reject HTTP clients.

See [What each SDK supports](/docs/support-matrix).

### How Sequential classifies events

- The nine classes are Page view, Click, Form submit, Identify, Error, Rage click, Dead click, Custom and System.
- If Sequential has no rule for a name, the event becomes Custom. This includes your own events and vendor events that Sequential does not list.
- Known vendor housekeeping events become System. For example: page-leave and web-vitals events.
- Sequential stores System events but hides them by default.

See [Events](/docs/events).

### How the recorder shares the session id

- The recorder reads the session id of your analytics SDK: PostHog, Amplitude, Mixpanel, Pendo, the Smartlook compatibility script or Sequential's own SDK.
- If the SDK has no session id, the recorder makes one. It registers that id with PostHog, Mixpanel or Pendo, so their events carry it too.
- The ids must match exactly. Else the recording loses its events.

See [Session replay (web)](/docs/session-replay) and [Mobile apps](/docs/mobile).

### What the judge returns

- Sequential sends a short text digest of the session's events, with your project's questions, to the judge.
- The judge answers each question with probabilities. Sequential stores these numbers.
- A signal reads as yes at a chance of "70%" or more, and as unclear from "40%".
- Sequential builds the sentences you read from these numbers. The judge writes no prose.

See [Questions: what the judge asks](/docs/rubric) and [Judgments](/docs/judgments).

## Where you see the results

| Where | What it shows | When |
|---|---|---|
| **Evidence** | The sessions of the week, in the lanes **Broke for the user**, **Struggled** and **Minor**. | After the judge reads a session, usually 30–35 minutes after its last event. |
| The session page | The judge's reading. Each reading has **Right** and **Wrong**. | Same as **Evidence**. |
| **Cases** | The problems that Sequential found in the events. Each case has a stage, such as **New** or **Measuring**. | At the next check for problems, every 15 minutes by default. |
| A case: **Did the fix work?** | The sessions that hit the problem before and after the release that names the case. | Every hour, after a release names the case. |
| **Questions** | What the judge asks, and **How often people agree with the judge**. | When people answer **Right** or **Wrong**. |

**Right** or **Wrong** on a reading does not judge the session again. It tells everyone how far the judge can be trusted. See [Feedback and calibration](/docs/feedback-and-calibration).

### How a case opens

The judge does not open cases. Sequential checks the events for problems every 15 minutes by default. The judge's readings only rank the cases.

- **From the first session:** a JS error, or a failed request with a 5xx status or with no status, such as a network failure or a timeout. One session from any person opens the case.
- **From repeats:** dead clicks, rage clicks, dead ends and requests with a 4xx status. These need the same problem in at least 3 sessions from at least 2 people in the last 7 days.
- **A dead end that people leave with Back:** at least 6 sessions from at least 4 people, and at least "20%" of the sessions that visited the page.
- **Never a case:** an error from a browser extension, a known browser notice that is not an error of the site, an error or request on a known ad, analytics or tag host, and a request that the page or the browser stopped.

See [Cases](/docs/findings).

### From hand-off to a measured fix

Each case moves along five steps: **New**, **Handed off**, **Fix linked**, **Shipped**, **Measured**.

| Stage | What it means |
|---|---|
| **New** | Nobody has picked this up yet. |
| **Handed off** | The brief left Sequential. No fix is linked yet. |
| **Fix linked** | A fix is linked. It is not in a release yet. |
| **Shipped** | A release claims to fix it. Measuring starts soon. |
| **Measuring** | The fix shipped. Sequential is counting sessions before and after. |
| **Fixed** | No new occurrence since the fix, with enough traffic to tell. |
| **Improved** | Fewer occurrences since the fix, but not zero. |
| **No change** | The fix shipped and the numbers did not move. |
| **Worse** | More occurrences since the fix than before it. |
| **Regressed** | It was fixed, then it came back. |
| **Not measured** | There is nothing to compare yet. |

1. On the case, click **Copy brief for an agent**, or **Hand to an agent** when a webhook is set up. The case moves to **Handed off**.
2. Under **Fix**, paste the URL of the pull request, commit or issue. Click **Link**.
3. Name the case in the release that ships the fix. Then Sequential measures it.

- Sequential counts the sessions with an event on the case's page. Of these, it counts the sessions that hit the problem.
- The before window is up to 14 days before the release. Sequential counts it once and keeps it.
- The after window is up to 28 days after the release.
- A fixed case is watched for 30 days for a return.
- **Did the fix work?** shows the counts and the percent before and after, for example "Before 2.4.0: 41 of 1,203 (3.4%) sessions hit it." It says how many sessions after the release it needs to decide.
- If a count fails, Sequential keeps the previous result. A failed count never becomes 0.
- A case from your server alone has no sessions. Sequential counts its occurrences per day instead.

### How long each step takes

| Step | When |
|---|---|
| Events in the app | About a minute. Events show about 60 seconds after they arrive. |
| A reading of the judge | Usually 30–35 minutes after the last event of the session. |
| A new case | At the next check for problems. The check runs every 15 minutes by default. |
| A measurement of a fix | The job runs every hour. |

- A reading comes no sooner than 30 minutes after the last event of the session.
- Sequential checks for sessions to judge every 5 minutes. So the reading usually comes 30–35 minutes after the last event.
- A reading takes longer when many sessions wait in the queue. It also takes longer when the daily allowance is used up.

## Why the events matter more than the recording

The judge never watches the video. It reads a digest of your stored events.

- **A session without events gets no reading.** The judge does not read a session that has a recording but no analytics events.
- **Sequential judges sessions that have no recording.** It reads them from their stored events, as for any session.
- **Custom events name your milestones.** A custom event such as `checkout_completed` gives the judge a named milestone. Without custom events, it sees only generic activity.

### What the digest contains

- The judge sees pages, clicks, form submits, errors, failed requests, rage and dead clicks, and your custom events. A custom event comes with a short summary of its properties.
- The digest carries paths, not hosts. It cuts every web address in any text to its path.
- The digest shortens labels.
- The digest includes no user id and no email.
- The digest drops a custom-event property when a whole part of its key is a personal-looking word, such as email, name or phone. See [AI and third parties](/docs/ai-and-third-parties).
- From the recording, the judge takes only the error counts that the recording measured: JS errors, failed requests and console errors.
- If the recording did not measure a count, the digest leaves it out. Sequential never sends a missing count as zero. See [DevTools in replays](/docs/devtools).
- In a very long session, the digest can leave out late custom events. See **Limits**.

## What it needs

- Events with a session id, from a supported SDK. See [Install Sequential](/docs/install).
- For replays on the web with PostHog, Mixpanel, Amplitude or Pendo: the recorder tag. See [Session replay (web)](/docs/session-replay).
- Named custom events for the moments that matter in your product. See [Send custom events](/docs/custom-events).
- Background judging on for the project. It is on by default. Your Sequential server must also allow it.
- A release that names the case, to measure a fix.

> **Where to turn background judging on or off**
>
> Owners and admins use **Judge new sessions automatically**, under **Settings** › **Recording & data** › **Judging**. Other roles can read the setting but not change it. If the server does not allow automatic judging, the project switch alone does not start it. Ask the person who runs your Sequential server.

## Limits

- **The judge reads each session once.** It does not see events that arrive after the reading.
- **A change to the questions does not judge old sessions again.** It applies only to sessions judged from then on. The session page of an earlier session says "The questions changed since; this reading is from the earlier version."
- **Old sessions are not judged.** Judging looks back 7 days. When background judging is turned on, Sequential does not judge sessions that ended before that.
- **Short sessions are skipped.** A session with fewer than 3 events that the judge can read is too short. System events do not count. The judge never reads it.
- **Sequential shortens very long sessions.** The judge reads at most 255 events per session, so it can miss a late milestone.
- **Ids must match exactly.** If your SDK and the recorder report different session ids, the recording loses its events. The judge never reads events without a session id.
- **Other server-side SDKs are rejected.** On the routes of the browser and mobile SDKs, Sequential treats events from posthog-node, curl or axios as bot traffic. To send events from your own server, use the [backend SDK](/docs/backend-sdk).
- **Judging stops when the daily allowance is used up.** Background judging has its own daily allowance. **Ask**, agents and **Try on a session** each use a separate one ([Limits](/docs/limits)). Background judging waits for the reset at midnight UTC.
- **A failed reading is not tried again.** If judging fails for a lasting reason, Sequential marks the session failed. That session never gets a reading.
- **A case needs a release that names it.** Without one, Sequential does not measure the fix.

### Exact limit behaviours

| Limit | What happens |
|---|---|
| Lasting failures | If judging fails for a lasting reason, Sequential marks the session failed and does not try it again. For example: the session is still too large after Sequential shortens it. |
| Throughput | Each check picks up at most 500 sessions per project. |
| Daily allowance | When the allowance is used up, a waiting session is tried again an hour later. So judging can resume up to an hour after the reset at midnight UTC. |
| Shortening | The judge leaves out plain clicks first, then custom events. Errors and failed requests stay longest. Of each kind, the earlier events stay. |
| The questions | A job judges with the questions as they are when the job runs. |

## Related

- [What is Sequential](/docs/what-is-sequential)
- [Your first hour](/docs/quickstart)
- [Sessions](/docs/sessions)
- [Judgments](/docs/judgments)
- [Evidence](/docs/watch)
- [Cases](/docs/findings)
- [Questions: what the judge asks](/docs/rubric)
- [Feedback and calibration](/docs/feedback-and-calibration)
- [Limits](/docs/limits)
