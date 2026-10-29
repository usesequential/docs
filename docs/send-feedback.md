# Send feedback to the Sequential team

> Send a bug, a wish or an idea to the Sequential team from the app. See what it attaches, and follow its status and the replies.

> **In short**
>
> - Send feedback from the feedback button next to your name in the left rail, from **Help**, or from **Ask or jump**. Your feedback is also in Settings › Your profile, under **Feedback to Sequential**.
> - Under **Sent with it**, the form shows what goes with your text. You can remove each line before you send.
> - Every role can send feedback. You do not need an organisation or a project.
> - Your feedback goes to the Sequential team. In the app, only you see it. Other people in your organisation do not see it.

## What it is for

Use **Send feedback to Sequential** to tell the Sequential team that something is broken, that you need a feature, or that you have an idea. The team replies in the app and by email. You can follow the status of each item.

## Send feedback

1. Open the **Send feedback to Sequential** panel. All of these places open the same panel:
   - At the bottom of the left rail, click the feedback button next to your name. Its label is "Send feedback to Sequential". Every role has it.
   - Press Shift H, or click **Help** in the rail, to open **Help**. At the bottom, under "Not in the docs, or the docs are wrong?", click **Send feedback to Sequential**.
   - Press ⌘K on a Mac or Ctrl K on other computers to open **Ask or jump**. Under **Commands**, choose **Send feedback to Sequential**.
   - Open Settings › Your profile. Under **Feedback to Sequential**, click **Write**.
   - Click your name at the bottom of the left rail, then **Your feedback**. The panel opens at **Your threads**.
