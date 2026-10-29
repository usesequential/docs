# Cases and fixes

> A case is a problem that Sequential counts across sessions. Hand it off, link the fix and mark the release. Then Sequential measures the rate again.

> **In short**
>
> - A **case** is a problem that Sequential counts across sessions: an error, a failed request, a dead click, a rage click or a dead end.
> - Hand a case to a developer or an agent with its **fix brief**. Then link the pull request, commit or issue for the fix.
> - Record a **release marker** for each release. Name the cases that it is for, for example `"finding_ids": ["F-12"]`.
> - About once an hour, Sequential measures again. It compares the sessions before the release with the sessions after it.
> - The result says what the rate did after the release. It never says why.

## What it is for

Use **Cases** to follow a problem from the first time Sequential counts it to the release that is meant to fix it. After the release, **Did the fix work?** on the case shows what the rate did.

## Where cases come from

Sequential looks for five kinds of problems in your events: **Error**, **Failed request**, **Dead click**, **Rage click** and **Dead end**.

Sequential opens a case in one of two ways:

- **From the first session.** A JavaScript error (**Error**), or a request that fails with a server error (5xx) or a network failure, such as a timeout, opens a case from the first session it happens in. One session of one person is enough, an anonymous visitor too. Until it repeats in 3 sessions from 2 people, its fix brief says "Opened from its first session", and the agents' `first_session` is `true`.
- **From your server.** An error that your server sends with the [backend SDK](/docs/backend-sdk) opens a case from its first occurrence, also when it is in no browser session. Until it repeats, its fix brief says "Opened from its first occurrence: an error from your server opens a finding at once." In the list and on the case, its page reads "your server". Its sample sessions are browser sessions only, so a case with only errors in no browser session shows "None from a server error." under **Evidence**. An error in no browser session counts in the people and occurrences of the case, not in its sessions. From 25 October 2026, Sequential measures a fix for a case from your server by its occurrences, not by sessions. See [A case from your server](#a-case-from-your-server). Agents read `sources`: `browser`, `server` or both.
- **When it repeats.** A rage click, a dead click, a dead end, or a request that fails with another status, such as 404, opens a case when the same problem happened in at least 3 sessions, of at least 2 different people, in the last 7 days.
- **A dead end and how people came back.** From 14 October 2026, Sequential also records how each visitor came back from the page that the click opened:
  - **with Back**: the visitor's own Back button or swipe, also a Back that reloads the page;
  - **sent by the app**: a redirect, or a navigation that the page made;
  - **not known**: Sequential cannot tell. This is so with a Sequential SDK from before 9 October 2026, with another tool's SDK, and in a browser without the Navigation API, such as Firefox.

  The sessions sent back by the app and the sessions not known open a dead end at 3 sessions of 2 people, as above. The sessions with Back count only toward a higher bar: at least 6 sessions, of at least 4 people, and at least 20 % of the sessions that visited the page. A dead end that opens by that bar is a pattern of people going back, not a fault. Its title reads "People often go straight back from <page> after "<text>" on <page>".

  On the case, **What happens** has a **How they came back** row. It counts the sessions by how people came back, for example "with Back ×2, in a way not recorded ×1". The other kind reads "by a link in the app". A kind with no sessions is left out. A dead end found before 14 October 2026 has no counts, so it has no row.

Some problems never open a case, under either rule:

- an error from a browser extension: its stack, frame or message names a `chrome-extension://`, `moz-extension://` or Safari extension address
- an error or a request on an ad, analytics or tag host, such as Google Analytics, Google Tag Manager, Hotjar or Segment. Payment and sign-in services are not on that list, and neither is the API of your own app: their failed requests count as usual.
- a request that the page cancelled, or that the browser cancelled because the user left the page
- a prefetch request

- The same problem is the same case as it grows. It keeps its id.
- The count of people is the "N people" in the counts of the row, for example "5 people, 12 sessions". With the Sequential SDK, PostHog or Mixpanel, one person counts once, even if they signed in between. Amplitude, Pendo and Smartlook send no link, so there each id counts as one person.
- A case that Sequential already shows never disappears because its count fell below 2. It stays, and the row shows its true count.
- The counts are exact. Sequential counts sessions. It does not estimate.
- Sequential looks for new cases every 15 minutes, by default.
- Judgments never create a case. When sessions with the problem are judged, the case adds a hedged line under its title, for example "About 4 of 9 judged sessions gave up after it (±2)."
- Sequential switches case detection on per project. The app has no setting for it. On a project where detection is off, it is paused. The **Cases** page still lists the stored cases, under the line "Detection is paused for this project: no new case opens, and the cases below are not updated." With no stored case, the line reads "Detection is paused for this project, so no case opens." From 15 October 2026, an agent's `list_findings` then answers `enabled: false` and still lists the stored cases: no new case opens, and the stored cases are not updated. `get_overview` counts them too.

## When the Cases page is empty

When a tab has no case, the page says "No case here." While detection is on, it adds "A case opens when the same problem reaches several sessions; an error opens one at once."

When the filter matches no case, the page says "No case matches."

On the **Open** tab, an empty list also shows **Ask your agent to look for problems**. While detection is paused, every empty tab shows it. It is not there while **Filter cases** has text. It is also not there when no event and no recording has reached the project yet. When Sequential cannot read this, the button shows.

The button opens the menu of [Ask your agent](/docs/sessions-and-replay#ask-your-agent). Its prompt is fixed text, with no data of your project: "Use Sequential's tools for this project to look through the sessions of the last 7 days for problems that are not findings yet: errors or failed requests in only a few sessions, rage clicks, dead clicks and pages where people give up. For each one, say what happened, on which page, how many sessions, and give one session id I can open."

On a project where detection is paused, the line under the title says so. See above.

## The Cases page

1. In the left rail, click **Cases**, or press G, then C.
2. Choose a tab: **All**, **Open**, **Fixed** or **Dismissed**. Each tab shows its count. The page opens on **Open**. **Fixed** lists the open cases whose fix Sequential measured and confirmed: the stage **Fixed**. **Open** leaves them out. If the problem comes back, the case goes back to **Open**.
3. Read a row: the id and the title, then the kind, the page, the counts and when Sequential last saw it. On the right are bars for the last 14 days, the stage dots and the stage pill. The counts read like "5 people, 12 sessions". A case from your server reads "your server" in place of the page.
4. Click a row to open the case.

- The line under the title counts the open cases, for example "12 open, 3 of them new. 1 has gone quiet." Under the tabs, the page gives the rule: "A case opens at 3 sessions from 2 people in 7 days; an error or failed request opens one at once."
- Cases that happen now come first. Quiet cases come after them. Fixed and dismissed cases come last.
- To filter, type at least 2 characters in **Filter cases**. The filter reads the title, the page and the id.
- **List** and **Board** change the view. **Board** puts each case in a column by its step: **New**, **Handed off**, **Fix linked**, **Shipped** and **Measured**. On every tab but **Open**, the dismissed cases are below the columns.
- Press J and K to select a case, and Enter to open it. Press V to change the view.
- The page reads at most 100 cases.
- An open case with no session and no person in the last 7 days is quiet. Its counts read "quiet now". While no fix is linked, the row adds "Not seen since" the day, then "Check that it still happens."
- A case of errors from your server in no browser session, but with people, is not quiet. Its counts name only the people, for example "3 people (server only)".
- From 25 October 2026, Sequential counts a dismissed case again at each check, as it counts an open one. The case stays dismissed. When it had no occurrence in the last 7 days, its counts read "no occurrence this week".

On a case, **Evidence** lists up to 5 sample sessions, for example "5 examples from the last 7 days". A sample shows the person, how long ago the session was, the judge's reading and the moment, for example "Error at 1:24". Your own sessions read "You". Click a sample to open the session beside the case, at that moment. In place of the moment, a sample can show **No recording**, **Recording not ready yet**, **Recording expired** or **No playable recording**.

When the last 7 days hold more sessions than the samples, a button such as "Show all 12 sessions of the last 7 days" lists them. It lists at most the newest 100.

With no sample, **Evidence** says why. For a quiet case, it says "No sample session: they come from the last 7 days, and it last happened on" the day. For a case from your server, it says "None from a server error." For any other case, it says "No sample session from the last 7 days."

## A case's page

A case's page has two columns when the page is wider than 900 px: the main column, and a side panel on the right. The side panel stays in view while you scroll. On a narrower page there is one column: first the decision card, then the main column, then **Changes**, **Fix** and the history.

At the top, the page shows:

- The id, the kind and the page, for example "F-12 · Failed request · /checkout". A case from your server reads "your server" in place of the page. A likely-noise case adds **Likely noise**.
- The title. From 20 October 2026 it is the short title when Sequential has one: the sentence of the kind without its long part. Else it is the full title. When the short title is only a type, such as "HTTP 501", the page uses the full title. In the short title:
  - An exception keeps its type and its message, without its page, for example "TypeError: price.toFixed is not a function" (from 25 October 2026). An exception with no message keeps its type and its page.
  - A failed request is without its host.
- A line that says how often it happened. For a case from the browser, it also gives the impact, for example "About 4 of 9 judged sessions gave up after it (±2)." Once a fix release is measured, the line starts with the result.
- The stage rail. See [The stages](#the-stages).

The main column, from the top:

1. A likely-noise note, for example "The browser dropped a page-data request before an answer came back."
2. **What happens**: the facts of the problem. An error has **Error** and **Where in the code**. A failed request has **Request** and **Answer**. A request that never completed reads "No answer (the request did not finish)", because it has no HTTP status. A dead end has **Element**, **Selector**, **Sends people to**, **Sessions on the page** and **How they came back**. A click has **Element** and **Selector**.
3. **How often**: bars for each UTC day of the last 30 days. A day that Sequential holds no data for reads "no data", never 0. A day with a partial count has a partial bar. Under the bars: why the case opened, and for a quiet case, "Not seen since" the day.
4. **Steps before it happened**: the steps from the fix brief. Times count from the session's first event. **Replay at** and a time opens the session at the moment.
5. **Since when** and **Done when**: from the fix brief. **Since when** also lists the changes that Sequential recorded in the 3 days before the case was first seen, at most 3, the nearest first. Each change shows its kind and when it started, for example "3 h before", or "running" if it had not ended. The line ends with "Nearness is not cause." If no change was recorded, there is no line. If Sequential cannot read the changes, it says "The changes before it could not be read just now."
6. **Evidence**: the sample sessions. See above.
7. **Who it reaches**: the top 5 **Browsers**, **Systems** and **Releases** of the sessions. A case from your server says "None from a server error."
8. **Did the fix work?** See [Read the result](#read-the-result).
9. **What the agent receives**: the fix brief, open by default. Under it, **GitHub repository** and **Open a GitHub issue**.

The side panel, from the top:

1. The decision card: the stage pill, what the case needs now, and the buttons for your role. See [Hand off a case](#hand-off-a-case). Owners, admins and members also get **Confirm problem** and **Dismiss…**. **Dismiss…** opens **Not a problem** and **Won’t fix**, with a box for an optional reason: "Why is it not a problem? (optional, kept with the case)". A chip such as **Our own test traffic** fills the box. A dismissed case says who dismissed it and when, and has **Reopen**. A viewer sees **Dismiss…** turned off, with "A viewer reads cases. An owner, admin or member can dismiss them." A case at **Fixed** says "Fixed. No new occurrence since" the release, "with enough traffic to tell." It has no **Confirm problem** and no **Dismiss…**. These buttons come back when the case becomes **Regressed**.
2. On a likely-noise case, **Dismiss all N like this…** dismisses the open cases of the same kind of noise. Each case is dismissed on its own, with the same reason. If you open another project while it runs, it stops before the next case, for example "2 of 5 cases dismissed. Stopped: You opened another project." The cases that it dismissed stay dismissed. It does not try the other cases. To undo one, click **Reopen** on the case.
3. **Fix**, in its own card.
4. **Changes**. See [Changes card](#changes-card).
5. **What happened to this case**: the history. See [The stages](#the-stages).

## The stages

Under the title, a rail shows how far the case got, in five steps: **New**, **Handed off**, **Fix linked**, **Shipped** and **Measured**. Every step before the current one is filled. The current step has the colour of its stage. On the last step, the rail shows the result, for example **Improved**. A dismissed case has no current step.

| Stage | What it means |
|---|---|
| **New** | Nothing has happened to the case yet. |
| **Handed off** | Someone copied the fix brief or opened a GitHub issue from it. Or a token read the case or its brief: GET `/api/findings/:n` counts too. The history shows when. See [What counts as a handoff](#what-counts-as-a-handoff). |
| **Waiting on you** | An agent asked to take the case. An owner or admin approves or declines it. |
| **Fix linked** | A pull request, commit or issue link is on the case. |
| **Shipped** | A release marker names the case. The first measurement has not run yet. |
| **Measuring** | Sequential is counting the sessions after the release, or the days for a case from your server. There are not enough yet to tell. |
| **Fixed**, **Improved**, **No change**, **Worse**, **Regressed**, **Not measured** | The result. See [Read the result](#read-the-result). |
| **Dismissed** | Someone set **Not a problem** or **Won’t fix**. This can happen at any stage except **Fixed**. **Reopen** makes the case open again. |

- When more than one stage applies, the case shows the first of these: **Dismissed**, the measurement, **Fix linked**, **Handed off**, **New**.
- The rail fills every step before the current one. A release alone can move a case to **Measuring**. Then **Handed off** and **Fix linked** are filled, also with no hand-off and no link. The history shows what really happened.
- **New**, **Worse** and **Regressed** are red. A **New** case that has gone quiet is not red.
- The list never shows **Shipped**. Until Sequential measures a new release, the list shows the last result that it stored for the case. This result can be for an older release. With no stored result, the list shows **Fix linked**, **Handed off** or **New**. Open the case to see the stage for the newest release.

**What happened to this case** lists who did what: the detector opened the case, the brief left Sequential, an agent asked to take the case, someone linked a fix, a release named the case, Sequential confirmed the fix or saw it again, and the last verdict with its reason. Each line says how long ago. Hover over the time to see the date.

## Hand off a case

1. Open the case. The decision card is at the top of the side panel.
2. At the stage **New**, click **Copy brief**. When the project has no agent webhook, owners and admins see **Copy brief for an agent** in its place. See [Hand to an agent](#hand-to-an-agent).
3. To read the brief first, go to **What the agent receives** in the main column.
4. To open a GitHub issue instead, go to **What the agent receives**. Type the repository as `owner/name` under **GitHub repository**. Then click **Open a GitHub issue**.

- The issue opens in a new tab. Its title is "Fix Sequential finding F-12", and its body is the brief.
- If the brief is too long for the link, Sequential copies it and says "The brief was copied: paste it as the issue body." If that copy fails, it says "The brief was too long for the link. Copy it from the brief and paste it as the issue body."
- The repository is "Remembered in this browser only", for each project. While **Open a GitHub issue** is off, the hint under the field says why, for example "Type the repository as owner/name to open an issue."
- If the copy fails, a message says "The clipboard is not available here."
- From 11 October 2026, the brief in the app is the copy that an agent gets. Element text is withheld, and the names, emails and phone numbers of known people are removed. See [Privacy at a glance](/docs/privacy-overview#names-emails-and-phone-numbers).
- If Sequential cannot check the brief for known people, the page says "The brief is held back until its people check passes. It cannot be copied yet." Until then, **Copy brief**, **Copy brief for an agent** and **Open a GitHub issue** do not work. The case and its evidence still show.
- From 15 October 2026, when an open case had no occurrence in the last 7 days, the brief says "Not seen since" the last time, "(more than 7 days). Check that it still happens before you change code." Its definition of done then says that zero occurrences after a change do not show a fix. For an agent, `list_findings` and `get_finding` give `quiet_since`: the last occurrence of such a case. For any other case, `quiet_since` is `null`.
- From 25 October 2026, `list_findings` and `get_finding` also give `noise`. It is a label, not a verdict:
  - `page_data`: a request for the data of a SvelteKit page (a path that ends in `/__data.json`) that the browser dropped before any answer. This is most often a page change or a cancelled preload.
  - `resize_observer`: the ResizeObserver loop notice of the browser. It is usually harmless.
  - `null`: any other case.

  A case with a `noise` label still opens. It stays open until a member dismisses it. The app shows the label as **Likely noise**, with a sentence that says why.
- From 9 October 2026, the brief has a **Steps before it happened** section. It shows the last steps before the case in up to 2 sample sessions, sessions with a recording first, and up to 6 steps for each: the pages that the user opened, as route templates, the clicks and the form submits, the names of custom events and the errors. In the copy that a token, an agent, a webhook or a hand-off gets, a click or a form step reads "(element text withheld)", and a click case says "Element text: withheld" and masks the selector. From 11 October 2026, the brief that you copy in the app is the same copy. The text of each step is in its own quoted block, up to 60 characters, redacted and screened like every quote. The section quotes at most 1,200 bytes in all. It never shows the properties of custom events. When a session has a recording, the section links to the replay at that moment. The link contains the session id, only when the id has 8 to 64 letters, digits and hyphens.
- The brief tells an agent to call `link_fix` only when the agent's token can call it.
- The first lines of the brief give its screening state. If they say "screen paused, N quoted passages withheld", each quoted passage reads `[instruction-like text removed]`. Sequential could not check its allowance. Open the case again later and copy the brief again.

Everyone on the project can copy the brief, viewers too.

## Link the fix

1. Open the case, and go to **Fix**. It is a card of its own in the side panel. On a narrow page, it comes after the main column.
2. Under **Fix**, paste the address of the pull request, commit or issue.
3. Keep the list next to it at **Auto**, or choose **Pull request**, **Commit** or **Issue**.
4. Click **Link**. The link shows with a **PR**, **Commit** or **Issue** pill.

**Link** stays off until the address starts with `https://`. With **Auto**, Sequential tells the kind from the path of the address. If it cannot tell, choose the kind and click **Link** again. See [Links in detail](#links-in-detail).

To remove a link, click **×** next to it. It acts at once. It does not ask you to confirm.

| Who | Add a link | Remove a link |
|---|---|---|
| Owner, admin, member | ✓ | ✓ |
| Viewer | — (sees the links only) | — |
| A token with `findings:link` | ✓ | — |

The form shows only on an open case. A link alone does not start a measurement. Only a release marker does.

## Mark a release

A **release marker** tells Sequential that you shipped a version, and which cases it is for.

Record the marker with POST `/api/releases`. Name the cases in `finding_ids`, for example `["F-12"]`. The token needs the `releases:write` scope. An agent can use the `record_release` tool.

- Sequential measures only markers for the project's own environment. When a marker names no environment, it gets the project's environment.
- Sequential does not measure a marker for another environment.
- If you record a version again for the same environment, the new marker replaces the old marker: its commit, its time and its cases. Without `released_at`, the new marker gets the time of the call, so the marker moves.

The `sequential release` command and a GitHub Action will read the cases from trailer lines in your commit messages. They are not published yet. See [The sequential release command](#the-sequential-release-command). A trailer looks like this:

One commit can name several cases: Sequential-Finding: F-12, F-14 F-19

```text
fix: debounce the retry loop

Sequential-Finding: F-12
```

## Read the result

**Did the fix work?** on the case shows the measurement for the newest release that names the case.

Before the first measurement, it says one of these:

- "No release names F-12 yet. Sequential measures a fix once a release names it."
- "A fix is linked. Name this case in the release that ships it (record_release with F-12), and Sequential measures it."
- "Release v1.4.0 claims to fix it. Measuring starts with the next sessions."
- "Sequential could not check the releases just now." Sequential could not read the release markers. So it does not say that no release named the case.

If Sequential cannot read the markers but has a stored result, it shows that result.

After it, the part shows the stage pill and one sentence, for example "Before fe@2: 12 of 300 (4%) sessions hit it. After: 0 of 150 (0%)." When both windows were counted, two bars show the **Before** and **After** rates on one scale, each with its percent. Under them, the part says how many sessions it needs after the release. Then it says "Counts, not causes: this says what changed, not why. Computed" and how long ago. A link goes to the release: "Release fe@2: the cases it named and what else changed around it".

| Result | What it needs |
|---|---|
| **Measuring** | Not enough sessions after the release yet. The part gives the count so far and the count needed, for example "80 of 120 sessions needed after the release to call it." |
| **Fixed** | No session after the release had it, and enough sessions came: at least 3, and at least 6 divided by the rate before. For example, with 12 of 300 before (4 %), 150 sessions. |
| **Improved** | Enough sessions came. The rate after is lower than before, and the 95 % interval of the change is wholly below "no change". |
| **No change** | Enough sessions came. The 95 % interval of the change includes "no change". |
| **Worse** | Enough sessions came. The rate after is higher, and the 95 % interval is wholly above "no change". |
| **Regressed** | After **Fixed**, a session had it again within 30 days. |
| **Not measured** | Sequential could not compare the two windows. The sentence says why. |

The sentences say what the rate did, for example "Before fe@2: 12 of 300 (4%) sessions hit it. After: 0 of 150 (0%)." They never say that the release fixed or caused anything.

### A case from your server

From 25 October 2026, Sequential also measures a fix for a case whose occurrences all came from your server. Such a case has no sessions to count, so Sequential counts occurrences and days. A day is 24 hours from the start of the window.

- **Before:** from the first occurrence of the case, at most 14 days before the release, up to the release.
- **After:** from 2 hours after the release, for at most 28 days. The 2 hours leave out old servers that still run during a deploy.
- **Fixed:** no occurrence for at least N days, and your server sent events to Sequential on at least N of those days. N is 7, or 6 × the days on which your server sent events before the release ÷ the days on which the error happened before the release, if that is more. The days on which your server sent events before the release count as at least 7. If this is not met by day 28, for example because N is more than 28, the result is **Not measured**. So a server that sends nothing never reads as fixed.
- **Improved** or **Worse:** from day 7, when the 95 % interval of the occurrences per day after the release ÷ before is wholly below or above 1.
- **No change:** only at day 28, when the interval still includes 1. Until then, the result stays **Measuring**.
- **Not measured:** for example, the error did not happen before the release, so there is nothing to compare.
- **Regressed:** an occurrence within 30 days after **Fixed**.
- The days on which your server sent events count all the server events of the project, also from other processes.

The fix brief of such a case states the same rule in **Definition of done**. In **Did the fix work?**, the bars show the occurrences a day before and after the release, for example "2.9 a day", with "40 in 14 days" under them. While nothing came back, a meter counts the quiet server days toward N, for example "Quiet server days: 3 of 7." The sentence counts occurrences and days, not sessions. Agents get the numbers from `get_verification`, in `server`: `days`, `occurrences`, `people`, `error_days` and `server_days` for before and after, and `needed_days`, `min_days`, `max_days` and `rate_ratio`.

## Troubleshooting

| You see | What it means | What to do |
|---|---|---|
| "No release names F-12 yet." | No marker for the project's environment names the case. A marker for another environment does not count. | Name the case in `finding_ids` of the marker. A trailer alone does not name it. Check the `environment` that your CI job sends. |
| **Not measured** | Sequential could not compare. It never shows this as 0. | Read the sentence. See [Why a result is Not measured](#why-a-result-is-not-measured). |
| A note under the bars, such as "Release fe@3 also shipped on 12 Oct." | Something else changed at the same time. The result stays, but read it with care. | See [Notes under the rates](#notes-under-the-rates). |
| **Measuring** for a long time | Not enough sessions reached the page. | Wait. After 28 days, the result becomes **Not measured**. |
| An agent gets `{"withheld": "needs findings:verify"}` | Its token does not have `findings:verify`. | Make a token with **checks fixes** (`findings:verify`) under **Settings** › **Agents & tokens**. |
| "The last measurement failed; it retries on its own." | The last run failed. It keeps the last good result. | Wait for the next run. |
| "Sequential could not check the releases just now." | Sequential could not read the release markers. It does not mean that no release named the case. | Reload the page. |
| **Link** says "kind: required (could not be inferred from the url)" | With **Auto**, Sequential could not tell the kind from the path of the address. | In the list next to the address, choose **Pull request**, **Commit** or **Issue**. Then click **Link** again. With the API or the `link_fix` tool, send `kind`. |

> **A result is not a cause**
>
> The card compares two groups of sessions. Other changes can move the rate too, for example another release or a change in traffic. The card lists the ones that Sequential can see. It cannot see all of them.

### The before and after windows

Each window counts the sessions that had an event on the case's page. A session is **affected** if the case occurred in it during the window. For a failed request, the page is the page where the failure happens most.

| Window | Which sessions | When |
|---|---|---|
| Before | All sessions on the page | From 14 days before the release to the release. If the case was first seen later, the window starts then. |
| After, release basis | Sessions that carry the fix release and no other release | From 1 day before the release to 28 days after it |
| After, time basis | Sessions that started 2 hours or more after the release | From 2 hours after the release to 28 days after it |

- Sequential counts the before window once, at the first measurement. After that, the count does not change, unless Sequential changes how it finds that kind of problem. Then it counts the before window again with the new rules, so that the two windows use the same rules. If the before window then starts earlier than the project keeps the data, the result is **Not measured**.
- A session that carries two releases, for example a tab left open across a deploy, counts on neither release.
- The release basis starts 1 day before the marker. A session can carry the new release before the marker arrives.
- No window reads the last 2 minutes. Events take up to about a minute to become visible.

### Release basis and time basis

- Sequential uses the **release basis** when any event carried the release name, from 1 day before the release. The name must match the marker's version exactly.
- With the Sequential SDK, add `data-release` to the tag, for example `data-release="2.14.1"`, or call `sequential.register({ $release: '2.14.1' })` on each page load, so that every event carries the release name. See [Sequential SDK](/docs/sequential).
- Otherwise it uses the **time basis**.
- Once a measurement is on the release basis, it stays on it.
- Until the result is final, a measurement on the time basis moves to the release basis once your events carry the release name.

### How many sessions are needed

The **needed** count is the number of after-window sessions that Sequential needs to tell. While the result is **Measuring**, the part shows it under the bars, for example "80 of 120 sessions needed after the release to call it."

- While no session after the release had it: at least 3 sessions, and at least 6 divided by the rate before (the rule of three). For a rate before of 4 %, this is 150.
- Once a session after the release had it: the number that a two-proportion test needs to show the rate halved, at 95 % and with 80 % power.
- **Improved**, **No change** and **Worse** use a 95 % interval of the rate after divided by the rate before (Katz). **No change** means that the interval includes 1.

### Why a result is Not measured

| The card says | Why |
|---|---|
| "It did not happen before fe@2, so there is nothing to compare." | No session in the before window had it, or no session reached the page. The before window is the 14 days before the release. If the case was first seen later, the window starts then. |
| "The sessions before fe@2 are older than Sequential keeps, so there is nothing to compare." | Some of the data that the before window needs is no longer kept. |
| "The sessions after fe@2 are past what Sequential keeps, and there was no verdict before they went." | Some of the data that the after window needs is no longer kept. |
| "Four weeks after fe@2, too few sessions came to tell whether it worked." | 28 days passed and the after window still had too few sessions. |

- **Not measured** is final for that release. A newer marker that names the case starts a new measurement.
- When Sequential did not read a window, it never shows the window as 0.
- Sequential measures a window only while the data that it reads is still stored. It checks the data that is really stored, not the current retention setting. For exceptions and failed requests, it reads the events and the replay data, so the shorter of the two periods decides. For the other kinds, it reads only the events.
- In a project made before 29 September 2026, Sequential does not measure a window that starts before 30 September 2026. It has no record of which data those days hold. If the server sets a [retention limit](/docs/retention-and-deletion#a-server-wide-limit), a daily run deletes a case, with its verdicts, links, verification results and hand-off records, once it was last seen more than the organisation's events retention period plus 8 days ago. That period is the period in force now, under the limit. See [Retention and deletion](/docs/retention-and-deletion).

### Notes under the rates

| Note | When it shows |
|---|---|
| "Release fe@3 also shipped on 12 Oct." | Another marker for the same environment came after the fix release, inside the after window. The card lists up to 50. |
| "The mix of traffic moved (20% → 45%)." | The share of all sessions that reached the page changed by more than half, up or down. |
| "Traffic is low: about 30 sessions a week, 120 needed to tell." | In the before window, fewer sessions a week reached the page than the needed count. |

A note never changes the result. Sequential does not say what moved the rate.

### When results become final

- **Improved**, **No change** and **Worse** are decided once, at the first run with enough sessions. They are then final for that release.
- **Fixed** starts a **regression watch** of 30 days. Every run, Sequential looks at the sessions on the page since the confirmation.
  - On the release basis, every session counts, except a session that carries an older release. An older release is one with a marker, for the same environment, from before the fix release. Examples are a stale tab or an app that was not updated. A release with no marker counts.
  - On the time basis, every session counts.
  - If one of these sessions had it, the result becomes **Regressed**. The history says "came back", with the release when Sequential has one.
  - After 30 days with none, **Fixed** is final.
- **Regressed** and **Not measured** are final for that release.
- A newer marker that names the same case starts a new measurement. The card always shows the newest one.

### When Sequential measures

- The job runs about once an hour.
- It measures only open cases. A dismissed case is not measured.
- It measures only projects where case detection is switched on.
- It measures only the newest marker, for the project's environment, that names the case.
- One run measures at most 200 cases over all projects. Cases not measured yet go first, then the cases measured longest ago.
- A marker less than 2 minutes old waits for the next run.
- If a run fails, the card keeps the last result and says "The last measurement failed; it retries on its own."

### Archived projects

- While a project is archived, Sequential does not look for cases in it and does not measure its cases.
- Its tokens stop working.
- The app opens only live projects, so you cannot open the cases of an archived project.
- Sequential keeps the stored results. A final result does not change. After the project is restored, measuring starts again for the other cases. If a window has aged out of retention in the meantime, the result is **Not measured**.
- The 30-day regression watch of a **Fixed** result keeps counting while the project is archived. Sequential does not look at the sessions of that time.

### Links in detail

- The address must start with `https://`. It can have at most 500 characters and no control characters.
- With **Auto**, Sequential tells the kind from the path of the address. It ignores the query (after `?`) and the fragment (after `#`).
- A pull request is `/pull/<n>`, `/merge_requests/<n>` or `/pull-requests/<n>`. More parts can follow, for example `/pull/42/files`.
- A commit is `/commit/<sha>` or `/commits/<sha>`, with 7 to 40 lowercase hex characters. More parts can follow.
- An issue is a path that ends with `/issues/<n>` or `/-/issues/<n>`. Only a `/` can follow.
- For any other address, choose the kind in the list next to the address. Through the API, send `kind` (`pr`, `commit` or `issue`) to POST `/api/findings/:n/links` or the `link_fix` tool.
- Sequential always uses a kind that you choose. It does not compare it with the address.
- Adding the same address again changes nothing. The first link stays, with its first author.
- Sequential stores and shows a link. The server never opens the address. In the app, you can click the link to open it in a new tab.

### What counts as a handoff

- **Copy brief**, **Copy brief again** and **Open a GitHub issue** in the app.
- **Copy brief for an agent**, **Hand to an agent**, **Send to webhook** and **Approve hand-off**, once Sequential has recorded the hand-off. A webhook send that fails does not count. The audit log records it as `finding.dispatched`, not `finding.handed_off`.
- A token that reads the case or its brief. GET `/api/findings/:n` carries the fix brief, so it counts as a handoff. So do GET `/api/findings/:n/brief`, the `get_fix_brief` tool and POST `/api/agent/get_fix_brief`.

These do not count: opening the case in the app, the cases list, and the `get_finding` tool. A token request that Sequential refuses, because it could not screen the brief, does not count either.

The `get_fix_brief` tool tells MCP clients that it changes data. Its `readOnlyHint` is false, its `destructiveHint` is false and its `idempotentHint` is true. Its description says that the call writes. If the case has no hand-off time yet, the call sets it to now and records `finding.handed_off` in the audit log. Only a case at the stage `new` then shows `handed_off`. Each call also records a delivery of the brief. If a write fails, the agent still gets the brief. A client can then ask you before it calls the tool. A token with `findings:read` can still call it.

Sequential keeps the time of the first handoff. The audit log records only that first handoff, as `finding.handed_off`. See [Audit log](/docs/audit-log).

### Hand to an agent

Owners and admins hand a case to their own coding agent from the decision card. The agent opens the pull request, and you review it.

- When the project has no agent webhook, the button is **Copy brief for an agent**. It records the hand-off and puts the brief on the clipboard: "Brief copied. Paste it into your coding agent." If the browser refuses the copy, the card shows the prompt and the brief to copy.
- When the webhook is ready, the button is **Hand to an agent**. It records the hand-off, then shows a prompt to copy: "Fix Sequential finding F-12. Read its brief with the Sequential MCP tool get_fix_brief (number 12), follow it, and put "Sequential-Finding: F-12" in the pull request so Sequential can measure the fix after release." **Copy prompt** and **Copy the brief** copy them.
- Your agent needs Sequential connected, with a token that has `findings:read`. See [Agent tools](/docs/agent-tools).
- **Send to webhook** appears only when the project has a webhook that is turned on, and the server can sign webhooks. From 26 October 2026, Sequential's hosted service signs webhooks.
- Sequential records the hand-off before it shows the prompt. If it cannot check all the quoted text in the brief, it sends nothing and says so. Try again in a minute.
- The server refuses another hand-off of the same case for 7 days after the last one that succeeded. Until then, the card says "You can hand it to an agent again on" a date. A refused hand-off says "This case went to an agent recently, or a request is waiting. It can go again after 7 days."
- After that date, the card offers the hand-off again. On a case with a result such as **No change**, the button is **Hand back to an agent**.
- A dismissed case, or one with a fix link, cannot be handed over. With a link, the card says "A fix is linked. Unlink it to hand the case back to an agent."
- An agent can also ask for a draft, with the tool `request_fix_draft` and a token that has `findings:draft`. The card then shows "An agent asked to take this case" with the time, and the pill **Waiting on you**. Owners and admins see "Approve to send it the brief." and choose **Approve hand-off** or **Decline**. **Approve hand-off** gives you the prompt and the brief to paste. The agent never receives the brief from this request. To record the request, Sequential prepares the brief and checks its quoted text. If Sequential cannot prepare the brief now, it refuses the request with `screen_incomplete`: "The finding's brief could not be rendered right now. Try again later."
- `request_fix_draft` writes, so it is not on `/mcp/readonly`. claude.ai never gets `findings:draft`: it cannot be granted through OAuth.
- Members and viewers do not see **Copy brief for an agent**, **Hand to an agent** or **Approve hand-off**. Others see "An owner or admin can approve it."
- On the case page, E hands off or approves, X declines or dismisses, and B shows or hides the brief.

### Set up the agent webhook

Owners and admins set up the webhook under **Settings** › **Project** › **Where hand-offs go**. **Send to webhook** on a case posts the fix brief there. Point it at whatever starts your coding agent.

- Only owners and admins see the section. It shows the address with its query values hidden.
- Type a **Webhook address** that starts with `https://`. Then click **Save address**. A new webhook is on. **Turn off** and **Turn on** change that.
- The line under the field reads "An https:// address on the standard port, with no user name, password, #part or IP address." For an address that Sequential refuses, it says why, for example "Use an https:// address on the standard port (443), with no user name, password or #part."
- **Send a test** posts a test body with no case in it, and tells you whether your webhook answered.
- **New signing secret…** makes a new secret after you click **Make a new secret**, and shows it once. The old secret stops working at once. Sequential cannot show a secret again.
- Each delivery is a POST with a JSON body of five fields: `finding`, `revision`, `template_version`, `finding_url` and `brief_markdown`, the screened fix brief. It holds no user ids, emails or recordings. Its **Steps before it happened** section can hold a replay link with a session id.
- Each delivery is signed. The header `X-Sequential-Signature` is `t=<unix seconds>,v1=<hex>`, where `v1` is the HMAC-SHA256 of `<t>.<raw body>` with your secret. With a new secret, the section says how your receiver checks it.
- Sequential sends once per click and waits up to 5 seconds. It does not follow redirects, and it refuses an address in a private network. A test counts too: a project can send up to 20 a day.
- If a send fails, the case says why, for example "Your webhook did not take the brief: it did not answer in time."
- From 26 October 2026, Sequential's hosted service signs webhooks. Each project's secret comes from the server's signing key. A server without a signing key says "This server has no signing key, so it cannot post hand-offs, test the webhook or make a signing secret yet." There, cases offer only the copy.

### The sequential release command

The command and the GitHub Action are not published yet. The command is not on npm, and the Action is not in a public repository. Until they are, record markers with POST `/api/releases`.

`sequential release --version <v> [--environment <e>] [--sha <sha>] [--range <prev..HEAD>]`

- `SEQUENTIAL_TOKEN` is required. It is a project access token with the `releases:write` scope. Always pass it from a secret store.
- `SEQUENTIAL_API_URL` is required. It has no default, because Sequential's hosted API is not deployed yet.
- The address must use `https://`. Only `localhost` and `127.0.0.1` can use `http://`.
- `--version` is required. The other options are optional. Without `--environment`, the marker gets the project's environment.
- `--range` is a git range, for example `v1.2.0..HEAD`. A base of all zeros, as on a first push, reads only the head commit.
- The trailer name can be in any case, but it must start the line. An id is `F-` and a number from 1, with no leading zero. The command reads up to 50 ids for each release.
- On success, it prints "Recorded release v1.3.0 (2 findings: F-12, F-14)" or "Recorded release v1.3.0 (no findings named)".
- On a refusal or a network error, it prints the error and exits with 1. It never follows a redirect, and it never prints the token.

The GitHub Action takes the inputs `version`, `sha`, `range`, `environment`, `token` and `api-url`. `version`, `token` and `api-url` are required. `api-url` has no default.

### Tokens and agents

- `findings:verify` is not on every token. Under **Settings** › **Agents & tokens**, a new token starts with the preset **Read cases**, and it includes `findings:verify`. The token that the app makes for an agent connection includes it too. An existing token does not get the new scope. In the app it reads "checks fixes".
- GET `/api/findings/:n/verification` and the `get_verification` tool need `findings:verify`. Without it, the route answers 403 `insufficient_scope`. A signed-in person does not need a scope.
- The findings list and one finding also carry the stage. For a token without `findings:verify`, the stage is one of `new`, `handed_off`, `fix_linked` or `dismissed`. `measuring` and every result come back as `{"withheld": "needs findings:verify"}`. (`fix_released` is also allowed, but the list and one finding never show it.) The `handed_off_at` time always shows.
- From 26 October 2026, the findings list and one finding also carry `stage_changed_at`: the time when the finding entered its current stage, in UTC. It is null when Sequential has no time for that stage. For a token, it is withheld when the stage is withheld.
- From 19 October 2026, the findings list takes `status=fixed`: the open findings whose fix Sequential measured and confirmed. It needs `findings:verify`. Without it, GET `/api/findings` answers 403 `insufficient_scope`, and the tool `list_findings` answers an error. With `findings:verify`, `status=open` leaves these findings out. Without it, `open` lists every open finding, as before.
- The findings list and one finding also carry `latest_verdict`, the newest verdict on the finding. For a token, its `reason` is screened like visitor text. It comes as `{"observed": …}`, `{"withheld": "removed by screen"}` or `{"withheld": "not screened"}`. A verdict with no reason has `"reason": null`. The name of the person who gave the verdict, `user_name`, always comes as `{"withheld": "person name"}`.
- This applies to GET `/api/findings` and `/api/findings/:n`, to POST `/api/agent/list_findings` and `/api/agent/get_finding`, and to the MCP tools `list_findings` and `get_finding`. The app, with a signed-in person, gets the reason and the name as stored.
- For a token, each title in the findings list is only the kind, for example `Exception`. `scope` and `page_route` are screened like visitor text. They come as `{"observed": …}`, a `withheld` form, or `""` if the finding has no page.
- For a token, each `session_id` in one finding's evidence and in a finding's sessions list comes as `{"id": "…", "source": "observed"}`. In the sessions list, a release name comes as `{"withheld": "not screened"}`. `get_session` gives the screened release.
- A token does not get a fix brief or a finding that Sequential could not fully screen. GET `/api/findings/:n` and `/api/findings/:n/brief` answer 503 `screen_unavailable`. The `get_fix_brief` and `get_finding` tools answer an error. The operator setting `FINDINGS_SCREEN_REQUIRED=false` turns this off. See [Privacy at a glance](/docs/privacy-overview).
- When the screen is paused, a token gets the brief and the finding with every quoted passage withheld. The brief says "screen paused". A finding with more quoted passages than the screen reads is still refused.
- `link_fix` needs `findings:link`. `/mcp/readonly` never lists it. No token can remove a link.
- With a token, GET `/api/findings/:n/verification` runs the `get_verification` tool. So REST, POST `/api/agent/get_verification` and MCP give the same answer. The request counts once toward the project read limit for tokens. If a limit refuses it, the answer keeps the status and the Retry-After of that limit. See [Limits](/docs/limits).
- In the answers of `link_fix` and `get_verification`, link addresses, release names, environments and commit SHAs are screened like visitor text. They come as `{"observed": …}` or a `withheld` form. See [Privacy at a glance](/docs/privacy-overview).
- The app, with a signed-in person, gets these values as stored.
- `released_elsewhere` lists up to 5 markers for other environments that name the finding, newest first. It shows only when no marker for the project's environment names the finding. Sequential does not measure these markers.
- `release_check: "unavailable"` means that Sequential could not read the release markers. Then a missing `released` or `released_elsewhere` means "not checked", not "no release".
- In a verification answer, a `null` count means that Sequential never read that window. It is not a zero. A failed run shows only `measurement_failed`, never the error text.

## Changes card

From 22 October 2026, a case page has a **Changes** card under **Fix**. It shows the changes that are linked to the case, and for each one whether Sequential saw the case again after it. It never says that a change fixed the case: "Seen or not seen is a fact about this case, not proof that a change worked." See [Link a change to a finding](/docs/changes#link-a-change-to-a-case).

## Related

- [Audit log](/docs/audit-log)
- [Roles and permissions](/docs/roles-and-permissions)
- [Limits](/docs/limits)
- [Privacy at a glance](/docs/privacy-overview)
- [Retention and deletion](/docs/retention-and-deletion)
- [Evidence: the sessions worth a look](/docs/watch)
