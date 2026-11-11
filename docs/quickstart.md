# Quickstart: your first hour with Sequential

> Ten steps take you from a new account to your first judged sessions. Each step says how to check that it is done and links to more detail.

> **In short**
>
> - Steps 1 to 3: create an organisation and a project, then install one source. Check on Settings › Setup that your source shows "receiving".
> - Steps 4 to 8: identify your users, send custom events for key moments, check masking, open a replay, then look at Evidence.
> - Steps 9 and 10: tailor the questions and invite your team.
> - Optional: connect your coding agent to Sequential.

## What you need

- An account with a verified email address. Anyone can create an account. When you create it, you confirm that you act for a business or organisation and accept the [Terms of Service](/terms). See [Sign-up and invitations](/docs/sign-up-and-invitations).
- Your app's code, or a developer with access to it.
- A place where your change is live, and a normal browser to open it (steps 2 and 3).
- A test sign-in to your app (step 4).
- The owner or admin role for steps 6 and 9, and to make a token for an agent in onboarding. The person who creates the organisation is its owner. Every role can connect claude.ai, in onboarding and on Agents.
- For step 10, every role can invite while Who may invite is set to "Every member, up to their own role". See [Invite teammates](/docs/sign-up-and-invitations#invite-teammates).

## 1. Create your organisation and project

After sign-up, onboarding shows four steps: Organisation, Project, Install and Agent. A project is one app or site. See [Organisations, projects and keys](/docs/organisations-and-projects).

| Onboarding step | On this page |
|---|---|
| Organisation and Project | Step 1 |
| Install | Steps 2 and 3 |
| Agent (optional) | [Connect your agent](#connect-your-agent) |

1. Enter an **Organisation name** and press **Continue**.
2. Enter a **Project name** and press **Continue**. Optional: pick your kind of app first, and tick starter questions ([Starter questions](#starter-questions)).

Done when: the Install step shows your project's key.

### Starter questions

From 8 November 2026, when an owner or admin creates a project, the Project step asks "What kind of app is it? (optional)". The choices are "Fitness or health", "Shop", "Software (SaaS)", "Content or media" and "Something else".

- For the first four kinds, the step shows 3 yes-or-no questions with a tick box each. It says "Tick the questions you also want the judge to ask." No box is ticked at first.
- For "Something else", it says "Sequential starts with general starting questions. You can add your own later, on Questions."
- The step always says: "If you tick a question, we save your questions now. Your project then keeps its own set, and it does not get our later changes to the starting questions. You can change any question later, on Questions."
- Sequential adds the ticked questions to the starting questions right after it creates the project. The Install step then says, for example, "Added 2 questions. You can change them on Questions."
- With no kind, "Something else" or no tick, Sequential saves no questions. The project gets the starting questions, as before.
- If Sequential cannot save them, the Install step says "Your project is ready, but the questions you ticked were not saved." Click "Add them on Questions". Questions then shows them, not saved yet. Click Save to keep them. If they are already in the list, Questions says "These questions are already in your list."
- Sequential does not save the kind of app that you picked.

The starter questions:

| Kind of app | Question | What the step says under it |
|---|---|---|
| Fitness or health | Finished a workout | Does the user start a workout, a class or an activity and finish it? |
| Fitness or health | Logged an entry | Does the user log a meal, a measurement or an activity? |
| Fitness or health | Set a plan or goal | Does the user make or change a plan, a goal or a schedule? |
| Shop | Added to cart | Does the user add a product to the cart? |
| Shop | Placed an order | Does the user complete an order, for example, by reaching an order confirmation page? |
| Shop | Searched but opened nothing | Does the user search for a product and then leave the results without opening a product? |
| Software (SaaS) | Did the main task | Does the user complete the main task of the product (for example, create, send or publish something)? |
| Software (SaaS) | Invited a teammate | Does the user invite a teammate or share their work with another person? |
| Software (SaaS) | Opened plans or billing | Does the user open the pricing, plans or billing page? |
| Content or media | Started a piece of content | Does the user start to watch, listen to or read a piece of content? |
| Content or media | Reached the end | Does the user reach the end of a piece of content? |
| Content or media | Stopped by a paywall | Does a paywall or a sign-up wall stop the user from watching, listening or reading? |

See [Questions: what the judge asks](/docs/rubric).

### Onboarding, the install code and other environments

If your account has no name yet, the first form also asks for Your name. Sequential fills in a guess from your email address. Change it if it is not right. The first form also has a Slug field. It follows the name until you change it.

A done Project or Install step at the top of onboarding is a button, with Change. Click it to go back to that step. Back on Project, the title is "Rename your project". Continue saves a new name and opens Install.

If you already belong to an organisation, each step but Agent has Back to the Brief at the bottom. If the organisation already has a project, the Project step reads "Add a project to" and the organisation name, for example "Add a project to Acme".

After onboarding creates the project, the address reads `/onboarding?project=<id>&step=install`, and `step=agent` on the Agent step. It holds only these two values, and a third one when you started connecting an agent before you had an organisation: `next`, the address of that connection's consent page. See [Connect claude.ai](/docs/connect-claude-ai#when-you-have-no-organisation-yet).

A reload, or a phone that closes the tab, opens the same step again, with the same project and its keys. This works only for a project that is not archived, in an organisation where your role can create projects: owner or admin. Otherwise onboarding starts again.

Onboarding always creates a production project. For a staging or development project, owners and admins use New project in the project switcher. See [Add a project: the steps](/docs/organisations-and-projects#add-a-project-the-steps).

## 2. Install

Mobile app: use PostHog's mobile SDK. See [Mobile apps](/docs/mobile).

In onboarding, the Install step has two tabs. Use one.

On the Ask your coding agent tab:

1. Press **Copy**.
2. Give the prompt to your agent.

Or, on the Paste the snippet tab:

1. Open the tab of your source. Each key works for one source only.
2. Some sources have two forms. Choose **New install**, or the form for a site with the SDK, such as **Already using PostHog**.
3. Press **Copy** to copy the snippet.

Find the install code later in Settings › Setup.

Not sure which source? Choose your path in [Install Sequential](/docs/install):

- Website, no analytics yet: use the [Sequential SDK](/docs/sequential).
- PostHog, Mixpanel, Amplitude or Pendo: send your SDK's data to Sequential. For replays, add the [Session replay (web)](/docs/session-replay) line.
- Smartlook: send your snippet's data to Sequential. See [Moving from Smartlook](/docs/smartlook).

Done when: the change is live somewhere you can open in a normal browser.

### Install step: tabs, keys and messages

The Install step opens on the Ask your coding agent tab. The prompt tells the agent to add the Sequential tag to the `<head>` of every page.

On the Paste the snippet tab, each source of the project with a live ingest key has a tab. The order is Sequential, PostHog, Mixpanel, Amplitude, Pendo, Smartlook and Replay only. The Sequential tab has a third form, Google Tag Manager (Custom HTML tag), for a Custom HTML tag in Google Tag Manager. See [Configure without attributes](/docs/sequential#configure-without-attributes).

On the Paste the snippet tab, after you press Copy, the button reads Copied. Then open your app in a normal browser.

On the tabs:

- Each tab, except Pendo, also shows the Ingest key of its source.
- On Pendo, the step says "Your Pendo API key:" and "not registered yet" or "registered". An owner or admin can paste the `apiKey` from the Pendo snippet and press Register. See [Organisations, projects and keys](/docs/organisations-and-projects).
- Under an SDK that does not record by itself, Session replay gives the recorder line and the Replay key. On Sequential, the step says "Session replay is included in this tag." Both need a live replay key.

Under the tabs, the step says that the keys in these snippets only let your site or app send events to your project. They cannot read anything, so they are safe to ship in a page or an app. You can revoke them in Settings, under Ingest keys.

The step also says that web recordings mask all text and inputs by default, and that apps mask as their SDK code sets it.

From 6 November 2026, under each Ingest key and Replay key, a line says which SDK the key is for, for example "For PostHog SDKs: iOS, Android, React Native, Flutter, posthog-js."

Under that, one line says where the step stands. The step can also show a message about the keys:

| Message | What it means | What to do |
|---|---|---|
| "Waiting for the first event. Open your site in a browser with the snippet in place." | Nothing arrived yet. | — |
| "It works", with the source and the time of the first event, such as "The first event came from the Sequential tag, 2 minutes ago." | The first event arrived. | — |
| "Sequential could not check for events just now. It tries again every few seconds." | — | — |
| For example: "This project has no live key for the Sequential tag." | The project has no live key for the Sequential tag. The step says so in a line like this one. | An owner or admin presses Create a key. |
| "Only owners and admins make keys. Ask one of them." | Other roles see this line when the project has no live key for the Sequential tag. | — |
| "Sequential could not load this project's keys." | The keys cannot load after a reload. | Press Try again. |

The step checks every 5 seconds, only while the tab is visible, for 30 minutes. After that, the setup checklist on the Brief can check. See [The first run on the Brief](#the-first-run-on-the-brief).

Until the step says It works, the button at the bottom is Skip for now, with "Whatever you skip waits on the Brief." After that, the button is Continue. Both open the Agent step. See [Connect your agent](#connect-your-agent).

### Install with a coding agent, and what starts the recorder

1. On **Settings › Setup**, under Install with your AI agent, press **Copy prompt**. The prompt includes your keys.
2. Paste it into your coding agent.

Under Install, Settings › Setup shows the code with your keys filled in.

On websites, the Sequential SDK and the Smartlook script start the recorder for you. With PostHog, Mixpanel, Amplitude or Pendo, the recorder is the extra line from step 2.

### For coding agents

If the person has no Sequential key yet, create a trial for them. Do not leave a placeholder key in the code. Send one call: `POST https://api.usesequential.com/api/agent/provision` with the JSON body `{"owner_email": "<the person's email>", "platform": "web"}`. Ask the person for their email if you do not have it. The answer has the key and the snippet. Until the person claims the trial, it accepts events only from `localhost` and other local addresses, and keeps up to 100 sessions. Sequential sends the person an email with a claim link. Tell the person to claim the trial within 72 hours. If nobody claims it, Sequential erases it. See [Let your agent set up a trial](/docs/agent-trial).

## 3. Check that events arrive

With Settings › Setup open, visit your site in a normal browser. Sequential rejects automated browsers as bots. For a mobile app, see [Mobile apps](/docs/mobile).

Or, in onboarding, wait on the Install step. It says "It works" when the first event arrives.

The Sources card checks for 5 minutes. To keep checking, reload the page. Session replay can take up to about 7 minutes to show "receiving" on the Sources card.

Done when: your source reads "receiving" on the Sources card. If you are stuck, see [Check your install](/docs/verify).

### How the Sources card checks

- The Sequential line changes from "no events yet" to "receiving". The line of another SDK, such as PostHog, shows only from its first event, as "receiving". Session replay, if you installed it, also changes to "receiving", but it can take longer.
- The Session replay line changes after a page visit longer than the minimum recording length. The default is 2 s.
- The Sources card checks again every few seconds for 5 minutes. To keep checking, reload the page.
- Session replay can take up to about 7 minutes to show "receiving". The card checks for 5 minutes, so reload the page if it has not changed.
- A first event can take up to about a minute to appear. When one line shows "receiving", the other lines can take up to about two minutes to update.
- To change the minimum recording length, see Shortest session kept on Settings › Recording & data.
- The waiting message stays while any source is silent, even one you do not use. Read your own line.

### The first run on the Brief

While setup is not done, the Brief shows a setup checklist at the top. It has three steps: Send your sessions, Connect your agent and Give it a morning. Each step has one line that says where it stands.

Click a step to open it. Only one step is open at a time. When Sequential knows the state of all three steps, the checklist shows, for example, "1 of 3 done".

On a first run, the checklist has the title "Set up <project>". A first run is a project that has never received an event or a recording, and has no data for your dashboard. Under the checklist, a card says "<project> is ready. Nothing has arrived yet." The card says what appears, and when:

- About a minute after a visit starts: events and recordings, once the Sequential tag is on your site.
- About 35 minutes after a visit ends: the judge's verdict on that session. A session is judged once it has been quiet for 30 minutes.
- Every 15 minutes: cases. A JavaScript error in your own code, or a request that fails with a server error or a network failure, opens one from its first session. Other problems need 3 sessions from 2 people.

Under the card, "What a judged session looks like" shows a sample verdict, with "Sample · not your data". It is from a fictional shop. It goes when your first event arrives.

After a first run, the checklist has the title "Finish setting up". It shows only while a step is not done. For an owner or admin, it shows while no live token of the project has made a call, or when this browser showed the first-run checklist. For a member or viewer, it shows only when your dashboard has no data and this browser showed the first-run checklist.

Send your sessions:

- Owners, admins and members get the tabs of the onboarding Install step. A viewer sees "The install snippet needs a member, admin or owner — ask one for the keys."
- The step checks every 5 seconds, only while the tab is visible, for 5 minutes.
- On the Ask your coding agent tab, an owner or admin can press Add an agent access token to this prompt. Sequential makes a token with the first six scopes in [What token does Sequential make for your agent?](#what-token-does-sequential-make-for-your-agent), for 90 days. Its name is "Setup prompt on" and the date. The prompt then also connects the Sequential MCP server. The step says "The token in this prompt is shown once. Copy the prompt now, and treat it like a password." Sequential keeps the token only in the page.

The line of Send your sessions:

| Message | What it means | What to do |
|---|---|---|
| "Waiting for the first event · Checking every few seconds." | The step is open and no event has arrived. | — |
| "Waiting for the first event · Stopped checking after 5 minutes." | The step stopped checking. | Press Check again. |
| For example: "Requests with your key reached Sequential 1 minute ago. Events can take a minute to show." | Requests with your key arrived, but no event is stored yet. The line says when. | — |
| The line ends "but no events are stored." | After 2 minutes, or at once when Sequential refused requests that day. | The step gives a possible cause and Check your install. |
| "Events are arriving." | The first event arrived while the Brief is open. | Press Open the dashboard to load your dashboard. |
| "Last event" and a time | Later. The step lists each source with its last event. | — |
| "Couldn’t check for events right now." | Sequential cannot check. | Press Try again. |

Connect your agent:

- For an owner or admin, the step holds the Agent step of onboarding, with Check again. See [Connect your agent](#connect-your-agent).
- The line says, for example, "Not connected" or "Connected · <token name> · last call 2 hours ago". A token counts when it works, has made a call, is not a trial's token, and can read more than the timeline.
- Members and viewers see "An agent is connected", or "No agent connected yet · you can connect claude.ai or ChatGPT yourself under Agents."

Give it a morning:

- The step says "Sequential can’t see your agent’s scheduler. This ticks once your agent has called Sequential’s tools on 3 different days in a week."
- An owner or admin gets a prompt for the agent, with Copy prompt. The prompt tells the agent to set up a task for every weekday at 08:00 in its own scheduler, and to run it once now. From 1 November 2026, the instruction that it schedules starts with the line that names the open project by its slug, for example "Use the Sequential tools on the project "shop": pass project "shop" to every call that takes a project argument."
- The line says, for example, "<token name> called Sequential on 2 of the last 7 days · ticks at 3". Before your agent is connected, it says "After your agent is connected."

When Send your sessions is done, the checklist has Hide. Hide removes the checklist of this project in this browser. When all three steps are done, the checklist also stops in this browser. If your browser blocks site data, the checklist still shows, and Hide lasts only until you reload or leave the page.

If your account has no name that you chose, the Brief also shows Add your name: "Your team sees it next to what you do here. Until then, they see your email."

1. Type your name into **Your name**.
2. Press **Save**.

## 4. Identify your users

Until you identify a visitor, Sequential counts them as a new user on every device.

- Sequential SDK: call `sequential.identify(userId)` at sign-up, at sign-in, and on page load if the user is signed in. Call `sequential.reset()` at sign-out.
- Vendor SDK: keep its own identify call.
- Pass the same value every time for a given person. Two different values, such as an email at sign-up then an account id, make two users.

Done when: after a test sign-in, People lists you. The line under your name shows the email that you passed with identify, or "Identified". See [Identify your users](/docs/identify-users).

> **Some pages do not join earlier events yet**
>
> With the Sequential SDK, PostHog or Mixpanel, People, each person's page, funnels, flows, retention and Workbench › Events count the events sent before identify under the value you passed. This can take up to 5 minutes. The Brief counts people the same way. With a vendor SDK, People also lists the anonymous id as a separate user.

### Which value to pass

A user id, an email or an account key all work. Sequential uses the value exactly as you pass it.

Until you identify a visitor, their events carry an anonymous id for each browser. Sequential stores the events sent before identify under the anonymous id.

With a vendor SDK, People also lists the anonymous id from before your test sign-in. With the Sequential SDK, PostHog or Mixpanel, it lists that id only until the link to your value shows, up to 5 minutes later.

## 5. Send custom events for key moments

Send one event for each business moment, such as starting checkout. Give it a stable name, such as `checkout_started`. Put the details in properties.

A filter can test a property too, but separate names keep each moment easy to find and count. So give moments that you count separately different names.

With the Sequential SDK, call `sequential.capture(name, props)`. Names that start with `$` are reserved. `capture()` throws an error on them.

Done when: your event shows on Workbench › Events when you add a filter on the field Event with its name. See [Send custom events](/docs/custom-events).

### Event names and where events are used

- The Sequential SDK captures page views, clicks and form submits itself.
- Business moments need their own events. Other examples are signing up and inviting a teammate.
- Names that start with `$` are reserved. `capture()` throws an error on them.
- Vendor calls such as `mixpanel.track` keep their names.
- You can use custom events as funnel steps. The judge also reads them. See steps 8 and 9.

## 6. Check replay and masking settings

On Settings › Recording & data, check:

- Record sessions: on.
- Share of sessions recorded: the share you expect.
- Masking level: Strict is the default. It masks all text, inputs and most attribute values, so replays show only the page layout.
- Console message text: keep it off in production until you know what your app logs.
- Mobile apps: you set masking in the app's PostHog SDK.

Done when: Record sessions is on, Share of sessions recorded shows the share you expect, and Masking level shows your masking. See [Recording settings](/docs/recording-settings) and [Masking and redaction](/docs/masking-and-redaction).

### What Strict masking and DevTools capture

Replay is on for new projects.

With Strict masking, replays look like a wireframe.

Sequential captures errors, console, network and performance by default.

### Change to Balanced masking

Strict also blocks images, SVG, media and iframes. It cuts link and image addresses to their domain, so CSS background images do not load in the replay. From 26 October 2026, web fonts load, unless an id-like part masks the file name.

Balanced masks all inputs. It masks only the text you mark with `data-sq-mask` or the `sq-mask` class. It records images and SVG. It still blocks video, audio and iframes. It records attribute values and the full page address. See [Masking and redaction](/docs/masking-and-redaction).

To change to Balanced:

1. Mark the sensitive elements in your app.
2. Under **Masking level**, choose **Balanced**.
3. Press **Save changes**.
4. Under "This records more than before.", type the project slug.
5. Press **Save and record more**.

Changes apply from the next page load. They never apply to earlier recordings.

## 7. Open a replay

1. Click **Evidence** in the rail.
2. Click a session card. The session opens in the peek, with the player.

A recording can take up to about 6 minutes after its last upload to become playable. If you cannot play the session now, the card says why in place of the moment.

Done when: the recording plays, and What they did under it lists your events. See [Find and replay sessions](/docs/sessions-and-replay).

### When a recording is missing or shows no events

The card on Evidence can say:

| Message | What it means | What to do |
|---|---|---|
| "Ready by 14:05", with a time | Sequential is still preparing the recording in 5-minute periods. | Wait until that time. |
| "Recording not ready yet" | — | — |
| "No recording" | — | — |

Sequential builds the Evidence list from analytics events. So a recording appears only if the same session also sent events.

If the recording shows no events, the recording and the events had different session ids. See [Troubleshooting](/docs/troubleshooting).

## 8. Look at Evidence

Evidence shows the sessions of the last 7 days in lanes, the worst first. Judging starts about 30 minutes after the session's last event. The judge judges a session with at least 3 meaningful events.

Done when: you see judged sessions in the lanes. See [Evidence](/docs/watch) and [Reading a verdict](/docs/reading-verdicts).

### If Evidence shows a message

| Message | What it means | What to do |
|---|---|---|
| "Nothing the judge could read in the 7 calendar days to today." | Every session was too short, is waiting to be read, or the judge could not read it. | — |
| "No session in the 7 calendar days to today." | Sequential received no session in these days. | — |
| "Judging is off for this project, so new sessions are not judged." | Background judging is switched off for this project. This line is under the title. | An owner or admin turns it on with Judge new sessions automatically, under Settings › Recording & data › Judging. |

If background judging is off, new sessions show in Not judged. See [Evidence](/docs/watch).

### When a session is judged, and what a card shows

Each card has a short verdict. It also shows the moment to watch, for example "Struggled at 0:42".

- The judge judges a session with at least 3 meaningful events. System events do not count.
- The judge reads the session's events, not the recording.
- On the full page of a session, Right or Wrong on a reading records whether the reading was right. The judge does not judge the session again.

## 9. Tailor the questions

The questions are what the judge asks about each judged session.

1. In the rail, select **Questions**.
2. Click **Edit questions**, then **Add a signal**.
3. Under Try on a session, pick a recent session and click **Try it**.
4. Click **Save**.

Done when: the line under the title says "this project’s own", not "Sequential’s defaults". The judge uses your changes only for sessions judged after you save. See [Customise the questions](/docs/rubric).

### Good questions and what changes after you save

The default questions are generic. It cannot know your product's own moments, such as reaching bulk upload.

For a yes-or-no question, press Add a signal. In Try on a session, the judge answers your draft before you save it.

A good question:

- can be answered by the judge from events, session facts and error counts. The judge never sees the screen.
- asks one thing.
- asks what happened, not how someone felt. For example: "Did they click the same control repeatedly?"

Try on a session has its own daily allowance. So it does not use the allowance of background judging.

After you save, the full page of an older session says "The questions changed since; this reading is from the earlier version." If you change what the judge asks, the counts under Calibration also start again.

## 10. Invite your team

1. In the rail, press **Invite people**.
2. Enter one or more **Email addresses** and choose a **Role**.
3. Press **Send invitation**.

Or invite on Settings › Members, under Invite people.

Invitations expire after 48 hours. To accept, a teammate signs in with the invited address. That address must be verified.

Done when: your teammates are under People on Settings › Members, not under Invitations waiting.

### Send an invitation again, and what each role can do

A role covers every project in the organisation.

If you press Send again under Invitations waiting, the 48 hours start again.

| Role | In the app |
|---|---|
| Owner | Full control, including deleting the organisation. |
| Admin | Manages members, projects, keys and settings. |
| Member | Explores analytics and replays. Can use AI. |
| Viewer | Read-only access to analytics and replays. |

See [Roles and permissions](/docs/roles-and-permissions).

## Connect your agent

This step is optional. It lets an agent, such as claude.ai, Claude Code or Cursor, read your sessions, verdicts and findings over MCP.

To create a token, you need the owner or admin role. claude.ai needs no token.

From 19 October 2026, Claude Code can also connect with a sign-in, in every role. See [Connect Claude Code](/docs/connect-claude-code#connect-with-a-sign-in).

> **The token is shown once**
>
> Sequential shows the token only once. Sequential stores only a hash of the token.
>
> Treat the token like a password. Paste it only into your own agent. Never put it into a shared chat, a ticket or a committed file. If you lose it, revoke it and create a new one.

In onboarding:

1. On the Install step, press **Skip for now**, or **Continue** after the step says "It works". The Connect your agent step opens.
2. Pick your agent. For claude.ai, copy the **Connector URL** and follow [Connect claude.ai](/docs/connect-claude-ai). The claude.ai tab makes no token.
3. Open the **Claude Code** or **Other MCP clients** tab, if it is not open. For an owner or admin, Sequential then makes the token.
4. Copy the setup for your agent. The step shows the token masked, but **Copy** copies the real token. Add it to your agent's user-level settings, not to a file in your repository. On Claude Code, run the command once in a terminal. On Other MCP clients, add the JSON to the user-level MCP config of your client, for example `~/.cursor/mcp.json` for Cursor.
5. Ask your agent a question. The step suggests one: "Using Sequential, what should I know about my product this week?"
6. Press **Check the connection**.

Done when: onboarding says "Your agent made its first call" and when. For Claude Code, [Connect Claude Code](/docs/connect-claude-code) gives every step.

### Which tabs show, and where does each setup go?

Sequential first checks that the claude.ai sign-in is on. Until the check answers, the step shows no tabs.

- When the sign-in is on, the tabs are claude.ai, ChatGPT, Claude Code and Other MCP clients. claude.ai is open at first.
- Otherwise, the tabs are Claude Code and Other MCP clients, and Claude Code is open at first. The step then says "claude.ai and ChatGPT: Not available yet.", or "Couldn’t check whether claude.ai and ChatGPT are available" with Retry.

claude.ai and ChatGPT connect with a sign-in to Sequential, not with a token. Each has its own tab in onboarding and on Agents, while the sign-in is on. See [Connect claude.ai](/docs/connect-claude-ai) and [Connect ChatGPT](/docs/connect-chatgpt).

The same messages show on Agents:

| Message | What it means | What to do |
|---|---|---|
| "claude.ai and ChatGPT: Not available yet." | Your Sequential server answers that the sign-in is off. Agents and onboarding have no claude.ai or ChatGPT tab. | — |
| "Couldn’t check whether claude.ai and ChatGPT are available" | Sequential could not check. | Press Retry to check again. |

What each setup is, and where it goes:

| Agent | The setup | Where it goes |
|---|---|---|
| Claude Code | A `claude mcp add` command with `--scope user` | Run it once. It adds Sequential for every project on the computer. |
| Cursor | JSON with `url` and an `Authorization` header | `~/.cursor/mcp.json`, not the `.cursor/mcp.json` of a project |
| Codex | TOML: `[mcp_servers.sequential]` with `url` and `http_headers` | `~/.codex/config.toml` |
| Other MCP clients | The same JSON as Cursor | The user-level MCP config of your client. The key names can be different in each client. |
| Claude Desktop | JSON that runs `npx -y mcp-remote@0.14.3`. The header value is in `env`, as `AUTH_HEADER`. | `claude_desktop_config.json` (Settings → Developer → Edit Config). Then quit and open Claude Desktop again. It needs Node.js. |

### What token does Sequential make for your agent?

For an owner or admin, the step says "Making a token for your agent…". The token is named "Coding agent (onboarding)".

It has the scopes `sessions:explore`, `ask:use`, `findings:read`, `findings:verify`, `sessions:read`, `analytics:read`, and from 22 October 2026 `changes:read` while Changes is on. If Sequential cannot read the scopes that it can issue, the token gets the first six only. It expires in 90 days.

The token includes `analytics:read`, so your agent can use the analytics tools. See [Analytics from an agent](/docs/limits#analytics-from-an-agent).

It is the same token that Agents makes. One token serves the step and Agents until you reload the page. After it makes a new token, Sequential revokes your earlier "Coding agent (onboarding)" tokens that were never used. It never revokes the token of the Settings › Setup prompt.

If Sequential cannot make the token, the step says why and shows Create token. Press it to try again. Other messages:

| Message | What it means | What to do |
|---|---|---|
| "To create a token for your agent, enter a code from your authenticator app, or one of your backup codes." | Your second factor is needed. The step asks for the code in place. | Enter the code. Then Sequential makes the token. |
| "Sign in again (this signs you out on this device), then come back here for your token." | You must sign in again. | Press Sign in again. After the sign-in, Sequential opens this step again. |
| "The token is shown masked and goes only to your clipboard when you copy. It is not shown again, so copy it now." | In onboarding: Sequential shows the token only once. | — |
| "The token in these snippets is shown once. Copy yours now, and treat it like a password." | On Agents: Sequential shows the token only once. | — |

Later, open Agents in the rail. Connect an agent has a tab for each agent: claude.ai while its sign-in is on, then Claude Code, Cursor, Codex, Claude Desktop, Other MCP clients and Read-only endpoint (no write tools).

For an owner or admin, Sequential makes the token itself when you open a tab that uses one. The token is named "Coding agent (onboarding)". It has the same scopes, and it expires in 90 days.

- One token serves every tab until you reload the page. Sequential keeps it only in the page's memory and never stores it.
- After a reload, or on a new visit, Sequential makes a new token. Then it revokes your earlier "Coding agent (onboarding)" tokens that were never used. It never revokes a used token, a teammate's token or a token with another name.

### Checking the connection, skipping, and other ways to connect

- Check the connection checks one time if the token was used. A request that Sequential accepts with the token counts as a use. On `/mcp`, the first connection already counts. If there is no use yet, the step says "No call with this token yet. Run the setup, ask your agent a question, then check again."
- The step has one button to leave. Until your agent uses the new token, the button is Skip for now. Next to it, the step says "You can connect an agent later, under Agents." After that, the button is Go to the Brief. Both open the Brief. Neither creates a token. A token that the step made stays. Revoke it on Agents if you do not use it.
- On Claude Code and Other MCP clients, members and viewers see that only owners and admins make tokens. For example: "Other MCP clients connect with a project token, and only owners and admins make tokens. Ask one of them." When the step has a claude.ai tab, the line ends "Ask one of them, or connect claude.ai or ChatGPT, which work for every role."
- On Settings › Setup, Add an agent access token to this prompt is in the bar of the Install with your AI agent card, next to Copy prompt. It creates a token with the first six scopes above and adds a section to the prompt: "Connect the Sequential MCP server (optional)". The section has the Claude Code command with the token. It tells any other agent to add the same URL and `Authorization` header to its user-level MCP config. Then it tells the agent to confirm the connection with one call to `list_sessions`. If the Sequential tools load only in a new session, the agent tells you to restart it and makes the call then. The card then says "The token in this prompt is shown once. Copy the prompt now, and treat it like a password." and "The token expires in 90 days." If you reload or leave the page, the prompt no longer has the token.
- From 8 November 2026, rows show on the card once the prompt has the token. "Reads" says "This project’s cases, sessions and verdicts, whether a fix worked, and its event analytics". "Asks" says "Which sessions match a description, checked by the judge. It can spend the project’s daily agent budget." "Changes" says "Getting a fix brief marks the case as handed off." "Expires" says "In 90 days". "Shown" says "On this page only, until you reload or leave it. The copied prompt holds it and tells your agent to add it to its MCP config." "Stored" says "By Sequential: only a hash of it and its last four characters, never the token". "Revoke" says, for example, "In Settings › Agents & tokens: “Setup prompt on 8 Nov 2026”". Under the rows, the line "The token in this prompt is shown once. Copy the prompt now, and treat it like a password." always shows. The two old lines are behind "Read the full text ▾".
- The Brief shows a setup checklist while setup is not done. Its steps Send your sessions and Connect your agent hold the same Install and Agent steps. See [The first run on the Brief](#the-first-run-on-the-brief).
- For the tools that an agent gets, see [Agent tools](/docs/agent-tools). For the scopes and limits, see [Limits](/docs/limits#programmatic-access).

## Limits

- A recording appears on Evidence only if the same session also sent analytics events.
- The judge judges a session with at least 3 meaningful events. System events do not count. Judging starts about 30 minutes after the session's last event.
- Sequential picks up only sessions from the last 7 days for judging.
- On busy days, sessions can wait for the project's daily allowance.

## Related

- [How Sequential works](/docs/how-it-works)
- [What each SDK supports](/docs/support-matrix)
- [Feedback and calibration](/docs/feedback-and-calibration)
- [Glossary](/docs/glossary)
