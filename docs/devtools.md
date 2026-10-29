# DevTools in session replays

> DevTools shows the console, network requests, errors and page performance behind a session replay. Use it to find broken sessions on Workbench › Sessions.

> **In short**
>
> - A replay shows what the user saw. DevTools shows what your product did at the same moment.
> - On websites, Sequential records JS errors, console output, network requests and page performance. All four captures are on by default.
> - On **Workbench** › **Sessions**, the **Problems** column and the problem filters show the sessions that broke.
> - A session row with nothing in **Problems** never means that the session was clean.
> - Console message text is off by default. If you turn it on, everyone who can watch replays in the project can read what your app logs.

## What it is for

A typical question: a trial user clicked "Pay" three times and left. Did the payment call fail, or did nothing happen?

## What it needs

| Platform | What it needs |
|---|---|
| Websites | Sequential's recorder on the page, from [Session replay (web)](/docs/session-replay) or started by the [Sequential SDK](/docs/sequential). It works with any analytics SDK. |
| Mobile apps | A PostHog iOS or Android SDK that sends to Sequential. See [Mobile apps](/docs/mobile). |

## Open DevTools in a replay

1. Open a session from **Evidence** or from **Workbench** › **Sessions**. Under the player, a panel has the tabs **What they did**, **Console**, **Network**, **Errors** and **Performance**. On the session page, the last tab is **Info**.
2. Click **Console**, **Network**, **Errors** or **Performance**.
3. To move the replay to an entry, click the entry.

The panel opens on **Errors** when the session had errors, on **Network** when requests failed, and else on **What they did**. If the session has no recording to play, the tabs say "DevTools come with the recording, and this session has none to play." If the recording did not load, they say "The recording did not load, so its DevTools cannot show. Try again from the player."

**Info** lists the facts of the session and the properties of the person. See [Find and replay sessions](/docs/sessions-and-replay).

