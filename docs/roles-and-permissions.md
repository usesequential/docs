# Roles and permissions

> Everyone in an organisation has one of four fixed roles: Owner, Admin, Member or Viewer. A role applies to every project in the organisation.

> **In short**
>
> - There are four fixed roles: **Owner**, **Admin**, **Member** and **Viewer**.
> - A role applies to every project in the organisation. There are no per-project roles.
> - Owners and admins manage members, projects, keys, access tokens and settings. Only an owner can delete the organisation or manage other owners.
> - A viewer is not read-only. A viewer can use **Ask**, ask the judge to read a session with **Judge this recording now**, and mark the judge's readings **Right** or **Wrong**.
> - You cannot suspend a person. To end their access, remove them.

## What it is for

Use this page to choose a role for each person. For typical cases, see **Typical cases** below.

## How roles work

- **A role belongs to the organisation.** There are no per-project roles and no custom roles.
- **To limit a person to some projects, put those projects in a different organisation.** See **Limits** for when the app lets you create one.
- **A person has one role in each organisation.** Settings › **Project** and Settings › **Organisation** show **Your role** there.
- **The person who creates the organisation is its first owner.**

### Typical cases

| Case | What to do |
|---|---|
| A contractor must open replays but not change settings. | Give them **Viewer**. They see every project in the organisation, not only their project. |
| You want to move an app to a new ingest key and turn off the old key. | An owner or an admin can rotate the key. |
| Your support lead wants to add a question to the project's questions. | They need **Admin** or **Owner**. |
| A CI job must mark releases. | An owner or an admin creates an access token with the `releases:write` scope. |
| A person left the company. | An owner or an admin removes them. If the person was an owner, another owner must remove them. Sequential also ends the claude.ai connections that the person made. |
| An admin becomes a member. | The claude.ai connections that they made stay, except a connection with `changes:read_sensitive`. Sequential ends that connection. A member keeps every other scope of a connection. |
| A person who created an access token leaves, is removed, is no longer an owner or admin, or their account is deleted. | From 20 October 2026, Sequential marks the token. It stops working 7 days after the mark, unless an owner or admin adopts it: **Adopt…** on Settings › **Agents & tokens**, or the API. Its `exports:write` and `changes:read_sensitive` stop at once. If it can write organisation-wide changes, that stops at once too. The owners and admins get an email. See [Limits and defaults](/docs/limits). |
| A person who created an access token with `exports:write` stops being an owner or admin, or leaves. | The token stops exporting. Each export call gets 403 `export_creator_not_admin`. The exports that were already made stay, and the other owners and admins can still download them. To export with a token again, an owner or admin creates a new token. See [Export your data](/docs/export-your-data#use-the-api-with-an-access-token). |
| An admin or a member becomes a viewer. | Sequential ends each claude.ai connection that they made in this organisation and that has `ask:use`, `findings:link`, `insights:propose`, `changes:propose` or `changes:read_sensitive`. **Read and investigate** has `ask:use`. Giving the role back does not bring an ended connection back. See [Connect claude.ai](/docs/connect-claude-ai). |

### More about how roles work

- A viewer is a viewer on every project in the organisation.
- A person can belong to several organisations.
- **The server checks every request.** The screens hide or disable most actions that your role cannot do. If a request comes in for one of these actions anyway, the server refuses it.

### How Settings picks the organisation

Settings › **Members** and Settings › **Organisation** show one organisation at a time: the organisation of the open project. What you can change there follows your role in that organisation.

To open another organisation of yours, pick one of its projects in the switcher. A link that ends in `?org=` and the organisation's id also opens it, also when it has no projects. If the link names an organisation that you are not in, the page says "You are not a member of that organisation." and lists your organisations.

### What people outside the organisation see

Sequential gives someone outside your organisation the same answer for your projects as for projects that do not exist. They cannot find which of your projects exist.

## What each role can do

| What you can do | Owner | Admin | Member | Viewer |
|---|:-:|:-:|:-:|:-:|
| Open **Brief**, **Cases**, **Ask**, **Evidence**, **People**, **Changes**, **Agents**, **Questions**, **Workbench** and **Board**; read **Recording & data** and **Setup**; mark the judge's readings **Right** or **Wrong** | ✓ | ✓ | ✓ | ✓ |
| See and copy ingest keys | ✓ | ✓ | ✓ | — |
| Save, rename and remove the project's saved views | ✓ | ✓ | ✓ | — |
| Change the questions, recording settings, projects and keys; manage access tokens and members; read the **Audit log** | ✓ | ✓ | — | — |
| Export a project's events and sessions, and download the files (Settings › **Data out**) | ✓ | ✓ | — | — |
| Delete the organisation | ✓ | — | — | — |

The full list is in **Full permission table** below.

Every role sees every section of **Settings**. A section says what your role can do there. The controls that your role cannot use are off.

- Only an owner can invite a person as an owner, make a person an owner, or change or remove an owner.
- Nobody can remove the only owner or change their role. The only owner cannot leave the organisation.
- Every person, whatever their role, manages their own **Your profile** and **Security** settings. Every person can also send feedback to the Sequential team with **Send feedback to Sequential** in the rail. They see their own feedback under Settings › **Your profile**, in **Feedback to Sequential**.
- A viewer starts in [Simple view](/docs/simple-view) the first time a browser has no choice yet: a short rail and three cards in place of the **Brief**. Owners, admins and members start with the full rail. Every role can turn Simple view on or off in the account menu. Simple view changes no permission.
- Sequential staff can also make support changes: change a project's settings, archive or restore a project, revoke an ingest key or an access token, and turn the two-factor requirement on or off. The [audit log](/docs/audit-log#changes-by-sequential-support) names them "Sequential support". It never shows the name of the staff member.

### Full permission table

| What you can do | Owner | Admin | Member | Viewer |
|---|:-:|:-:|:-:|:-:|
| See **Workbench** (Events, Funnels, Retention, Flows, Heatmaps, Accounts, Sessions), **People** and **Evidence** | ✓ | ✓ | ✓ | ✓ |
| Open the project's saved views | ✓ | ✓ | ✓ | ✓ |
| Save, rename and remove saved views, also those that someone else saved | ✓ | ✓ | ✓ | — |
| Pin a saved funnel to the [Simple view](/docs/simple-view), or unpin it | ✓ | ✓ | ✓ | — |
| Use **Ask** | ✓ | ✓ | ✓ | ✓ |
| Mark the judge's readings **Right** or **Wrong** | ✓ | ✓ | ✓ | ✓ |
| Ask the judge to read a session now (**Judge this recording now**, **Judge again**) | ✓ | ✓ | ✓ | ✓ |
| Open a session's replay and **The judge's reading** | ✓ | ✓ | ✓ | ✓ |
| See the **Questions** page and **How often people agree with the judge** | ✓ | ✓ | ✓ | ✓ |
| Edit the questions (**Edit questions**), go back to the defaults (**Restore defaults**), **Apply** or **Reject** a proposed edit, and use **Try on a session** | ✓ | ✓ | — | — |
| See recording settings (Settings › **Recording & data**) | ✓ | ✓ | ✓ | ✓ |
| Change recording settings | ✓ | ✓ | — | — |
| See Settings › **Project**, **Recording & data** and **Setup** | ✓ | ✓ | ✓ | ✓ |
| Create a project | ✓ | ✓ | — | — |
| Rename a project, or change its slug or environment (**The project** on Settings › **Recording & data**) | ✓ | ✓ | — | — |
| Archive, unarchive or delete a project (Settings › **Recording & data**; unarchive and delete also on **All projects**) | ✓ | ✓ | — | — |
| Start an export, see the project's exports and download the files (Settings › **Data out**). Members and viewers see only the sentence "Only owners and admins can export data, because an export holds personal data." | ✓ | ✓ | — | — |
| See **Changes** | ✓ | ✓ | ✓ | ✓ |
| Record, retract and restore changes; confirm or reject proposals; link changes to cases | ✓ | ✓ | ✓ | — |
| Read admins-only changes; record changes for the whole organisation | ✓ | ✓ | — | — |
| See and copy ingest keys: Settings › **Keys**, and the install snippet and **Install with your AI agent** on Settings › **Setup** | ✓ | ✓ | ✓ | — |
| Create, rotate and revoke keys; register a Pendo API key | ✓ | ✓ | — | — |
| See the list of server keys on Settings › **Keys** | ✓ | ✓ | ✓ | — |
| Create and revoke server keys for the [backend SDK](/docs/backend-sdk) | ✓ | ✓ | — | — |
| See, create, revoke and adopt access tokens (**This project’s tokens** and **Make a token** on Settings › **Agents & tokens**), and see the activity of every agent on **Agents** | ✓ | ✓ | — | — |
| Disconnect or cancel any connection of the project on **Agents** | ✓ | ✓ | — | — |
| Create an agent token in onboarding, or with **Add an agent access token to this prompt** on Settings › **Setup** | ✓ | ✓ | — | — |
| Set a verdict on a case: **Confirm problem**, **Dismiss…** (**Not a problem** or **Won’t fix**) or **Reopen** | ✓ | ✓ | ✓ | — |
| Hand a case to an agent (**Hand to an agent** or **Copy brief for an agent**), and approve or decline an agent's request (**Approve hand-off**, **Decline**) | ✓ | ✓ | — | — |
| Copy a new case's brief with **Copy brief**. This marks the case as handed off | ✓ | ✓ | ✓ | ✓ |
| Invite people with **Invite people** in the rail, with your own role or a lower one | ✓ | ✓\* | ✓† | ✓† |
| Invite people on Settings › **Members**, with your own role or a lower one | ✓ | ✓\* | ✓† | ✓† |
| Send invitations again (**Send again**) | ✓ | ✓\* | ✓†‡ | ✓†‡ |
| Cancel invitations (**Cancel invitation…**) | ✓ | ✓ | ✓‡ | ✓‡ |
| Change **Who may invite** on Settings › **Organisation** | ✓ | ✓ | — | — |
| Open **Agents** and connect claude.ai. Members and viewers see only their own agents on **Agents**. They disconnect or cancel their own connections there, and under **Your connections** on Settings › **Agents & tokens**. A viewer's connection reads and can send feedback, nothing more | ✓ | ✓ | ✓ | ✓ |
| Use **Ask your agent** on a session, an error or an empty **Cases** list. Its last line links to **Agents**: owners and admins set up an agent there, and members and viewers connect claude.ai there | ✓ | ✓ | ✓ | ✓ |
| Change members' roles | ✓ | ✓\* | — | — |
| Remove members | ✓ | ✓\* | — | — |
| Rename the organisation (only its name: its slug cannot change after you create it); turn the two-factor rule on or off (**Require two-factor**, **Make two-factor optional**) | ✓ | ✓ | — | — |
| Delete the organisation | ✓ | — | — | — |
| Read the **Audit log** on Settings › **Organisation** and a project's **Recent changes** on Settings › **Recording & data** | ✓ | ✓ | — | — |

\* An admin cannot do this for an owner. Only an owner can invite a person as an owner, make a person an owner, or change or remove an owner. The role lists on Settings › **Members** and in the **Invite people** dialog do not show **Owner** to an admin.

† Only while **Who may invite** is **Every member, up to their own role**. It is on by default. A member invites members and viewers. A viewer invites viewers.

‡ Only the invitations that they sent. **Cancel invitation…** works also while only owners and admins invite.

### Role descriptions in the app

When you invite a person with **Invite people** in the rail, the dialog shows a sentence under **Role** for each role that you can give:

| Role | In the app |
|---|---|
| **Owner** | "An owner can do everything an admin can, and also delete the organisation." |
| **Admin** | It says that an admin can do everything a member can. An admin can also hand fixes to agents and approve their hand-offs, change roles, remove people, and change project settings and keys. |
| **Member** | "A member can do everything a viewer can, and also accept or dismiss findings and record changes." |
| **Viewer** | "A viewer can see every case, recording and chart, use Ask, copy a case’s brief (which marks it handed off) and mark the judge’s readings Right or Wrong." |

Viewer is not read-only: a viewer can use **Ask**, copy a brief and give **Right** or **Wrong**. See **Cases to know about** below.

Settings › **Members** also has **What each role can do**: a sentence for each role, and **Every permission, role by role** under it. Sequential reads both from the backend.

## Change someone's role

1. Open Settings › **Members**. Only owners and admins can change roles.
2. Under **People**, find the person. If the organisation has 9 or more members, you can type a name or an email in **Find a member…**.
3. Pick a new role from the list in their row.
4. Click the **Make …** button that names the role, for example **Make admin**. A message confirms the change.

The new role applies from the person's next request. They do not need to sign out. The app reads their role again when they come back to its tab, or when they reload the page.

### What the People list shows

- Owners and admins see each member's role, two-factor ("Two-factor on" or "No two-factor") and last active day.
- The last active day is "Active today", "Active yesterday" or "Last active" and a date. A person with no recorded sign-in shows "Not active yet". It never shows a time or a device. Sequential records sign-ins only from 11 October 2026. So "Not active yet" does not mean that the person never signed in. From 23 October 2026, a click on the link in the email that verifies a new address also counts as a sign-in.
- Members and viewers see each person's name, email and role. Sequential does not send them the two-factor and last active facts. They see "Owners and admins also see who uses two-factor and when each person was last active."
- **Require two-factor** is on Settings › **Organisation**, under **Two-factor for everyone**. See [Two-factor authentication and account security](/docs/two-factor-and-security).

To choose a role before a person joins, pick it under **Role** when you invite them. The default is **Member**. See [Sign-up and invitations](/docs/sign-up-and-invitations).

### Hand over ownership

There is no transfer button. Do these steps:

1. As an owner, change the new person's role to **Owner**: pick **Owner** in their row, then click **Make owner**.
2. Change your own role in your row, ask the new owner to change it, or leave the organisation.

To leave, see **Leave an organisation** below. Keep at least two owners. Then the organisation does not depend on one person's account.

### When a role change is refused or locked

If Sequential refuses the change, the row shows why.

Some rows have no role list. The row shows the role as text, and a line under the row says why:

| Case | Line |
|---|---|
| It is an owner, and you are an admin | "Only an owner changes an owner’s role." |
| It is your own row, and you are the only owner | "You are the only owner: make someone else an owner before you change your own role." |

Members and viewers see no role lists. They see, for example, "Owners and admins change roles and remove members; you are a member."

## Remove someone

1. Open Settings › **Members**.
2. In the person's row, click **Remove…**.
3. Read what removing does, then click the **Remove …** button with the person's name. A message confirms it.

From their next request, the person cannot open anything in your organisation. Nobody can remove the only owner.

### What stays after you remove someone

- Their Sequential account and their other organisations do not change.
- Their past entries stay in the [Audit log](/docs/audit-log). The log names them "Someone no longer in the organisation".
- Only an owner can remove an owner.

### Leave an organisation

Any person except the only owner can leave.

1. If you belong to several organisations, pick one of this organisation's projects in the switcher.
2. Open Settings › **Members**.
3. Under **Leave the organisation**, click the **Leave …** button that shows the name of your organisation.
4. Click **Leave …** again to confirm. This takes effect at once.

You lose access to every project in the organisation. An owner or an admin can invite you again. While **Who may invite** is **Every member, up to their own role**, a member or viewer can invite you too, with their own role or a lower one.

The only owner sees "You are the only owner. Make someone else an owner first, or delete the organisation."

## Cases to know about
- Only owners and admins can switch background judging off or on, with **Judge new sessions automatically** under **Judging** on Settings › **Recording & data**. Members and viewers see the switch, but they cannot change it.
- **Ask** in the app and background judging have separate daily allowances. Heavy use of **Ask** does not stop background judging.
- Every role can click **Copy brief** on a new case. This marks the case as handed off.

> **A viewer is not read-only**
>
> Every role, **Viewer** included, can use **Ask** and **Judge this recording now**, and mark the judge's readings **Right** or **Wrong**. **Ask** uses the project's daily Ask allowance. **Judge this recording now** uses the project's daily allowance for judging on demand. The allowances are per project, not per person. So one person can use all of the day's allowance for the whole team.

- **A viewer's Right or Wrong counts the same as an admin's.** It feeds **How often people agree with the judge** on the **Questions** page. See [Feedback and calibration](/docs/feedback-and-calibration).
- **The two-factor requirement applies to every role.** When **Require two-factor** is on, Sequential blocks a person from the organisation's projects unless they have two-factor set up and signed in with a code or a trusted device. See [Two-factor authentication and account security](/docs/two-factor-and-security).

### AI judging and allowances

- **Viewers can use Ask.** **Ask** uses the project's daily Ask allowance. See [Ask](/docs/ask).
- **Ask** uses a separate daily allowance. Background judging has its own.
- **Viewers can use Judge this recording now.** It uses the project's daily allowance for judging on demand, apart from the allowances of **Ask** and background judging. See [Reading an AI verdict](/docs/reading-verdicts).

### Feedback and two-factor details

- Any role can mark a reading **Right** or **Wrong** in **The judge's reading** on a session's page.
- Each person's latest answer feeds **How often people agree with the judge** on the **Questions** page.
- The two-factor block stays until the person has set up two-factor authentication and signed in with a code or a trusted device.

### Saved views by role

- Saved views belong to the project, not to the person who saved them. Owners, admins and members can rename and remove any of them.
- Viewers see and open saved views. On the **Board**, a viewer sees, for example, "Viewers can read the project’s saved answers but not remove them."
- On Workbench › **Events**, **Sessions**, **Funnels**, **Flows** and **Retention**, a viewer sees no save, rename, delete or pin button. The card says, for example, "Viewers can open the project’s saved funnels but not save, rename or delete them." On **Funnels**, a viewer has no **Save as a view** button and no `s` key.
- See [Filters, date ranges and saved views](/docs/filters-and-saved-views).

### Keys and access tokens by role

- **Members can copy ingest keys but not manage them.** Ingest keys are not secrets, because your site's pages contain them. This rule only controls who manages the install. See [Organisations, projects and keys](/docs/organisations-and-projects).
- **Viewers do not see the keys.** On Settings › **Keys**, they see "Viewers do not see ingest keys. Ask an owner or admin if you need one." On Settings › **Setup**, they see "The install snippet needs a member, admin or owner — ask one for the keys." in place of the snippet.
- **Server keys are secrets.** A server key lets your own server send events with the [backend SDK](/docs/backend-sdk). Members see the list of server keys: each label and the last 4 characters. Only owners and admins create and revoke them. Viewers do not see them.
- **Only owners and admins see the project's access tokens.** Members and viewers see Settings › **Agents & tokens** without **This project’s tokens**. They see **Connect an agent**, **Your connections** and **Your tokens in other projects**. The **Make a token** form is off for them, with, for example, "You are a viewer: only owners and admins make, revoke and adopt tokens."
- **A token cannot manage tokens.** To create, revoke or adopt a token, an owner or admin must be signed in.
- **A token depends on its creator.** From 20 October 2026, a token stops working 7 days after its creator loses access, unless an owner or admin adopts it. See [Limits and defaults](/docs/limits).
- **A token with `exports:write` exports only while the person who created it is an owner or admin.** Sequential checks this at each export call. If that person is now a member or viewer, or left the organisation, the call gets 403 `export_creator_not_admin`. See [Export your data](/docs/export-your-data#use-the-api-with-an-access-token).
- **Only owners and admins can read agent activity.** GET `/api/projects/:id/agent-activity` gives the tool calls of the project's tokens. It needs the same permission as the token list, and a signed-in session. The **Agents** page shows it too. See [Limits](/docs/limits).
- **Every role can see whether an agent is connected.** GET `/api/projects/:id/status` gives every role that can read the project `agent.connected` and `agent.regular`. `connected` says whether a token that counts as an agent exists. `regular` says whether one such token called Sequential on 3 or more of the last 7 days. The answer has no token names, ids, dates or counts. A value that Sequential could not read is `null`. Settings › **Project** says it in one line, for example "An agent is connected and calls Sequential regularly (on 3 or more of the last 7 days)."
- **Every role gets Agents in the rail and in Ask or jump.** In [Simple view](/docs/simple-view), the rail does not show it, but Ask or jump does. Owners and admins see every agent of the project and its activity. Members and viewers see "Only owners and admins see every agent; here is your own:" and only their own connections. From 19 October 2026, they see the calls of their own connections only. They can disconnect their own connections there, or cancel one that is still connecting. If Sequential cannot read their own connections, the page says "Your own connections could not be read just now, so they cannot be disconnected here." with **Try again**. Sequential does not give them the project's token list or the activity of the whole project. Under **Connect an agent**, they see, for example, "You are a member: only owners and admins make tokens. You can connect claude.ai yourself."
- **Every person can see and end their own claude.ai connections through the API.** GET `/api/projects/:id/tokens/mine` lists only the connections that you made. POST `/api/projects/:id/tokens/mine/:tokenId/revoke` ends one of them. From 19 October 2026, GET `/api/projects/:id/agent-activity/mine` shows the calls of only the connections that you made. Access tokens and the connections of other people are not included: for them, the answer is 404. **Your connections** on Settings › **Agents & tokens** uses the first two routes. The **Agents** page uses all three for members and viewers. Every role can connect claude.ai. A viewer's connection reads, and can send feedback for the viewer when they tick **Also: it sends feedback to Sequential**. It cannot use **Ask**, link fixes or propose questions. When a viewer connects, the page says what the connection cannot do, for example "With your role in this project, the connection can read. It cannot use Ask, link fixes or propose questions." If a person becomes a viewer, Sequential ends each of their connections that holds Ask, fix links or proposals. In onboarding, members and viewers see that only owners and admins make tokens for a coding agent. While the step has a **claude.ai** tab, they also see that claude.ai works for every role. They do not get **Add an agent access token to this prompt** on Settings › **Setup**.
- **A token can never set a verdict.** A verdict on a case needs a person. See [Limits](/docs/limits).

## Limits

- There are four fixed roles. You cannot create custom roles or give a person a role on one project only.
- You cannot suspend a person. Removing them is the only way to end their access.
- Owners and admins cannot reset the password or two-factor authentication of another member. They cannot sign out another member's devices.
- An organisation can have up to 100 members and 100 pending invitations.
- If you are an owner or admin of an organisation, you cannot create a second organisation from the app.
- An access token cannot create or revoke tokens. It cannot set a verdict on a case. These actions need a signed-in person.

## Related

- [Organisations, projects and keys](/docs/organisations-and-projects)
- [Limits](/docs/limits)
- [Sign-up and invitations](/docs/sign-up-and-invitations)
- [Two-factor authentication and account security](/docs/two-factor-and-security)
- [Audit log](/docs/audit-log)
- [Ask: one line about sessions, funnels, retention or people](/docs/ask)
- [Feedback and calibration](/docs/feedback-and-calibration)
- [Customise the questions](/docs/rubric)
- [Recording settings](/docs/recording-settings)
