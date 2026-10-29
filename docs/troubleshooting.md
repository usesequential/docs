# Troubleshooting Sequential

> Causes and fixes for common problems: missing events or session replays, an empty Evidence, people counted twice or not found, and dates.

> **In short**
>
> - Most missing data comes from the wrong project, the wrong window or a source that sends nothing. Check these three first.
> - If events do not arrive, look at the **Network** tab of your browser's developer tools.
> - Each project has its own recording settings. A saved change reaches websites on the next page load.
> - Every window is a run of whole UTC days. There is no time-zone setting.
> - "Known limitations" at the end of this page lists the problems with no fix yet.

## Check these first

1. **The project.** Pages show the project selected in the project switcher, at the top of the left rail. Each browser remembers its own choice. A link with `project=` selects its project for you.
2. **The window.** Each view of **Workbench** shows only the days of its window. It opens on the window in its address, or else on its own default, such as the last 7 days. **Evidence** always shows the last 7 days, as whole UTC days.
3. **Setup.** Open **Settings** › **Setup**. Under **Sources**, **Sequential** and **Session replay** show "receiving" or "no events yet". Another source shows only after its first event.

### Project and window: more detail

- Three checks explain most missing data.
- The switcher is at the top of the left rail. Every page shows the selected project.
- Each browser remembers its own project choice. So a teammate can look at a different project.
- A view shows nothing outside its window.
- Each view keeps its window in its address. To share your window, copy the address, or click **Copy link**.

## A page shows no data

The pages tell you why they are empty. The message is in a card.

| You see | What it means | What to do |
|---|---|---|
| "<Project> is ready. Nothing has arrived yet." on the **Brief** | The project has never received an event or a recording. | Open **Send your sessions** in the setup checklist above the card. Install a source there. A viewer sees "The install snippet needs a member, admin or owner — ask one for the keys." |
| "Nothing in the last 30 days" under **Your dashboard** on the **Brief** | No event in the last 30 days makes a tile. | Press **Set up <project>**. For an owner or admin, it opens the **Install** step of onboarding. |
| "No session matches." and "Widen the window, or take a condition out of the search." on Workbench › **Sessions** | The project has data, but nothing in this window matches your search. | Widen the window, or take a condition out. The list loads again a short time later. |
| "Nothing to count here" and "Widen the window, or take a condition out of the filter." on Workbench › **Events** | The project has data, but nothing in this window matches your filter. | Widen the window, or take a condition out. The view counts again a short time later. |

While nothing has arrived, **Settings** › **Project** also says "Nothing has arrived from this project yet." Click **Set up a source**. It opens **Settings** › **Setup**.

While **People**, Workbench › **Sessions** or Workbench › **Accounts** loads, it shows placeholder rows, not a count of 0. If a list does not load, the page gives the reason and **Try again**.

If the project has data but no account, Workbench › **Accounts** says "No account yet." It adds "Accounts appear once your site sends an account id with its events." See "Accounts is empty, or sessions have no account" below.

## No events arrive

1. Open your site in a normal browser.
2. In the developer tools, open the **Network** tab.
3. Filter by the API address in your install snippet. For the Sequential SDK, this is `data-api`.

In onboarding, the **Install** step says "Waiting for the first event." until your first event arrives. Then it says **It works**. **Settings** › **Project** shows what Sequential refused, on its **Refused** line. See [Your first hour](/docs/quickstart).

[Check your install](/docs/verify) explains every response.

| Symptom | Likely cause | Fix |
|---|---|---|
| 401 `unknown_ingest_key` | The key is mistyped, revoked or for another source. Or the project is archived. | Copy that SDK's key from **Settings** › **Setup** or **Settings** › **Keys**. If archived, an owner or admin clicks **Unarchive and take data again** under **Settings** › **Recording & data** › **The project**, or **Unarchive** under **Archived** on **All projects**. |
| Pendo requests get 401 | Your own Pendo API key is not registered. | An owner or admin pastes the apiKey under **Pendo API key** on **Settings** › **Keys** and clicks **Register**. See [Pendo](/docs/pendo). |
| 403 `Bot traffic not allowed` | The request looked automated. | Test in a normal browser. |
| 403 `origin_not_allowed` | The project has a list of allowed origins, and this site is not on it. A sandboxed iframe or a `data:` page sends `Origin: null`, which is also refused. The Sequential SDK then stops for the rest of the page load and writes "[sequential] Events refused: this website is not on the project's allowed websites (origin_not_allowed). This page sends no more events." | An owner or admin adds the site under **Allowed sites**, in **Settings** › **Recording & data** › **Who may send data**. See [Organisations and projects](/docs/organisations-and-projects). |
| 429 `rate_limited`, with `Retry-After` | The project sent more than its event rate limit, 20,000 events a minute. The Sequential SDK waits, then sends again. | Send fewer events. Look for a capture call that runs in a loop, or on each scroll or mouse move. See [Limits](/docs/limits). |
| 503 `overloaded`, with `Retry-After` | The Sequential server had too much work, so it refused some uploads for a few seconds, or its database was briefly unavailable (then the wait is 30 to 60 seconds). This is not a limit of your project. The Sequential SDK and the recorder wait, then send again. | Nothing to change. If it continues, contact Sequential support. See [Limits](/docs/limits). |
| 503 `config_unavailable`, with `Retry-After: 30` | Sequential could not read the project's settings, so it could not check the allowed origins. | Wait, then send again. If it does not stop, contact Sequential support. |
| Requests blocked, no status | Your Content-Security-Policy. | Allow the hosts your SDK's install page lists. |
| Console shows `[sequential] the script tag has no data-key — no events will be sent.`, or says that `data-api` is missing | The tag misses an attribute, so the SDK does nothing. | Copy the snippet again from **Settings** › **Setup**. See [Sequential SDK](/docs/sequential). |
| One browser sends nothing (Sequential SDK) | It remembers `sequential.optOut()`, in the `__sq_opt` key. | Call `sequential.optIn()`, for example from your consent banner. |
| Events stop after the consent page (Sequential SDK with `data-opt-out`) | `data-opt-out` starts every page load opted out. | After consent, call `sequential.optIn()` on every page load. |
| Amplitude events never arrive | Batching (`useBatch`) is on. Today, batched requests do not reach Sequential. | Turn batching off. See [Amplitude](/docs/amplitude). |
| **Settings** › **Setup** says "receiving", but Workbench › **Events** is empty | Wrong project or window. | Fix both. For today's events, see "Dates differ by one day". |

