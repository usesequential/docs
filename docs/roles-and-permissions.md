# Roles and permissions

> Everyone in an organisation has one of four fixed roles: owner, admin, member or viewer. A role applies to every project in the organisation.

> **Key facts**
>
> - No per-project or custom roles. To limit a teammate to some projects, put those projects in another organisation; see [Limits](#limits).
> - A viewer is not read-only: they can use Copy brief and check the judge. From 11 November 2026, a viewer reads the answers that Ask, Judge this recording now and judging steps in words already gave, but cannot start a new one.
> - The Ask and Judge this recording now allowances are per project: one teammate can use all the team's daily allowance.
> - You cannot suspend a teammate. To end their access, remove them.
> - Removal or a lower role can end claude.ai connections and stop project access tokens (`sq_pat_…`); leaving can stop tokens too.

## What each role can do

A teammate has one role in each organisation. Each role can also do everything in the rows below it:

| Role | What it adds |
|---|---|
| Owner | Delete the organisation. Invite a teammate as an owner, make a teammate an owner, or change or remove an owner. |
| Admin | Change the questions, recording settings, projects and keys. Manage project access tokens (`sq_pat_…`) and teammates. Hand cases to agents. Export data. Read the Audit log. |
| Member | Set a verdict on a case. Record changes. Save, rename and remove saved views. See and copy ingest keys. |
| Viewer | See every case, recording and chart. Read Settings › Recording & data and Settings › Setup. Use Ask and Judge this recording now. Copy a case's brief. Check the judge: answer Right or Wrong on a reading. Invite teammates with your own role or a lower one, if Who may invite allows (on by default). |

The teammate who creates the organisation is its first owner. Nobody can remove the only owner or change their role.

### Full permission table

Pages, Workbench, replay and saved views:

| Action | Owner | Admin | Member | Viewer |
|---|:-:|:-:|:-:|:-:|
| Open Brief, Cases, Ask, Evidence, People, Changes, Agents, Questions, Workbench and Board | ✓ | ✓ | ✓ | ✓ |
| See Workbench (Events, Funnels, Retention, Flows, Heatmaps, Accounts, Sessions), People and Evidence | ✓ | ✓ | ✓ | ✓ |
| Open the project's saved views | ✓ | ✓ | ✓ | ✓ |
| Save, rename and remove saved views, also those that someone else saved | ✓ | ✓ | ✓ | — |
| Pin a saved funnel to the [Simple view](/docs/simple-view), or unpin it | ✓ | ✓ | ✓ | — |
| Open a session's replay and The judge's reading | ✓ | ✓ | ✓ | ✓ |

Ask, judging and questions:

| Action | Owner | Admin | Member | Viewer |
|---|:-:|:-:|:-:|:-:|
| Use [Ask](/docs/ask) | ✓ | ✓ | ✓ | ✓ |
| Check the judge: answer Right or Wrong on a reading ([Feedback and calibration](/docs/feedback-and-calibration)) | ✓ | ✓ | ✓ | ✓ |
| Ask the judge to read a session now (Judge this recording now, Judge again) | ✓ | ✓ | ✓ | ✓ |
| See the Questions page and Calibration | ✓ | ✓ | ✓ | ✓ |
| Turn background judging off or on (Judge new sessions automatically under Judging on Settings › Recording & data) | ✓ | ✓ | — | — |
| Edit the questions (Edit questions), go back to the defaults (Restore defaults), Apply or Reject a proposed edit, and use Try on a session ([Customise the questions](/docs/rubric)) | ✓ | ✓ | — | — |

Cases:

| Action | Owner | Admin | Member | Viewer |
|---|:-:|:-:|:-:|:-:|
| Set a verdict on a case: Confirm problem, Dismiss… (Not a problem or Won’t fix) or Reopen | ✓ | ✓ | ✓ | — |
| From 4 November 2026: make, change and remove mute rules (Mute cases like this, Settings › Cases), and Keep in Open | ✓ | ✓ | ✓ | — |
| From 5 November 2026: Accept or Keep open an agent's suggestion on a case | ✓ | ✓ | ✓ | — |
| From 5 November 2026: turn Let agents dismiss cases on or off | ✓ | ✓ | — | — |
| Hand a case to an agent (Hand to an agent or Copy brief for an agent), and approve or decline an agent's request (Approve hand-off, Decline) | ✓ | ✓ | — | — |
| Copy a new case's brief with Copy brief. This marks the case as handed off | ✓ | ✓ | ✓ | ✓ |
| From 11 November 2026: record that a fix is live, on the case page (The fix is live) | ✓ | ✓ | — | — |

Changes:

| Action | Owner | Admin | Member | Viewer |
|---|:-:|:-:|:-:|:-:|
| See Changes | ✓ | ✓ | ✓ | ✓ |
| Record, retract and restore changes; confirm or reject proposals; link changes to cases | ✓ | ✓ | ✓ | — |
| Read admins-only changes; record changes for the whole organisation | ✓ | ✓ | — | — |

Settings and projects:

Every role sees every section of Settings. A section says what your role can do there, and the controls that your role cannot use are off. Settings › Project and Settings › Organisation show Your role.

| Action | Owner | Admin | Member | Viewer |
|---|:-:|:-:|:-:|:-:|
| See Settings › Project, Recording & data and Setup | ✓ | ✓ | ✓ | ✓ |
| See recording settings (Settings › Recording & data) | ✓ | ✓ | ✓ | ✓ |
| Change recording settings ([Recording settings](/docs/recording-settings)) | ✓ | ✓ | — | — |
| Create a project | ✓ | ✓ | — | — |
| Rename a project, or change its slug or environment (The project on Settings › Recording & data) | ✓ | ✓ | — | — |
| Archive, unarchive or delete a project (Settings › Recording & data; unarchive and delete also on All projects) | ✓ | ✓ | — | — |
| Start an export, see the project's exports and download the files (Settings › Data out). Members and viewers see only the sentence "Only owners and admins can export data, because an export holds personal data." | ✓ | ✓ | — | — |

Keys:

| Action | Owner | Admin | Member | Viewer |
|---|:-:|:-:|:-:|:-:|
| See and copy ingest keys: Settings › Keys, and the install snippet and Install with your AI agent on Settings › Setup | ✓ | ✓ | ✓ | — |
| Create, rotate and revoke keys; register a Pendo API key | ✓ | ✓ | — | — |
| See the list of server keys on Settings › Keys | ✓ | ✓ | ✓ | — |
| Create and revoke server keys for the [backend SDK](/docs/backend-sdk) | ✓ | ✓ | — | — |

- Members can copy ingest keys but not manage them. Ingest keys are not secrets, because your site's pages contain them. This rule only controls who manages the install. See [Organisations, projects and keys](/docs/organisations-and-projects).
- Viewers do not see the keys. They see a line on Settings › Keys, and a line in place of the snippet on Settings › Setup.
- Server keys are secrets. A server key lets your own server send events with the [backend SDK](/docs/backend-sdk). Members see the list of server keys: each label and the last 4 characters. Only owners and admins create and revoke them. Viewers do not see them.

Agents and project access tokens:

| Action | Owner | Admin | Member | Viewer |
|---|:-:|:-:|:-:|:-:|
| See, create, revoke and adopt project access tokens (This project’s tokens and Make a token on Settings › Agents & tokens), and see the activity of every agent on Agents | ✓ | ✓ | — | — |
| Disconnect or cancel any connection of the project on Agents | ✓ | ✓ | — | — |
| Create an agent token in onboarding, or with Add an agent access token to this prompt on Settings › Setup | ✓ | ✓ | — | — |
| Open Agents and connect claude.ai. Members and viewers see only their own agents on Agents. They disconnect or cancel their own connections there, and under Your connections on Settings › Agents & tokens. A viewer's connection reads and can send feedback, nothing more | ✓ | ✓ | ✓ | ✓ |
| Use Ask your agent on a session, an error or an empty Cases list. Its last line links to Agents: owners and admins set up an agent there, and members and viewers connect claude.ai there | ✓ | ✓ | ✓ | ✓ |

Teammates and invitations:

| Action | Owner | Admin | Member | Viewer |
|---|:-:|:-:|:-:|:-:|
| Invite teammates with Invite people in the rail, with your own role or a lower one | ✓ | ✓, not an owner | ✓ if Who may invite allows | ✓ if Who may invite allows |
| Invite teammates on Settings › Members, with your own role or a lower one | ✓ | ✓, not an owner | ✓ if Who may invite allows | ✓ if Who may invite allows |
| Send invitations again (Send again) | ✓ | ✓, not an owner | ✓ own invitations, if Who may invite allows | ✓ own invitations, if Who may invite allows |
| Cancel invitations (Cancel invitation…) | ✓ | ✓ | ✓ own invitations | ✓ own invitations |
| Change Who may invite on Settings › Organisation | ✓ | ✓ | — | — |
| Change teammates' roles | ✓ | ✓, not an owner | — | — |
| Remove teammates | ✓ | ✓, not an owner | — | — |

Organisation and your own account:

| Action | Owner | Admin | Member | Viewer |
|---|:-:|:-:|:-:|:-:|
| Rename the organisation (only its name: its slug cannot change after you create it); turn the two-factor rule on or off (Require two-factor, Make two-factor optional) | ✓ | ✓ | — | — |
| Delete the organisation | ✓ | — | — | — |
| Read the Audit log on Settings › Organisation and a project's Recent changes on Settings › Recording & data | ✓ | ✓ | — | — |
| Manage your own Your profile and Security settings | ✓ | ✓ | ✓ | ✓ |
| Send feedback to the Sequential team with Send feedback to Sequential in the rail, and see your own feedback under Settings › Your profile, in Feedback to Sequential | ✓ | ✓ | ✓ | ✓ |

Not an owner: an admin cannot do this for an owner. Only an owner can invite a teammate as an owner, make a teammate an owner, or change or remove an owner. The role lists on Settings › Members and in the Invite people dialog do not show Owner to an admin.

If Who may invite allows: only while Who may invite is Every member, up to their own role. It is on by default. A member invites members and viewers. A viewer invites viewers.

Own invitations: only the invitations that they sent. Cancel invitation… works also while only owners and admins invite.

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Viewers do not see ingest keys. Ask an owner or admin if you need one." | Settings › Keys, for viewers | Viewers do not see the keys. | — |
| "The install snippet needs a member, admin or owner — ask one for the keys." | Settings › Setup, for viewers, in place of the snippet | Viewers do not see the keys. | — |

## Choose a role

| Case | What to do |
|---|---|
| A contractor must open replays but not change settings. | Give them Viewer. They see every project in the organisation, not only their project. |
| A teammate must set verdicts on cases, record changes and save views. | Give them Member. Member is the default under Role when you invite a teammate. See [Sign-up and invitations](/docs/sign-up-and-invitations). |
| You want to move an app to a new ingest key and turn off the old key. | You need Admin or Owner to rotate the key. |
| Your support lead wants to add a question to the project's questions. | They need Admin or Owner. |
| A CI job must mark releases. | An owner or an admin creates a project access token (`sq_pat_…`) with the `releases:write` scope. |
| You have no CI job, and a fix is live. | From 11 November 2026, an owner or an admin clicks The fix is live on the case page. |
| An agent must record releases. | From 10 November 2026, an owner, an admin or a member connects it through claude.ai or ChatGPT with "Also: it records releases" ticked. |

### Role descriptions in the app

When you invite a teammate with Invite people in the rail, the dialog shows a sentence under Role for each role that you can give:

| Role | In the app |
|---|---|
| Owner | "An owner can do everything an admin can, and also delete the organisation." |
| Admin | It says that an admin can do everything a member can. An admin can also hand fixes to agents and approve their hand-offs, change roles, remove teammates, and change project settings and keys. |
| Member | "A member can do everything a viewer can, and also accept or dismiss findings and record changes." |
| Viewer | "A viewer can see every case, recording and chart, use Ask, copy a case’s brief (which marks it handed off) and check the judge’s readings (Right or Wrong)." From 11 November 2026, a viewer cannot start a new Ask, only read answers already given. |

Settings › Members also has What each role can do: a sentence for each role, and Every permission, role by role under it. Sequential reads both from the backend.

### Saved views by role

- Saved views belong to the project, not to the teammate who saved them. Owners, admins and members can rename and remove any of them.
- Viewers see and open saved views. On the Board, a viewer sees, for example, "Viewers can read the project’s saved answers but not remove them."
- On Workbench › Events, Sessions, Funnels, Flows and Retention, a viewer sees no save, rename, delete or pin button. The card says, for example, "Viewers can open the project’s saved funnels but not save, rename or delete them." On Funnels, a viewer has no Save as a view button and no `s` key.
- See [Filters, date ranges and saved views](/docs/filters-and-saved-views).

## Change someone's role

Only owners and admins can change roles.

1. Go to **Settings › Members**.

2. Under People, find the teammate. With 9 or more teammates, type a name or an email in **Find a member…**.

3. Choose a new role from the list in their row.

4. Click **Make …** with the name of the role, for example **Make admin**.

Result: A message confirms the change. The new role applies from the teammate's next request, and they do not need to sign out. The app reads their role again when they come back to its tab, or when they reload the page.

### What the People list shows

From 8 November 2026, the top of Settings › Members starts with a count, for every role. In these examples, the organisation is Acme. The headline says, for example, "4 people, 2 invitations waiting". With more than 200 teammates, it says "200+ people". Under it, a row gives each role with its count, then your own role, for example "1 owner · 2 admins · 3 members · You are an owner". A line then says what you can do, for example "You can invite people, change roles and remove members." The last line starts with "Everyone in Acme". With more than 200 teammates, it adds "Only the first 200 are listed". An invitation whose link expired still counts as waiting, and the last line adds, for example, "1 invitation link expired". At the end of that line, the old sentence is behind "How counted ▾".

From 8 November 2026, if Sequential cannot read the member list, the headline says, for example, "You are an owner in Acme". The last line says "The member list could not be read, so nobody is counted".

Owners and admins see each teammate's role, two-factor state and last active day. Members and viewers see each teammate's name, email and role. Sequential does not send them the two-factor and last active facts.

The last active day never shows a time or a device. Sequential records sign-ins only from 11 October 2026. So "Not active yet" does not mean that the teammate never signed in. From 23 October 2026, a click on the link in the email that verifies a new address also counts as a sign-in.

Require two-factor is on Settings › Organisation, under Two-factor for everyone. See [Two-factor authentication and account security](/docs/two-factor-and-security).

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Two-factor on" | People, for owners and admins | The two-factor state of the teammate. | — |
| "No two-factor" | People, for owners and admins | The two-factor state of the teammate. | — |
| "Active today" | People, for owners and admins | The last active day. | — |
| "Active yesterday" | People, for owners and admins | The last active day. | — |
| "Last active" | People, for owners and admins | The last active day, with a date. | — |
| "Not active yet" | People, for owners and admins | A teammate with no recorded sign-in. | — |
| "Owners and admins also see who uses two-factor and when each person was last active." | People, for members and viewers | Members and viewers do not get the two-factor and last active facts. | — |

### When a role change is refused or locked

If Sequential refuses a change, the row shows why. Some rows have no role list. The row shows the role as text, and a line under the row says why.

Members and viewers see no role lists. The only owner also cannot leave the organisation.

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Only an owner changes an owner’s role." | Under the row | It is an owner, and you are an admin. | — |
| "You are the only owner: make someone else an owner before you change your own role." | Under the row | It is your own row, and you are the only owner. | — |
| "Owners and admins change roles and remove members; you are a member." | Settings › Members, for members and viewers | An example: members and viewers see no role lists. | — |
| "You are the only owner. Make someone else an owner first, or delete the organisation." | Settings › Members, for the only owner | The only owner cannot leave. | — |

### Hand over ownership

There is no transfer button. Keep at least two owners, so the organisation does not depend on one teammate's account.

1. As an owner, choose **Owner** in the new owner's row.

2. Click **Make owner**.

3. Change your own role in your row, ask the new owner to change it, or [leave the organisation](#leave-an-organisation).

## Remove someone

Only owners and admins can remove a teammate, and only an owner can remove an owner.

1. Go to **Settings › Members**.

2. In the teammate's row, click **Remove…**.

3. Read what removing does, then click **Remove …** with the teammate's name.

Result: A message confirms it. From their next request, the teammate cannot open anything in your organisation.

- Their Sequential account and their other organisations do not change.
- Their past entries stay in the [Audit log](/docs/audit-log). The log names them "Someone no longer in the organisation".

### Leave an organisation

Any teammate except the only owner can leave.

1. If you are in several organisations, choose a project of this one in the switcher.

2. Go to **Settings › Members**.

3. Under **Leave the organisation**, click **Leave …** with the name of your organisation.

4. Click **Leave …** again to confirm.

Result: You lose access to every project in the organisation at once.

### If you want to come back later

An owner or an admin can invite you again. While Who may invite is Every member, up to their own role, a member or viewer can invite you too, with their own role or a lower one. See [Sign-up and invitations](/docs/sign-up-and-invitations).

## Agents and tokens when a role changes

| When | What happens |
|---|---|
| A teammate is removed | Sequential ends the claude.ai connections that they made. |
| A teammate becomes a viewer | Sequential ends each of their connections that holds Ask, fix links or proposals. From 10 November 2026, it also ends each of their connections that records releases. Giving the role back does not bring an ended connection back. |
| An admin becomes a member | Their claude.ai connections stay, except a connection with `changes:read_sensitive`. Sequential ends that connection. A member keeps every other scope of a connection. |
| The creator of a project access token (`sq_pat_…`) leaves, is removed, is no longer an owner or admin, or their account is deleted | From 20 October 2026, Sequential marks the token. It stops working 7 days after the mark, unless an owner or admin adopts it: Adopt… on Settings › Agents & tokens, or the API. Owners and admins get an email. The token also stops exporting. |

### Project access tokens and connections by role

More about the rules in Agents and tokens when a role changes:

- A token depends on its creator. From 20 October 2026, a token stops working 7 days after its creator loses access, unless an owner or admin adopts it. See [Limits and defaults](/docs/limits).
- The mark. From 20 October 2026, Sequential marks the token. Its `exports:write` and `changes:read_sensitive` stop at once, and from 11 November 2026 also its `ask:use`. If it can write organisation-wide changes, that stops at once too. The owners and admins get an email. See [Limits and defaults](/docs/limits).
- A token with `exports:write` exports only while the teammate who created it is an owner or admin. Sequential checks this at each export call. If that teammate is now a member or viewer, or left the organisation, the call gets 403 `export_creator_not_admin`.
- The exports that a token with `exports:write` already made stay, and the other owners and admins can still download them. To export with a token again, an owner or admin creates a new token. See [Export your data](/docs/export-your-data#use-the-api-with-an-access-token).
- When an admin or a member becomes a viewer, Sequential ends each claude.ai connection that they made in this organisation and that has `ask:use`, `findings:link`, `insights:propose`, `changes:propose`, `changes:read_sensitive` or, from 10 November 2026, `releases:write`. Read and investigate has `ask:use`. See [Connect claude.ai](/docs/connect-claude-ai). For `changes:read_sensitive`, see [Who sees a change](/docs/changes#who-can-see-and-do-what).

Project access tokens:

- Only owners and admins see the project access tokens of a project. Members and viewers see Settings › Agents & tokens without This project’s tokens. They see Connect an agent, Your connections and Your tokens in other projects. The Make a token form is off for them, with the reason.
- A token cannot manage tokens. To create, revoke or adopt a token, an owner or admin must be signed in.
- A token can never set a verdict. A verdict on a case needs a signed-in teammate. See [Limits](/docs/limits).

Agents and connections:

- Every role gets Agents in the rail and in Ask or jump. In [Simple view](/docs/simple-view), the rail does not show it, but Ask or jump does.
- Owners and admins see every agent of the project and its activity. Members and viewers see only their own connections. From 19 October 2026, they see the calls of their own connections only.
- Members and viewers can disconnect their own connections on Agents, or cancel one that is still connecting. If Sequential cannot read their own connections, the page says so, with Try again. Sequential does not give them the project's token list or the activity of the whole project.
- Every role can connect claude.ai, to one project or, from 1 November 2026, to all projects of the organisation, with the access that its role allows. Only owners and admins can let such a connection propose changes for the whole organisation.
- A viewer's connection reads, and can send feedback for the viewer when they select Also: it sends feedback to Sequential. It cannot use Ask, link fixes, propose questions or record releases. When a viewer connects, the page says what the connection cannot do.
- In onboarding, members and viewers see that only owners and admins make tokens for a coding agent. While the step has a claude.ai tab, they also see that claude.ai and ChatGPT work for every role. They do not get Add an agent access token to this prompt on Settings › Setup.

| Message | Where | What it means | What to do |
|---|---|---|---|
| "You are a viewer: only owners and admins make, revoke and adopt tokens." | The Make a token form on Settings › Agents & tokens (an example, for a viewer) | The form is off for members and viewers. | — |
| "Only owners and admins see every agent; here is your own:" | Agents, for members and viewers | They see only their own connections. | — |
| "Your own connections could not be read just now, so they cannot be disconnected here." | Agents, for members and viewers, with Try again | Sequential cannot read their own connections. | — |
| "You are a member: only owners and admins make tokens. You can connect claude.ai or ChatGPT yourself." | Under Connect an agent (an example, for a member) | Members and viewers do not make tokens. | — |
| "With your role in this project, the connection can read. It cannot use Ask, link fixes or propose questions." | When a viewer connects claude.ai (an example) | What the connection cannot do. | — |

### For agents and the API

- Every role can see whether an agent is connected. GET `/api/projects/:id/status` gives every role that can read the project `agent.connected` and `agent.regular`. `connected` says whether a token that counts as an agent exists. `regular` says whether one such token called Sequential on 3 or more of the last 7 days. The answer has no token names, ids, dates or counts. A value that Sequential could not read is `null`. Settings › Project says it in one line, for example "An agent is connected and calls Sequential regularly (on 3 or more of the last 7 days)."
- An export call with a project access token whose creator is no longer an owner or admin gets 403 `export_creator_not_admin`. See [Export your data](/docs/export-your-data#use-the-api-with-an-access-token).
- Only owners and admins can read agent activity. GET `/api/projects/:id/agent-activity` gives the tool calls of the project's tokens. It needs the same permission as the token list, and a signed-in session. The Agents page shows it too. See [Limits](/docs/limits).
- Every teammate can see and end their own claude.ai connections through the API. GET `/api/projects/:id/tokens/mine` lists only the connections that you made. POST `/api/projects/:id/tokens/mine/:tokenId/revoke` ends one of them. From 19 October 2026, GET `/api/projects/:id/agent-activity/mine` shows the calls of only the connections that you made. Project access tokens and the connections of other teammates are not included: for them, the answer is 404. Your connections on Settings › Agents & tokens uses the first two routes. The Agents page uses all three for members and viewers.

## Limits

- Owners and admins cannot reset another teammate's password or two-factor authentication, or sign out their devices.
- An organisation can have at most 100 teammates and 100 pending invitations.
- If you are an owner or admin of an organisation, you cannot create a second organisation from the app. [Sign-up and invitations](/docs/sign-up-and-invitations#create-an-organisation) says when you can.

## FAQ

### Which organisation does Settings show?

A teammate can belong to several organisations. Settings › Members and Settings › Organisation show one organisation at a time: the organisation of the open project. What you can change there follows your role in that organisation.

To open another organisation of yours, choose one of its projects in the switcher. A link that ends in `?org=` and the organisation's id also opens it, also when it has no projects. If the link names an organisation that you are not in, the page says "You are not a member of that organisation." and lists your organisations.

### What if someone tries an action that their role cannot do?

The server checks every request. The screens hide or turn off most actions that your role cannot do. If a request comes in for one of these actions anyway, the server refuses it. Sequential gives someone outside your organisation the same answer for your projects as for projects that do not exist. They cannot find which of your projects exist.

### Who can turn background judging off?

Only owners and admins can switch background judging off or on, with Judge new sessions automatically under Judging on Settings › Recording & data. Members and viewers see the switch, but they cannot change it. Ask in the app and background judging have separate daily allowances. Heavy use of Ask does not stop background judging.

### Which allowance does a viewer use?

Owners, admins and members can use Ask and Judge this recording now. Ask uses the project's daily Ask allowance. See [Ask](/docs/ask).

From 11 November 2026, a viewer reads the answers already given, but cannot start a new one. Staff who view as a customer cannot start one either. Sequential refuses a new answer with 403 `ai_use_required` and one of these sentences:

- Asking about sessions needs a member role or higher; a viewer can read answers already asked.
- Judging a recording needs a member role or higher; a viewer can read judgements already made.
- Judging steps in words needs a member role or higher; a viewer can read the steps already judged.

Judge this recording now uses the project's daily allowance for judging on demand, apart from the allowances of Ask and background judging. See [Reading an AI verdict](/docs/reading-verdicts).

The allowances are per project, not per teammate. So one teammate can use all of the day's allowance for the whole team.

### Does a viewer's Right or Wrong count?

A viewer's Right or Wrong counts the same as an admin's. Any role can check the judge on a session's page: answer Right or Wrong in The judge's reading. Each teammate's latest answer feeds Calibration on the Questions page. See [Feedback and calibration](/docs/feedback-and-calibration).

### Does the two-factor requirement apply to every role?

Yes. When Require two-factor is on, Sequential blocks a teammate from the organisation's projects unless they have two-factor set up and signed in with a code or a trusted device. The block stays until the teammate has set up two-factor authentication and signed in with a code or a trusted device. See [Two-factor authentication and account security](/docs/two-factor-and-security).

From 8 November 2026, every role sees the rule as rows under Two-factor for everyone on Settings › Organisation. "Without two-factor" says that a teammate without it can still accept or decline an invitation, or leave, and that an owner or admin can still make two-factor optional. "Project access tokens" says "Keep working: the rule does not apply to them".

### Can Sequential staff change my organisation?

Sequential staff can make support changes: change a project's settings, archive or restore a project, revoke an ingest key or a project access token, and turn the two-factor requirement on or off. The [audit log](/docs/audit-log#changes-by-sequential-support) names them "Sequential support". It never shows the name of the staff member.

### Why does a viewer see a short rail?

A viewer starts in [Simple view](/docs/simple-view) the first time a browser has no choice yet: a short rail and three cards in place of the Brief. Owners, admins and members start with the full rail. Every role can turn Simple view on or off in the account menu. Simple view changes no permission.

## Related pages

- [Organisations, projects and keys](/docs/organisations-and-projects)
- [Two-factor authentication and account security](/docs/two-factor-and-security)
- [Audit log](/docs/audit-log)
- [Limits](/docs/limits)
