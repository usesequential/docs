# Organisations, projects and keys

> An organisation is your company or team. A project is one app or site inside it, with its own ingest keys, data and settings.

> **In short**
>
> - An organisation holds your members, roles, invitations, two-factor requirement and audit log. Roles apply to every project in it.
> - A project is one app or site. Every report shows one project at a time.
> - Each source has its own ingest key. Keys are public, so anyone who copies one can send data into your project.
> - To replace a key, rotate it, deploy the new key, then revoke the old one.
> - You can undo an archive but not a delete. A project delete permanently deletes the project's events within 14 days with the default schedule.

## What they are

An **organisation** is the company or team that owns your projects and members. It holds your members and their roles, [invitations](/docs/sign-up-and-invitations), the [two-factor requirement](/docs/two-factor-and-security) and the [audit log](/docs/audit-log).

A **project** is one app or site. It has its own ingest keys, its own data and its own settings. For example, the recording settings and the questions are per project.

## When to create separate projects

Use one project for data that you want to analyse together. Use separate projects for production and staging, for unrelated products, and when settings must differ. See **Which data goes in which project** below.

Owners and admins can add a project with **New project** in the project switcher, at the top of the left rail, or on **All projects**. The steps are in **Add a project: the steps** below.

## Environments

Every project has one of three labels: **production**, **staging** or **development**. The label changes one thing: the default for replay sampling, set when the project is made. A production project starts at 100 %. A staging or development project starts at 10 %. When you add a project with **New project**, you pick its environment. Onboarding always creates a production project. A later change of the label does not change the sampling.

Sampling applies to replay only. Sequential does not sample analytics events.

## Sources and ingest keys

A **source** is the channel that data arrives through, for example PostHog or Session replay. Every new project gets one ingest key for each source. Keys look like `sq_posthog_…`. A key works only for its own source.

Each tab of the install snippet on **Settings** › **Setup** already contains the right key. The exception is **Pendo**. See [Install Sequential](/docs/install).

**Server keys.** A server key is for the [backend SDK](/docs/backend-sdk), which sends events from your own server. Unlike an ingest key, it is a secret: never put it in a web page or an app. The **Server keys** section on **Settings** › **Keys** lists the keys. Owners and admins create and revoke them.

> **Ingest keys are public**
>
> Keys ship in your site's HTML or your app, like any analytics key. Unless your project has a list of allowed origins, Sequential does not check which site or app a key comes from. So anyone who copies a key can send data into your project.
>
> If that happens, rotate the key, then revoke the old one. The new key is also in your page, so someone can copy it too. Rotation stops only the copy that you found.
>
> **Allowed origins.** A project can have a list of allowed origins, such as `https://app.example.com`. Then Sequential refuses data that a browser sends from any other site, with 403 `origin_not_allowed`.
>
> - An origin is the scheme, the host and the port. The list takes exact origins only, with no wildcard and no path.
> - Sequential reads the browser's `Origin` header. When there is none, it reads the origin of the `Referer`.
> - It also refuses `Origin: null`. A browser sends it from a sandboxed iframe, a `data:` page and some privacy modes.
> - It allows a request with no `Origin` and no `Referer`, for example from a server, `curl` or a mobile SDK. So the list stops other websites from using your key in their visitors' browsers. It does not stop a script or a server, which can send any origin.
> - The check applies to every request that sends data from a browser or an app, not to the requests that read settings. It does not apply to the [backend SDK](/docs/backend-sdk).
> - The Sequential SDK stops sending after a 403 `origin_not_allowed`, for the rest of that page load, and writes one warning to the console. The next page load tries again.
> - If Sequential cannot read the list, it refuses the data with 503 `config_unavailable` and `Retry-After: 30`. It never treats an unreadable list as empty.
> - The list is empty by default, and an empty list allows every origin.
>
> **Set the allowed websites.** Open **Settings** › **Recording & data**. The **Allowed sites** box is under **Settings** › **Who may send data**.
>
> 1. In **Allowed sites**, type each site that runs your snippet, one per line, for example `https://shop.example.com`.
> 2. Under the box, **Where data came from in the last 7 days** lists the sites that sent events, each with **Allow** or **Allowed**. With a list, it says what the list would have refused, for example "With this list, Sequential would have refused 120 events from 2 sites (…)". When every site is on the list, it says "Every site that sent data is on the list." The box help says "Empty accepts data from any site."
> 3. Click **Save changes**. If the list refuses sites that sent events in the last 7 days, Sequential asks "Refuse events from these sites?" and names them. Click **Save and refuse them**, or **Cancel**.
> 4. Sequential says "Saved as version N. Recorders pick it up on their next fetch, usually within a few minutes."
>
> - Each line must be an origin only. For a line with a path, or with a slash at the end, Sequential says "Use the origin only, without a path or a trailing slash." and shows the origin. For a wildcard, it says "Wildcards are not allowed: list each site." For other text, it says "Write a site like https://app.example.com." It ignores empty lines and lines that repeat.
> - The list takes at most 200 sites.
> - The check before you save reads the page addresses of the events of the last 7 days. It checks the 50 sites with the most events, and says how many more sites it did not check. Pages with no web address, such as `file:`, `data:` and `about:` pages, are refused by any list. Events with no page address, for example from a server or a mobile app, are not affected, and Sequential says how many there were.
> - To remove the list, delete all the lines and click **Save changes**.
> - Only owners and admins can change the list. Other roles see the list and, for example, "You are a member: you can read these settings; owners and admins change them."
> - If someone else saved the project's settings after you opened the page, Sequential names them, and **Load the newest version** shows their version.
> - Sequential saves the whole settings document, with the version that you loaded. Your audit log records the change.

