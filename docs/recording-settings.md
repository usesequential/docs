# Session replay recording settings

> Settings › Recording & data controls what a project records. This page gives each control's purpose, default, and what applies it: server, recorder or nothing.

> **In short**
>
> - Each project has one recording policy. One form under **Settings** › **Recording & data** shows it, for the web and for mobile apps.
> - Only owners and admins can save in the app. Sequential support can also save a new version. **Who changed what** then names "Sequential support" for that version. Each save creates a new version.
> - A change needs no redeploy. Websites apply it on the next page load. Mobile apps apply it on the next launch that reaches the network. The server applies its settings immediately.
> - The server applies **Record sessions**, the **Record on** boxes, **Largest recording** and the captures under **What a recording carries**. The recorder applies **Share of sessions recorded**, **Shortest session kept**, **Longest recording**, the page lists and the masking. A modified recorder can bypass these five.
> - Heatmap data is on by default. The **Heatmaps** box under **What a recording carries** turns it on or off. See [Heatmap data](#heatmap-data).
> - **Recordings at the same time**, **Session budget**, **When the budget is used up** and **Never record these app screens** are saved, but they do nothing today. Each of the four says "Saved; nothing applies it yet."

## What it is for

Session replay records what real people see and do in your product. These settings decide how much of it Sequential keeps. Use them to:

- Stop all recording now, without a code change. For example, do this if a release shows customers' addresses without masking.
- See which buttons users clicked, but never what they typed.
- Record every production session, but only a tenth of staging.
- Keep pages such as checkout out of recordings.

## How it works

Every save of the recording policy creates a new version: v1, v2 and so on.

One form holds the settings for the web and for mobile apps. For example, **Share of sessions recorded** applies to the web and to mobile apps.

### When a change takes effect

Recorders fetch the policy themselves, so a change needs no redeploy.

| Who applies it | When a change takes effect |
|---|---|
| Sequential's web recorder | On the next page load |
| Mobile apps | On the next launch that reaches the network |
| The server | Immediately, for each upload as it arrives |

The web recorder fetches the policy on every page load, before it records anything. A mobile app fetches the policy at launch and keeps a copy. The server also applies some settings to every upload as it arrives.

- A project that nobody has changed shows "Nothing is stored for this project yet: the defaults below apply."
- When Sequential creates a staging or development project, it sets its sampling to 10 %. So the project starts at v1, saved in its creator's name.

Mobile masking comes from your app's SDK, not from this policy.

## Change a setting

Every role can open **Settings** › **Recording & data**. Only owners and admins can save in the app. Sequential support can also save a new version. See [Roles and permissions](/docs/roles-and-permissions).

1. Go to **Settings** › **Recording & data**.
2. Check the line at the top for the version in effect.
3. Make your changes. The settings are in six groups: **Recording**, **Privacy and masking**, **What a recording carries**, **Data and your team**, **Who may send data** and **Judging**.
4. Click **Save changes**. If the change loosens what is recorded, a box opens: "This records more than before."
5. If the box opens, it lists what the change records. Type your project's slug in the field "Type `web-shop`, the project’s slug, to save". Spaces before or after the slug do not matter.
6. Click **Save and record more**. To close the box without a save, click **Not now**.

If a change records more, you cannot undo it for the recordings made under it. So the app asks for the slug. Sequential writes every save to the [Audit log](/docs/audit-log), with the reasons for any loosening.

### The version line and where the settings arrived

The line at the top shows the version and who saved it, for example "Version 5, saved by Ana", and when.

Under it, one line for each platform shows the version that its recorder last fetched. For example: "Web has the current settings (version 5), fetched …" or "No iOS app has fetched these settings yet."

The lines do not update on their own. To check them, reload the page. The lines can also be up to a minute behind the real fetches.

### What the page shows while you edit and save

- Members and viewers see the form greyed out, with a line such as "You are a member: you can read these settings; owners and admins change them."
- An archived project shows "The project is archived, so nothing is recorded whatever these say."
- The bottom bar counts your unsaved changes, for example "3 unsaved changes". Open it to see each change. To undo all unsaved changes before you save, click **Discard**.
- If a saved **Masked text** or **Blocked elements** selector is not valid in your browser, the top of the page says so, for example: "Web recording is off: the saved Blocked elements selector isn't valid in browsers ("div:nope" is not a valid CSS selector). No web session is recorded until it is fixed under Privacy and masking." The line shows only while **Record sessions** and **Web** are on. See [Masking and redaction](/docs/masking-and-redaction).
- After each save, a line confirms the new version: "Saved as version 5. Recorders pick it up on their next fetch, usually within a few minutes."

**If someone else saved first**

If someone else saved while you were editing, Sequential refuses your save. The page says, for example, "Ana saved these settings …, after you opened them. Load their version, then make your change again." If Sequential support saved, the message starts with "Someone".

**Load the newest version** loads their version and drops your edits. Make your edits again.

## The controls

| Control | What it is for | Default |
|---|---|---|
| **Record sessions** | Stop all recording at once | On |
| **Record on**: **Web**, **iOS**, **Android** | Choose where the project records | All on |
| **Share of sessions recorded** | Record a share of sessions, to control volume | 100 % |
| **Shortest session kept** | Leave out very short visits, such as bounces | 2 seconds |
| **Longest recording** | Stop a tab left open all day from recording all day | 60 minutes |
| **Largest recording** | Stop one runaway session from growing without limit | 25 MB |
| **Record only these pages**, **Never record these pages** | Keep pages out, or record only part of your product | Empty |
| **Masking level** | Choose how much of each page you can see in a replay | **Strict** |
| **What a recording carries** | Record the technical context behind a replay | All on, except the console level `debug` and **Console message text** |

**Longest recording**, the page lists and the masking work on the web only. The one exception is **Attribute values**: it also shortens the DevTools addresses that iOS and Android apps send.

Each number field shows the values that it takes, for example "Allowed: 1–1,440 min."

### Where each control applies, and what applies it

Defaults are what a new project starts with. Your project's own values are on the page.

- **Server** means that Sequential applies the setting to every upload as it arrives, whatever the recorder was told.
- **Recorder** means that Sequential's web recorder applies it, or your app's SDK on mobile. The server does not check it again.

| Control | Default | Applies to | Applied by |
|---|---|---|---|
| **Record sessions** | On | Web and mobile | Server |
| **Record on**: **Web**, **iOS**, **Android** | All on | Each platform | Server |
| **Share of sessions recorded** | 100 %. New non-production projects start at 10 % | Web and mobile | Recorder |
| **Shortest session kept** | 2 seconds | Web and mobile | Recorder |
| **Longest recording** | 60 minutes | Web only | Recorder |
| **Largest recording** | 25 MB | Web and mobile | Server |
| **Recordings at the same time**: "Saved; nothing applies it yet." Not in use | 50 | — | Nothing. Saved but not enforced |
| **Session budget** and **When the budget is used up**: "Saved; nothing applies it yet." Not in use | No budget, and "Tell us" | — | Nothing. Saved but not enforced |
| **Record only these pages** and **Never record these pages** | Empty | Web only | Recorder |
| **Never record these app screens**: takes screen names. "These screens are still recorded. Saved; nothing applies it yet." Not in use | Empty | iOS and Android | Nothing yet. Saved but not applied |
| **Masking level** and its fields | **Strict** | Web only. **Attribute values** also applies to the DevTools addresses that apps send | Recorder, in the user's browser. The server masks attribute values, addresses, input values and DevTools addresses again |
| **JavaScript errors**, **Console output**, **Network requests**, **Performance timings** | All on, except `debug` and **Console message text** | Web. Also mobile for **Network requests**, and for **Console output** while **Console message text** is on | Server, and the recorder |
| **Heatmaps**: heatmap data, where sampled visitors click and how far they scroll | On | Web only | Server. The recorder loads the heatmap code only while it is on, and the server stores heatmap data only while it is on |
| Replay retention (no control): how long replays stay available. One of 7, 30, 90, 180 or 365 days. The organisation's period, set by Sequential. A server-wide limit can make it shorter | 30 days | Web and mobile | Server. Sequential stops playing the replay. The storage deletes the recording files about 2 days later |

### Recording and platforms

While **Record sessions** is off:

- The web recorder does nothing.
- Sequential tells mobile apps not to record.
- Sequential refuses every upload immediately.

Pages that are already open keep running the recorder that they loaded. Sequential stores nothing that they send. When you archive a project, Sequential also turns recording off.

Sequential refuses uploads from a platform whose box under **Record on** is off. React Native and Flutter apps have no box of their own. They record while **iOS** or **Android** is on, and they never get a line of their own under the version line.

Under **Record on**, the page says what reaches an app: "iOS and Android apps are sent these switches, the share recorded, the shortest session, and whether to send console logs and network timing; the app's SDK decides what else it captures. What an app sends is then filtered by the console and network settings under What a recording carries and by Attribute values, and refused past Largest recording."

### Sampling and session caps

**Share of sessions recorded**

- Each project has its own rate. For example, a staging project can record 10 % while production records 100 %.
- New staging and development projects start at 10 %.
- On websites, the recorder decides once per session. So it records a session across several pages completely or not at all.
- A new rate applies to new sessions only.

**Shortest session kept**

- Enter seconds, for example 1.5. Sequential stores milliseconds.
- A value of 0 turns it off.
- On websites, the clock restarts at each page load. So a page that the user leaves sooner sends nothing, even in the middle of a session.
- If users move quickly between pages, keep this value low.

**Longest recording**

- On websites, it also counts from each page load. So it limits each page, not the whole session.

**Largest recording**

- The server adds up the size of the recording data that it stores for the session, across its pages. It counts the data before compression. It refuses more data past the limit. On websites, the recorder then stops.
- The limit also applies to mobile apps.
- If Sequential's counter is unavailable, it does not apply the limit.
- The count starts again when a session sends nothing for 2 hours.
- An example of a runaway session is a page with constant animation.

### URL patterns

**Record only these pages** and **Never record these pages** take path patterns, one per line. The help under each list says: "One pattern per line, matched against the whole path. * stays within one path segment: /app/* matches /app/settings, not /app/settings/billing. ** crosses segments: /app/** matches /app/settings/billing."

- Patterns match the page's path only, with no domain or query string. `https://example.com/checkout` never matches.
- `/checkout/**` matches `/checkout/pay`, but not `/checkout` itself. To keep a whole section out, list both `/checkout` and `/checkout/**`.
- `*` matches within one path segment. `**` matches across segments. So `/account/*/billing` matches `/account/42/billing`.
- `*` never matches a `/`. So `/app/*` matches `/app/settings`, but not `/app/settings/billing`. To match every page under `/app/`, use `/app/**`.
- If a page matches both lists, **Never record these pages** wins. If **Record only these pages** has entries, a page must match one of them.
- Each list takes up to 200 patterns, with at most 100 wildcards and 8,192 characters in total.

**When a user moves within your app**

- A user can move to a path in **Never record these pages**, or to a path that a non-empty **Record only these pages** does not include. The recorder notices within about a second. It sends what it has captured, then stops. It stays stopped until the next full page load, even if the user moves back.
- That last second can include the start of the excluded page, masked as usual. If a page must never appear, open it with a full page load. Also mask or block its content.
- If a page loads on a path that the lists exclude, nothing records during that page load. This stays true after the user moves within your app to an allowed path. Recording starts at the next full page load on an allowed path.

### Masking presets

Masking happens in the user's browser, before anything is sent.

| **Masking level** | What it does |
|---|---|
| **Strict** (default) | Masks all text and every input. Blocks images, SVG, video, audio, iframes and embeds. Masks attribute values, except structure, id references and known state values. Cuts link and image addresses to their domain, and the page address and web font files to their route with id-like parts masked. You see the layout and where people clicked, not what they read. |
| **Balanced** | Masks every input. Masks text only inside elements with the `data-sq-mask` or `data-sq-private` attribute or the `sq-mask` class. Records images and SVG. Still blocks video, audio, iframes and embeds. Records attribute values and the full page address as they are. |
| **Custom** | Any other combination. |

Under **Masking level**, the form has **Mask every input**, **Masked text**, **Blocked elements**, **Attribute values (titles, labels, alt text, data-*)**, **Collect fonts** and **Record canvas**. The two selector fields take CSS selectors, separated by commas. If you choose **Strict** or **Balanced**, Sequential overwrites all six. If you edit any of them, the level changes to **Custom**, unless the six then match **Strict** or **Balanced** exactly.

From 10 October 2026, the recorder always gets `[data-sq-private]` in its **Masked text** selector, also when the field is empty and masks no other text. You do not need to add it. The help under the field says "[data-sq-private] is always masked as well." Under **Strict**, the selector is `*`, which masks all text already.

**Canvas snapshots.** From 10 October 2026, when **Record canvas** is on, the recorder records each canvas as a series of snapshots, not as its drawing calls. By default, it takes 2 snapshots a second, as WebP images at quality 0.6. A canvas that does not change adds nothing to the recording after its first snapshot. While **Record canvas** is on, two fields change this: **Canvas snapshots per second**, a whole number from 1 to 10, and **Canvas snapshot quality**, from 10 to 100 %. An owner or admin can also set them through the settings API, with PATCH `/api/projects/:id/config`, as `replay.masking.canvas_fps` and `replay.masking.canvas_quality` (0.1 to 1.0). The API refuses a value outside these ranges, and the recorder uses the default when it gets no valid value. A preset does not change them, and a change to them keeps the preset.

**Attribute values (titles, labels, alt text, data-*)** has three choices: **Masked**, **Kept, URLs cut to the path** and **Recorded as on the page**. **Strict** uses **Masked**, and **Balanced** uses **Recorded as on the page**. **Kept, URLs cut to the path** is a **Custom** choice only. This field also sets how DevTools shortens network addresses and code locations. See [Masking and redaction](/docs/masking-and-redaction).

Both presets mask what users type, the value of a checkbox or radio button that a user picks, the name of a file that a user picks and the value of hidden fields.

Masked text keeps its place and shows as solid blocks (█). A blocked element leaves an empty box of the same size. Add `data-rr-block` to any element that must never be captured. Both presets block it.

Sequential never re-masks a recording later. Each recording keeps the masking that it was made with. See [Masking and redaction](/docs/masking-and-redaction).

### DevTools captures

The captures are under **What a recording carries**.

| Capture | What it records |
|---|---|
| **JavaScript errors** | Uncaught exceptions and unhandled promise rejections, with stack traces. Web only. |
| **Console output** | Calls at the levels you tick. By default `error`, `warn`, `info` and `log`, not `debug`. |
| **Network requests** | Each request's method, URL, status, timing and size. Never its headers or body. |
| **Performance timings** | Core Web Vitals and page-load timing, per page load. Web only. |

The server applies your current DevTools settings to every upload. So when you turn a capture off, Sequential stops storing it immediately. This includes data from an older recorder or a mobile app.

Replays recorded while a capture is off do not show as clean for that kind. They carry no count for it, never a zero. So a filter for sessions with errors or failed requests cannot return them.

On mobile, logs on iOS and network timing on Android also need a setting in the app itself. See [Mobile apps](/docs/mobile) and [DevTools](/docs/devtools).

> **Console text can hold personal data**
>
> **Console message text** is off by default. If you turn it on, Sequential stores whatever your app writes to the console. Anyone who can open the project's replays can read it: every role, viewers included. If you turn it off later, Sequential keeps the text that it already stored.

### Console message text

**Without it**, a web console entry keeps its level, how often it was logged and where. Warnings and errors also keep a stack trace. The entry does not keep the words that were logged.

**With it**, you also get the words, such as "payment failed: card_declined" or an API error body. The words are often why the entry matters.

**Redaction:** Sequential replaces these with `[redacted]`:

- JWTs
- Bearer and Basic credentials
- email addresses
- card numbers
- values under names like `password` or `token`

No rule catches a name, a postal address or a one-time link in a log line.

The help beside the box says: "Messages can hold what people typed or saw. Off by default."

- Keep it off for production until you have checked what your app logs.
- Settings are per project, so a separate staging project can keep it on.
- While **JavaScript errors** is on, Sequential keeps exception messages either way.
- On iOS and Android, Sequential asks the app for logs only while **Console message text** is on. Under the box, the page says: "On iOS and Android, logs are requested from the app only when Console message text is on."

### Network request settings

- **Query values kept** lists the query parameter names whose values you want to keep. Sequential records every other query value as `[redacted]`.
- **Requests ignored** takes patterns, one per line. `*` stays within a path segment and `**` crosses segments.
- The help under **Requests ignored** says: "One pattern per line, matched against the whole URL without its query. * stays within a path segment, ** crosses them. For example https://api.example.com/health*."
- Unlike the page lists, these patterns match the request's full address without its query string. So include the domain, as in `https://api.example.com/health`, or start with `**`, as in `**/health`.

### Changes that ask for the slug

The app asks for the slug when a save would:

- stop masking inputs, stop masking all text, or turn text masking off. A move from **Strict** to **Balanced** counts.
- remove anything from **Blocked elements**, or turn on **Record canvas**.
- remove an entry from **Never record these pages** or **Never record these app screens**.
- turn on **JavaScript errors**, **Console output** or **Network requests**, add a console level, or turn on **Console message text**.
- add a name to **Query values kept**, or remove a pattern from **Requests ignored**.
- lower **Attribute values**: from **Masked** to either other choice, or from **Kept, URLs cut to the path** to **Recorded as on the page**. A move from **Strict** to **Balanced** counts.

Two other changes ask a question of their own before the save. Turning on **Heatmaps** asks "Turn on heatmaps for …?". A new **Allowed sites** list that refuses sites which sent data recently asks "Refuse events from these sites?".

### Changes that widen recording without asking

These changes record more, but the app does not ask for the slug:

- turning **Record sessions** or a platform on.
- raising **Share of sessions recorded**, **Longest recording** or **Largest recording**.
- lowering **Shortest session kept**.
- adding entries to **Record only these pages** when it already has some, or clearing it.
- turning on **Collect fonts** or **Performance timings**.
- replacing one **Masked text** selector with another, unless the old one masked all text.

## Heatmap data

Sequential collects heatmap data for a sample of recorded web sessions: where visitors click and how far they scroll, as page structure and counts, with no text. **Workbench** › **Heatmaps** shows its click counts and scroll depth. See [Heatmaps](/docs/sessions-and-replay#heatmaps). For what it holds, see [Heatmap data](/docs/privacy-overview#heatmap-data).

The **Heatmaps** box is under **What a recording carries**. It says: "Clicks and scroll depth from a sample of recorded sessions. Needs recording on."

- **On by default** for each project that records websites.
- **Agents.** From 15 October 2026, the switch also covers agents. With heatmap data off, `list_heatmap_pages` and `get_heatmap` answer `off`, with the reason.
- **The switch.** Only owners and admins can change it. Members and viewers see it read-only. While heatmap data is off, **Workbench** › **Heatmaps** says "Turn them on in project settings."
- **Turning it on asks first.** When you save, a box asks "Turn on heatmaps for …?" and says what is counted and who sees the page picture. Nothing is saved until you click **Turn on**. Turning it off asks nothing. For the full text, see [Turn heatmap data on or off](/docs/privacy-overview#turn-heatmap-data-on-or-off).
- **The switch saves with the form.** It saves when you click **Save changes**, with your other changes. The **Audit log** records it as `project.config_changed`.
- **Sample.** **Automatic (about 2,000 sessions a day)**, or **A fixed share**: **Heatmap share**, a percentage of recorded sessions, from 0.1 to 100. The choice shows only while heatmaps are on. See [Limits](/docs/limits#heatmap-data).
- **It needs recording and the web.** While **Record sessions** or **Web** under **Record on** is off, Sequential collects no heatmap data.
- **From the next page load.** The web recorder stops loading the heatmap code on the next page load. Sequential's servers stop storing heatmap data from open pages once they read the new setting.
- **The page picture stops too.** While heatmap data is off, a request for a page picture answers `off`. See [The page picture](/docs/privacy-overview#the-page-picture).
- **To check it,** open **The settings that apply, as JSON** under **What applies**, and look for `heatmaps` under `replay`.
- **Through the API.** A script signed in as an owner or admin can set `replay.heatmaps.enabled` with PATCH `/api/projects/:id/config`. It must send the whole settings document, with `If-Match`. See [Turn heatmap data on or off](/docs/privacy-overview#turn-heatmap-data-on-or-off).

## What it needs

- **Websites:** Sequential's recorder, from [Session replay (web)](/docs/session-replay) or started by the [Sequential SDK](/docs/sequential). Web replays come only from this recorder, whichever analytics SDK you use.
- **Mobile apps:** PostHog's iOS or Android SDK, sending to Sequential. See [Mobile apps](/docs/mobile).

## Limits

- **Saved, not enforced:** **Recordings at the same time**, **Session budget**, **When the budget is used up** and **Never record these app screens** do nothing today. Neither do **Properties dropped**, **Properties hashed**, **IP addresses** and **Allowed app ids**.
- **A modified recorder can bypass recorder-only settings.** So can anyone who sends data with your project's public replay key.
- **Mobile masking is not on this page.** Your app's SDK sets it.
- **Not retroactive.** Settings apply to new recordings only.
- **Replays stop playing first, and the files go later.** By default, after 30 days you cannot play a replay. The storage deletes the recording files about 2 days after that. If you delete the project, its recordings become unreadable at once, and the storage deletes the files later.
- **Per project, not per visitor.** For a visitor's consent choice, see [Sequential SDK](/docs/sequential), or add the recorder tag only after the visitor consents ([Session replay (web)](/docs/session-replay)).
- `/checkout/**` does not match `/checkout` itself. To keep a whole section out, list both `/checkout` and `/checkout/**`.
- The page lists match the path only. A pattern with a domain, such as `https://example.com/checkout`, never matches.
- In a single-page app, recording stops after a move to an excluded path. It starts again only at the next full page load on an allowed path.
- A replay can include about one second of an excluded page after an in-app move. If a page must never appear, open it with a full page load.
- On websites, **Shortest session kept** and **Longest recording** count from each page load. A short page sends nothing, even in the middle of a session.
- Some changes record more but do not ask for the slug. Examples are raising **Share of sessions recorded** and clearing **Record only these pages**.
- **Requests ignored** matches the full address. A path-only pattern such as `/health` never matches. Use `https://api.example.com/health` or `**/health`.
- While **JavaScript errors** is on, Sequential keeps exception messages, even with **Console message text** off.

### Limits in detail

**Settings that apply nothing yet**

- **Recordings at the same time**, **Session budget** and **When the budget is used up** are under **Limits not applied yet, and upload timing**. Each says "Saved; nothing applies it yet." Nothing reads them, so they do not limit how many sessions record at once. To control volume, use **Share of sessions recorded** and the session caps.
- **Never record these app screens** takes screen names, as your iOS or Android app reports them. Nothing applies the list to mobile recordings today. Its help says: "Screen names as your iOS or Android app reports them. These screens are still recorded. Saved; nothing applies it yet."
- **Properties dropped**, **Properties hashed** and **IP addresses** are under **Property and IP rules not applied yet**. Each says "Saved; nothing applies it yet."
- **Allowed app ids** is under **Who may send data**. Nothing applies it today: Sequential takes data from any iOS or Android app that sends your key. Its help says: "Bundle or application ids, exactly. Any iOS or Android app with your key can still send. Saved; nothing applies it yet."

**The settings that apply, as JSON**

Under **What applies**, **The settings that apply, as JSON** shows the session budget, `events_retention_days`, the IP setting, the property deny and hash lists, and the allowed origins and bundle ids. `events_retention_days` is the organisation's events retention period, and Sequential applies it: see [Retention and deletion](/docs/retention-and-deletion). Sequential applies the allowed origins to every request that sends data. Owners and admins change them in **Allowed sites** under **Who may send data**. See [Organisations and projects](/docs/organisations-and-projects). The others do not restrict who can send data or which properties Sequential keeps. The one exception is heatmap data: if the allowed origins list hosts, Sequential drops heatmap data from pages on other hosts.

**Recorder-only settings**

The server does not check **Share of sessions recorded**, **Shortest session kept**, **Longest recording**, the page lists or text masking again. It does mask attribute values, addresses, input values and DevTools addresses again, under the current settings of the project.

**Mobile masking**

The masking on this page applies to the web only. For mobile apps, your app's SDK sets the masking.

**Not retroactive**

Tightening masking or turning a capture off does not change what is already stored.

**Retention**

Replays stay available by default for 30 days, counted from when the first part of the recording arrived at Sequential. **How long data is kept**, under **Data and your team**, shows the organisation's two periods: **Events** and **Recordings**. If the server sets a shorter limit, the page shows the limit, with a line that says why. See [A server-wide limit](/docs/retention-and-deletion#a-server-wide-limit). The organisation sets both periods for all its projects. The page has no control for them, and only Sequential support can change them. A shorter period deletes nothing: stored recordings keep their old period. Through the settings API, a change of either period gets 409 `retention_set_by_organisation` and saves nothing. After the period, you cannot play the recording in Sequential. See [Retention and deletion](/docs/retention-and-deletion).

**Version history**

Every role sees each save under **Who changed what**, as a sentence such as "Ana Novak changed 3 settings", with the time. Open a version to see each change. Owners and admins also see the project's audit rows under **Recent changes**. The audit log also shows each save, with what changed.

## Related

- [Find and replay sessions](/docs/sessions-and-replay)
- [DevTools](/docs/devtools)
- [Masking and redaction](/docs/masking-and-redaction)
- [Retention and deletion](/docs/retention-and-deletion)
- [Session replay (web)](/docs/session-replay)
- [Mobile apps](/docs/mobile)
- [Roles and permissions](/docs/roles-and-permissions)
- [Audit log](/docs/audit-log)
