# Organisations, projects and keys

> An organisation is your company or team. A project is one app or site inside it, with its own ingest keys, data and settings.

> **Key facts**
>
> - An organisation holds your teammates, roles, invitations, two-factor requirement and audit log. Roles apply to every project in it.
> - Use separate projects for production and staging, and for unrelated products.
> - Ingest keys are public: anyone who copies one can send data. Server keys are secret.
> - To replace a key, rotate it, deploy the new key, then revoke the old one. Always keep one live Session replay key.
> - You can undo an archive but not a delete. A project delete permanently deletes the project's events within 14 days with the default schedule.

## What they are

1. An organisation owns your projects and teammates. See [invitations](/docs/sign-up-and-invitations), the [two-factor requirement](/docs/two-factor-and-security) and the [audit log](/docs/audit-log).
2. A project's settings are its own. For example, the recording settings and the questions are per project.
3. A source is the channel that data arrives through, for example PostHog or Session replay. Every new project gets one ingest key for each source.
4. A list of [allowed origins](#allowed-origins) stops other websites from using an ingest key in their visitors' browsers. Rotation stops only the copy that you found.

There are no per-project roles. So a project does not limit who in your organisation can see its data. See [Roles and permissions](/docs/roles-and-permissions).

## When to create separate projects

Use one project for data that you want to analyse together.

### Which data goes in which project

Give data that you want to keep apart its own project.

| Situation | Suggestion |
|---|---|
| Production and staging of the same app | Separate projects. Test traffic stays out of your production reports. |
| Your app and a marketing site that you report on together | One project |
| Two unrelated products | Separate projects |
| Settings that must differ, for example console text captured in staging but not in production | Separate projects. Recording settings and the questions are per project. |

### Add a project: the steps

Owners and admins can add a project.

1. In the project switcher, at the top of the left rail, click **New project** (the organisation shows next to it, for example "in Acme").

2. In **Name**, enter the name of the project.

3. Optional: in **Slug**, enter a slug. If you leave it empty, Sequential makes the slug from the name.

4. In **Environment**, choose Production, Staging or Development (the form starts on Production).

5. Click **Create project**. To stop, click **Cancel**.

Result: Sequential says "Project <name> created". The new project is on All projects and in the switcher.

Sequential does not open it. To open it, choose it in the switcher. Its install snippet is then on Settings › Setup.

### The New project form in detail

- Or open All projects and click New project next to the organisation.
- Under the fields, the form says that a project is one app or site, with its own ingest keys for every source.
- If you click New project for an organisation that is not open, Sequential first opens a project of that organisation.
- An organisation with no live project shows No project yet in the switcher. Owners and admins click it to open the same form.

| Message | Where | What it means | What to do |
|---|---|---|---|
| "That slug is already taken." | New project | The slug is taken. | — |
| "Use lowercase letters, digits and single dashes for the slug (up to 60 characters)." | New project | Sequential cannot use the slug for another reason. | — |

## Environments

Every project has one of three labels: production, staging or development. The label does not change what Sequential records. The environment does not separate data inside a project. For that, use separate projects.

The label does two things:

- A release that you record without an environment gets the project's label.
- When you [compare a point](/docs/events-explorer#compare-a-point-with-the-usual-day) in Events, the releases that it shows are those of the project's label.

Every new project starts with replay sampling at 100 %. For projects made before 1 November 2026, see [What replay sampling does a new project get?](#what-replay-sampling-does-a-new-project-get)

## Sources and ingest keys

Ingest keys look like `sq_posthog_…`. A key works only for its own source.

Each tab of the install snippet on Settings › Setup already contains the right key. The exception is Pendo. See [Install Sequential](/docs/install).

A server key is for the [backend SDK](/docs/backend-sdk), which sends events from your own server. Unlike an ingest key, it is a secret: never put it in a web page or an app. The Server keys section on Settings › Keys lists the keys. Owners and admins create and revoke them.

From 8 November 2026, Ingest keys and Server keys on Settings › Keys each start with one line. Rows follow the line. Members, admins and owners see them. Viewers see no keys, so they see no rows. The old note is under "Read the full text ▾".

| Row | Ingest keys | Server keys |
|---|---|---|
| The line | "An ingest key tells Sequential which project the data belongs to." | "A server key lets your own servers send events as this project, with the backend SDK." |
| Secret | "No. Pages and apps send it with their events." | "Yes. Sequential shows it once, when it is made; then only its label and last 4 characters." |
| "Lives in" | "Your site’s snippet, or your app’s SDK setup" | "Your server’s environment, never a page" |
| "Managed by" | "Owners and admins create, rotate and revoke keys. Members, admins and owners can copy the whole key; viewers do not see it." | "Owners and admins make and revoke server keys. Members see each key’s label and last 4 characters; viewers do not." |
| "Revoking" | "Stops everything that sends with it, at once. It cannot be undone." | No row |

### What a key can and cannot do

- An ingest key can send data into its project.
- An ingest key can read the project's recording settings.
- An ingest key cannot read your analytics.
- An ingest key is not a login or API credential.

### Which key each install uses

The sources are Sequential, PostHog, Mixpanel, Amplitude, Pendo, Smartlook and Session replay. Sequential refuses a key that it gets from a different source, even when the key belongs to your project. For example, Sequential refuses a Session replay key in a PostHog setup. It also refuses a PostHog ingest key that arrives at Mixpanel's endpoint.

| You install | Key it uses |
|---|---|
| Sequential SDK | Sequential. It fetches the Session replay key itself. |
| PostHog, Mixpanel or Amplitude on the web | That source's key. The optional replay line uses the Session replay key. |
| PostHog's mobile SDKs | PostHog, for events and replay |
| Smartlook | Smartlook. Replay starts on its own with the project's Session replay key. |
| Pendo | Your own Pendo API key, registered with the project. The optional replay line uses the Session replay key. |
| Session replay on its own | Session replay |

## Allowed origins

A project can have a list of allowed origins, such as `https://app.example.com`. Then Sequential refuses data that a browser sends from any other site. The list does not stop a script or a server, which can send any origin.

The list is empty by default, and an empty list allows every origin. Only owners and admins can change the list.

An origin is the scheme, the host and the port. The list takes exact origins only, with no wildcard and no path.

1. Go to **Settings › Recording & data › Who may send data**.

2. In **Allowed sites**, enter each site that runs your snippet, one per line, for example `https://shop.example.com`.

   Result: Under the box, Where data came from in the last 7 days lists the sites that sent events. Each site has "Allow" or "Allowed". With a list, it says what the list would have refused. From 8 November 2026, it says it in a headline, for example "120 of 3,400 events would have been refused by this list." The line under it has parts such as "Last 7 days, rolling" and "From 2 of 5 sites". The old sentence is under How counted ▾.

3. Click **Save changes**.

4. If Sequential asks "Refuse events from these sites?" and names them, click **Save and refuse them**, or **Cancel**.

Result: Sequential says "Saved as version N. Recorders pick it up on their next fetch, usually within a few minutes."

### How the allowed-origins check works

Keys ship in your site's HTML or your app, like any analytics key. Unless your project has a list of allowed origins, Sequential does not check which site or app a key comes from. So anyone who copies a key can send data into your project.

The check:

- With a list, Sequential refuses data that a browser sends from any other site, with 403 `origin_not_allowed`.
- Sequential reads the browser's `Origin` header. When there is none, it reads the origin of the `Referer`.
- It also refuses `Origin: null`. A browser sends it from a sandboxed iframe, a `data:` page and some privacy modes.
- Pages whose address is not a web address, such as `file:`, `data:` and `about:` pages, are refused by any list.
- It allows a request with no `Origin` and no `Referer`, for example from a server, `curl` or a mobile SDK. So the list stops other websites from using your key in their visitors' browsers.
- The check applies to every request that sends data from a browser or an app, not to the requests that read settings. It does not apply to the [backend SDK](/docs/backend-sdk).
- The Sequential SDK stops sending after a 403 `origin_not_allowed`, for the rest of that page load, and writes one warning to the console. The next page load tries again.
- If Sequential cannot read the list, it refuses the data with 503 `config_unavailable` and `Retry-After: 30`. It never treats an unreadable list as empty.

The list and its editor:

- Each line must be an origin only. Sequential ignores empty lines and lines that repeat. The list takes at most 200 sites.
- The check before you save reads the page addresses of the events of the last 7 days. It checks the 50 sites with the most events, and says how many more sites it did not check. If the list refuses sites that sent events in the last 7 days, Sequential asks "Refuse events from these sites?" and names them.
- From 8 November 2026, when the list would refuse events, the preview under the box has a headline and a line under it. The headline counts the events that the list would have refused, of all the events from the listed sites and from pages with no web address. An example: "120 of 3,400 events would have been refused by this list."
- From 8 November 2026, the line under the headline starts with the period, for example "Last 7 days, rolling". Then it says where the refused events came from, for example "From 2 of 5 sites", "From 2 of 5 sites and pages with no web address" or "From pages with no web address". When the count leaves out events, the line also says "Events without a page not counted", "Other sites with fewer events not counted" or "Events without a page and other sites with fewer events not counted". Other sites are the sites after the 50 with the most events.
- From 8 November 2026, the old sentence, "With this list, Sequential would have refused …", is under How counted ▾. For members and viewers, How counted ▾ shows open.
- Events with no page address, for example from a server or a mobile app, are not affected, and Sequential says how many there were.
- To remove the list, delete all the lines and click Save changes.
- Other roles see the list, but only owners and admins can change it.
- If someone else saved the project's settings after you opened the page, Sequential names them, and Load the newest version shows their version.
- Sequential saves the whole settings document, with the version that you loaded. Your [audit log](/docs/audit-log) records the change.

#### Messages of the Allowed sites box

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Use the origin only, without a path or a trailing slash." | Allowed sites | A line has a path, or a slash at the end. Sequential also shows the origin. | — |
| "Wildcards are not allowed: list each site." | Allowed sites | A line has a wildcard. | — |
| "Write a site like https://app.example.com." | Allowed sites | A line has other text. | — |
| "Empty accepts data from any site." | Allowed sites (the box help) | An empty list allows every origin. | — |
| "120 of 3,400 events would have been refused by this list." | Where data came from in the last 7 days | From 8 November 2026, an example of the headline: the events that the list would have refused, of all the events from the listed sites and from pages with no web address. | — |
| "With this list, Sequential would have refused 120 events from 2 sites (…)" | Where data came from in the last 7 days | An example of what the list would have refused. From 8 November 2026, this sentence is under How counted ▾, under the headline. | — |
| "Every site that sent data is on the list." | Where data came from in the last 7 days | Every site that sent events is on the list. | — |
| "Refuse events from these sites?" | After Save changes | The list refuses sites that sent events in the last 7 days. Sequential names them. | Click Save and refuse them, or Cancel. |
| "Saved as version N. Recorders pick it up on their next fetch, usually within a few minutes." | After the save | Sequential saved the list. | — |
| "You are a member: you can read these settings; owners and admins change them." | Settings › Recording & data, for other roles | An example of the line for a role that cannot change the list. | — |

## Rotate or revoke a key

Keys are under Settings › Keys › Ingest keys. Members can copy keys. Owners and admins can also rotate and revoke them.

If someone copies a key, rotate the key, then revoke the old one. The new key is also in your page, so someone can copy it too.

> **Keep one live Session replay key**
>
> Always keep one live Session replay key. The Sequential SDK and Smartlook fetch this key themselves. If you revoke the only one, their replay stops and Sequential shows no warning.

### Replace a key without losing data

1. Next to the key, click **Rotate**.

   Result: Both keys work until you revoke the old key. The old key shows Old key.

2. Copy the new key. Sequential shows the whole new key only until you click **Done**.

3. Deploy the new key that you copied.

   Result: Until you revoke the old key, Settings › Setup still shows the old key.

   **If you rotate the Session replay key and use the Sequential SDK or Smartlook**

   There is nothing to deploy. Sequential gives them the project's oldest live Session replay key. So they keep using the old key until you revoke it.

   After you revoke it, new page loads switch to the new key within about a minute. Pages that are already open keep sending with the old key, and Sequential refuses it.

4. When your app sends data with the new key, click **Revoke old key…**.

5. Type the last 4 characters of the old key.

6. Click **Revoke key**.

Result: Sequential refuses anything sent with the old key from then on.

The Old key mark and Revoke old key… show only while the page stays open. If you left the page, revoke the old key with Revoke… next to it: type its last 4 characters, then click Revoke key.

### Revoke a key now

Revoking is permanent. An app that still uses the key loses data until it ships a new key.

1. Next to the key, click **Revoke…**.

2. Type the last 4 characters of the key.

3. Click **Revoke key**.

Result: Sequential refuses anything sent with the key from then on.

### Rotation edge cases

When you revoke a key, every Sequential server stops accepting it at once. If Sequential cannot tell its other servers, for example because Redis is down, another server can accept the key for up to a minute.

On Settings › Keys:

- To keep both keys working after you rotate, click Keep both.
- The page lists live keys by their last use, most recent first. A key that you rotate in has the label "rotated" and today's date.
- Owners and admins see Create key for a source with no live key. They choose the source in New key for.
- Members can only copy a key. Rotate and Revoke… are for owners and admins.
- The Used … note on a key also updates when a recorder fetches its settings. So the note shows only that something uses the key. It does not show that events arrive. To check for events, use Setup. See [Check your install](/docs/verify).

## Pendo API keys

If you use [Pendo](/docs/pendo), Pendo's agent sends data with your own Pendo API key. So owners and admins must register that key with the project.

- A Pendo API key registers to one project only, so production and staging need different keys.
- Sequential shows no Rotate on a registered Pendo API key.
- Revoking one is permanent: no project can register a revoked Pendo API key again while the project that revoked it exists.

From 8 November 2026, Pendo API key on Settings › Keys starts with the line "Already using Pendo? Register the API key from your Pendo snippet, so Sequential knows those events are yours." Rows follow the line. Members, admins and owners see them. The old note is under "Read the full text ▾".

| Row | What it says |
|---|---|
| Secret | "No. Pendo’s agent sends it with your events." |
| "Lives in" | "Your Pendo snippet. Settings › Keys lists it under Ingest keys, masked to its last 4 characters." |
| "Managed by" | "Owners and admins register and revoke it. Members, admins and owners can copy the whole key there; viewers do not see it." |
| "Revoking" | "Stops the events sent with it, at once. It cannot be undone, and no project can register the same Pendo key again while this project exists." |

### Register your Pendo API key

1. Go to **Settings › Keys**.

2. Under **Pendo API key**, at **Register your Pendo API key**, paste the `apiKey` from your Pendo snippet.

3. Click **Register**.

4. Finish the steps in [Pendo](/docs/pendo).

The Pendo tab of the install snippet on Settings › Setup has the same form. See [Why is the Pendo tab missing?](#why-is-the-pendo-tab-missing) and [How do I replace a registered Pendo API key?](#how-do-i-replace-a-registered-pendo-api-key)

## Archive or delete

If you can, archive the project instead of deleting it.

| | Archive | Delete |
|---|---|---|
| Undo | Unarchive. The same keys work again. | None |
| Keys | Refused | Removed |
| Events, and the user, session and account records | Kept. Browse them again after you unarchive the project. | Unavailable at once. Permanently deleted within 14 days with the default schedule |
| Other stored data, such as judgments and identity links | Kept | Unavailable at once. Permanently deleted with the events |
| Recording files | Kept | Unreadable at once, because Sequential deletes their encryption keys. The storage deletes them later |
| Recording settings and questions | Kept | Removed |
| Export files | Kept until they expire, 7 days after the export finished | Deleted at once. If that fails, Sequential tries again about every hour |

Archive, unarchive and delete a project on Settings › Recording & data › The project. Only owners can delete an organisation, on Settings › Organisation.

To archive a project:

1. Go to **Settings › Recording & data › The project**.

2. Click **Archive this project…**.

3. Click **Archive and stop all data**, or **Keep it running**.

Result: An archived project leaves the switcher. To unarchive it, use Archived projects under Settings › Recording & data › The project, or the Archived list on All projects.

> **What an organisation delete removes**
>
> Deleting an organisation deletes each of its projects in the same way as a project delete. Sequential deletes their export files later, with a check that runs about every hour. Deleting an organisation also deletes its audit log. See [Retention and deletion](/docs/retention-and-deletion).

### Archive, restore or delete: the steps

If you belong to more than one organisation and archive an organisation's last live project, the switcher still lists that organisation, with No project yet. Owners and admins can click it to add a project.

To unarchive the project, open Settings › Recording & data in any project. The project is under Archived projects. Or open All projects from the switcher. The project is under its organisation, in Archived.

To restore a project:

1. Go to **Settings › Recording & data › The project**.

   Result: An archived project that you look at shows Unarchive and take data again. Your other archived projects are under Archived projects, each with Unarchive.

2. Click **Unarchive and take data again** or **Unarchive**.

   Result: The same keys work again.

You can also unarchive a project on All projects. Under its organisation, open Archived, then click Unarchive.

What a delete removes:

- Deleting a project permanently deletes its events, and the user, session and account records built from them, within 14 days with the default schedule.
- Judgments and identity links are deleted too.
- Recordings become unreadable at once, because Sequential deletes their encryption keys. The storage deletes the recording files later.
- Sequential deletes the export files of the project at once.

See [Retention and deletion](/docs/retention-and-deletion).

To delete a project:

1. In **Settings › Recording & data › The project**, click **Delete <project>…**.

   Result: From 8 November 2026, the box says, for example, "Deleting Acme removes it from the organisation." Under it, a list says what happens. Keys: "Revoked". Data: "Stops being available at once". Analytics data: "Deleted for good later, with AI judgments and identity links. The date shows when you confirm." Recordings: "Unreadable at once: their encryption keys are deleted. The stored files are removed later." Kept names the audit log entries about the project and the usage counts for billing. The old text is under Read the full text ▾.

2. Type the project's slug in the field "Type <slug>, the project’s slug, to confirm".

3. Click **Delete <project> for good** (it stays unavailable until the text matches exactly; a space at the end does not match).

Result: The Delete column of the table in [Archive or delete](#archive-or-delete) says what Sequential removes.

Or: an archived project also has Delete <project>… under Archived on All projects.

A delete needs a recent proof on this device. If your 2FA is on, Sequential can ask for a code from your app or a backup code. If your 2FA is off, it can ask you to sign in again.

To delete an organisation: whoever creates an organisation becomes its owner. Only owners can delete an organisation.

1. Go to **Settings › Organisation › Delete the organisation**.

2. Click **Delete <organisation>…**.

3. Type the organisation's name.

4. Click **Delete <organisation> for good**.

Result: This removes the organisation's projects and keys. It deletes each project's data in the same way as a project delete. It deletes the organisation's audit log.

## The switcher, All projects and Settings

Every report, funnel and replay list shows one project at a time: the project that you choose in the project switcher.

### The project switcher and All projects

The project switcher: the top row of the left rail shows the project that you are looking at, and its organisation. Click it to switch. When you choose a project, every page switches at once.

- If you belong to more than one organisation, the switcher groups projects under the name of their organisation. Each project shows its environment. A tick marks the current project.
- Owners and admins also see New project, with the name of the organisation. It opens the form on All projects. See [Add a project: the steps](#add-a-project-the-steps).
- The menu ends with Project settings, when a project is open, and All projects.
- Sequential remembers your choice in this browser only.
- An organisation with no live project shows No project yet. Owners and admins can click it to add one. Other roles see "An owner or admin adds one".
- An action that is running when you switch project can stop. See [What happens to an action when I switch project?](#what-happens-to-an-action-when-i-switch-project)

All projects lists every project of each organisation that you belong to. To open it, click the project switcher, then All projects at the end of the menu. Every role can open it.

Each organisation:

- Each organisation has its own section, with the number of its live projects. An organisation with no project keeps its section.
- Owners and admins see New project next to the name of the organisation. See [Add a project: the steps](#add-a-project-the-steps).
- An organisation with no live project shows No projects yet, with one line for owners and admins and another for other roles.

From 1 November 2026, the section of an organisation with more than one live project has Ask your agent. Its prompt starts "Use the Sequential tools for every project in the organisation" and the slug of the organisation, then tells the agent to call `list_projects` and pass `project` to each call.

For each project, the agent says what changed in the last 7 days, the open cases and what broke this week, and which project each result comes from. It ends with the three things most worth doing across the projects.

The prompt needs a connection to all projects of the organisation. On a connection to one project, the agent says so and goes on with that project.

Each live project:

- Each live project shows its name, slug and environment. Current marks the open project. Click a project to open it on Settings › Project.
- Each live project also shows its activity, or why Sequential does not read it.

Archived projects:

- Archived projects are under Archived and their count, for example Archived (2). Each one shows its name, its slug and the date of the archive. Owners and admins can click Unarchive, or delete the project with Delete <project>…. See [Archive, restore or delete: the steps](#archive-restore-or-delete-the-steps).
- Other roles see the archived projects, but the buttons are off. The page says "Only owners and admins of its organisation unarchive or delete a project."

#### Activity and empty lines on All projects

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Receiving" | A live project | The newest event or recording is from the last 7 days. It shows with the time, for example "Receiving · 2 minutes ago". | — |
| "Last event 3 weeks ago" | A live project | An example: the newest event or recording is older. | — |
| "No events yet" | A live project | The project has no data. | — |
| "Activity unknown" | A live project | Sequential cannot read the activity. | — |
| "Its organisation requires two-factor: open the project to see its activity." | A project in another organisation | Sequential does not read the activity of a project in another organisation that requires two-factor. | — |
| "Accept its Terms to see its activity." | A project that an agent trial added | Sequential does not read the activity of a project that an agent trial added when you signed in, until you accept its terms. See [Let your agent set up a trial](/docs/agent-trial). | — |
| "Create one to get ingest keys and an install snippet." | No projects yet, for owners and admins | The organisation has no live project. | — |
| "Ask an owner or admin to create one." | No projects yet, for other roles | The organisation has no live project. | — |

### Settings sections and who sees them

Settings, in the left rail, opens the settings of the project that you are looking at. The sections are in three groups: This project, Organisation and You.

| Section | What it is for | Who sees it |
|---|---|---|
| Project | The project's name, environment, organisation and your role. Then four lines: Data, Keys, Agent and Refused (see The Project section). Then Where hand-offs go, the webhook for hand-offs. | Everyone. Where hand-offs go: owners and admins. |
| Setup | Whether each source is receiving. The install snippet and Install with your AI agent. | Everyone. Snippet and Install with your AI agent: members, admins and owners. |
| Recording & data | The project (the name, slug and environment, with Save; archive; delete), What applies, the [recording settings](/docs/recording-settings), Who may send data, the switch Judge new sessions automatically, and Recent changes, the project's last 10 audit entries as sentences. | Everyone. Changing them, and Recent changes: owners and admins. |
| Keys | Every ingest key, with copy, rotate and revoke, the Pendo API key and the Server keys | Members, admins and owners |
| Agents & tokens | How to connect an agent, your own connections, and the project access tokens (`sq_pat_…`) for agents and CI jobs | Everyone. Every token of the project: owners and admins |
| Data out | Export a date range and Warehouse export. See [Export your data](/docs/export-your-data) | Everyone. Starting an export: owners and admins |

The [questions](/docs/rubric) and Calibration are on the Questions page, in the left rail. [Changes](/docs/changes) has its own page in the left rail too. An old project settings address opens the matching place. For example, the old Insights address opens the Questions page.

On Setup, Sequential and Session replay always show whether they are receiving. Another source shows only after its first event, as on Settings › Project. To confirm a new install, see [Check your install](/docs/verify).

The Project section: Settings › Project shows the project's Name, Environment, Organisation and Your role. An archived project also shows Archived and the date. Then four lines:

| Line | What it says |
|---|---|
| Data | When the last event and the last recording arrived, and the sessions in the last 7 days. If nothing has arrived, it says "Nothing has arrived from this project yet." and Set up a source opens Setup. One line for each source: Sequential and Session replay always, another source only after it has sent events. |
| Keys | How many keys sent data in the last 7 days, and the newest use. Server keys count here too. Revoked keys count too. From 8 November 2026, the line starts with the count. An example: "2 of 3 keys sent data" and "Last use 2 hours ago". The line under it says "Last 7 days, rolling" and "Revoked keys and server keys count too". With no keys, the line says "No keys". When no key was ever used, it says, for example, "0 of 3 keys used yet". In these two cases, the line under it says only "Revoked keys and server keys count too". The old sentence is under How counted ▾. If Sequential cannot count the keys, the line says "Sequential could not count this project’s keys just now." Then it has no How counted ▾. |
| Agent | Whether an agent is connected, and whether it calls Sequential on 3 or more of the last 7 days. |
| Refused | What Sequential refused or dropped from this project in the last days, and what to do. |

- If a read fails, the section shows the message and Try again.
- To rename the project or change its environment, use Settings › Recording & data › The project.

On Settings › Organisation, Usage this period shows the sessions of the organisation when the server counts them and you can read the usage (owners, admins and members). See [Usage and limits](/docs/usage-and-limits).

#### Lines on Setup and Usage this period

| Message | Where | What it means | What to do |
|---|---|---|---|
| "PostHog · receiving · 2 minutes ago" | Setup | An example. A line says "receiving", with a green dot, only when the last event is from the last 7 days. | — |
| "PostHog · last event 2 weeks ago" | Setup | An example of an older last event. It shows a dot that is not green. | — |
| "Usage is not metered on this server, so there is no limit to show." | Usage this period, on Settings › Organisation | The server counts nothing. | — |
| "Owners, admins and members see usage; viewers do not." | Usage this period, for a viewer | A viewer sees this line. | — |

## Limits

- Sequential staff can also make support changes to a project: change its settings, archive or restore it, and revoke its keys and access tokens. The audit log names them "Sequential support". It never shows the name of the staff member. See [Changes by Sequential support](/docs/audit-log#changes-by-sequential-support).
- Recent changes, on Settings › Recording & data, leaves out key changes. See the [Audit log](/docs/audit-log).

## FAQ

### What replay sampling does a new project get?

- Every new project, of every environment, records every session until someone changes Share of sessions recorded.
- Until 1 November 2026, a new staging or development project started at 10 %. Those projects keep their setting. A staging or development project made before 1 November 2026 records about one session in ten, until someone changes it.
- When you add a project with New project, you choose its environment. Every new project starts at 100 %. A staging or development project made before 1 November 2026 started at 10 % and keeps that rate. Onboarding always creates a production project.
- You can change the environment later in Settings › Recording & data › The project, then click Save. If you change a project's environment later, Sequential does not change its replay sampling.
- Sampling applies to replay only. Sequential does not sample analytics events.
- To see your project's own value, go to Settings › Recording & data › Recording › Share of sessions recorded. Owners and admins can change it there. See [Recording settings](/docs/recording-settings).

### Why is the Pendo tab missing?

The Pendo tab appears only while the project has a live Pendo key. If you revoked the Pendo ingest key that Sequential created with the project, bring it back on Settings › Keys: choose Pendo in New key for and click Create key.

### How do I replace a registered Pendo API key?

Register the new key under Pendo API key. When every source has a live key, Settings › Keys says this too. Sequential shows no Rotate on your registered Pendo API key, because Pendo never sends a new key. Revoke a registered Pendo API key only when you are sure.

### What happens to an action when I switch project?

- If you choose another project while Sequential sends your answer to a decision on the Brief, it sends nothing more for that decision, to either project. Dismiss all N like this… on a case also stops. See [Cases and fixes](/docs/findings).
- Undo puts nothing back after you choose another project: on the Board after you remove an item, and in Ask after an answer is taken off your Board.
- Sequential sends some changes in more than one request, for example a save to the Board, or a save of a funnel or saved view that tries the name again as "Name (2)". If, while it sends one, you choose another project, you sign out or someone else signs in, or you switch between the demo and your own data, Sequential does not send the rest.

| Message | Where | What it means | What to do |
|---|---|---|---|
| "This decision belongs to the project you left. Nothing more was sent for it." | A decision on the Brief | Sequential sent nothing more for that decision, to either project. | — |
| "The open project changed, so nothing was put back." | Undo on the Board, and in Ask | Undo put nothing back. | — |
| "The open project or account changed before this was sent, so it was not sent." | A change that Sequential sends in more than one request | Sequential did not send the rest. | — |

### Can I change an organisation's slug?

No. An organisation is different from a project: its slug cannot change after you create the organisation. Owners and admins can change only its name.

From 26 October 2026, a request that tries to change anything else is refused, and nothing changes. Sequential answers 400 `SLUG_IMMUTABLE` when the request has a slug, also with other fields, or 400 `ORG_FIELD_NOT_UPDATABLE` for another field.

## Related pages

- [Roles and permissions](/docs/roles-and-permissions): what each role can do.
- [Sign-up and invitations](/docs/sign-up-and-invitations): how teammates join your organisation.
- [Install Sequential](/docs/install): install a source in your app.
- [Recording settings](/docs/recording-settings): what a project records.
- [Retention and deletion](/docs/retention-and-deletion): how long Sequential keeps each kind of data.