**Settings** › **Setup** checks every 5 seconds for 5 minutes, then stops. To check again, reload the page.

You can also ask an agent that has `analytics:read`: "Is Sequential dropping or refusing any of the data my site sends?" One `get_overview` call answers it. See **Refused or dropped data** below.

## Console lines about the SDK settings

When the settings of the [Sequential SDK](/docs/sequential) are wrong, it writes a line that starts with `[sequential]` to the browser console.

| Console line | What it means | What to do |
|---|---|---|
| `[sequential] the script tag has no data-key — no events will be sent.` | The SDK found no key: not on its own tag, not in a usable `window.sequentialConfig`, and not on another script tag of the page. It sends nothing. | Add `data-key` to the tag, or `key` to `window.sequentialConfig`. Copy the key from **Settings** › **Setup**. |
| `[sequential] the script tag has no data-api — no events will be sent. The CDN origin is not the ingest origin, so it cannot be guessed from this script’s own src.` | The tag, or `window.sequentialConfig`, has no API address that the SDK accepts. It sends nothing. | Add `data-api`, or `api`, such as `https://api.usesequential.com`. |
| `[sequential] window.sequentialConfig has no key; it is not used.` | The config has no `key`. The SDK looks for a script tag with `data-key` instead. | Set `key`. |
| `[sequential] window.sequentialConfig.key is not a Sequential ingest key (sq_sequential_…); it is not used.` | The key is not `sq_sequential_` and 1 to 64 letters or digits. The SDK looks for a script tag with `data-key` instead. | Copy the key from **Settings** › **Setup** again. |
| `[sequential] window.sequentialConfig.api must be an https:// origin, such as https://api.usesequential.com.` | `api` has a path, a query, a fragment, user information or `http:`. The SDK then also writes the `data-api` line above and sends nothing. | Use an `https://` origin with no path. |
| `[sequential] window.sequentialConfig.<names>: not read (only key, api and release are). To hold events until consent, fire the tag after consent or call sequential.optOut().` (a warning) | The config has other names. The SDK uses the config, but not those names. | Remove the other names. To wait for consent, fire the tag after consent, or call `sequential.optOut()`. |

