# Export your data

> Owners and admins can export one project's events and sessions as NDJSON or CSV files, in the app or with an access token. See what the files hold, the limits and how long Sequential keeps them.

> **In short**
>
> - Owners and admins can export the events and sessions of one project. Members and viewers cannot.
> - One export covers a range of days in UTC, in one format: NDJSON or CSV, each file gzipped. It always holds the events files, the sessions files and **manifest.json**.
> - Start an export in **Settings** › **Data out**, under **Export a date range**. Or use the API with an access token that has the scope `exports:write`.
> - An export holds personal data. Sequential removes nothing from it: user ids, account ids, full IP addresses, URLs and properties are in the files as Sequential stores them.
> - If your account has two-factor authentication (2FA), Sequential asks for a code when you start an export. A download never asks for a code.
> - Sequential keeps the files for 7 days after the export finishes. From 23 October 2026, the storage then keeps an older version of each file for up to 8 more days. No one can download it. You can start 3 exports of a project each day (UTC).

## Before you start

- **Your role.** You must be an owner or admin of the organisation. Members and viewers also see **Data out**, but **Export a date range** shows only "Only owners and admins can export data, because an export holds personal data." Its **Export data…** button is off.
- **A code, if you have 2FA.** If your account has 2FA, Sequential asks for a code from your authenticator app, or a backup code, when you start an export. It does not ask if you entered a code in this sign-in in the last 15 minutes, for example when you signed in. A trusted device does not count. If you do not have 2FA, Sequential does not ask for a code.
- **Data that Sequential still keeps.** An export holds only the days that Sequential still keeps under the organisation's events retention period. The range also cannot start before the day of the project's first event. The form says: "Both days are included. Sequential can only export what it still keeps for this project." On Sequential's hosted service, the period is 7 days, unless Sequential support set a longer one for your organisation. See [A server-wide limit](/docs/retention-and-deletion#a-server-wide-limit).
- **A safe place for the files.** The files hold personal data. Decide where you keep them before you download them.

## Start an export

