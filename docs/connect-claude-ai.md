# Connect claude.ai to Sequential (MCP)

> Add Sequential to claude.ai as a custom connector. You sign in to Sequential and choose the project and the access. There is no token to copy.

> **At a glance**
>
> - **Who can:** Every role. Your role decides what the connection can do.
> - **Before you start:** A project that is not archived; 2FA, if your organisation requires it; a claude.ai account that can add a custom connector.
> - **Key:** claude.ai connects with a sign-in to Sequential, not with a project access token (`sq_pat_…`). You do not copy a secret.
> - **Works with:** claude.ai. From 1 November 2026, a connection is for one project, or for all projects of one organisation.
> - **Know this:** On the Sequential consent page, you choose what claude.ai can do. claude.ai cannot ask for more.
> - **Know this:** End it on both sides. If you remove the connector only in claude.ai, expect it to stay live in Sequential.

## Connect claude.ai

> **Allow only a request that you started**
>
> Above the buttons, the consent page says: "Only allow if you just pressed Connect in Claude yourself." Never click Allow for a request that you did not start.

1. In Sequential, open **Agents** in the left rail.

   **If you start in Settings or in onboarding**

   The same tab is under Connect an agent in Settings › Agents & tokens. Under the steps, it says "No token is needed, and every role can connect this way. It then shows under “Your connections”." On Agents, this line ends with "Connected".

   In onboarding, the Connect your agent step has a claude.ai tab while the claude.ai sign-in is on. This tab is first and open. It shows the same URL and the same first two steps. Its third step ends "No token is needed, and every role can do this." On Agents, the third step ends "You choose what it may do." You do not create a token on this tab.

   In onboarding, while there is no claude.ai tab, Claude Code is open first. After Retry, the open tab stays open, also when the claude.ai tab is added.

2. Under **Connect an agent**, click the **claude.ai** tab.

   **If you do not see the claude.ai tab**

   When nothing is connected yet, the Connect an agent section is first on the page. Otherwise, it is under Connected, with the title Connect another agent. The Connect an agent button at the top of the page goes to it.

   On Agents, in Settings › Agents & tokens and in onboarding, Sequential checks once, when the page loads, that the claude.ai sign-in is on. Until the check answers, these pages show no tabs. Until it is sure, they have no claude.ai or ChatGPT tab:

   - "Checking whether claude.ai and ChatGPT can connect…": the check has not answered yet.
   - "Couldn’t check whether claude.ai and ChatGPT are available" and Retry: the check got no answer. Click Retry to check again.
   - "claude.ai and ChatGPT: Not available yet.": your Sequential server answered that the sign-in is off.

3. Next to **Connector URL**, click **Copy**.

   Result: This copies the connector URL: the address of your Sequential API, followed by `/mcp`.

4. In claude.ai, open **Customize › Connectors**. Add a custom connector.

   **If you want the exact steps from the tab**

   On Agents, the claude.ai tab says: "In claude.ai, open Customize, then Connectors. Click Add and add a custom connector." Then: "Paste the URL below and leave the advanced settings blank." The last step on the tab says: "claude.ai sends you here to sign in and choose the project. You choose what it may do."

5. Paste the URL. Leave the advanced settings blank.

6. In claude.ai, connect the new connector.

   Result: A Sequential window opens.

7. If you are not signed in to Sequential, sign in. If your account has 2FA, enter your code.

   Result: The consent page opens. Its title is "Claude wants to connect to Sequential".

