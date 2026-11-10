# Data retention and deletion

> How long Sequential keeps each kind of data, what archiving and deleting do to it, and what is not possible yet: per-person deletion and per-person export.

> **In short**
>
> - Sequential keeps events for the organisation's events retention period: 7, 30, 90, 180 or 365 days. The default is 365 days. Sequential sets the period for all the projects of an organisation. A project has no retention setting of its own.
> - Identity links have no expiry. Under a [server-wide limit](#a-server-wide-limit), a daily run deletes them once they are older than the events period plus 8 days.
> - Recordings stop playing after the organisation's replay period. The default is 30 days. The storage deletes the recording files about 2 days after the period ends.
> - Heatmap data is shown for the replay period. It can stay stored up to about a week longer, but Sequential never shows it after the period.
> - When you delete a project, its data becomes unavailable at once. Sequential permanently deletes it within 14 days with the default schedule. Deleting an organisation does the same for each of its projects.
> - When you delete a project or an organisation, its recordings become unreadable at once, because Sequential deletes their encryption keys. The storage deletes the recording files later.
> - Sequential cannot delete or export one person's data today. Owners and admins can export the events and sessions of a whole project. You can download the export files for 7 days after the export finishes. Then Sequential deletes them. See [Export your data](/docs/export-your-data).
> - A shorter period applies only to events and recordings that arrive after the change. Older events and recordings stay, and you can still see them, until their own period ends. Under a server-wide limit, older judgments, feedback, identity links, Ask searches and cases go at the next daily run.
> - A Sequential server can set one limit, shorter than these periods, for every project on it. Sequential's hosted service has a limit of 30 days, and each organisation keeps 7 days there unless support gives it more. See [A server-wide limit](#a-server-wide-limit).

## What it is for

This page answers questions from your privacy notice, your data protection officer (DPO) or a security questionnaire.

For how many of your users come back, see [Retention](/docs/retention).

### Questions this page answers

- "How long do you keep events and session recordings?"
- "A customer has asked us to delete their data. Can we?"
- "Can we get a copy of our data?"
- "We are closing our staging app. Can we stop collecting and keep its history?"
- "What happens to the data if we delete the project?"

## How long Sequential keeps data

| Data | How long Sequential keeps it |
|---|---|
| Events (for example page views, clicks and custom events), with the full IP address, and the user, session and account records Sequential builds from them | The organisation's events retention period, counted from when each event arrived. See [The events retention period](#the-events-retention-period) |
| Identity links: the link between a visitor and the value you passed to `identify()` | No expiry. Under a [server-wide limit](#a-server-wide-limit), a daily run deletes them once they are older than the events period plus 8 days |
| Session recordings, as something you can play | The organisation's replay period, counted from when the first part of the recording arrived at Sequential. The default is 30 days |
| Session recordings, as stored files, with the DevTools data recorded with them | The replay period, and about 2 days more. Then the storage deletes them automatically |
| Heatmap data: counts of where sampled visitors click and scroll, an hourly pointer to one recording of each page, and from 11 October 2026 the session ids of rage clicks on each element. See [Heatmap data](/docs/privacy-overview#heatmap-data) | Shown for the replay period. Stored up to about a week more: Sequential deletes it one week at a time |
| A heatmap page picture, made from one recording. Sequential's hosted service makes these pictures with its builder service. See [The page picture](/docs/privacy-overview#the-page-picture) | At most 15 minutes, and never longer than its recording |
| Export files: the events and sessions of a project that an owner or admin exported. See [Export your data](/docs/export-your-data#how-long-sequential-keeps-exports) | You can download them for 7 days after the export finishes. Sequential deletes them within about 1 more day |

- The audit log keeps each team member's IP address and browser with no expiry. Only deleting the organisation removes it. The exception is the entry for a deleted project: see [Delete a project](#delete-a-project).
- Sequential does not store a copy of the payload that your SDK sent. It stores the event that it builds from it.

### How long Sequential keeps judgments, feedback, the audit log and brief deliveries

| Data | How long Sequential keeps it |
|---|---|
| Judgments: the AI judge's answers about a session. See [Judgments](/docs/judgments) | About 400 days after the session ends |
| Your organisation's audit log, with the IP address and browser of the team member who acted | 400 days after each entry, from 23 October 2026. Sequential also deletes the log when an owner deletes the organisation |
| Sequential's record that an organisation was deleted. See [Delete an organisation](#delete-an-organisation) | No expiry. After 90 days, Sequential removes the names, the slug, the IP address and the browser from it |
| The audit log entry for a deleted project | 400 days, or earlier when the organisation is deleted. After 90 days, Sequential removes the project name, the IP address and the browser from it |
| Your team's **Right** or **Wrong** on a judgment or on an **Ask** match, and who gave it. For an **Ask** match, it also holds the first 200 characters of the search. See [Feedback and calibration](/docs/feedback-and-calibration) | About 400 days after it was given |
| The answers of **Judge this recording now**: the judge's answers for one session, without the digest. See [Reading an AI verdict](/docs/reading-verdicts) | Up to 7 days, in a cache. Sequential also deletes them when you delete the project or the organisation |
| Feedback that you send to the Sequential team. See [Send feedback to the Sequential team](/docs/send-feedback) | 2 years after the item closes. Sequential keeps an open item |
| **Ask** searches: the text typed, who searched (for an agent, the id of its token) and how many sessions matched. See [Ask: one line about sessions, funnels, retention or people](/docs/ask) | About 180 days. Sequential keeps the results for up to an hour |
| The fix brief delivery log: one row each time Sequential delivers a fix brief | 400 days after the delivery, by an automatic expiry |
| The agent call log: one row each time an agent tool answers a token with success, with the tool, the token and counts. `record_release` writes no row. A token's GET `/api/findings/:n/verification` runs `get_verification`, so it writes a row too. It holds no visitor text. Sequential writes it on a best-effort basis, so a missing row does not prove that no answer was given. See [Privacy at a glance](/docs/privacy-overview) | 400 days, by an automatic expiry |
| The record of each export: its range, format and state, who started it, and the names, row counts and sizes of its files. See [Export your data](/docs/export-your-data) | No expiry. It goes when the project or the organisation is deleted. **Settings** › **Data out** shows the exports of the last 30 days |
| Release markers | No expiry |
| Usage counts: events and sessions per day, recordings per day, AI calls and tokens per day, and (from 11 October 2026) stored bytes per day | No expiry. They stay after a project is deleted |
| The record of each AI call: time, feature, model and token counts, with no text | 25 months |
| The database's own query log | 7 days |

These periods are fixed, except the 90 days and the 400 days of the audit log, which a self-hosted server can change. A value of the 400 days below 365 does not apply, and the 400 days stay. Without a server-wide limit, the events retention period does not change them. Under a limit, judgments, feedback and Ask searches go sooner: see [A server-wide limit](#a-server-wide-limit). See also [AI and third parties](/docs/ai-and-third-parties).

### What the brief delivery log holds

Sequential writes a row when it delivers a fix brief: through the REST API (this includes POST `/api/agent/get_fix_brief`), through MCP `get_fix_brief`, or in the app. MCP `get_finding` writes no row. If Sequential refuses a brief to a token because it could not screen it, it delivers nothing and writes no row.

Each row holds:

- the project, the case number and the brief's revision and template version
- the screening state (clean, removed, partial, not screened or withheld), its reason and how many passages Sequential removed or withheld
- how the brief was delivered: REST, MCP or the app
- the access token's id, or nothing if a signed-in person got the brief
- when Sequential delivered the brief

An automatic expiry removes each row 400 days after the delivery. Sequential writes the log on a best-effort basis. If it cannot write a row, it still delivers the brief. So a missing row does not prove that no brief was delivered.

## The events retention period

Each organisation has an events retention period. It applies to all the projects of the organisation, also to the projects that you add later. It is one of 7, 30, 90, 180 or 365 days. The default is 365 days.

Only Sequential support can change it. Sequential support can set a period with an end date. After the end date, the default applies again. Your audit log records each change as `organization.limits_changed`. See [Audit log](/docs/audit-log). For a longer period, write to support@usesequential.com.

To see the period that applies, open **Settings** › **Recording & data**. Under **Data and your team**, **How long data is kept** shows it as **Events**, for example "7 days". **The settings that apply, as JSON**, under **What applies**, shows it as `events_retention_days`.

From 14 October 2026, a project has no retention period of its own. A period that was saved for a project before that date stays in its settings, but it does not apply. Owners and admins cannot change the period through the settings API: see **A retention change through the API** below.

- The period counts from when the event arrived at Sequential. It does not count from the time in the event.
- Sequential deletes events one week at a time, once a day. So Sequential keeps each event for at least the period, and for up to about a week longer.
- The user, session and account records use the same period. Sequential deletes them by whole weeks, so a record can stay up to about a week longer than the events that it was built from. When a session's events are deleted, the session goes from **Evidence** and **Workbench** › **Sessions**.

> **The events period can be shorter than the replay period**
>
> If the events retention period is 7 days and the replay period is 30 days, the session goes from **Evidence** and **Workbench** › **Sessions** after about a week. You can no longer find its replay there.

### When the events retention period changes

Sequential stamps each event with the period that is in force when the event arrives.

- **A longer period** applies only to events that arrive after the change. Events that are already stored keep their old period.
- **A shorter period** applies to new events at once. It deletes nothing. The stored events keep their old period, and the pages and agents still show them until that period ends. This is also true when a period with an end date ends.
- **Under a server-wide limit**, a shorter period also deletes older judgments, feedback, identity links, Ask searches and cases at the next daily run. See [A server-wide limit](#a-server-wide-limit).

### A retention change through the API

The GET and PATCH answers of `/api/projects/:id/config` show the periods that apply:

- `retention_source` is `organisation`.
- `org_retention` has `events_days` and `replay_days`: the periods that apply to new data.
- `effective` has the same values as `events_retention_days` and `replay_retention_days`.
- `config` keeps the periods that were saved for the project. They do not apply. Where one differs, `clamps` has an entry with `reason` `org_limit`.

A PATCH that changes `events_retention_days` or `replay_retention_days` from the saved value saves nothing. Sequential answers 409 with:

- `error`: `retention_set_by_organisation`
- `message`: "Sequential sets the retention periods for the organisation. A project setting cannot change them. For a longer period, write to support@usesequential.com."

This is also true for a longer period, and for a change by Sequential support on the project. Send the two values as `config` has them, and the other changes save as usual. The app has no control for the periods. If it gets the 409, it shows the message.

## The replay period

Each organisation has a replay period, next to its events retention period. It applies to all the projects of the organisation. It is one of 7, 30, 90, 180 or 365 days. The default is 30 days.

Only Sequential support can change it, also with an end date, as for the events period. To see the period that applies, open **Settings** › **Recording & data**. **How long data is kept** shows it as **Recordings**, for example "7 days". **The settings that apply, as JSON** shows it as `replay_retention_days`.

- The period counts from when each part of a recording arrived at Sequential. Sequential puts the parts of a recording that arrive in the same 5-minute period together, and counts from the start of that 5-minute period.
- When the period of the first part of a recording ends, the whole recording expires. You cannot play any part of it anywhere in Sequential. If the period became shorter during the recording, a later part can stop playing earlier.
- About 2 days after the period ends, the storage deletes the recording files, with the DevTools data in them.
- Heatmap data follows the replay period too. Sequential deletes it one week at a time, so it can stay stored up to about a week longer. It is never shown after the period: **Workbench** › **Heatmaps** and the API stop showing a day's data when that day's recordings stop being viewable. A shorter period deletes no stored heatmap data.

### What Sequential shows after the period

The session stays in **Evidence** and **Workbench** › **Sessions** while Sequential keeps its events.

- When the replay period ends, the session's card says "Recording expired", and a table says "Expired". If you open the replay, the player says "This recording has expired.", then for example "Recordings are kept 30 days in this project. This session is older, so its recording is gone."
- Only the end of the replay period shows "Expired". A recording that Sequential never received in full shows "No playable recording". This is not related to retention.
- Up to about a week after the period ends, Sequential removes its index of the recording. Then the session reads "No recording".

See [Find and replay sessions](/docs/sessions-and-replay).

### When a recording setting changes

Each part of a recording keeps the replay period that was in force when it arrived at Sequential.

- **A longer period** applies only to the parts that arrive after the change. A session that is recording during the change can have parts with the old period and parts with the new period.
- **A shorter period** applies to new parts at once. It deletes nothing. The stored parts keep their old period, and you can play them until that period ends.

Recording settings work the same way. For example, if you make masking stricter or turn off a DevTools capture such as **Console message text**, the change applies only to what Sequential records after it. What is already stored stays as it was recorded. See [Recording settings](/docs/recording-settings).

## A server-wide limit

A Sequential server can set one retention limit for every project on it. The limit is 7, 30, 90, 180 or 365 days. A server without a limit changes nothing on this page. Sequential's hosted service, the preview, has a limit of 30 days. There, every organisation keeps events and recordings for 7 days, unless Sequential support gives it a longer period, up to 30 days. With 7 days, events stay 7 to 14 days, and the storage deletes recording files 9 days after they are written. Sequential support can exempt the events of an organisation's projects from the limit: see below.

When the server has a limit:

- **The shorter period applies.** For events, recordings and heatmap data, the period that applies is the shorter of the organisation's period and the limit. If the limit is lifted, the organisation's period applies to data that arrives after that. Data that was already deleted does not come back.
- **The settings API shows the limit.** The answer shows the period that applies under `effective` and `org_retention`. When the limit makes a period shorter, the answer also has a `clamps` entry with `reason` `deployment_cap`.
- **Data goes in weekly blocks.** Sequential deletes data one week at a time. So with a limit of 7 days, events stay 7 to 14 days, and up to about 1 day more until the daily deletion runs. Data stored before the limit was set goes on the same schedule. This includes heatmap data and its hourly pointers to recordings.
- **Recording files go sooner.** The storage deletes each recording file 2 days after the shorter of the replay period and the limit, counted from when the file was written. This includes files written before the limit was set.
- **More data is deleted.** Sequential also deletes judgments, **Right**/**Wrong** feedback, identity links and Ask searches. With the default schedule, once this data is older than the organisation's events period plus 8 days, a daily run deletes it. Here the events period is the period in force now, under the limit. The daily run also deletes each case that was last seen before then, with its verdicts, links, verification results and hand-off records. For example, with the preview's default period of 7 days, this is 15 days. With a period of 30 days, it is 38 days.
- **Runtime issues follow the replay period.** Runtime issues (the errors and failed requests that cases are built from) normally go at the end of the replay period that they arrived with. As a backstop, once a runtime issue is older than the organisation's replay period plus 8 days, a daily run deletes it.
- **A shorter period applies to this data at once.** If Sequential support makes a period shorter, or a period with an end date ends, the next daily run deletes this data by the new period. Events keep the period that they arrived with.
- **If Sequential cannot read the periods,** the daily run deletes this data by a period of 7 days, never by the limit.
- **Usage counts stay.** The usage counts, the record of each AI call, release markers, the fix brief delivery log, the agent call log and the audit log keep the periods in the tables above.

A self-hosted server sets the limit with `RETENTION_MAX_DAYS`: 7, 30, 90, 180 or 365, or unset for no limit. It sets the default period of every organisation with `ORG_RETENTION_DEFAULT_DAYS`, one value for both events and recordings: 7, 30, 90, 180 or 365. Unset, the defaults are 365 days for events and 30 days for recordings. Any other value of either setting stops the server from starting.

### Organisations that Sequential support exempts

Sequential support can exempt an organisation from the limit, for example the organisation of a demo project. The exemption applies to all its projects, also to the projects that you add later. Only Sequential support can set or remove an exemption. While the limit is shorter than 365 days, Sequential support cannot remove an exemption, because the removal would delete the data that the exemption keeps. For the projects of an exempt organisation:

- **Events keep the organisation's period.** Events, and the user, session and account records built from them, stay for the organisation's events retention period.
- **Other data is kept for up to about 373 days.** Judgments, **Right**/**Wrong** feedback, identity links, Ask searches and cases do not go at the limit. With the default schedule, Sequential deletes them when they are older than 365 days plus 8 days, or earlier if their own period in the tables above is shorter.
- **Recordings stay under the limit.** Recordings, heatmap data and runtime issues follow the organisation's replay period, under the limit.
- **Settings show the longer events period.** For example, **How long data is kept** shows **Events** "365 days".
- **The audit log records each change** as `organization.retention_cap_exempt_changed`, by "Sequential support". Entries from before 13 October 2026 show `project.retention_cap_exempt_changed`. From 19 October 2026, the entry reads "lifted the retention cap on the organisation's data", or "put the organisation's data back under the retention cap". See [Audit log](/docs/audit-log).

### What Settings shows under a limit

Under **Settings** › **Recording & data** › **Data and your team**, **How long data is kept** shows each period that applies, after the limit: **Events** and **Recordings**. **The settings that apply, as JSON** also shows the periods that apply.

When the limit makes a period shorter than the organisation's, a line under them says why. For example: "Events kept for: 7 days applies. This server keeps at most 7 days, whatever a project stores (365 days here)."

### Identity links under a limit

When Sequential deletes an identity link, the visitor's anonymous id is no longer linked to the value you passed to `identify()`. Their later events show under the anonymous id until your app calls `identify()` for them again. For up to about 5 minutes after a link is deleted, Sequential can still use it.

> **Some project settings are not applied**
>
> **Properties dropped**, **Properties hashed** and **IP addresses**, under **Data and your team**, say "Saved; nothing applies it yet." **The settings that apply, as JSON** shows them as `ip`, `property_denylist` and `property_hash`. Sequential does not act on them. Sequential stores the full IP address with every event. It does not remove or hash any property.

## Archive or delete a project

Owners and admins can archive or delete a project.

| | Archive | Delete |
|---|---|---|
| Ingest keys | Refused until you unarchive | Removed |
| Recording | Off | Off, because the keys are gone |
| The project in the app | Hidden from the project switcher. **Archived projects**, under **Settings** › **Recording & data**, lists it. So does **Archived** on **All projects** | Gone from the organisation, with its recording settings and questions |
| Reading its data | Sequential keeps its sessions, cases and settings, and the members of the organisation can still read them through the API. The app does not open an archived project: the switcher leaves it out, and a link to it is refused. Its access tokens and agent connections pause. Background judging and the checks for new cases skip it | Nobody |
| Events, and the user, session and account records | Kept. They come back when you unarchive, except data whose period ended while the project was archived | Unavailable at once. Permanently deleted within 14 days with the default schedule |
| Judgments, feedback, Ask searches, identity links, release markers and the other stored data | Kept | Unavailable at once. Permanently deleted with the events |
| Usage counts: events, sessions and recordings per day, and a record of each AI call | Kept | Kept. They hold no user, session or event identifiers |
| Recording files | Kept | Unreadable at once, because Sequential deletes their encryption keys. The storage deletes the files later. After you delete a project, the app shows the date by which they are removed |
| Export files | Kept. They still go 7 days after the export finishes | Deleted at once. If Sequential cannot delete them, it tries again about every hour |
| Undo | **Unarchive and take data again**, or **Unarchive** | None |

To stop collecting and keep the history, archive the project. Do not delete it. To stop only recordings, turn off **Record sessions**.

### Archive a project

1. Go to **Settings** › **Recording & data** › **The project**.
2. Click **Archive this project…**.
3. Click **Archive and stop all data**. To keep the project as it is, click **Keep it running**.

While the project is archived, Sequential refuses all data that your app sends. Sequential does not store it for later. Archiving does not pause any period.

### If a period ends while a project is archived

Archiving does not pause any of the periods on this page. If a period ends while the project is archived, that data is gone or does not play after you unarchive the project.

### Restore an archived project

1. Go to **Settings** › **Recording & data**.
2. If the archived project is open, click **Unarchive and take data again** under **The project**. Otherwise, expand **Archived projects**, and click **Unarchive** next to the project.

Or open **All projects** from the project switcher. Under the organisation, expand **Archived**, and click **Unarchive** next to the project.

The same keys work again. You do not need to change your install.

### Delete a project

When you delete a project, Sequential records a deletion for the data it stores about the project: events and the records built from them, judgments, feedback, Ask searches, identity links, release markers, runtime issues, the fix brief delivery log, heatmap data and the index of its recordings.

- With the default schedule, Sequential permanently deletes them within 14 days: the deletion job runs once a week, and Sequential allows one more week in case a run fails. After you delete the project, the app shows the exact date.
- If their retention period ends first, they go at that time.
- Sequential marks the deletion done only when none of the rows are left in storage.
- Sequential deletes the project's export files at once, and the records of its exports with the project. If it cannot delete the files, it tries again about every hour.
- For up to about a minute after you delete a project, a page that is still open can deliver heatmap data. Sequential deletes it with the rest of the project's data.
- The audit log entry for the deletion stays. After 90 days, Sequential removes the project name, the IP address and the browser from it.

Sequential keeps the project's usage counts after the deletion. These are the number of events for each day and source, the number of sessions for each day, the number of recorded sessions for each day, the number and size of the stored recording parts for each day, and a record of each AI call: its time, feature, model and token counts, also added up for each day. From 11 October 2026, they also include the storage size of the project's recordings for each day, and of its other tables that are kept for each project, such as judgments and identity links. The size of its events is not counted for each project. They keep the project's id, but no user, session or event identifiers and no text.

Sequential deletes the encryption keys of the project's recordings at once. So the recordings become unreadable at once, and no page in Sequential serves them. Every Sequential server refuses the keys within 60 seconds of the delete, even if Sequential cannot tell its other servers. A part of a recording that a server is already reading can finish. The storage deletes the recording files later, about 2 days after the end of their replay period. After you delete the project, the app shows the date by which the files are removed. This date is Sequential's own upper limit, not a promise from the storage provider. The storage usually removes the files before that date. If Sequential found no recordings for the project, the app shows no date for them. A backup of Sequential's key store can keep a copy of the keys until that backup expires.

A heatmap page picture is encrypted with the same keys, so it also becomes unreadable at once. Sequential also removes the stored pictures and the waiting picture requests of the project.

### Delete an organisation

Deleting an organisation deletes each of its projects, and Sequential records the same deletion for each one as for a project delete. You do not need to delete the projects first. The recordings of each project become unreadable at once, as when you delete a project. The app does not show a date for the recording files.

Nobody can download the export files of its projects after the delete. Sequential deletes these files later, with a check that runs about every hour. The records of the exports go with the organisation.

Deleting an organisation also deletes its audit log. Copy what you need from the [Audit log](/docs/audit-log) first.

Before Sequential deletes the organisation, it reads the ingest keys of its projects, so that it can stop them on every server after the delete. If Sequential cannot read them, it refuses the delete and changes nothing. The page then shows "The organisation was not deleted: it could not be prepared. Try again."

Then Sequential writes its own record of the deletion. If Sequential cannot write this record, it refuses the delete and changes nothing. The page then shows "The organisation was not deleted: its deletion could not be recorded. Try again."

Sequential also writes a record of the organisation's id. If the organisation started a test checkout in the past, the record also holds the payment provider's ids. If Sequential cannot write this record, it refuses the delete and changes nothing. See [Payments](/docs/privacy-overview#payments).

> **Where these deletions run**
>
> Sequential's hosted service runs the deletions on this page: the retention drop for events and recordings, and the erasure after a delete. A self-hosted backend runs them only when its configuration enables them (`RETENTION_DROP_DATABASES` for the retention drop and the deletions under a [server-wide limit](#a-server-wide-limit), `ERASURE_DATABASES` for erasure). A deletion recorded while erasure is not enabled is kept, and it is carried out when erasure is enabled.

### Steps to delete a project or an organisation

**Delete a project**

1. Go to **Settings** › **Recording & data** › **The project**. An archived project also has a delete button under **Archived projects**, and under **Archived** on **All projects**.
2. Click **Delete <project>…**, with your project's name.
3. Type the project's slug in the field "Type `web-shop`, the project’s slug, to confirm".
4. Click **Delete <project> for good**.

The text must match exactly. A space at the end keeps the delete button unavailable.

From 8 November 2026, after step 2 the box shows a line, for example "Deleting Acme removes it from the organisation." Under it, a list says what happens: Keys, Data, Analytics data, Recordings and Kept. Kept names the audit log entries about the project and the usage counts for billing. The audit log entries stay for 400 days. After 90 days, Sequential removes the project name, the IP address and the browser from the entry of the delete. The full text of the box is under Read the full text ▾.

**Delete an organisation**

Only the owners of an organisation can delete the organisation.

1. Go to **Settings** › **Organisation** › **Delete the organisation**.
2. Click **Delete <organisation>…**, with your organisation's name.
3. Type the organisation's name in the field "Type <organisation> to confirm".
4. Click **Delete <organisation> for good**.

Spaces before or after the organisation's name do not matter.

**Confirm that it is you**

From 27 October 2026, a delete of a project or an organisation needs a recent proof that it is you, because you cannot undo a delete. If you gave no proof on this device in the last 10 minutes, Sequential deletes nothing yet:

- If you use two-factor authentication, a code form opens: "To delete <project>, enter a code from your authenticator app, or one of your backup codes. It counts for 10 minutes on this device." Enter the code and click **Continue**. Then Sequential does the delete. You do not click the delete button again. A sign-in with a code in the last 10 minutes is also a proof.
- If you do not use two-factor authentication, the page says, for example: "Sign in again, then delete this project: this needs a sign-in from the last 10 minutes." Click **Sign in again**. This signs you out on this device. After you sign in, delete the project or the organisation again.
- If Sequential cannot do the check, the page says "Sequential could not check your sign-in just now. Try again in a minute." Sequential deletes nothing.

### What else deleting a project or an organisation does

**Project**

- A new project with the same name or slug starts empty. It does not get the old data back.
- Sequential never gives the id of a deleted project to a new project, in any organisation.
- Sequential records the deletion in the [Audit log](/docs/audit-log). After 90 days, Sequential removes the project name, the IP address and the browser from that entry. It keeps the project id, the account that deleted it and the time.

**Organisation**

- Sequential removes the organisation's members, invitations, projects and keys.
- Sequential deletes the organisation's audit log, with the records of any project deletions.
- Sequential keeps its own record of the deletion. The record holds the organisation's name and slug, the name and id of each of its projects, and the account that deleted it. It also holds the IP address and browser of the delete request, when Sequential has them.
- This record is not part of the organisation's audit log. No page in the app shows it. From 23 October 2026, Sequential deletes the record 400 days after the deletion.
- After 90 days, a daily job removes the organisation's name and slug, the project names, the IP address and the browser from the record. It keeps the ids, the account that deleted the organisation, the times and the state of the deletion. A self-hosted server can change the 90 days with `DELETION_RECORD_RETENTION_DAYS`.

## What is not possible yet

- **No per-person deletion.** If someone asks you to delete their data, Sequential cannot delete one person's data for you today.
- **No immediate deletion of recording files.** After you delete a project or an organisation, its recordings are unreadable at once. But the storage deletes the files only about 2 days after the end of their replay period.
- **No partial deletion.** To delete judgments, feedback, Ask searches or identity links, you must delete the project or the organisation.
- **No per-person export.** You cannot export the data of one person.

Base your privacy notice and your answers to data requests on the tables above. A person can ask you for a copy of their data. Then you can export the project and look for their user id in the files. See [Export your data](/docs/export-your-data).

## Before you describe this to your users

- **Quote your organisation's events retention period for events.** If your server sets a shorter [limit](#a-server-wide-limit), quote the limit. Say that Sequential can keep an event for up to about a week longer than that.
- **Say that identity links have no expiry,** unless your server sets a limit.
- **Send only what you are prepared to keep.** You cannot remove property values or the value you pass to `identify()` from a project that you keep. See [Identify your users](/docs/identify-users).

### More advice for your privacy notice

- **Treat the replay period as the time when recordings stop playing.** The storage deletes the files about 2 days later.
- **Limit what recordings capture.** Keep **Strict** masking. Leave **Console message text** off unless you know what your app logs. See [Masking and redaction](/docs/masking-and-redaction).

## Limits

- Sequential deletes events one week at a time. An event can stay for up to about a week after its retention period.
- After you archive or delete a project, delete an organisation or revoke a key, every Sequential server stops accepting the keys at once. If Sequential cannot tell its other servers, for example because Redis is down, another server can accept data sent with the keys for up to a minute.
- After you unarchive a project, every server accepts its keys again at once. If Sequential cannot tell its other servers, another server can refuse the keys for up to 10 seconds, and can keep recording off for up to 30 seconds.
- Revoking a key does not remove the data already sent with it.
- After you delete a project, every Sequential server forgets its recordings' keys at once. If Sequential cannot tell its other servers, for example because Redis is down, another server still refuses the keys within 60 seconds. A part of a recording that a server is already reading can finish. No page serves the recordings after the delete.
- A server removes a recording key from its memory about 11 minutes after it last used the key.
- If a server cannot check a recording key, for example because its database is down, it refuses the key. The player then shows an error with **Try again**. Sequential deletes nothing because of this.
- Files of recordings already past their period can stay in storage for about 2 days.
- Stricter masking or a turned-off capture applies only to new recordings. Stored recordings stay as they were recorded.
- The fix brief delivery log can miss deliveries. A missing row does not prove that Sequential delivered no brief.

## Related

- [Privacy at a glance](/docs/privacy-overview)
- [Export your data](/docs/export-your-data)
- [Organisations and projects](/docs/organisations-and-projects)
- [Roles and permissions](/docs/roles-and-permissions)
- [Recording settings](/docs/recording-settings)
- [Masking and redaction](/docs/masking-and-redaction)
- [Audit log](/docs/audit-log)