2. Under **What is it?**, select **Something is broken**, **Something is missing** or **An idea**.
3. If something is broken, you can also select, under "How much does it get in your way?", **It stops my work**, **It slows me down** or **Minor**. This is optional. **Not sure** clears it.
4. To add a title, type it in **Title**. This is optional. The **Title** can have 120 characters.
5. Write your text. If something is broken, the field is "What happened, and what did you expect?". Otherwise, it is "Tell us about it". You must write a text. The limit is 5,000 characters. From 4,500 characters, a line says how many characters are left.
6. Check **Sent with it**. See [What Sequential attaches](#what-sequential-attaches).
7. Click **Send to Sequential**, or press ⌘ Enter on a Mac or Ctrl Enter on other computers.

A message then says "Sent as #42. Sequential answers in its thread." The panel shows the new thread.

If you close the panel or open another page, your text stays in the form. A reload or a closed tab loses it. Sequential clears the text after an accepted send.

### If the send fails

| You see | What to do |
|---|---|
| "Write a few words first." | Write a text. |
| A line such as "12 characters too long: at most 5000." | Make the text or the title shorter. |
| "The text is too long: at most 5000 characters." or "The title is too long: at most 120 characters." | Make the text or the title shorter. |
| "Sequential could not read that. Remove unusual characters and try again." | Change the text, then send it again. |
| "You have sent a lot in the last hour. Try again in N minutes." | Wait. See [Limits](#limits). |
| "Feedback cannot be sent right now. Try again in a few minutes, or write to support@usesequential.com." | Wait, or send an email to support@usesequential.com. |
| "Sequential could not be reached. Your text is still here: try again." | Click **Send to Sequential** again. |

Your text stays in the form.

## What Sequential attaches

Under **Sent with it**, the form lists what goes with your text. Sequential reads it once, when the form opens. To remove a line, click **Remove**. To put it back, click **Add back**. Sequential does not send a line that you removed. Under the list, the form says "Your name and email go with it, so the team can answer. Never the page address or anything typed on it."

| Line | What it holds |
|---|---|
| **Project** | The open project. Sequential keeps it only if you can open the project |
| **Screen** | The name of the screen that you are on, for example "Evidence" or "Workbench › Funnels". It also sends the page pattern, such as `/cases/[n]`. Not the real address |
| **Case**, **Session**, **Person** or **Account** | On the page of one case, session, person or account: its number or id |
| **Browser** | The browser name and main version, and the system name only, for example "Safari 18 on macOS" |
| **Window size** | The window size, for example "1440 × 900" |
| **Theme** | **Light** or **Dark** |
| **Language** | Your browser's language, such as "en-GB" |

Each value has a limit of 200 characters. The server keeps only these items. It keeps an item id only with a known kind of item. It cuts an id at the first `?` or `#`. It does not keep an id that holds `://`.

Sequential never attaches the real page address, its query string or its `#` part. It never attaches what you typed in forms or the text on the page.

## After you send

| Status | What it means |
|---|---|
| **Received** | The Sequential team has your feedback. |
| **Planned** | The team plans to do it. |
| **In progress** | The team works on it now. |
| **Fixed** | The team fixed the bug. |
| **Shipped** | The feature or idea is available. |
| **Not planned** | The team does not plan to do it. |
| **Merged with a similar request** | The team joined your item to a similar request. That request's status follows, for example "Merged with a similar request · Planned". Sequential does not show the other request. |

**Fixed**, **Shipped**, **Not planned** and **Merged with a similar request** close the item.

### Where you see them

- In the panel, open **Your threads**. The same list is in Settings › Your profile, under **Feedback to Sequential**. An old link to `/settings/feedback` opens it there.
- The thread with the newest change is first. Each row shows the title or the start of the text, the number, the kind, the status and when it last changed. Click **Show older threads** for older ones.
- A dot shows on a thread with an answer that you did not read. Open the thread to remove the dot. Above the list, a line says how many threads have an answer that you have not read.
- The **Your threads** tab shows how many threads have such an answer, and the feedback button in the rail shows a dot. Sequential reads the number every five minutes while the tab is visible.

A thread shows your text and **Sent with it**, closed at first: the lines that Sequential got, for example "Screen", "Browser", "System" and "Window size", with their values. Then it shows each answer and each status change, oldest first. Each entry shows **You** or **Sequential**, the time, and a status sentence or a message, for example "Sequential plans to do it."

### Replies

- The team replies in the app, in the thread.
- Sequential also sends an email for each reply and each status change, but not for **Received**. The email goes only to a verified address. If the item has an organisation, you must still be a member of it.
- The email asks you to reply in Sequential, so that your answer stays with your feedback.

To reply, open the thread, write in **Reply to Sequential** (up to 5,000 characters) and click **Send reply**. You can reply while the item is open, and for 30 days after it closes. For a merged item, the 30 days start when the similar request closes. After that, the thread says "This thread closed more than 30 days ago, so it takes no more replies. Something new? Write a new one."

## Who can see it

Your feedback goes to the Sequential team. In the app, only you see it. Other people in your organisation do not see it. Sequential records sessions of its own app, but it does not record what you write or what Sequential answers. The feedback panel and **Feedback to Sequential** in Settings › Your profile are marked `data-sq-private`, which every masking preset masks.

Every signed-in person can send feedback and read their own: Owner, Admin, Member and Viewer. You do not need an organisation or a project. An access token cannot send or read feedback.

## Feedback from your agent

From 16 October 2026, an agent can send feedback for you with the tool `send_feedback`. It needs a connection made by sign-in, from claude.ai or, from 19 October 2026, from Claude Code, with the scope `feedback:write`. To give it, tick "Also: it sends feedback to Sequential" on the consent page. Its help line says "It sends a bug report or an idea to the Sequential team as you, after it shows you the text. This is a write." The box is off at first. When you tick it, a second box shows under it: "Let it send feedback without asking". It is also off at first. Its help line says "It then sends without showing you the text first. You get a mail for each one." The tool sends a bug, a feature request or an idea about Sequential, not about your own site.

- The agent must show you the exact kind and text, and send only after you say yes, unless you ticked "Let it send feedback without asking". Each call sends one item.
- The text has at most 1,000 characters and no title. Before Sequential stores it, it removes names, emails and secrets. If no words are left, Sequential refuses it.
- The item is yours: it shows in **Your threads**, with the project of the connection. The team replies to it as to any other item.
- In the list and in the thread, an item from an agent shows "sent by" and a name, for example "sent by Claude". The name is Sequential's name for a known app, else the name that the agent's app gives itself, else "Unknown agent". Sequential does not check a name that the app gives itself. An item that you sent from the app shows no "sent by".
- After each send, Sequential emails you: "Your agent sent feedback #N". The email names the agent and the kind, and links to the item. It never holds the text. It goes only to a verified address, while you are a member of the organisation.
- Only a person's own connection can send. An access token cannot. If you leave the organisation, the tool refuses. Every role can make a connection by sign-in. A later role change does not end a connection because of `feedback:write`: every role can keep it, a viewer too.
- The tool tells MCP clients that it changes data and that it reaches outside Sequential: its `readOnlyHint` is false and its `openWorldHint` is true, because Sequential sends an email. Every other Sequential tool has `openWorldHint` false.
- Limits: your own limit of 10 new items an hour counts these items too. Each connection can send 5 a day (UTC). The organisation limit also applies.

## Limits

These are the default limits of the hosted service.

| What | Default limit |
|---|---|
| New feedback from one person | 10 in each clock hour |
| Replies from one person | 30 in each clock hour, counted apart |
| New feedback from one organisation | 100 in each day (UTC) |

- The count starts again at the start of each hour or day.
- The organisation is the one of the attached project, else your current organisation. Without an organisation, only your own limit applies.
- For a reply over the limit, the thread says "You have sent a lot in the last hour. Try again in N minutes."

## How long Sequential keeps it

- Sequential deletes an item 2 years after it closes. A daily job does this. For a merged item, the 2 years start when the similar request closes. Sequential does not delete an open item because of its age.
- If you delete your account, Sequential deletes the title, the text and your replies. The team keeps the item and its own replies.
- If an owner deletes the organisation, Sequential deletes the organisation's feedback.
