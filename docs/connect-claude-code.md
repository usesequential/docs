# Connect Claude Code to Sequential (MCP)

> Connect Claude Code to Sequential over MCP: sign in from Claude Code, or use a project access token. Then start a new session.

> **At a glance**
>
> - **Before you start:** Claude Code on your computer. For a sign-in, an account in the project's organisation.
> - **Who can:** Every role can connect with a sign-in. Only owners and admins of the project's organisation can create a token.
> - **Works with:** Claude Code, with a sign-in or project access token (`sq_pat_…`). Other coding agents, such as Cursor, connect only with a token.
> - **Know this:** After you add Sequential, start a new Claude Code session. The tools load only there.
> - **Know this:** For a sign-in, `claude mcp remove sequential` removes Sequential only from Claude Code. End the connection on Agents.

## Connect with a sign-in

Run this command once in a terminal. It has no token:

```sh
claude mcp add --transport http --scope user sequential https://api.usesequential.com/mcp
```

1. Start a new Claude Code session. A server that you add with `--scope user` does not load into the session that added it.

2. In Claude Code, open the `/mcp` menu.

3. Choose **sequential**, then **Authenticate**.

   Result: Your browser opens the Sequential consent page. If you are not signed in to Sequential, sign in.

4. Choose one project, or all projects of an organisation ([All projects in an organisation](/docs/connect-claude-ai#all-projects-in-an-organisation)).

5. Choose the access ([The consent page](/docs/connect-claude-ai#the-consent-page)).

   Result: Your role decides what the connection can do, as for claude.ai.

6. Read the warning above **Allow**.

   Result: It says: "Continue only if you started Claude Code on this computer just now. Any program on this computer can ask to connect in its name."

7. Click **Allow** only if you started this sign-in yourself, just now.

   Result: Your browser sends you back to Claude Code.

8. Ask Claude Code to use Sequential, for example "Using Sequential, list my sessions from today".

Done when: On Agents, under Connected, a row shows the connection ([Disconnect Claude Code](#disconnect-claude-code)).

### What the consent page shows, and why it warns you

The consent page, its 2FA step, its limits and its messages are the same as for claude.ai. See [Connect claude.ai to Sequential](/docs/connect-claude-ai).

The page also says "Sequential will send you back to Claude Code on this computer."

Why the warning: Claude Code gets the sign-in back through an address on your own computer, such as `http://localhost:<port>/callback`. Sequential accepts such an address only from Claude Code, by its exact client id. Any program on your computer can start a sign-in in the name of Claude Code. Only your Allow stops it.

## Connect with a token

> **The token is shown once**
>
> Sequential shows the token only once. Treat it like a password. Never put it into a shared chat, a ticket or a committed file. If you lose it, revoke it on Agents and create a new one.

The command that Sequential shows has this form:

```sh
claude mcp add --transport http --scope user sequential https://api.usesequential.com/mcp --header "Authorization: Bearer <your token>"
```

1. On Agents, under Connect an agent, click the **Claude Code** tab.

   Result: Sequential makes the token when you click the tab: there is no form. Other places: [Where to get a token, and what it can do](#where-to-get-a-token-and-what-it-can-do).

2. Copy the command that Sequential shows.

   Result: The page shows the token masked, and Copy copies the whole token.

3. Run the command once in a terminal.

   Result: With `--scope user`, Sequential is added for every project on your computer.

4. Start a new Claude Code session.

5. Ask Claude Code to use Sequential, for example "Using Sequential, list my sessions from today".

Done when: On Agents, the row of the token shows how long ago it was used, under Last used.

### Where to get a token, and what it can do

Use one of these places.

| Place | How | What you see |
|---|---|---|
| Onboarding | On the Connect your agent step, click the Claude Code tab. When the step has no claude.ai tab, Claude Code is open first. Sequential makes the token when the tab opens. | The page says "Making a token for your agent…". The token is named "Coding agent (onboarding)" and expires in 90 days. It is the same token that Agents makes, until you reload the page. If Sequential cannot make it, click Create token. |
| Agents | Under Connect an agent, click the Claude Code tab. | The page says "Making a token for your agent…". The token is named "Coding agent (onboarding)" and expires in 90 days. If the Claude Code tab is already open, click Make a token for your agent. |
| Settings › Agents & tokens | Make a token under Make a token. | The commands under Connect an agent then carry it. |

From 8 November 2026, on Agents, the fine print under "Make a token for your agent" has parts. It starts with "Reads only." Then three rows follow. "Reads" says "This project’s cases, sessions and verdicts, whether a fix worked, its event analytics, and Changes while it is on". "Asks" says "Which sessions match a description, checked by the judge. It can spend the project’s daily agent budget." "For" says "90 days". Under the rows, the line "Getting a fix brief marks the case as handed off." always shows. The old fine print is under "Read the full text ▾".

The tokens from onboarding and from Agents can watch sessions, ask the judge, read cases, check fixes, read sessions and read analytics. While Changes is on, they also read the timeline.

After a tool call, the row of the token on Agents shows how long ago, under Last used. For 15 minutes after a tool call, it also shows "Working now". Before the first tool call, it says, for example, "Signed in 4 days ago", or "Never used". On a narrow screen, the row says "Last used" or "Last signed in" before the time.

### Use a read-only connection

For a read-only connection, use the path `/mcp/readonly` in place of `/mcp`. Under Connect an agent, the tab "Read-only endpoint (no write tools)" shows this command for Claude Code. On `/mcp/readonly`, Sequential does not list the tools that change data, with one exception: `get_fix_brief`. Getting a fix brief marks the case as handed off.

## Disconnect Claude Code

> **Important**
>
> For a sign-in, `claude mcp remove sequential` removes Sequential only from Claude Code. If you remove it only there, expect the connection to stay live in Sequential.

Every role can end its own connections on Agents.

1. On **Agents**, find the row of the sign-in connection.

2. Click **Disconnect…** on the row.

Done when: After a connection ends, its row moves under Revoked and expired.

### What the card shows, and who can end it

From 8 November 2026, on Agents, under Connected, each connection has its own row. A row shows the connection as "Claude Code (localhost)" or "Claude Code (127.0.0.1)". Under the name, the row says "OAuth app:" and the name that Claude Code sent, then who connected it and when, for example "connected by you, 3 Nov".

- Owners and admins see every connection of the project. A member or viewer sees only their own, with the note "Only owners and admins see every agent; here is your own:".
- An owner or admin can end every connection of the project.
- Connections with the same name, the same kind and the same app show under one heading, with their number. Each of their rows starts with who connected it and when, for example "Connected by you, 3 Nov".

In Settings › Agents & tokens, the connection shows under Your connections, as "Agent connection" and the name that Claude Code sent. Owners and admins also see it there under This project’s tokens. Every role can also disconnect its own connections in Settings › Agents & tokens, under Your connections.

## If it does not work

| Symptom | Cause | Fix |
|---|---|---|
| The tools are not in the session where you ran the command | This is expected. A server that you add with `--scope user` does not load into the session that added it. | Start a new Claude Code session. |
| With a token: 401, "The access token is unknown, revoked or expired", or the Sequential tools do not load | The token is wrong, revoked or expired. | Create a new token and run the command again with it. |
| "Tool not available for this token" | The token's scopes do not include that tool. Or the connection uses `/mcp/readonly`, which does not list the tools that change data, except `get_fix_brief`. | Use a token with that scope, on `/mcp`. |
| A tool such as `link_fix` answers that it "is not enabled on this connection, so nothing was done" | On `/mcp`, a connection that does not have an extra of the consent page lists that extra's tool as a stub ([Changes to connecting Claude Code](#changes-to-connecting-claude-code)). | Connect again on the consent page and keep the box ticked, then disconnect the old connection under Agents. Or an owner or admin creates a new token with the scope. |
| Another coding agent, such as Cursor, cannot finish a sign-in | Sequential accepts a sign-in to an address on your computer only from Claude Code. | Use a token. |

For sign-in, 2FA and consent-page messages, see [Connect claude.ai to Sequential](/docs/connect-claude-ai).

### Changes to connecting Claude Code

From 19 October 2026, Claude Code can connect in two ways: with a sign-in to Sequential, or with a project access token.

From 1 November 2026, on `/mcp`, a connection that does not have an extra of the consent page lists that extra's tool as a stub. The title of the stub ends with "(not enabled)". The server's instructions also name what the connection does not have. A token cannot hold `feedback:write` or `changes:propose`, so a token on `/mcp` always lists the `send_feedback` stub.

From 12 November 2026, the token of an [agent trial](/docs/agent-trial) is the exception. It lists no stubs, and its instructions name only what it can do. They end with "After the person claims the project, they can connect an agent through the consent page."

## Next steps

- [Your first hour](/docs/quickstart#connect-your-agent): the Connect your agent step in onboarding.
- [Agent tools (MCP)](/docs/agent-tools): what each tool does.
- [Connect claude.ai to Sequential](/docs/connect-claude-ai): claude.ai connects with a sign-in too.
