# DevTools in session replays

> DevTools shows the console, network requests, errors and page performance behind a session replay. Use it to find broken sessions on Workbench › Sessions.

> **At a glance**
>
> - **Know this:** A replay shows what the person saw. DevTools shows what your product did at the same moment.
> - **Before you start:** Websites: Sequential's recorder, from [Session replay (web)](/docs/session-replay) or the [Sequential SDK](/docs/sequential). It works with any analytics SDK.
> - **Before you start:** [Mobile apps](/docs/mobile): a PostHog iOS or Android SDK that sends to Sequential.
> - **Who can:** Owners and admins change the capture settings.
> - **Default:** On websites, JavaScript errors, Console output, Network requests and Performance timings are on. Console message text is off.
> - **You get:** On Workbench › Sessions, a Problems column and three filters that find broken sessions anywhere in the window.
> - **Know this:** A blank Problems cell does not prove a clean session. Sequential may not have counted it.

> **In short**
>
> - Mobile apps send Console and Network only, and only what their SDK sends. Their logs need Console message text on.
> - With Console message text on, everyone who can watch replays in the project can read what your app logs.

## Open DevTools in a replay

1. Open a session from **Evidence** or from **Workbench › Sessions**.

   Result: Under the player, a panel has the tabs What they did, Console, Network, Errors and Performance.

2. Click a tab.

3. To move the replay to an entry, click the entry.

### Timeline marks, tab counts and the first tab

Marks on the player's timeline show each JavaScript error ("Error:" and the message) and each failed request ("Failed request:" and the method, the path and the status). Click a mark to move the replay to it.

The tabs show their counts. For example, Errors shows the number of errors, and Network shows the number of requests and "1 failed".

