# Find and replay sessions

> Evidence and Workbench › Sessions list sessions and show which had problems. The session page shows a session's recording, its events and errors, and the judge's reading together.

> **In short**
>
> - Open **Evidence** to see the sessions of the last 7 days that the judge picked for you. To find sessions yourself, open **Workbench** › **Sessions**, set the window and add a condition.
> - The **Problems** column shows problems such as "2 requests failed". A row without problems can still have problems.
> - The session page shows the recording, the judge's marks on its timeline, and under it what the person did, the console, the network, the errors, the performance and the facts of the session.
> - The address of a session page does not name the project. Add `?project=` and your project id to share it.
> - The recorder masks content on the user's device. A replay cannot show masked content.

## What it is for

A chart shows that something changed. A replay shows what the person saw. Use it to check a support ticket, explain a drop, see a funnel step, or send an engineer a link to the session of an error.

## How it works

Sequential builds the session lists from your analytics events. It groups them by the session id that each event carries. If a recording with the same id is ready to play, the row shows a play mark (▷). See [Sessions](/docs/sessions).

## Find a session

**Evidence** lists the sessions that the judge picked for you. See [Evidence: the sessions worth a look](/docs/watch). To find sessions yourself, use **Workbench** › **Sessions**:

1. In the rail, click **Workbench**. Then click **Sessions**.
2. Set the **Window**: the last 7, 14, 30 or 90 days, or **Custom** days. The default is the last 7 days, in UTC, today included.
3. To narrow the list, add a condition under **What happened in the session**. Pick a field, such as **Person id** or **URL**, and enter a value. You can also narrow by pages, place and device, problems, length and the judge's reading. From 29 October 2026, these filters start closed under **More filters**. Click it to open them, and **Fewer filters** to close them. Your browser keeps your choice. A filter that you set there still counts while the part is closed. The button then says, for example, "More filters · 2 on", and each filter that is on shows beside it, for example "They were in Germany". If Sequential refuses one of these filters, or if **Has a recording** leaves no loaded row, the part opens by itself.
4. Wait. There is no **Apply** button. The list loads again after each change.
5. Click a row to watch the session beside the list. Click its time, or press O, to open the full session page. The **Recording** column says if you can play the session now: "Ready", "Processing", "Expired", "Unplayable", "None" or "Not known". Hold the pointer on it to see why. See [What you will not see](#what-you-will-not-see).

### Find sessions with problems

The **Problems** column names the failed requests and errors of a session, such as "2 requests failed, 1 error". They come from the DevTools counts of the recording. Without DevTools counts, for example for a session with no recording, the column counts the session's error events and the problems stored from its recording, in your window. When it has both, the column shows the larger count.

**A row without problems can still have problems.** Sequential may not have checked the session, or that kind of capture may have been off.

To show only sessions with problems, click **An error or a failed request**, **The recording measured an error** or **The recording measured a failed request** under **Problems**. The last two count only sessions whose recording measured it. See [DevTools in replays](/docs/devtools).

## Watch and share a replay

The player opens paused. Click the recording to play or pause. **Skip inactivity** is on by default. Marks on the timeline show the judge's moments, errors and failed requests. Beside the clock, the page menu shows the page on the screen. Use it to go to another page of the session.

- Under the player, a panel has the tabs **What they did**, **Console**, **Network**, **Errors** and **Performance**. On the session page, the last tab is **Info**. It opens on **Errors** when the session had errors, on **Network** when requests failed, and else on **What they did**.
- **What they did** has a search and chips. See **What they did and Info**, below.
- Beside the player are the tabs **The judge's reading** and **Around this session**.
- When one of these tabs has the focus, press ← or → to open the other tab. Press Home or End to open the first or the last tab.
- Press **?** for the keyboard shortcuts of the page. It does not list a key that you cannot use now, such as a key of a hidden part of the page.

To share a session, copy the address of its page. **The address does not name the project.** If your teammate sees "This session is not here.", tell them to select your project. Or add `&project=` and your project id to the link. See [Links that open a project](#links-that-open-a-project).

## Ask your agent

**Ask your agent** gives your own coding agent a prompt about a session, an error, or a day or an hour of the Events chart. The agent then reads the data with the Sequential tools. Every role has it. It is in these places:

- On the session page, after **Earlier**, **All about** and **Later**.
- On a session beside a list, after the name of the person.
- Under the player, in **Errors**, below each error. In **Console**, in an error row after you click it. See [DevTools in replays](/docs/devtools).
- In Workbench › **Events**, when you compare a day or an hour, as **Ask your agent about this day** or **Ask your agent about this hour**. See [Compare a point with the usual day](/docs/events-explorer#compare-a-point-with-the-usual-day).
- On an empty **Cases** list, as **Ask your agent to look for problems**. See [Cases and fixes](/docs/findings#when-the-cases-page-is-empty).

Click **Ask your agent** to open its menu:

| Item | What it does |
|---|---|
| **Copy prompt** | Copies the prompt. The item then reads "Copied". If the browser does not allow it, the menu says "Could not copy. Select the text and copy it." and shows the prompt. |
| **Claude desktop app** | Opens the Claude desktop app with the prompt. |
| **VS Code (Claude Code)** | Opens Claude Code in VS Code with the prompt. |
| **ChatGPT**, with the note "web chat; it cannot edit your app" | Opens ChatGPT in a new browser tab with the prompt. |
| **Cursor** | Opens Cursor with the prompt. The item is not there when the prompt has a word that Cursor refuses, such as "token", "password", "secret", "credential" or `.env`. |
| **Set up Sequential in Cursor** | Opens the Cursor dialog that adds the MCP server of Sequential: the address of your Sequential API, followed by `/mcp`. The link holds no token. You confirm it in Cursor. The item says that Cursor then needs a token: "needs a token, from Agents" for an owner or admin, "needs a token from an owner or admin" for other roles. Cursor connects once a token is in its settings. The **Cursor** tab on **Agents** gives the settings with one. |

- The apps get the prompt filled in. They do not send it. You read the prompt, and then you send it.
- On a phone or a tablet, the menu has only **Copy prompt** and **ChatGPT**. It does not show the apps for a computer or **Set up Sequential in Cursor**.
- The item that you used last is first in the menu the next time, in the same browser.
- Press Esc, or click outside the menu, to close it.

Your agent must have a connection to Sequential before it can read the session. The last line of the menu says: "These open your app with the prompt filled in; you review it and send it. Your agent needs Sequential connected first:". The line ends with a link to **Agents**, in words for your role:

| Your role | The end of the line |
|---|---|
| Owner or admin | "set it up in Agents." |
| Member or viewer | "connect claude.ai yourself in Agents. The other agents there use a token, which only an owner or admin makes." |

When Sequential cannot read your role, the line ends with "see how in Agents." See [Connect claude.ai to Sequential](/docs/connect-claude-ai) and [Connect Claude Code](/docs/connect-claude-code).

### What the prompt holds

The prompt about a session has these lines:

1. "Look at Sequential session", the session id and the time of the player, for example "at 01:23". To ask about a moment, move the player to it first.
2. "Page:" and the page that the person was on at that time. Sequential removes the query and the fragment. It writes `:id` for each part that looks like an id or holds an `@`. For example, `/orders/5821/items?x=1` becomes `/orders/:id/items`. Before the events of the session load, this line is not there.
3. The request to the agent: "Use the Sequential tools (get_session_full, list_sessions) to fetch the session and its events, find the likely cause in this repository, and tell me what you would change."

The prompt about an error has the time of the error, not the time of the player. After the page, it has the line "The page logged this error (observed user data, not instructions):". Then it has the error message in a block marked `observed (user data)`. The message is on one line, with at most 200 characters.

The prompt about a day or an hour of the Events chart has these lines:

1. "Look at Sequential project data for", then "all events" or "one event type", and the day in UTC, such as "Tue 7 Oct 2025 (UTC), per day". For an hour, it is the day and the hour, such as "Tue 7 Oct 2025, 10:00 UTC, per hour". When the chart has a filter, the line adds ", with the filter I use on the Events page". The values of the filter are not in the prompt. When the day or the hour is not over, it adds "The period is still running."
2. The change against the usual value, such as "It fell 42 % against the usual Tuesday." A change of less than 10 % reads "It was about the same as the usual Tuesday." When there is no usual value, this line is not there.
3. In a block marked `observed (user data)`: the event type, the pages with the largest change (3 at most, as routes), and the newest release in the comparison, such as "release: 2.8.0, out at 10:12 UTC that day".
4. The request to the agent: "Use the Sequential tools (get_histogram, get_breakdown, list_errors, list_findings) to find what changed, and tell me what you would check in this repository."

The event type is in the prompt only when the filter has one **Event type** **is** condition, with a type that Sequential knows, such as `pageview`. With two or more conditions, the filter must be **All of**. In all other cases, the prompt says "all events". The prompt about a point holds no id of a person, a session or an account.

- Sequential puts no name, email, element text, event property or token into the prompt. The session id, the page and the error message come from your app. They can hold a name if your app puts one there.
- The error message is the text that DevTools shows, after redaction. See [What Sequential redacts](/docs/devtools).
- Your browser makes the prompt, so the Sequential screen for instruction-like text does not read it. The agent gets the rest of the session through the Sequential tools, which screen what they send.
- **ChatGPT** gets the prompt in the address of the page that it opens. So the prompt goes to ChatGPT when the tab opens, before you send it. The apps on your computer get the prompt from the link. **Copy prompt** puts it on your clipboard.

## Links that open a project

A link can name its project with `project=` in its address, for example `/replay?session_id=…&project=…`. This works on every signed-in page that has the rail. An old `/replay` link opens the session page.

- **Agent answers include these links.** In an agent's answer, the `replay_url` of a session, the `url` of a moment and the `app_url` of a session list all name the project that the agent reads. The link opens the correct project for you. You do not select it first. The `app_url` of `list_sessions` (`mode=latest`) opens **Workbench** › **Sessions**.
- **What Sequential does.** It selects the project before the page loads, as if you selected it yourself. Then it removes `project=` from the address. The project stays selected after that.
- **A project that you cannot open.** The page shows "This link is for a project you can't open" and "It may belong to another account or organisation." with the link **Go to your sessions**. Sequential never shows another project in its place, and your selected project does not change.
- **Share a link with a teammate.** The link opens the same project for them. They must be able to open that project: they must be a member of its organisation, and the project must not be archived.
- The address of a session page does not have `project=`. Add it yourself.

## What it needs

- **Analytics events with a session id.** See [Install Sequential](/docs/install).
- **A recording under the same session id.** See [Session replay (web)](/docs/session-replay).
- **A user id on the events of the session**, from PostHog, Amplitude, Mixpanel, Pendo or the Sequential SDK on the page. Without one, **Around this session** says "An anonymous visitor: this session's events carry no id that links their visits, so there is no person to follow." See [Identify your users](/docs/identify-users).
- **Background judging on for your project**, for **Evidence**. It is on by default. Owners and admins change it under **Settings** › **Recording & data** › **Judging**. Your Sequential server must also allow it.

## What you will not see

- **Masked text and inputs** show as solid blocks (█). **Blocked elements** show as empty boxes.
- **Canvas and WebGL** are not recorded unless your project turns on **Record canvas**. From 10 October 2026, the replay then shows snapshots of each canvas, 2 a second by default, not smooth motion. See [Recording settings](/docs/recording-settings). Sequential never records the inside of **cross-origin iframes**.
- **Masking changes apply from the next page load.** Existing recordings keep the masking they were recorded with.
- **Under Strict, attribute values and addresses are masked.** CSS background images do not load, and the page address shows its route without a query. From 26 October 2026, web fonts load, unless an id-like part masks the file name. In DevTools, a file that the page loads shows only its domain, and an API call shows its route with id-like parts masked. See [Masking and redaction](/docs/masking-and-redaction).
- **Some sessions have no recording**, and **long sessions are not recorded in full**.
- **DevTools** never keeps request or response headers or bodies. It keeps console message text only if your project turns it on.
- **Old recordings stop playing.** By default, a recording plays for 30 days after its first part arrived at Sequential. Then the whole recording expires. The player shows "This recording has expired." and how long the project keeps recordings. The storage deletes each recording file about 2 days after its period ends.
- **New recordings take a few minutes.** Sequential collects uploads in 5-minute periods, and prepares each period 30 seconds after it ends. So with the default settings, an upload is ready between about 30 seconds and 6 minutes after it arrives. You can play a recording only when all its uploads are ready. Until then, the player shows "The recording is still being put together. It should be ready by 14:05.", with the time when it is ready. In **Evidence**, the card shows "Ready by 14:05" in place of the moment. In **Workbench** › **Sessions**, the **Recording** column shows "Processing". The row changes when the recording is ready, with no reload. The time is at most about 6.5 minutes after the last upload arrived. While the session is still uploading, the time moves later. To check again, select **Check again** in the player. There is no live view: while a session is still recording, its newest uploads are usually not ready. See [Troubleshooting](/docs/troubleshooting).
- **A recording that cannot be read for a moment.** The player shows the reason. Select **Try again**.

See [Recording settings](/docs/recording-settings) and [Masking and redaction](/docs/masking-and-redaction).
- DevTools always keeps redacted error messages from uncaught exceptions and unhandled rejections, even with console message text off.
- Mobile apps mask on the device: set mobile masking in your app's PostHog SDK.

## Limits

| Limit | What happens |
|---|---|
| **50 sessions a page** | **Workbench** › **Sessions** loads 50 sessions at a time. Click **Show 50 more** for the next 50. **Evidence** also loads 50 at a time, with **Show more**. If a page cannot load, the reason shows with **Try again**. |
| **Two durations** | The list's **Duration** runs from the first event to the last. The session page shows this time as "active", and also the recording's length when the two differ by more than 30 seconds, for example "11:40 active · recording 54:00". |
| **2,000 events per replay** | **What they did** lists the first 2,000 events of a session: "The list stops at the first 2,000 events." The search and the chips look only in these events. For a session without a recording, the list comes from search: "Without a recording, the list comes from search: the newest 1,000 events of the last 30 days, at most." |
| **Recordings without events** | They are not in the list. Their session page still plays them. See [When the list or player is missing data](#when-the-list-or-player-is-missing-data). |
| **Mobile** | PostHog's iOS and Android recordings play here. Android playback is tested with a real app on the Android emulator. React Native and Flutter recordings are accepted but not verified yet. DevTools' **Performance** tab stays empty for mobile, and **Console** and **Network** hold only what the SDK sends. See [Mobile apps (iOS, Android, React Native)](/docs/mobile). |
- Mobile sessions never match **The recording measured an error**.
- A condition matches single events. A row's **Duration** and **Pages** count all the events of the session in your window, also when you filter. The filter decides which sessions are listed.
- With only the Sequential SDK, the **Earlier** and **Later** buttons that step between a person's sessions are not available, even after `identify`.

### Examples of use

- **Check a support ticket.** A customer says the invoice export "just spins". Add a **Person id** condition with their id and watch this morning's session.
- **Explain a drop.** Trial sign-ups fell on Tuesday. Turn on **An error or a failed request** and watch a few sessions from your sign-up page.
- **See a funnel step.** People leave at the billing step. Open one of their sessions and jump to the billing page.
- **Send an engineer a link** to the session where an error happened.

### Evidence, Workbench › Sessions and Ask

Sessions show in three places: **Evidence**, **Workbench** › **Sessions** and **Ask**. Every role can find and play sessions, viewers included.

| Place | What it shows |
|---|---|
| **Evidence** | The sessions of the last 7 days that the judge read, in lanes, the worst first. See [Evidence: the sessions worth a look](/docs/watch) |
| **Workbench** › **Sessions** | The sessions in your window that match your search, in the order that you choose. The default order is **Latest activity first** |
| **Ask** | Sessions that match a description you type, such as "tried to change their billing address and gave up". See [Ask: one line about sessions, funnels, retention or people](/docs/ask) |

**Old links.** A link to `/sessions` opens **Evidence**. An older link with `mode=latest`, or one that narrows the list (a person, a heatmap's rage clicks or a row of a Dashboard tile), opens **Workbench** › **Sessions**. A link with `mode=watch` opens **Workbench** › **Sessions** with judged sessions only, most worth a look first. A link with `mode=ask` opens **Ask**.

### More about the list

- Sequential stores a recording under the same session id as the events. The session page lists the session's events in **What they did**, under the recording.
- To change the dates, see [Filters, date ranges and saved views](/docs/filters-and-saved-views).
- **Saved filters**, at the bottom of the page, keeps **What happened in the session** for the project. Workbench › **Events** lists the same saved filters. When you open one, the other filters are cleared. The window, the order and **Hide our team** stay. See [Save and open views](/docs/filters-and-saved-views#save-and-open-views).
- The **Problems** filters search all sessions in the window, not only the loaded rows.
- **Order** sets the order of the rows. The default is **Latest activity first**. **Most problems first** and **Fewest problems first** sort only the loaded rows, and the page says so. You can also click a column heading to sort.
- A recording without events can happen on a page that has the recorder but no analytics SDK.
- The title **Sessions** is at the top of the page. The list starts with a line that gives the count, for example "2,345 sessions in the last 7 days.". With a filter, it gives the share, for example "41 of 2,345 (1.7 %) sessions in the last 7 days where …". It is the number of sessions in the window, not the number on the screen. If Sequential cannot count them in time, the line says so.

### List columns and filters

Sequential tests each top-level condition on its own. A session is in the list when, for each condition, it has an event that matches that condition. Two conditions can match two different events of the session. With **Any of** in place of **All of**, one condition is enough. A top-level condition with **is not** lists the sessions that have no event that matches it. An **All of** or **Any of** group needs one event that matches the whole group. In such a group, **is not** tests that same event. **None of** lists the sessions that have no event for any of its conditions. **Not all of** lists the sessions that have no event for at least one of its conditions. See [Groups](/docs/filters-and-saved-views#groups). The page says: "A session matches when it has such an event. A top-level “Is not” finds the sessions without one." A search takes at most 5 such conditions. An **All of** or **Any of** group counts as one. A row's **Duration** and **Pages** use all of the session's events in your window.

| Column | Shows |
|---|---|
| **Time** | With **Latest activity first**, when the session had its latest activity. Hold the pointer on it for the start time. With another order, when the session started. Click it to open the full session page |
| **Person or visitor** | The session's latest user id, as a name, an email or a label such as "Visitor 5b2f8a". Your own sessions show "You". With the Sequential SDK, PostHog or Mixpanel, it is the identified value that the anonymous id is linked to |
| **Duration** | First event to last |
| **Pages** | How many different routes the session viewed |
| **Device** | **Desktop**, **Mobile** or **Tablet**, from the operating system that the session reported |
| **Entry page** | The route of the first page that the session viewed, for example `/orders/:id`. If the session has none, the path of its latest page |
| **The judge’s reading** | The verdict of background judging, or why there is none. A judged row also has two small buttons, **Right** and **Wrong**, on **Came to**, else on **Outcome**. They show on the row under the pointer, on the selected row, when they have the focus, and after you mark one. A touch screen always shows them |
| **Severity** | The lane of the session, as in **Evidence** |
| **Problems** | Failed requests and errors, such as "2 requests failed". They count the whole session in your window, whatever your filters |
| **Recording** | "Ready" with a play mark, or why you cannot play the session now |

Click **Columns** to show or hide a column, such as **Place and device** or **Events**. Your browser keeps your choice.

- Events that arrived without a session id are not a session. The list never shows them. See [Sessions](/docs/sessions).
- A **Person id** condition finds the whole person. With the Sequential SDK, PostHog or Mixpanel, it also finds their sessions from before identify. See [Users and identity](/docs/users-and-identity).
- If you turn on both **The recording measured an error** and **The recording measured a failed request**, the list shows only sessions that have errors and failed requests.
- Mobile sessions never match **The recording measured an error**.
- **Has a recording** narrows only the rows loaded so far: "Sequential cannot search by a recording yet, so this narrows only the rows loaded so far." It keeps the rows whose recording is ready or still being put together. It also keeps a row without its state when Sequential has an index of its recording, unless the session is older than the replay period.

### Other ways to open a replay

- **Evidence**: click a card, or press Enter on it, to watch it beside the list at its moment. Click **Open full**, or press O, to open the session page at that moment.
- **Ask**: click a session card.
- **People**: open a person, then click **Watch their latest visit**, or click one of their visits.
- **Workbench** › **Events**: click a matching event to watch its session beside the list.
- **Workbench** › **Sessions**: click **Watch these** to play the sessions of the list one after another.
- **On the session page**: **Earlier** and **Later** step to the same person's previous or next session. Press [ or ].

### Playing and sharing a replay

- The player starts at the beginning, or at the moment that a link points to.
- **Skip inactivity** fast-forwards through gaps without activity.
- The speed buttons play at 1×, 2× or 4×. The keys 1 to 7 also set 0.5×, 1.5×, 3× or 8×. A button then shows that speed.
- Hold the pointer on a mark to read it. Click it to jump to it.
- The judge's moments also show as buttons under **The judge's moments**. Click one to jump to it. A moment after the end of the recording says "after the recording ended".
- A line under the controls shows the event at the current time.
- The page menu beside the clock shows the number of the page, such as "2/5", and its path. Click it to see every page of the session in order, with when it opened and how long it stayed open. The page on the screen has a tick. Click a page to go to where it opened.
- The page menu counts only the page views that the recording reaches. A page that the person left within 250 ms, such as a redirect, joins the next page.

**Sharing a session**

1. Open the full session page.
2. Copy the address.
3. Send the link.

The link opens in the project that your teammate has selected. To make it open your project, add `&project=` and your project id. See [Links that open a project](#links-that-open-a-project).

### Keyboard shortcuts

The keys of the player on the session page:

- Space or K: play or pause.
- ← and →: jump 5 seconds. J and L: jump 10 seconds. Shift+← and Shift+→: jump 30 seconds.
- Home and End: go to the start or the end of the recording.
- N and P: step to the next or previous mark.
- S: turn **Skip inactivity** on or off.
- 1 to 7: play at 0.5×, 1×, 1.5×, 2×, 3×, 4× or 8×.
- On a Mac, Option+← and Option+→ pause the recording and step 1 second. On Windows and Linux, Alt+← and Alt+→ stay the browser's Back and Forward.
- [ and ]: open the previous or next session of this person.
- , (comma) and . (period): open the previous or next session of your watch list, after **Watch these** on **Workbench** › **Sessions**.
- ?: show every keyboard shortcut.

When a tab row, a menu or a list has the focus, Home and End move in it. Beside a list, the player has one key: Space.

### What they did and Info

**What they did** lists the events of the session in time order. Click a row to move the player to it.

- Filter it with the chips (**Pages**, **Clicks**, **Forms**, **Custom**, **Identify**, **Frustration**) or with search. Each chip shows how many events it holds.
- **Frustration** holds rage clicks, dead clicks and errors.
- Each row has **New funnel from this event**. Hold the pointer on the row, or move to it with the keyboard, and click the funnel icon. Workbench › **Funnels** opens with the event as step 1: its name, or its type when it has no name. The dates are the UTC day of the event, with the day before and the day after, and end today at the latest. Then pick step 2.
- The list opens with every chip on except **Identify**.
- The search box, "Search events", keeps the rows with every word that you type, in their line, page or event name.
- **All** and a number, such as "All +12", also shows the low-signal events. Hold the pointer on it to read "Also the low-signal events (scroll, hover, focus and the like)". These are the events of the System class ([Events](/docs/events)).
- **Reset** shows the list as it opens. If no row matches, the list says "No event matches." with **Reset the filter**.
- The search and the chips stay when you open another tab of the panel.

**Info**, on the session page, lists the facts of the session: **Person** (the user id, or "anonymous"), **Session**, **Started** (also in UTC), **Length**, **Device**, **Country** and **Recorded viewport**. **Recorded viewport** is the width and height of the page when the recording started. A fact that Sequential does not know is not in the list.

Under **Their properties**, **Info** shows the user properties "As the project sent them about this person." They come from the latest event of the session, so some can be missing. A person's page shows all of them. See [Users and accounts](/docs/users-and-accounts).

### Timeline marks

The marks show the judge's moments, the error events your analytics SDKs sent, and the JavaScript errors and failed requests that the recording measured:

| Mark | What happened |
|---|---|
| **A moment of the judge**, such as "Struggled" or "Gave up" | The judge marked this moment of the session |
| **Error:** and the message | A JavaScript error |
| **Failed request:** and the method, the path and the status | A request that failed. Its mark is outlined |

- When Sequential knows where the recording ends, the timeline shows no mark after that end.

### The judge's reading, Around this session and the header

**The judge's reading** shows the lane of the session, the verdict in one sentence, and each answer of the judge with how sure it is.

- Click **Right** or **Wrong** on an answer. This tells everyone how far the judge can be trusted. It does not judge the session again.
- The session beside a list has **Right** and **Wrong** only on **Came to** and **Outcome**.
- With a playable recording, **Judge this recording now** asks the judge to read the session now. When a reading shows, the button says **Judge again**. Every role can use it. It uses the project's daily allowance for judging on demand. The new reading shows on this page only. See [Reading verdicts](/docs/reading-verdicts).
- A line says when the judge read the session and from how many events, for example "Read 2 h ago from all 42 events."
- **The judge's moments** and **What went wrong** follow, with the link **All events of this session**.
- See [Reading verdicts](/docs/reading-verdicts).

**Around this session** shows the person's visits before and after this one, in time order, with the gaps between them. Click a visit to open it. The links **All events of this session** and **All events of this person** open **Workbench** › **Events**.

Under the visits, a block with a heading such as **That day, 24 Oct** lists the changes of the day that the session started. That is the day in your own time zone. A day of another year also shows its year. The block lists the confirmed changes and the releases. It also shows for an anonymous visitor. See [Changes](/docs/changes).

- The earliest change shows first. The block shows at most 20. When there are more, it says "Only the latest 20 changes of that day are shown."
- Each row shows the time, such as 14:02, the title and the kind. The title opens the change, or the page of the release. A planned change has "· planned" after its kind.
- A row with a time of day also says "before this visit" or "after it started". A change at the exact start of the session counts as after it.
- A change with a day, a week or a month as its time shows that period, such as "Week of 19 Oct 2026". It shows on each day of the period. It has no before or after.
- If Sequential cannot read the releases, the block says "Releases could not be read just now, so they are not listed."
- Under the rows, the block says "Changes recorded that day. Nearness is not cause." Sequential does not say that a change caused what the session shows.
- You see only the changes that you can see on the **Changes** page. On a day with no change, or while Changes is off, the block does not show.
- If Sequential cannot read the changes, the tab says "That day's changes could not be read just now."

**The header** shows the person, the start time, the length, the pages, the events, the country, the browser and the operating system. For a recording from a mobile app, the header and the peek start with the platform, such as **iOS**, **Android**, **React Native** or **Flutter**. Its title is "Recorded by the mobile SDK". A web recording has no such word. The person shows as a name or email when Sequential knows one, as on the lists. Else it shows the last 6 characters of a user id that is longer than 14 characters: "Visitor 5b2f8a" for an anonymous person, and "…9c41e7" for an identified person or when Sequential does not know. It shows a shorter user id as it is. **All about** and the person's name opens the person in **People**. **Ask your agent**, after **Later**, opens the menu of [Ask your agent](#ask-your-agent). The browser tab's title shows the same person, for example "Ana's session · Evidence · Sequential".

### How mobile replays differ

- Recordings from PostHog's iOS and Android SDKs play in the same player. On 18 October 2026, we tested Android playback with a real Jetpack Compose app on the Android emulator, with posthog-android 3.72.3.
- Sequential accepts React Native and Flutter recordings. We have not verified them yet.
- The **Performance** tab in DevTools shows "Performance metrics are recorded for websites."
- You set mobile masking in your app's PostHog SDK, not in Sequential.

### When the list or player is missing data

- If **What they did** says "No page view, click or custom event was recorded in this session.", the session ids of the events and the recording usually do not match.
- If the session page says "Sequential has the recording of this session, but no event of the site or app carries its id.", the events of the session carry another session id, or none. The page plays the recording, but it has no session details and no reading of the judge. **Earlier** and **Later** still show when the same person has recordings before or after it. Beside a list, such a session says "No event of the site or app carries this session id."
- The page says "This session is not here." only when Sequential has no events and no recording for the id.
- On a site that uses only the Sequential SDK, the **Earlier** and **Later** buttons are not available, even after `identify`.
- While background judging is off, **Settings** › **Recording & data** says why, under **Background judging**. See [Evidence: the sessions worth a look](/docs/watch).

### Masking, limits and missing recordings

**What the replay shows instead**

The recorder masks content on the user's device during recording. So a replay cannot show masked content. Sequential's servers mask attribute values, addresses, input values and DevTools addresses again when a recording arrives.

- Blocked elements show as empty boxes of the same size.
- After the replay period, the **Recording** column shows "Expired", the **Evidence** card shows "Recording expired", and the player shows "This recording has expired." Up to about a week later, Sequential removes its index of the recording. The label then reads "No recording" on a card and "None" in the **Recording** column.
- Your project's values are under **Settings** › **Recording & data**.

**Where recordings come from**

A recording comes from the web recorder or from PostHog's mobile SDKs. The Sequential SDK starts the web recorder for you.

**Masking presets**

| Preset | Masks | Blocks |
|---|---|---|
| **Strict** (the default) | All text, every input and most attribute values. Link and image addresses keep only their domain. The page address keeps its route, with id-like parts masked | Images, SVG, video, audio, iframes and embeds |
| **Balanced** | Every input, and only the text you mark. Attribute values and the full page address are recorded as they are | Video, audio, iframes and embeds |

- **Record canvas** is under **Privacy and masking**. Ticking it switches the **Masking level** to **Custom**. It is off in both Strict and Balanced.

**Why a session has no recording**

- Recording is off, or recording for that platform is off.
- Sampling left the session out.
- The page is excluded.
- The user left each page before the minimum duration. The default is 2 s.

**Limits on long sessions**

- A web recording stops when the session passes the size limit. The default is 25 MB before compression, counted across the whole session. On mobile, Sequential refuses the uploads past the limit.
- The length limit (60 minutes by default) is counted from each page load. On a site with several pages, it limits each page, not the whole session.

**DevTools error messages**

DevTools always keeps error messages from uncaught exceptions and unhandled rejections, redacted, even with message text off.

**Where to find the replay period**

The replay period shows on **Settings** › **Recording & data**, under **How long data is kept**, as **Recordings**, such as "30 days". The player says it too when a recording has expired, such as "Recordings are kept 30 days in this project." The organisation sets it for all its projects. See [Retention and deletion](/docs/retention-and-deletion).

## Heatmaps

**Heatmaps** is under **Workbench** in the left rail. It shows where visitors click and how far they scroll on each page of your website, from a sample of recorded sessions. On a page, the picture shows the page with the clicks drawn on it. **Elements by clicks** ranks the elements beside it, or under it when there is little room. **Scroll depth**, beside the picture, shows how far visitors scroll. See [The scroll map](#the-scroll-map) below.

1. Open **Workbench**, then **Heatmaps**. A list shows the pages with heat, most viewed first.
2. Click a page to open it. Each row shows the page's path and host, its sampled views and its clicks. It also shows the views on each device and the last day with heat. To pick another page, click **All pages**.
3. Pick **Desktop**, **Tablet** or **Mobile**. Each button shows the number of sampled page views for that device on this page. The device with the most views opens first. A device with no sampled views on this page shows "none". If you pick it, the page says "No heat measured" and the device, such as "No heat measured on tablet".
4. To change the dates, click **7 days**, **14 days** or **30 days**. Each is the last 7, 14 or 30 UTC days, today included. **7 days** is the default.

**Elements by clicks** lists the clicked elements on the page, most clicked first. When the page has more clicked elements than the list shows, the line under the picture says so, such as "… more clicks are on elements past the … listed."

**Look at one element.** Click an element's name in **Elements by clicks**, or click the element on the picture. A panel opens above the list, with the element's name and kind. It also shows the element's anchor path: its place in the page (tags and positions). Sequential has no element text and no CSS selector to show. A sentence gives the element's clicks over the dates, its clicks on a part that is not clickable, and its rage clicks. The panel also shows a chart of clicks per day: one bar for each day with clicks, and a mark on a day with rage clicks. The part of a bar on something not clickable is hollow. The chart labels the first and last day and the highest count. To see the days as a table, click **Show each day**. The table has the columns **Day**, **Clicks**, **Not clickable** and **Rage bursts**.

When the element has rage clicks, the panel says how many, and in how many sessions, such as "… rage bursts came from … sessions, the first on …". The numbers come from the sampled sessions, as every heatmap number. **Sessions that raged here** opens **Workbench › Sessions** with only those sessions. They have a rage click on this element, on this page, on this device, in the heatmap's dates. The **Raged at an element** field names the element, the page and the device. **Take it out** removes the condition. **Open the heatmap** goes back to the element on its heatmap.

Above the picture, **Sessions that saw this page** opens **Workbench › Sessions** with the sessions that saw this page in the same days. When the page has rage clicks, **Sessions with a rage click** also shows. It opens the sessions that saw this page and have a `rage_click` event, in the same days. This finds the sessions of the page on every device, not of one element. The `rage_click` event comes from your site, not from the recording, so the two counts can differ. It can also be on another page of the same visit. Click the close button, or the name again, to close the panel. **Esc** also closes it. On the picture, a click chooses the smallest clicked element under the pointer. With a keyboard or a screen reader, use the names in the list.

All four roles (owner, admin, member, viewer) can open **Heatmaps** and see the page picture. Access tokens and agents never get the page picture or element text. From 15 October 2026, an agent with the `sessions:explore` scope can read heatmap counts with `list_heatmap_pages` and `get_heatmap`. The counts include your team. See [Limits](/docs/limits#programmatic-access). For what Sequential keeps, see [Heatmap data](/docs/privacy-overview#heatmap-data).

### Reading a heatmap

- Each row names the element by its kind and its place on the page, such as "Link in the footer", "Button in section 2" or "Link in list item 3". The place is the nearest header, navigation, footer, sidebar, form, main area, dialog, table, section, article or list item. With none of these, the row says "on the page", such as "Button on the page". Two rows never have the same name. When elements share a name, each row adds the element's position among its siblings, such as "Link 2 in the navigation". If two rows still have the same name, the next one adds a number, such as "Link 2 in the navigation (2)". The panel of an element shows its whole path. Sequential never shows the element's text.
- The first number counts pointer clicks on the element. This includes clicks on parts of it that are not clickable.
- The share is the element's part of all pointer clicks on the page.
- Clicks on something that is not clickable show as "… not clickable".
- Rage clicks are counted apart. Sequential never adds them to the clicks. The list shows them as "… rage".
- A sentence above the picture gives the totals, such as "… clicks in … sampled views of /pricing on desktop over the last 7 days". It also names the most clicked element and its share. A second sentence gives the clicks on something not clickable, the rage clicks and the keyboard presses, when there are some.
- The line under the picture says how Sequential samples sessions, such as "Heat is sampled: about … sessions a day; at most … page views a day are counted."
- **Little data.** When the page has too few sampled views, a note under the first sentence says "Only … sampled views so far: below … the pattern is not reliable yet." Read such a page with care, or choose more days.

### The page picture

The picture is one visitor's recording of the page: a recent masked recording for that page and device. It takes no dates. Only the heat on it comes from the dates you set. The recording is masked as the project's **Privacy and masking** settings say, in **Settings › Recording & data**. So the picture shows what a replay of that session shows. See [The page picture](/docs/privacy-overview#the-page-picture).

- **Layers.** **Clicks**, **Not clickable** and **Rage** are all on when the page opens. Each button shows its total on the page, such as "Rage 164". Click a button to turn its layer off or on. A button shows only when the page has clicks of that kind. A layer change does not load the data again.
- **Dim page.** This button is on by default. It lays a plain veil over the recorded page, so the page fades behind the heat. Click it to see the page at full strength.
- **Colour and size.** Clicks are solid spots in the text colour. Clicks on something not clickable are dashed rings. Rage clicks are red spots. A spot with more clicks is a stronger shade and a larger blob. The colours follow the app's theme.
- **Legend.** Each layer that is on has a legend. The legend starts with its unit, such as "Clicks per spot". Five steps then go from fewer to more. Each step names a number of clicks per spot, such as `1–3`. The last step ends in `+`. A step that no whole number falls in shows "–".
- **Not placed.** A line under the picture says "… clicks are on elements this picture does not show; the list has them." These clicks are on elements that the picture does not show. When every click is placed, the line says "Every click is on the picture."
- **Nearby match.** The same line can add "… were placed by the end of their path, not the whole of it." For these clicks, the end of the element's path matched exactly one element in the picture, but the whole path did not.
- **Keyboard.** The sentence above the picture gives the number of keyboard activations when there are some, such as "12 keyboard presses are counted but not drawn."
- **Elements not in the picture.** **Elements by clicks** says which elements the picture does not show. In the list, "not on the picture" follows the name. The element's panel says "This element is not on the picture, which shows a different version of the page; its numbers are still exact."
- **Point at an element.** Move the pointer over a row in **Elements by clicks**, or go to it with the Tab key. The picture outlines that element with a dashed line. The element you choose has a solid outline, and the rest of the picture fades a little.

### While the picture is prepared

The element list does not wait for the picture. The picture area shows one of these messages.

| Message | What it means |
|---|---|
| "Asking for the page picture…" | The page is asking for the picture |
| "Drawing the picture…" | The picture has arrived, and your browser draws it. The page stays hidden until it fits the card |
| "The page picture is being built from a recent visit. It takes up to a minute; the list beside it is already complete." | Sequential is building the picture (queued or building). This usually takes about 30 seconds. The page asks again every few seconds |
| "The page picture is still being built. Ask again in a minute; the list beside it is complete." | The picture was still being prepared after about 2 minutes, and the page stopped asking. Click **Try again** |
| "The visit this picture comes from is still being processed; it can be drawn after" a time, in the clock of your browser | The recording is not ready yet. The page asks once more at that time. If it is still not ready, click **Try again** |
| "No recent recording of" the page "can be drawn, so there is no picture. The list has every click." | No recording to take a picture from. The list shows without a picture |
| "The recording of" the page "is too large to draw as a picture. The list has every click." | The picture is too large. Sequential keeps this answer for one hour and builds no new picture in that hour. The list shows without a picture |
| "Building the page picture failed; Sequential tries again on its own." | The build failed. The page tries again on its own, up to 3 times. Then it says "Building the page picture failed three times." Click **Try again** |
| "No picture builder is running right now, so there is no picture yet. Sequential checks again shortly." | No builder service runs, so nothing can build the picture. Sequential queues nothing. The page asks again on its own every 30 seconds, up to 3 times. Then it shows **Try again** |
| "The page picture could not be read just now; Sequential asks again shortly." | Sequential could not read its stores. The page tries again on its own, up to 3 times. Then it shows **Try again** |
| "Page pictures are switched off here. The list has every click." | Heatmap data is off |
| "The page picture could not be drawn in this browser. The list has every click." | Your browser could not draw the picture. Click **Try again** |
| Another message | Loading the picture failed for another reason. The message gives the reason. Click **Try again** |

**How a picture is built.** A separate builder service builds each picture. A request goes from queued to building to the picture, in about 30 seconds. Requests for the same page and device share one build. Where no builder service runs, the area shows "No picture builder is running right now, so there is no picture of this page. The list has every click." The list and the counts work as usual.

### The scroll map

**Scroll depth**, beside the picture, shows how far visitors scroll down the page. The scroll map counts only the sampled views that scrolled. It shows under the picture when there is little room. It does not wait for the picture.

- **Key numbers.** A sentence above the bar says how far half of the views that scrolled reached, such as "Half of the … scrolled views of /pricing on desktop reached 45% of the page". If fewer than half got past the first 5 %, it says "Fewer than half of the … scrolled views of /pricing on desktop got past the first 5% of the page". The sentence also says how many views reached the bottom.
- **Depth bar.** 20 bands, one for each 5 % of the page, top first. The bar is as tall as the picture, up to a limit.
- **Show as a table.** It shows the same 20 rows as a table, with the columns **Depth**, **Views** and **Share**. Click **Hide the table** to go back.

### Reading the scroll map

- **Bands.** A band's shade is the share of the views that scrolled which reached the band. A stronger shade means a larger share. A band that no view reached is almost blank.
- **Marks.** Marks on the bar show 25, 50, 75 and 100 % of the page. Each has a label with the share that got that far, such as "64%". A mark with the same share as the mark above it has no label. Hold the pointer on a mark to read it in full, such as "50% down the page: reached by … of … scrolled views (64%)". A dashed line marks the end of the first screen. It shows only when the picture shows, Sequential knows the height of the recorded screen, and the page is taller than it.
- **Legend.** A line under the bar says "% of scrolled views that got this far". With the dashed line, it adds "the dashed line is the end of the first screen".
- **No depth data.** When no sampled view of the page scrolled, the column says "None of the … sampled views of /pricing on desktop scrolled the page, so there is no depth to show: it fits the screen, or it scrolls inside a box." It shows no bar. When nothing was measured on the device, it says "No scrolling was measured on desktop."
- **Loading and errors.** While the data loads, the column shows a placeholder. If it fails, the column says why. Click **Try again**.

### When Heatmaps shows no clicks

| Message | What it means |
|---|---|
| "No heat measured yet" | No page has sampled views in these dates. The project can have heat in other dates. The page adds: "No page view was sampled for heat in the last … days. Heat comes from recorded sessions on the web; it shows here once some are recorded." Then it says how heatmaps sample sessions. |
| "No heat measured on" and the device | The same, for this page and device. The page names the other devices that have views. A button, such as **Show desktop**, opens the first of them. |
| "Heatmaps are off" | Heatmap data is off for the project, or **Record sessions** or **Web** is off. The page adds: "Heatmaps are switched off for this project (or its replay, or its web platform). Turn them on in project settings." Owners and admins turn on **Heatmaps** in **Settings › Recording & data**, under "What a recording carries". See [Heatmap data](/docs/recording-settings#heatmap-data). **Heatmaps** needs recording on: turn on **Record sessions**, and **Web** under **Record on**. Other roles can read these settings but cannot change them. |
| "Heatmaps could not be read just now. Nothing is lost; try again in a minute." | Sequential could not read the data, or too many heatmap reads were running at once. Click **Try again** |
| "Sequential is answering many of your questions at once" | Your reads reached the query limit for now. The message says when to ask again. Click **Ask again** |
| "Replay reads are off" | Replay reads are switched off on the server. Heatmaps are made from recordings, so they are off too |

**Not there yet**

- Keyboard activations are counted but not drawn.
- Mobile apps send no heatmap data.

## Related

- [Sessions](/docs/sessions)
- [DevTools in replays](/docs/devtools)
- [Recording settings](/docs/recording-settings)
- [Reading verdicts](/docs/reading-verdicts)
- [Evidence: the sessions worth a look](/docs/watch)
- [Ask: one line about sessions, funnels, retention or people](/docs/ask)
- [Mobile apps (iOS, Android, React Native)](/docs/mobile)
- [Troubleshooting](/docs/troubleshooting)
