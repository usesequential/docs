# Send feedback to the Sequential team

> Send a bug, a wish or an idea to the Sequential team from the app. See what it attaches, and follow its status and the replies.

> **At a glance**
>
> - **Who can:** Anyone signed in to Sequential can send feedback and read their own: Owner, Admin, Member and Viewer.
> - **Before you start:** You do not need an organisation or a project.
> - **You get:** Replies in the app and by email. Each item's status, in Your threads.
> - **Know this:** In the app, only you see your feedback. Other teammates do not see it.
> - **Know this:** An agent can send feedback for you (consent box "Also: it sends feedback to Sequential"). By default, it must ask first.

## Send feedback

1. At the bottom of the left rail, click the feedback button next to your name. Its label is "Send feedback to Sequential".

2. Under **What is it?**, choose Something is broken, Something is missing or An idea.

3. Write your text. A title and the impact are optional.

4. Check the lines under **Sent with it**. To leave a line out, click **Remove**.

   Result: Under the list, the form says "Your name and email go with it, so the team can answer. Never the page address or anything typed on it." See [What Sequential attaches](#what-sequential-attaches).

5. Click **Send to Sequential**, or press ⌘ Enter on a Mac or Ctrl Enter on other computers.

Result: A message says "Sent as #42. Sequential answers in its thread." The panel shows the new thread.

You can also open the panel from Help (Shift H) or from Ask or jump (⌘K or Ctrl K).

### All options: fields and drafts

- Impact: if something is broken, you can also select, under "How much does it get in your way?", It stops my work, It slows me down or Minor. This is optional. Not sure clears it.
- Title: to add a title, type it in Title. This is optional. The Title can have 120 characters.
- The text: if something is broken, the field is "What happened, and what did you expect?". Otherwise, it is "Tell us about it". You must write a text. The limit is 5,000 characters. From 4,500 characters, a line says how many characters are left.
- Drafts: if you close the panel or open another page, your text stays in the form. A reload or a closed tab loses it. Sequential clears the text after an accepted send.

### If the send fails

Your text stays in the form. Find the message that you see.

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Write a few words first." | — | — | Write a text. |
| "12 characters too long: at most 5000." | — | A line such as this one. | Make the text or the title shorter. |
| "The text is too long: at most 5000 characters." | — | — | Make the text or the title shorter. |
| "The title is too long: at most 120 characters." | — | — | Make the text or the title shorter. |
| "Sequential could not read that. Remove unusual characters and try again." | — | — | Change the text, then send it again. |
| "You have sent a lot in the last hour. Try again in N minutes." | — | — | Wait. See [Limits](#limits). |
| "Feedback cannot be sent right now. Try again in a few minutes, or write to support@usesequential.com." | — | — | Wait, or send an email to support@usesequential.com. |
| "Sequential could not be reached. Your text is still here: try again." | — | — | Click Send to Sequential again. |

## What Sequential attaches

Sequential never attaches the real page address, its query string or its `#` part. It never attaches what you typed in forms or the text on the page.

Under Sent with it, the form lists what goes with your text. To put a removed line back, click Add back. Sequential does not send a line that you removed.

From 8 November 2026, two rows under the list say what goes with your text. "Goes with it" says "Your name and email, so the team can answer. The lines above that you keep. An organisation, when there is one: the project’s, else your current one, else your only one." "Never" says "The page’s full address, its query or # part, or anything typed on the page". The old line, "Your name and email go with it, so the team can answer. Never the page address or anything typed on it.", is behind "Read the full text ▾".

| Line | What it holds |
|---|---|
| Project | The open project. Sequential keeps it only if you can open the project |
| Screen | The name of the screen that you are on, for example "Evidence" or "Workbench › Funnels". It also sends the page pattern, such as `/cases/[n]`. Not the real address |
| Case, Session, Person or Account | On the page of one case, session, person or account: its number or id |
| Browser | The browser name and main version, and the system name only, for example "Safari 18 on macOS" |
| Window size | The window size, for example "1440 × 900" |
| Theme | Light or Dark |
| Language | Your browser's language, such as "en-GB" |

### How Sequential reads and checks the lines

Sequential reads the list under Sent with it once, when the form opens. Each value has a limit of 200 characters. The server keeps only these items. It keeps an item id only with a known kind of item. It cuts an id at the first `?` or `#`. It does not keep an id that holds `://`. It keeps the Project line only if you can open the project.

## Follow your feedback

The feedback button in the rail shows a dot when a thread has an answer that you did not read.

1. At the bottom of the left rail, click the feedback button.

2. In the panel, open **Your threads**.

   Result: The thread with the newest change is first.

3. Click a thread to open it.

   Result: The thread shows your text, then each answer and each status change, oldest first. Opening the thread removes the dot on that thread.

4. Write your reply in **Reply to Sequential** (at most 5,000 characters).

5. Click **Send reply**.

You can reply while the item is open, and for 30 days after it closes.

### How replies and emails work in detail

- The team replies in the app, in the thread.
- Sequential also sends an email for each reply and each status change, but not for Received. The email goes only to a verified address. If the item has an organisation, you must still belong to it.
- The email asks you to reply in Sequential, so that your answer stays with your feedback.

For a merged item, the 30 days start when the similar request closes. After that, the thread says "This thread closed more than 30 days ago, so it takes no more replies. Something new? Write a new one."

### How the list of threads works in detail

- In the panel, open Your threads. The same list is in Settings › Your profile, under Feedback to Sequential. An old link to `/settings/feedback` opens it there.
- The thread with the newest change is first. Each row shows the title, the number, the kind, the status and when it last changed. Click Show older threads for older ones.
- From 2 November 2026, a row or a thread with no title shows a headline from its text: the first line, then the first sentence of it, at most 80 characters. A longer headline stops at a word and ends with "…". Sequential does not store the headline.
- A dot shows on a thread with an answer that you did not read. Open the thread to remove the dot. Above the list, a line says how many threads have an answer that you have not read.
- The Your threads tab shows how many threads have such an answer, and the feedback button in the rail shows a dot. Sequential reads the number every five minutes while the tab is visible.

A thread shows your text and Sent with it, closed at first: the lines that Sequential got, for example "Screen", "Browser", "System" and "Window size", with their values. Then it shows each answer and each status change, oldest first. Each entry shows You or Sequential, the time, and a status sentence or a message, for example "Sequential plans to do it."

## Who can see it

Your feedback goes to the Sequential team. In the app, only you see it. Other teammates do not see it.

Sequential records sessions of its own app, but it does not record what you write or what Sequential answers. The feedback panel and Feedback to Sequential in Settings › Your profile are marked `data-sq-private`, which every masking preset masks.

A project access token (`sq_pat_…`) cannot send or read feedback.

## Feedback from your agent

An agent can send feedback for you with the tool `send_feedback`. It needs a connection made by sign-in, from claude.ai or from Claude Code, with the scope `feedback:write`.

The scope `feedback:write` comes from the box "Also: it sends feedback to Sequential" on the consent page. From 1 November 2026, the box is ticked at first, when your role allows it. While it is ticked, a second box shows under it: "Let it send feedback without asking". That box is off at first.

By default, the agent must show you the exact kind and text, and send only after you say yes. After each send, Sequential emails you.

The email never holds the text. It goes only to a verified address, while you belong to the organisation.

### How agent feedback works in detail

From 16 October 2026, an agent can send feedback for you with the tool `send_feedback`. It needs a connection made by sign-in, from claude.ai or, from 19 October 2026, from Claude Code, with the scope `feedback:write`.

The help line of the box "Also: it sends feedback to Sequential" says "It sends a bug report or an idea to the Sequential team as you, after it shows you the text. This is a write." The help line of "Let it send feedback without asking" says "It then sends without showing you the text first. You get a mail for each one."

The tool sends a bug, a feature request or an idea about Sequential, not about your own site. Each call sends one item. The text has at most 1,000 characters and no title. Before Sequential stores it, it removes names, emails and secrets.

- The agent must show you the exact kind and text, and send only after you say yes, unless you ticked "Let it send feedback without asking".
- If no words are left after Sequential removes emails and secrets, Sequential refuses the text. From 14 November 2026, a name counts as a word: if the text is only a name that Sequential removes, Sequential stores `[person]`.
- The item is yours: it shows in Your threads, with the project of the connection. The team replies to it as to any other item.
- In the list and in the thread, an item from an agent shows "sent by" and a name, for example "sent by Claude". The name is Sequential's name for a known app, else the name that the agent's app gives itself, else "Unknown agent". Sequential does not check a name that the app gives itself. An item that you sent from the app shows no "sent by".
- After each send, Sequential emails you: "Your agent sent feedback #N". The email names the agent and the kind, and links to the item.
- The agent names the Sequential tool that the feedback is about. From 2 November 2026, it can name `app` for feedback about the Sequential app in the browser, with the page as a route, such as `/heatmaps` or `/sessions/[id]`. Sequential stores the page with each part that looks like an id as `:id`. A route with other characters, or longer than 100 characters, is refused.
- Only your own connection can send. A project access token (`sq_pat_…`) cannot. If you leave the organisation, the tool refuses. Every role can make a connection by sign-in. A later role change does not end a connection because of `feedback:write`: every role can keep it, a viewer too.
- The tool tells MCP clients that it changes data and that it reaches outside Sequential: its `readOnlyHint` is false and its `openWorldHint` is true, because Sequential sends an email. Every other Sequential tool has `openWorldHint` false.

## FAQ

### Where else can I open the panel?

All of these places open the same Send feedback to Sequential panel. Every role has the feedback button in the rail.

- Help: press Shift H, or click Help in the rail, to open Help. At the bottom, under "Not in the docs, or the docs are wrong?", click Send feedback to Sequential.
- Ask or jump: press ⌘K on a Mac or Ctrl K on other computers to open Ask or jump. Under Commands, choose Send feedback to Sequential.
- Settings › Your profile: under Feedback to Sequential, click Write.
- Your name: click your name at the bottom of the left rail, then Your feedback. The panel opens at Your threads.

### What does each status mean?

| Status | What it means |
|---|---|
| Received | The Sequential team has your feedback. |
| Planned | The team plans to do it. |
| In progress | The team works on it now. |
| Fixed | The team fixed the bug. |
| Shipped | The feature or idea is available. |
| Not planned | The team does not plan to do it. |
| Merged with a similar request | The team joined your item to a similar request. That request's status follows, for example "Merged with a similar request · Planned". Sequential does not show the other request. |

Fixed, Shipped, Not planned and Merged with a similar request close the item.

## Limits

These are the default limits of the hosted service.

| What | Default limit |
|---|---|
| New feedback from one sender | 10 in each clock hour |
| Replies from one sender | 30 in each clock hour, counted apart |
| New feedback from one organisation | 100 in each day (UTC) |
| New feedback from one agent connection | 5 in each day (UTC) |

### How the limits work in detail

- The count starts again at the start of each hour or day.
- The limit of 100 a day counts the organisation of the attached project. If no project is attached, it counts your current organisation. Without an organisation, only your own limit applies.
- Your own limit of 10 new items an hour counts the items from your agent too. The organisation limit also applies to them.
- For a reply over the limit, the thread says "You have sent a lot in the last hour. Try again in N minutes."

## How long Sequential keeps it

- Sequential deletes an item 2 years after it closes. A daily job does this. For a merged item, the 2 years start when the similar request closes. Sequential does not delete an open item because of its age.
- If you delete your account, Sequential deletes the title, the text and your replies. The team keeps the item and its own replies.
- If an owner deletes the organisation, Sequential deletes the organisation's feedback.

## Next steps

- [Connect claude.ai to Sequential (MCP)](/docs/connect-claude-ai): connect an agent by sign-in.
- [Connect Claude Code to Sequential (MCP)](/docs/connect-claude-code): connect an agent by sign-in.
- [Privacy at a glance](/docs/privacy-overview): what Sequential collects, where it sends it and who can see it.
