# Connect ChatGPT to Sequential (MCP)

> Add Sequential to ChatGPT as a custom MCP server. You sign in to Sequential and choose the project and the access. There is no token to copy.

> **At a glance**
>
> - **Who can:** Every role in Sequential. Your role decides what the connection can do.
> - **Before you start:** A project that is not archived; 2FA, if your organisation requires it; a ChatGPT plan that can add a custom MCP server. In a ChatGPT Business or Enterprise/Edu workspace, an admin or owner of the workspace adds it.
> - **Key:** ChatGPT connects with a sign-in to Sequential, not with a project access token (`sq_pat_…`). You do not copy a secret.
> - **Works with:** ChatGPT on the web. ChatGPT Plus can add a custom MCP server: Sequential tested it on 9 November 2026, and ChatGPT read and wrote. OpenAI gives every tool to Business and Enterprise/Edu workspaces. On Pro, ChatGPT uses only the tools that read. Free and Go cannot add a custom server.
> - **Know this:** On the Sequential consent page, you choose what ChatGPT can do. ChatGPT cannot ask for more.
> - **Know this:** Sequential gives the agent what you tick on its page, whatever the agent asked for.
> - **Know this:** ChatGPT asks you before a tool only as its Permission setting says. With the default, Allow low-risk, ChatGPT ran a write without a question in our test.
> - **Know this:** When you click Disconnect in ChatGPT, ChatGPT tells Sequential, and the connection ends in Sequential too (our test, 9 November 2026).
> - **Know this:** ChatGPT stays connected: when its one-hour access ends, it renews the connection by itself, without asking you to sign in again (our test, 9 November 2026).

## Connect ChatGPT

> **Allow only a request that you started**
>
> Above the buttons, the consent page says: "Only allow if you just pressed Connect in ChatGPT yourself." Never click Allow for a request that you did not start.

1. In Sequential, open **Agents** in the left rail.

   **If you start in Settings or in onboarding**

   The same tab is under Connect an agent in Settings › Agents & tokens. In onboarding, the Connect your agent step has a ChatGPT tab after the claude.ai tab, while the sign-in is on.

2. Under **Connect an agent**, click the **ChatGPT** tab.

   **If you do not see the ChatGPT tab**

   Sequential checks once, when the page loads, that the sign-in is on. Until the check answers, there are no tabs. If the sign-in is off, a line says "claude.ai and ChatGPT: Not available yet." If the check fails, a line says "Couldn’t check whether claude.ai and ChatGPT are available", with Retry.

3. Next to **Server URL**, click **Copy**.

   Result: This copies the server URL: the address of your Sequential API, followed by `/mcp`.

4. In ChatGPT on the web, open **Plugins** in the left rail. Click **Add**, then **Add custom MCP server**.

   **If you want the exact steps from the tab**

   The ChatGPT tab says: "In ChatGPT on the web, open Plugins. Click Add, then Add custom MCP server." Then: "Name it Sequential. Paste the URL below as the Server URL and choose OAuth. Tick “I understand and want to continue”, then click Create as a plugin." The last step says: "Click Connect, then Connect Sequential. ChatGPT sends you here to sign in and choose the project. You choose what it may do."

5. In **Name**, type "Sequential". Under **Connection**, keep **Server URL** and paste the URL. Under **Authentication**, choose **OAuth**. Leave **Advanced OAuth settings** as they are.

6. Tick **I understand and want to continue**, then click **Create as a plugin**.

7. Click **Connect**, then **Connect Sequential**.

   Result: The same browser tab opens Sequential.

8. If you are not signed in to Sequential, sign in. If your account has 2FA, enter your code.

   Result: The consent page opens. Its title is "ChatGPT wants to connect to Sequential".

