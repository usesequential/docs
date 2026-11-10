# Limits and defaults

> Limits and defaults on session replay, events, lists, AI judging, Ask, reading your data, sign-in, API access and exports, and what happens at each one.

> **In short**
>
> - Most limits count per project. Some count per person, per network address or per server. The row says so.
> - Daily allowances per project: 5,000,000 input tokens for background judging. Ask in the app: 2,000,000. Ask from an agent: 2,000,000.
> - The daily allowances reset at midnight UTC. The app does not show the allowances or how much of them is used.
> - [Some lists](#lists-and-reports) stop at 10,000 rows and do not say so. Narrow the dates or add a condition.
> - Some values look like limits, but Sequential does not apply them. See [Values that are not enforced](#values-that-are-not-enforced).
>
> For a refused request, see [Refusals by status code](#refusals-by-status-code).

## Limits most teams meet

| Limit | Value | Section |
|---|---|---|
| One upload from a website | 5 MB before compression. Server default | [Uploads](#uploads) |
| Largest recording | 25 MB per session, counted before compression. Project default | [Per session](#per-session) |
| How long you can play a replay | 30 days by default. A server-wide limit can make it shorter. Only Sequential support can change it, for all the projects of the organisation | [Per session](#per-session) |
| Events a project sends | 20,000 events a minute, for all SDKs and keys of the project together. Server default | [Events](#events) |
| Background judging | 5,000,000 input tokens per project per UTC day. Server default | [Daily allowances](#daily-allowances) |
| Ask in the app | 2,000,000 input tokens per project per UTC day. Server default | [Daily allowances](#daily-allowances) |
| Ask from an agent | 2,000,000 input tokens per UTC day. All tokens of the project share it. Server default | [Ask from an agent](#ask-from-an-agent) |
| The Cases page | 100 cases. It does not say when there are more | [Cases and fixes](#cases-and-fixes) |
| Workbench › Sessions, People, Workbench › Accounts | 50 rows a page | [Lists and reports](#lists-and-reports) |
| Reading analytics or replays | 300 requests a minute, per person per project. Server default | [Reading your data](#reading-your-data) |
| Token requests | 120 a minute per token. Server default | [Programmatic access](#programmatic-access) |
| Token expiry | 30, 90 or 365 days. The default is 90. The token that an agent gets with a trial lasts 3 days from setup | [Programmatic access](#programmatic-access) |
| Exports started per project | 3 a day, counted from 00:00 UTC | [Exports](#exports) |

## How to read this page

Values can carry a label:

| Label | Meaning |
|---|---|
| Project default | A new project starts with this value. Owners and admins can change it under Settings › Recording & data. |
| Server default | One value for every project on your Sequential server. You cannot set it per project or see it in the app. See [For self-hosted servers](#for-self-hosted-servers). |
| No label | The limit is built in and is the same everywhere. |

## Refusals by status code

From the SDKs and the recorder:

| Status | Code or message | Where |
|---|---|---|
| 403 | Bot traffic | [Events](#events) |
| 413 | A request of events that is too large | [Events](#events) |
| 413 | A request from the backend SDK with more than 500 events | [Events](#events) |
| 413 | An upload that is too large | [See a replay limit in the browser](#see-a-replay-limit-in-the-browser) |
| 413 | `session_cap` | [See a replay limit in the browser](#see-a-replay-limit-in-the-browser) |
| 429 | `rate_limited`: events over the project's rate | [Events](#events), [Event limits in detail](#event-limits-in-detail) |
| 429 | A request from the backend SDK over the rate | [Events](#events) |
| 429 | Upload volume (per project or per network address) | [See a replay limit in the browser](#see-a-replay-limit-in-the-browser) |
| 503 | `overloaded` | [Events](#events), [When Sequential is overloaded](#when-sequential-is-overloaded) |
| 503 | "The replay upload could not be stored right now. Retry the same block shortly." | [Uploads](#uploads) |

In the app, the settings API and sign-in:

| Status | Code or message | Where |
|---|---|---|
| 400 | `bad_request` | [Agent activity](#agent-activity) |
| 409 | `retention_set_by_organisation` | [Replay limits in detail](#replay-limits-in-detail), [Events retention period](#events-retention-period) |
| 429 | "Too many requests for this project. Try again shortly." | [Reading your data](#reading-your-data) |
| 429 | Over an emailed-code limit or a new-account limit | [Sign-in limits in detail](#sign-in-limits-in-detail) |
| 503 | `budget_unavailable`, `ask_unavailable` | [Daily allowances in detail](#daily-allowances-in-detail) |
| 503 | Sequential cannot check the sign-in limits | [Sign-in limits in detail](#sign-in-limits-in-detail) |
| 503 | Sequential cannot read your connections | [Agent activity](#agent-activity) |

Exports, in the app or with a token:

| Status | Code or message | Where |
|---|---|---|
| 400 | `invalid_export_request` | [Exports](#exports) |
| 409 | `export_in_progress` | [Exports](#exports) |
| 410 | `export_expired` | [Exports](#exports) |
| 422 | `range_before_retention` | [Exports](#exports) |
| 429 | `export_daily_limit` | [Exports](#exports) |

For a project access token (`sq_pat_…`) or an agent:

| Status | Code or message | Where |
|---|---|---|
| 400 | `limit_too_large` | [Ask from an agent](#ask-from-an-agent) |
| 400 | `invalid_body`, `tool_error` | [Token errors](#token-errors) |
| 401 | `invalid_token`, `grant_paused`, `unauthenticated` | [Token errors](#token-errors) |
| 402 | `budget_exhausted` | [Ask from an agent](#ask-from-an-agent), [Daily allowances](#daily-allowances) |
| 403 | `insufficient_scope`, `export_creator_not_admin` | [Token errors](#token-errors) |
| 404 | `not_found`, `unknown_tool` | [Token errors](#token-errors) |
| 404 | `:id` is not the token's project | [Routes a token can use](#routes-a-token-can-use) |
| 405 | GET or DELETE on `/mcp` | [Token errors](#token-errors) |
| 429 | `rate_limited`: "Too many requests for this access token. Try again shortly." | [Programmatic access](#programmatic-access) |
| 429 | `project_rate_limited` | [The project read limit for tokens](#the-project-read-limit-for-tokens) |
| 429 | `token_daily_limit`, `ai_concurrency` | [Ask from an agent](#ask-from-an-agent) |
| 429 or 503 | `busy` | [Refusals, calls at once and properties](#refusals-calls-at-once-and-properties) |
| 500 | `internal_error` | [Token errors](#token-errors), [Session tools in detail](#session-tools-in-detail) |
| 502 | An error of `ask_sessions` | [Token errors](#token-errors) |
| 503 | `ai_busy`, `ai_unavailable` | [Ask from an agent](#ask-from-an-agent) |
| 503 | `rate_limit_unavailable`, `auth_unavailable`, `screen_unavailable`, `export_check_unavailable` | [Token errors](#token-errors) |

## Session replay

### Uploads

| Limit | Value | What happens at the limit |
|---|---|---|
| One upload from a website | 5 MB before compression. Server default | Sequential refuses it. The recorder stops for that page. |
| One upload from a mobile app | 5 MB compressed, 20 MB decompressed. One event in it: 5 MB after Sequential compresses it. Server default | Sequential refuses it. |
| Upload volume | 50 MB a minute per project. 50 MB a minute per network address. Server default | Sequential refuses uploads until the minute ends. Long overloads leave gaps. |
| Storing an upload for replay | At most 2 seconds to store it. Server default | Refused with 503: "The replay upload could not be stored right now. Retry the same block shortly." `Retry-After` is 30 seconds. A retried block is stored once. |
| When a new recording can be played | Sequential collects uploads in 5-minute periods. It prepares each period 30 seconds after the period ends. Server default | You can play a recording only when all its uploads are ready. Until then, a session card shows "Ready by 14:05", with a time, and the player shows "The recording is still being put together. It should be ready by 14:05." The time is at most about 6.5 minutes after the last upload. |

### Per session

| Limit | Value | What happens at the limit |
|---|---|---|
| Largest recording | 25 MB per session, counted before compression. Allowed: 1–500. Project default | Sequential refuses more uploads for the session. Websites: the recorder stops. |
| Longest recording | 60. Allowed: 1–1,440. Project default | Websites: the recorder stops. Counts from each page load. Not sent to mobile apps. |
| Shortest session kept | 2 seconds. Allowed: 0–60 seconds. Project default | Sequential does not record shorter sessions. |
| How long you can play a replay | The organisation's replay period: 30 days by default, counted from when the first part of the recording arrived. One of 7, 30, 90, 180 or 365 days. A server-wide limit can make it shorter: see [A server-wide limit](/docs/retention-and-deletion#a-server-wide-limit). Only Sequential support can change it, for all the projects of the organisation | You cannot play the replay. The player shows "This recording has expired." The storage deletes the recording files about 2 days later. |

### DevTools and the player

| Limit | Value | What happens at the limit |
|---|---|---|
| Per page (websites) | 1 MB of DevTools data. 1,000 network requests | That capture stops for the page. |
| Bursts (websites) | Console messages: 50 at once, then 5 a second. Uncaught errors: 20 at once, then 1 a second | Sequential does not record the rest. |
| Events in What they did under the player | The first 2,000 of a session | "The list stops at the first 2,000 events." |
| Events in What they did for a session without a recording | The newest 1,000 events of the session in the last 30 days, from search | "Without a recording, the list comes from search: the newest 1,000 events of the last 30 days, at most." |

An empty Problems cell does not mean a clean session. The Problems column on Workbench › Sessions shows only errors and failed requests. A session with neither shows "—", even when it reached a DevTools limit. See [DevTools in replays](/docs/devtools).

### Replay limits in detail

Uploads:

- One upload from a website: recording starts again on the next page load. The likeliest cause is a very large page snapshot, which the recorder sends in one upload.
- One upload from a mobile app: PostHog's mobile SDK decides what the app does next.
- Upload volume per project: all the project's visitors share it. The web recorder keeps up to 5 refused uploads. From 23 October 2026, it sends them again after the time that the answer asks for (1 to 300 seconds), or after 30 seconds when the answer gives none. When the page closes, it sends the waiting uploads with the browser's beacon. If more than 5 uploads wait, it drops the oldest, and the `ingest_refusals` check counts it as `replay_upload_lost`. After 5, it drops the oldest, so a long overload leaves gaps in the replay.
- Upload volume per network address: everyone behind that address shares it, whichever project they visit. The web recorder sends refused uploads again, as for the per-project limit. Visitors behind one office network count together.
- Storing an upload for replay: a retried block is stored once. From 22 October 2026, its heatmap counts are added again in its own project.

Per session:

- Largest recording: Sequential refuses more uploads for the session, from websites and mobile apps. On websites, the recorder stops. If Sequential's counter is unavailable, it does not apply the limit. The count starts again when a session sends nothing for 2 hours.
- Longest recording: because it counts from each page load, it limits each page, not the whole session.
- Shortest session kept: on websites it counts from each page load. If a visitor leaves a page sooner, the recorder sends nothing for that page, and Sequential records nothing for that page.
- How long you can play a replay: Settings › Recording & data shows it under How long data is kept › Recordings, for example "30 days". The organisation sets it for all its projects. Only Sequential support can change it. A shorter period deletes nothing: stored recordings keep their old period. Through the settings API, a change of `replay_retention_days` gets 409 `retention_set_by_organisation` and saves nothing. See [Retention and deletion](/docs/retention-and-deletion).

DevTools:

- Per page: at 1 MB, DevTools capture stops for the rest of the page. At 1,000 network requests, network capture stops for the rest of the page.
- One DevTools entry: 64 KB. Sequential does not record a larger entry.
- Sequential counts bursts of uncaught errors separately from console messages.
- At a DevTools limit, the replay's Console tab shows a recorder notice. The DevTools summary of the recording then ends with "(the recorder dropped some entries, so counts are lower bounds)". Sequential does not record a DevTools entry larger than 64 KB.

### See a replay limit in the browser

1. Open your browser's developer tools.

2. Open **Network**.

3. Look at requests to `/rec/`.

- A 413 means an upload was too large or the session reached Largest recording. In the second case the response says `session_cap`.
- A 429 means the page reached an upload budget.

See [Check your install](/docs/verify).

### Heatmap data

Heatmap data is on by default for each project that records websites. Owners and admins turn it on or off under Settings › Recording & data › What a recording carries › Heatmaps. See [Heatmap data](/docs/privacy-overview#heatmap-data).

| Limit | Value | What happens at the limit |
|---|---|---|
| Sessions in the sample | In Settings, Automatic (about 2,000 sessions a day) or A fixed share. Project default: `"auto"` | A session outside the sample gives no heatmap data. |
| Page views | 25,000 a UTC day per project. Server default | Sequential stores no more heatmap data for the project that day. Recordings are not affected. |
| Facts: page views, scroll steps, clicks and counts | 500,000 a UTC day per project. Server default | The same. |
| Different pages | 2,000 a UTC day per project. Server default | The same. |
| Different clicked elements | 100,000 a UTC day per project. Server default | The same. |
| Clicks per page view | 300. Per session: 2,000 | The recorder counts the rest as clicks that it could not place. |

### Heatmap limits in detail

- Sessions in the sample: `"auto"`: about 2,000 recorded sessions a day, from the average of the last 7 full UTC days. A project that records fewer keeps all its sessions. Never less than 1 in 1,000. Or a fixed share from 0.001 to 1. In Settings, the sample is Automatic (about 2,000 sessions a day) or A fixed share, from 0.1 to 100 % of recorded sessions in Heatmap share.
- Sequential picks the sample from the session id, so a session is in or out on every page.
- The recorder gets the share rounded up to 1, 1/2, 1/4 and so on, so that its settings do not reveal your traffic. So the recorder can collect for up to about twice as many sessions as Sequential keeps. Sequential drops the rest when they arrive.
- A session outside the rounded-up share installs no listeners.
- A new project with no recorded days keeps every session.
- Until Sequential has worked out a project's share, for example just after a server starts, it collects no heatmap data for that project.
- If Sequential cannot check the daily limits, it stores no heatmap data until it can. Recordings are not affected.
- With heatmap data on, the recorder that each page loads is about 3.3 KB larger, compressed: about 24 % more, measured with DevTools off. This is on every page load, in the sample or not.
- A heatmap page picture over 4 MB, compressed, is not kept. Sequential answers `too_large` for that page. Sequential also answers `too_large` when the builder refuses a part of the recording: it would use too much memory, it is too dense to read safely, or two earlier attempts on it did not finish. Sequential keeps a `too_large` answer for one hour, and starts no new build for that picture during the hour. Only the builder service builds pictures. A finished picture is kept for at most 15 minutes. See [The page picture](/docs/privacy-overview#the-page-picture).

## Events

| Limit | Value | What happens at the limit |
|---|---|---|
| One request of events | JSON: 1 MB. Compressed batch from a PostHog SDK: 1 MB compressed, 16 MB decompressed. Form-encoded (events in a `data=` field): 56 KB | Sequential refuses it with 413. |
| Sending from your own servers | With the [backend SDK](/docs/backend-sdk) for Node and a server key | On the routes of the browser and mobile SDKs, Sequential refuses a server-side SDK or HTTP client as bot traffic (403). |
| One request from the backend SDK | 500 events and 1 MB. 50 requests a second for each server key. Server default | Sequential refuses a request with more than 500 events with 413, and a request over the rate with 429. The backend SDK keeps each request under 500 events and 1 MB. It does not limit how many requests it sends each second: on a 429, it waits for the `Retry-After` time and sends the batch again. See [Send events from your server](/docs/backend-sdk). |
| Headless browsers | Not accepted | Sequential refuses them as bot traffic (403). Test in a normal browser. |
| A Sequential SDK session | 30 minutes without an event, or 24 hours after it started | The next event starts a new session. |
| A retried request | Stored again if the first attempt was stored | The events count twice. Retries are rare. See [Event limits in detail](#event-limits-in-detail). |
| Events a project sends | 20,000 events a minute, for all SDKs and keys of the project together. Server default | Sequential refuses the batch that goes over the limit with 429 and stores none of its events. The Sequential SDK waits, then sends the batch again. See [Event limits in detail](#event-limits-in-detail). |
| A server that is overloaded | Not a limit of your project | Sequential refuses some event and recording uploads with 503 `overloaded`, and stores none of them. The Sequential SDK and the recorder wait, then send again. See [When Sequential is overloaded](#when-sequential-is-overloaded). |

### Event limits in detail

- The 1 MB JSON limit includes the last batch a page sends as it closes. If Sequential refuses a JSON request, it stores none of that request's events.
- Sending from your own servers: on the routes of the browser and mobile SDKs, examples of clients refused as bot traffic are curl, axios, node-fetch and python-requests. The route of the backend SDK does not refuse them. A project can have at most 10 active server keys.
- Headless browsers: automated tests in a headless browser do not appear.
- A retried request: an SDK sends a request again when it gets a server error or no answer. From 23 October 2026, Sequential stores such a retry only once, when every event in the request carries the SDK's own event id: `uuid` from sequential.js, the backend SDK and PostHog, `$insert_id` from Mixpanel and `insert_id` from Amplitude. The retry must have the same events as the first request, and it must arrive in the same week (weeks start on Monday 00:00 UTC). Pendo and Smartlook send no event ids, so a retry from them counts twice. From 21 to 23 October 2026, Sequential stored every retry again, so it counted twice.
- The event rate limit counts per project, not per key. A new key does not reset it. It counts the events from sequential.js, PostHog, Mixpanel, Amplitude, Pendo, Smartlook and the backend SDK. Session replay has its own limit: see [Session replay](#session-replay).
- Each minute starts at 00 seconds on the clock. At the start of a minute, the project can send its full 20,000 events again.
- If a batch goes over the limit, Sequential refuses the full batch. It does not store a part of it. The refused events still count for that minute.
- The answer is 429 with the body `{ "error": "rate_limited", "retry_after_sec": N }` and a `Retry-After` header. N is the number of seconds to the end of the minute. Pendo gets its image with the 429.
- These requests do not count: a batch with no events, and a request that Sequential refused because the website is not in the project's allowed origins.
- The Sequential SDK on a 429: it waits `retry_after_sec`. If there is none, it waits the `Retry-After` value. If there is none, it waits 60 seconds. The wait is 1 second at minimum and 300 seconds at maximum. During the wait, it keeps the refused batch and the events that it records. It keeps at most 100 events and about 128 KB, and drops the oldest first. After the wait, it sends the refused batch again, as its own request, then the other events. From 22 October 2026, it sends a refused batch again after each wait, until 5 minutes after the first refusal. After that, it drops the batch. If the page closes during the wait, the SDK sends what it keeps as the page closes.
- Other SDKs follow their own rules for a 429.
- A refused batch shows in the project's refused data as `event_rate_limited`. See [Troubleshooting](/docs/troubleshooting).
- If the store that counts the limit is unavailable, Sequential accepts the events.
- See [Sessions](/docs/sessions).

### When Sequential is overloaded

When a Sequential server has too much work, it refuses some uploads at once, before it reads them. Then it can answer the other uploads quickly, and fewer requests time out. This protects the server. It is not a limit of your project: Sequential does not read the project or the key before it refuses. From 5 November 2026, an upload that a page sends as it closes is refused only when the server is at its limit. Under load, other uploads are asked to wait and are sent again.

- The answer is 503 with the body `{ "error": "overloaded", "retry_after_sec": N }` and a `Retry-After` header. N is a random number of seconds from 3 to 8, so that clients do not all send again at the same time. Sequential stores nothing from that request.
- Only uploads are refused: events from the Sequential SDK, PostHog, Mixpanel, Amplitude, Pendo and Smartlook, and recording uploads. The app, the API, sign-in, agents and the loading of the SDK and the recorder are never refused.
- Sequential refuses a part of the uploads. The part becomes larger while requests wait too long in the server, or while the server is too busy, at most 95 %. It becomes smaller when the server is calm again: quickly when the server is less than 70 % busy, and slowly from 70 % to 80 %, so that the part does not go up and down. When the server already handles 128 uploads, it refuses each new one until one of them is done.
- From 13 October 2026, how busy the server is counts only when it stays more than 90 % busy for 1 second, and only while the server gets about 200 uploads a second or more. So other work on the server, for example a background job, does not make Sequential refuse uploads. At 97 % busy or more, the part becomes larger more quickly.
- Measured on a test box, not a promise: one server with half a CPU core, at 3,200 events a second. Sequential refused about 46 % of the uploads, answered the other uploads in 160 ms or less (p95), and no request timed out. With no refusals, the same load had a p95 of 23.5 seconds, and about 20 % of the requests timed out. A sudden start at 1,600 events a second refused about 2 % to 4 % of the uploads, nearly all in the first few seconds.
- From 22 October 2026, when Sequential cannot store events because its database is unavailable, it answers the same 503 `overloaded`, with N from 30 to 60 seconds. This happens after it read the request, unlike the refusals above, and Sequential stores nothing from it. If the database stored the request before it failed to answer, the resend stores it again: it counts twice.
- The Sequential SDK on a 503 `overloaded`: it waits as on a 429. It waits `retry_after_sec`, else the `Retry-After` value, else 60 seconds, from 1 to 300 seconds. It keeps the batch and the new events, at most 100. From 22 October 2026, it sends a refused batch again after each wait, until 5 minutes after the first refusal. On a 503 that is not `overloaded`, it tries again quickly, 3 times in total.
- The recorder keeps the upload and sends it again after the time that the answer asks for, or after about 30 seconds. See [Replay limits in detail](#replay-limits-in-detail).
- Other SDKs follow their own rules. If a server stored a batch after the SDK stopped waiting, and the SDK then sends the batch again, Sequential stores it once when every event carries the SDK's own event id. See A retried request in [Event limits in detail](#event-limits-in-detail).
- These refusals do not show in the project's refused data, because Sequential does not know the project at that time.

## Lists and reports

| Limit | Value | What happens at the limit |
|---|---|---|
| Matching events on Workbench › Events | The 50 most recent matching events. No paging | "The 50 newest of N matching events." above the list. |
| Workbench › Sessions | 50 rows a page, most recent activity first. Show 50 more loads the next page, with no limit on the pages | From 8 November 2026, the headline above the list counts the sessions in the window, for example "2,345 sessions". If the count takes more than 2 seconds, the headline gives the loaded rows, for example "At least 50 sessions". The scope line then adds "More than Sequential could count in time". "How counted ▾" keeps the sentence, for example "More sessions in the last 7 days than Sequential could count in time. The newest 50 are below." |
| People list | 50 rows a page, the people seen most recently first, or in the order that you choose in People › Order. Show 50 more loads the next page | From 8 November 2026, the headline counts the people that the list shows, for example "3 of 15 people hit a problem." How counted ▾ counts the people of the window, for example "21 people visited in the last 7 days; …". If Sequential cannot count them, the headline says "Who used the product in the last 7 days." |
| Workbench › Accounts | Up to 10,000 accounts, the most recently active. 50 rows a page. Show 50 more loads the next page | — |
| Visits on a person's page | The last 30 days, most recent activity first. First, up to 5 visits of the newest day. Then the visits of that day. Then all the visits that are read. Load more visits reads the next 50 | "N visits shown" next to the button. |
| A funnel's people in People (View them in People) | At most 1,000 people: the first 1,000 in the order of their ids. 50 rows a page. Show 50 more loads the next page. Their events: the latest 100 events | With more people, the page says "This list shows the first 1,000 of them." See [People from a funnel](/docs/users-and-accounts#people-from-a-funnel). |
| Break down by on Workbench › Events | 2 levels at most (Break down by and Then by). The top 1,000 values by count, and the top 1,000 pairs | Later rows are not shown. The table says "The list stops at 1,000 values; there are N in all." or "Some values of … are not listed: the list stops at 1,000 pairs." |
| A compared point on Workbench › Events | By page: the 5 pages with the largest change, then All other pages. Sequential reads at most 1,000 pages of the point. Evidence: at most 5 cases, read from the newest 100. At most 10 releases and at most 10 recorded changes | "Some pages are counted only in All other pages." under By page. "Showing findings from the newest 100." under the cases. |
| Changes marked under the chart on Workbench › Events | The newest 100 changes in the window of the chart | "Only the newest 100 changes in this window are marked." under the chart. |

At a list limit, narrow the dates or add a condition.

### List limits in detail

- Matching events: older events in the window are not listed.
- Workbench › Sessions: each page holds 50 sessions. Two filters apply before Sequential splits the list into pages, so they search the whole window: The recording measured an error and The recording measured a failed request.
- People and Accounts: see [Users and accounts](/docs/users-and-accounts).
- A funnel's people in People: the list stays only in the tab that opened it, for one hour at most. A sign-out removes it.
- The filter on People: at most 5 conditions on what people did together. An All of or Any of group counts as one. Over 5, the page sends nothing and says why, and the list waits until the filter fits. The server also refuses a filter with more than 5. The filter has the limits of the other filter bars too. See [Property conditions](/docs/filters-and-saved-views#property-conditions).
- Past filters on Workbench › Sessions and Events, and on People: the last 10 different filters that you applied on that page, in that project. Sequential removes older entries.
- Blank ids: Workbench › Events, People, Workbench › Accounts and Workbench › Sessions never count a blank id as a user, an account or a session. Workbench › Funnels, Flows and Retention never count an event without a user id as a user.

### Saved views

Workbench › Events, Sessions, Funnels, Flows and Retention, and the Board, save views for everyone on the project. There is no limit on how many items a project can save. Each item has these limits:

| Limit | Value |
|---|---|
| Name | 1–200 characters, after spaces at the start and end are removed |
| Size | 32 KB for the conditions, steps and dates together |
| Conditions and groups | 500 in one filter, and in each funnel or flow step |
| Nested groups | 25 levels |
| Steps | 100 in a funnel or flow |
| Days | 1 to 10 in a retention question, each a whole number from 1 to 365, with no repeats |

If an item breaks a limit, Sequential does not save it. The page says why, for example "The project could not store this funnel as a view." See [Filters, date ranges and saved views](/docs/filters-and-saved-views).

## AI judging

Background judging is on by default for each project. It runs only while the project's switch is on and your Sequential server allows it. If it is off, Settings › Recording & data says why, under Background judging.

### Background judging

| Limit | Value | What happens at the limit |
|---|---|---|
| Sessions that can be judged | A session id and at least 3 events that are not System events | Sequential never judges the session. |
| When a session is judged | 30 minutes after its last event. Checked every 5 minutes | Usually 30–35 minutes after the last event. |
| How far back | Last event in the past 7 days | Older sessions are never judged automatically, even when judging is turned on again. |
| A session's background judgment | Made once. No automatic retry after a failure | The session stays under Not judged on Evidence. |
| Saved background judgment | 400 days after the session ended | The session counts as not judged and is not judged again. |
| Events the judge reads | 255 per session | Sequential drops lower-priority events first. |
| Evidence | The sessions of today and the 6 days before, in whole UTC days, by attention. 50 rows a page | Show more loads the next rows. |

### Background judging in detail

- A session with fewer than 3 events that the judge can read (System events and unknown event types do not count): Evidence lists it under Not judged, "Too short (under 3 events), not read yet, or the judge could not read them."
- Sessions taken per check: 500 per project. The rest wait for the next check.
- Events the judge reads: lower-priority events are, for example, custom events and plain clicks. A judgment made from fewer events ranks like a full one.

### Daily allowances

Values are input tokens per project per UTC day. All reset at midnight UTC.

| Allowance | Value | What happens at the limit |
|---|---|---|
| Background judging | 5,000,000. Server default | Background judging stops until midnight UTC. Then it judges the newest sessions first. Ask is not affected. |
| Ask in the app | 2,000,000. Server default | "The judge has used today's reading budget for this project. It resets …". Background judging is not affected. |
| Try it, the preview of the questions | 750,000. Server default | "Today’s judging budget for tries is used up, so nothing was judged. It starts again at …". Background judging and Ask are not affected. |
| Ask from an agent (`ask_sessions`) | 2,000,000. Server default | 402 `budget_exhausted`. Background judging and Ask in the app are not affected. See [Ask from an agent](#ask-from-an-agent). |
| Screening visitor text for agents | 300,000. Server default | New visitor text in an agent's answer reads `{"withheld": "not screened"}`. This includes a token's GET `/api/findings/:n/verification` and the verdict reasons in a token's cases list or one case. See [Privacy at a glance](/docs/privacy-overview). |
| Checking the text that agents write: the reasons of `review_finding` and `review_session`, and rubric proposals | 250,000. Set on the live server; the code's default is 50,000 | `review_finding` and `review_session` refuse with "The text check could not run. Nothing was stored. Try again later." The same message shows when the check fails for another reason. |

From 15 October 2026, for an organisation in its first 30 days, unless Sequential support set its limits, background judging is 500,000 and Ask in the app 200,000 input tokens per project per UTC day. If Sequential cannot read the organisation's age, it uses these smaller values.

From 15 October 2026, a Sequential server also has one daily ceiling for all its projects together: 20,000,000 input tokens per UTC day by default. When the server reaches it, every allowance above reads as used up until midnight UTC. The same happens when the operator turns all AI spend off, or when Sequential cannot read the ceiling's count.

### Daily allowances in detail

- Background judging starts again after midnight UTC.
- Ask in the app: if Sequential cannot read the allowance, it refuses the search. The server answers 503 `budget_unavailable`, with `Retry-After: 30`, and Ask says "The judge is not available right now. Try again in a minute." It spends nothing. This is not the same as 503 `ask_unavailable`, which means that judging is not set up. A saved answer still returns.
- Try it: find it on the Questions page, in the Try on a session card.
- Try it: if Sequential cannot read the allowance, it does not judge. The server answers 503 `budget_unavailable` with `Retry-After: 30`. Sequential spends nothing and does not call the judge. Try it shows "Sequential cannot read the judging budget right now, so nothing was judged or charged. Try again shortly."
- Another allowance, 500,000 input tokens per project per UTC day (server default), pays for the screening of fix briefs.
- If Sequential cannot read that allowance, the screening of fix briefs continues, with a cap. Each server process allows, per project, 10 brief screenings a minute. With more than one server process, each process has its own cap.
- Past the screening cap, Sequential does not screen the brief. It withholds every quoted passage, and the brief says "screen paused". Sequential does not keep this result, so a later request screens as usual. See [Privacy at a glance](/docs/privacy-overview).

### Try it

| Limit | Value | What happens at the limit |
|---|---|---|
| Try it previews | 10 per person per minute | "That is 10 tries this minute, the most there is. Try again in N seconds." |

### Size of the questions

If the questions break a limit, Sequential refuses the save and marks the field that broke it. See [Questions: what the judge asks](/docs/rubric).

| Limit | Value |
|---|---|
| Questions | 24. At most 5 of them can be moment questions |
| Options per list question | 2–30 |
| Levels per scale | 2–7 |
| Labels | Up to 40 characters |
| Question text | Up to 300 characters |

## Ask

| Limit | Value | What happens at the limit |
|---|---|---|
| Your description | One line, 3–200 characters | "The judge could not read that question. Ask it in one line, 3 to 200 characters." |
| Sessions considered | 2,000 most recently active in the last 7 days | Older sessions are not considered. |
| Sessions judged per run | 200 | When the window has more sessions, the answer says "The judge read N of M sessions in the last 7 days: first the sessions it has already judged, by how much they need attention, then the newest of the others." |
| Sessions judged together | Up to 8 | "Some sessions could not be read, so the answer may miss a few." Sequential does not save that answer. |
| Saved answer | 1 hour | The same question over the same sessions uses no allowance. |

Ask lists only likely matches. A short or empty list does not mean that nothing matching your description happened. See [Ask: one line about sessions, funnels, retention or people](/docs/ask).

### Ask in detail

- Daily allowance: Ask in the app has its own. See [Daily allowances](#daily-allowances). When it is used up: "The judge has used today's reading budget for this project. It resets …"
- Ask does not show sessions that the judge rated below its cut-off.
- Sessions considered: each needs a session id and at least 3 events. The answer's line "The judge read N of M sessions in the last 7 days: first the sessions it has already judged, by how much they need attention, then the newest of the others." counts only these, so M is never more than 2,000. An M of 2,000 means Sequential left out older sessions.
- Sessions judged together: Sequential judges up to 8 at a time. The answer adds "Some sessions could not be read, so the answer may miss a few." if Sequential cannot judge a group.

### Ask from an agent

An agent runs Ask with the tool `ask_sessions`. The token needs the scope `ask:use`.

| Limit | Value | What happens at the limit |
|---|---|---|
| Sessions judged per call | `limit`: 1–50, default 25 | Over 50: 400 `limit_too_large`, with `max`: 50. Sequential spends nothing. |
| The window | `days`: 1–30, default 7. The last N days, with no filters | A value out of range is a tool error. |
| The agent allowance of the project | 2,000,000 input tokens per UTC day. Server default. All tokens of the project share it | 402 `budget_exhausted`, with `resets_at` and `budget` |
| The allowance of one token | 500,000 input tokens per UTC day. Server default | 429 `token_daily_limit`, with `resets_at` |
| `ask_sessions` calls at the same time, per server process | 1 per project, and 2 for all projects together. Server defaults | 429 `ai_concurrency` when your project already has a call running; 503 `ai_busy` when the process is full, also with calls of other projects. `Retry-After: 10` |
| Sequential cannot read the allowances | Sequential refuses the call | 503 `ai_unavailable`, with `Retry-After: 30`. If the judge already read some sessions, the call stops instead, with `stop_reason` `ai_unavailable` |

The endpoint `/mcp/readonly` does not stop this spend. To stop an agent from running Ask and spending the agent allowance, give it a token without `ask:use`. Other agent tools still spend the screening allowance.

### Ask from an agent in detail

- Sequential checks the allowance of the token first, then the allowance of the project.
- Sequential estimates the tokens of each group of up to 8 sessions before the judge reads it. If the next group does not fit in an allowance, Sequential does not send it. So Sequential can refuse a call before an allowance is fully used. The estimate can also be low, for example for sessions with many ids. Then a call can take an allowance a little over its limit. Sequential charges what the judge actually used.
- If an allowance runs out after the judge has read some sessions, the call does not fail. The answer has `stopped`: `"budget"`, a `stop_reason` and a `next_cursor`. The answer keeps the matches from the sessions that the judge read. Sequential charges only what it spent. Sequential does not save an answer that stopped.
- The limits on calls at the same time count per server process, not across servers. A call holds its place from its first paid judgment to when it ends. With more servers, more calls can run at the same time.
- A saved answer uses none of the agent allowance. But Sequential first checks that the project and the token still have agent allowance left, before it reads anything. If one is used up, or Sequential cannot read the allowances, the call is refused, also when a saved answer exists. A saved answer holds no concurrency slot, so it cannot get 429 `ai_concurrency`. Screening its labels can still use the allowance for screening visitor text. The app and an agent share saved answers: the same question over the same sessions returns the saved answer.
- Screening the answer uses the allowance for screening visitor text. See [Daily allowances](#daily-allowances).
- For each refusal, see [Troubleshooting](/docs/troubleshooting).

## Cases and fixes

| Limit | Value | What happens at the limit |
|---|---|---|
| A new case | A JavaScript error, or a request that fails with a 5xx or a network failure: 1 session. Every other problem: at least 3 sessions, of at least 2 people, in the last 7 days. With the Sequential SDK, PostHog or Mixpanel, one person counts once, even if they signed in between. | Below this, Sequential does not make a case. |
| The Cases page | 100 cases | The page shows at most 100 cases. It does not say when there are more. |
| A fix link | `https://` only, at most 500 characters, no control characters | Sequential refuses the link, for example "url: at most 500 characters". |
| Cases named on one release | 50 | POST `/api/releases` refuses more: "finding_ids: up to 50 ids like F-12". The `sequential-release` command reads the first 50. |
| A release version | 1–64 printable ASCII characters | Sequential refuses the release. |
| Open a GitHub issue | 7,500 characters of link | Longer: the issue opens without a body, and Sequential copies the brief for you to paste. |
| Agent case reviews | 100 a project in a UTC day, 25 for one connection. Of them, dismissals that apply at once: 25, and 5 for one connection | Over it: "This project's agent reviews for today are used up. Try tomorrow." A dismissal over its limit waits for a person. |
| Agent session checks | 500 a project in a UTC day. From 9 November 2026, 200 for one connection (before, 100) | Over the project's limit: "This project's agent checks for today are used up. Try tomorrow." Over the connection's limit: "This connection's checks for today are used up. Try tomorrow." |

See [Cases](/docs/findings).

### How a fix is measured

| Limit | Value | What happens at the limit |
|---|---|---|
| Before window | 14 days before the release, or from when the case was first seen | Counted once, then frozen. Counted again when Sequential changes how it finds that kind of problem. |
| After window | Up to 28 days after the release | Still too few sessions: Not measured. |
| Regression watch | 30 days after Fixed | After that, the result is final. |
| Watch after Quiet since the fix | For as long as the case is open. Only for a case from your server | One occurrence makes the result Regressed. |
| Measurements | About once an hour, at most 200 cases a run over all projects | Cases not measured yet go first, then the cases measured longest ago. |

### What a token sees of a case

- For a token without `findings:verify`, the stage of a case is one of `new`, `handed_off`, `fix_linked` or `dismissed`. `measuring` and every result, also `quiet_since_fix` (from 4 November 2026), come back as `{"withheld": "needs findings:verify"}`. (`fix_released` is also allowed, but the list and one case never show it.)
- From 2 November 2026, with `findings:verify`, `get_finding` also gives the release of a measured case: `release` with its `version`, `environment` and `released_at`. For a case that was not measured, `not_measured_reason` says why: `nothing_to_compare`, `before_outside_retention`, `after_expired` or `no_traffic`.
- From 4 November 2026, a case at the stage `quiet_since_fix` also has `stage_note` in `list_findings`, `get_finding` and `list_errors`. It is one sentence that says what the stage means, for an agent whose copy of the tool texts does not have the stage yet. `get_verification` gives the same sentence as `state_note`. For such a case, its `server` part also gives `watched_through`: the time up to which Sequential looked for a new occurrence.
- From 2 November 2026, `list_finding_sessions` takes `days`: 1–30, default 7. Its answer gives `window_days` and `window`.
- A token cannot remove a fix link.

## Reading your data

Every page that reads analytics or replays counts against one limit.

| Limit | Value | What happens at the limit |
|---|---|---|
| Reading analytics or replays | 300 requests a minute, per person per project. Server default | Sequential refuses requests for a moment, with 429 and the message "Too many requests for this project. Try again shortly." |

### When the store that counts limits is unavailable

Sequential sizes the read limit so that a person who works normally does not reach it. If the store that counts the read limit is unavailable, Sequential lifts the limit, so pages keep working.

The "running at once" limits do not depend on that store.

## Sign-in and account protection

Limits count per network address, so teammates behind one office network share them. Over a limit, the sign-in pages say "Too many tries from this network. Wait a minute, then try again."

| Action | Allowed from one network address |
|---|---|
| Sign in with email and password; enter a two-factor code, at sign-in or during set-up | 10 a minute |
| Sign up with email and password; request a password reset; enter a backup code | 5 a minute |
| Resend the verification email | 3 a minute |
| Ask for an emailed sign-in code | 3 a minute and 30 an hour |
| Enter an emailed sign-in code | 3 a minute |
| Continue with Google, Continue with GitHub or Continue with Microsoft (when it is available), change your password, set up or disable two-factor authentication, regenerate backup codes | 3 every 10 seconds |
| Join the waitlist | 5 every 10 minutes |
| Any other sign-in or account action | 100 a minute |

| Two-factor codes, per account | What happens |
|---|---|
| Five wrong codes in one sign-in | The sign-in ends: "Too many wrong codes for this sign-in, so it was closed." Select Sign in again. |
| Ten wrong codes in a row | Code entry locks for 15 minutes. The message says "Too many wrong codes. This account is locked for 15 minutes, then you can try again." |

Password sign-in has no per-account lockout, only the per-address limit. See [Two-factor authentication and account security](/docs/two-factor-and-security).

### Sign-in limits in detail

Per email address, for emailed sign-in codes (from 20 October 2026):

- 5 codes an hour and 20 a day (a UTC day).
- 10 wrong codes in a day (a UTC day) pause sign-in by code for that address until the day ends. Every later code gets the wrong-code answer, also a correct code. The verified address of an account gets one email: "Sign-in codes paused for today". Your password and other sign-in methods still work.
- Sequential also limits the number of code emails for the whole service in one UTC day.
- Code emails to an address with no verified account, server defaults: 5 a day from one network address and 50 a day for the whole service (a UTC day). An account whose email was never verified counts as no verified account. A code for a verified account does not count. Past either limit, Sequential sends no email, and the page still says that it sent the code.
- Over a code limit: 429. If Sequential cannot check the code limits, it sends no code and checks no code: 503, try again shortly.

New accounts per day (a UTC day), server defaults:

- 5 from one network address, 10 for one email domain and 50 in total.
- An address with a pending invitation skips the network and domain limits, but counts toward the total.
- Large free-mail domains, such as gmail.com, outlook.com, icloud.com, proton.me, gmx.de and seznam.cz, skip only the domain limit.
- Only accounts that are actually created count: an email sign-up, a first Continue with Google, Continue with GitHub or Continue with Microsoft when it is available, a first sign-in with an emailed code, and sign-up from an invitation.
- Over a limit: 429, with Retry-After until the end of the UTC day. If Sequential cannot check the limits: 503, try again in a minute.

Other sign-in rules:

- Sequential limits how often each action can be tried from one network address, to slow down guessing. The limits count per address, not per person.
- Join the waitlist: over the limit, the form says "Too many tries from here. Wait a few minutes, then try again."
- From 23 October 2026, 10 wrong passwords for one email address within 15 minutes pause password sign-in for that address for 15 minutes, from every network address. Sign-in with an emailed code still works.
- Ten wrong codes in a row count across sign-ins. A correct code resets the count.
- The 10 wrong emailed codes of a day count across codes. Someone who knows your address can use them up. This stops only sign-in by code for that day.
- The count of wrong emailed codes restarts at the start of each UTC day. So up to 20 wrong codes are possible in 24 hours, 10 at the end of one day and 10 at the start of the next.

## Programmatic access

An agent or a CI job can use a project access token (`sq_pat_…`). Owners and admins make tokens under Settings › Agents & tokens, in Make a token. See [Connect your agent](/docs/quickstart#connect-your-agent).

| Limit | Value | What happens at the limit |
|---|---|---|
| Token requests | 120 a minute per token. Server default | 429: "Too many requests for this access token. Try again shortly." |
| The store that counts token requests is unavailable | Sequential refuses token requests | 503: "The token rate limit cannot be checked right now. Try again shortly." |
| Token reads per project | 600 a minute, for all tokens of the project together. Server default. By default, Sequential only counts them | Only when the operator turns the limit on: 429 `project_rate_limited`. See [The project read limit for tokens](#the-project-read-limit-for-tokens) |
| Token expiry | 30, 90 or 365 days. The default is 90. No token lasts longer. The token that an agent gets with a trial lasts 3 days from setup ([Agent trials](/docs/agent-trial)) | The token stops working. |
| Scopes per token | 1 or more, each at most once. The form offers each scope that the server can issue: 14 when every switch is on | Sequential refuses the token. |
| Token name | 1–60 characters | Sequential refuses the token. |
| claude.ai connections | 10 per person per project, and 50 per project. They are not access tokens, but each one has the same request limits as a token | See [Connect claude.ai](/docs/connect-claude-ai#limits). |

- A token stops working when its project is archived.
- If Redis is down, another server can accept a revoked token for up to 30 seconds.

Agents and tokens also meet these limits:

| Limit | Section |
|---|---|
| The agent allowance of the project, and the allowance of one token | [Ask from an agent](#ask-from-an-agent) |
| Screening visitor text for agents | [Daily allowances](#daily-allowances) |
| Agent case reviews and agent session readings | [Cases and fixes](#cases-and-fixes) |
| Agent tool calls that run at the same time | [Analytics from an agent](#analytics-from-an-agent) |

> **A token can never set a verdict**
>
> A verdict on a case needs a person. No REST route and no MCP tool lets a token set one.

Ingest keys are public. They can never read events, sessions or judgments. See [Organisations, projects and keys](/docs/organisations-and-projects).

### Scopes and what they allow

A token works only on the routes that its scopes allow. Every other route of the app's API needs a person's signed-in session. Sequential has no service accounts. The only webhook is the one under Settings › Project › Where hand-offs go: see [Cases](/docs/findings). Owners and admins can export a project's data under Settings › Data out, and a token with `exports:write` can use the export routes: see [Export your data](/docs/export-your-data#use-the-api-with-an-access-token).

| Scope | In the app | What it allows |
|---|---|---|
| `findings:read` | "reads cases" | Read the cases list, one case, a case's sessions and its fix brief |
| `sessions:read` | "reads sessions" | Only the tool `get_session` |
| `sessions:explore` | "watches sessions" | The tools `list_watch`, `list_sessions`, `get_user_journey`, `get_session_full`, `get_session_timeline`, `list_errors`, `get_struggle_by_segment`, `get_rubric`, `get_calibration` and, from 15 October 2026, `list_heatmap_pages` and `get_heatmap`, and from 2 November 2026, `list_frustration`. They only read |
| `releases:write` | "records releases" | Record a release |
| `findings:link` | "links fixes" | Add a pull request, commit or issue link to a case. It cannot remove a link |
| `findings:verify` | "checks fixes" | Read a case's measurement after its fix release |
| `ask:use` | "asks the judge" | The tool `ask_sessions`. It runs Ask and spends the agent allowance of the project. See [Ask from an agent](#ask-from-an-agent) |
| `analytics:read` | "reads analytics". No preset of the token form includes it. A claude.ai connection gets it | The 11 analytics tools: `get_overview`, `search_events`, `get_histogram`, `get_breakdown`, `funnel_analysis`, `user_flows`, `list_users`, `list_entities`, `get_event_types`, `suggest_property_values` and `retention_analysis`. They only read. See [Analytics from an agent](#analytics-from-an-agent) |
| `findings:draft` | "asks to take cases". Fix loop agent includes it, and claude.ai never gets it | The tool `request_fix_draft`. It asks for a draft fix; an owner or admin approves or declines it on the case. It writes, so it is not on `/mcp/readonly`. See [Cases](/docs/findings) |
| `insights:propose` | "proposes questions". It works only with `sessions:explore`: when you tick it, the form also ticks `sessions:explore`, and when you untick `sessions:explore`, the form unticks it. No preset includes it. A claude.ai connection gets it only when the person ticks it on the consent page | The tool `propose_rubric`. It stores a proposal; an owner or admin applies or rejects it on the Questions page. It writes, so it is not on `/mcp/readonly`. See [Proposals from an agent](/docs/rubric#proposals-from-an-agent) |
| `exports:write` | "exports data". No preset includes it, and claude.ai never gets it. Creating a token with it can ask for a two-factor code | Start an export of the project's events and sessions, see its state and download the files, through the export routes. The files are not filtered. It works only while the person who created the token is an owner or admin. No agent tool uses it. See [Export your data](/docs/export-your-data#use-the-api-with-an-access-token) |

The scope `feedback:write` is not for access tokens. The token form does not offer it. Sequential refuses a token that asks for it: "scopes: feedback:write is for agent connections only". Only a claude.ai connection can have it. It allows the tool `send_feedback`.

A new claude.ai connection gets `sessions:explore`, `ask:use`, `findings:read`, `findings:verify`, `sessions:read`, `analytics:read` and `changes:read`. From 10 November 2026, it gets `releases:write` only when an owner, an admin or a member ticks "Also: it records releases" on the consent page. Only claude.ai and ChatGPT get this box. See [Connect claude.ai](/docs/connect-claude-ai#the-consent-page).

### The token form and Connect an agent

On the Agents page, owners and admins can also make a token from Connect an agent. The token form under Make a token has a Name, What it is for, It may and Expires. The name starts empty. Under What it is for, you choose one of four options. Read cases is selected at first:

| Option | Scopes |
|---|---|
| Read cases: "Reads cases, their sessions and whether a fix worked. Reads only. Getting a fix brief marks the case as handed off." | `findings:read`, `findings:verify`, `sessions:read`, `changes:read` |
| Fix loop agent: "A coding agent that takes a case’s brief, asks to take cases, links its fix and records the release." | `findings:read`, `sessions:read`, `releases:write`, `sessions:explore`, `findings:link`, `findings:verify`, `findings:draft`, `changes:read` |
| Release bot: "A CI job that records each release, so fixes are measured. Nothing else." | `releases:write` |
| CLI and CI (from 6 November 2026, only while the server can issue `changes:write`): "The Sequential CLI in a CI job or a script: records changes and releases. Nothing else." | `changes:read`, `changes:write`, `releases:write` |
| Custom: "Tick each permission below." | The ones that you tick under It may |

Each option holds only the scopes that the server can issue now. For example, `changes:read` is in an option only while Changes is on. It may has a box for each scope that the server can issue, with the scope id in small text. Under `changes:read_sensitive`, the form says "Owners and admins only." When you tick `changes:write`, the box "Write timeline changes for the whole organisation, not only this project." shows. When you tick `exports:write`, you must also tick "I understand this token can export this project’s data, people’s details included, out of Sequential." From 10 November 2026, when the token may record releases (`releases:write`), the box "This token is for an agent" shows, with the line "Sequential checks and limits the releases this token records. On the Changes page, each one says “recorded by an agent” and names the person who made the token." Fix loop agent ticks it. Read cases, Release bot and CLI and CI never do. The mark is set when the token is made and never changes, and a token made earlier is not marked. In the list, a marked token shows "for an agent". Make the token creates it.

A token marked for an agent records at most 20 releases a UTC day, and names at most 25 new cases in releases a day. The agents of a project record at most 50 releases a day together. At a limit, the call is refused with "This agent has recorded 20 releases today. Try again tomorrow.", "This agent has named 25 cases today. Try again tomorrow." or "Agents have recorded 50 releases in this project today. Try again tomorrow." A CI token is never counted. From 10 November 2026, an agent connection through claude.ai or ChatGPT has the same limits as a token marked for an agent.

Sequential can ask for a code before it creates the token. It asks if you tick `exports:write` or `changes:read_sensitive`, or if the token writes changes for the whole organisation. It asks only when your two-factor is on. The form then says "Making it asks for a code from your authenticator, since it can do more than read." From 23 October 2026, a person without two-factor can tick the two Changes boxes too. The code form says "To make this token, enter a code from your authenticator app, or one of your backup codes. It counts for 15 minutes on this device." It asks only if this sign-in did not pass a code in the last 15 minutes. After a correct code, Sequential creates the token. From 23 October 2026, every token also needs a recent sign-in: you signed in on this device in the last hour, or you entered a code from your second factor in the last hour. If not, a person with two-factor gets the code form. A person without two-factor sees "You signed in more than an hour ago. Sign in again, then make this token." and Sign in again. Sequential signs you out on this device and, after the sign-in, opens this page again.

After Make the token, the new token shows once, with Copy token. The setups under Connect an agent then carry it.

Settings › Agents & tokens and the Agents page both have Connect an agent. It has a tab for each setup: Claude Code, Cursor, Codex, Claude Desktop, Other MCP clients and Read-only endpoint (no write tools). When the sign-in is on, a claude.ai tab comes first and shows the Connector URL. From 9 November 2026, a ChatGPT tab follows it, with the steps to connect ChatGPT with a sign-in. See [Connect ChatGPT](/docs/connect-chatgpt). While the sign-in is off, a line says "claude.ai and ChatGPT: Not available yet." If Sequential could not check that the sign-in is on, it shows "Couldn’t check whether claude.ai and ChatGPT are available" and Retry. See [Connect claude.ai](/docs/connect-claude-ai). See [Connect your agent](/docs/quickstart#connect-your-agent) for where each setup goes. On the Agents page, an owner or admin can pick the tab of a setup that uses a token. Sequential then makes a token and puts it in the setup.

### Ingest keys and the app's API

- A request with a person's signed-in session gets exactly that person's access.
- Find the Ingest keys under Settings › Keys.
- Ingest keys go in your pages and apps, so treat them as public. They can send data and get the project's recording settings.

### Routes a token can use

| Route | Scope |
|---|---|
| GET `/api/findings`, `/api/findings/:n`, `/api/findings/:n/sessions`, `/api/findings/:n/brief` | `findings:read` |
| POST `/api/releases` | `releases:write` |
| POST `/api/findings/:n/links` | `findings:link` |
| GET `/api/findings/:n/verification` | `findings:verify` |
| GET `/api/projects/:id/rubric`, `/api/projects/:id/rubric/history` (from 11 October 2026) | `sessions:explore` |
| POST and GET `/api/projects/:id/exports`, GET `/api/projects/:id/exports/:exportId`, GET `/api/projects/:id/exports/:exportId/files/:name` | `exports:write` |
| Tools `list_findings`, `get_finding`, `get_fix_brief`, `list_finding_sessions` | `findings:read` |
| Tool `get_session` | `sessions:read` |
| Tools `list_watch`, `list_sessions`, `get_user_journey`, `get_session_full`, `get_session_timeline`, `list_errors`, `get_struggle_by_segment`, `get_rubric`, `get_calibration`, `list_heatmap_pages`, `get_heatmap`, `list_frustration` | `sessions:explore` |
| Tool `record_release` | `releases:write` |
| Tool `link_fix` | `findings:link` |
| Tool `get_verification` | `findings:verify` |
| Tool `ask_sessions` | `ask:use` |
| Tool `request_fix_draft` | `findings:draft` |
| Tool `propose_rubric` | `insights:propose` |
| Tool `send_feedback` | `feedback:write`, on a claude.ai connection only |
| Tools `list_changes`, `get_change`, `get_change_schema`, `get_change_coverage`, `preview_changes`, `list_finding_changes` | `changes:read` |
| Tools `record_change`, `record_changes`, `update_change`, `retract_change`, `link_change_to_finding` | `changes:write` |
| Tool `propose_changes` | `changes:propose`, on a connection made by sign-in only |
| Tools `get_overview`, `search_events`, `get_histogram`, `get_breakdown`, `funnel_analysis`, `user_flows`, `list_users`, `list_entities`, `get_event_types`, `suggest_property_values`, `retention_analysis` | `analytics:read` |

- The table lists all 47 agent tools.
- A case's sessions list needs `findings:read`, on REST and on MCP. `sessions:read` does not allow it.
- In a case's sessions list, and in the `samples` of a case's evidence (GET `/api/findings/:n` and the `get_finding` tool), each session has `replay_state` and `replay_ready_by` next to `has_replay`. `replay_state` is `ready`, `processing`, `expired` (retention removed the recording), `incomplete` (Sequential never received the full recording, so it cannot play) or `none`. `replay_ready_by` is the time when a `processing` recording will be ready, else null. The two fields can be absent, for example when Sequential cannot read the state within its time limit. Then use `has_replay`, which only tells if Sequential has an index of a recording.
- From 14 October 2026, for a dead end, each sample in `samples` also has `returned`: `back`, `app` or `unknown`, how the visitor came back. A sample without a kind has no `returned`. Each case in the list and in `get_finding` has `returns`: `{ back, app, unknown }`, the dead end's sessions by how the visitor came back. It is `null` for the other kinds, and for a dead end found before the counts existed.
- For a token, each `session_id` in these lists comes as `{"id": "…", "source": "observed"}`, and a release name in a case's sessions list comes as `{"withheld": "not screened"}`. See [Privacy at a glance](/docs/privacy-overview).
- With a token, GET `/api/projects/:id/rubric` and `/rubric/history` give the answer of the `get_rubric` tool, screened. `:id` must be the token's project, else the answer is 404. The history gives at most 20 changes and never who made them. Changing or resetting the questions, and Try it, need a person's signed-in session.
- With a token, the export routes need `exports:write`. `:id` must be the token's project, else the answer is 404. They work only while the person who created the token is an owner or admin of the organisation. The file route answers with a download link (`url`) and its end (`expires_at`). See [Export your data](/docs/export-your-data#use-the-api-with-an-access-token).
- GET `/api/releases` does not accept a token.
- POST `/api/findings/:n/verdict` accepts only a person's signed-in session. So does DELETE `/api/findings/:n/links/:id`, which removes a link.
- An agent calls a tool through MCP, or with POST `/api/agent/<tool>` and the tool's arguments as a JSON object. The two give the same data. With a token, GET `/api/findings/:n/verification` runs the `get_verification` tool and gives the same answer too. It counts once toward the project read limit. If a limit refuses it, the answer keeps the status and the Retry-After of that limit. For a tool outside the token's scopes, REST answers 403 `insufficient_scope`, and MCP answers "Tool not available for this token". From 1 November 2026, there is one exception on `/mcp`. When a connection does not have an extra of the consent page, Sequential lists that extra's tool as a stub: `link_fix`, `propose_rubric`, `send_feedback` or `propose_changes`. A call of the stub does nothing, and answers a tool error with the steps to turn the extra on. From 10 November 2026, `record_release` has a stub too, but only on a claude.ai or ChatGPT connection of an owner, an admin or a member.
- The MCP endpoint is `/mcp`. The endpoint `/mcp/readonly` does not list the tools that change data: `record_release`, `link_fix`, `request_fix_draft`, `propose_rubric`, `send_feedback`, `record_change`, `record_changes`, `update_change`, `retract_change`, `propose_changes` or `link_change_to_finding`. It lists `get_fix_brief`, and getting a fix brief marks the case as handed off. It lists `ask_sessions`, so a read-only connection with an `ask:use` token can spend the agent allowance. POST `/api/agent/record_release` has no read-only form: it works with `releases:write`.
- The MCP server name is `sequential`.
- A token cannot create, list or revoke tokens. These actions need a signed-in owner or admin.

### Token errors

| Case | Status | Response |
|---|---|---|
| The token is unknown, revoked or expired | 401 | `invalid_token`: "The access token is unknown, revoked or expired" |
| A claude.ai connection calls while its project is archived | 401 | `grant_paused`: "This connection is paused while its project is archived" |
| A request to `/mcp` or `/api/agent/<tool>` has no bearer token | 401 | `unauthenticated`: "Send Authorization: Bearer <project access token>" |
| The token lacks the scope | 403 | `insufficient_scope`: "This token lacks the <scope> scope" |
| On an export route, the person who created the token is no longer an owner or admin of the organisation | 403 | `export_creator_not_admin`: "The person who created this token is no longer an owner or admin of this organization." |
| On an export route, Sequential cannot check the person who created the token | 503 | `export_check_unavailable`, with `Retry-After: 5` |
| A REST route request names another project's `tenant_id` | 404 | `not_found` |
| A tool call on `/mcp` or `/api/agent/<tool>` has a `tenant_id` argument | — | A tool error: "Unknown argument: tenant_id (the token's project is used)" |
| Over the token rate limit | 429 | `rate_limited`, with a Retry-After header |
| Over the project read limit, only when the operator turned it on | 429 | `project_rate_limited`, with a Retry-After header |
| The store that counts token requests is unavailable | 503 | `rate_limit_unavailable`, with `Retry-After: 30` |
| Sequential cannot look up the token, its project or its connection | 503 | `auth_unavailable`, with `Retry-After: 30` |
| A token asks for a fix brief or a case that Sequential could not fully screen | 503 | `screen_unavailable`, with `Retry-After: 60`. POST `/api/agent/<tool>` answers 400 `tool_error`. MCP answers a tool error |
| GET or DELETE on `/mcp` | 405 | "This MCP endpoint is stateless: POST JSON-RPC." |
| An MCP tool that the token cannot use | — | "Tool not available for this token" |
| On `/mcp`, the stub of a tool whose extra the connection does not have | — | "… is not enabled on this connection, so nothing was done.", then the steps to turn it on |
| POST `/api/agent/<tool>` names a tool that does not exist | 404 | `unknown_tool` |
| The body of POST `/api/agent/<tool>` is not a JSON object | 400 | `invalid_body`: "Send the tool's arguments as a JSON object" |
| The tool refuses the request, for example because of a wrong argument | 400 | `tool_error`, with the tool's message |
| An agent tool call starts while 4 calls of the project, or 16 calls on the server, are running. From 7 November 2026, not `record_release`, `record_change` or `record_changes`: see the next row. From 10 November 2026, a `record_release` call from an agent connection or from a token marked for an agent counts here | 429 or 503 | `busy` (from 6 November 2026), with `Retry-After: 3` and `retry_after_sec: 3`: "Sequential is busy answering this project's other questions; try again in a few seconds." (429) or "Sequential is busy answering other questions on this server; try again in a few seconds." (503). MCP answers a tool error whose text is the same JSON body. See [Analytics from an agent](#analytics-from-an-agent) |
| From 7 November 2026: a `record_release`, `record_change` or `record_changes` call starts while 2 of these calls of the project, or 4 on the server, are running. From 10 November 2026, not a `record_release` call from an agent connection or from a token marked for an agent: see the row before | 429 or 503 | `busy`, with `Retry-After: 3` and `retry_after_sec: 3`: "Sequential is busy recording this project's other releases and changes; try again in a few seconds." (429) or "Sequential is busy recording releases and changes on this server; try again in a few seconds." (503). See [Analytics from an agent](#analytics-from-an-agent) |
| `ask_sessions` refuses or fails a call: a limit, a description Ask cannot use, judging not set up, or every judgment failed | 400, 402, 429, 502 or 503 | Its own error, for example `budget_exhausted` or `bad_query`. MCP gives the same JSON as a tool error. See [Troubleshooting](/docs/troubleshooting) |
| The tool fails | 500 | `internal_error` |

- The 401 responses carry a `WWW-Authenticate: Bearer` header. The 403 response names the missing scope in that header.
- Sequential refuses batched JSON-RPC requests on `/mcp`.
- For the other answers of the export routes, see [Messages](/docs/export-your-data#messages).
- A token request spends the rate limit before Sequential checks the project and the scope. This applies to REST and MCP.
- By default, a token does not get a fix brief or a case that Sequential could not fully screen. An operator can turn this off with `FINDINGS_SCREEN_REQUIRED=false`. See [Privacy at a glance](/docs/privacy-overview).

### The project read limit for tokens

Sequential counts the read requests of all tokens of a project together. The limit is 600 requests a minute per project. Server default. The operator changes it with `TOKEN_PROJECT_REQUESTS_PER_MINUTE`. A value that is 0, empty or not valid gives the default.

- By default, Sequential only counts. It never refuses a request because of this limit.
- The operator can turn the limit on with `TOKEN_PROJECT_LIMIT_ENFORCE=true`. Any other value, or no value, keeps the default.
- When the limit is on and a project goes over it, Sequential answers 429 `project_rate_limited`: "Too many requests for this project's access tokens and connections. Try again shortly." The answer has a Retry-After header and `retry_after_sec`.
- When the limit is on and the store that counts it is unavailable, Sequential answers 503 `rate_limit_unavailable`, with `Retry-After: 30`.
- Through MCP, a refused tool call is a tool error, and its text is the same JSON. POST `/api/agent/<tool>` answers with the same status, body and Retry-After.

What counts:

- A token's GET `/api/findings`, `/api/findings/:n`, `/api/findings/:n/sessions`, `/api/findings/:n/brief` and `/api/findings/:n/verification`. Each request counts once. A request that gets 403 or 404 does not count.
- Each call of a tool that only reads, through `/mcp`, `/mcp/readonly` or POST `/api/agent/<tool>`. `ask_sessions` counts too.
- Write requests never count: `record_release`, `link_fix`, POST `/api/releases` and POST `/api/findings/:n/links`. The export routes never count, also for GET, because `exports:write` is a write scope.

The limit of 120 requests a minute for each token still applies. From 1 November 2026, a connection to all projects of an organisation has one limit of 120 requests a minute for all its projects. Each of its calls counts toward the limits of the project that the call acts on: the project limit, the daily allowances of the agent, and the paid budgets of that project. So in the worst case, one such connection uses the allowances of every project of the organisation, which is the sum of their allowances. A request that one of the two limits refuses does not use up the other limit: if the limit for each token refuses it, Sequential gives back its count on the project limit, and if the project limit is on and refuses it, Sequential gives back its count on the token limit (Sequential tries this once, so a count can stay one too high until the minute ends).

Operator note: when the project limit is on and refuses a tool call through `/mcp`, `/mcp/readonly` or POST `/api/agent/<tool>`, the call still counts toward the limit of 120 requests a minute for that token.

### How tokens work with sessions, expiry and revocation

- Sequential stores only a hash of each token. It shows the full token once, when you create it.
- If a request has a bearer token and a session cookie, Sequential uses the token. A bad token does not fall back to the cookie.
- Expiry choices in the app: In 30 days, In 90 days or In 365 days. In 90 days is selected by default.
- Revoking a token stops it on that server at once. Sequential tells its other servers through Redis. If Redis is down, another server can accept a revoked token for up to 30 seconds.
- A token stops working when its project is archived.
- From 20 October 2026, a token stops working when the person who created it loses access, unless an owner or admin adopts it. Losing access means that their account is deleted, that they leave or are removed from the organisation, or that they are no longer an owner or admin. A token that an AI agent trial made is never affected.
- Sequential marks the token when it first sees the loss: at the token's next use, or in the daily check, whichever comes first. From the mark, the token works for 7 more days, but without `exports:write` and `changes:read_sensitive`. A token that can write organisation-wide changes also loses that power at the mark. After 7 days, Sequential refuses it, and the next daily check revokes it. So a token that nobody uses can work for up to about 8 days. If the person gets their access back before the daily check revokes the token, that check removes the mark, and the token works again.
- After the daily check, Sequential emails the organisation's verified owners and admins once about each new mark. The subject is "A project access token stops working in 7 days", or "N project access tokens stop working in 7 days". The email names each token by its name, its last 4 characters and its project, with the date and time (UTC) when it stops working. It never contains the token.
- Under Settings › Agents & tokens, a live access token (not an agent connection) whose creator lost access has the amber badge Maker lost access and a note under its name. After the mark, the note starts with "Stops working on", the date and "unless an owner or admin adopts it". Before the mark, it starts with "Stops working in about a week unless an owner or admin adopts it". Then comes the reason: "the person who made it left the organisation", "the person who made it is no longer an owner or admin", "the account that made it was deleted" or "its organisation no longer exists". A marked token with `exports:write` also has "Its export permission is already off until someone adopts it."
- To keep the token working, an owner or admin adopts it, before or after the mark. Select Adopt… next to Revoke…. The app says: "Adopting “<name>” makes you its maker. It keeps its value, name, permissions and expiry, so whatever uses it keeps working, and you answer for it from now on." Select Adopt it, or Keep it as it is. Then the notice "Adopted <name>. It keeps working." shows, and the list is read again. Adopting makes that person its creator, and `exports:write`, `changes:read_sensitive` and organisation-wide changes work again. For a token with `exports:write`, Sequential first asks for a code from your authenticator app, if your 2FA is on and this sign-in has not passed one in the last 15 minutes. For a token with `changes:read_sensitive` or organisation-wide changes, the adopter must be an owner or admin. With 2FA on, Sequential asks for a code too. From 23 October 2026, an adopter without 2FA can adopt it, and adopting any token needs a recent sign-in, as for creating one: the page then says "You signed in more than an hour ago. Sign in again, then adopt this token." After the code, Sequential adopts the token, with no second click. The API does the same: POST `/api/projects/:id/tokens/:tokenId/adopt`. Any other token gets 404, and the app shows "This token can no longer be adopted. The list now shows how it stands." and loads the list again.
- A token with `exports:write` works on the export routes only while the person who created it is an owner or admin of the organisation. Sequential checks this on each call. Otherwise the answer is 403 `export_creator_not_admin`.
- The token list, GET `/api/projects/:id/tokens`, gives each token a `status`. It is `live`, `expired`, `revoked` or `paused:project_archived`. From 20 October 2026, a marked token that is past its 7 days is `access_lost:` and the reason, until the daily check revokes it. Under Settings › Agents & tokens, such a token has the badge Access lost, and its note starts with "Stopped working on" and the date. It has no Adopt… button. When the daily check revokes it, it moves under Revoked and expired. Each token also has `orphan`, with `since`, `reason` and `refuse_by` while it is marked, else `null`. And it has `creator_access_lost`: `user_deleted`, `org`, `member` or `role` when its creator has lost access now, also before the mark, else `null`. `paused:project_archived` means that the project is archived, so the token does not work. Under Settings › Agents & tokens, a paused token has the badge Paused and the note "Paused while the project is archived." On the Agents page, its row says the same. A revoked or expired token moves under Revoked and expired, with the badge Revoked or Expired. Revoke… stays on a paused token. In the API, each row also has `kind`, which is `pat` for the tokens that you create. `last4` can be null, but never for a token that you create.
- A claude.ai connection is in the same list, with `kind` `oauth` and no `last4`. Its `status` can also be `pending`, `refresh_idle`, `client_missing` or `access_lost:` and a reason. Settings › Agents & tokens shows these as Pending, Idle, App gone and Access lost. A connection on an archived project is paused, and it works again when you restore the project. See [Connect claude.ai](/docs/connect-claude-ai#see-the-connection-under-agents).

### Agent activity

- GET `/api/projects/:id/agent-activity` shows how the access tokens of a project used the agent tools. The Agents page in the app shows it under "What they did, last 7 days". From 8 November 2026, each connection has a row on Agents. The row shows its calls under "Calls, 7 days", for example "29 calls". When the connection got removed or withheld values, the row also says, for example, "3 values held back". Each call in the list says which agent made it and what the call did, for example "listed the cases". If no agent called in the 7 days, it shows "No call in this window." If Sequential cannot read the log, the page shows "Calls are not measured on this backend." From 8 November 2026, each row then says "Not measured" in place of a count of calls.
- It needs the signed-in session of an owner or admin. It does not accept an access token.
- From 19 October 2026, GET `/api/projects/:id/agent-activity/mine` gives the same answer for the calls of your own connections only: the connections that you allowed on the consent page. It never includes a teammate's connections or an access token. Every role can use it. On the Agents page, a member or viewer sees it under the same heading. The list of agents then says "Only owners and admins see every agent; here is your own:". If Sequential cannot read your connections, the route answers 503, not an empty list. From 20 October 2026, it counts at most 200 of your connections, the most recently used first. When it leaves out a connection, the answer has `grants_capped: true`.
- `days`: 1–30. The default is 7. Any other value gets 400 `bad_request`: "days: an integer 1-30".
- The answer has `window_days`, `state`, `per_token`, `recent`, `tokens` and `tokens_state`.
- `per_token` has one row for each token that has calls in the window. The token with the most calls is first. Each row has `token_id`, `calls`, `removed`, `withheld`, `input_tokens` and `last_call_at`.
- `recent` has the newest 50 calls, newest first. Each call has `tool`, `token_id`, `consumer` (`mcp` or `rest`), `observed`, `removed`, `withheld`, `input_tokens` and `delivered_at`.
- `observed` is the number of different observed text values in the answer. `removed` is the number that the screen removed. `withheld` is the number that Sequential withheld for another reason, for example because it could not screen them. `input_tokens` is the paid AI input tokens of the call: the screen, and the judging of `ask_sessions`. In `per_token`, the counts are totals.
- Times are in UTC, in ISO 8601 format.
- The answer counts only the calls that the agent call log records. These are the successful calls of every agent tool, except `record_release` by a CI token (an access token that is not marked for an agent). A token's GET `/api/findings/:n/verification` runs `get_verification`, so it is counted too. The answer does not count `record_release` by a CI token, a call that failed, or the REST routes GET `/api/findings` and `/api/findings/:n`.
- Sequential writes the log on a best-effort basis. A missing call does not prove that the call did not occur.
- `state` is `ok` or `not_measured`. `not_measured` means that Sequential could not read the log, for example because the read took more than 10 seconds. Then both lists and `tokens` are empty, and `tokens_state` is `unavailable`. Empty lists with `not_measured` do not mean zero calls. The status is still 200.
- `tokens` gives a name for the token ids in `per_token` and `recent`. Each entry has `id`, `name`, `kind` and `identified_as`. `name` is the name that the token got when it was created. A revoked token keeps its name. `kind` is `pat` for the tokens that you create, and `oauth` for a claude.ai connection. `identified_as` is the name that the agent's MCP client sent, at most 60 characters, or null. Sequential does not check it.
- `tokens_state` is `ok` or `unavailable`. `ok` means that the name lookup succeeded, or that there were no token ids to look up. `unavailable` means that Sequential could not look up the names, or could not read the log. Then `tokens` is empty. An empty `tokens` with `unavailable` does not mean that the tokens have no names.

### Session tools in detail

- `list_watch`: the sessions that Evidence ranks highest, and the sessions that the judge was unsure about. `days`: 1–30, default 7. `limit`: 1–100, default 25, for the two lists together. The unsure list gets at most a quarter of `limit`. Each row has a `severity`: `broke`, `struggled` or `minor`, the Evidence lane of the session ([Evidence](/docs/watch)). `null` means the session is not judged.
- `list_sessions`: the sessions with the most recent activity first, by the time of the last event of each session, not its start. The same `days` and `limit`. With `judged_only: true`, only judged sessions.
- Rows and counts. From 10 October 2026, each row of `list_watch` and `list_sessions` gives `last_page`: the page that the session ended on, not the page where a signal happened. From 6 November 2026, `last_page` is a route template, as `first_page` is: Sequential removes the host, the query and the fragment, and shows ids as `:id`. From 6 November 2026, for a mobile app session, `last_page` is the page of its last named screen. See [Screens are pages](/docs/mobile#screens-are-pages). Before, this field was `path`. Each answer also gives `sessions_total`, and `list_watch` gives `unsure_total`: how many sessions match in the whole window, or `null` when Sequential cannot count them in time. From 2 November 2026, `list_watch` also gives `sessions_by_severity`: `broke`, `struggled`, `minor` and `not_judged`. `sessions_total` is not the number of sessions that need a look: the ranked list ends with the sessions that are not judged yet. `truncated` is true when the answer leaves out sessions. Then narrow `days`, `user_id` or `belief_filters`. `beliefs_meta` counts every session in the window, before `belief_filters` and `judged_only`.
- From 10 October 2026:
  - A compact row's judgment also has `struggling`: true when the friction is at the middle of the friction scale or higher. This is the same rule as in `get_struggle_by_segment`.
  - `list_watch` takes `platform_os`: only the sessions with an event on that operating system, with the name that a row shows. From 12 October 2026, the case of the name does not matter: `android` and `Android` match. `get_struggle_by_segment` by `platform_os` also puts both in one group, `Android`.
  - From 12 October 2026, the filters and breakdowns of an agent also take `platform`: `web`, `ios`, `android` or `other`. It tells the website from the app. Safari on an iPhone is `web`, and the iOS app is `ios`. An app view that shows a web page also counts as `web`. A `platform` filter takes only these four values. Sequential refuses any other value. There is no device filter. For devices, use `get_struggle_by_segment` by `device`.
  - From 15 October 2026, the filters and breakdowns of an agent also take `traffic_source`: the other site that a visit came from, as its host without `www.`, such as `google.com`. A visit with no referrer, or from a page of the same site, has an empty value: direct or internal. Another domain of your project counts as another site. `utm_referer` still gives the full referrer address.
  - `list_watch` with `detail: "counts"` gives no rows, only counts over every session in the window and filters: `judged`, `unjudged`, `struggling`, `need_a_look`, `routine` and `unsure`. It does not use `limit`.
  - `list_sessions` takes `order: "asc"` for the oldest first, by the last event of each session. It cannot be used with `judged_only` or `belief_filters`.
  - A `list_sessions` row has `ended_at`, also in compact detail, and `is_first_session`: true when it is the first session of its person that Sequential holds, false when that person has an earlier one, `null` when Sequential cannot check.
- `list_watch` and `list_sessions` also take these arguments:
  - `has_errors: true` or `has_failed_requests: true`: only the sessions whose recording measured at least one JS error, or at least one failed request. A session without a recording, or without measured DevTools data, never matches. Then the answer has `devtools_meta`: the number of recorded sessions in the window, for the whole project, that were not measured or did not capture that kind. So an empty list does not prove that there were no errors. The value `false` gets a tool error. To get all sessions, leave the argument out.
  - `belief_filters`: up to 10 `{ key, min }`. Only judged sessions where each value is at least `min`, for example `friction_score` or a signal. The keys are in `get_rubric`.
  - `user_id`: only the sessions of one person. An anonymous id that was identified later finds the same person.
  - `detail`: `compact` (the default) gives the top answer of each verdict, the friction label, and the signals that are on or unclear. `full` gives every answer with its probability and the state of every signal.
  - Two shapes: an `ask_sessions` result always has the full judgment. Its `verdict_intent` and `verdict_outcome` each have `id`, `value`, `label`, `probability`, `confidence` and `options`. `list_watch` and `list_sessions` give the compact shape unless you ask for `full`, and `get_user_journey`'s `verdict` is always compact. An agent that compares sessions from these tools must read both shapes.
  - A label is a string when it comes from Sequential's default questions. When the project edited its questions, a label is `{"observed": "…"}`: text that a team member typed, after the screen. If the screen removed it, the label is `{"withheld": …}`. An agent must read all these forms.
  - A `compact` row of `list_watch` has no `ended_at`: use `started_at` and `duration_ms`. Its probabilities and `attention` have 2 decimals. Its `devtools` is `"none"` when the recording was measured and had nothing, or else only the counts that are not 0. A count that is not there is 0. With `suppressed: true`, Sequential dropped some entries, so the counts are lower bounds. `full` gives `ended_at` and every DevTools count.
- `get_session_full`: one session, with its judgment, its moments and its DevTools counts. If the session has a recording, each moment has a replay link.
- Pages of one session. From 10 October 2026, `get_session` and `get_session_full` give `pages`: up to 10 route templates, the 10 with the most events, in the order that the session first visited them. Each page has `events`, the number of events of every kind on it (not page views, and not time), and `first_offset_ms`, the time from the start of the session to its first event there. `pages_total` counts all the pages of the session. A page that the session visited again is listed once, so `pages` is not the path. For every step in order, use `get_session_timeline`.
- `get_user_journey`: from 10 October 2026, the sessions of one person in the order they started, oldest first. `user_id` is any id of the person: an anonymous id that later identified finds the same person. `days`: 1–30, default 30. It gives at most 50 sessions. With more, `truncated` is true and `sessions_total` counts all of them. Each session has `first_page`, `last_page`, `pages_total`, the compact judgment as `verdict`, `overlaps_previous` and `is_first_session`. `overlaps_previous` is true when the session started before an earlier session of the list ended, for example in two tabs or on two devices. `identified` is true when an identify call linked an anonymous id to the person. `false` does not mean anonymous. The tool gives ids only, never a name, an email, an IP address or a property.
- `get_session_timeline`: one session, event by event, in order: each page, click, form submit, custom event and error, with its time from the start of the session. From 10 October 2026, the answer also names the session's person: `user_id` after identity resolution, and `anonymous_id`, the id that the session sent, when it differs. If Sequential cannot look up the person in time, `user_id` comes as `{"withheld": "not resolved"}`. These are the events that the judge read. Sequential does not show system events, and for a long session it keeps the 255 most informative events, in order. Each event has an id, for example `E001`. A moment of `get_session_full` names the same id. `limit`: 1–120 events, default 60. `start`: 1–255, default 1. If there are more events, use `next_start` as `start` to get the next part. A session with fewer than 3 events that are not system events has no timeline: `timeline_state` is `too_short`, and the answer has no `duration_ms`, `timeline_events`, `breakage` or `pauses`. Otherwise, `timeline_state` is `ok`.
- Replay links. From 11 October 2026, `replay_url` is null when Sequential holds no recording of the session. It is also null when Sequential cannot check this in time. The tools tell the agent: "replay_url is null when Sequential holds no recording of the session." `get_session_timeline` has `has_replay`: true, false, or null when Sequential cannot check. Each session of `get_user_journey` has `has_replay`.
- `list_errors`: the JS errors and failed requests of the project, in groups. From 3 November 2026, it leaves out the same failed requests that never open a case: requests to the new ad and analytics hosts, and requests with no HTTP status that failed as the visitor left the page. See [Where cases come from](/docs/findings#where-cases-come-from). The group that the most sessions hit comes first. From 14 October 2026, a group's `page` is the page where it happened most often, the same page as its case. Each group also has `finding`: `{ number, id, stage, status, verdict }` when Sequential holds a case for the same problem. `id` is like `F-12`. From 1 November 2026, `stage` is the stage of the case as `list_findings` gives it, withheld in the same way. `status` is `open` or `dismissed`, and `verdict` is the latest verdict (`not_a_problem`, `wont_fix`, `confirmed`, `reopened`, or `detection_changed` when Sequential closed the case because its detection changed) or `null`. `finding` is `null` when there is no case, `{"withheld": "needs findings:read"}` for a token without that scope, and `{"withheld": "not available"}` when Sequential could not check. The rows of `get_overview`'s `errors.top` have the same `finding`. `days`: 1–30, default 7. `limit`: 1–50 groups, default 20. Each group has up to 3 sample sessions. A sample has a replay link only when Sequential holds a recording of it. A group has no minimum count, so an error that is too rare to become a case is in the list too. With `session_id`, it gives the errors and failed requests of that one session in time order, up to 100. Each has a replay link at that moment when Sequential holds a recording of the session. Then it reads the time of that session, not the last `days` days, and it refuses `kind` and `limit`. The errors come from recordings with DevTools on and from `$exception` events. Console messages are not included. Each sample also has `user_id`. From 12 October 2026, it is the person of that session, resolved as on a session row. Only when Sequential resolves no person for the session is it the id that the occurrence was stored with. `users` counts these people.
- `get_struggle_by_segment`: how the judged sessions went, in groups of one field (`by`): `page`, `device`, `platform_os`, `browser` or `country_code`. For each group, it gives the judged sessions, how many of them struggled, the average friction, the 3 most frequent signals and outcomes, and the 2 sessions with the most friction, each with a replay link when Sequential holds a recording of it. A session struggled when its friction is at the middle of the friction scale or higher: 1.5 or more on the default scale of 4 levels. A signal counts when the judge gives it 0.7 or more. With `page`, a session counts in each route template that it viewed, so pages overlap. `device` is `mobile` for iOS and Android, `desktop` for other operating systems, and `unknown` when there is no operating system. The other fields come from the latest event of the session. Only judged sessions count. A group with fewer than 5 judged sessions has `small_sample` set to true: its percentages are not rates. `days`: 1–30, default 7. `limit`: 1–50 groups, default 10, with the most judged first. `min_judged`: 1–1000, default 1. It reads at most 20,000 rows of judged sessions. With `page`, each pair of a session and a page is one row. At that limit, the counts are partial and `truncated` is true. `truncated` is also true when it leaves out groups. An example session has `internal: true` when its person is marked internal.
- From 2 November 2026, `list_frustration` shows where people get frustrated: the rage clicks, dead clicks and U-turns of every session, not a sample, by page and by the element that people clicked. A U-turn is a page that the visitor left with the Back button, and its page is the page that the visitor left. `days`: 1–30, default 7. `limit`: 1–50 groups, default 20. `kind` keeps one kind. Each group has its `host` and its page, so the same route on the website and in the app, such as `/`, stays apart. Each group has its counts of events, sessions and people, up to 3 sample sessions and, for a click, the case that Sequential opened for it. The element label comes only when it is made of common interface words, and the selector is masked as in the other tools. The heatmap tools say to use it for every session.
- From 15 October 2026, `list_heatmap_pages` and `get_heatmap` read the counts of [Heatmaps](/docs/sessions-and-replay). `list_heatmap_pages` lists the web pages with heatmap data, up to 20 (default 10), by views or by frustration: rage bursts per 1,000 views, with pages of little data last. When every page of the window has little data, `all_low_data` is `true`. Each page has a `page_ref`. `get_heatmap` takes a `page_ref` or a page address, and one device class. It gives the most clicked elements, the elements that frustrate people, and scroll depth, up to 20 elements in a list (default 10). For up to 3 elements with rage clicks in the days that the sessions list reads, the most rage clicks first, it also gives up to 5 recent sessions each, from that list. Both take `days` 1–90 (default 7).
  - The counts come from the sampled sessions of Heatmaps. A device class is the layout width of a web page: mobile below 768 px, tablet below 1,024 px, desktop from 1,024 px. Mobile apps have no heatmaps.
  - An element is named by its kind, its place and a path of tags and positions. Sequential withholds element text, class names, ids and the names of custom elements: an unknown tag shows as `…`. An agent never gets the page picture.
  - The counts include your team, and the answer says so: `internal.counts_separable` is `false`. There is no `exclude_internal`.
  - When heatmap data is off for the project, the answer is `off` with the reason. When `list_heatmap_pages` finds no data in the window, its answer is `not_measured`, with no numbers. For a page with no data in the window, `get_heatmap` gives a tool error: "This page has no heatmap data in this window. Use page_ref from list_heatmap_pages." `get_heatmap` answers `not_measured`, with no numbers, when the device class has no sampled views on the page.
- `get_rubric`: from 11 October 2026, all the questions as `document`: each question's id, kind, label, role and text, its options or levels with their criteria and phrases, and its weight. It also gives `limits`: the most questions, options and levels, and the longest texts, that the questions can have. `questions`, the earlier short form, stays for now. With `history: true`, it lists the changes instead, newest first: the version, the ids that were added, removed or reworded, the time, and `changed_via` (`staff`, `agent`, or null for a person in the app). It never names who made a change. `limit`: 1–20, default 20, only with `history`. Sequential screens the texts of your own questions. See [Privacy at a glance](/docs/privacy-overview).
- `get_calibration`: how often the judge was right, per question, for the current wording only. `days`: 1–400, default 90.
- The session tools read the same data as Evidence and Workbench › Sessions.
- In `get_session` and the `sessions:explore` tools, each read of stored session data stops after 10 seconds. This does not apply to the read of the questions. Then the tool answers "Internal error" (500 `internal_error` at POST `/api/agent/<tool>`). If only the DevTools read of `get_session_full` fails, the answer has `devtools` null and the warning `devtools_unavailable`. If only the judgments cannot be read in `list_watch` or `list_sessions`, the answer has `beliefs` null and the warning `beliefs_unavailable`.
- For how the session tools show visitor text, see [Privacy at a glance](/docs/privacy-overview).

### Analytics from an agent

The scope `analytics:read` gives an agent 11 tools: `get_overview`, `search_events`, `get_histogram`, `get_breakdown`, `funnel_analysis`, `user_flows`, `list_users`, `list_entities`, `get_event_types`, `suggest_property_values` and `retention_analysis`.

The 10 tools after `get_overview` read the same events as the pages under Workbench in the app, for the project of the token only. For what they show and what they never show, see [Privacy at a glance](/docs/privacy-overview#analytics).

| Limit | Value | What happens at the limit |
|---|---|---|
| Time window (`days`) | The last 1–30 days. Default 7 | Another value: a tool error |
| Older events | Only the events that Sequential still keeps. On Sequential's hosted service, events stay 7 to 14 days with the default period of 7 days. Sequential support can set a period of up to 30 days, or exempt your organisation. See [A server-wide limit](/docs/retention-and-deletion#a-server-wide-limit) | Older days count as empty |
| Agent tool calls that run at the same time | 4 for each project, and 16 for each server process. From 7 November 2026, `record_release`, `record_change` and `record_changes` have their own limit: 2 for each project, and 4 for each server process. They do not count toward the 4 and the 16. From 10 November 2026, `record_release` from an agent connection or from a token marked for an agent counts toward the 4 and the 16 instead. Server defaults. Each server process counts only its own calls | A wait of up to 3 seconds, then a tool error. See [Refusals, calls at once and properties](#refusals-calls-at-once-and-properties) |

### Limits of each analytics tool

| Limit | Value | What happens at the limit |
|---|---|---|
| Events in `search_events` (`hits_limit`) | 1–50. Default 20 | Another value: a tool error |
| Buckets in `get_breakdown` | 100 | `truncated` is true |
| Steps in `funnel_analysis` | 2–10 | Another number: a tool error |
| Steps in `user_flows` | 1–10 | Another number: a tool error |
| Paths in `user_flows` | 100 | `paths_total` counts all paths |
| Ids in each drop-off list and in the completed list of `funnel_analysis` | 100 | The `_total` fields count all ids. With List people in funnels set to Off, the lists are empty and `people_withheld` says why |
| Rows in `list_users` and `list_entities` (`limit`) | 1–100. Default 50 | `truncated` is true when rows were left out |
| Values in `suggest_property_values` | 100 | `truncated` is true |
| `retention_days` in `retention_analysis` | 1–10 different whole numbers, each 1–365 | Another value: a tool error |

### Refusals, calls at once and properties

- Identity fields are refused. A filter, a funnel or flow step, a retention event, a breakdown or a `suggest_property_values` call that names a person's or account's identity gets the tool error "Agents can't filter or break down by a person's or account's name, email or other identity fields." From 20 October 2026, this includes a company or organisation name, even under a plain `company` key. For the fields, see [Privacy at a glance](/docs/privacy-overview#analytics).
- Too many calls at once. The cap counts every agent tool call, not only the analytics tools. From 7 November 2026, the three calls that CI sends, `record_release`, `record_change` and `record_changes`, have a cap of their own: 2 for each project, and 4 for each server process. From 10 November 2026, `record_release` from an agent connection or from a token marked for an agent uses the first cap. Other calls never use these slots, so a project whose agents are busy can still record its releases and changes. Every other call, also every other write, uses the first cap. A call over its cap waits for a free slot for up to 3 seconds. At most 8 calls wait for each cap on each server process. When no slot comes free in time, or 8 calls already wait, Sequential refuses the call, before any read. If the client goes away while its call waits, the call runs no read. From 6 November 2026, POST `/api/agent/<tool>` answers 429 when 4 calls of the project are running, and 503 when 16 calls are running on the server. The body is `{"error": "busy", "message": …, "retry_after_sec": 3}`, with the header `Retry-After: 3`. Through MCP, the answer is a tool error whose text is that JSON body. The message is "Sequential is busy answering this project's other questions; try again in a few seconds." (429) or "Sequential is busy answering other questions on this server; try again in a few seconds." (503). For the three CI calls, Sequential answers 429 when 2 of them are running for the project, and 503 when 4 are running on the server. Their message is "Sequential is busy recording this project's other releases and changes; try again in a few seconds." (429) or "Sequential is busy recording releases and changes on this server; try again in a few seconds." (503). Wait 3 seconds, then try again. `GET /api/findings/:n/verification` and the token routes of the questions answer in the same way.
- Properties. The filters of the analytics tools take the property conditions of the app, with the same limits. See [Property conditions](/docs/filters-and-saved-views#property-conditions). `get_breakdown` can also group by a property: `event_prop:<name>`, `visitor_prop:<name>` or `account_prop:<name>`, for `field` or `second_field`. Events without the property get their own bucket, with a `null` key and `unset: true`. `event_prop:$utm_source` and the other `$utm_*` tags group by the campaign tags of the page address. For the campaign that brought each person, or the first or last campaign of each session, use the `user:` and `session:` fields. See [Measure a campaign](/docs/measure-a-campaign#agents). `suggest_property_values` also lists event properties, such as `plan`. It reads only the properties sent as text. A property sent as a number, a boolean or a date is not in its list of names, and its list of values is empty. An identity property is refused, as above. An element-text property, such as `$el_text`, and PostHog's `$set`, take only is set and is not set, and breakdowns and suggestions refuse them. A filter on `selector` takes only `exists` or an exact structure.
- Each analytics call also counts toward the token limits above.

### What get_overview gives

`get_overview` gives a briefing in one call. It compares the last `days` days with the same number of days before them. It gives:

- the sessions, people, events and page views, now and before, with the change in percent
- from 2 November 2026, `frustration`: the sessions with rage clicks, with dead clicks and with U-turns in the window, over every session, and the page with the most of them, as its host and route. A token without `sessions:explore` gets `{"withheld": "needs sessions:explore"}`
- the median and average session length, the sessions with only one event, and the new and returning people. A returning person was also active in the days before
- the 8 pages with the most page views, by route template. Their visitors are people after identity resolution, so one person with two ids is one visitor
- setup checks for events, releases, identify, account ids, recordings, DevTools, custom events, judging, rage and dead click events, refused or dropped data (`ingest_refusals`), internal traffic (`internal_traffic`), and from 15 October 2026 your own hosts (`own_hosts`) and ids that look like email addresses (`ids_look_personal`), and from 6 November 2026, for a project that sends app screen views, whether the app names its screens (`screen_names`). The state of each check is `ok`, `partial`, `missing` or `off`, or `unknown` when Sequential cannot read the refusal counts in time. The events check can also be `stopped`. See [Refused or dropped data](/docs/troubleshooting) Most checks that are not `ok` tell what to send or turn on next. The account id check names `sequential.account()` and the `account` of Pendo. From 10 October 2026, the events check gives the install snippet of sequential.js, with a placeholder for the ingest key. From 29 October 2026, this snippet has the two parts of Settings › Setup: the small inline script and the tag. The custom events check gives an example `sequential.capture` call. From 10 October 2026, a `missing` check for events, releases, identify, account ids, custom events, or rage and dead clicks also says one of these: the day that the last such event arrived, in the 90 days before the window; that the data Sequential holds has none; or that older data was not checked. So "none in this window" does not mean "never"
- from 15 October 2026, the events check is `stopped` when no event arrived for 24 hours, and the same 24 hours one week earlier had 20 or more events. It is never `stopped` for a project younger than 8 days. Its fix says to check that the tag still loads and uses this project's ingest key, and to read `ingest_refusals`. `traffic.newest_event_at` is the time that the newest event arrived. It is `null` when no event arrived in the last 30 days, or when Sequential could not read the time quickly enough
- from 15 October 2026, `ids_look_personal` counts how many user ids and account ids in the window look like email addresses. It never shows one. It is `partial` when some do, with the fix: send a pseudonymous id, and the email as a person property. It is `ok` when none do, and `unknown` when Sequential could not count them
- from 15 October 2026, `own_hosts` says whether the people filter hides your own site's host in agent answers, for example as `www.[person].com`. It checks the 3 most-viewed hosts of the window. It is `ok` when your Allowed sites keep them readable, and `missing` when some are hidden. It gives counts only, never a host
- with `sessions:explore`: the 3 error groups that the most sessions hit, and the sessions worth watching. From 10 October 2026, `watch` gives `judged`, the number of judged sessions, and `flagged_total`, the judged sessions with at least one signal on. `top` lists up to 3 flagged sessions with the most attention. Each has its person (`user_id`, and `anonymous_id` when it differs) and `last_page`, the page that the session ended on. If no session is flagged, `top` is empty. The two counts read at most the latest 10,000 sessions of the window, so with more sessions they are lower bounds. If Sequential cannot read the judgments, the two counts are `null`, not 0
- with `findings:read`: up to 3 open cases. From 19 October 2026, with `findings:verify` too, the open cases and their count leave out the cases whose fix Sequential confirmed

If the token does not have the scope of a section, the section comes as `{"withheld": "needs sessions:explore"}` or `{"withheld": "needs findings:read"}`, and Sequential does not read the data of that section.

### Your team in agent answers

Your team (internal traffic). From 10 October 2026, a project can mark its own team as internal, in `data.internal` of its settings document. Owners and admins set it under Settings › Recording & data › Your team, or through the settings API, with PATCH `/api/projects/:id/config`.

- `user_ids` (User ids of your team): up to 200 user ids, as your project sends them. An anonymous id that later identified counts as the same person.
- `email_domains` (Email domains of your team): up to 20 domains, such as `mycompany.com`. The match is exact and ignores case, so a sub-domain is its own entry. A person matches when the email of their latest identify event has the domain.
- `sequential_members: true` (Everyone in this organisation on Sequential): a person matches when the email of their latest identify event is the Sequential account email of a member of your organisation.

The tools `search_events`, `get_histogram`, `get_breakdown`, `funnel_analysis`, `user_flows`, `retention_analysis`, `list_users`, `list_entities`, `list_sessions`, `list_watch`, `list_errors`, `get_struggle_by_segment` and `get_overview` include the team by default. Each answer has `internal`, with counts only:

- `{ "configured": true, "excluded", "people", "sessions", "events" }`: the share of the team in the answer. `capped: true` means that Sequential uses only the first 2,000 internal people, so the counts are a lower bound.
- `{ "configured": false }`: nobody is marked, so `exclude_internal` changes nothing. From 11 October 2026, the tool tells the agent that Sequential then cannot tell which ids are your team, and that it must not call an id yours.
- `{ "unknown": true }`: Sequential cannot read the setting now. Then `exclude_internal: true` gets a tool error: "Sequential could not read which people are marked internal right now. Try again shortly, or call without exclude_internal."

With `exclude_internal: true`, the tool leaves the team out. An event with no user id is never internal, so it stays in. `list_watch` and `list_sessions` count `internal` before `belief_filters`, `judged_only` and `limit`. Sequential reads the team again at most every 5 minutes. Cases and judging do not use the setting. In the app, the Hide our team switch leaves the team out of Ask. Where the server allows it, the switch also leaves the team out of the session and people lists. `get_overview` also has the setup check `internal_traffic`: it is `missing` when one person who is not marked internal made more than half of the events in the window.

### Analytics answers in detail

Counts only. No agent tool adds up, averages or takes percentiles of the values of an event property, for example a duration or an order value that you send as a property.

Where the data is complete. A window can start before the data that Sequential holds. Sequential deletes each event at the end of the retention period that applied when the event arrived, and a new project has no events before its first one. After the organisation's events retention gets shorter, older events stay until their own period ends, so the agent can still see them. From 11 October 2026, each tool that reads a window of days gives `window.data_from` and `window.partial`:

- `data_from` is where the data that Sequential holds is complete in the window. Before it, some rows can be missing and others can still show.
- `partial: true` means that a part of the window is older than that.
- Both are `null` when Sequential could not check.

From 12 October 2026, `list_errors` also gives `window.recordings_from`. In `list_errors`, `data_from` is where its `$exception` events are complete. `recordings_from` is where the errors and failed requests from recordings start. Sequential keeps those only for the replay retention period, so `recordings_from` can be later than `data_from`. Sequential removes the older rows in the background. So a group first seen before `recordings_from` can still be a failed request or an error from a recording. Its `kind` and `source` tell which, not its first time. `null` means that Sequential does not know.

In `get_overview`, the window before (`previous_window`) has the same fields. When Sequential does not hold all of it, it also has a `reason`:

- If Sequential holds none of it, its counts are `null`, never 0.
- If Sequential holds a part of it, its counts stay.
- If Sequential could not check, a count of 0 is `null`, because the 0 can be data that it does not hold. A count above 0 stays.
- `change_pct`, `new_people` and `returning_people` are `null` unless Sequential holds all of the window before.

Empty intervals in `get_histogram`. `get_histogram` lists each interval of the window (`filled: true`). An interval without events has zeros. From 11 October 2026, an interval that has no events has `null` when it is before `first_event_at`, or before `window.data_from` when that is later: Sequential did not measure it, or deleted it at the end of the retention period. An interval before `data_from` that has events keeps its counts. Some of its events can be missing. `first_event_at` is the time of the oldest event that Sequential still keeps. It is the oldest event of the project, not of the filter. If the window has more than 200 intervals, if the interval is `month`, or if Sequential cannot read the oldest event within 3 seconds, the answer lists only the intervals with events (`filled: false`).

People in `get_breakdown`. From 10 October 2026, a `user_id` field, at either level, groups by the person after identity resolution: the same person that `unique_users` counts. Each person bucket has `anonymous_ids`: how many other ids of that person the window put into it. It is a count, never the ids. Every bucket also has `unique_sessions`.

Times, totals and identified people in `get_breakdown`. From 10 October 2026:

- Each bucket has `first_seen` and `last_seen`: its oldest and newest matching event in the window, in UTC. So the newest value of a property, such as a release, is the bucket with the latest `first_seen`. When `truncated` is true, a newer value can be missing.
- The answer has `total`: the events, people and sessions over all buckets, before the limit of 100 buckets. A person in two buckets counts in both. So use `total`, not a sum of the buckets.
- A person bucket has `identified`: true when an identify call linked an anonymous id to that person, false when none did, `null` when Sequential cannot check. `false` does not mean anonymous: an id that your project sent without Sequential's identify is also `false`.

The event catalog. From 10 October 2026, `get_event_types` gives the event types over all the events that Sequential holds. It also gives the custom event names of the last `days` days (1–30, default 30): at most 10 names, the most events first. Each name has its events, its sessions, and its first and last event in the window. It has up to 8 property names, each with its kind (`string`, `number`, `boolean` or `datetime`), how many events carry it, and that share in percent (`fill_pct`). The catalog does not list property values: for those, use `get_breakdown` by `event_prop:<key>`. A property marked `restricted` is an element-text or identity property. See [Privacy at a glance](/docs/privacy-overview#analytics).

New people and accounts. From 10 October 2026, each row of `list_users` and `list_entities` has `first_seen_at`: the first event in the window, not before it. `sort: "first_seen_at"` lists the newest first. `first_seen_within_days: N` keeps only the rows whose `first_seen_at` is in the last N days of the window. Both work on the rows that the list found, so at most on the 10,000 most recently active.

Ids in `retention_analysis`. From 10 October 2026, `include_ids: true` adds the ids of each cohort's members and of the members who came back. The whole answer gives at most 50 of each, from the earliest cohort on. So a later cohort's list can be short or empty, with its `truncated` flag true. `include_ids` needs the scope `sessions:explore` too. Without it, Sequential refuses the call. Each id is the person after identity resolution. On a large project, the call can stop at its time limit. Then call again without `include_ids`.

The `page` field. An agent can use `page` in a filter, and as `field` or `second_field` of `get_breakdown`. `page` is the route template of the page address. Sequential removes the scheme, the host, the query, the fragment and a slash at the end. It shows numbers, UUIDs and long hex ids as `:id`. So `/replay?session_id=…` and `/replay` are one page, and `/users/123/orders/456` is `/users/:id/orders/:id`. From 6 November 2026, for a mobile app event with no URL, `page` is the page of its screen, for example `/Checkout`. See [Screens are pages](/docs/mobile#screens-are-pages). The filters of Workbench offer it as Page.

## Exports

Owners and admins can export the events and sessions of a project as files, under Settings › Data out or with a token that has `exports:write`. See [Export your data](/docs/export-your-data).

| Limit | Value | What happens at the limit |
|---|---|---|
| Exports started per project | 3 a day, counted from 00:00 UTC. A failed export counts too | 429 `export_daily_limit`. The app says "This project already started 3 exports today (UTC), the most for one day. Try again in …" |
| Exports at the same time per project | 1 waiting or running | 409 `export_in_progress`. The app says "An export of this project is already waiting or running. When it is done, start the next one." |
| Range | Whole UTC days, up to today and at most 366 days. Only data that Sequential still keeps | 400 `invalid_export_request`, or 422 `range_before_retention` with `held_from` |
| Export files | You can download them for 7 days after the export finishes. Each download gets a new link | 410 `export_expired` |

For the other limits, such as the size limit and the download link limit, see [Limits](/docs/export-your-data#limits).

## Values that are not enforced

Some values look like limits, but Sequential does not apply them today.

> **Do not rely on these values**
>
> Three settings under Settings › Recording & data apply nothing yet: Recordings at the same time, Session budget and When the budget is used up. The page says "Saved; nothing applies it yet."

To control how much you record, use Share of sessions recorded, Longest recording and Largest recording. See [Recording settings](/docs/recording-settings).

### Events retention period

`events_retention_days` is applied. Settings › Recording & data shows it under How long data is kept › Events. It is the organisation's events retention period: one of 7, 30, 90, 180 or 365 days. The default is 365. If the server sets a shorter limit, the page shows the limit, and the limit applies. See [A server-wide limit](/docs/retention-and-deletion#a-server-wide-limit). Sequential keeps each event for at least that period and up to about a week longer. Only Sequential support can change it, for all the projects of the organisation. A shorter period deletes nothing. Through the settings API, a change of `events_retention_days` gets 409 `retention_set_by_organisation` and saves nothing. See [Retention and deletion](/docs/retention-and-deletion).

## For self-hosted servers

These notes are for the operator of a Sequential server.

### When a server value is not valid

If the server value for a judging allowance or a request limit is 0, empty or not valid, Sequential uses the default. So nobody can turn off these limits by mistake.

### Server values and status fields

Events:

- On a self-hosted server, the duplicate check is on by default. `INGEST_RETRY_DEDUP=off` turns it off for events, and `HEAT_RETRY_DEDUP=off` for heatmaps. Any other value than `on` or `off` stops the backend from starting. With the check on, the backend does not start on ClickHouse 26.6 or older, or on 26.7 before 26.7.36. Those versions can lose other requests that arrive in the same minute as a duplicate. If the backend cannot read the ClickHouse version when it starts, it runs with the duplicate check off until it starts again. Then `GET /` shows `ingest.retry_dedup_forced_off: true`.

When Sequential is overloaded:

- On a self-hosted server: GET `/` shows `ingest.shed`, `ingest.shed_fraction`, `ingest.event_loop_lag_p99_ms`, `ingest.sojourn_p95_ms`, `ingest.in_flight` and `ingest.utilization`. `ingest.shed_raised_by` and `ingest.shed_raised_far` count which signal made the part larger (`utilization`, `sojourn` or `lag`), and `ingest.shed_by_cap` counts the uploads refused at 128. `INGEST_SHED=off` turns it off.
- How busy the server is (`ingest.utilization`): the larger of the event loop's busy time and the process CPU divided by the CPU quota. `INGEST_CPU_QUOTA_CORES` sets the quota in cores. Without it, Sequential reads the quota from the cgroup files, else it uses 1 core. The limits are `INGEST_SHED_UTIL_HIGH` (0.90), `INGEST_SHED_UTIL_FAR` (0.97), `INGEST_SHED_UTIL_LOW` (0.80), `INGEST_SHED_UTIL_FAST_LOW` (0.70), `INGEST_SHED_UTIL_TICKS` (4 checks of 250 ms) and `INGEST_SHED_UTIL_MIN_ARRIVALS` (50 uploads in a check).

Background judging:

- Background judging runs only while your Sequential server allows it, with `JUDGING_AUTOMATIC=on`.

Daily allowances:

- Operators change the Ask allowance with `ASK_DAILY_TOKENS` and the background judging allowance with `BELIEFS_DAILY_TOKENS`.

Ask from an agent:

- Operators change the limits with `AGENT_DAILY_TOKENS`, `AGENT_TOKEN_DAILY_TOKENS`, `AGENT_JUDGE_MAX_CONCURRENT` and `AGENT_JUDGE_MAX_CONCURRENT_PER_PROJECT`.

Analytics from an agent:

- The operator changes the caps with `AGENT_READ_MAX_CONCURRENT_PER_PROJECT` and `AGENT_READ_MAX_CONCURRENT`, and the wait with `AGENT_READ_QUEUE_MS` and `AGENT_READ_QUEUE_MAX`.

Tokens:

- Operators change the token rate limit with `TOKEN_REQUESTS_PER_MINUTE`.

## Related pages

- [Session replay recording settings](/docs/recording-settings): project defaults for recordings.
- [Check that your install works](/docs/verify): check that data arrives.
- [DevTools in session replays](/docs/devtools): DevTools data in a replay.
- [How the judge works](/docs/judgments): when sessions are judged.
- [Ask: one line about sessions, funnels, retention or people](/docs/ask): Ask in the app.
- [Two-factor authentication and account security](/docs/two-factor-and-security): sign-in rules.
- [Data retention and deletion](/docs/retention-and-deletion): how long data is kept.
- [Troubleshooting Sequential](/docs/troubleshooting): fixes for refusals.