1. Go to **Settings** › **Data out**.
2. Under **Export a date range**, set **First day (UTC)** and **Last day (UTC)**. The days are in UTC, and the export includes both days. At first, the form shows the last 7 days: **First day (UTC)** is 6 days before today, and **Last day (UTC)** is today.
3. Under **Format**, choose **NDJSON (one JSON object per line)** or **CSV**. At first, NDJSON is selected. Each file is gzipped. See [What an export holds](#what-an-export-holds).
4. Click **Export data…**.
5. Read the warning: "**This export holds personal data.**" It names the project, the days and the format, and says that anyone with a download link can read the files until the link expires.
6. Click **Yes, export this personal data**.
7. If Sequential asks for a code, enter the code from your authenticator app, or a backup code, in **Code**. Then click **Continue**. The export then starts. You do not have to click **Export data…** again.

Every export holds both the events and the sessions. You cannot choose only one of them.

The new export shows under **Exports of the last 30 days**, with the status **Waiting**. The export runs on the Sequential server, so you can close the page. While an export waits or runs, the page reads the list again every 4 seconds.

Sequential refuses a new export in two cases. Under the form, the page says why:

- "An export of this project is already waiting or running. When it is done, start the next one." An export of this project shows **Waiting** or **Writing**.
- "This project already started 3 exports today (UTC), the most for one day. Try again in 5 hours." 3 exports of this project started today (UTC). Exports that failed count too.

**Follow the export.** **Exports of the last 30 days** shows the exports of the project from the last 30 days, newest first. Each row shows the range, for example "8 Oct 2026 to 15 Oct 2026", the format and the status. A line under it says when the export was asked for and by whom, for example "Asked 5 minutes ago by Ana." An export that a token started shows "by an access token".

| Status | What it means | What the row also shows |
|---|---|---|
| **Waiting** | The export waits for its turn. The exports of all projects on the server wait in one queue. | "Waiting to start: it is next.", or its place, for example "Waiting to start: 2 exports are ahead of it on this server." |
| **Writing** | Sequential reads the data and writes the files. | "Sequential is writing the files." |
| **Ready** | The files are ready. See [Download the files](#download-the-files). | The row counts, for example "120,000 events and 4,000 sessions ready to download.", the files, and "The files are removed 24 Oct 2026, 14:02." |
| **Failed** | The export stopped. It made no files. | The reason. See [Messages](#messages) |
| **Removed** | Sequential deleted the files. | "The files were removed 7 days after the export. Start a new one to get the data again." |

To try a failed export again, start a new export with the same days and the same format. It counts toward the 3 exports of the day.

## Download the files

1. In **Exports of the last 30 days**, find an export that shows **Ready**. It lists its files, each with its rows and its size, for example "Events, part 1", and **Manifest (file list and checksums)**.
2. Next to a file, click **Download**. Your browser downloads the file.
3. Do step 2 for each file. Also download the manifest, **manifest.json**. It lists the files with their row counts and their SHA-256 checksums.

- Each click asks Sequential for a new link. A link works for up to 24 hours. The page says, for example, "events-0001.csv.gz is downloading. The link works until 14:02; ask for a new one any time."
- A download does not ask for a 2FA code.
- Every owner and admin can download every export of the project. This includes the exports that another person or an access token started.
- The sizes are in decimal units: 1 MB is 1,000,000 bytes.
- The [Audit log](/docs/audit-log) records each link as "downloaded a data export of" the project. It never records the link itself.
- Sequential keeps the files for 7 days after the export finishes. The line under the export gives the date, for example "The files are removed 24 Oct 2026, 14:02."

## What an export holds

One export is one project, one range of UTC days and one format. It always holds two sets of files and **manifest.json**:

| File | What it holds |
|---|---|
| `events-0001.ndjson.gz`, `events-0002.ndjson.gz`, … | One row for each event whose time is in the range |
| `sessions-0001.ndjson.gz`, … | One row for each session whose first event is in the range |
| `manifest.json` | The export id, the project id, the format, the range and the time of the snapshot. For each file: its rows, its size, its SHA-256 checksum, and its first and last day |

In CSV, the names end in `.csv.gz`.

- Each data file is compressed with gzip. **manifest.json** is plain JSON. Its times are ISO 8601 in UTC, for example `2026-10-17T12:23:18.285Z`.
- Sequential starts a new file when the next part would take the file over 1,000,000 rows. It also starts a new file after a file reaches 256 MiB compressed.
- Each CSV file starts with its own header line.
- A set with no rows still has one file, so you always find both sets.
- Times are in UTC. The range starts at 00:00 UTC on the first day and stops at the end of the last day (UTC).

> **Sequential removes nothing from an export**
>
> An export holds the values as Sequential stores them. This includes user ids, account ids, full IP addresses, page URLs, element selectors, and the event, visitor and account properties that your app sent. If your app sends emails or names as ids or properties, the files hold them. Sequential does not hide names, emails or phone numbers in an export. Treat the files as personal data. For what Sequential removes when it receives data, see [Privacy at a glance](/docs/privacy-overview#what-sequential-removes-automatically).

### Columns of the events files

The events files have these columns, in this order:

- `time_create`, `event_type`, `event_name`, `source`, `session_id`, `user_id`, `account_id`, `url`
- `utm_referer`, `utm_source`, `utm_medium`, `utm_campaign`, `utm_term`, `utm_content`
- `selector`, `platform_os`, `browser`, `country_code`, `user_ip`, `release`
- `event_props_s`, `event_props_n`, `event_props_b`, `event_props_dt`
- `visitor_props_s`, `visitor_props_n`, `visitor_props_b`, `visitor_props_dt`
- `account_props_s`, `account_props_n`, `account_props_b`, `account_props_dt`
- `ingested_at`: the time when Sequential stored the event

The columns that end in `_s`, `_n`, `_b` and `_dt` hold the text, number, true or false, and date properties. The files have no project column: **manifest.json** names the project.

### Columns of the sessions files

The sessions files have these columns, in this order:

- `session_id`, `first_time_create`, `last_time_create`, `event_count`, `user_count`, `first_event_type`, `last_event_type`
- `user_id`, `account_id`, `source`, `event_name`, `platform_os`, `browser`, `country_code`, `user_ip`, `url`, `utm_referer`
- `visitor_props_s`, `visitor_props_n`, `account_props_s`, `account_props_n`

From `user_id` to `account_props_n`, each value is the latest value in the session.

### What is not in an export

An export holds only events and sessions. It does not hold the **People** list, the accounts list of **Workbench** › **Accounts**, cases, session recordings, heatmap data or AI judgments. The events and sessions files hold the user ids, the account ids and the properties that those lists show.

### NDJSON or CSV

**NDJSON**

- Each line is one JSON object, for one row.
- The values are as Sequential stores them. A time is text in UTC, with no `T` and no `Z`, for example `2026-10-08 14:02:11.123`. `ingested_at` has whole seconds, for example `2026-10-08 14:02:12`. A count is a number.
- `null` and empty text stay different.
- A property column is a list of name and value pairs, for example `[{"name":"plan","value":"pro"}]`. A column with no properties is `[]`.

**CSV**

- The first line of each file is the header. The lines end with CR LF.
- A time is ISO 8601 in UTC. `time_create` has milliseconds, for example `2026-10-08T14:02:11.123Z`. `ingested_at` has whole seconds, for example `2026-10-08T14:02:12Z`.
- An empty cell is `null` or empty text. To tell them apart, use NDJSON.
- A property column is one cell with a JSON object as text, for example `{"plan":"pro"}`. True or false properties are `true` or `false`. Date properties are ISO text.
- A text cell that starts with `=`, `+`, `-`, `@`, a tab or a carriage return gets a `'` in front of it. This stops a spreadsheet from running the cell as a formula. Number, time and property cells do not change. NDJSON files do not change.

### Which sessions an export holds

- A session is in the sessions files when its first event is in the range. A session that started before the first day is not in them, also when it has events in the range.
- The row of a session counts all of the events that Sequential has stored for the session, also the events after the range. For example, `last_time_create`, `last_event_type` and `event_count` include them. **manifest.json** states this rule too.

### The events files are a snapshot

The events files hold the events that Sequential stored before the export started to run (**Writing**). Events that arrive later are not in them, also when their time is in the range. **manifest.json** gives this time as `as_of`. The sessions files have no such limit. They show the sessions as Sequential has them when it writes the files.

## Limits

These are the default limits.

| Limit | Value | What you see |
|---|---|---|
| Exports of one project in a day | 3 a day (UTC), counted from 00:00 UTC. An export that failed counts. A request that Sequential refused does not count | "This project already started 3 exports today (UTC), the most for one day. Try again in …" The API answers 429 `export_daily_limit` |
| Exports of one project at a time | 1 that waits or runs | "An export of this project is already waiting or running. When it is done, start the next one." The API answers 409 `export_in_progress` |
| Exports that wait on the server | 20, for all projects together | "Too many exports are waiting on this server now. Try again in 5 minutes." The API answers 503 `export_queue_full` |
| Estimated size of one export | 10 GiB. Sequential counts 112 bytes for each event in the range, so the limit is about 95 million events | "That range holds about … events, more than one export can hold. Choose fewer days." The API answers 422 `export_too_large` |
| Files that one export writes | 12 GiB compressed | **Failed**, with "The files were larger than one export can hold. Choose fewer days." |
| Time to make one export | 4 hours | **Failed**, with "The export took too long. Choose fewer days, or try again later." |
| Range | UTC days, first and last day included. The last day is today or earlier. At most 366 days. Only days that Sequential still keeps | A message under the days. The API answers 400 `invalid_export_request` or 422 `range_before_retention` |
| List and status reads | 60 a minute, for each person or token, in each project | The API answers 429 `rate_limited` |
| Download links | 30 a minute, for each person or token, in each project | "Too many export requests in the last minute. Try again in a minute." The API answers 429 `rate_limited` |
| Requests with one access token | 120 a minute, for all routes together | The API answers 429 `rate_limited` |
| Files of an export | Kept for 7 days after the export finishes | **Removed**. The API answers 410 `export_expired` |
| One download link | Works for up to 24 hours | Ask for a new link |

If Sequential cannot count a limit, it refuses the request and asks you to wait. It never lets the request through.

## Use the API with an access token

A script can start an export, read its status and get the file links with an access token. The token needs the scope `exports:write`.

**Create the token.** Only an owner or admin can create it.

1. Go to **Settings** › **Agents & tokens**. Find **Make a token**.
2. Enter a **Name**. In **Expires**, choose **In 30 days**, **In 90 days** or **In 365 days**.
3. Under **What it is for**, choose **Custom**. Under **It may**, tick **exports data**. Its scope is `exports:write`.
4. Tick "I understand this token can export this project’s data, people’s details included, out of Sequential."
5. Click **Make the token**.
6. If Sequential asks for a code, it says "To make this token, enter a code from your authenticator app, or one of your backup codes." Enter the code in **Code** and click **Continue**. Sequential then creates the token.
7. Click **Copy token**. The app says "This is the only time Sequential shows this token." Then click **Done, I have saved it**.

- Sequential asks for a code if your account has 2FA, and this sign-in did not pass a code in the last 15 minutes.
- No preset includes `exports:write`. Choose it with **Custom**.
- claude.ai and other agent connections never get `exports:write`.
- If **It may** does not list **exports data**, exports are not on for your Sequential server.
- The token works only for its own project.
- At each call, Sequential checks that the person who created the token is still an owner or admin of the organisation. If not, the call gets 403 `export_creator_not_admin`. Other owners and admins can still download the exports that the token started.
- A call with the token needs no 2FA code.
- The [Audit log](/docs/audit-log) names the person who created the token.

**Call the API.** Send the token in the header `Authorization: Bearer sq_pat_…`. In each path, `<project id>` is the id of the token's project.

| Method and path | Body | Answer |
|---|---|---|
| POST `/api/projects/<project id>/exports` | `{"from": "2026-10-01", "to": "2026-10-07", "format": "csv"}`. All three fields are necessary. `format` is `ndjson` or `csv` | 202 `{"export": {…}}`, with `state` `queued` |
| GET `/api/projects/<project id>/exports` | None | 200 `{"exports": […]}`: the exports of the last 30 days, newest first, at most 100 |
| GET `/api/projects/<project id>/exports/<export id>` | None | 200 `{"export": {…}}` |
| GET `/api/projects/<project id>/exports/<export id>/files/<file name>` | None | 200 `{"url": "…", "expires_at": "…"}`. The file name is a `name` from `files`, or `manifest.json` |

After the POST:

1. Read the status until `state` is `ready` or `failed`. Wait some seconds between two reads. The limit is 60 reads a minute.
2. For each file in `files`, and for `manifest.json`, ask for a link.
3. Download each `url` before its `expires_at`. The link needs no token.

Each request for a link makes a new link and a new audit log entry.

### The export object

| Field | What it holds |
|---|---|
| `id` | The export id |
| `state` | `queued`, `running`, `ready`, `failed` or `expired` |
| `format`, `from`, `to` | The format, and the first and last UTC day |
| `queue_position` | While `queued`: its place in the queue of the server. 1 is the next to run. Otherwise `null` |
| `created_at`, `started_at`, `completed_at`, `expires_at` | ISO times in UTC, or `null`. `expires_at` is when Sequential deletes the files |
| `files` | For each data file: `name`, `table`, `rows` and `bytes`. `manifest.json` is not in the list |
| `rows` | `events` and `sessions`: `null` before the first part, the rows read so far while `running`, and the totals when `ready` |
| `error` | When `failed`: `export_too_large`, `export_read_budget`, `export_timeout`, `export_interrupted` or `export_failed`. Otherwise `null` |
| `requested_by` | `{"kind": "member", "id": …}` for a person, or `{"kind": "token", "id": …}` for a token |

Replace each value in angle brackets, and put your token in TOKEN.

```sh
API="https://api.usesequential.com"
TOKEN="sq_pat_…"          # your access token
PROJECT="<project id>"

# 1. Start an export of 1 to 7 October 2026 (UTC), as CSV.
curl -s -X POST "$API/api/projects/$PROJECT/exports" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"from":"2026-10-01","to":"2026-10-07","format":"csv"}'
# The answer holds the export id: {"export":{"id":"<export id>","state":"queued",…}}

# 2. Read the status. Do this again until "state" is "ready" or "failed".
curl -s "$API/api/projects/$PROJECT/exports/<export id>" \
  -H "Authorization: Bearer $TOKEN"

# 3. Ask for a link to one file. Do this for each file in "files", and for manifest.json.
curl -s "$API/api/projects/$PROJECT/exports/<export id>/files/events-0001.csv.gz" \
  -H "Authorization: Bearer $TOKEN"
# The answer: {"url":"<link>","expires_at":"<time>"}

# 4. Download the file from the link. The link needs no token.
curl -s -o events-0001.csv.gz "<link>"
```

## Messages

In the app:

| You see | Cause | What to do |
|---|---|---|
| "Only owners and admins can export data, because an export holds personal data." | Your role in the organisation is member or viewer. | Ask an owner or admin to export the data. |
| "An export of this project is already waiting or running. When it is done, start the next one." | An export of this project shows **Waiting** or **Writing**. | Wait until it shows **Ready** or **Failed**. |
| "This project already started 3 exports today (UTC), the most for one day. Try again in 5 hours." | 3 exports of this project started today (UTC). Exports that failed count. | Start the next export after 00:00 UTC. |
| "Too many exports are waiting on this server now. Try again in 5 minutes." | 20 exports wait on the server. | Wait for the time that the message gives. Then click **Export data…** again. |
| "That range holds about 120,000,000 events, more than one export can hold. Choose fewer days." | The estimated size is more than 10 GiB. | Choose fewer days. To get all the days, make two or more exports. |
| "Sequential keeps events from 10 Oct 2026 on for this project. Choose a first day on or after it." | The first day is before the first day that Sequential keeps. | Choose that day or a later day. |
| "The last day can be today (17 Oct 2026, UTC) at the latest." | The last day is after today (UTC). | Choose today or an earlier day. |
| "The first day must be on or before the last day." | The last day is before the first day. | Change one of the days. |
| "Enter the first day as a date." or "Enter the last day as a date." | The day is not a real date. | Enter the day again. |
| "Choose at most 366 days." | The range is longer than 366 days. | Choose fewer days. |
| "Sequential could not check this request just now. Try again in a moment." | Sequential could not do one of its checks, for example the 2FA check. | Wait a few seconds. Then click **Export data…** again. |
| "Sequential could not check how far back this project keeps events. Try again in a moment." | Sequential could not read the first day that it keeps. | Wait a few seconds. Then try again. |
| "Sequential could not count the events in that range just now. Try again in a moment." | Sequential could not make the size estimate. | Wait a few seconds. Then try again. |
| "The files were larger than one export can hold. Choose fewer days." | The export failed: its files grew past 12 GiB compressed. | Make two or more exports with shorter ranges. |
| "Sequential could not read the range within the limits of one export. Choose fewer days." | The export failed: one part of the range needed more than the read limit of Sequential. | Choose a shorter range. |
| "The export took too long. Choose fewer days, or try again later." | The export failed after 4 hours. | Choose a shorter range. |
| "The server stopped while it wrote the export. Start it again." | The export stopped two times before it finished, for example because a server restarted. | Start the export again. |
| "The export failed. Start it again." | The export failed for another reason. | Start the export again. |
| "Too many export requests in the last minute. Try again in a minute." | You asked for more than 30 links, or more than 60 reads, in one minute. | Wait one minute, then click **Download** again. |
| "The files of this export were removed. Start a new export." | The files were deleted. | Start a new export. |

From the API, each refusal has a code in `error`:

| Code | Status | Cause | What to do |
|---|---|---|---|
| `invalid_export_request` | 400 | A field of the body is wrong. `field` names it. `message` says why, for example "to: on or before today (2026-10-17, UTC)" or "from: at most 366 days before to". | Correct the field. |
| `range_before_retention` | 422 | `from` is before the first day that Sequential keeps. `held_from` gives that day. | Send `held_from` or a later day as `from`. |
| `export_too_large` | 422 | The estimated size is more than 10 GiB. `rows` and `projected_bytes` give the estimate. | Split the range into two or more exports. |
| `export_in_progress` | 409 | The project has an export that waits or runs. `export_id` names it. | Wait until that export is `ready` or `failed`. |
| `export_daily_limit` | 429 | 3 exports of this project started today (UTC). `limit` is 3. `retry_after` gives the seconds until 00:00 UTC. | Wait until 00:00 UTC. |
| `export_queue_full` | 503 | 20 exports wait on the server. `retry_after` is 300. | Wait 5 minutes. |
| `export_retention_unknown`, `export_precount_unavailable` or `TWO_FACTOR_CHECK_UNAVAILABLE` | 503 | Sequential could not do a check: the first day that it keeps, the size estimate, or the 2FA check. | Wait 5 seconds. Then send the request again. |
| `TWO_FACTOR_STEP_UP_REQUIRED` | 403 | A signed-in person with 2FA started an export, and this sign-in did not pass a code in the last 15 minutes. The message is "Enter a code from your authenticator (or a backup code) to export data". A token never gets this code. | Enter a code in the app. Then try again. |
| `export_not_ready` | 409 | You asked for a link, but the export is not ready. `state` gives its state. | Wait until `state` is `ready`. |
| `export_expired` | 410 | Sequential deleted the files. | Start a new export. |
| `not_found` | 404 | The export id is unknown or belongs to another project, or the file is not in the export. A token also gets it for a project that is not its own. | Check the ids and the file name. |
| `rate_limited`, with `retry_after` | 429 | More than 60 list and status reads, or more than 30 links, in one minute. | Wait for `retry_after` seconds. |
| `export_limit_unavailable` | 503 | Sequential could not count the reads or the links. | Wait for `retry_after` seconds. |
| `rate_limited`, with `retry_after_sec` | 429 | More than 120 requests with this token in one minute. The message is "Too many requests for this access token. Try again shortly." | Wait for `retry_after_sec` seconds. |
| `rate_limit_unavailable` | 503 | Sequential could not count the requests of the token. | Wait for `retry_after_sec` seconds. |
| `invalid_token` | 401 | "The access token is unknown, revoked or expired". Sequential also gives this code when the project is archived. | Create a new token, or restore the project. |
| `insufficient_scope` | 403 | "This token lacks the exports:write scope" | Create a token with `exports:write`. |
| `export_creator_not_admin` | 403 | "The person who created this token is no longer an owner or admin of this organization." | Ask an owner or admin to create a new token. |
| `export_check_unavailable` | 503 | Sequential could not check the person who created the token. `retry_after` is 5. | Wait 5 seconds. |
| `forbidden` | 403 | A signed-in member or viewer called the API. | Ask an owner or admin. |
| `export_disabled` | 404 | Exports are not on for this Sequential server. | Ask the team that runs the server. |

Each answer that asks you to wait has the header `Retry-After`, in seconds. Some answers also give the seconds in the body: `retry_after` for the export limits and checks, and `retry_after_sec` for the limit of the token.

## How long Sequential keeps exports

| What | How long Sequential keeps it |
|---|---|
| The files of an export | 7 days after the export finishes. Then the export shows **Removed**, and Sequential gives no more links: the API answers 410 `export_expired`. Sequential deletes each file 7 to 8 days after it wrote the file |
| The files of a failed export | Sequential deletes the parts that it wrote. It keeps no files |
| The record of an export: the range, the format, the status, who started it, the file names, the row counts and the sizes | Until the project is deleted. The app and the API list only the exports of the last 30 days. The record holds no data from the files and no link |
| The files that you downloaded | Sequential cannot delete your copies. Delete them when you no longer need them |

- **Delete a project.** Sequential deletes the export files of the project at once. If that fails, it tries again about every hour. The export records go with the project.
- **Delete an organisation.** Sequential deletes the export files of its projects later, with a check that runs about every hour. The export records go with the organisation.

The [Audit log](/docs/audit-log), under **Settings** › **Organisation**, records each step of an export:

| Entry | Recorded when |
|---|---|
| "started a data export of" the project | Sequential accepts an export. The entry names the person, or the person who created the token, with the range and the format. |
| "finished a data export of" the project | The files are ready. The entry gives the row counts, the number of files and the size. |
| "could not finish a data export of" the project | The export stops before it finishes. The entry gives the reason when Sequential knows it. |
| "downloaded a data export of" the project | Someone asks for a link to a file. The entry names the file. |

## Related

- [Data retention and deletion](/docs/retention-and-deletion)
- [Roles and permissions](/docs/roles-and-permissions)
- [Two-factor authentication and account security](/docs/two-factor-and-security)
- [Audit log](/docs/audit-log)
- [Limits and defaults](/docs/limits#programmatic-access)
- [Privacy at a glance](/docs/privacy-overview)
