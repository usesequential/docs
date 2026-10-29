# Glossary of Sequential terms

> Plain definitions of the terms used in Sequential and in these docs, such as session, verdict and case. Each entry links to the page that explains it.

> **In short**
>
> - The terms are in alphabetical order, in groups of letters.
> - Each entry gives a short definition and a link to the page that explains it.
> - Each entry and table row starts with its term in bold. Inside a definition, words in **bold** are exact labels from the app.
> - The table **Terms that are easy to confuse** shows pairs that people often mix up.

## Terms that are easy to confuse

| Term | Not the same as |
|---|---|
| **Member**: a person on your team who signs in to Sequential | **User**: a person who uses your product |
| **Session**: one visit to your product | A sign-in session, which **Settings** › **Security** lists |
| **Masking**: hides text, and the layout stays | **Block**: leaves the element out, so it plays back as an empty box |
| **Retention (data)**: how long Sequential keeps what it collects | **Retention (report)**: Workbench › **Retention** |
| **Role (organisation)**: a member's permission level | **Role (question)**: a tag on one of your questions |
| **Rubric version**: the count of saves of the questions | **Rubric hash**: a fingerprint of what the judge reads |
| **Event property**: describes one event | **User property**: describes the person. The filter field **Event property** matches event properties. |

## A–B

