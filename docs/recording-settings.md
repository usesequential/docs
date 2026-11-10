# Session replay recording settings

> Settings › Recording & data controls what a project records, on the web and in mobile apps. A change needs no redeploy.

> **At a glance**
>
> - **Who can:** Every role can open Settings › Recording & data. Only owners and admins can save in the app ([Roles and permissions](/docs/roles-and-permissions)).
> - **Default:** Share of sessions recorded 100 %, Strict masking (layout and clicks, no text), Console message text off, [heatmap data](#heatmap-data) on.
> - **Takes effect:** Websites: on the next page load. Mobile apps: on the next launch that reaches the network. The server: immediately.
> - **Before you start:** Websites: Sequential's recorder ([Session replay (web)](/docs/session-replay)). Mobile apps: PostHog's iOS or Android SDK, sending to Sequential ([Mobile apps](/docs/mobile)).
> - **Know this:** Settings apply to new recordings only. You cannot undo recording more, so some changes ask for the slug.
> - **Know this:** Mobile masking comes from your app's SDK, not from these settings. Some settings are saved but do nothing today.

## Choose a setting for your goal

| Goal | Change this |
|---|---|
| Stop all recording now, without a code change. | Turn off Record sessions, then click Save changes. Sequential refuses every upload immediately. |
| See which buttons people clicked, but never what they typed. | Masking level: Strict (default) and Balanced both mask every input. |
| Record every production session, but only a tenth of staging. | Share of sessions recorded. Each project has its own rate. |
| Leave out very short visits, such as bounces. | Shortest session kept (default 2 seconds). A value of 0 turns it off. |
| Keep pages such as checkout out of recordings. | Never record these pages, on the web only. List both `/checkout` and `/checkout/**` ([URL patterns](#url-patterns)). A replay can include about one second of an excluded page after an in-app move. |
| Keep app screens out of recordings. | The list Never record these app screens is saved, but nothing applies it today. These screens are still recorded. |
| Keep one element out of recordings. | Add `data-rr-block` to the element. Both presets block it. |

## Change a setting

> **Important**
>
> If a change records more, you cannot undo it for the recordings made under it. So the app asks for the slug for the changes in [Changes that ask for the slug](#changes-that-ask-for-the-slug).

1. Go to **Settings › Recording & data**.

2. To see which version is in effect, check the line at the top.

3. Make your changes in the six groups: Recording, Privacy and masking, What a recording carries, Data and your team, Who may send data and Judging.

4. Click **Save changes**.

5. If a box asks for the slug, type your project's slug in its field.

6. Click **Save and record more**. To close the box without a save, click **Not now**.

Result: A line confirms the new version: "Saved as version 5. Recorders pick it up on their next fetch, usually within a few minutes."

Sequential writes every save to the [Audit log](/docs/audit-log), with the reasons for any change that asks for the slug.

### Changes that ask for the slug

What the app asks before a save depends on the change.

For a change that asks for the slug, a box opens: "This records more than before." It lists what the change records. Type your project's slug in the field "Type `web-shop`, the project’s slug, to save". Spaces before or after the slug do not matter.

| Change | What the app asks before the save |
|---|---|
| Stop masking inputs, stop masking all text, or turn text masking off. A move from Strict to Balanced counts. | The slug |
| Remove anything from Blocked elements, or turn on Record canvas. | The slug |
| Remove an entry from Never record these pages or Never record these app screens. | The slug |
| Turn on JavaScript errors, Console output or Network requests, add a console level, or turn on Console message text. | The slug |
| Add a name to Query values kept, or remove a pattern from Requests ignored. | The slug |
| Lower Attribute values: from "Masked" to either other choice, or from "Kept, URLs cut to the path" to "Recorded as on the page". A move from Strict to Balanced counts. | The slug |
| Turn on Heatmaps. | A question of its own: "Turn on heatmaps for …?" |
| A new Allowed sites list that refuses sites which sent data recently. | A question of its own: "Refuse events from these sites?" |
| Turn Record sessions or a platform on. | No slug |
| Raise Share of sessions recorded, Longest recording or Largest recording. | No slug |
| Lower Shortest session kept. | No slug |
| Add entries to Record only these pages when it already has some, or clear it. | No slug |
| Turn on Collect fonts or Performance timings. | No slug |
| Replace one Masked text selector with another, unless the old one masked all text. | No slug |

The changes marked No slug record more, but the app does not ask for the slug.

### What the page shows while you edit and save

Members and viewers see the form greyed out ([Roles and permissions](/docs/roles-and-permissions)).

The line at the top shows the version and who saved it, and when. Under it, one line for each platform shows the version that its recorder last fetched.

The lines do not update on their own. To check them, reload the page. The lines can also be up to a minute behind the real fetches.

From 8 November 2026, some settings show their help in parts: one line, rows of a term and its detail, and a risk line that always shows. Each setting has only the parts it needs. These settings are Console message text, List people in funnels (a grid and a risk line), Judge new sessions automatically and Show who is on the site now. The question "Turn on heatmaps for …?" and the box that deletes a project show rows too. The old help text is word for word under Read the full text ▾. Members and viewers see the full text open, because their form is greyed out.

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Version 5, saved by Ana" | The line at the top | An example: the version in effect, who saved it, and when. | — |
| "Web has the current settings (version 5), fetched …" | One line for each platform, under the version line | An example: the recorder of this platform last fetched version 5. | — |
| "No iOS app has fetched these settings yet." | One line for each platform, under the version line | An example: no recorder of this platform has fetched the settings. | — |
| "Nothing is stored for this project yet: the defaults below apply." | — | Nobody has changed this project. | — |
| "You are a member: you can read these settings; owners and admins change them." | For members and viewers | An example: the line that a member sees on the greyed-out form. | — |
| "The project is archived, so nothing is recorded whatever these say." | — | The project is archived. | — |
| "3 unsaved changes" | The bottom bar | An example: the bar counts your unsaved changes. Open it to see each change. | To undo all unsaved changes before you save, click Discard. |
| "Web recording is off: the saved Blocked elements selector isn't valid in browsers ("div:nope" is not a valid CSS selector). No web session is recorded until it is fixed under Privacy and masking." | The top of the page, only while Record sessions and Web are on | An example: a saved Masked text or Blocked elements selector is not valid in your browser. | — |

For the selector fields, see [Masking and redaction](/docs/masking-and-redaction).

If someone else saved while you were editing, Sequential refuses your save. The page says, for example, "Ana saved these settings …, after you opened them. Load their version, then make your change again." If Sequential support saved, the message starts with "Someone".

Click "Load the newest version". It loads their version and drops your edits. Make your edits again.

## How it works

Each project has one recording policy. Every save creates a new version: v1, v2 and so on. One form holds the settings for the web and for [mobile apps](/docs/mobile).

Recorders fetch the settings themselves, so a change needs no redeploy. The web recorder fetches them on every page load, before it records anything. A mobile app fetches them at launch and keeps a copy.

## The controls

This table gives each control's default and what applies it: server or recorder.

| Control | Default | Applies to | Applied by |
|---|---|---|---|
| Record sessions | On | Web and mobile | Server |
| Record on: Web, iOS, Android | All on | Each platform | Server |
| Share of sessions recorded | 100 %. Staging and development projects made before 1 November 2026 started at 10 % | Web and mobile | Recorder |
| Shortest session kept | 2 seconds | Web and mobile | Recorder |
| Longest recording | 60 minutes | Web only | Recorder |
| Largest recording | 25 MB | Web and mobile | Server |
| Record only these pages, Never record these pages | Empty | Web only | Recorder |
| Masking level and its fields | Strict | Web only. Attribute values also applies to the DevTools addresses that apps send | Recorder; the server masks some values again |
| JavaScript errors, Console output, Network requests, Performance timings | All on, except the console level `debug` and Console message text | Web, some on mobile ([DevTools captures](#devtools-captures)) | Server, and the recorder |
| Heatmaps | On | Web only | Server |
| Replay period (no control) | 30 days | Web and mobile | Server |

| Applied by | What it means |
|---|---|
| Server | Sequential applies the setting to every upload as it arrives, whatever the recorder was told. |
| Recorder | Sequential's web recorder applies it, or your app's SDK on mobile. The server does not check it again. |
| Server, and the recorder | The server also applies your current DevTools settings to every upload. |

These settings are saved, but nothing applies them today: Recordings at the same time, Session budget, When the budget is used up, Never record these app screens, Properties dropped, Properties hashed, IP addresses and Allowed app ids ([Limits in detail](#limits-in-detail)).

### Recording, platforms, sampling and session caps in detail

Session replay records what real people see and do in your product. These settings decide how much of it Sequential keeps. Defaults are what a new project starts with. Your project's own values are on the page.

Each number field shows the values that it takes, for example "Allowed: 1–1,440 min."

Websites use Sequential's recorder, from Session replay (web) or started by the [Sequential SDK](/docs/sequential). Web replays come only from this recorder, whichever analytics SDK you use.

Record sessions stops all recording at once, without a code change. For example, do this if a release shows people's addresses without masking. While Record sessions is off:

- The web recorder does nothing.
- Sequential tells mobile apps not to record.
- Sequential refuses every upload immediately.

Pages that are already open keep running the recorder that they loaded. Sequential stores nothing that they send. When you archive a project, Sequential also turns recording off.

Record on chooses where the project records. Sequential refuses uploads from a platform whose box under Record on is off. React Native and Flutter apps have no box of their own. They record while iOS or Android is on, and they never get a line of their own under the version line.

Under Record on, the page says what reaches an app: "iOS and Android apps are sent these switches, the share recorded, the shortest session, and whether to send console logs and network timing; the app's SDK decides what else it captures. What an app sends is then filtered by the console and network settings under What a recording carries and by Attribute values, and refused past Largest recording."

Share of sessions recorded records a share of sessions, to control volume:

- Each project has its own rate. For example, a staging project can record 10 % while production records 100 %.
- Every new project starts at 100 %, whatever its environment. Staging and development projects made before 1 November 2026 started at 10 % and keep that rate: until 1 November 2026, when Sequential created a staging or development project, it set its sampling to 10 %, saved as v1 in its creator's name. A project created on or after 1 November 2026 has nothing stored, so it shows the defaults.
- On websites, the recorder decides once per session. So it records a session across several pages completely or not at all.
- A new rate applies to new sessions only.
- When the rate is under 100 %, the player says it for a session that has no recording: "This session was not recorded. This project records about 10% of its sessions." At 0 %, it says "This project records no sessions." The line gives the project's rate, not the cause for this session. A session can have no recording for other reasons too. Owners and admins get a link to Share of sessions recorded. Other roles read "An owner or admin can change this in Settings › Recording & data." On Sessions, the tooltip of "None" in the Recording column says the same.

Shortest session kept (default 2 seconds) leaves out very short visits, such as bounces:

- Enter seconds, for example 1.5. Sequential stores milliseconds.
- A value of 0 turns it off.
- On websites, the clock restarts at each page load. So a page that a person leaves sooner sends nothing, even in the middle of a session.
- If people move quickly between pages, keep this value low.

Longest recording (default 60 minutes) stops a tab left open all day from recording all day. On websites, it also counts from each page load. So it limits each page, not the whole session.

Largest recording (default 25 MB) stops one runaway session from growing without limit:

- The server adds up the size of the recording data that it stores for the session, across its pages. It counts the data before compression. It refuses more data past the limit. On websites, the recorder then stops.
- The limit also applies to mobile apps.
- If Sequential's counter is unavailable, it does not apply the limit.
- The count starts again when a session sends nothing for 2 hours.
- An example of a runaway session is a page with constant animation.

### URL patterns

Record only these pages and Never record these pages keep pages out, or record only part of your product. They take path patterns, one per line. The help under each list says: "One pattern per line, matched against the whole path. * stays within one path segment: /app/* matches /app/settings, not /app/settings/billing. ** crosses segments: /app/** matches /app/settings/billing."

| Pattern | Matches | Does not match |
|---|---|---|
| `/app/*` | `/app/settings` (`*` matches within one path segment) | `/app/settings/billing` (`*` never matches a `/`) |
| `/app/**` | Every page under `/app/`, such as `/app/settings/billing` (`**` matches across segments) | — |
| `/account/*/billing` | `/account/42/billing` | — |
| `/checkout/**` | `/checkout/pay` | `/checkout` itself. To keep a whole section out, list both `/checkout` and `/checkout/**`. |
| `https://example.com/checkout` | Never matches. Patterns match the page's path only, with no domain or query string. | — |

- If a page matches both lists, Never record these pages wins. If Record only these pages has entries, a page must match one of them.
- Each list takes up to 200 patterns, with at most 100 wildcards and 8,192 characters in total.

When a person moves within your app:

- A person can move to a path in Never record these pages, or to a path that a non-empty Record only these pages does not include. The recorder notices within about a second. It sends what it has captured, then stops. It stays stopped until the next full page load, even if the person moves back.
- That last second can include the start of the excluded page, masked as usual. If a page must never appear, open it with a full page load. Also mask or block its content.
- If a page loads on a path that the lists exclude, nothing records during that page load. This stays true after the person moves within your app to an allowed path. Recording starts at the next full page load on an allowed path.

### Masking presets

Masking level chooses how much of each page you can see in a replay. Masking happens in the person's browser, before anything is sent. The masking level does not reach the mobile SDKs (iOS, Android): an app sets its masking in its own code. See [Mobile apps](/docs/mobile#ios-swift). From 6 November 2026, under Masking level, the page says "These settings do not reach the mobile SDKs (iOS, Android). Set masking in the app code. Default image masking can make an app replay all black.", with the link Masking in apps →. It does not show this when only the web recorder has read the settings of the project. From 8 November 2026, the note has parts. A row "Images" says "Default image masking can make an app replay all black." Under it, the line "These settings do not reach the mobile SDKs (iOS, Android). Set masking in the app code." always shows. Then come the link Masking in apps → and "Read the full text ▾", which holds the whole note. Members and viewers see the whole note open.

| Masking level | What it does |
|---|---|
| Strict (default) | Masks all text and every input. Blocks images, SVG, video, audio, iframes and embeds. Masks attribute values, except structure, id references and known state values. Cuts link and image addresses to their domain, and the page address and web font files to their route with id-like parts masked. You see the layout and where people clicked, not what they read. |
| Balanced | Masks every input. Masks text only inside elements with the `data-sq-mask` or `data-sq-private` attribute or the `sq-mask` class. Records images and SVG. Still blocks video, audio, iframes and embeds. Records attribute values and the full page address as they are. |
| Custom | Any other combination. |

Under Masking level, the form has Mask every input, Masked text, Blocked elements, Attribute values (titles, labels, alt text, data-*), Collect fonts and Record canvas. The two selector fields take CSS selectors, separated by commas. If you choose Strict or Balanced, Sequential overwrites all six. If you edit any of them, the level changes to Custom, unless the six then match Strict or Balanced exactly.

From 10 October 2026, the recorder always gets `[data-sq-private]` in its Masked text selector, also when the field is empty and masks no other text. You do not need to add it. The help under the field says "[data-sq-private] is always masked as well." Under Strict, the selector is `*`, which masks all text already.

From 10 October 2026, when Record canvas is on, the recorder records each canvas as a series of snapshots, not as its drawing calls. By default, it takes 2 snapshots a second, as WebP images at quality 0.6. A canvas that does not change adds nothing to the recording after its first snapshot. While Record canvas is on, two fields change this: Canvas snapshots per second, a whole number from 1 to 10, and Canvas snapshot quality, from 10 to 100 %. An owner or admin can also set them through the settings API, with PATCH `/api/projects/:id/config`, as `replay.masking.canvas_fps` and `replay.masking.canvas_quality` (0.1 to 1.0). The API refuses a value outside these ranges, and the recorder uses the default when it gets no valid value. A preset does not change them, and a change to them keeps the preset.

Attribute values (titles, labels, alt text, data-*) has three choices: "Masked", "Kept, URLs cut to the path" and "Recorded as on the page". Strict uses "Masked", and Balanced uses "Recorded as on the page". "Kept, URLs cut to the path" is a Custom choice only. This field also sets how DevTools shortens network addresses and code locations. See [Masking and redaction](/docs/masking-and-redaction).

The masking on this page applies to the web only. The one exception is Attribute values: it also shortens the DevTools addresses that iOS and Android apps send.

Both presets mask what people type, the value of a checkbox or radio button that a person picks, the name of a file that a person picks and the value of hidden fields.

Masked text keeps its place and shows as solid blocks (█). A blocked element leaves an empty box of the same size. Add `data-rr-block` to any element that must never be captured. Both presets block it.

Sequential never re-masks a recording later. Each recording keeps the masking that it was made with. See [Masking and redaction](/docs/masking-and-redaction).

> **Console text can hold personal data**
>
> Console message text is off by default. If you turn it on, Sequential stores whatever your app writes to the console. Anyone who can open the project's replays can read it: every role, viewers included. If you turn it off later, Sequential keeps the text that it already stored.

### DevTools captures

The captures are in Settings › Recording & data › What a recording carries. They record the technical context behind a replay. All are on by default, except the console level `debug` and Console message text. They apply to the web. They also apply to mobile for Network requests, and for Console output while Console message text is on.

| Capture | What it records |
|---|---|
| JavaScript errors | Uncaught exceptions and unhandled promise rejections, with stack traces. Web only. |
| Console output | Calls at the levels you tick. By default `error`, `warn`, `info` and `log`, not `debug`. |
| Network requests | Each request's method, URL, status, timing and size. Never its headers or body. |
| Performance timings | Core Web Vitals and page-load timing, per page load. Web only. |

The server applies your current DevTools settings to every upload. So when you turn a capture off, Sequential stops storing it immediately. This includes data from an older recorder or a mobile app.

Replays recorded while a capture is off do not show as clean for that kind. They carry no count for it, never a zero. So a filter for sessions with errors or failed requests cannot return them.

On mobile, logs on iOS and network timing on Android also need a setting in the app itself. See [Mobile apps](/docs/mobile) and [DevTools](/docs/devtools).

Without Console message text, a web console entry keeps its level, how often it was logged and where. Warnings and errors also keep a stack trace. The entry does not keep the words that were logged.

With it, you also get the words, such as "payment failed: card_declined" or an API error body. The words are often why the entry matters.

Redaction: Sequential replaces these with `[redacted]`:

- JWTs
- Bearer and Basic credentials
- email addresses
- card numbers
- values under names like `password` or `token`

No rule catches a name, a postal address or a one-time link in a log line.

The help beside the box says: "Messages can hold what people typed or saw. Off by default."

- Keep it off for production until you have checked what your app logs.
- Settings are per project, so a separate staging project can keep it on.
- While JavaScript errors is on, Sequential keeps exception messages either way, even with Console message text off.
- On iOS and Android, Sequential asks the app for logs only while Console message text is on. Under the box, the page says: "On iOS and Android, logs are requested from the app only when Console message text is on."
- From 8 November 2026, under the box Console message text, the page says "Keeps the text of each console message in the recording." A row says Default: "Off". A risk line always shows: "Messages can hold what people typed or saw." The old help, "Messages can hold what people typed or saw. Off by default.", is under Read the full text ▾.

The network request settings work like this:

- Query values kept lists the query parameter names whose values you want to keep. Sequential records every other query value as `[redacted]`.
- Requests ignored takes patterns, one per line. `*` stays within a path segment and `**` crosses segments.
- The help under Requests ignored says: "One pattern per line, matched against the whole URL without its query. * stays within a path segment, ** crosses them. For example https://api.example.com/health*."
- Unlike the page lists, these patterns match the request's full address without its query string. So include the domain, as in `https://api.example.com/health`, or start with `**`, as in `**/health`.

## Heatmap data

Sequential collects heatmap data for a sample of recorded web sessions: where visitors click and how far they scroll, as page structure and counts, with no text. For what it holds, see [Heatmap data](/docs/privacy-overview#heatmap-data).

### How the heatmap switch works

Workbench › Heatmaps shows its click counts and scroll depth ([Heatmaps](/docs/sessions-and-replay#heatmaps)).

The Heatmaps box turns heatmap data on or off. In Settings › Recording & data › What a recording carries, it says: "Clicks and scroll depth from a sample of recorded sessions. Needs recording on." The recorder loads the heatmap code only while it is on, and the server stores heatmap data only while it is on.

- Heatmap data is on by default for each project that records websites.
- From 15 October 2026, the switch also covers agents. With heatmap data off, `list_heatmap_pages` and `get_heatmap` answer `off`, with the reason.
- Only owners and admins can change the switch. Members and viewers see it read-only. While heatmap data is off, Workbench › Heatmaps says "Turn them on in project settings."
- Turning it on asks first. When you save, a box asks "Turn on heatmaps for …?" and says what is counted and who sees the page picture. Nothing is saved until you click Turn on. Turning it off asks nothing. For the full text, see [Turn heatmap data on or off](/docs/privacy-overview#turn-heatmap-data-on-or-off).
- From 8 November 2026, the question lists what is counted and kept: Counts, From, Stored, Page address, Session ids, Kept for, Page picture and Agents. The old text is under Read the full text ▾. For the words of each row, see [Turn heatmap data on or off](/docs/privacy-overview#turn-heatmap-data-on-or-off).
- The switch saves with the form. It saves when you click Save changes, with your other changes. The Audit log records it as `project.config_changed`.
- For the sample, choose Automatic (about 2,000 sessions a day) or A fixed share. For A fixed share, Heatmap share is a percentage of recorded sessions, from 0.1 to 100. The choice shows only while heatmaps are on. See [Limits](/docs/limits#heatmap-data).
- It needs recording and the web. While Record sessions or Web under Record on is off, Sequential collects no heatmap data.
- The web recorder stops loading the heatmap code on the next page load. Sequential's servers stop storing heatmap data from open pages after they read the new setting.
- The page picture stops too. While heatmap data is off, a request for a page picture answers `off`. See [The page picture](/docs/privacy-overview#the-page-picture).
- To check it, open What applies › The settings that apply, as JSON, and look for `heatmaps` under `replay`.
- Through the API, a script signed in as an owner or admin can set `replay.heatmaps.enabled` with PATCH `/api/projects/:id/config`. It must send the whole settings document, with `If-Match`. See [Turn heatmap data on or off](/docs/privacy-overview#turn-heatmap-data-on-or-off).

## Limits

- A modified recorder can bypass recorder-only settings. So can anyone who sends data with your project's public replay key.
- These settings apply per project, not per person. For a person's consent choice, see [Sequential SDK](/docs/sequential), or add the recorder's tag only after the person consents ([Session replay (web)](/docs/session-replay)).
- Replays stop playing first, and the files go later ([Limits in detail](#limits-in-detail)).

### Limits in detail

Settings that apply nothing yet. They are saved, but nothing applies them today:

| Setting | Default | Applies to | Under | What it says |
|---|---|---|---|---|
| Recordings at the same time | 50 | — | Limits not applied yet, and upload timing | "Saved; nothing applies it yet." |
| Session budget | No budget | — | Limits not applied yet, and upload timing | "Saved; nothing applies it yet." |
| When the budget is used up | "Tell us" | — | Limits not applied yet, and upload timing | "Saved; nothing applies it yet." |
| Never record these app screens | Empty | iOS and Android | — | "These screens are still recorded. Saved; nothing applies it yet." |
| Properties dropped | — | — | Property and IP rules not applied yet | "Saved; nothing applies it yet." |
| Properties hashed | — | — | Property and IP rules not applied yet | "Saved; nothing applies it yet." |
| IP addresses | — | — | Property and IP rules not applied yet | "Saved; nothing applies it yet." |
| Allowed app ids | — | — | Who may send data | "Bundle or application ids, exactly. Any iOS or Android app with your key can still send. Saved; nothing applies it yet." |

- Nothing reads the first three settings in this table (Recordings at the same time, Session budget and When the budget is used up), so they do not limit how many sessions record at once. To control volume, use Share of sessions recorded and the session caps.
- Never record these app screens takes screen names, as your iOS or Android app reports them. Nothing applies the list to mobile recordings today. Its help says: "Screen names as your iOS or Android app reports them. These screens are still recorded. Saved; nothing applies it yet."
- Allowed app ids: Sequential takes data from any iOS or Android app that sends your key. Its help says: "Bundle or application ids, exactly. Any iOS or Android app with your key can still send. Saved; nothing applies it yet."

The page lists match the path only: `/checkout/**` does not match `/checkout` itself, and a pattern with a domain, such as `https://example.com/checkout`, never matches ([URL patterns](#url-patterns)). Requests ignored matches the full address: a path-only pattern such as `/health` never matches. Use `https://api.example.com/health` or `**/health` ([DevTools captures](#devtools-captures)).

What applies › The settings that apply, as JSON shows the session budget, `events_retention_days`, the IP setting, the property deny and hash lists, and the allowed origins and bundle ids. `events_retention_days` is the organisation's events retention period, and Sequential applies it: see [Retention and deletion](/docs/retention-and-deletion). Sequential applies the allowed origins to every request that sends data. Owners and admins change them in Allowed sites under Who may send data. See [Organisations and projects](/docs/organisations-and-projects). The others do not restrict who can send data or which properties Sequential keeps. The one exception is heatmap data: if the allowed origins list hosts, Sequential drops heatmap data from pages on other hosts.

The recorder applies Share of sessions recorded, Shortest session kept, Longest recording, the page lists and the masking. A modified recorder can bypass these five. The server does not check Share of sessions recorded, Shortest session kept, Longest recording, the page lists or text masking again. It does mask attribute values, addresses, input values and DevTools addresses again, under the current settings of the project.

Settings apply to new recordings only. Tightening masking or turning a capture off does not change what is already stored.

The replay period has no control. It is how long replays stay available: one of 7, 30, 90, 180 or 365 days. It is the organisation's period, set by Sequential. A server-wide limit can make it shorter. At the end of it, Sequential stops playing the replay, and the storage deletes the recording files about 2 days later.

By default, after 30 days you cannot play a replay. The storage deletes the recording files about 2 days after that. If you delete the project, its recordings become unreadable at once, and the storage deletes the files later.

Replays stay available by default for 30 days, counted from when the first part of the recording arrived at Sequential. How long data is kept, under Data and your team, shows the organisation's two periods: Events and Recordings (the replay period). If the server sets a shorter limit, the page shows the limit, with a line that says why. See [A server-wide limit](/docs/retention-and-deletion#a-server-wide-limit). The organisation sets both periods for all its projects. The page has no control for them, and only Sequential support can change them. A shorter period deletes nothing: stored recordings keep their old period. Through the settings API, a change of either period gets 409 `retention_set_by_organisation` and saves nothing. After the period, you cannot play the recording in Sequential. See [Retention and deletion](/docs/retention-and-deletion).

Sequential support can also save a new version. Who changed what then names "Sequential support" for that version. Every role sees each save under Who changed what, as a sentence such as "Ana Novak changed 3 settings", with the time. Open a version to see each change. Owners and admins also see the project's audit rows under Recent changes. The audit log also shows each save, with what changed. See [Audit log](/docs/audit-log).

## Next steps

- [Find and replay sessions](/docs/sessions-and-replay): watch the recordings.
- [Masking and redaction](/docs/masking-and-redaction): choose what a replay hides.
- [DevTools](/docs/devtools): read errors, console and requests.
- [Retention and deletion](/docs/retention-and-deletion): how long recordings stay.
- [Session replay (web)](/docs/session-replay): add the recorder to a website.
