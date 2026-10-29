# Connect claude.ai to Sequential (MCP)

> Add Sequential to claude.ai as a custom connector. Sign in, choose one project and what claude.ai can read, then find and end the connection under Agents.

> **In short**
>
> - claude.ai connects with a sign-in to Sequential, not with an access token. You do not copy a secret.
> - Every role can connect claude.ai. Your role decides what the connection can do. Each connection is for one project.
> - On the Sequential consent page, you choose what claude.ai can read. claude.ai cannot ask for more.
> - To end a connection, disconnect it in Sequential, and remove the connector in claude.ai. If you remove it only in claude.ai, expect it to stay live in Sequential.
> - ChatGPT cannot connect yet. Under **Connect an agent**, a line says "Coming soon: ChatGPT. We’ll show the steps here when it can connect to Sequential."

## Before you start

- Every role can connect: owner, admin, member and viewer. Your role decides what the connection can do. A viewer's connection reads, and can send feedback for the viewer when they tick "Also: it sends feedback to Sequential". It cannot use **Ask**, link fixes or propose questions.
- The project must not be archived.
- If your organisation requires two-factor authentication (2FA), you must have 2FA on your account.
- Your claude.ai account must let you add a custom connector.

From 19 October 2026, Claude Code can connect with a sign-in too, or with an access token. Its sign-in connections show on **Agents** as "Claude Code (localhost)". See [Connect Claude Code](/docs/connect-claude-code).

## Connect claude.ai