Each error with a message has **Ask your agent**. It gives your coding agent a prompt about the error: the session, the time of the error, the page and the error message. See [Ask your agent](/docs/sessions-and-replay#ask-your-agent).

## Find the sessions that broke

1. Open **Workbench** › **Sessions**. The **Problems** column names the problems of each session. For example: "2 requests failed, 1 error". Without DevTools counts, for example in a session with no recording, the column counts the session's error events and the problems stored from its recording, in your window.
2. To show only the sessions that broke, click **An error or a failed request**, **The recording measured an error** or **The recording measured a failed request** under **Problems**.
3. To turn a filter off, click it again.

When the recorder reached a per-page limit, the line at the top of the DevTools panel ends with "(the recorder dropped some entries, so counts are lower bounds)". Some entries were not recorded. Read each number as "at least" that number.

> **No problem does not mean no problems**
>
> - A session with nothing in **Problems** may be one that Sequential did not check for that kind of problem.
> - **The recording measured an error** and **The recording measured a failed request** can only return counted sessions.
> - Those sessions may have broken too. To see them, turn the filter off.

> **Console message text**
>
> - **Console message text** is off by default. We recommend that you keep it off in production.
> - If you turn it on, Sequential stores whatever your app writes to the console. Everyone who can watch replays in the project can read it.
> - If you turn it off later, Sequential does not remove text that is already stored.
> - Redaction catches only known formats. It is not a guarantee.

## Turn captures on or off

Only owners and admins can change these settings.

1. Go to **Settings** › **Recording & data**.
2. Under **What a recording carries**, tick or untick the captures and the console levels.
3. To keep the values of some query parameters, add their names to **Query values kept**.
4. To skip some requests, add URL patterns to **Requests ignored**. A pattern must match the whole URL.
5. Click **Save changes**. If the change records more than before, the page asks you to type the project slug. Then click **Save and record more**.

If a pattern matches nothing, Sequential gives no warning. Those requests are still recorded.
- The captures are one setting for the project. They apply to websites and mobile apps.

## Mobile apps

DevTools shows only what PostHog's mobile SDKs send.

- **Console and Network only.** Mobile sessions never match **The recording measured an error**.
- **No logs with the default settings.** Sequential asks for logs only when **Console output** has a level ticked and **Console message text** is on. Under **Console message text**, the page says: "On iOS and Android, logs are requested from the app only when Console message text is on."
- **Failed requests can be higher than the count.** Sequential cannot see a request that got no response, such as a timeout, and no setting changes that. So a mobile session with no observed failure does not match **The recording measured a failed request**.
- **An empty tab is ambiguous.** Either the SDK sent nothing, or the capture was off.
- Flutter apps send no logs and no requests. React Native sends requests on iOS only. iOS logs need `captureLogs: true`. Android requests need `PostHogOkHttpInterceptor`.

## Limits

| Per-page limit | What the recorder does |
|---|---|
| 1 MB of DevTools data | Stops DevTools capture |
| 1,000 requests | Stops network capture |
| An entry over 64 KB | Leaves out that entry |
| A burst of console messages or exceptions | Rate-limits them |

Each limit shows as a recorder notice in the **Console** tab. The line at the top of the panel then says that counts are lower bounds.

- There is no problem word or filter for console errors and warnings.
- When you turn a capture on, Sequential does not fill in older sessions.
- **The recording measured an error** does not find errors that your analytics SDK reports, such as PostHog exceptions.
- Aborted requests, requests that the browser cancelled because the user left the page, prefetches, and failed images or scripts do not count as failed requests.
- Performance measures full page loads only. It does not measure navigations inside a single-page app.

### More questions DevTools answers

- Which sessions this week had a JS error? You can watch the ones that broke, not a random sample.
- A customer says the dashboard is slow. Did the main content paint in 1 second or in 6?

### How Sequential stores and counts

On websites, Sequential's recorder captures JS errors, console output, network requests and page performance with each recording. Each is a capture that you turn on or off per project. All four are on by default.

- **Sequential stores only what the settings allow.** When a recording arrives, Sequential applies the project's current DevTools settings, whatever the page sent.
- **Sequential counts only what it stored.** It counts the JS errors and failed requests in the stored data. So the filters **The recording measured an error** and **The recording measured a failed request** never count something that the replay cannot show you.

### Other ways to find an entry

The tabs show their counts. For example, **Errors** shows the number of errors, and **Network** shows the number of requests and "1 failed".

Marks on the player's timeline show each JavaScript error ("Error:" and the message) and each failed request ("Failed request:" and the method, the path and the status). Click a mark to move the replay to it. For what each tab shows, see **Each tab in detail**, below.

### What the problems and filters count

What the counts include:

- **JS errors** are uncaught exceptions and unhandled promise rejections that Sequential's recorder caught. They also include errors reported through the Smartlook compatibility script. See [Moving from Smartlook](/docs/smartlook).
- `console.error` calls are not in this count. The **Console** tab shows them.
- A **failed request** is a fetch or XHR call that returned HTTP 400 or above. On websites, a call that ended in a network error or a timeout has also failed, also when the tab was in the background.
- A call that the browser cancelled because the user left the page has not failed. Neither has a prefetch, which is a request that the page sends before the user needs it. This applies to sessions recorded from 13 October 2026. Before that day, the recorder could not tell a cancel when the user left the page from a network error.
- Some browsers, for example Safari on iPhone, give no sign before the user leaves the page. From 18 October 2026, in these browsers, a GET request that ends with a network error at most 1 second before the user leaves the page is also a cancel, not a failed request. A request of another method, for example POST, stays a failed request.

How the filters work:

- If both **The recording measured an error** and **The recording measured a failed request** are on, a session must match both.
- Sequential applies the filter before it splits the list into pages. So the filter finds broken sessions anywhere in the window.

### The three states of a session

For each kind of problem, a session is in one of three states. Two of them show no DevTools count.

| State | What it means | On the row |
|---|---|---|
| Counted | Sequential checked the session for that kind of problem. | The count if it found any. Nothing if it found none. |
| Not captured | Sequential counted the session, but not this kind. The recording or the app's SDK did not report it. | No DevTools count. The row never shows the kind as 0 or "off". |
| Not measured | Sequential has not counted all of the session. | No DevTools count. |

The difference is important when a filter is on. **The recording measured an error** and **The recording measured a failed request** leave out sessions that are not captured or not measured.

### Why a session is not captured or not measured

**Not captured**

- On websites, the recording did not report that kind. Usually that capture was off for your project.
- A website recording with no DevTools data at all is also in this state once Sequential counts it. An example is a recording made before DevTools existed.
- On mobile, your app's SDK did not report that kind.
- A mobile session with no observed failed request is also in this state. Sequential cannot see a request that got no response.

**Not measured**

- Sequential has no counts for the session. Sequential counts each part of a recording when the part arrives, so this does not happen to a recording that the current server stored.

### Why Sequential does not show zero

A zero reads as "nothing went wrong". If unchecked sessions counted as zero, **The recording measured an error** would silently drop every older broken session. The list would then call those sessions clean.

The AI judge behind [Evidence](/docs/watch) and [Ask](/docs/ask) reads these counts too. Sequential never tells the judge zero for something it did not count.

If Sequential counted only part of a session and N is above zero, it tells the judge "at least N".

### What each capture records

| Capture | What it records | What it never records | Default |
|---|---|---|---|
| **JavaScript errors** | Uncaught exceptions and unhandled promise rejections, with their message and stack trace | — | On. Web only |
| **Console output** | For each ticked level: each call's level, how often it happened and where. A stack trace for warnings and errors | Message text, unless **Console message text** is on | On for `error`, `warn`, `info` and `log`. `debug` off. Text off |
| **Network requests** | Method, URL, status, timing and size. Under **Masked** attribute values, the URL is shorter (see **How masking changes DevTools addresses**) | Headers and bodies. Query values, except for keys under **Query values kept**. Requests that match **Requests ignored** | On, keeping no query values |
| **Performance timings** | Core Web Vitals and page-load timing, once per page load | Long tasks | On. Web only |

Whatever the settings, Sequential replaces some values with `[redacted]` in DevTools data. This redaction catches only known formats. It is not a guarantee. See **What Sequential redacts**, below, and [Masking and redaction](/docs/masking-and-redaction).

### Each tab in detail

**Console**

- Each row shows the time, the kind or level, and the message. Click a row to see where the app logged it, such as `cart.js:42`, and its stack trace.
- A message that repeats in a row is one row, marked ×N.
- While **Console message text** is off, a row reads "Text withheld" and where it was logged. Errors keep their message.
- A recorder notice reads, for example, "The page made more requests than the recorder keeps (1,000); later ones are missing."
- Click an error row to show **Ask your agent** under it. An error row is an exception, or a console line of the level error. A row that reads "Text withheld" has no **Ask your agent**. Warnings and recorder notices have none.

If an error reads only `Script error.`, the browser hid its details, because the script comes from another origin. To see the details, add `crossorigin="anonymous"` to the script tag. Then serve the script with CORS headers.

**Network**

Each row is one request, with its time, method, address, status, duration and size. A status can be, for example, "404" or "timeout". Click a row to see what happened to it, for example:

- "It was cancelled because the person left the page." This is not a failure.
- "It failed while the tab was in the background." This is a failure.
- A prefetch shows "a prefetch" in its **Type**. A prefetch is never a failure.

- **Failed** shows only the failed requests.
- **Fetch / XHR**, **Document** and **Assets** show one type.
- Parts of an address shown as █ were masked by the project's masking settings.
- The detail never shows headers or bodies: "Headers and bodies are never recorded, and nor are a request's phases (DNS, connecting, waiting): the recorder keeps the method, address, status, start, duration and size."

Aborted requests, requests cancelled because the user left the page, prefetches, and failed assets, such as images and scripts, do not count as failed requests.

**Errors**

- Each row is one JavaScript error, with its message, its kind, the file it came from and its stack trace. A repeated error is one row, marked ×N.
- An error without a stack reads "No stack was recorded for this error."
- Each error with a message has **Ask your agent** under its stack.

**Performance**

- The tab shows one card per full page load.
- It does not measure navigations inside a single-page app separately.
- Each card shows the Core Web Vitals **LCP**, **INP**, **CLS**, **FCP** and **TTFB**. Each is rated good, needs improvement or poor, with its cut-offs. For example: "The largest content appeared after 2.4 s: good (good up to 2.5 s, poor above 4 s)."
- To see the full name of a vital, hover over it.
- An **LCP** or **CLS** that the page never reported reads "Not reported: it is sent when the page is left, and this page did not report it."
- Below the vitals, sentences give the load's timing: DNS, connecting, the server's answer, and when the page was interactive and fully loaded.

### What Sequential redacts

Whatever the settings, Sequential replaces these values with `[redacted]` in DevTools data:

- JWTs, and Bearer and Basic credentials
- email addresses
- card numbers that pass a Luhn check
- values logged under key names such as token, password or secret

On websites, Sequential does this before anything leaves the browser, and again on the server. See [Masking and redaction](/docs/masking-and-redaction).

### How masking changes DevTools addresses

The **Attribute values (titles, labels, alt text, data-*)** masking setting also changes the addresses in DevTools. The **Strict** level uses **Masked**. The **Balanced** level uses **Recorded as on the page**. The recorder applies the rule in the browser, and Sequential's servers apply it again under the project's current setting. For iOS and Android apps, only the servers apply it.

| What | **Masked** | **Kept, URLs cut to the path** (Custom) | **Recorded as on the page** (Balanced) |
|---|---|---|---|
| A network request for a file that the page loads, such as an image, CSS, a script, a font or media | Domain kept. Every path segment masked. No query | Path kept. No `;` parameters. Query values `[redacted]` | Path kept. Query values `[redacted]` |
| A fetch or XHR call, and the page itself | Domain and route kept. Id-like segments masked. No `;` parameters. Query values `[redacted]` | Path kept. No `;` parameters. Query values `[redacted]` | Path kept. Query values `[redacted]` |
| Code locations: the file of an error, each stack frame, and where a console entry came from | A script or other asset file: domain kept, every path segment masked, no query. Any other address: domain and route kept, id-like segments masked, query values `[redacted]`. Line and column kept | Path kept. No `;` parameters. Query values `[redacted]` | Path kept. Query values `[redacted]` |
| `http(s)` and `ws(s)` addresses in error messages and console text | Changed as code locations are | Changed as code locations are | Kept. Only redaction runs |
| UUIDs, hex runs of 16 or more characters and runs of 6 or more digits after a `/` in error messages, console text and stack frames | Masked | Kept | Kept |

- A request with no kind, or a kind that Sequential does not know, counts as a file.
- **Query values kept** applies to network requests only. In every setting, query parameter names stay, and addresses lose the `#fragment` and any `user:pass@`.
- Under **Masked** and **Kept, URLs cut to the path**, a query item with no `=`, such as `?<uuid>`, becomes `[redacted]`.
- A segment is id-like when it holds a UUID, a hex run of 16 or more characters or an email address anywhere, such as `<uuid>.json`. [Masking and redaction](/docs/masking-and-redaction) gives the full rule.
- The text rule reads each word that holds a `/`, and masks only what comes after the first `/`. Prose such as `and/or`, `2026/09/29` and `v1/2` stays as it is.

What **Masked** does not mask in DevTools:

- Domain names, and query parameter names.
- Numbers of 5 digits or fewer, and name slugs, in the route of an API call.
- An id in text with no `/` before it in its word, such as `id=<uuid>`. The keys of a logged object.

Under **Masked**, you cannot see which file failed to load. A failed image, script or font shows only its domain, its kind, its status and its timing. To find the file, reproduce the issue in a browser, or use **Kept, URLs cut to the path** on a staging project.

### Console message text in detail

While text is off, console rows read "Text withheld" and where the app logged them, such as `/cart.js:42`. With text on, you also see the words that your app logged, such as "payment failed: card_declined". This is the difference between knowing that `console.error` fired and knowing why.

Exceptions keep their message either way. There is one case where this is not true: a promise rejected with a plain object, not an Error or a string. While text is off, that rejection reads only as its type, such as `Unhandled rejection: [object Object]`.

Redaction catches formats, not meaning. For example, Sequential does not redact `console.log("reset link for", user, "is", url)`. It also does not redact names, addresses, one-time links, custom tokens or logged API responses.

- Turn text on freely in a staging or development project.
- In production, turn it on only after you check what your app logs.
- Settings are per project. So you can turn text on in a staging project and keep it off in a production project.

While text is off, Sequential empties message text as it arrives. This includes text from an older recorder, or from a mobile SDK that sends it. Text that is already stored stays in the recording. Sequential cannot remove it. See [Retention and deletion](/docs/retention-and-deletion).

### Settings in detail

- Other roles see the settings read-only, with a line such as "You are a member: you can read these settings; owners and admins change them."
- Under **What a recording carries**, the settings are **JavaScript errors**, **Performance timings**, **Console output** and its levels, **Console message text**, **Network requests**, **Query values kept** and **Requests ignored**.
- The captures are one setting for websites and mobile apps.
- **JavaScript errors** says "Web only." **Performance timings** says "Core Web Vitals and page-load timing, once per page load. Long tasks are not recorded. Web only."
- A pattern matches the whole URL, scheme and host included, but not the query. So write `https://api.example.com/health` or `**/health`, not `/health`.
- In a pattern, `*` stays within a path segment. `**` crosses path segments.
- The help under **Requests ignored** says: "One pattern per line, matched against the whole URL without its query. * stays within a path segment, ** crosses them. For example https://api.example.com/health*."
- These changes record more than before, so the page asks for the project slug before it saves:
  - errors, console or network capture turned on
  - a level added
  - message text turned on
  - a query value kept
  - a request pattern removed

Sequential applies your current settings to every upload as it arrives. So when you turn a capture off, Sequential stops storing that data immediately. Websites use the change on their next page load. Mobile apps use it on their next launch. See [Recording settings](/docs/recording-settings).

### Mobile apps in detail

iOS and Android recordings come from PostHog's mobile SDKs. See [Mobile apps](/docs/mobile).

Under **Record on**, **Settings** › **Recording & data** says: "iOS and Android apps are sent these switches, the share recorded, the shortest session, and whether to send console logs and network timing; the app's SDK decides what else it captures. What an app sends is then filtered by the console and network settings under What a recording carries and by Attribute values, and refused past Largest recording." So the console and network settings, and **Attribute values**, apply to what an app sends.

- The **Performance** tab reads "Performance metrics are recorded for websites."
- The **Errors** tab reads "Uncaught errors are recorded for websites. An app’s error logs are in Console."
- Every mobile log counts as console output, never as an exception. So mobile sessions never match **The recording measured an error**.
- On mobile, a request counts as failed only when it returned HTTP 400 or above. Sequential cannot see a request that got no response, such as a timeout or no connection. No setting changes that.
- So a mobile session with no observed failure does not match **The recording measured a failed request**, and the real number of failed requests can be higher than the count.
- The replay cannot tell an SDK that sent nothing from a capture that was off. The empty tab says this, for example: "This app’s SDK didn’t send logs, or console capture is off for this project."

### Per-SDK differences on mobile

**Logs**

- Native iOS apps must also set `captureLogs: true`.
- Android sends logcat by default.
- In React Native, `captureLog` is on by default.
- The Flutter SDK does not send logs.

**Network requests**

- iOS sends requests from URLSession by default.
- Android needs `PostHogOkHttpInterceptor`.
- React Native sends requests on iOS only.
- Flutter sends none.

**Requests with no response**

Mobile SDKs send request metrics only. Sequential cannot see a request that got no response at all, such as a timeout or no connection. PostHog's mobile SDKs do not report it, and no setting changes that.

So a mobile session with no observed failure is "couldn't be checked", never "0 failed requests". It shows no count for it. It does not match **The recording measured a failed request**.

## Related

- [Find and replay sessions](/docs/sessions-and-replay)
- [Recording settings](/docs/recording-settings)
- [Masking and redaction](/docs/masking-and-redaction)
- [Session replay (web)](/docs/session-replay)
- [Mobile apps](/docs/mobile)
- [Evidence: the sessions worth a look](/docs/watch)
- [Ask](/docs/ask)
- [Retention and deletion](/docs/retention-and-deletion)
- [What each SDK supports](/docs/support-matrix)