- **Access token.** A project credential that an agent or a CI job sends to Sequential. Owners and admins create it on **Agents** or under **Settings** › **Agents & tokens**. Sequential shows it once. Treat it like a password. [Limits](/docs/limits#programmatic-access)
- **Account.** A group of users, such as a customer company. Today, accounts come from Pendo and from the Sequential SDK's `sequential.account()`. [Users and accounts](/docs/users-and-accounts)
- **Agents.** The page in the left rail where you see which agents are connected, such as claude.ai and coding agents. Owners and admins see every connection. Members and viewers see only their own. There, people connect claude.ai. Owners and admins also make access tokens there and end any connection or token. Every role ends its own connections there and under **Settings** › **Agents & tokens**. The page also lists what the agents did. [Your first hour](/docs/quickstart#connect-your-agent)
- **Anonymous id.** The user id of a visitor before your app identifies them. It shows on **People** like any other user, until the Sequential SDK links it to one identified value. [Users and identity](/docs/users-and-identity)
- **Archive.** The reversible way to stop a project. Sequential refuses requests that use its keys. [Organisations, projects and keys](/docs/organisations-and-projects)
- **Ask.** The **Ask** page in the left rail: you ask one line about sessions, funnels, retention or people. A short or empty list of sessions does not mean that nothing like it happened. [Ask: one line about sessions, funnels, retention or people](/docs/ask)
- **Attention score.** The number that orders the sessions in each lane of **Evidence**, from each question's **Attention weight**. [Judgments](/docs/judgments)
- **Attribution parameters.** The marketing query parameters whose values Sequential keeps in stored page URLs. [What Sequential keeps from page URLs](/docs/url-policy)
- **Audit log.** A record of security and configuration changes, with who made each change and when. [Audit log](/docs/audit-log)
- **Autocapture.** Events that an SDK sends without code from you. [Events](/docs/events)
- **Belief.** The name the API uses for a stored judgment (`/api/beliefs/…`). The app says the judge's reading. [Judgments](/docs/judgments)
- **Block.** To leave an element fully out of a recording. It plays back as an empty box. [Masking and redaction](/docs/masking-and-redaction)
- **Breakdown.** A grouping of the events on Workbench › **Events** by one field or property. [Explore events](/docs/events-explorer)

### More about A–B terms

- **Account:** Sequential identifies an account by an account id. To see accounts, open Workbench › **Accounts**. An event without an account id belongs to no account. **Accounts** does not list it as a row. A line under the list counts the sessions that have no account. Group calls from PostHog, Mixpanel and Amplitude are not used for accounts yet.
- **Anonymous id:** The SDK creates it. The Sequential SDK keeps its own in the browser's storage. Nothing marks it as anonymous.
- **Archive:** The project no longer shows in the project switcher. **All projects** lists it under **Archived**. Sequential keeps its data, keys and settings. **Unarchive** brings it back with the same keys.
- **Ask:** The judge rates how likely each candidate session is to match. Ask does not list sessions that it rates unlikely.
- **Attention score:** Each question adds its **Attention weight**, which owners and admins set on the **Questions** page. **Evidence** calculates the score each time it loads. So a weight change re-orders the sessions at once.
- **Attribution parameters:** Examples: `utm_source`, `utm_campaign` and ad click ids like `gclid`. Every other query value becomes `[redacted]`.
- **Audit log:** It covers changes in your organisation. Examples: saved recording settings, saved questions and deleted projects. Owners and admins can read it, under **Settings** › **Organisation**.
- **Autocapture:** The events are page views, clicks and form submits. The Sequential SDK autocaptures by default. It never records what anyone types.
- **Belief:** Background judging makes them. It is on by default for each project. Owners and admins turn it off or on under **Settings** › **Recording & data** › **Judging**. See also *Judgment*.
- **Block:** Sequential blocks elements with the `data-rr-block` attribute under both **Strict** and **Balanced**. Compare *Masking*.
- **Breakdown:** For example, by country. On Workbench › **Events**, set it with **Break down by**. It shows a count and a share for each value.

## C–D

- **Calibration.** The part **How often people agree with the judge** of the **Questions** page. It uses your team's **Right** and **Wrong** on each reading of a session to check if the judge is right as often as it says. [Feedback and calibration](/docs/feedback-and-calibration)
- **Case.** A problem that Sequential counts across sessions: an error, a failed request, a dead click, a rage click or a dead end. A JavaScript error, a server error (5xx) or a network failure opens one from its first session. Other problems need at least 3 sessions of at least 2 people in the last 7 days. A dead end where people came back with the Back button needs at least 6 sessions of 4 people, and 20 % of the page's sessions. Errors from browser extensions and requests to ad or analytics hosts never open one. With the Sequential SDK, PostHog or Mixpanel, one person counts once, even if they signed in between. Its id reads like F-12. [Cases and fixes](/docs/findings)
- **Class (event class).** One of nine fixed categories that every event gets on arrival. To filter on it, use **Event type**. [Events](/docs/events)
- **Connection (claude.ai).** The link from claude.ai to one project. A person of any role makes it with a sign-in and a consent page, not with a token. It shows under **Connected** on **Agents**, and under **Your connections** in **Settings** › **Agents & tokens**. [Connect claude.ai](/docs/connect-claude-ai)
- **Console text.** The words that your app writes to the browser console. Sequential stores them only when **Console message text** is on. It is off by default. [Masking and redaction](/docs/masking-and-redaction)
- **Custom event.** An event whose name Sequential does not recognise as another class, such as `checkout_started`. [Send custom events](/docs/custom-events)
- **Dead click.** See *Rage click and dead click*.
- **Delete (project).** Removes a project with its keys, recording settings and questions. You cannot undo it. Sequential permanently deletes the project's events within 14 days with the default schedule. [Retention and deletion](/docs/retention-and-deletion)
- **DevTools.** The JavaScript errors, console output, network requests and page performance that Sequential records with a web replay. [DevTools in replays](/docs/devtools)
- **DevTools states.** *Counted*, *not captured* or *not measured*. An empty **Problems** cell on Workbench › **Sessions** does not prove that the session was clean. [DevTools in replays](/docs/devtools)
- **Digest.** The short text version of a session that the judge reads, with at most 255 events. [Judgments](/docs/judgments)
- **Distinct id.** The id that an SDK sends for the current person. Sequential stores it as the *user id*. [Identify your users](/docs/identify-users)

### More about C–D terms

- **Calibration:** The part is on the **Questions** page, under the questions. For example: when a question says 90 %, was it right about 90 % of the time?
- **Case:** **Cases** in the left rail lists them. A case moves along the steps **New**, **Handed off**, **Fix linked**, **Shipped** and **Measured**. The API and the agent tools call a case a finding, for example `/api/findings` and `get_finding`.
- **Class (event class):** Sequential decides the class from the event name. The classes are Page view, Click, Form submit, Identify, Error, Rage click, Dead click, Custom and System. A class means the same for every SDK.
- **Console text:** An example is "payment failed: card_declined". **Console message text** is a project setting. Whether it is on or off, Sequential keeps the console levels, counts and code locations.
- **Custom event:** Usually your own code sends it. Custom events are how your product's milestones reach funnels, flows and the judge.
- **Delete (project):** Sequential can no longer open the project's data. It permanently deletes the events, and the user, session and account records, within 14 days with the default schedule. Judgments and identity links are deleted too. Recordings become unreadable at once, because Sequential deletes their encryption keys. The storage deletes the recording files later.
- **DevTools:** DevTools is the technical context of a replay. Sequential never records the headers or bodies of network requests. You turn each capture on or off per project. All four are on by default.
- **DevTools states:** They say how much Sequential knows about a session's DevTools counts. The **Problems** column names only errors and failed requests. Console errors never show there.
- **Digest:** The judge never watches the recording. Sequential does not keep the digest.
- **Distinct id:** It is `distinct_id` in the Sequential SDK, PostHog and Mixpanel. Before your app identifies the visitor, it is an anonymous id. After that, it is the value that you pass.

### The three DevTools states

| State | What it means |
|---|---|
| *Counted* | Sequential checked the session. The **Problems** column shows what it found, for example "2 requests failed". |
| *Not captured* | That capture was off, or your mobile SDK does not report it. |
| *Not measured* | Sequential never checked the session. For example, a session recorded before counting began. |

The player's DevTools counts console errors, but console errors never show in **Problems**.

Two filters on Workbench › **Sessions** count only checked sessions: **The recording measured an error** and **The recording measured a failed request**. They leave out the sessions that are not captured or not measured.

### What the digest holds

- One numbered line per event, except System events.
- Pauses.
- A few facts, such as duration, device and, when measured, error counts.

The digest holds at most 255 events. In a longer session, Sequential leaves out the least important events first: clicks, and then custom events.

## E–H

- **Entities.** The old name of the **Accounts** view. An old `/entities` link opens Workbench › **Accounts**, or the account's page when the link names an account. [Users and accounts](/docs/users-and-accounts#the-accounts-list)
- **Environment.** A project label: production, staging or development. It does not separate data inside a project. [Organisations, projects and keys](/docs/organisations-and-projects)
- **Event.** One thing that happened in a session, such as a page view or a click. [Events](/docs/events)
- **Event name.** The exact name that the sending SDK used, such as `$autocapture`. Sequential never rewrites it. [Events](/docs/events)
- **Event property.** A property of one event, such as `plan` on `checkout_started`. The **Event property** filter matches one with a type and an operator. [Send custom events](/docs/custom-events)
- **Evidence.** The **Evidence** page in the left rail: the judged sessions of the last 7 days in lanes, the worst first. [Evidence: the sessions worth a look](/docs/watch)
- **Export.** A copy of one project's events and sessions as files, for a range of days in UTC. Owners and admins start one under **Settings** › **Data out**, in **Export a date range**, or with an access token. [Export your data](/docs/export-your-data)
- **Filter.** Conditions on an event's fields, in the filter bar of a Workbench view or of **People**. With two or more conditions or groups, the bar reads **All of** or **Any of**. On Workbench › **Sessions** and **Events**, and on **People**, a filter can have groups: **All of**, **Any of**, **None of** or **Not all of**. [Filters, date ranges and saved views](/docs/filters-and-saved-views)
- **Finding.** The name that the API and the agent tools use for a case. See *Case*. [Cases and fixes](/docs/findings)
- **Fix brief.** The text about one case that you copy for a developer or an agent. Its quoted blocks are data from your users' sessions. [Cases and fixes](/docs/findings)
- **Fix link.** A link from a case to the pull request, commit or issue for its fix. [Cases and fixes](/docs/findings)
- **Flow.** The **Flows** view of **Workbench**: the order in which users move between a few events that you pick. [Flows](/docs/flows)
- **Forward-only.** Sequential judges each session once, and its stored answers never change. [Customise the questions](/docs/rubric)
- **Funnel.** The **Funnels** view of **Workbench**: how many users complete a series of steps in order. [Funnels](/docs/funnels)
- **Handed off.** A case stage: someone copied the fix brief or opened a GitHub issue from it. Or a token read the case or its brief: GET `/api/findings/:n` counts too. [Cases and fixes](/docs/findings)
- **Heatmap data.** Where sampled visitors click and how far they scroll on each page of a website, kept as counts with no text. On by default. Owners and admins turn it on or off with **Heatmaps** under **Settings** › **Recording & data** › **What a recording carries**. Workbench › **Heatmaps** shows its click counts, drawn on a page picture, and its scroll depth. [Privacy at a glance](/docs/privacy-overview#heatmap-data)
- **Heatmap page picture.** A picture of a page, taken from one visitor's masked recording, with the clicks drawn on it. Workbench › **Heatmaps** shows it to all four roles (owner, admin, member, viewer). Anything that the recording shows unmasked appears in it. A separate builder service makes it in the background. Where no builder runs, the page says "No picture builder is running right now, so there is no picture of this page. The list has every click." The list of elements still shows, without a picture. [The page picture](/docs/privacy-overview#the-page-picture)

### More about E–H terms

- **Entities:** Since 13 October 2026, the name is **Accounts**. It lists only accounts. To see people, open **People**.
- **Environment:** It has one effect: a project created as staging or development starts with replay sampling at 10 % instead of 100 %. **New project** asks for the environment. Onboarding always creates a production project.
- **Event:** Another example is your app's `checkout_started`. Sequential stores each event with its class, original name, source, time, page, device, user, session and properties.
- **Event name:** Other examples: `[Amplitude] Page Viewed` and `checkout_started`.
- **Event property:** You can see event properties in an event's raw data. The filter field **Event property** matches them with a type and an operator.
- **Evidence:** Each card says in one sentence what the judge read, and the moment to watch, such as "Struggled at 0:42". Click a card, or press Enter on it, to watch the session beside the list, at its moment. If you cannot play the recording now, the card says why, for example **No recording**.
- **Export:** It always holds the events, the sessions and `manifest.json`, as NDJSON or CSV, gzipped. The files can hold emails, user ids and IP addresses as your app sent them. You can download them for 7 days. A project can start 3 exports a day (UTC).
- **Filter:** An example condition is **Event type** is `rage_click`. Each condition tests one event at a time. The same filter bar defines funnel and flow steps.
- **Fix link:** A case with a fix link is at the stage **Fix linked**.
- **Flow:** It draws the paths as a diagram. Each user has one path for the full window. An event counts toward every step that it matches. If the same step comes two times in a row, Sequential keeps it once.
- **Forward-only:** If you change what the judge is asked, the change applies only to sessions that Sequential judges after the change. On the page of a session judged before it, the reading says "The questions changed since; this reading is from the earlier version."
- **Funnel:** It also shows the time between steps, and which users left at which step. Sequential measures conversion against step 1. A later step counts only within the conversion window after step 1. The default is 7 days.
- **Heatmap data:** It follows the replay period. An owner or admin turns it off with `replay.heatmaps.enabled` in the settings API. That also stops the page picture.

## I–L

- **Identify.** The call that tells Sequential who a visitor is, such as `sequential.identify()`. Two different values for one person make two users. [Identify your users](/docs/identify-users)
- **Identity claim.** The link that Sequential records when the Sequential SDK identifies a visitor. The **People** list, each person's page, **Evidence**, Workbench › **Sessions**, funnels, flows, retention, Workbench › **Events** and the **Person id** filter use claims. From 26 October 2026, the **Brief** uses them too: **People, 30 days** counts a visitor who signed in during a visit once. [Users and identity](/docs/users-and-identity)
- **Ingest key.** A public key for one source in a project, such as `sq_posthog_…`. It cannot read your analytics. [Organisations, projects and keys](/docs/organisations-and-projects)
- **Judge.** The AI model that answers your project's questions. See [AI and third parties](/docs/ai-and-third-parties). [AI and third parties](/docs/ai-and-third-parties)
- **Judgment.** The judge's answers about one session, stored as probabilities. When background judging is on for your project, it makes one judgment per session that was active in the last 7 days. Sequential marks a session with fewer than 3 meaningful events as too short. It never judges that session. [Judgments](/docs/judgments)
- **Judgment budget.** Each project's daily judging allowance. It resets at midnight UTC. When an allowance runs out, the judging it covers stops until the reset. [Judgments](/docs/judgments)
- **Loosening.** A change to the recording settings that records more. To save one, type the project's slug. [Recording settings](/docs/recording-settings)

### More about I–L terms

- **Identify:** Events sent before it keep the anonymous id. Sequential uses the value that you pass as it is. Any stable identifier works. Always pass the same value for a person, everywhere.
- **Identity claim:** A claim says: this anonymous id became this identity in this session. The pages that use claims then show one user.
- **Ingest key:** It can send data to the project and read its recording settings. To rotate or revoke it, go to **Settings** › **Keys**. Pendo uses your own Pendo API key instead.
- **Judge:** It reads the digest and your questions. It returns probabilities, never prose.
- **Judgment:** Background judging judges a session when about 30 minutes have passed since the session's last event.
- **Judgment budget:** Background judging, **Ask** in the app and **Ask** from an agent each have their own allowance. **Try on a session** on the **Questions** page has its own too.
- **Loosening:** Examples: a move from **Strict** to **Balanced** masking, or turning on **Console message text**. The audit log flags it.

### What a judgment holds

A judgment stores one probability for each of these:

- each option of a list question
- each level of a scale
- yes, on a signal
- which event a moment points to

### Identity claims

- Claims come only from the Sequential SDK.
- The session where identify ran always follows its claim.
- The other sessions of the anonymous id follow its first claim. If two values claim the same anonymous id, those sessions go to the first value that Sequential received for that anonymous id.
- A claim links a single step, not a chain of identify calls.
- A new claim can take up to 5 minutes to show.

## M–Q

- **Masking.** Hiding what people type and read in a web recording, in their browser. Under **Strict**, it also hides attribute values and most of each address. Masked text plays back as solid blocks (█), and the layout stays. [Masking and redaction](/docs/masking-and-redaction)
- **Member.** A person on your team who signs in to Sequential. [Roles and permissions](/docs/roles-and-permissions)
- **Moment.** A "where" question in your questions: did something happen, and at which event? [Customise the questions](/docs/rubric)
- **Near miss.** A session that **Ask** judged and rated close to a match, but below the cut-off. Ask does not list it. The app counts it in the first line of the answer, for example "3 of 120 sessions match, 2 more were close." An agent gets it as `near_misses`. [Ask: one line about sessions, funnels, retention or people](/docs/ask)
- **Not judgeable.** A session that is too short for **Ask** to judge. The judge does not read it. The app shows the count under the answer, for example "2 sessions were too short to judge." An agent gets it as `not_judgeable`. [Ask: one line about sessions, funnels, retention or people](/docs/ask)
- **Not measured.** A case stage: Sequential could not compare the sessions before and after the release. The case says why. It is never a count of 0. [Cases and fixes](/docs/findings)
- **Organisation.** The company or team that owns your projects and members. [Organisations, projects and keys](/docs/organisations-and-projects)
- **Policy version.** The version of the recording settings that a session was recorded under. [Recording settings](/docs/recording-settings)
- **Project.** One app or site in your organisation. [Organisations, projects and keys](/docs/organisations-and-projects)
- **Questions.** Your project's questions, up to 24, that the judge answers for every judged session. They are on the **Questions** page, in the left rail. Until 19 October 2026, the app called them the rubric. [Customise the questions](/docs/rubric)

### More about M–Q terms

- **Masking:** The person's browser does it before it sends anything. Sequential's servers mask attribute values, addresses, input values and DevTools addresses again when a recording arrives. The preset is **Strict** (the default), **Balanced** or **Custom**. Mobile apps set masking in their own code.
- **Member:** A member has one role in your organisation. Do not confuse a member with a *user* of your product.
- **Moment:** Examples are a struggle or a drop-off. On **Evidence**, a card shows its moment, such as "Struggled at 0:42". **The judge's moments**, under the player, go to it.
- **Near miss:** Its match is at least 0.2 and less than 0.4. If an answer has no results but has near misses, the judge read sessions and none matched. This is true in the app and for an agent.
- **Not judgeable:** Such a session has fewer than 3 events that the judge can read.
- **Not measured:** For example, "Four weeks after 1.4.2, too few sessions came to tell whether it worked."
- **Organisation:** It holds your members' roles, invitations, the two-factor requirement and the audit log.
- **Policy version:** It goes up by one each time someone saves the recording settings. After a save, **Settings** › **Recording & data** says, for example, "Saved as version 4."
- **Project:** It has its own ingest keys, data, recording settings and questions. Every report shows one project at a time: the one picked in the project switcher at the top of the left rail.
- **Questions:** Examples: Intent, Outcome, Friction, Hit an error and Worth watching. Owners and admins edit them. Every role can read them.

## R

- **Rage click and dead click.** Repeated clicks on one spot, and a click that gets no response. Sequential stores them only when the sending SDK detects them. The Sequential SDK sends neither yet. [Events](/docs/events)
- **Recorder.** Sequential's web script that records the screen, masks it in the browser and uploads it. [Session replay (web)](/docs/session-replay)
- **Recording.** The captured screen of one session. [Find and replay sessions](/docs/sessions-and-replay)
- **Recording settings.** A project's rules for what Sequential records and how. [Recording settings](/docs/recording-settings)
- **Redaction.** Sequential replaces values that have a recognisable shape with `[redacted]`. It does not redact a name or an address in a console message. [Masking and redaction](/docs/masking-and-redaction)
- **Release basis.** A way to measure a case after a release: only the sessions that carry the fix release, and no other release, count. Sequential uses it when your events report the release. [Cases and fixes](/docs/findings)
- **Release marker.** A record that you shipped a version, and which cases it is for. You send it with an access token, for example from CI. [Cases and fixes](/docs/findings)
- **Replay key.** The project's **Session replay** ingest key. Keep at least one replay key active. [Organisations, projects and keys](/docs/organisations-and-projects)
- **Replay period.** How long a recording stays viewable: 30 days by default. The storage deletes the recording files about 2 days after it ends. [Retention and deletion](/docs/retention-and-deletion)
- **Retention (data).** How long Sequential keeps what it collects. Events stay for the organisation's events retention period, 365 days by default. The storage deletes recording files about 2 days after the replay period. Sequential sets both periods for each organisation. A server can set a shorter limit for every project. [Retention and deletion](/docs/retention-and-deletion)
- **Retention (report).** Workbench › **Retention**: the share of people who did a return event exactly N days after their first start event. [Retention](/docs/retention)
- **Role (organisation).** A member's permission level: owner, admin, member or viewer. [Roles and permissions](/docs/roles-and-permissions)
- **Role (question).** A tag that connects one of your questions to a place in the product. [Customise the questions](/docs/rubric)
- **Rubric.** The old name of your project's **Questions**. The API and the agent tools keep it, for example `get_rubric`. [Customise the questions](/docs/rubric)
- **Rubric hash.** A fingerprint of everything that the judge reads from your questions. [Customise the questions](/docs/rubric)
- **Rubric version.** The count of saves of your questions. The line under the title of the **Questions** page shows it, for example "version 3". [Customise the questions](/docs/rubric)

### More about R terms

- **Rage click and dead click:** A rage click is repeated clicks on one spot. A dead click is a click that gets no response. Sequential stores them as events.
- **Recorder:** It uploads under your analytics SDK's session id. The Sequential SDK and the Smartlook compatibility script start it for you.
- **Recording:** The replay player plays it back with the session's events on its timeline. On the web, the recorder makes it. On iOS and Android, PostHog's mobile SDK makes it.
- **Recording settings:** They cover on or off, platforms, sampling, which pages, masking and DevTools captures. They are under **Settings** › **Recording & data**. Owners and admins can change them.
- **Redaction:** It applies in DevTools data and stored URLs. Examples: email addresses, card numbers, JWTs and `Bearer` credentials. It is always on. It matches shapes, not meaning.
- **Replay key:** The web recorder uses it. The Sequential SDK and the Smartlook compatibility script fetch it themselves.
- **Replay period:** Sequential counts it from when the first part of the recording arrived. The organisation has one replay period for all its projects. **Settings** › **Recording & data** shows it under **How long data is kept**, as **Recordings**, for example "30 days". When the period ends, you cannot play the recording. The player shows "This recording has expired."
- **Retention (data):** Events, and the user, session and account records, stay for the organisation's events retention period: 7, 30, 90, 180 or 365 days, counted from when each event arrived, and up to about a week longer. Recordings stop being viewable after the replay period, and the storage deletes their files about 2 days later. Some derived data expires on fixed periods that you cannot change, unless the server sets a shorter [limit](/docs/retention-and-deletion#a-server-wide-limit):
  - judgments: about 400 days after the session ends
  - **Right** and **Wrong** checks: about 400 days after someone gave them
  - Ask searches: after about 180 days
- **Retention (report):** It puts each person in a cohort by the UTC day of their first start event. With **New people**, the default, that is their first start event ever, and that day must be in the window. With **Everyone active**, it is their first start event in the window. Then it shows the share of people who did a return event exactly N days later. By default, both events are any event, and N is 1, 7, 14 and 28.
- **Role (organisation):** A member has a role per organisation, and it applies to every project in it. There are no project-level roles.
- **Role (question):** The roles are **Intent**, **Outcome**, **Friction**, **Worth watching**, **Struggle**, **Goal** and **Drop-off**. Only one question can hold each role.
- **Rubric:** The API paths keep the name, such as `/api/projects/:id/rubric`.
- **Rubric hash:** After a new hash, the page of a session judged before it says "The questions changed since; this reading is from the earlier version." A new hash also starts new counts in **How often people agree with the judge**.
- **Rubric version:** It is separate from the hash. A save that changes only question names or weights gets a new version. The hash stays the same.

### Rage clicks and dead clicks per SDK

| SDK | Rage clicks | Dead clicks |
|---|---|---|
| PostHog | Sends them by default | Sends them only if you set `capture_dead_clicks: true` when you initialise it |
| Mixpanel | Its autocapture can send them | Its autocapture can send them |
| Sequential SDK | Does not send them yet | Does not send them yet |

### What changes the rubric hash

The hash covers these parts of the questions, in order:

- each enabled question's text and criteria
- each option's key with its criteria, or its label when the option has no criteria
- each level's label and criteria

| Change | Changes the hash? |
|---|---|
| Rename a level | Yes |
| Rename an option that has no criteria | Yes |
| Reorder options or levels | Yes |
| Change question labels | No |
| Change roles | No |
| Change weights | No |
| Change the summary wording | No |
| Change the order of questions | No |

## S

- **Sampling.** The share of sessions that a project records: by default 100 % for production and 10 % for staging and development. [Recording settings](/docs/recording-settings)
  - A sampled recording can still end early. **Longest recording** and **Largest recording** under **Settings** › **Recording & data** › **Recording** cut a long recording short. The defaults are 60 minutes and 25 MB.
- **Saved view.** A filter, flow, funnel, retention view or sessions search that you saved by name. It belongs to the project, and everyone in the project sees it. [Filters, date ranges and saved views](/docs/filters-and-saved-views)
- **Scale.** A question with ordered levels, lowest first, such as Friction. [Customise the questions](/docs/rubric)
- **Scroll map.** The **Scroll depth** card on Workbench › **Heatmaps**. For each 5 % of a page, it shows the share of the sampled views that scrolled which saw all of that part. Bands on a bar beside the page picture show it. [Heatmaps](/docs/sessions-and-replay#the-scroll-map)
- **Session.** One visit, as your analytics SDK defines it. It is not a sign-in session. [Sessions](/docs/sessions)
- **Session id.** The value on each event that groups it into a session and joins it to the recording. An event without one still counts as an event. It is never a session: **Evidence** and Workbench › **Sessions** do not list it, and Sequential never judges it or links it to a replay. [Sessions](/docs/sessions)
- **Signal.** A yes-or-no question, such as Hit an error. [Customise the questions](/docs/rubric)
- **Source.** The channel that data arrives through, such as PostHog. Each source has its own ingest key. [Organisations, projects and keys](/docs/organisations-and-projects)
- **Super property.** A property that you register with `sequential.register()`. Call `register()` on every page load. [Send custom events](/docs/custom-events)
- **System event.** SDK housekeeping, such as `$pageleave`. **What they did**, under the player, shows system events only when you turn on **All**. [Events](/docs/events)

### More about S terms

- **Sampling:** Sequential decides once per session, so sampling never records part of a session. Sequential never samples analytics events. Your value is under **Settings** › **Recording & data** › **Recording** › **Share of sessions recorded**.
- **Saved view:** The **Board**, in the left rail, shows the saved funnels, retention views and sessions searches of the selected project. Owners, admins and members can rename and remove any of them. Viewers can only open them. Each card shows who changed it last. To save a filter, flow, funnel or retention view, use the card of saved views on its Workbench page, such as **Saved funnels** on Workbench › **Funnels**. Owners, admins and members can rename and delete views there too. On **Saved funnels**, they can also pin one funnel to the [Simple view](/docs/simple-view). To save a sessions search, click **Save to Board** on Workbench › **Sessions**. **Past filters**, on Workbench › **Sessions** and **Events** and on **People**, is not a saved view: it is your own list of the filters that you applied, and nobody else in the project can read it.
- **Scale:** The judge gives a probability for each level.
- **Session:** A session is all the events, and at most one recording, that share a *session id* in a project. **Settings** › **Security** lists sign-in sessions.
- **Session id:** Your SDK supplies it, and Sequential stores it exactly as sent.
- **Signal:** Another example is Worth watching. The judge gives the probability of yes.
- **Source:** The sources are Sequential, PostHog, Mixpanel, Amplitude, Pendo, Smartlook and Session replay. Every event records the SDK that sent it.
- **Super property:** You register it once. The Sequential SDK then adds it, as an event property, to every later event from the same page. It lasts only as long as the page.
- **System event:** Other examples: `$web_vitals` and `$set`. A system event is not something the person did. Sequential stores system events and counts them in charts. The digest leaves them out.

## T–W

- **The judge was unsure.** A lane of **Evidence**. It holds judged sessions where the judge could not tell what the person came to do, or how the session ended. [Evidence: the sessions worth a look](/docs/watch)
- **Time basis.** A way to measure a case after a release when your sessions do not report the release: the sessions that started 2 hours or more after the release count. [Cases and fixes](/docs/findings)
- **Try on a session.** A panel of the question editor that judges your unsaved draft on one recent session. Every run is a real judgment. [Customise the questions](/docs/rubric)
- **Two-factor authentication.** A code from an authenticator app, asked for at sign-in with a password, or with Google when Google sign-in is available. [Two-factor authentication and account security](/docs/two-factor-and-security)
- **Unclear.** An answer that means the judge could not tell from the session's events. It is not the same as no. [Reading a verdict](/docs/reading-verdicts)
- **User.** A person who uses your product, known by one *user id*. [Users and identity](/docs/users-and-identity)
- **User property.** A property of the person, such as their plan. Only some SDKs store them. [Users and identity](/docs/users-and-identity)
- **Verdict.** The judge's best answer to one of your questions, with its likelihood. It is a forecast, not a case. [Reading a verdict](/docs/reading-verdicts)
- **Window.** The days that a Workbench view counts. Each view keeps its own window. [Filters, date ranges and saved views](/docs/filters-and-saved-views)
- **Worth watching.** One of the default questions: should a product manager watch this recording? [Evidence: the sessions worth a look](/docs/watch)

### More about T–W terms

- **The judge was unsure:** No signal of the judge fired in these sessions. This is a result, not a failure.
- **Try on a session:** To use it, pick a session in its list and click **Try it**. You see the answers before you save. It uses the daily allowance for **Try on a session**.
- **Two-factor authentication:** Sequential asks for the code when you sign in with a password, or with Google when Google sign-in is available. An organisation can require it of every member.
- **Unclear:** An unclear answer is a result, not a failure. Sequential keeps "I don't know" apart from "I don't think so" on purpose. On the page of a session, an unclear signal shows after "The judge leans toward, but is not sure of:".
- **User:** Before your app identifies them, the user id is the anonymous id. After that, it is the value that your app passes. Each user id is one row on **People**. With the Sequential SDK, PostHog or Mixpanel, an anonymous id that is linked to one identified value is counted in that value's row.
- **User property:** It describes the person, not one event. User properties show as **Visitor property** in the filter bar, and under **What your app sent about them** on a person's page in **People**. The **Info** tab of a session page shows them under **Their properties**.
- **Verdict:** Example: "Buy or subscribe" at 81 %. On the **Questions** page, the questions that pick one answer from a list, such as Intent, are under **What they came to do and how it ended**.
- **Window:** Each Workbench view has a **Window** of whole UTC days, today included, such as **7 days**, **14 days**, **30 days** or **90 days**. A valid window applies at once. There is no **Apply** button. The view keeps its window in its address.
- **Worth watching:** It is a yes-or-no question. It has the largest default **Attention weight**. On the page of a session, its reading reads **Worth watching** or **Not worth watching**. **Right** and **Wrong** beside it record whether it was right.

### User properties per SDK

| SDK | Stores user properties? |
|---|---|
| Pendo | Yes |
| Amplitude, with `Identify` | Yes |
| Smartlook compatibility script, with `identify` | Yes |
| Sequential SDK | No |
| PostHog | No |
| Mixpanel, with the browser `people.set` | No |

### How the attention score is calculated

- Each weighted yes-or-no question adds its weight times the probability of yes.
- Each weighted scale adds its weight times how far up the scale the session sits.

The default weights:

| Question | **Attention weight** |
|---|---|
| Worth watching | 0.45 |
| Friction | 0.25 |
| Hit an error | 0.15 |
| Product bug | 0.15 |

## Related

- [Troubleshooting](/docs/troubleshooting)
- [Limits](/docs/limits)
- [Support matrix](/docs/support-matrix)
- [What is Sequential](/docs/what-is-sequential)
