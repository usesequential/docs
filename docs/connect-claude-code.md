# Connect Claude Code to Sequential (MCP)

> Connect Claude Code to Sequential over MCP: sign in from Claude Code, or use a project access token. Then start a new session.

> **In short**
>
> - From 19 October 2026, Claude Code can connect in two ways: with a sign-in to Sequential, or with a project access token.
> - Every role can connect with a sign-in. Only owners and admins can create a token.
> - After you add Sequential, start a new Claude Code session. The tools load only there.
> - Other coding agents, such as Cursor, connect only with a token.

## Before you start

- You need Claude Code on your computer.
- For a sign-in, you need an account in the project's organisation. Every role can connect. Your role decides what the connection can do, as for claude.ai.
- For a token, you must be an owner or admin of the project's organisation.
- claude.ai connects with a sign-in too. See [Connect claude.ai to Sequential](/docs/connect-claude-ai).

## Connect with a sign-in

1. Run this command once in a terminal. It has no token:

```sh
claude mcp add --transport http --scope user sequential https://api.usesequential.com/mcp
```

2. Start a new Claude Code session. A server that you add with `--scope user` does not load into the session that added it.
3. In Claude Code, open the `/mcp` menu, select **sequential** and choose **Authenticate**. Your browser opens the Sequential consent page.
4. If you are not signed in to Sequential, sign in. Choose the project and the access, as for claude.ai. The page says "Sequential will send you back to Claude Code on this computer."
5. Read the warning above **Allow**: "Continue only if you started Claude Code on this computer just now. Any program on this computer can ask to connect in its name." Press **Allow** only if you started this sign-in yourself, just now.
6. Your browser sends you back to Claude Code. Ask Claude Code to use Sequential, for example "Using Sequential, list my sessions from today".

The consent page, its 2FA step, its limits and its messages are the same as for claude.ai. See [Connect claude.ai to Sequential](/docs/connect-claude-ai).

**Why the warning.** Claude Code gets the sign-in back through an address on your own computer, such as `http://localhost:<port>/callback`. Sequential accepts such an address only from Claude Code, by its exact client id. Any program on your computer can start a sign-in in the name of Claude Code. Only your **Allow** stops it.

**Where the connection shows.** On **Agents**, under **Connected**, a card shows the connection as "Claude Code (localhost)" or "Claude Code (127.0.0.1)". Under the name, the card says "OAuth app" and the name that Claude Code sent. Owners and admins see every connection of the project. A member or viewer sees only their own, with the note "Only owners and admins see every agent; here is your own:". Connections with the same name, the same app and the same status show on one card, for example with "2 connections". After a connection ends, its card moves under **Revoked and expired**. In Settings › Agents & tokens, the connection shows under **Your connections**, as "Agent connection" and the name that Claude Code sent. Owners and admins also see it there under **This project’s tokens**.

**To end it**, press **Disconnect…** on its card under **Agents**. Every role can end its own connections there. An owner or admin can end every connection of the project. Every role can also disconnect its own connections in Settings › Agents & tokens, under **Your connections**. `claude mcp remove sequential` removes Sequential only from Claude Code. If you remove it only there, expect the connection to stay live in Sequential.

## Connect with a token

1. Get a token. Only owners and admins make tokens. Use one of these places:
   - In onboarding, on the **Connect your agent** step, select **Claude Code**. When the step has no **claude.ai** tab, **Claude Code** is open first. Sequential makes the token when the tab opens. The page says "Making a token for your agent…". The token is named "Coding agent (onboarding)" and expires in 90 days. It is the same token that **Agents** makes, until you reload the page. If Sequential cannot make it, press **Create token**.
   - On **Agents**, under **Connect an agent**, select **Claude Code**. Sequential makes the token when you select the tab: there is no form. The page says "Making a token for your agent…". The token is named "Coding agent (onboarding)" and expires in 90 days. If the **Claude Code** tab is already open, press **Make a token for your agent**.
   - In Settings › Agents & tokens, make a token under **Make a token**. The commands under **Connect an agent** then carry it.

   The tokens from onboarding and from **Agents** can watch sessions, ask the judge, read cases, check fixes, read sessions and read analytics. While Changes is on, they also read the timeline.
2. Copy the command that Sequential shows. The page shows the token masked, and **Copy** copies the whole token. The command has this form:

```sh
claude mcp add --transport http --scope user sequential https://api.usesequential.com/mcp --header "Authorization: Bearer <your token>"
```

3. Run the command once in a terminal. With `--scope user`, Sequential is added for every project on your computer.
4. Start a new Claude Code session. A server that you add with `--scope user` does not load into the session that added it.
5. Ask Claude Code to use Sequential, for example "Using Sequential, list my sessions from today". On **Agents**, the card of the token then says "Last used" and how long ago. For 15 minutes after a tool call, it also shows **Working now**. Before the first tool call, the card says "Last signed in" and a time, or "Never used".

For a connection that reads, use the path `/mcp/readonly` in place of `/mcp`. Under **Connect an agent**, the tab **Read-only endpoint (no write tools)** shows this command for Claude Code. On `/mcp/readonly`, Sequential does not list the tools that change data, with one exception: `get_fix_brief`. Getting a fix brief marks the case as handed off.

> **The token is shown once**
>
> Sequential shows the token only once. Treat it like a password. Never put it into a shared chat, a ticket or a committed file. If you lose it, revoke it on **Agents** and create a new one.

## If it does not work

| You see | Cause | What to do |
|---|---|---|
| 401, "The access token is unknown, revoked or expired", or the Sequential tools do not load | The token is wrong, revoked or expired. | Create a new token and run the command again with it. |
| The tools are not in the session where you ran the command | This is expected. | Start a new Claude Code session. |
| "Tool not available for this token" | The token's scopes do not include that tool. Or the connection uses `/mcp/readonly`, which does not list the tools that change data, except `get_fix_brief`. | Use a token with that scope, on `/mcp`. |
| Another coding agent, such as Cursor, cannot finish a sign-in | Sequential accepts a sign-in to an address on your computer only from Claude Code. | Use a token. |

See [Your first hour](/docs/quickstart#connect-your-agent) and [Agent tools (MCP)](/docs/agent-tools).
