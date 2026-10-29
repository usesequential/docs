# Check that your install works

> How to tell that events arrive in Sequential after you install an SDK, and what each failure looks like, for every SDK that Sequential accepts.

## Where Sequential shows the first event

Step 3 of the project setup (**Install Sequential on** your project) says "Waiting for the first event." until the first event arrives from any source. Then it says **It works** and names the source, for example "The first event came from a recording". It checks again every 5 seconds while the tab shows, for 30 minutes.

On Settings › Setup, **Sources** has a line for each source. It says "receiving" and how long ago, when the source sent an event in the last 7 days. Otherwise it says when the last event came, or "no events yet". A source of another tool gets a line after its first event. While a source has no events, the page checks every 5 seconds, for 5 minutes. Settings › Project shows the same lines.

Events are written in batches, so allow up to about a minute. A recording can take up to about 7 minutes to show.

## In the browser

Open the site in a normal browser, open developer tools → Network, and filter by the Sequential API host.

| You see | It means |
|---|---|
| 200 / 204 | Accepted. |
| 401 `unknown_ingest_key` | The key is wrong, revoked, or belongs to another source. A PostHog key only works with PostHog, a replay key only with the recorder, and so on. |
| 403 `Bot traffic not allowed` | The request looked automated: a headless browser, curl, a server-side SDK. Test in a normal browser. To send events from your own server, use the [backend SDK](/docs/backend-sdk). |
| 403 `replay disabled for tenant` | Session replay is switched off for the project. |
| 413 | The request was too large: over 1 MB for most event requests, or over the per-session replay size. |
| 429 with `Retry-After` | The project went over a rate limit: 20,000 events a minute, or the replay upload limit. The Sequential SDK and the recorder wait, then send again. See [Limits](/docs/limits). |
| Blocked, no status | The page’s Content-Security-Policy refused it. See the CSP section of the SDK’s page. |

Session replay: `window.__lxReplaySessionId` in the console shows the current recording’s session id. `window.__lxReplayFlush()` sends what is buffered now instead of waiting.

## Things that look broken but are not

- Nothing is recorded for a visit shorter than the project’s minimum replay duration (2 s by default; the project’s own value is under Settings › Recording & data).
- A project’s sampling setting can skip a session on purpose. New non-production projects record 10 % of sessions.
- PostHog feature flags evaluate as off. Sequential does not serve flags.
- Automated end-to-end tests do not show up. Sequential rejects headless browsers as bots, and posthog-js itself drops events when it detects automation (`navigator.webdriver`, a HeadlessChrome brand), before anything is sent.