## Rotate or revoke a key

Keys are under **Settings** › **Keys** › **Ingest keys**. Members can copy keys. Owners and admins can also rotate and revoke them.

### Replace a key without losing data

1. Next to the key, click **Rotate**. Both keys work until you revoke the old key.
2. Copy the new key and deploy it. Sequential shows the whole new key only until you click **Done**.
3. When your app sends data with the new key, click **Revoke old key…**. Type the last 4 characters of the old key, then click **Revoke key**.

### Revoke a key now

Next to the key, click **Revoke…**. Type the last 4 characters of the key, then click **Revoke key**. Revoking is permanent. Sequential refuses anything sent with the key from then on. So an app that still uses the key loses data until it ships a new key.

Always keep one live Session replay key. The Sequential SDK and Smartlook fetch this key themselves. If you revoke the only one, their replay stops and Sequential shows no warning.

## Pendo API keys

If you use Pendo, owners and admins must register your own Pendo API key. A Pendo API key registers to one project only, so production and staging need different keys.

Sequential shows no **Rotate** on a registered Pendo API key. Revoking one is permanent: you can never register a revoked Pendo API key again. See **Pendo API keys: before you change one** below.

## Archive or delete

If you can, archive the project instead of deleting it.

| | Archive | Delete |
|---|---|---|
| Undo | **Unarchive**. The same keys work again. | None |
| Keys | Refused | Removed |
| Events, and the user, session and account records | Kept. Browse them again after you unarchive the project. | Unavailable at once. Permanently deleted within 14 days with the default schedule |
| Other stored data, such as judgments and identity links | Kept | Unavailable at once. Permanently deleted with the events |
| Recording files | Kept | Unreadable at once, because Sequential deletes their encryption keys. The storage deletes them later |
| Recording settings and questions | Kept | Removed |
| Export files | Kept until they expire, 7 days after the export finished | Deleted at once. If that fails, Sequential tries again about every hour |

> **What a delete removes**
>
> Deleting a project permanently deletes its events, and the user, session and account records built from them, within 14 days with the default schedule. Judgments and identity links are deleted too. Recordings become unreadable at once, because Sequential deletes their encryption keys. The storage deletes the recording files later. Sequential deletes the export files of the project at once. See [Retention and deletion](/docs/retention-and-deletion).
>
> Deleting an organisation deletes each of its projects in the same way. Sequential deletes their export files later, with a check that runs about every hour. Deleting an organisation also deletes its audit log.