9. Choose one project, or all projects of an organisation, and the access. See [The consent page](/docs/connect-claude-ai#the-consent-page): it is the same for ChatGPT.

10. Click **Allow**.

    **If ChatGPT asks you before it uses a tool**

    In ChatGPT, the plugin has a **Permission** setting: "Choose when ChatGPT should ask for permission when using this plugin". It has four choices: "Always ask", "Allow read-only tools", "Allow low-risk tools" (the default; the plugin's settings show it as Allow low-risk) and "Allow all tools". In our test with the default, ChatGPT recorded a `review_session` check without asking. To have ChatGPT ask you before every change, choose "Allow read-only tools". To have it ask before every tool, choose "Always ask". Every Sequential tool says whether it only reads, whether it can overwrite, and whether it reaches outside Sequential.

Done when: Sequential sends you back to ChatGPT. Under Connected accounts, the plugin shows your Sequential account.

## Check it works

1. On the plugin's page in ChatGPT, click **Try in chat**. Ask, for example "Using Sequential, what are the biggest problems in my project this week?"

2. In Sequential, on **Agents**, under Connected, find "ChatGPT (chatgpt.com)".

   Result: After the first tool call, its row shows a time under Last used.

## What ChatGPT can do

- ChatGPT uses Sequential's [agent tools](/docs/agent-tools). The access that you chose on the consent page decides which tools it gets.
- It gets the same tools as claude.ai. See [Which tools claude.ai gets](/docs/connect-claude-ai#what-claude-ai-can-do).
- On ChatGPT Pro, ChatGPT uses only the tools that read, whatever the connection may do (OpenAI, November 2026).
- A connection to all projects of an organisation works as it does for claude.ai. See [All projects in an organisation](/docs/connect-claude-ai#all-projects-in-an-organisation).

## See the connection under Agents

Open Agents in the left rail. A ChatGPT connection has the name "ChatGPT (chatgpt.com)". Everything else is as for claude.ai: see [See the connection under Agents](/docs/connect-claude-ai#see-the-connection-under-agents).

## Disconnect ChatGPT

You can disconnect on either side. Disconnecting in Sequential does not remove the plugin in ChatGPT; ChatGPT then has to connect again.

1. In Sequential, open **Agents**, find "ChatGPT (chatgpt.com)" and click **Disconnect…**. Then click **Disconnect**.

   Result: The connection moves under Revoked and expired, as Revoked.

2. In ChatGPT, open the plugin settings of Sequential. Under **Connected accounts**, open the menu of your account and click **Disconnect**. ChatGPT tells Sequential, and the connection moves under Revoked and expired. To remove the plugin too, click **Uninstall**.

## Fix a failed connection

- The messages on the consent page are the same as for claude.ai, with "Start again from ChatGPT." See [Messages during the sign-in](/docs/connect-claude-ai#messages-during-the-sign-in).
- If you do not find Plugins, look in the left rail of ChatGPT on the web.
- ChatGPT keeps its own copy of the Sequential tool list and of Sequential's instructions for the agent. After you connect again with other access, or after Sequential changes a tool or its instructions, ChatGPT can still use the old ones, also in a new chat. Then open Plugin settings › Sequential and click **Refresh tools**.
- If ChatGPT says it cannot add the server, check your ChatGPT plan: Free and Go cannot add a custom server, and in a workspace only an admin or owner can.
- If the consent page title says "An unverified app wants to connect to Sequential", the request did not come from ChatGPT. Click Deny.

## Security and privacy

- **ChatGPT acts for you, not as you.** Sequential never gives ChatGPT your password or your Sequential sign-in. It gives ChatGPT a connection that works only on `/mcp`, for one project or for all projects of one organisation, with the access that you chose.
- **Your access limits it.** On each call, Sequential checks that you are still in the organisation, that your role allows every access of the connection, and that you meet its 2FA rule.
- **Only ChatGPT's own address gets the code.** Sequential sends the sign-in back only to an address on chatgpt.com that ChatGPT's registration names.
- **What leaves Sequential.** Sequential sends ChatGPT the answers to its tool calls, fixed text (the tool descriptions and the server instructions), and the credentials of the connection. Sequential sends nothing else to OpenAI.
- **The same screen as for a token.** Visitor text in tool answers is screened and marked. See [Privacy at a glance](/docs/privacy-overview#access-tokens-and-agents).
- **To end access,** disconnect it on both sides. See [Disconnect ChatGPT](#disconnect-chatgpt).

The [Audit log](/docs/audit-log) records a ChatGPT connection with the same actions as a claude.ai connection. See [Security and privacy](/docs/connect-claude-ai#security-and-privacy).

## FAQ

### Does Sequential send my data to OpenAI?

Only through the connection that you make. ChatGPT receives the answers to the tool calls that it makes, and OpenAI's terms apply to them. Sequential sends nothing to OpenAI by itself. See [Privacy at a glance](/docs/privacy-overview).

### Which ChatGPT plan do I need?

OpenAI decides this. When Sequential read OpenAI's help (9 November 2026): Business and Enterprise/Edu workspaces get every tool, and an admin or owner adds the server; Pro gets the tools that read; Free and Go cannot add a custom server. Plus can add a custom server: it read and wrote in our test (9 November 2026). For other plans, and for changes, see OpenAI's help.

## Next steps

- [Connect claude.ai](/docs/connect-claude-ai): the consent page, the messages and the limits in full.
- [Agent tools](/docs/agent-tools): every tool and its scope.
- [Limits](/docs/limits#programmatic-access): limits for tokens and connections.
- [Roles and permissions](/docs/roles-and-permissions): what each role can do.