See [Configure without attributes](/docs/sequential#configure-without-attributes).

### Refused or dropped data

`get_overview` has a setup check named `ingest_refusals`. It tells an agent what Sequential refused or did not store for this project in the window, and why. Or it tells that Sequential refused nothing.

- The check shows at most 3 lines, the largest first. `more_reasons` counts the others. Each line has the reason, the source, the count, the last day and a sentence.
- A count is of requests: event batches for the Sequential SDK, uploads for recordings, or the requests of another tool's SDK. For `replay_event_malformed` and `heat_host_not_allowed`, it is of events.
- A refusal shows about a minute after it happens. Sequential keeps the counts for 30 days, so the oldest day of a 30-day window can be incomplete.
- A request with a wrong or revoked ingest key names no project, so Sequential cannot count it for your project. See **No events arrive** above.
- If Sequential cannot read the counts in time, the state is `unknown`.
- A host in a line can be another website that uses your project's public key.
- GET `/api/projects/:id/status` returns the same lines for the last 7 days, under `refusals`. **Settings** › **Project** shows them on its **Refused** line, with **What to do**. The **Brief** says how many uploads Sequential refused, under **Health**, with **Why**.

| Reason | Sequential | What to do |
|---|---|---|
| `origin_not_allowed` | refused data from a website that is not in the project's allowed origins | If the host is your own site, an owner or admin adds it under **Allowed sites**. Do not add a host that you do not know |
| `origin_missing` | refused a request with no `Origin` or `Referer` header, because the project accepts only its allowed origins | Check that nothing between the page and Sequential, such as a proxy, removes the `Origin` header |
| `trial_origin_locked`, `trial_replay_after_claim`, `trial_session_cap` | refused data because the trial project is not claimed: it accepts only local development, it records no mobile replay, or it reached its session limit | Claim the trial project. See [Agent trials](/docs/agent-trial) |
| `billing_limit_reached` | refused data because the organisation was over its monthly session allowance | Recording of new sessions starts again when the monthly allowance resets. **Settings** › **Organisation** shows the day when the count starts again |
| `replay_disabled` | refused recordings because session replay is off for the project or its platform | Turn on session replay, or stop the SDK from recording |
| `bot` | refused data from a browser that says it is a bot or runs headless, such as an automated test, a crawler or a script. It counts a request only when the request has a known ingest key. It does not store the user agent. It does not count Pendo requests or PostHog's mobile replay uploads | Test in a normal browser window |
| `too_large`, `event_too_large` | refused recording uploads over a size limit | Flush the recorder more often, or mask or block large elements |
| `rate_limited` | refused recording uploads over the project's replay rate limit | Record fewer sessions, or mask large elements |
| `replay_upload_lost` | from 23 October 2026: dropped replay uploads in the browser before they were sent. The recorder held the most failed uploads that it keeps for a retry, during an outage or on a page that records faster than it can send | Nothing to change if it was during an outage. If it repeats, lower the replay sample rate or mask large elements, so that each upload is smaller |
| `event_rate_limited` | refused event batches over the project's event rate limit | Send fewer events. Look for a capture call that runs in a loop, or on each scroll or mouse move |
| `session_cap` | refused uploads of a session that reached the largest size of a recording | |
| `malformed`, `replay_event_malformed` | refused uploads, or dropped recording events, that it could not read | Update the SDK |
| `empty_batch` | received batches that held no events, and stored nothing | Update the SDK |
| `heat_host_not_allowed` | dropped heatmap data from a page whose host is not in the allowed origins | |
| `config_unavailable`, `trial_unavailable`, `not_stored` | could not check or store the data. The fault was on Sequential's side | Nothing to change. A sender that tries a 503 again sends the data again. If it continues, contact Sequential support |

### An agent sees [person] in your own site address

An agent gets a host or a URL with `[person]` in it, for example `www.[person].com`. A value that Sequential knows for a person has the word of your domain in it. Often this is a teammate's sign-up email with a tag, such as `name+yourbrand@…`, or a test user named after your product.

To fix it, add your site to the list of allowed websites: **Settings** › **Recording & data** › **Who may send data** › **Allowed sites**. From 10 October 2026, Sequential then keeps your own hosts readable for agents. See [Privacy at a glance](/docs/privacy-overview).

The list also refuses data from sites that are not on it. So add every site that runs your snippet. See [Organisations and projects](/docs/organisations-and-projects).

### Not a fault

- On **Settings** › **Setup**, "Waiting for the first event from the sources above" stays while a line on the list reads "no events yet". Only **Sequential** and **Session replay** can read so. This includes **Session replay** when you do not record. Read the line for your own source.
- A first event can take up to about a minute to appear. If a project already has some data, a new source can take up to about two minutes to change to "receiving".
- "Used … ago" on **Settings** › **Keys** only means that a request used the key, for example to get settings. It does not prove that Sequential stores events.

### No events arrive: more detail

- **Keys.** Each ingest key works only with its own SDK. Members, admins and owners can see keys. An archived project refuses all its keys. After **Unarchive**, the same keys work again.
- **Pendo.** Pendo sends with your own Pendo API key. Paste the apiKey from your Pendo snippet.
- **Bot traffic.** Examples of automated requests: a headless browser, a test runner, curl or a server-side SDK. By design, automated tests do not appear in Sequential. Events from the [backend SDK](/docs/backend-sdk) are not bot traffic.
- **Opt-in.** Check that your consent banner calls `sequential.optIn()` when the visitor agrees. `data-opt-out` is a default, not a stored choice. So `sequential.optIn()` on one page does not carry to the next page. Do not call it only when the visitor clicks the banner.
- **Amplitude batching.** Today, batched requests do not reach Sequential's Amplitude handling.
- **Session ids.** Instead of the recorder, you can register your own `$session_id` super property.

## Session replay does not record

Owners and admins change each project's recording settings under **Settings** › **Recording & data**. A saved change reaches websites on the next page load and apps on the next launch. See [Recording settings](/docs/recording-settings).

| Symptom | Likely cause | Fix |
|---|---|---|
| No recordings at all | **Record sessions** is off, the platform is off under **Record on**, or the project is archived. | Turn on **Record sessions**, or tick the platform under **Record on**, for example **iOS**. Then click **Save changes**. If archived, unarchive the project. |
| A website with PostHog, Mixpanel, Amplitude or Pendo records nothing | Their web recorders do not send to Sequential. | Add Sequential's recorder. See [Session replay (web)](/docs/session-replay). |
| An app with PostHog's mobile SDK records nothing | The app's PostHog setup has session replay off. | Set `sessionReplay = true`, or `enableSessionReplay: true` in React Native. See [Mobile apps](/docs/mobile). |
| The Sequential SDK or Smartlook records nothing | The project has no live **Session replay** key. | An owner or admin picks **Session replay** in **New key for** on **Settings** › **Keys**, and clicks **Create key**. |
| Only some sessions are recorded | **Share of sessions recorded** is below 100 %. | Raise **Share of sessions recorded**. |
| Short visits have no recording | **Shortest session kept**, default 2 seconds, applies to each page load. | Lower it. 0 turns the rule off. |
| No recordings, and the browser console shows `[sequential] replay: masking_selector_invalid` | A saved **Masked text** or **Blocked elements** selector is not valid CSS in that browser. Sequential records nothing rather than record unmasked content. If your browser also refuses it, the top of **Settings** › **Recording & data** starts with "Web recording is off". | Fix the selector under **Privacy and masking**, then click **Save changes**. See [Masking and redaction](/docs/masking-and-redaction). |
| No recording from some visits, and the browser console shows a warning followed by `[sequential] replay: recorder_start_failed` | The recorder could not start on that page in that browser. Nothing from that visit was recorded or sent, not even DevTools data. The warning just before the line names the cause. | If it happens only for some visitors, such as an old browser or one with an extension that changes how pages work, there is nothing to fix on your site. If it happens on every visit to a page, a script on that page usually replaces a built-in browser feature that the recorder needs: check that page's other scripts. A reload does not help: the same browser on the same page fails the same way. |
| Some pages are never recorded | **Record only these pages** and **Never record these pages** match only the page path. | Use path patterns, for example `/checkout/**`. |
| Text shows as ███ and images are missing | **Strict** masking is the default. | Set **Masking level** to **Balanced**. Only new recordings change. **Balanced** also records attribute values and the full page address. On mobile, the app's SDK sets masking. See [Masking and redaction](/docs/masking-and-redaction). |
| Fonts look wrong, or background images are missing | **Strict** masking cuts image addresses to their domain, so the player cannot load them. From 26 October 2026, a web font loads, unless an id-like part, such as a long build hash, masks its file name. A recording from before that date shows fallback fonts. | Expected under **Strict**. See [Masking and redaction](/docs/masking-and-redaction). |
| A recording stops partway | A 413 on `/rec/`: **Largest recording** (default 25 MB) or one upload too large. No 413: **Longest recording** (default 60 minutes). | Raise them under **Recording**. |
| A recording has gaps, with 429 responses | The project reached the upload rate limit: 50 MB a minute, shared by all its visitors. | Lower **Share of sessions recorded** on busy projects. |
| A session does not play from Workbench › **Sessions** or **Evidence** | The **Recording** column, or the card on **Evidence**, says why. Hold the pointer on the column to read more. "Processing", or "Ready by 14:05" with a time on a card: the recording is not ready yet. "Expired" or "Recording expired": the replay period ended. "Unplayable" or "No playable recording": Sequential never received the full recording, so the player cannot play it. "None" or "No recording": the session ids are different, the session was not recorded, or the recording expired more than about a week ago. "Not known" or "Recording state not known": Sequential did not send the state of the recording with the list. | For "Processing", wait until that time: the list checks again and changes the row. For "Not known", wait a moment: the list asks for the state and changes the row. If it stays, open the session. The player asks for the state. Otherwise see [Sessions](/docs/sessions). |
| The player shows "The recording is still being put together. It should be ready by 14:05.", with the time when it is ready | Sequential has not prepared all the uploads of the recording yet. With the default settings, that time is at most about 6.5 minutes after the last upload. | Wait until that time. Then select **Check again**. |
| The player shows "This recording has expired." | The replay period of the first part of the recording ended. The player also says how long the project keeps recordings. | See [Retention and deletion](/docs/retention-and-deletion). |
| The player shows "This recording can't be played: it was never fully received." | Sequential did not receive the start of the recording, so the player cannot show it. | Check the session's events instead. |
| The player shows "That part of the backend is not available right now." and **Try again** | Sequential could not read the stored recording for a moment. Its answer is 503 `replay_store_unavailable`, "The recording could not be read right now. Retry shortly." | Select **Try again**. |

### Session replay: more detail

- **Platforms.** **Record on** has a box for each of **Web**, **iOS** and **Android**. Uploads that still arrive from a platform that is off get 403 `replay disabled for tenant` or `replay disabled for platform`.
- **Archived project.** It refuses its keys. An owner or admin clicks **Unarchive and take data again** under **Settings** › **Recording & data** › **The project**, or **Unarchive** under **Archived** on **All projects**.
- **PostHog mobile.** PostHog's mobile recorder sends app recordings to Sequential. Sequential's own recorder is for websites.
- **Session replay key.** Sequential SDK and Smartlook installs get the key from Sequential. The project must have a live replay key. Then **Settings** › **Setup** says "Session replay is included in this tag." Without one, **Settings** › **Setup** says that session replay needs a live replay key, with a link to **Keys**.
- **Sampling.** Staging and development projects start at 10 %. Each session gets its decision once, when it starts. Sessions that already have a decision keep it.
- **Short visits.** If the visitor leaves a page before **Shortest session kept**, that page sends nothing.
- **Pages.** `/checkout/**` works. A pattern with `https://` or `?` never matches. If **Record only these pages** has entries, only matching pages are recorded. In a single-page app, recording stops at a denied path until the next full page load.
- **Strict masking.** It masks all text, inputs and most attribute values. It blocks images, SVG, video, audio and iframes. It cuts addresses to their domain.
- **Balanced masking.** You must type the project slug to switch. Mark sensitive elements with `data-sq-mask`.
- **Caps.** When a cap is reached, recording ends for the rest of that page. "Too large" means over the server's upload limit. To keep uploads smaller, block heavy regions with `data-rr-block`.
- **Rate limit.** The 50 MB a minute limit applies unless your server sets another value.
- **Missing recording.** The recording and your events do not share a session id. [Sessions](/docs/sessions) explains how ids are matched. The list stops showing a recording a fixed number of days after its last activity.

### Upload and retention limits

- **Server upload limit.** One upload can be at most 5 MB, unless whoever runs your Sequential server changed it.
- **Upload rate limit per IP address.** The 50 MB a minute limit also applies to each IP address. So testers on one office network share it.
- **Retries.** After a 429, the recorder retries after the time that the answer asks for, or after 30 seconds when the answer gives none. It keeps only its last 5 waiting uploads.
- **When a recording stops playing.** The number of days is **Recordings** under **How long data is kept**, on **Settings** › **Recording & data**. For a new project, it is 30. After it, the **Recording** column of Workbench › **Sessions** shows "Expired".

## DevTools or masking shows less than you expect

| You see | Likely cause | Fix |
|---|---|---|
| In DevTools, a failed image, script or font shows only a domain and █ blocks. You cannot see which file failed | **Strict** masks the path of every file that the page loads. The kind, status and timing stay | Expected under **Strict**. Reproduce the issue in a browser. Or, on a staging project, set **Attribute values (titles, labels, alt text, data-*)** to **Kept, URLs cut to the path** under **Privacy and masking**. See [DevTools](/docs/devtools). |
| In DevTools, a part of an API path shows as █ blocks, such as `/api/orders/███████/items` | **Strict** masks id-like segments of an API call's route | Expected under **Strict**. The route words stay, so you can still see which call failed. |
| An error message or console text shows █ blocks in a path | Under **Strict**, Sequential masks UUIDs, long hex runs and runs of 6 or more digits after a `/` | Expected under **Strict**. |
| A replay shows the value of a checkbox, radio button or drop-down option in the page's HTML | **Balanced** records page markup as it is. Only what users pick or type is masked | Use **Strict**, or put `data-rr-block` on the element. See [Masking and redaction](/docs/masking-and-redaction). |
| 400 `masking_preset_conflict` from PATCH `/api/projects/:id/config` | The request names the preset `strict` and sets `mask_attributes` to `urls` or `off`. Sequential saved nothing | Send the preset `custom` to loosen attribute masking, with `confirm` and the project slug if the change records more. Or leave out `mask_attributes`, or set it to `strict`. |

## Evidence is empty

**Evidence** ranks only judged sessions. The sessions that the judge did not read are in **Not judged**.

| You see | Likely cause | Fix |
|---|---|---|
| "Nothing the judge could read in the 7 calendar days to today." | Every session was too short, is waiting to be read, or the judge could not read it. Sequential judges a session about 30 minutes after its last event. | Read the line under it. Wait, then reload. |
| "No session in the 7 calendar days to today." | Sequential received no session in these days. | See "No events arrive" above. |
| New sessions stay in **Not judged** | Background judging is off. | Read **Background judging**, under **Settings** › **Recording & data** › **What applies**. |
| "Background judging is switched off for this project." | An owner or admin switched it off. | An owner or admin turns on **Judge new sessions automatically** under **Settings** › **Recording & data** › **Judging**. |
| On Evidence: "Judging is off for this project, so new sessions are not judged." | Background judging is switched off for this project. | An owner or admin turns on **Judge new sessions automatically** under **Settings** › **Recording & data** › **Judging**. |
| On **Settings** › **Recording & data**: "Nothing is judged until you accept this trial’s terms." | The project is an [agent trial](/docs/agent-trial), and you did not accept its terms. | Accept the terms. They show in place of the other pages. Accepting them turns **Judge new sessions automatically** on. |
| "Background judging is off for every project on this Sequential server." | The server does not run background judging. | Ask whoever runs your Sequential server. |
| "This Sequential server has no AI key set up, so it can't judge sessions." | The server has no key for the judge. | Ask whoever runs your Sequential server. |
| "Sequential can't tell right now whether background judging is running for this project." | Sequential could not read the project's settings. | Reload the page later. |
| "The judge could not read N sessions. Sequential does not try them again." | The judge returned an error for these sessions. | Nothing. These sessions stay in **Not judged**. |
| **Not judged** never empties | Some sessions never get a judgment. | Send a session id with every event. See [Sessions](/docs/sessions). |
| A session you expect is not listed | Its last event is outside the last 7 days. | Find it on Workbench › **Sessions**. |

The line under the title says why the judge did not read the other sessions: too short, waiting to be read, the judge could not read them, or judging is off. These counts also include sessions that never get a judgment. See [Evidence: the sessions worth a look](/docs/watch).

### Evidence: more detail

- **Turning judging on.** Owners and admins turn on **Judge new sessions automatically** under **Settings** › **Recording & data** › **Judging**. Sequential then also judges the unjudged sessions from the past 7 days.
- **Judging off, with verdicts.** Evidence keeps the sessions that already have verdicts, and new sessions show in **Not judged**. When background judging is switched off for this project, the line under the title says "Judging is off for this project, so new sessions are not judged." When your Sequential server keeps judging off, Evidence does not say so.
- **Older sessions.** Evidence has no window. It always shows the last 7 days.
- **Delay.** Sequential checks every 5 minutes. A busy project adds delay. When the daily allowance runs out, this also adds delay.
- **Counts.** The counts in the line under the title count all sessions in the last 7 days that have no judgment.

These never get a judgment:

- Sessions with fewer than 3 meaningful events. By design, very short sessions stay unjudged.
- Events that have no session id.
- Sessions whose last event was already more than 7 days old when judging reached them.
- Sessions where the judge returned an error.

## One person shows as several users

Each event has one user id: the identify value, or before identify, an anonymous id per browser. See [Users and identity](/docs/users-and-identity).

| Symptom | Likely cause | Fix |
|---|---|---|
| The same person counts as several users | Your app does not identify them. | Call identify at sign-in, and on page load for signed-in people. See [Identify your users](/docs/identify-users). |
| A new user on every page load (Sequential SDK) | The browser blocks storage. | Identify signed-in users on every page load. |
| A person who signs up during a visit appears twice on **People** (Sequential SDK) | The link to the anonymous id can take up to 5 minutes to show. | Wait 5 minutes, then reload. |
| A person who signs up during a visit appears twice on **People** (Amplitude, Pendo or Smartlook) | Sequential joins the two ids only for the Sequential SDK, PostHog or Mixpanel. | None yet. This is a known limitation. |
| Funnels, flows or retention count one person twice | Sequential SDK, PostHog or Mixpanel: the link to the anonymous id can take up to 5 minutes to apply. Amplitude, Pendo or Smartlook: nothing links the two ids. | Sequential SDK, PostHog or Mixpanel: wait 5 minutes, then run it again. Amplitude, Pendo or Smartlook: keep a funnel on one side of identify. |
| One person appears under two values you recognise | Your app passes different values to identify. Sequential does not merge identities. | Pass one value per person. |
| Smartlook: each person appears twice | Only the identify call carries the user id. | See [Moving from Smartlook](/docs/smartlook). |
| Two people show as one on a shared device | The next person keeps the previous user's id. | Call your SDK's reset on sign-out, for example `sequential.reset()`. |

### Identity: more detail

- **Storage.** Sequential stores every event under one user id. After identify, it is the value your app passes.
- **New users from one person.** Before identify, each browser has its own anonymous id. So a second device, a private window or cleared storage makes a new user.
- **Blocked storage.** The browser does not keep the anonymous id between pages.
- **Sign-up during a visit.** Later events go under your id. With the Sequential SDK, PostHog or Mixpanel, **People** lists one user and counts that session once. With Amplitude, Pendo or Smartlook, **People** lists both ids. With every SDK, a funnel across sign-up loses people at that step.
- **Two values.** For example: an email on one screen and an account id on another. Sequential takes the value you pass at face value. Use one identifier for each person. Pass the same value everywhere, every time.
- **Smartlook.** Other events stay under Smartlook's visitor id.

## "This person is not in this project."

The page of a person says this when no event that Sequential keeps has the id, in any dates. Under it, the page says "They may belong to another project, or Sequential has not seen them yet." Check that you have the exact id that your app sends. With the Sequential SDK, PostHog or Mixpanel, an anonymous id that is linked to the person opens the same page.

If **Visits, last 30 days** says "No visit in the last 30 days.", the person had no session in that time. To find older sessions, add a **Person id** condition on Workbench › **Sessions**, and widen the window.

### Person not found: more detail

- The page searches for the exact user id.
- **Visits, last 30 days** always shows the last 30 days. It does not take the window of another page.

## Accounts is empty, or sessions have no account

On Workbench › **Accounts**, a session without an account id is never a row. See [Users and accounts](/docs/users-and-accounts#the-accounts-list).

| You see | Likely cause | Fix |
|---|---|---|
| "No account yet." and "Accounts appear once your site sends an account id with its events." | The project has data, but no account. Accounts come from Pendo and from the Sequential SDK's `sequential.account()`. Group calls from PostHog, Mixpanel and Amplitude are not used for accounts yet. | With the Sequential SDK, call `sequential.account(id)` after sign-in. With Pendo, add `account: { id: … }` next to `visitor` in `pendo.initialize`. |
| "No account matches." and "Clear the plan or the search to see every account.", or a sentence about a health | No account matches your filters in this window. | Clear the plan or the search. |
| "N sessions in the last 30 days carried no account id, so they are in no account here." | These sessions have no account id. **Accounts** counts them, but does not list them. | With Pendo, set the account before the first event on each page. With the Sequential SDK, call `sequential.account()` before those events. Only events sent after that are linked to it. Events from other SDKs have no account id. |
| "Accounts could not be read right now." | Sequential could not read the list. | Click **Try again**, or wait the time that the message gives. |
| "Accounts show by their id because your site sends no account name or plan." | Your app sends no name for the account. | Send a name property, such as `name` or `company_name`, with the account. See [Name and plan](/docs/users-and-accounts#name-and-plan). |

## Try on a session: nothing was judged

**Try on a session** on the **Questions** page judges your draft on one session. See [Customise the questions](/docs/rubric).

| You see | Likely cause | Fix |
|---|---|---|
| "Sequential cannot read the judging budget right now, so nothing was judged or charged. Try again shortly." | Sequential cannot read the allowance of **Try on a session**, so it does not judge. It spends nothing. | Click **Try it** again after about 30 seconds. If it continues, ask whoever runs your Sequential server. |

## Cases: Did the fix work?

**Did the fix work?** on a case shows what the rate did after a release. See [Cases and fixes](/docs/findings).

| It says | Likely cause | Fix |
|---|---|---|
| "No release names F-12 yet. Sequential measures a fix once a release names it." | No release marker for the project's environment names the case. Sequential measures only markers for the project's environment. | Name the case in `finding_ids` of the marker. Check the `environment` that your CI job sends. |
| "Sequential could not check the releases just now." | Sequential could not read the release markers. It does not mean that no release named the case. | Reload the page. |

## Agents: "No call with this token yet."

After onboarding makes a token for your agent, **Check the connection** checks one time if the token was used. If not, the step says "No call with this token yet. Run the setup, ask your agent a question, then check again."

| Likely cause | What to do |
|---|---|
| The agent has not sent a request yet | Restart the agent, so that it reads the new setup. Ask it something. Then press **Check the connection**. |
| The setup went to the wrong place | Use the setup for your agent, with the note under it. Claude Code needs `--scope user`. Cursor reads `~/.cursor/mcp.json`. Codex reads `~/.codex/config.toml`. Claude Desktop reads `claude_desktop_config.json`. |
| Claude Desktop did not read the setup | Quit Claude Desktop and open it again. Its setup runs `npx`, so the computer needs Node.js. |
| The agent uses an old token | Paste the setup again. It must contain the new token. |
| The new token no longer works | The step counts a use only while the token works: not revoked, not expired, and its project not archived. Open **Agents** and use **Connect an agent** to get a new token. |

You can also leave with **Skip for now**. The token stays. Later, when the agent calls Sequential, its card on **Agents** says "Last used" and a time.

If **Agents** cannot read its list, it gives the reason and **Try again**. Zero calls shows "No call in this window." under **What they did**. If Sequential could not read the names of the agents, the page says "Agent names could not be read just now."

## Agents: a fix brief or a finding is refused

By default, a token does not get a fix brief or a finding that Sequential could not fully screen. See [Privacy at a glance](/docs/privacy-overview).

| You see | Likely cause | Fix |
|---|---|---|
| 503 `screen_unavailable` from GET `/api/findings/:n` or `/api/findings/:n/brief` | Sequential could not screen every quoted passage of the finding. The screen is not set up, its daily allowance is used up or it did not answer. Or the finding has more quoted text than the screen reads. | Try again after the `Retry-After` time, 60 seconds. If it continues, ask the operator of your Sequential server. |
| 400 `tool_error` from POST `/api/agent/get_fix_brief` or `/api/agent/get_finding`, or an MCP tool error that says "this server requires screening" | The same cause. | The same fix. |

The app, with a signed-in person, shows the brief also when the screen did not run. The operator can turn off the refusal for tokens with `FINDINGS_SCREEN_REQUIRED=false`. From 11 October 2026, the app does not show the brief when Sequential cannot check it for known people. See [Cases and fixes](/docs/findings).

## A fix brief says "screen paused"

| You see | Likely cause | Fix |
|---|---|---|
| The first lines of the brief say "screen paused, N quoted passages withheld". Each quoted passage reads `[instruction-like text removed]`. | Sequential cannot read the allowance for screening, and the project reached 10 screenings in a minute on this server process. So Sequential did not screen the brief, and it withheld every quoted passage. | Open the case again after a minute, or ask the agent to get the brief again. Sequential does not keep a paused result. |

## Agents: Ask is refused or stops

The tool `ask_sessions` runs **Ask** for an agent. See [Ask: one line about sessions, funnels, retention or people](/docs/ask). POST `/api/agent/ask_sessions` answers with the status below. Through MCP, the refusal is a tool error, and its text is the same JSON. When there is a `Retry-After` header, the JSON also has `retry_after_sec`. Sequential charges nothing to the allowances on a refusal. This includes 502 `ask_failed`: the judge answered for no session, so nothing is charged.

| You see | Likely cause | Fix |
|---|---|---|
| 400 `limit_too_large` | `limit` is more than 50. | Use 50 or less. Continue with `next_cursor`. |
| 400 `bad_query` | The description has a line break or a control character, or it is shorter than 3 characters without double quotes, backticks and extra spaces. | Use one line of 3–200 characters. |
| 402 `budget_exhausted` | The agent allowance of the project is used up, or the first group of up to 8 sessions would go over it. | Try again after `resets_at`, at midnight UTC. The operator can raise `AGENT_DAILY_TOKENS`. |
| 429 `token_daily_limit` | This token used its own daily allowance, or the first group of up to 8 sessions would go over it. | Try again after `resets_at`, at midnight UTC. The operator can raise `AGENT_TOKEN_DAILY_TOKENS`. |
| 429 `ai_concurrency` | Another `ask_sessions` call of this project still runs on this server. | Try again after 10 seconds. Do not send calls at the same time. |
| 503 `ai_busy` | This server process already runs 2 `ask_sessions` calls, of any projects. | Try again after 10 seconds. |
| 503 `ai_unavailable` | Sequential cannot read the allowances, so it does not spend. | Try again after 30 seconds. If it continues, ask the operator of your Sequential server. |
| 503 `ask_unavailable` | Judging is not configured on your Sequential server. | Ask the operator of your Sequential server. |
| 502 `ask_failed` | The judge failed for every session of the page. | Try again. |
| The answer has `stopped`: `"budget"` | A limit ran out during the call, or Sequential could no longer read the limits. `stop_reason` names it. The judge did not check the rest of the page. | Call again with `next_cursor`. For `budget_exhausted` or `token_daily_limit`, call after midnight UTC. For `ai_unavailable`, call again in a minute. A cursor used hours later continues in a list that has changed: some sessions can be skipped or come again. |

A wrong argument, such as `days` over 30 or an unknown `cursor`, is a 400 `tool_error`.

## Agents: too many requests

Sequential limits how often access tokens can call it. See [Limits](/docs/limits).

| You see | Likely cause | Fix |
|---|---|---|
| 429 `rate_limited` | This token sent more than its limit, by default 120 requests a minute. | Wait for the `Retry-After` time. Send fewer requests with this token. |
| 429 `project_rate_limited` | The tokens of this project together sent more read requests than the project read limit, by default 600 a minute. Sequential refuses them only when the operator turned this limit on with `TOKEN_PROJECT_LIMIT_ENFORCE=true`. | Wait for the `Retry-After` time. Send fewer read requests from all the agents of this project. The operator can raise `TOKEN_PROJECT_REQUESTS_PER_MINUTE`. |
| 503 `rate_limit_unavailable` | Sequential cannot count the requests, so it refuses them. | Try again after 30 seconds. If it continues, ask the operator of your Sequential server. |

The token limit refuses the HTTP request, also on `/mcp`. The project read limit refuses each tool call: through MCP, the refusal is a tool error, and its text is the same JSON, with `retry_after_sec`.

## A link says "This link is for a project you can't open"

A link can name its project with `project=`. Links in agent answers do. See [Links that open a project](/docs/sessions-and-replay#links-that-open-a-project).

| You see | Likely cause | Fix |
|---|---|---|
| "This link is for a project you can't open" | You are not a member of the organisation that owns the project. Or the project is archived. Or you are signed in with an account in another organisation. Or the project id in the link is wrong. | Sign in with the account that is a member. Or ask a person in the organisation to invite you. Members and viewers can invite only while **Every member, up to their own role** is chosen under **Settings** › **Organisation**. For an archived project, an owner or admin unarchives it. **Go to your sessions** opens the project that you have selected. |

Sequential never opens another project in place of the one that the link names.

## Agents: claude.ai

See [Connect claude.ai](/docs/connect-claude-ai).

| You see | Likely cause | Fix |
|---|---|---|
| You removed the connector in claude.ai, but the connection still shows under **Agents** | In our tests, claude.ai did not tell Sequential when a connector was removed. The connection stays live, and it counts toward your limit until it goes idle 30 days after claude.ai last renewed it. | Press **Disconnect…** on its card under **Agents**. Every role can do this for its own connections, and an owner or admin for every connection. Every role can also disconnect its own connections under **Settings** › **Agents & tokens** › **Your connections**. If you connected claude.ai again, both connections show on one card, with "2 connections". See [An older connection that stays live](/docs/connect-claude-ai#an-older-connection-that-stays-live). |
| "You have reached your connection limit for this project. …", or the project shows "at your connection limit" | You have 10 connections to this project. Connections that you removed only in claude.ai still count. Connections that are still being set up count too. | Disconnect the connections that you no longer use. A connection that is still being set up shows **Pending**. Press **Cancel…** on it under **Agents**, or wait: it clears within 10 minutes. Every role can cancel its own connection, and an owner or admin any connection. |
| "This project has reached its connection limit. …" | The project has 50 connections, from all people. | An owner or admin disconnects old ones under **Agents**. |
| claude.ai does not follow the instructions of the Sequential server | When we tested it (October 2026), claude.ai did not give the server's instructions to its model. The model does get each tool's description and the answers to its tool calls. | Say in your message what you want claude.ai to do. |
| A call fails with "This connection is paused while its project is archived" | The project is archived. | Unarchive the project. The connection works again. |
| claude.ai stops working after you changed or reset your password | A password change or reset ends every claude.ai connection that you made. | Connect claude.ai again. |
| On **Agents**, a claude.ai connection is under **Revoked and expired** as **Revoked**, and nobody pressed **Disconnect…** | Sequential ended the connection, for example after a password change under **Settings** › **Security**. See [When a connection stops working](/docs/connect-claude-ai#when-a-connection-stops-working). The [Audit log](/docs/audit-log) shows how it ended. | Connect claude.ai again. |
| Under **Connect an agent** or on the onboarding step **Connect your agent**, claude.ai shows "Couldn’t check whether claude.ai is available" and **Retry** | Sequential checks once, when the page loads, that the claude.ai sign-in is on. The check got no answer: a network error, a server error, or no answer within 5 seconds. | Press **Retry**. If it stays, ask whoever runs your Sequential server. |
| Under **Connect an agent** or on the onboarding step **Connect your agent**, claude.ai shows "Not available yet." | Your Sequential server answered that the claude.ai sign-in is off. | Ask whoever runs your Sequential server. |
| In onboarding, "… with a project token, and only owners and admins make tokens." | Your role is member or viewer. Only an owner or admin can create a token for a coding agent. | If the step has a **claude.ai** tab, connect claude.ai there. See [Connect claude.ai](/docs/connect-claude-ai#before-you-start). Claude Code can also connect with a sign-in. See [Connect Claude Code](/docs/connect-claude-code#connect-with-a-sign-in). For a token, ask an owner or admin. |

## Dates differ by one day

Sequential stores times in UTC, and windows are whole UTC days.

- A window of the last N days includes today, as a UTC day.
- The window includes the whole last day, on every view.
- Days on the Workbench › **Events** chart and Workbench › **Retention** cohorts are UTC days.

### Dates: more detail

- The **First day** and **Last day** of a **Custom** window are UTC dates.
- **Some times are converted.** The **Matching events** list on Workbench › **Events** and the table on Workbench › **Sessions** show your local time.
- A chart day runs from midnight to midnight UTC. So evening activity in the Americas counts on the next UTC day.

## Custom event properties are missing

To see what Sequential stored, open Workbench › **Events**. In **Break down by**, pick **Event property…** and type the name of the property. The table lists its values.

[What each SDK supports](/docs/support-matrix) lists which properties each SDK keeps.

| Symptom | Likely cause | Fix |
|---|---|---|
| In the breakdown, but a filter finds nothing | **is** on **Text** matches only the exact text of the whole value. A date and time value matches only with the type **Date**. | Copy the value from the breakdown exactly, or use **contains**. For a number or a date, choose the type **Number** or **Date**. |
| `capture()` throws "… is a reserved event name …" | The Sequential SDK reserves names that start with `$`. | Rename the event. |
| A Sequential SDK event never arrives | Its properties could not become JSON, so the SDK dropped it. | Send strings, numbers and booleans. |
| `register()` properties disappear after a page load | Sequential SDK super properties last only for the page. | Call `register()` on every page load. |
| User properties you set do not appear | The Sequential SDK and PostHog do not store them as user properties. Properties passed on the first `posthog.identify()` do not show anywhere in Sequential. Today, Sequential refuses Mixpanel's `people.set` from the browser. | Read them on the event. With PostHog, use `posthog.setPersonProperties()`. |
| Mixpanel properties that start with `$` are gone | Sequential drops them, except element properties. | Rename them without the `$`. |
| Pendo `track` properties are not on the event | Sequential stores them as user properties. | Filter with **Visitor property**. |
| A URL in a property reads `[redacted]` | Sequential redacts URL query values, except attribution parameters such as `utm_*`. | See [What Sequential keeps from page URLs](/docs/url-policy). |

### Event properties: more detail

- **Filters.** **is** on **Text** matches only the exact text of a value. For a number or a date and time, choose the type **Number** or **Date**.
- **JSON.** Examples of values the SDK cannot turn into JSON: a BigInt, or an object that refers to itself. Sequential stores objects and arrays as JSON text.
- **Mixpanel `$` properties.** Sequential drops them when it stores the event.
- **URLs.** Sequential redacts query values when it stores them.
- **User properties.** Check the support matrix before you rely on user properties.

### Where user properties go

- **Sequential SDK.** It keeps `identify()` properties on the `$identify` event that the call sends. A repeat `sequential.identify()` with the same id and the same properties sends nothing. From 11 October 2026, a repeat with changed properties sends a new `$identify` event with them.
- **PostHog.** Sequential keeps `$set` and `$set_once` only when they arrive on a `$set` event. That event comes from `posthog.setPersonProperties()` or a repeat identify with the same id.
- **Mixpanel.** Sequential refuses `people.set` from the browser today.

## Known limitations

These have no fix yet:

- Amplitude batching (`useBatch`) does not reach Sequential.
- Only the Sequential SDK, PostHog or Mixpanel joins a visitor's events from before identify to the identified user. With Amplitude, Pendo or Smartlook, the two ids stay two users on every page.
- Sequential refuses Mixpanel's `people.set` from the browser.

## Limits
- On the routes of the browser and mobile SDKs, Sequential refuses automated requests, such as a headless browser, a test runner, curl or a server-side SDK. To send events from your own server, use the [backend SDK](/docs/backend-sdk).
- Staging and development projects start with **Share of sessions recorded** at 10 %. Raise it to record every session.
- The 50 MB a minute upload limit also applies to each IP address. Testers on one office network share it.
- By default, a recording stops playing 30 days after its first part arrived.
- Sequential never judges sessions with fewer than 3 meaningful events, sessions older than 7 days when judging reaches them, or sessions where the judge failed.
- With Amplitude, Pendo or Smartlook, a funnel across sign-up loses people at that step. Nothing links the ids from before and after identify.
- The **Event property** filter matches only the event's own properties.

## A sign-in page stops you

| You see | Fix |
|---|---|
| "You were signed out after 7 days without use." | Sign in again. From 21 October 2026, a sign-in ends 7 days after you last used Sequential. |
| "You were signed out after 30 days." | Sign in again. From 21 October 2026, a sign-in ends 30 days after you signed in, even when you use Sequential every day. |
| "This reset link cannot be used" | Click **Ask for a new link**. |

## Sequential cannot be reached

When you open a page that needs your sign-in, the app first asks Sequential who you are. If Sequential does not answer within 4 seconds, or answers with an error, the page says "Sequential can't be reached right now". Sequential does not sign you out, and the address of the page stays. Click **Try again** to load the page again. If your sign-in ended in the meantime, **Try again** or a reload in the browser opens the **Sign in** page. If it keeps happening, write to support@usesequential.com.

## Need help

If this page does not solve your problem, write to support@usesequential.com.

## Related

- [Check your install](/docs/verify)
- [Recording settings](/docs/recording-settings)
- [Session replay (web)](/docs/session-replay)
- [Sessions](/docs/sessions)
- [Evidence: the sessions worth a look](/docs/watch)
- [Identify your users](/docs/identify-users)
- [Users and identity](/docs/users-and-identity)
- [Filters, date ranges and saved views](/docs/filters-and-saved-views)
- [What each SDK supports](/docs/support-matrix)
- [Limits](/docs/limits)