## Limits

- Roles belong to the organisation. There are no per-project roles. So a project does not limit who in your organisation can see its data. See [Roles and permissions](/docs/roles-and-permissions).
- Sequential staff can also make support changes to a project: change its settings, archive or restore it, and revoke its keys and access tokens. The audit log names them "Sequential support". It never shows the name of the staff member. See [Changes by Sequential support](/docs/audit-log#changes-by-sequential-support).
- You cannot undo a project delete.
- **Recent changes**, on **Settings** › **Recording & data**, leaves out key changes. See the [Audit log](/docs/audit-log).
- **Usage this period**, on **Settings** › **Organisation**, shows the sessions of the organisation when the server counts them and you can read the usage (owners, admins and members). When the server counts nothing, it says "Usage is not metered on this server, so there is no limit to show." A viewer sees "Owners, admins and members see usage; viewers do not." See [Usage and limits](/docs/usage-and-limits).
- An archived project leaves the switcher. To unarchive it, use **Archived projects** under **Settings** › **Recording & data** › **The project**, or the **Archived** list on **All projects**.
- If you change a project's environment later, Sequential does not change its replay sampling. Change sampling in **Settings** › **Recording & data** › **Recording** › **Share of sessions recorded**.
- The Used note on a key does not show that events arrive. To check for events, use **Setup**.

### Add a project: the steps

1. In the project switcher, at the top of the left rail, click **New project**. The organisation shows next to it, for example "in Acme". Or open **All projects** and click **New project** next to the organisation.
2. In **Name**, type the name of the project.
3. Optional: in **Slug**, type a slug. If you leave it empty, Sequential makes the slug from the name.
4. In **Environment**, pick **Production**, **Staging** or **Development**. The form starts on **Production**.
5. Click **Create project**. To stop, click **Cancel**.

Sequential says "Project <name> created". The new project is on **All projects** and in the switcher. Sequential does not open it. To open it, pick it in the switcher. Its install snippet is then on **Settings** › **Setup**.

- Under the fields, the form says that a project is one app or site, with its own ingest keys for every source. It also says that a staging or development project starts by recording replays of 10 % of its sessions.
- If the slug is taken, Sequential says "That slug is already taken." For any other slug that it cannot use, it says "Use lowercase letters, digits and single dashes for the slug (up to 60 characters)."
- If you click **New project** for an organisation that is not open, Sequential first opens a project of that organisation.
- An organisation with no live project shows **No project yet** in the switcher. Owners and admins click it to open the same form.

### Which data goes in which project

Put data that you want to analyse together in one project. Give data that you want to keep apart its own project.

| Situation | Suggestion |
|---|---|
| Production and staging of the same app | Separate projects. Test traffic stays out of your production reports, and staging records less replay by default. |
| Your app and a marketing site that you report on together | One project |
| Two unrelated products | Separate projects |
| Settings that must differ, for example console text captured in staging but not in production | Separate projects. Recording settings and the questions are per project. |

### Sampling defaults and later changes

- A staging or development project records about one session in ten.
- Sequential applies the sampling default once, at creation. These values are defaults only.
- You can change the environment later in **Settings** › **Recording & data** › **The project**, then click **Save**. This changes the label, never the sampling.
- To see your project's own value, go to **Settings** › **Recording & data** › **Recording** › **Share of sessions recorded**. Owners and admins can change it there. See [Recording settings](/docs/recording-settings).
- **New project** asks for the environment. A project that you create as **Staging** or **Development** starts at 10 %. Onboarding always creates a production project. If you change the environment later, change **Share of sessions recorded** yourself.
- The environment does not separate data inside a project. For that, use separate projects.

### What a key can and cannot do

- A key can send data into its project.
- A key can read the project's recording settings.
- A key cannot read your analytics.
- A key is not a login or API credential.

### Which key each install uses

The sources are Sequential, PostHog, Mixpanel, Amplitude, Pendo, Smartlook and Session replay.

Sequential refuses a key that it gets from a different source, even when the key belongs to your project. For example, Sequential refuses a Session replay key in a PostHog setup. It also refuses a PostHog key that arrives at Mixpanel's endpoint.

| You install | Key it uses |
|---|---|
| Sequential SDK | Sequential. It fetches the replay key itself. |
| PostHog, Mixpanel or Amplitude on the web | That source's key. The optional replay line uses the Session replay key. |
| PostHog's mobile SDKs | PostHog, for events and replay |
| Smartlook | Smartlook. Replay starts on its own with the project's replay key. |
| Pendo | Your own Pendo API key, registered with the project. The optional replay line uses the Session replay key. |
| Session replay on its own | Session replay |

### Rotation edge cases

- When you revoke a key, every Sequential server stops accepting it at once. If Sequential cannot tell its other servers, for example because Redis is down, another server can accept the key for up to a minute.
- To keep both keys working after you rotate, click **Keep both**.
- The **Old key** mark and **Revoke old key…** show only while the page stays open. If you left the page, revoke the old key with **Revoke…** next to it: type its last 4 characters, then click **Revoke key**.
- The page lists live keys by their last use, most recent first. A key that you rotate in has the label "rotated" and today's date. The old key shows **Old key**.
- Until you revoke the old key, **Setup** still shows the old key.
- Owners and admins see **Create key** for a source with no live key. They pick the source in **New key for**.
- Members can only copy a key. **Rotate** and **Revoke…** are for owners and admins.
- If you use the Sequential SDK or Smartlook and rotate the **Session replay** key, there is nothing to deploy. Sequential gives them the project's oldest live replay key. So they keep using the old key until you revoke it.
- After you revoke it, new page loads switch to the new key within about a minute. Pages that are already open keep sending with the old key, and Sequential refuses it.
- The **Used …** note on a key also updates when a recorder fetches its settings. So the note shows only that something uses the key. It does not show that events arrive. To check for events, use **Setup**.

### Pendo API keys: before you change one

Pendo's agent sends data with your own Pendo API key. So owners and admins must register that key with the project. Before you change a registered Pendo API key:

- You can register a Pendo API key to one project only. So production and staging projects need different Pendo API keys.
- Sequential shows no **Rotate** on your registered Pendo API key, because Pendo never sends a new key. To replace it, register the new key under **Pendo API key**. When every source has a live key, **Settings** › **Keys** says this too.
- Revoke a registered Pendo API key only when you are sure. You can never register a revoked Pendo API key again.

### Register your Pendo API key

Owners and admins can register a Pendo API key.

1. Open **Settings** › **Keys**. The **Pendo** tab of the install snippet on **Settings** › **Setup** has the same form.
2. Under **Pendo API key**, at **Register your Pendo API key**, paste the `apiKey` from your Pendo snippet.
3. Click **Register**.
4. Finish the steps in [Pendo](/docs/pendo).

### When the Pendo tab is missing

The **Pendo** tab appears only while the project has a live Pendo key. If you revoked the Pendo ingest key that Sequential created with the project, bring it back on **Settings** › **Keys**: pick **Pendo** in **New key for** and click **Create key**.

### Settings sections and who sees them

**Settings**, in the left rail, opens the settings of the project that you are looking at. The sections are in three groups: **This project**, **Organisation** and **You**.

| Section | What it is for | Who sees it |
|---|---|---|
| **Project** | The project's name, environment, organisation and your role. Then four lines: **Data**, **Keys**, **Agent** and **Refused**. See **The Project section** below. Then **Where hand-offs go**, the webhook for hand-offs. | Everyone. **Where hand-offs go**: owners and admins. |
| **Setup** | Whether each source is receiving. The install snippet and **Install with your AI agent**. | Everyone. Snippet and **Install with your AI agent**: members, admins and owners. |
| **Recording & data** | **The project** (the name, slug and environment, with **Save**; archive; delete), **What applies**, the [recording settings](/docs/recording-settings), **Who may send data**, the switch **Judge new sessions automatically**, and **Recent changes**, the project's last 10 audit entries as sentences. | Everyone. Changing them, and **Recent changes**: owners and admins. |
| **Keys** | Every ingest key, with copy, rotate and revoke, the **Pendo API key** and the **Server keys** | Members, admins and owners |
| **Agents & tokens** | How to connect an agent, your own connections, and the project's access tokens for agents and CI jobs | Everyone. Every token of the project: owners and admins |
| **Data out** | **Export a date range** and **Warehouse export**. See [Export your data](/docs/export-your-data) | Everyone. Starting an export: owners and admins |

The [questions](/docs/rubric) and "How often people agree with the judge" are on the **Questions** page, in the left rail. [Changes](/docs/changes) has its own page in the left rail too. An old project settings address opens the matching place. For example, the old **Insights** address opens the **Questions** page.

On **Setup**, **Sequential** and **Session replay** always show whether they are receiving. Another source shows only after its first event, as on **Settings** › **Project**. For example: "PostHog · receiving · 2 minutes ago". A line says "receiving", with a green dot, only when the last event is from the last 7 days. An older last event shows a dot that is not green and, for example, "PostHog · last event 2 weeks ago". To confirm a new install, see [Check your install](/docs/verify).

### The Project section

**Settings** › **Project** shows the project's **Name**, **Environment**, **Organisation** and **Your role**. An archived project also shows **Archived** and the date. Then four lines:

| Line | What it says |
|---|---|
| **Data** | When the last event and the last recording arrived, and the sessions in the last 7 days. If nothing has arrived, it says "Nothing has arrived from this project yet." and **Set up a source** opens **Setup**. One line for each source: **Sequential** and **Session replay** always, another source only after it has sent events. |
| **Keys** | How many keys sent data in the last 7 days, and the newest use. Server keys count here too. |
| **Agent** | Whether an agent is connected, and whether it calls Sequential on 3 or more of the last 7 days. |
| **Refused** | What Sequential refused or dropped from this project in the last days, and what to do. |

- If a read fails, the section shows the message and **Try again**.
- To rename the project or change its environment, use **Settings** › **Recording & data** › **The project**.
- An organisation is different: its slug cannot change after you create the organisation. Owners and admins can change only its name. From 26 October 2026, a request that tries to change anything else is refused, and nothing changes. Sequential answers 400 `SLUG_IMMUTABLE` when the request has a slug, also with other fields, or 400 `ORG_FIELD_NOT_UPDATABLE` for another field.

### Archive, restore or delete: the steps

### Archive a project

1. Open **Settings** › **Recording & data** › **The project**. Click **Archive this project…**.
2. Click **Archive and stop all data**, or **Keep it running**. The project leaves the switcher.

### Restore a project

1. Open **Settings** › **Recording & data** › **The project**. An archived project that you look at shows **Unarchive and take data again**. Your other archived projects are under **Archived projects**, each with **Unarchive**.
2. Click the button. The same keys work again.

You can also unarchive a project on **All projects**. Under its organisation, expand **Archived**, then click **Unarchive**.

### Delete a project

1. In **Settings** › **Recording & data** › **The project**, click **Delete <project>…**. An archived project also has **Delete <project>…** under **Archived** on **All projects**.
2. Type the project's slug in the field "Type <slug>, the project’s slug, to confirm".
3. Click **Delete <project> for good**. It stays unavailable until the text matches exactly. A space at the end does not match.

A delete needs a recent proof on this device. If your 2FA is on, Sequential can ask for a code from your app or a backup code. If your 2FA is off, it can ask you to sign in again.

### Archiving when you belong to more than one organisation

If you archive an organisation's last live project, the switcher still lists that organisation, with **No project yet**. Owners and admins can click it to add a project.

To unarchive the project, open **Settings** › **Recording & data** in any project. The project is under **Archived projects**. Or open **All projects** from the switcher. The project is under its organisation, in **Archived**.

### Deleting an organisation

The person who creates an organisation becomes its owner. Only owners can delete an organisation. Go to **Settings** › **Organisation** › **Delete the organisation**. Click **Delete <organisation>…**, type the organisation's name, then click **Delete <organisation> for good**. This removes the organisation's projects and keys. It deletes each project's data in the same way as a project delete. It deletes the organisation's audit log.

### The project switcher

Every report, funnel and replay list shows one project at a time. This is the project that you pick in the project switcher. The top row of the left rail shows the project that you are looking at, and its organisation. Click it to switch. When you pick a project, every page switches at once.

- If you pick another project while Sequential sends your answer to a decision on the **Brief**, it sends nothing more for that decision, to either project. The decision says "This decision belongs to the project you left. Nothing more was sent for it." **Dismiss all N like this…** on a case also stops. See [Cases and fixes](/docs/findings).
- **Undo** puts nothing back after you pick another project: on the **Board** after you remove an item, and in **Ask** after an answer is taken off your Board. It says "The open project changed, so nothing was put back."
- Sequential sends some changes in more than one request, for example a save to the **Board**, or a save of a funnel or saved view that tries the name again as "Name (2)". If, while it sends one, you pick another project, you sign out or another person signs in, or you switch between the demo and your own data, Sequential does not send the rest. The page says "The open project or account changed before this was sent, so it was not sent."
- If you belong to more than one organisation, the switcher groups projects under the name of their organisation. Each project shows its environment. A tick marks the current project.
- Owners and admins also see **New project**, with the name of the organisation. It opens the form on **All projects**. See **Add a project: the steps**.
- The menu ends with **Project settings**, when a project is open, and **All projects**. See **The All projects page** below.
- Sequential remembers your choice in this browser only.
- An organisation with no live project shows **No project yet**. Owners and admins can click it to add one. Other roles see "An owner or admin adds one".

### The All projects page

**All projects** lists every project of each organisation that you belong to. To open it, click the project switcher, then **All projects** at the end of the menu. Every role can open it.

- Each organisation has its own section, with the number of its live projects. An organisation with no project keeps its section.
- Each live project shows its name, slug and environment. **Current** marks the open project. Click a project to open it on **Settings** › **Project**.
- Each live project also shows its activity, for example "Receiving · 2 minutes ago". It says "Receiving" when the newest event or recording is from the last 7 days. An older one shows, for example, "Last event 3 weeks ago". A project with no data shows "No events yet". If Sequential cannot read the activity, it shows "Activity unknown".
- Sequential does not read the activity of a project in another organisation that requires two-factor. The row says "Its organisation requires two-factor: open the project to see its activity."
- Sequential does not read the activity of a project that an agent trial added when you signed in, until you accept its terms. The row says "Accept its Terms to see its activity." See [Let your agent set up a trial](/docs/agent-trial).
- Owners and admins see **New project** next to the name of the organisation. See **Add a project: the steps**.
- An organisation with no live project shows **No projects yet**. Owners and admins see "Create one to get ingest keys and an install snippet." Other roles see "Ask an owner or admin to create one."
- Archived projects are under **Archived** and their count, for example **Archived (2)**. Each one shows its name, its slug and the date of the archive. Owners and admins can click **Unarchive**, or delete the project with **Delete <project>…**. See **Archive, restore or delete: the steps**.
- Other roles see the archived projects, but the buttons are off. The page says "Only owners and admins of its organisation unarchive or delete a project."

## Related

- [Roles and permissions](/docs/roles-and-permissions)
- [Sign-up and invitations](/docs/sign-up-and-invitations)
- [Install Sequential](/docs/install)
- [Check your install](/docs/verify)
- [Pendo](/docs/pendo)
- [Recording settings](/docs/recording-settings)
- [Retention and deletion](/docs/retention-and-deletion)
- [Audit log](/docs/audit-log)