8. Choose one project, or all projects of an organisation, and the access. See [The consent page](#the-consent-page).

9. Click **Allow**.

   **If claude.ai asks you before it uses a tool**

   In claude.ai, the page of the connector has Tool permissions, with Read-only tools and Write/delete tools. When Sequential checked (1 November 2026), Write/delete tools was set to Needs approval. claude.ai then asks you before it uses a tool that changes data, for example `link_fix`.

Done when: Sequential sends you back to claude.ai.

## Check it works

1. Ask in claude.ai. Name Sequential in your first message, for example "Using Sequential, what should I know about my product this week?"

2. In Sequential, on **Agents**, under Connected, find "Claude (claude.ai)".

   Result: After the first tool call, its row shows a time under Last used.

## The consent page

On the consent page, you choose two things:

- Project: one project, or [all projects of an organisation](#all-projects-in-an-organisation). A project that you cannot connect is dimmed, with the reason in brackets. Each reason, and what to do, is in [Everything on the consent page](#everything-on-the-consent-page).
- What it may do: one of two access choices, and check boxes. From 1 November 2026, each box that your role allows is ticked at first. Untick a box to leave that permission out.

Your role in the chosen project decides which choices show. Choose one access choice:

| Access choice | What it allows | Roles that get it |
|---|---|---|
| Read and investigate (selected first) | It watches sessions, asks the judge, reads cases, checks fixes, reads sessions, reads analytics and reads the timeline | owner, admin, member |
| Without Ask, so it spends no AI budget | The same, without asking the judge. It cannot spend the agent allowance of the project | every role |

Under the two choices are check boxes:

| Check box | What it allows | Roles that get it |
|---|---|---|
| Also: it links fixes | It can attach a pull request to a case. This is a write | owner, admin, member |
| Also: it proposes questions | From 12 October 2026. It suggests edits to the questions; an owner or admin applies them. This is a write | owner, admin, member |
| Also: it sends feedback to Sequential | It can send feedback to the Sequential team as you | every role |
| Also: it proposes timeline changes | From 22 October 2026. It suggests timeline entries; nothing lands until someone confirms them | owner, admin, member |
| Also: it reads admins-only changes | From 22 October 2026. It reads planned prices and other entries only owners and admins see | owner, admin |
| Also: it records releases | From 10 November 2026. When it puts a fix live, it tells Sequential, so Sequential can check whether the fix worked. Untick it if this agent does not deploy your app. This is a write. Only for claude.ai and ChatGPT | owner, admin, member |

No check box shows for the read-only address (`/mcp/readonly`).

If your account has 2FA, the page can ask for a [two-factor code](#when-does-the-consent-page-ask-for-a-two-factor-code).

Sequential decides the access, not claude.ai. Only the options that you choose on the consent page decide what claude.ai can do. From 10 November 2026, a connection can record releases when you tick "Also: it records releases" on the consent page. Only an owner, an admin or a member gets this box, and only for claude.ai or ChatGPT on `/mcp`. A viewer never gets it, and the read-only address `/mcp/readonly` never offers it. Claude Code does not get this box. Claude Code records releases with an access token that has `releases:write`. The box is ticked at first. Untick it if the agent does not deploy your app. A connection that you made before 10 November 2026 cannot record releases, and Sequential never adds this permission when claude.ai renews its access. To add it, connect again with the box ticked, then disconnect the old connection under Agents. Without the box, the connection of an owner, an admin or a member lists the tool "Record release (not enabled)". A call of it gives the steps to turn it on.

### Everything on the consent page

The consent page shows who asks, where Sequential sends you back to, and who you are.

When claude.ai starts the sign-in, it asks for permissions. Sequential does not use that request.

- Title: "Claude wants to connect to Sequential". Sequential shows a name only for an app that it knows. Any other app shows as "An unverified app wants to connect to Sequential".
- "Sequential will send you back to claude.ai."
- "Signed in as" and your email. To use a different account, click Not you? Switch account. Sequential signs you out. Then start again from claude.ai.

Project. The list shows each project of each of your organisations, as "organisation / project". Choose one. If only one project can be connected, it is already selected. While no project is selected, a line says "Choose a project to allow this connection." A project that you cannot connect is dimmed and shows the reason in brackets:

| Reason | What it means |
|---|---|
| "archived" | The project is archived. Unarchive it first. |
| "needs an owner or admin" | Your role in that organisation allows none of the access. Today every role allows some access, so you do not see this. |
| "needs two-factor on your account" | The organisation requires 2FA, and your account does not have 2FA. You cannot choose the project. Click Turn on two-factor: Settings › Security opens in a new tab. Set up 2FA there. Then come back and click Check again. |
| "asks for your authenticator code" | The organisation requires 2FA. You have 2FA, but this sign-in did not pass it. You can choose the project. When you click Allow, the page asks for a code first. |
| "at your connection limit: 10 of 10" | You have 10 connections to this project. Connections that are still being set up count too. See [Limits](#limits). |
| "at its connection limit: 50 of 50" | The project has 50 connections. |

Access. Under What it may do, choose one:

- Read and investigate. It is selected first. A line under it says what it allows: "It watches sessions, asks the judge, reads cases, checks fixes, reads sessions, reads analytics and reads the timeline." With "reads analytics", claude.ai can read your analytics: event counts, funnels, flows, retention, and users and accounts by id. See [Privacy at a glance](/docs/privacy-overview#analytics). "reads the timeline" is the changes your team recorded, without the admins-only ones. See [Changes](/docs/changes).
- Without Ask, so it spends no AI budget. The same, without "asks the judge". claude.ai then cannot run Ask, so it cannot spend the agent allowance of the project. Sequential still screens visitor text in tool answers, under a separate budget.

Under the two choices are check boxes. From 1 November 2026, each box that your role allows is ticked at first. None shows for the read-only address (`/mcp/readonly`):

- "Also: it links fixes", with the line "It can attach a pull request to a case. This is a write." Untick it if claude.ai must not add fix links to cases.
- From 12 October 2026, "Also: it proposes questions" can show: "It suggests edits to the questions; an owner or admin applies them. This is a write." See [Proposals from an agent](/docs/rubric#proposals-from-an-agent). Questions gives you a prompt to paste into claude.ai. See [Keep your questions up to date with your product](/docs/rubric#keep-your-questions-up-to-date-with-your-product).
- "Also: it sends feedback to Sequential" lets your agent send feedback to the Sequential team as you. While it is ticked, a second box shows under it: "Let it send feedback without asking". See [Send feedback](/docs/send-feedback).
- From 22 October 2026, "Also: it proposes timeline changes": "It suggests timeline entries; nothing lands until someone confirms them." See [Changes](/docs/changes).
- From 22 October 2026, "Also: it reads admins-only changes": "Planned prices and other entries only owners and admins see. It stops if you stop being one." With 2FA on, it asks for your second factor. From 23 October 2026, you do not need 2FA for it.

When your account does not have 2FA, a line under the buttons says "Two-factor is off for your account. Turning it on in Settings › Security protects every agent connection."

Your role in the chosen project decides which choices show. An owner or admin gets them all. A member gets them all except "Also: it reads admins-only changes".

A viewer gets only Without Ask, so it spends no AI budget and, of the check boxes, only "Also: it sends feedback to Sequential". The page then says what the connection cannot do. It names only the check boxes on offer that your role cannot take, for example "With your role in this project, the connection can read. It cannot use Ask, link fixes or propose questions." When the timeline check boxes are on offer, the line ends "propose questions or propose changes."

A viewer's connection reads, and can send feedback for the viewer when they tick "Also: it sends feedback to Sequential". It cannot use Ask, link fixes or propose questions.

Deny has the focus. The X key also denies. To connect, click Allow. At the bottom, the page says "You can disconnect it any time under Agents."

## What claude.ai can do

- claude.ai uses Sequential's [agent tools](/docs/agent-tools). The access that you chose on the consent page decides which tools it gets.
- A connection to one project reads only that project. A connection to all projects of an organisation reads one project on each call.
- [Links in the answers](/docs/sessions-and-replay#links-that-open-a-project) of claude.ai, such as a replay link, open that project in Sequential. You do not select it first.
- Ask through claude.ai spends the [agent allowance](/docs/limits#ask-from-an-agent) of the project.
- After a Sequential release with new tools or new tool descriptions, reconnect the connector in claude.ai.

### Which tools claude.ai gets

- The tools that claude.ai lists follow the access of the connection. `request_fix_draft` never shows, because a claude.ai connection cannot get `findings:draft`. From 10 November 2026, `record_release` works only when you ticked "Also: it records releases". See [The consent page](#the-consent-page).
- From 22 October 2026, `list_changes`, `get_change`, `get_change_schema`, `get_change_coverage` and `preview_changes` show with either access choice, because both include `changes:read`. From 22 October 2026, `list_finding_changes` shows too. `propose_changes` works only when you ticked "Also: it proposes timeline changes". `record_change`, `record_changes`, `update_change`, `retract_change` and `link_change_to_finding` never show, because a claude.ai connection cannot get `changes:write`.
- With Read and investigate, claude.ai lists 35 tools that work. With Without Ask, so it spends no AI budget, it lists 34, without `ask_sessions`.
- Each check box that you ticked makes its tool work. `link_fix` works only when you ticked "Also: it links fixes" on the consent page. `propose_rubric` works only when you ticked "Also: it proposes questions". `send_feedback` works only on a connection with `feedback:write`. A connection has `feedback:write` only when you ticked "Also: it sends feedback to Sequential" on the consent page.
- From 1 November 2026, a box that you did not tick still lists its tool, as a stub: `link_fix`, `propose_rubric`, `send_feedback` or `propose_changes`. Its title ends with "(not enabled)". Its description starts "Not enabled on this connection: call it for the steps to turn it on." A call of a stub does nothing. It answers with the steps: connect again on the consent page and keep the box ticked, then disconnect the old connection under Agents. So claude.ai can tell you why it cannot do it. "Also: it reads admins-only changes" adds no tool, so it has no stub. From 10 November 2026, `record_release` has a stub too, "Record release (not enabled)", but only when your role could tick its box. Its answer also says "Optional: only for an agent that deploys the app." The read-only address `/mcp/readonly` lists no stubs.
- claude.ai keeps its own copy of the tool list and the tool descriptions. When Sequential tested it (October 2026), a reconnect of the connector in claude.ai read both again. Right after a reconnect, the first tool calls can fail with "The user didn't complete authentication. They can try again." Later calls in the same chat work, so ask again.
- With either access choice, claude.ai gets the eleven analytics tools of the scope `analytics:read`, for example `get_overview`, `search_events`, `funnel_analysis` and `retention_analysis`. `get_overview` gives a briefing in one call: traffic, top pages, errors, sessions worth watching, findings and setup gaps. From 2 November 2026, it also counts the sessions with rage clicks, dead clicks and U-turns, when the connection has `sessions:explore`. From 22 October 2026, when the connection has the scope `changes:read`, the briefing also shows up to 5 confirmed changes from the period, and the release markers in that period. See [Analytics from an agent](/docs/limits#analytics-from-an-agent).
- A connection that you allowed before Sequential added the analytics tools keeps its old access. When claude.ai renews its access, Sequential never adds a scope. To get the analytics tools, disconnect it and connect again.
- claude.ai uses the connection only on `/mcp`. The connection does not work on the app's REST routes or on POST `/api/agent/<tool>`.

## All projects in an organisation

A connection can reach every project of one organisation. On the consent page, choose All projects and a Default project. A tool that reads acts on the default project when the call names no project. Disconnecting it in any project disconnects it from all projects.

When the organisation has more than one project that is not archived, four tools that change something need `project`. A call of one of them without `project` is refused, and the agent is told to ask you which project.

### How a connection to all projects works in detail

From 1 November 2026, a connection can reach every project of one organisation.

On the consent page, the projects show under the name of their organisation. Each organisation has two choices: All projects and Specific project. All projects has the line, for example, "Now 3 projects, and any project added later. You keep access only while you are a member." The count has only the projects that are not archived. The list of projects shows only under Specific project.

- Which choice is set at first. With one organisation that you can choose whole, the page starts on All projects, with its first project that is not archived as the default project. With one organisation that you cannot choose whole, it starts on Specific project, with the project selected if only one can be connected. With several organisations, nothing is chosen at first.
- Several organisations: choose the organisation first. Under Organisation, each organisation has a line, for example "2 projects." The line says when you cannot choose all its projects: "2 projects. All projects is not available (needs an owner or admin).", or "Only a specific project can be connected." An organisation is dimmed when it has nothing to connect: "2 projects. None of them can be connected now." or "No project to connect yet." Until you choose one, a line says "Choose an organisation to allow this connection." Then All projects and Specific project show for that organisation, set at first as for one organisation. If you choose another organisation, these choices start again.
- With All projects, choose a Default project too. Its line says "The agent works in this project when it does not name one. You can change it later under Agents." Archived projects are not in the list. You must choose one: until then, a line says "Choose a default project to allow this connection."
- Your role in the organisation decides the access, the same for every project. You can already open every project of the organisation in the app, so the connection gets nothing more than you have.
- When you cannot choose All projects for an organisation, it is dimmed, with the reason in brackets: "needs an owner or admin", "needs two-factor on your account", "asks for your authenticator code", "at your connection limit: 10 of 10", "at its connection limit: 50 of 50" or "no project to connect yet".
- With All projects and "Also: it proposes timeline changes" ticked, an owner or admin also gets "Also: it proposes timeline changes for the whole organisation": "Entries that apply to every project in" the organisation. It is off at first. When you tick it, Sequential can ask for your authenticator code before it allows the connection. The connection stops if you stop being an owner or admin.

The project of each call. Each tool takes a `project` argument: the id, the slug or the exact name of a project of the organisation. The name can be in any case. Without it, a tool that reads acts on the default project. An exact id comes before a slug.

When the organisation has more than one project that is not archived, seven tools need `project`: `propose_rubric`, `link_fix`, `propose_changes`, `get_fix_brief` (getting a fix brief marks the case as handed off), `review_finding`, `review_session` and, from 10 November 2026, `record_release`. A call of one of them without `project` is refused, and the agent is told to ask you which project.

`send_feedback` does not need it. Without `project`, Sequential looks up its `finding_id` and `session_id` in the default project and records that project with the feedback. The feedback itself goes to Sequential.

From 1 November 2026, on such a connection, the description of these four tools and of their `project` argument starts with "Before the call, tell the person which project you will change (the approval shows no input); if they did not name one, ask them." The instructions of the connection say it too. The approval in claude.ai does not show what the call sends.

Each answer starts with the project that the call used: its id, its slug, its name and whether it is the default. From 2 November 2026, an error answer also names the project that the call ran in, after its text. A call refused before it ran names none.

The tool `find_project` finds which projects of the organisation hold a session id or a case number, such as F-12. It searches at most 25 projects that are not archived: `more` is true when there are more. A value from another organisation and a value that does not exist get the same answer: no match.

From 2 November 2026, a call with a case number and no `project` is refused when another project that is not archived also holds that number, or holds it when the default project does not. This applies to `get_finding`, `list_finding_sessions`, `get_verification`, `get_fix_brief`, `link_fix`, `request_fix_draft`, `list_finding_changes` and `link_change_to_finding`, and also to `near.finding` of `list_changes` and to `finding_id` of `send_feedback`. The refusal says, for example, "F-5 is in 2 projects of this connection: the default project and 1 more." It lists the ids of those projects and which one is the default, and tells the agent to ask you which project. If Sequential cannot check the projects, the call runs on the default project.

The tool `list_projects` lists the projects that the connection reaches, with the id, the slug, the name, the environment, whether it is archived, and which one is the default. The names are text that your team typed, so Sequential screens them as it screens other such text. A connection to one project does not list `project` or `list_projects`. Its tools are the same as before.

| Answer | Why |
|---|---|
| "No project with that id or slug is in this connection's organisation. …" | The project does not exist, or it is in another organisation. Both get the same answer. |
| "That project is archived: it answers nothing until an owner or admin restores it. …" | The connection still works for the other projects. |
| "This connection reaches every project of its organisation and has no default project now (it was deleted). …" | Pass `project`, or choose a new default under Agents. |
| "This connection reaches 3 projects and link_fix changes something in one of them, so it needs project: …" | A tool that changes something, called without `project`, in an organisation with more than one project. Pass `project`. |
| "More than one project of this connection's organisation has that name. …" | Two projects have the name that the call gave. Pass the id or the slug. |
| "This connection reaches one project only, so project must name that project or be left out." | A connection to one project. Connect again and choose All projects to reach the others. |

On Agents, the row of the connection says, for example, "OAuth app: Claude", who connected it and when, and "All projects in" and the name of the organisation. Under this line, it says "Default project:" and the name. In Settings › Agents & tokens, its row says "Agent connection (Claude) · All projects in" and the name. It shows in every project of the organisation. The person who made the connection can click Change… to choose another project of the organisation that is not archived, then Save. A message says, for example, "Default project is now" and the name. Each change is in the [Audit log](/docs/audit-log) as `oauth.default_project_changed`. If the default project was deleted, the row says "Its default project was deleted. An agent has to name a project in each call until a new default is chosen."

Disconnecting it in any project disconnects it from all projects: "This disconnects" the agent "from all projects in" the organisation. It also ends when you leave the organisation or someone removes you, when your role no longer allows its access, and when the organisation is deleted. When a project is deleted, the connection stays.

## See the connection under Agents

Open Agents in the left rail, or press G, then M. An owner or admin sees every connection and token of the project. A member or viewer sees only their own, and can end their own connections there.

From 8 November 2026, under Connected, each connection has its own row. A claude.ai connection has the name "Claude (claude.ai)". The State column shows a badge when the connection does not work. A connection that works has no badge. When a connection needs you, a line under Connected counts them, for example "1 connection needs you." A connection needs you when its badge is Pending, Paused, Access lost or App gone, or when it shows a Reconnect badge.

| Badge | What it means | Button |
|---|---|---|
| Pending, "Waits for someone to finish connecting it." | Someone clicked Allow, and claude.ai has not finished. If claude.ai does not finish within 10 minutes, the connection moves under Revoked and expired, as Expired. | Cancel… |
| Paused, "Paused while the project is archived." | The project is archived. Unarchive the project, and the connection works again. | Disconnect… |
| Access lost, "Stopped working:" and the reason | The person who connected it lost the access that it needs, and Sequential has not ended it yet. At its next call, or at the daily check, Sequential ends it. Connect again. | Disconnect… |
| App gone, "The OAuth app behind it no longer exists." | Sequential no longer has the registration of the app. Connect again. | Disconnect… |
| Idle, "Not refreshed for a long time. It must reconnect." | claude.ai did not renew the connection for 30 days. It cannot work again. Connect again. | None |

### What a card on Agents shows

Every role has Agents in the rail and in Ask or jump (⌘K). A member or viewer sees the note "Only owners and admins see every agent; here is your own:". If Sequential cannot read their connections, the page says "Your own connections could not be read just now, so they cannot be disconnected here." with Try again.

With no project open, for example in an organisation that has no project yet, Agents says "No project is open." and "Agents work on one project at a time. Open a project from the project menu in the rail to see its agents." An owner or admin also gets New project in and the name of the organisation. For a member or viewer, the text ends with "Owners and admins add projects." Connect an agent is not there.

From 8 November 2026, Connected lists one row for each connection or token. A line under the heading says "Calls in this project: last 7 days, rolling". When some rows belong to the same agent, the line starts with "From" and the number of agents, for example "From 3 agents". "How counted ▾" says how Sequential counts.

Connections with the same name, the same kind and the same app are one agent. They show under one heading: the name, the kind, for example "OAuth app:" and the name that claude.ai sent, and the number of connections. Each of their rows starts with who connected it and when, for example "Connected by you, 3 Nov". A row alone starts with the name. Under the name, it says "OAuth app:" and the name that claude.ai sent, then, for example, "connected by Ana, 9 Sept". Sequential does not check the name that claude.ai sent. A teammate's name is their email address when their name is blank.

On a wide screen, a row has these columns. On a narrow screen, they stack:

- Agent: the name and the line under it.
- May do: a short label, for example "Reads only" or "Reads and 2 extras", and an exact line, for example "All 7 reads", or "Also:" or "Only:" and the permissions. "Read the full text ▾" shows the full sentence, for example "Watches sessions, asks the judge, reads cases, checks fixes, reads sessions, reads analytics and reads the timeline." It also lists what the connection does not hold, after "It does not hold:". And it says "An agent connection never holds these: asks to take cases, writes the timeline and exports data. Only a token can." From 8 November 2026, May do counts only the permissions that work in this project. When Sequential has switched off a permission for this project, the full text says, for example, "This permission does nothing in this project, because Sequential switched it off: exports data.", or "These permissions do nothing in this project, because Sequential switched them off: …" for more than one. Such a permission is never under "It does not hold:". When every permission that a connection holds is switched off here, the label says "All switched off here". A connection that holds no permission says "No permissions".
- State: a badge when the connection does not work. The badges are in See the connection under Agents. A connection that lacks a feature shows, for example, "Reconnect for 1 feature". "Read the full text ▾" then gives the reason and the steps. From 8 November 2026, the review feature counts only when a reconnect here would offer it. A connection that its maker cannot give review, for example because the maker is a viewer, never shows a badge for it. For a connection to all projects of an organisation, review must also work in its default project. Working now shows for 15 minutes after a tool call.
- Last used: how long ago the newest tool call was, for example "3 hours ago". It counts only tool calls. Before the first tool call, it says, for example, "Signed in 4 days ago", or "Never used". On a narrow screen, it says, for example, "Last used 3 hours ago" or "Last signed in 4 days ago".
- Expires: the date, for example "19 Oct 2027".
- Calls, 7 days: a bar for each day and the number of calls, for example "29 calls". Click it to show only the calls of this connection under What they did. When the judge spent tokens on its calls, it also says, for example, "Judge: 17.6K input tokens". If Sequential cannot read the calls, it says "Not measured".
- The button that ends it. An owner or admin sees it on every row. A member or viewer sees it on their own connections.

What they did, on the same page, lists the calls of claude.ai together with the calls of your tokens, for the last 7 days.

### Revoked and expired

Revoked and expired is under the rows of Connected. It shows only when a connection or a token has ended, and it is closed at first. Its rows have a badge under State:

| Badge | What it means |
|---|---|
| Revoked | Someone disconnected it, or Sequential ended it. See [When a connection stops working](#when-a-connection-stops-working). Connect again. |
| Expired | The connection reached its end date, 365 days after Allow. Or claude.ai did not finish within 10 minutes of Allow. Connect again. |

A connection that ended stays in this list for 30 days. Then Sequential does not show it.

### An older connection that stays live

If you connect claude.ai again to the same project, you can have two connections that work. Sequential does not end the older connection. On Agents, both show under one heading, with the number 2. Each has its own row, which starts with who connected it and when. Under Last used, each row shows a time, or "Never used". If you do not use the older one, disconnect it. Until then, it counts toward your limits. See [Disconnect claude.ai](#disconnect-claude-ai).

## Disconnect claude.ai

Disconnecting in Sequential does not remove the connector in claude.ai.

> **Also disconnect the connection in Sequential**
>
> In Sequential's tests (October 2026), when you remove the connector in claude.ai, claude.ai does not tell Sequential. Expect the connection to stay live under Agents. It counts toward your limits until you disconnect it, or until it goes idle 30 days after claude.ai last renewed it.

1. In Sequential, open **Agents**, find the row and click **Disconnect…**.

   Result: The row asks: "Disconnect this agent? It stops working at once, and it has to be connected again to come back." Cancel has the focus.

   **If you use Settings › Agents & tokens or the API**

   Every role can disconnect its own connections in Settings › Agents & tokens, under Your connections. Click Disconnect…. The row says "Disconnecting “Claude (claude.ai)” stops that agent at once. It has to connect and be allowed again to come back. This cannot be undone." Click Disconnect it, or Keep it as it is. The connection then moves under Revoked and expired, as Revoked.

   Through the API, any person can end a connection that they made: POST `/api/projects/:id/tokens/mine/:tokenId/revoke`.

2. Click **Disconnect**.

   Result: The connection moves under Revoked and expired, as Revoked.

   **If the card shows Pending, or has no button**

   To stop a connection that shows Pending, click Cancel… on Agents. Every role can cancel its own connection, and an owner or admin any connection. The row asks: "Cancel this connection? claude.ai has to start connecting again." Keep has the focus. Click Cancel connection. A connection under Revoked and expired has no button, because it cannot work again. On Agents, a connection that shows Idle has no button either.

3. In claude.ai, open **Customize › Connectors**.

4. Under **Yours**, open the Sequential connector.

5. Click **Disconnect**.

## When you have no organisation yet

From 20 October 2026: if you have no organisation when a connection reaches Sequential, for example because you created your account on the way, Sequential first opens setup and remembers the connection. If the request is still open, the last step of setup, Finish connecting your agent, has a button that opens the consent page.

### How setup finishes the connection

- Sequential remembers only the address of a consent page: `/oauth/consent?request=` and the 43-character id of the request. With any other address, setup opens as usual.
- The last step of setup is Finish connecting your agent, with the line "You started connecting an agent before you had an organisation. Your organisation and project are ready now." First it shows "Checking the connection…".
- If the request is still open, the step says "Go back to finish the connection: there you choose this project and what the agent may do in it." Click Back to Claude. The button names the app, or says Back to your agent when Sequential cannot name it. The button opens the consent page, where you choose the project and the access as usual. Setup does not create a token. To skip it, click Go to the Brief instead.
- If the request is over, the step says so, for example "That connection request expired. Start the connection again from your agent.", and shows Go to the Brief. A request is valid for 10 minutes. From 23 October 2026, while the consent page or onboarding is open, Sequential keeps the request alive, up to 60 minutes after it started. Then start again from claude.ai.
- Only the address of the page remembers the connection, so a reload keeps it. Sequential stores nothing new on its server.

## Fix a failed connection

If connecting stops with a message, find it in [Messages during the sign-in](#messages-during-the-sign-in).

For a connection that stops later, see [When a connection stops working](#when-a-connection-stops-working) or [Troubleshooting](/docs/troubleshooting#agents-claude-ai).

### Messages during the sign-in

If the page has already loaded, and the request then expires or someone answers it, the message ends with "Start again from Claude."

| Message | Where | What it means | What to do |
|---|---|---|---|
| "This connection request has expired. Start again from claude.ai, ChatGPT or your agent." | — | A connection request is valid for 10 minutes. From 23 October 2026, while the consent page or onboarding is open, Sequential keeps the request alive, up to 60 minutes after it started. | Start again from claude.ai. |
| "This connection was started in another browser. Start again from claude.ai, ChatGPT or your agent." | — | You opened the consent page in a different browser from the one where claude.ai started the connection. | Start again from claude.ai, and stay in the same browser. |
| "This connection request was already answered. Start again from claude.ai, ChatGPT or your agent." | — | Someone clicked Allow or Deny for this request. | Start again from claude.ai. |
| "This connection request belongs to another Sequential account. Start again from claude.ai, ChatGPT or your agent." | — | A different Sequential account opened this request first. | Start again from claude.ai. |
| "This app’s registration with Sequential has ended. Start again from claude.ai, ChatGPT or your agent." | — | Sequential no longer has the registration of the app. | Start again from claude.ai. |
| "You have reached your connection limit for this project. Disconnect one under Agents, then try again. Connections still being set up count too; they clear within 10 minutes." | — | You have 10 connections to the project. Connections that are still being set up count too. | Disconnect one. Then click Allow again. |
| "This project has reached its connection limit. An owner or admin can disconnect one under Agents, then try again." | — | The project has 50 connections. | An owner or admin disconnects one under Agents. |
| "Too many connections in the last hour. Try again later." | — | You clicked Allow more than 20 times in one hour, including clicks that were refused. | Wait, then try again. |
| "Only owners and admins can connect an agent to this project." | — | Your role allows none of the access. Today every role allows some access. | Ask an owner or admin. |
| "Your role in this project does not allow that access. Choose what your role allows, then try again." | — | You chose access that your role does not allow. For example, your role changed to viewer after the page opened. The page reads the request again. | Choose Without Ask, so it spends no AI budget. Leave every check box off. Then click Allow. |
| "This project is archived. Restore it before connecting." | — | The project is archived. | Unarchive it, or choose another project. |
| "This organisation requires two-factor. Turn it on in Settings › Security first, then press Allow again." | — | Your account does not have 2FA. | Click Turn on two-factor. Settings › Security opens in a new tab. Set up 2FA there, then click Allow again. |
| "This organisation needs two-factor on this session. Enter a code from your authenticator app, or a backup code." | — | The organisation requires 2FA, and this sign-in did not pass 2FA. | The page shows Authenticator code. Enter a code, then click Verify and allow. You do not have to sign out. |
| "Sign in again before you connect: your last sign-in on this device was more than an hour ago." | — | From 23 October 2026: your account does not have 2FA, and your sign-in on this device is more than one hour old. Allow does not show. | Click Sign in again. Sequential signs you out on this device, and after the sign-in it opens the consent page again. Then click Allow. |
| "Only owners and admins can give a connection admins-only changes. Untick it, then press Allow again." | — | Your role changed after the page opened. The page reads the request again, and the box goes. | Click Allow again. |
| "One of the options you chose is not available now. Check the options, then press Allow again." | — | An option was turned off after the page opened. The page reads the request again. | Check the options, then click Allow again. |
| "Too many connection attempts from this network. Try again in a few minutes." | — | More than 60 connections started from your network address in 10 minutes. | Wait, then start again. |
| "This app is not one Sequential can connect to yet." | — | Sequential does not accept the app that started the connection, or could not read its registration just now. | Use claude.ai with the URL that Sequential shows. |

## When a connection stops working

| Event | What happens |
|---|---|
| The project is archived | The connection pauses. A call from claude.ai gets "This connection is paused while its project is archived". Unarchive the project, and it works again. A paused connection still counts toward the limits. |
| The person who connected it is removed from the organisation or leaves it | Sequential ends the connection. It shows Revoked. |
| The person who connected it gets a role that does not allow every scope of the connection | Sequential ends the connection. It shows Revoked. If the person gets the old role back, the connection stays ended. See [Which role changes end a connection?](#which-role-changes-end-a-connection) |
| The organisation starts to require 2FA, and the person did not have 2FA when they connected | Sequential ends the connection when an owner or admin turns the requirement on. Otherwise, it ends it at its next call or at the daily check. |
| The person turns off 2FA while the organisation requires it | Sequential ends the connection. |
| The person changes their password in Settings › Security, or resets it | Sequential ends every claude.ai connection of that person, in every project. If Sequential cannot end them, it does not change the password. Try again. |
| A sign-in code or an old credential of the connection is used again | Sequential ends the connection to protect your data. |
| claude.ai does not renew the connection for 30 days | The connection shows Idle. |
| 365 days pass after Allow | The connection shows Expired. |
| The person who made it, an owner or an admin disconnects it | The connection stops at once. |

After any of these, except a pause, connect claude.ai again.

## Limits

| Limit | Value | Result |
|---|---|---|
| Connections of one person to one project | 10. Connections that work, are being set up or are paused count | The project shows "at your connection limit". Allow shows the limit message. |
| Connections to one project, for all people | 50 | The project shows "at its connection limit". |
| Connections of one person to all projects of one organisation | 10 | The organisation shows "at your connection limit". A connection to all projects counts toward no project's limit |
| Connections to all projects of one organisation, for all people | 50 | The organisation shows "at its connection limit". |
| Allow clicks | 20 an hour per person | "Too many connections in the last hour. Try again later." |
| A connection request | Valid for 10 minutes. From 23 October 2026, while the consent page or onboarding is open, Sequential keeps the request alive, up to 60 minutes after it started | "This connection request has expired. Start again from claude.ai, ChatGPT or your agent." |
| Connections started from one network address | 60 in 10 minutes | "Too many connection attempts from this network. Try again in a few minutes." |
| One access credential | 1 hour. Server default. claude.ai renews it without asking you | — |
| A connection without a renewal | 30 days. Server default | Idle. Connect again. |
| A connection | 365 days after Allow. Server default | Expired. Connect again. |
| Requests | 120 a minute per connection, as for a token. Server default | 429 `rate_limited` |
| Reads per project | 600 a minute, for all tokens and connections of the project together. By default, Sequential only counts them | See [Limits](/docs/limits#programmatic-access). |

## Security and privacy

- **claude.ai acts for you, not as you.** Sequential never gives claude.ai your password or your Sequential sign-in. It gives claude.ai a connection that works only on `/mcp`, for one project or for all projects of one organisation, with the access that you chose.
- **Your access limits it.** On each call, Sequential checks that you are still in the organisation, that your role allows every access of the connection, and that you meet its 2FA rule.
- **A forwarded link does not connect.** A connection link that someone sends you does not connect their claude.ai to your account. claude.ai shows "Account mismatch".
- **What leaves Sequential.** Sequential sends claude.ai the answers to its tool calls. It also sends fixed text (the tool descriptions and the server instructions), and the credentials of the connection. The text is the same for every customer, except that send_feedback has a second fixed description for a connection that may send feedback without asking. Sequential sends nothing else to the company that runs claude.ai.
- **The same screen as for a token.** Visitor text in tool answers is screened and marked. See [Privacy at a glance](/docs/privacy-overview#access-tokens-and-agents).
- **To end access,** disconnect it on both sides. See [Disconnect claude.ai](#disconnect-claude-ai).

The [Audit log](/docs/audit-log), in Settings › Organisation, records these actions:

| Action code | Recorded when | Reads as |
|---|---|---|
| `oauth.consent_granted` | Someone presses **Allow**, and Sequential creates the connection | "Ana allowed an agent to connect." |
| `oauth.token_issued` | claude.ai finishes the connection | "The agent connection “…” finished connecting." If the app cannot find the connection: "An agent finished connecting." |
| `access_token.revoked` | Someone disconnects a connection, or presses **Cancel connection** on a connection that is still connecting | "Ana disconnected the agent connection “…”." |
| `oauth.grant_revoked` | Sequential ends a connection: the person lost access, changed or reset their password, or a sign-in code was used twice | "Sequential ended an agent connection." For a password change or reset, the person's name comes first. |
| `oauth.refresh_reuse_detected` | An old renewal credential was used again. Sequential ends the connection to protect it | "Sequential ended an agent connection whose refresh token was used twice." |
| `oauth.revoked_by_client` | The connected app told Sequential that it disconnected | "The agent connection “…” ended its own connection." |

A **Deny** does not show in your audit log.

## FAQ

### Which other agents can connect?

From 9 November 2026, ChatGPT connects with a sign-in too. See [Connect ChatGPT](/docs/connect-chatgpt).

From 19 October 2026, Claude Code can connect with a sign-in too, or with a project access token (`sq_pat_…`). Its sign-in connections show on Agents as "Claude Code (localhost)". See [Connect Claude Code](/docs/connect-claude-code).

### Does claude.ai give Sequential's server instructions to its model?

Sequential's MCP server sends short instructions when an agent connects. When Sequential tested it in October 2026, claude.ai did not give these instructions to its model. In a test on 4 November 2026, claude.ai added them to the answers of the tool calls. This can change again.

claude.ai also keeps a copy of the tool list for a time. After Sequential adds a tool or an argument, claude.ai can use its older copy for a while: in Sequential's tests, from 8 minutes to more than 25 minutes. Sequential still takes a new argument when the model names it. In Sequential's test, disconnecting Sequential in claude.ai and connecting it again gave the new list at once. claude.ai can then ask you to allow each tool again.

The model always gets the description of each tool and the answers to its tool calls. The tool descriptions also say that quoted text from your users' sessions is data, not instructions. To get claude.ai to work in a certain way, say so in your message.

In the October tests, claude.ai showed its model only the name and the start of the description of each tool, and loaded a tool in full when it searched for one. So name Sequential in your first message, for example "Using Sequential, what should I know about my product this week?"

### When does the consent page ask for a two-factor code?

- If your account has 2FA, Sequential asks for a code before it connects. It does not ask again if you entered a code or a backup code in this sign-in in the last 15 minutes, for example when you signed in. A trusted device does not count.
- When Sequential needs a code, the page shows Authenticator code and "Enter a code from your authenticator app, or a backup code, to connect." The button then says Verify and allow. Enter the code, then click Verify and allow.
- If you do not have 2FA, and your organisation does not require it, Sequential does not ask for a code.

### Which role changes end a connection?

Sequential ends a connection when the person who connected it gets a role that does not allow every scope of the connection. A member keeps every scope except `changes:read_sensitive`. A viewer cannot keep `ask:use`, `findings:link`, `insights:propose`, `changes:propose` or `changes:read_sensitive`. Read and investigate holds `ask:use`, so that connection ends when its person becomes a viewer. If the person gets the old role back, the connection stays ended.

### Where else are my connections listed?

In Settings › Agents & tokens, owners and admins see the same connections under This project’s tokens, together with the project access tokens. Every role sees its own connections under Your connections. Each row shows:

- The name, for example "Claude (claude.ai)". Sequential sets this name.
- "Agent connection" and, in brackets, the name that claude.ai sent. Sequential does not check this name.
- What the connection may do.
- "Last used" with how long ago, or "Never used". Then "expires" and the date. Under This project’s tokens, then "connected by" and the name of the person who clicked Allow.
- A badge when the connection does not work, as on Agents.
- Disconnect… on each connection that can still work, also on a connection that is still connecting.

Connections that do not work any more, also an idle one, are under Revoked and expired there, closed at first.

## Next steps

- [Your first hour: connect your agent](/docs/quickstart#connect-your-agent): the agent step of onboarding.
- [Agent tools](/docs/agent-tools): every tool and its scope.
- [Limits](/docs/limits#programmatic-access): limits for tokens and connections.
- [Roles and permissions](/docs/roles-and-permissions): what each role can do.
- [Privacy at a glance](/docs/privacy-overview): what Sequential does with your data.