The panel opens on Errors when the session had errors, on Network when requests failed, and else on What they did. For what each tab shows, see [Each tab in detail](#each-tab-in-detail).

### Each tab in detail

Console:

- Each row shows the time, the kind or level, and the message. Click a row to see where the app logged it, such as `cart.js:42`, and its stack trace.
- A message that repeats in a row is one row, marked ×N.
- Click an error row to show Ask your agent under it. An error row is an exception, or a console line of the level error. A row that reads "Text withheld" has no Ask your agent. Warnings and recorder notices have none.
- If an error reads only `Script error.`, the browser hid its details, because the script comes from another origin. To see the details, add `crossorigin="anonymous"` to the script tag. Then serve the script with CORS headers.

Network:

- Each row is one request, with its time, method, address, status, duration and size. A status can be, for example, "404" or "timeout". Click a row to see what happened to it.
- A prefetch shows "a prefetch" in its Type. A prefetch is never a failure.
- Failed shows only the failed requests. Fetch / XHR, Document and Assets show one type.
- Parts of an address shown as █ were masked by the project's [masking settings](/docs/masking-and-redaction).
- The detail never shows headers or bodies: "Headers and bodies are never recorded, and nor are a request's phases (DNS, connecting, waiting): the recorder keeps the method, address, status, start, duration and size."

Errors:

- Each row is one JavaScript error, with its message, its kind, the file it came from and its stack trace. A repeated error is one row, marked ×N.
- Each error with a message has Ask your agent under its stack. It gives your coding agent a prompt about the error: the session, the time of the error, the page and the error message. See [Ask your agent](/docs/sessions-and-replay#ask-your-agent).

Performance:

- The tab shows one card per full page load. It does not measure navigations inside a single-page app separately.
- Each card shows the Core Web Vitals LCP, INP, CLS, FCP and TTFB. Each is rated good, needs improvement or poor, with its cut-offs. For example: "The largest content appeared after 2.4 s: good (good up to 2.5 s, poor above 4 s)."
- To see the full name of a vital, hover over it.
- Below the vitals, sentences give the load's timing: DNS, connecting, the server's answer, and when the page was interactive and fully loaded.

Info:

- On the session page, the last tab is Info. Info lists the facts of the session and the properties of the person. See [Find and replay sessions](/docs/sessions-and-replay).

#### Messages in the tabs

| Message | Where | What it means | What to do |
|---|---|---|---|
| "DevTools come with the recording, and this session has none to play." | The tabs | The session has no recording to play. | — |
| "The recording did not load, so its DevTools cannot show. Try again from the player." | The tabs | The recording did not load. | — |
| "Text withheld" | Console | Console message text is off. The row shows where the app logged the message. Errors keep their message. | — |
| "The page made more requests than the recorder keeps (1,000); later ones are missing." | Console | A recorder notice: the recorder reached a per-page limit, and some entries were not recorded. | — |
| "(the recorder dropped some entries, so counts are lower bounds)" | The end of the line at the top of the DevTools panel | The recorder reached a per-page limit. Some entries were not recorded. Read each number as "at least" that number. | — |
| "It was cancelled because the person left the page." | Network, a request | This is not a failure. | — |
| "It failed while the tab was in the background." | Network, a request | This is a failure. | — |
| "No stack was recorded for this error." | Errors | The error has no stack. | — |
| "Not reported: it is sent when the page is left, and this page did not report it." | Performance, LCP or CLS | The page never reported that vital. | — |

## Find the sessions that broke

1. Go to **Workbench › Sessions**.

   Result: The Problems column names the problems of each session. For example: "2 requests failed, 1 error".

2. Click **More filters** ([Find sessions with problems](/docs/sessions-and-replay#find-sessions-with-problems)).

3. To show only the sessions that broke, click a filter under **Problems**.

4. To turn a filter off, click it again.

The filters are:

- An error or a failed request
- The recording measured an error
- The recording measured a failed request

The last two are the measured filters. They count only what Sequential stored from the recording. If both measured filters are on, a session must match both.

For each kind of problem, a session is in one of three states. Two of them show no DevTools count.

| State | What it means | On the row |
|---|---|---|
| Counted | Sequential counted that kind of problem in the session. | The count if it found any. Nothing if it found none. |
| Not captured | Sequential counted the session, but not this kind. The recording or the app's SDK did not report it. | No DevTools count. The row never shows the kind as 0 or "off". |
| Not measured | Sequential has not counted all of the session. | No DevTools count. |

The measured filters can only return counted sessions. The sessions that they leave out may have broken too. To see them, turn the filter off.

### Why a session is not captured or not measured

Not captured:

- On websites, the recording did not report that kind. Usually that capture was off for your project.
- A website recording with no DevTools data at all is also in this state after Sequential counts it. An example is a recording made before DevTools existed.
- On mobile, your app's SDK did not report that kind.
- A mobile session with no observed failed request is also in this state.

Not measured:

- Sequential has no counts for the session. Sequential counts each part of a recording when the part arrives, so this does not happen to a recording that the current server stored.

Why Sequential does not show zero: a zero reads as "nothing went wrong". The filter "The recording measured an error" would silently drop every older broken session if Sequential gave zero to the sessions that it did not count. The list would then call those sessions clean.

The AI judge behind [Evidence](/docs/watch) and [Ask](/docs/ask) reads these counts too. Sequential never tells the judge zero for something it did not count. If Sequential counted only part of a session and N is above zero, it tells the judge "at least N".

### What the problems and filters count

What the counts include:

- JS errors are uncaught exceptions and unhandled promise rejections that Sequential's recorder caught. They also include errors reported through the Smartlook compatibility script. See [Moving from Smartlook](/docs/smartlook).
- `console.error` calls are not in this count. The Console tab shows them.
- A failed request is a fetch or XHR call that returned HTTP 400 or above. On websites, a call that ended in a network error or a timeout has also failed, also when the tab was in the background.
- Aborted requests, requests that the browser cancelled because the person left the page, prefetches, and failed assets, such as images and scripts, do not count as failed requests. A prefetch is a request that the page sends before the person needs it. For a cancel when the person left the page and for a prefetch, this applies to sessions recorded from 13 October 2026. Before that day, the recorder could not tell a cancel when the person left the page from a network error.
- Some browsers, for example Safari on iPhone, give no sign before the person leaves the page. From 18 October 2026, in these browsers, a GET request that ends with a network error at most 1 second before the person leaves the page is also a cancel, not a failed request. A request of another method, for example POST, stays a failed request.
- Without DevTools counts, for example in a session with no recording, the Problems column counts the session's error events and the problems stored from its recording, in your window.

How the filters work: Sequential applies the filter before it splits the list into pages. So the filter finds broken sessions anywhere in the window.

## Turn captures on or off

> **Sequential recommends that you keep Console message text off in production**
>
> - If you turn it on, Sequential stores whatever your app writes to the console.
> - With Console message text on, everyone who can watch replays in the project can read what your app logs.
> - If you turn it off later, Sequential does not remove text that is already stored. See [Retention and deletion](/docs/retention-and-deletion).
> - Redaction catches only known formats. It is not a guarantee.
> - Settings are per project. So you can turn text on in a staging project and keep it off in a production project.

1. Go to **Settings › Recording & data**.

2. Under **What a recording carries**, select or clear the captures, the Console output levels and **Console message text**.

3. To keep the values of some query parameters, add their names to **Query values kept**.

4. To skip some requests, add URL patterns to **Requests ignored**. Write `**/health`, not `/health`: a pattern must match the whole URL without its query.

   Result: If a pattern matches nothing, Sequential gives no warning. The requests you meant to skip are still recorded.

5. Click **Save changes**.

   Result: If the change records more than before, the page asks you to type the project slug.

6. If the page asks for the slug, type it. Then click **Save and record more**.

Result: Websites use the change on their next page load. Mobile apps use it on their next launch. When you turn a capture on, Sequential does not fill in older sessions.

### Settings in detail

What each capture records:

| Capture | What it records | What it never records | Default |
|---|---|---|---|
| JavaScript errors | Uncaught exceptions and unhandled promise rejections, with their message and stack trace | — | On. Web only |
| Console output | For each selected level: each call's level, how often it happened and where. A stack trace for warnings and errors | Message text, unless Console message text is on | On for `error`, `warn`, `info` and `log`. `debug` off. Text off |
| Network requests | Method, URL, status, timing and size. Under Masked attribute values, the URL is shorter (see [How masking changes DevTools addresses](#how-masking-changes-devtools-addresses)) | Headers and bodies. Query values, except for keys under Query values kept. Requests that match Requests ignored | On, keeping no query values |
| Performance timings | Core Web Vitals and page-load timing, once per page load | Long tasks | On. Web only |

Whatever the settings, Sequential replaces some values with `[redacted]` in DevTools data. This redaction catches only known formats. It is not a guarantee. See [What does Sequential redact in DevTools data?](#what-does-sequential-redact-in-devtools-data) and [Masking and redaction](/docs/masking-and-redaction).

The settings page:

- Only owners and admins can change these settings. Other roles see the settings read-only, with a line such as "You are a member: you can read these settings; owners and admins change them."
- The captures are one setting for the project. They apply to websites and mobile apps.
- Under What a recording carries, the settings are JavaScript errors, Performance timings, Console output and its levels, Console message text, Network requests, Query values kept and Requests ignored.
- JavaScript errors says "Web only." Performance timings says "Core Web Vitals and page-load timing, once per page load. Long tasks are not recorded. Web only."
- A pattern matches the whole URL, scheme and host included, but not the query. So write `https://api.example.com/health` or `**/health`, not `/health`.
- In a pattern, `*` stays within a path segment. `**` crosses path segments.
- The help under Requests ignored says: "One pattern per line, matched against the whole URL without its query. * stays within a path segment, ** crosses them. For example https://api.example.com/health*."
- These changes record more than before, so the page asks for the project slug before it saves: errors, console or network capture turned on; a level added; message text turned on; a query value kept; a request pattern removed.

Sequential applies your current settings to every upload as it arrives. So when you turn a capture off, Sequential stops storing that data immediately. See [Recording settings](/docs/recording-settings) and [Session replay (web)](/docs/session-replay).

### Console message text in detail

- Turn text on freely in a staging or development project.
- In production, turn it on only after you check what your app logs.

While text is off, console rows read "Text withheld" and where the app logged them, such as `/cart.js:42`. With text on, you also see the words that your app logged, such as "payment failed: card_declined". This is the difference between knowing that `console.error` fired and knowing why.

Exceptions keep their message either way. There is one case where this is not true: a promise rejected with a plain object, not an Error or a string. While text is off, that rejection reads only as its type, such as `Unhandled rejection: [object Object]`.

Redaction catches formats, not meaning. For example, Sequential does not redact `console.log("reset link for", user, "is", url)`. It also does not redact names, addresses, one-time links, custom tokens or logged API responses.

While text is off, Sequential empties message text as it arrives. This includes text from an older recorder, or from a mobile SDK that sends it. Text that is already stored stays in the recording. Sequential cannot remove it. See [Retention and deletion](/docs/retention-and-deletion).

From 8 November 2026, under the box Console message text, the page says "Keeps the text of each console message in the recording." A row says Default: "Off". A risk line always shows: "Messages can hold what people typed or saw." The old help is under Read the full text ▾.

### How masking changes DevTools addresses

The Attribute values (titles, labels, alt text, data-*) masking setting also changes the addresses in DevTools. The Strict level uses Masked. The Balanced level uses Recorded as on the page. The recorder applies the rule in the browser, and Sequential's servers apply it again under the project's current setting. For iOS and Android apps, only the servers apply it.

| What | Masked | Kept, URLs cut to the path (Custom) | Recorded as on the page (Balanced) |
|---|---|---|---|
| A network request for a file that the page loads, such as an image, CSS, a script, a font or media | Domain kept. Every path segment masked. No query | Path kept. No `;` parameters. Query values `[redacted]` | Path kept. Query values `[redacted]` |
| A fetch or XHR call, and the page itself | Domain and route kept. Id-like segments masked. No `;` parameters. Query values `[redacted]` | Path kept. No `;` parameters. Query values `[redacted]` | Path kept. Query values `[redacted]` |
| Code locations: the file of an error, each stack frame, and where a console entry came from | A script or other asset file: domain kept, every path segment masked, no query. Any other address: domain and route kept, id-like segments masked, query values `[redacted]`. Line and column kept | Path kept. No `;` parameters. Query values `[redacted]` | Path kept. Query values `[redacted]` |
| `http(s)` and `ws(s)` addresses in error messages and console text | Changed as code locations are | Changed as code locations are | Kept. Only redaction runs |
| UUIDs, hex runs of 16 or more characters and runs of 6 or more digits after a `/` in error messages, console text and stack frames | Masked | Kept | Kept |

- A request with no kind, or a kind that Sequential does not know, counts as a file.
- Query values kept applies to network requests only. In every setting, query parameter names stay, and addresses lose the `#fragment` and any `user:pass@`.
- Under Masked and Kept, URLs cut to the path, a query item with no `=`, such as `?<uuid>`, becomes `[redacted]`.
- A segment is id-like when it holds a UUID, a hex run of 16 or more characters or an email address anywhere, such as `<uuid>.json`. [Masking and redaction](/docs/masking-and-redaction) gives the full rule.
- The text rule reads each word that holds a `/`, and masks only what comes after the first `/`. Prose such as `and/or`, `2026/09/29` and `v1/2` stays as it is.

What Masked does not mask in DevTools:

- Domain names, and query parameter names.
- Numbers of 5 digits or fewer, and name slugs, in the route of an API call.
- An id in text with no `/` before it in its word, such as `id=<uuid>`. The keys of a logged object.

Under Masked, you cannot see which file failed to load. A failed image, script or font shows only its domain, its kind, its status and its timing. To find the file, reproduce the issue in a browser, or use Kept, URLs cut to the path on a staging project.

## What mobile apps send

Sequential asks an app for logs only when Console output has a level selected and Console message text is on. So with the default settings, Sequential asks for no logs. The same is true while you keep Console message text off in production, as Sequential recommends.

| SDK | Logs, when Sequential asks for them | Network requests |
|---|---|---|
| iOS | Needs `captureLogs: true` | From URLSession by default |
| Android | Logcat by default | Needs `PostHogOkHttpInterceptor` |
| React Native | `captureLog` is on by default | On iOS only |
| Flutter | None | None |

- An empty tab is ambiguous. Either the SDK sent nothing, or the capture was off.
- Mobile sessions never match the filter "The recording measured an error".
- Sequential cannot see a request that got no response, such as a timeout or no connection. So the real number of failed requests can be higher than the count.

### Mobile apps in detail

iOS and Android recordings come from PostHog's mobile SDKs. See [Mobile apps](/docs/mobile) and [What each SDK supports](/docs/support-matrix).

Under Record on, Settings › Recording & data says: "iOS and Android apps are sent these switches, the share recorded, the shortest session, and whether to send console logs and network timing; the app's SDK decides what else it captures. What an app sends is then filtered by the console and network settings under What a recording carries and by Attribute values, and refused past Largest recording." So the console and network settings, and Attribute values, apply to what an app sends.

Under Console message text, the page says: "On iOS and Android, logs are requested from the app only when Console message text is on."

- The Performance tab reads "Performance metrics are recorded for websites."
- The Errors tab reads "Uncaught errors are recorded for websites. An app’s error logs are in Console."
- Every mobile log counts as console output, never as an exception. So the filter "The recording measured an error" never matches a mobile session.
- The replay cannot tell an SDK that sent nothing from a capture that was off. The empty tab says this, for example: "This app’s SDK didn’t send logs, or console capture is off for this project."

Per SDK: native iOS apps must also set `captureLogs: true`. Android needs `PostHogOkHttpInterceptor` to send requests.

Requests with no response: mobile SDKs send request metrics only. On mobile, a request counts as failed only when it returned HTTP 400 or above. Sequential cannot see a request that got no response at all, such as a timeout or no connection. PostHog's mobile SDKs do not report it, and no setting changes that.

A mobile session with no observed failure is "couldn't be checked", never "0 failed requests". It shows no count for it. The filter "The recording measured a failed request" does not match it.

## FAQ

### What questions does DevTools answer?

- A typical question: a person on a trial clicked "Pay" three times and left. Did the payment call fail, or did nothing happen?
- Which sessions this week had a JS error? Watch the ones that broke, not a random sample.
- A customer says the dashboard is slow. Did the main content paint in 1 second or in 6?

### How does Sequential store and count DevTools data?

On websites, Sequential's recorder captures JS errors, console output, network requests and page performance with each recording. Each is a capture that you turn on or off per project.

- Sequential stores only what the settings allow. When a recording arrives, Sequential applies the project's current DevTools settings, whatever the page sent.
- Sequential counts only what it stored. It counts the JS errors and failed requests in the stored data. So the measured filters never count something that the replay cannot show you.

### What does Sequential redact in DevTools data?

Whatever the settings, Sequential replaces these values with `[redacted]` in DevTools data:

- JWTs, and Bearer and Basic credentials
- email addresses
- card numbers that pass a Luhn check
- values logged under key names such as token, password or secret

On websites, Sequential does this before anything leaves the browser, and again on the server. See [Masking and redaction](/docs/masking-and-redaction).

## Limits

| Per-page limit | What the recorder does |
|---|---|
| 1 MB of DevTools data | Stops DevTools capture |
| 1,000 requests | Stops network capture |
| An entry over 64 KB | Leaves out that entry |
| A burst of console messages or exceptions | Rate-limits them |

Each limit shows as a recorder notice in the Console tab. The line at the top of the panel then says that counts are lower bounds.

- There is no problem word or filter for console errors and warnings.
- The filter "The recording measured an error" does not find errors that your analytics SDK reports, such as PostHog exceptions.
- Performance measures full page loads only. It does not measure navigations inside a single-page app.

## Next steps

- [Find and replay sessions](/docs/sessions-and-replay): Info and Ask your agent.
- [Recording settings](/docs/recording-settings): the other recording settings.
- [Mobile apps](/docs/mobile): set up the PostHog SDKs.
- [Evidence](/docs/watch) and [Ask](/docs/ask): the judge behind them reads these counts too.