1. In Sequential, open **Agents** in the left rail. Under **Connect an agent**, select the **claude.ai** tab. When nothing is connected yet, this section is first on the page. Otherwise, it is under **Connected**, with the title **Connect another agent**. The **Connect an agent** button at the top of the page goes to it.
2. Next to **Connector URL**, press **Copy**. This copies the connector URL: the address of your Sequential API, followed by `/mcp`.
3. Do what the steps say: "In claude.ai, open Settings, then Connectors, then Add custom connector." Then: "Paste the URL below and leave the advanced settings blank."
4. In claude.ai, connect the new connector. A Sequential window opens.
5. If you are not signed in to Sequential, sign in. If your account has 2FA, enter your code. The last step on the tab says: "claude.ai sends you here to sign in and choose the project. You choose what it may do."
6. The consent page opens. Its title is "Claude wants to connect to Sequential". Choose the project and the access. See [The consent page](#the-consent-page).
7. Press **Allow**. Sequential sends you back to claude.ai.

The same tab is under **Connect an agent** in Settings › Agents & tokens. Under the steps, it says "No token is needed, and every role can connect this way. It then shows under “Your connections”." On **Agents**, this line ends with "Connected". In onboarding, the **Connect your agent** step has a **claude.ai** tab while the claude.ai sign-in is on. This tab is first and open. It shows the same URL and the same first two steps. Its third step ends "No token is needed, and every role can do this." On **Agents**, the third step ends "You choose what it may do." You do not create a token on this tab.

On **Agents**, in Settings › Agents & tokens and in onboarding, Sequential checks once, when the page loads, that the claude.ai sign-in is on. Until the check answers, these pages show no tabs. Until it is sure, they have no **claude.ai** tab:

- "Checking whether claude.ai can connect…": the check has not answered yet.
- "Couldn’t check whether claude.ai is available" and **Retry**: the check got no answer. Press **Retry** to check again.
- "claude.ai: Not available yet.": your Sequential server answered that the sign-in is off.

In onboarding, while there is no **claude.ai** tab, **Claude Code** is open first. After **Retry**, the open tab stays open, also when the **claude.ai** tab is added.

**Done when:** on **Agents**, under **Connected**, a card shows the connection as "Claude (claude.ai)". After the first tool call, the card says "Last used" and a time.

## The consent page

The consent page shows who asks, where Sequential sends you back to, and who you are.

- **Title:** "Claude wants to connect to Sequential". Sequential shows a name only for an app that it knows. Any other app shows as "An unverified app wants to connect to Sequential".
- "Sequential will send you back to claude.ai."
- "Signed in as" and your email. To use a different account, press **Not you? Switch account**. Sequential signs you out. Then start again from claude.ai.

**Project.** The list shows each project of each of your organisations, as "organisation / project". Choose one. If only one project can be connected, it is already selected. While no project is selected, a line says "Choose a project to allow this connection." A project that you cannot connect is dimmed and shows the reason in brackets:

| Reason | What it means |
|---|---|
| "archived" | The project is archived. Restore it first. |
| "needs an owner or admin" | Your role in that organisation allows none of the access. Today every role allows some access, so you do not see this. |
| "needs two-factor on your account" | The organisation requires 2FA, and your account does not have 2FA. You cannot choose the project. Press **Turn on two-factor**: Settings › Security opens in a new tab. Set up 2FA there. Then come back and press **Check again**. |
| "asks for your authenticator code" | The organisation requires 2FA. You have 2FA, but this sign-in did not pass it. You can choose the project. When you press **Allow**, the page asks for a code first. |
| "at your connection limit: 10 of 10" | You have 10 connections to this project. Connections that are still being set up count too. See [Limits](#limits). |
| "at its connection limit: 50 of 50" | The project has 50 connections. |

**Access.** Under **What it may do**, choose one:

- **Read and investigate**. It is selected first. A line under it says what it allows: "It watches sessions, asks the judge, reads cases, checks fixes, reads sessions, reads analytics and reads the timeline." With "reads analytics", claude.ai can read your analytics: event counts, funnels, flows, retention, and users and accounts by id. See [Privacy at a glance](/docs/privacy-overview#analytics). "reads the timeline" is the changes your team recorded, without the admins-only ones. See [Changes](/docs/changes).
- **Without Ask, so it spends no AI budget**. The same, without "asks the judge". claude.ai then cannot run **Ask**, so it cannot spend the agent allowance of the project. Sequential still screens visitor text in tool answers, under a separate budget.

Under the two choices are check boxes. Each one is off at first, and none shows for the read-only address:

- "Also: it links fixes", with the line "It can attach a pull request to a case, so the release is measured. This is a write." Turn it on only if claude.ai must add fix links to cases.
- From 12 October 2026, "Also: it proposes questions" can show: "It suggests edits to the questions; an owner or admin applies them. This is a write." See [Proposals from an agent](/docs/rubric#proposals-from-an-agent). While the questions are Sequential's defaults, **Questions** then gives you a prompt to paste into claude.ai. See [Let your agent suggest questions](/docs/rubric#let-your-agent-suggest-questions).
- "Also: it sends feedback to Sequential" lets your agent send feedback to the Sequential team as you. While it is ticked, a second box shows under it: "Let it send feedback without asking". See [Send feedback](/docs/send-feedback).
- From 22 October 2026, "Also: it proposes timeline changes": "It suggests timeline entries; nothing lands until someone confirms them." See [Changes](/docs/changes).
- From 22 October 2026, "Also: it reads admins-only changes": "Planned prices and other entries only owners and admins see. It stops if you stop being one." With 2FA on, it asks for your second factor. From 23 October 2026, you do not need 2FA for it.

When your account does not have 2FA, a line under the buttons says "Two-factor is off for your account. Turning it on in Settings › Security protects every agent connection."

Your role in the chosen project decides which choices show. An owner or admin gets them all. A member gets them all except "Also: it reads admins-only changes". A viewer gets only **Without Ask, so it spends no AI budget** and, of the check boxes, only "Also: it sends feedback to Sequential". The page then says what the connection cannot do. It names only the check boxes on offer that your role cannot take, for example "With your role in this project, the connection can read. It cannot use Ask, link fixes or propose questions." When the timeline check boxes are on offer, the line ends "propose questions or propose changes."

**Decide.** Above the buttons, the page says: "Only allow if you just pressed Connect in Claude yourself." Never press **Allow** for a request that you did not start. **Deny** has the focus. The X key also denies. To connect, press **Allow**. At the bottom, the page says "You can disconnect it any time under Agents."

> **Sequential decides the access, not claude.ai**
>
> When claude.ai starts the sign-in, it asks for permissions. Sequential does not use that request. Only the options that you choose on the consent page decide what claude.ai can do. A connection can never record a release.

### Two-factor codes on the consent page

- If your account has 2FA, Sequential asks for a code before it connects. It does not ask again if you entered a code or a backup code in this sign-in in the last 15 minutes, for example when you signed in. A trusted device does not count.
- When Sequential needs a code, the page shows **Authenticator code** and "Enter a code from your authenticator app, or a backup code, to connect." The button then says **Verify and allow**. Enter the code, then press **Verify and allow**.
- If you do not have 2FA, and your organisation does not require it, Sequential does not ask for a code.

### Messages during the sign-in

| You see | Cause | What to do |
|---|---|---|
| "This connection request has expired. Start again from claude.ai or your agent." | A connection request is valid for 10 minutes. From 23 October 2026, while the consent page or onboarding is open, Sequential keeps the request alive, up to 60 minutes after it started. | Start again from claude.ai. |
| "This connection was started in another browser. Start again from claude.ai or your agent." | You opened the consent page in a different browser from the one where claude.ai started the connection. | Start again from claude.ai, and stay in the same browser. |
| "This connection request was already answered. Start again from claude.ai or your agent." | Someone pressed **Allow** or **Deny** for this request. | Start again from claude.ai. |
| "This connection request belongs to another Sequential account. Start again from claude.ai or your agent." | A different Sequential account opened this request first. | Start again from claude.ai. |
| "This app’s registration with Sequential has ended. Start again from claude.ai or your agent." | Sequential no longer has the registration of the app. | Start again from claude.ai. |
| "You have reached your connection limit for this project. Disconnect one under Agents, then try again. Connections still being set up count too; they clear within 10 minutes." | You have 10 connections to the project. Connections that are still being set up count too. | Disconnect one. Then press **Allow** again. |
| "This project has reached its connection limit. An owner or admin can disconnect one under Agents, then try again." | The project has 50 connections. | An owner or admin disconnects one under **Agents**. |
| "Too many connections in the last hour. Try again later." | You pressed **Allow** more than 20 times in one hour, including presses that were refused. | Wait, then try again. |
| "Only owners and admins can connect an agent to this project." | Your role allows none of the access. Today every role allows some access. | Ask an owner or admin. |
| "Your role in this project does not allow that access. Choose what your role allows, then try again." | You chose access that your role does not allow. For example, your role changed to viewer after the page opened. The page reads the request again. | Choose **Without Ask, so it spends no AI budget**. Leave every check box off. Then press **Allow**. |
| "This project is archived. Restore it before connecting." | The project is archived. | Restore it, or choose another project. |
| "This organisation requires two-factor. Turn it on in Settings › Security first, then press Allow again." | Your account does not have 2FA. | Press **Turn on two-factor**. Settings › Security opens in a new tab. Set up 2FA there, then press **Allow** again. |
| "This organisation needs two-factor on this session. Enter a code from your authenticator app, or a backup code." | The organisation requires 2FA, and this sign-in did not pass 2FA. | The page shows **Authenticator code**. Enter a code, then press **Verify and allow**. You do not have to sign out. |
| "Sign in again before you connect: your last sign-in on this device was more than an hour ago." | From 23 October 2026: your account does not have 2FA, and your sign-in on this device is more than one hour old. **Allow** does not show. | Press **Sign in again**. Sequential signs you out on this device, and after the sign-in it opens the consent page again. Then press **Allow**. |
| "Only owners and admins can give a connection admins-only changes. Untick it, then press Allow again." | Your role changed after the page opened. The page reads the request again, and the box goes. | Press **Allow** again. |
| "One of the options you chose is not available now. Check the options, then press Allow again." | An option was turned off after the page opened. The page reads the request again. | Check the options, then press **Allow** again. |
| "Too many connection attempts from this network. Try again in a few minutes." | More than 60 connections started from your network address in 10 minutes. | Wait, then start again. |
| "This app is not one Sequential can connect to yet." | Sequential does not accept the app that started the connection, or could not read its registration just now. | Use claude.ai with the URL that Sequential shows. |

If the page has already loaded, and the request then expires or someone answers it, the message ends with "Start again from Claude."

## What claude.ai can do

- claude.ai uses Sequential's agent tools. The access that you chose decides which tools it gets. See [Agent tools](/docs/agent-tools).
- The tools that claude.ai lists follow the access of the connection. `record_release` and `request_fix_draft` never show, because a claude.ai connection cannot get `releases:write` or `findings:draft`. From 22 October 2026, `list_changes`, `get_change`, `get_change_schema`, `get_change_coverage` and `preview_changes` show with either access choice, because both include `changes:read`. From 22 October 2026, `list_finding_changes` shows too. `propose_changes` shows only when you ticked "Also: it proposes timeline changes". `record_change`, `record_changes`, `update_change`, `retract_change` and `link_change_to_finding` never show, because a claude.ai connection cannot get `changes:write`. With **Read and investigate**, claude.ai lists 35 tools. With **Without Ask, so it spends no AI budget**, it lists 34, without `ask_sessions`. Each check box that you ticked adds its tool. `link_fix` shows only when you ticked "Also: it links fixes" on the consent page. `propose_rubric` shows only when you ticked "Also: it proposes questions". `send_feedback` shows only on a connection with `feedback:write`. A connection has `feedback:write` only when you ticked "Also: it sends feedback to Sequential" on the consent page.
- claude.ai keeps its own copy of the tool list and the tool descriptions. When we tested it (October 2026), a reconnect of the connector in claude.ai read both again. After a Sequential release with new tools or new tool descriptions, reconnect the connector in claude.ai. Right after a reconnect, the first tool calls can fail with "The user didn't complete authentication. They can try again." Later calls in the same chat work, so ask again.
- With either access choice, claude.ai gets the eleven analytics tools of the scope `analytics:read`, for example `get_overview`, `search_events`, `funnel_analysis` and `retention_analysis`. `get_overview` gives a briefing in one call: traffic, top pages, errors, sessions worth watching, findings and setup gaps. From 22 October 2026, when the connection has the scope `changes:read`, the briefing also shows up to 5 confirmed changes from the period, and the release markers in that period. See [Analytics from an agent](/docs/limits#analytics-from-an-agent).
- A connection that you allowed before Sequential added the analytics tools keeps its old access. When claude.ai renews its access, Sequential never adds a scope. To get the analytics tools, disconnect it and connect again.
- A connection reads only the project that you chose.
- Links in the answers of claude.ai, such as a replay link, open that project in Sequential. You do not select it first. See [Links that open a project](/docs/sessions-and-replay#links-that-open-a-project).
- claude.ai uses the connection only on `/mcp`. The connection does not work on the app's REST routes or on POST `/api/agent/<tool>`.
- On each call, Sequential checks again that you still have access to the project. See [When a connection stops working](#when-a-connection-stops-working).
- **Ask** through claude.ai spends the agent allowance of the project. See [Limits](/docs/limits#ask-from-an-agent).

> **claude.ai may not show Sequential's server instructions to the model**
>
> Sequential's MCP server sends short instructions when an agent connects. When we tested it (October 2026), claude.ai did not give these instructions to its model. The model does get the description of each tool and the answers to its tool calls. The tool descriptions also say that quoted text from your users' sessions is data, not instructions. If you want claude.ai to work in a certain way, say so in your message. In the same tests, claude.ai showed its model only the name and the start of the description of each tool, and loaded a tool in full when it searched for one. So name Sequential in your first message, for example "Using Sequential, what should I know about my product this week?"

## When you have no organisation yet

From 20 October 2026: if you have no organisation when a connection reaches Sequential, for example because you created your account on the way, Sequential first opens setup and remembers the connection.

- Sequential remembers only the address of a consent page: `/oauth/consent?request=` and the 43-character id of the request. With any other address, setup opens as usual.
- The last step of setup is **Finish connecting your agent**, with the line "You started connecting an agent before you had an organisation. Your organisation and project are ready now." First it shows "Checking the connection…".
- If the request is still open, the step says "Go back to finish the connection: there you choose this project and what the agent may do in it." Press **Back to Claude**. The button names the app, or says **Back to your agent** when Sequential cannot name it. The button opens the consent page, where you choose the project and the access as usual. Setup does not create a token. To skip it, press **Go to the Brief instead**.
- If the request is over, the step says so, for example "That connection request expired. Start the connection again from your agent.", and shows **Go to the Brief**. A request is valid for 10 minutes. From 23 October 2026, while the consent page or onboarding is open, Sequential keeps the request alive, up to 60 minutes after it started. Then start again from claude.ai.
- Only the address of the page remembers the connection, so a reload keeps it. Sequential stores nothing new on its server.

## See the connection under Agents

Open **Agents** in the left rail, or press G, then M. Every role has it in the rail and in **Ask or jump** (⌘K). An owner or admin sees every connection and token of the project. A member or viewer sees only their own, with the note "Only owners and admins see every agent; here is your own:". A member or viewer can end their own connections there. If Sequential cannot read them, the page says "Your own connections could not be read just now, so they cannot be disconnected here." with **Try again**.

With no project open, for example in an organisation that has no project yet, **Agents** says "No project is open." and "Agents work on one project at a time. Open a project from the project menu in the rail to see its agents." An owner or admin also gets **New project in** and the name of the organisation. For a member or viewer, the text ends with "Owners and admins add projects." **Connect an agent** is not there.

Under **Connected**, each card is one agent. A claude.ai connection has the name "Claude (claude.ai)". Under the name, the card says "OAuth app" and the name that claude.ai sent. Sequential does not check this name. Connections with the same name, the same app and the same status show on one card, for example with "2 connections". A card shows:

- What the connection may do, for example "Watches sessions, asks the judge, reads cases, checks fixes, reads sessions, reads analytics and reads the timeline."
- A line such as "Last used 5 minutes ago · expires 19 Oct 2027 · made by Ana, 3 days ago". "Last used" counts only tool calls. Before the first tool call, the line starts with "Last signed in" and a time, or "Never used".
- **Working now**, for 15 minutes after a tool call.
- The number of calls in the last 7 days. Click it to show only the calls of this agent under **What they did**.
- A badge when the connection does not work. A connection that works has no badge.
- The button that ends it. An owner or admin sees it on every card. A member or viewer sees it on their own connections. When the card has more than one connection, **Each connection** lists them, each as "You · Connected" or, for a teammate, their name. A teammate's name is their email address when their name is blank.

| Badge | What it means | Button |
|---|---|---|
| **Pending**, "Waits for someone to finish connecting it." | Someone pressed **Allow**, and claude.ai has not finished. If claude.ai does not finish within 10 minutes, the connection moves under **Revoked and expired**, as **Expired**. | **Cancel…** |
| **Paused**, "Paused while the project is archived." | The project is archived. Restore the project, and the connection works again. | **Disconnect…** |
| **Access lost**, "Stopped working:" and the reason | The person who connected it lost the access that it needs, and Sequential has not ended it yet. At its next call, or at the daily check, Sequential ends it. Connect again. | **Disconnect…** |
| **App gone**, "The OAuth app behind it no longer exists." | Sequential no longer has the registration of the app. Connect again. | **Disconnect…** |
| **Idle**, "Not refreshed for a long time. It must reconnect." | claude.ai did not renew the connection for 30 days. It cannot work again. Connect again. | None |

**What they did**, on the same page, lists the calls of claude.ai together with the calls of your tokens, for the last 7 days.

### Revoked and expired

**Revoked and expired** is under the cards of **Connected**. It shows only when a connection or a token has ended, and it is closed at first. Its cards have a badge:

| Badge | What it means |
|---|---|
| **Revoked** | Someone disconnected it, or Sequential ended it. See [When a connection stops working](#when-a-connection-stops-working). Connect again. |
| **Expired** | The connection reached its end date, 365 days after **Allow**. Or claude.ai did not finish within 10 minutes of **Allow**. Connect again. |

A connection that ended stays in this list for 30 days. Then Sequential does not show it.

### In Settings › Agents & tokens

In Settings › Agents & tokens, owners and admins see the same connections under **This project’s tokens**, together with the access tokens. Every role sees its own connections under **Your connections**. Each row shows:

- The name, for example "Claude (claude.ai)". Sequential sets this name.
- "Agent connection" and, in brackets, the name that claude.ai sent. Sequential does not check this name.
- What the connection may do.
- "Last used" with how long ago, or "Never used". Then "expires" and the date. Under **This project’s tokens**, then "connected by" and the name of the person who pressed **Allow**.
- A badge when the connection does not work, as on **Agents**.
- **Disconnect…** on each connection that can still work, also on a connection that is still connecting.

Connections that do not work any more, also an idle one, are under **Revoked and expired** there, closed at first.

### An older connection that stays live

If you connect claude.ai again to the same project, you can have two connections that work. Sequential does not end the older connection. On **Agents**, both show on one card, with "2 connections". Open **Each connection** to see each one, with "Last used" and a time, or "Never used". If you do not use the older one, disconnect it. Until then, it counts toward your limits. See [Disconnect claude.ai](#disconnect-claude-ai).

## Disconnect claude.ai

Do both steps. Disconnecting in Sequential does not remove the connector in claude.ai. In our tests, removing the connector in claude.ai did not end the connection in Sequential.

1. In Sequential, end the connection:
   - Open **Agents**, find the card and press **Disconnect…**. Every role can do this for its own connections. An owner or admin can do it for every connection. The card asks: "Disconnect this agent? It stops working at once, and it has to be connected again to come back." **Cancel** has the focus. Press **Disconnect**.
   - Every role can disconnect its own connections in Settings › Agents & tokens, under **Your connections**. Press **Disconnect…**. The row says "Disconnecting “Claude (claude.ai)” stops that agent at once. It has to connect and be allowed again to come back. This cannot be undone." Press **Disconnect it**, or **Keep it as it is**.

   The connection then moves under **Revoked and expired**, as **Revoked**.
2. In claude.ai, remove the Sequential connector in claude.ai's connector settings.

Through the API, any person can end a connection that they made: POST `/api/projects/:id/tokens/mine/:tokenId/revoke`. To stop a connection that shows **Pending**, press **Cancel…** on **Agents**. Every role can cancel its own connection, and an owner or admin any connection. The card asks: "Cancel this connection? claude.ai has to start connecting again." **Keep** has the focus. Press **Cancel connection**. A connection under **Revoked and expired** has no button, because it cannot work again. On **Agents**, a connection that shows **Idle** has no button either.

> **Also disconnect the connection in Sequential**
>
> In our tests (October 2026), when you remove the connector in claude.ai, claude.ai does not tell Sequential. Expect the connection to stay live under **Agents**. It counts toward your limits until you disconnect it, or until it goes idle 30 days after claude.ai last renewed it.

## Limits

| Limit | Value | Result |
|---|---|---|
| Connections of one person to one project | 10. Connections that work, are being set up or are paused count | The project shows "at your connection limit". **Allow** shows the limit message. |
| Connections to one project, for all people | 50 | The project shows "at its connection limit". |
| **Allow** presses | 20 an hour per person | "Too many connections in the last hour. Try again later." |
| A connection request | Valid for 10 minutes. From 23 October 2026, up to 60 minutes after it started, while the consent page or onboarding is open | "This connection request has expired. Start again from claude.ai or your agent." |
| Connections started from one network address | 60 in 10 minutes | "Too many connection attempts from this network. Try again in a few minutes." |
| One access credential | 1 hour. Server default. claude.ai renews it without asking you | — |
| A connection without a renewal | 30 days. Server default | **Idle**. Connect again. |
| A connection | 365 days after **Allow**. Server default | **Expired**. Connect again. |
| Requests | 120 a minute per connection, as for a token. Server default | 429 `rate_limited` |
| Reads per project | 600 a minute, for all tokens and connections of the project together. By default, Sequential only counts them | See [Limits](/docs/limits#programmatic-access). |

## When a connection stops working

| Event | What happens |
|---|---|
| The project is archived | The connection pauses. A call from claude.ai gets "This connection is paused while its project is archived". Restore the project, and it works again. A paused connection still counts toward the limits. |
| The person who connected it is removed from the organisation or leaves it | Sequential ends the connection. It shows **Revoked**. |
| The person who connected it gets a role that does not allow every scope of the connection | Sequential ends the connection. It shows **Revoked**. A member keeps every scope except `changes:read_sensitive`. A viewer cannot keep `ask:use`, `findings:link`, `insights:propose`, `changes:propose` or `changes:read_sensitive`. **Read and investigate** holds `ask:use`, so that connection ends when its person becomes a viewer. If the person gets the old role back, the connection stays ended. |
| The organisation starts to require 2FA, and the person did not have 2FA when they connected | Sequential ends the connection when an owner or admin turns the requirement on. Otherwise, it ends it at its next call or at the daily check. |
| The person turns off 2FA while the organisation requires it | Sequential ends the connection. |
| The person changes their password in Settings › Security, or resets it | Sequential ends every claude.ai connection of that person, in every project. If Sequential cannot end them, it does not change the password. Try again. |
| A sign-in code or an old credential of the connection is used again | Sequential ends the connection to protect your data. |
| claude.ai does not renew the connection for 30 days | The connection shows **Idle**. |
| 365 days pass after **Allow** | The connection shows **Expired**. |
| The person who made it, an owner or an admin disconnects it | The connection stops at once. |

After any of these, except a pause, connect claude.ai again.

## Security and privacy

- **claude.ai acts for you, not as you.** Sequential never gives claude.ai your password or your Sequential sign-in. It gives claude.ai a connection that works only on `/mcp`, for one project, with the access that you chose.
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

## Related

- [Your first hour: connect your agent](/docs/quickstart#connect-your-agent)
- [Agent tools](/docs/agent-tools)
- [Limits](/docs/limits#programmatic-access)
- [Privacy at a glance](/docs/privacy-overview)
- [Roles and permissions](/docs/roles-and-permissions)
- [Audit log](/docs/audit-log)
- [Troubleshooting](/docs/troubleshooting#agents-claude-ai)
