# Simple view

> Simple view shows a short rail and a 7-day page of three cards, for people who watch sessions but do not build analyses. It changes no permission.

> **At a glance**
>
> - **You get:** A rail of Brief, Evidence, Funnels and Heatmaps, in this order.
> - **Default:** A viewer starts in it. Other roles do not. The choice applies to this browser only.
> - **Who can:** [Every role](/docs/roles-and-permissions) can turn it on or off.
> - **Know this:** Every page still opens from a link and from [Ask or jump](/docs/search-or-jump-to) (⌘K).
> - **Know this:** The first card needs a [pinned saved funnel](#pin-a-saved-funnel).

## Turn it on or off

1. Click your name at the bottom of the rail.

   Result: The account menu opens.

2. Click **Simple view** (On or Off shows beside it).

   Result: The change applies at once, and the menu closes. There is no Save button.

To turn it off from Your last 7 days, click "Show everything" beside the title. The Brief comes back at once.

### Who starts in it?

Simple view is for people who watch sessions and read results, but do not build funnels or filters.

- If this browser has no choice yet, Sequential uses your role. A viewer starts in Simple view. An owner, an admin or a member starts with the full rail.
- Sequential then keeps that choice in the browser. A later change of your role does not change it.
- The choice belongs to the browser, not to the person. Another person who uses the same browser gets the same choice. Another browser or another computer has its own choice.
- If the browser blocks site storage, the switch still works on the page, but the browser does not keep the choice. After a reload, the default of your role applies again.
- When a viewer starts in Simple view, a note shows under the title of Your last 7 days: "You are in Simple view. Turn it off any time with Simple view in your account menu." Click "Got it" to close it. The note shows until you click "Got it", or until you turn Simple view off.
- The demo does not set this default.

Every role can turn Simple view on or off. See [Roles and permissions](/docs/roles-and-permissions).

## What the rail shows

In Simple view, the rail does not show Cases, Ask, People, Changes, Agents, Questions, Workbench, Board or Settings.

### The short rail in detail

In Simple view the rail shows, in this order:

1. Brief
2. Evidence
3. Funnels: Workbench › Funnels
4. Heatmaps: Workbench › Heatmaps

- The project switcher, Ask or jump, Invite people, Get more sessions, Help and the row with your name stay.
- [Ask or jump](/docs/search-or-jump-to) (⌘K) still lists every place of the full rail.
- Brief does not show the number of decisions that wait for you. Evidence can still show its number.
- Only Brief and Evidence show their G keys. The G keys of every page still work.
- On a phone, the menu shows the same places.
- A screen reader names the rail "Main, Simple view".
- Hold the pointer on Simple view in the account menu to read its hint: "Show only Brief, Evidence, Funnels and Heatmaps. Other pages still open from a link or from Ask or jump (⌘K)."

To see the full rail, turn off Simple view in the account menu, or click "Show everything" on Your last 7 days.

## Your last 7 days

In Simple view, Brief opens "Your last 7 days, at a glance".

| Card | What it shows | Click | It opens |
|---|---|---|---|
| Where people leave | Each step of the pinned saved funnel, and the biggest drop | See why people left | Workbench › Funnels |
| Sessions worth watching | The top 5 sessions from Evidence | All sessions | Evidence |
| Where people click | The page with the most views, with its views and clicks | Open heatmap | Workbench › Heatmaps |

### How the page loads

The three cards show in place of the Brief. They answer three questions: where people leave, which sessions to watch, and where people click. All three cards use the last 7 days: today and the 6 days before, in UTC.

Above the title "Your last 7 days, at a glance", the page says Last 7 days. The browser tab says "Your last 7 days · Sequential". The keys of the Brief do not work on this page. You cannot change the dates on this page.

Each card loads on its own. If one card fails, it shows an error and Try again. The other cards still show. When you change the project, the cards load again for the new project.

### Where people leave

This card runs the saved funnel that your team pinned to the Simple view.

- Under the title, the card shows the name of the funnel.
- It runs the steps, the conversion window and the team setting of the saved funnel on the last 7 days. It does not use the breakdown.
- It shows a sentence such as "292 of 800 people (36.5%) who reached “/pricing” went on to “signup” in the last 7 days."
- It shows the biggest drop, such as "The biggest drop: 63.5% left between “/pricing” and “signup”." If two drops are equal, it shows the earlier one.
- It shows one bar for each step, with the number of people and their share of step 1. Between two steps, a line shows the share of people that left.
- See why people left opens Workbench › Funnels with the saved funnel on the last 7 days. There, the breakdown of the saved funnel applies again. See [Funnels: where users drop off](/docs/funnels).

If nobody reached step 1, the card says, for example, "Nobody reached “/pricing” in the last 7 days."

A saved funnel can leave out your team. If Sequential cannot read who is on your team, the card counts with your team in. It then says "Who is on your team could not be read for this answer."

### Sessions worth watching

Beside the title, the card says "Top 5 from Evidence". It shows the first 5 sessions of the last 7 days, in the attention order that Evidence uses.

- Each row is a session card, as on Evidence: the person, when the session started and how long it was, the sentence of the judge, and the moment worth seeing.
- If the recording cannot play, the row says why, for example "No recording" or "Ready by" with a time.
- Click a row to open the session in the peek ([Find and replay sessions](/docs/sessions-and-replay)).
- All sessions opens Evidence. See [Evidence: the sessions worth a look](/docs/watch).

### Where people click

This card shows the page with the most views in the last 7 days. It shows the path and the host of the page, and then its views and clicks, for example "1,204 views, 312 clicks". If two pages have the same number of views, the card shows the page that Workbench › Heatmaps lists first.

Open heatmap opens Workbench › Heatmaps on that page, on the last 7 days. It opens the device that most of the views came from: desktop, tablet or mobile. See [Heatmaps](/docs/sessions-and-replay#heatmaps).

### Messages the cards can show

When no funnel is pinned, both a viewer and the other roles see Open Funnels on the card Where people leave. If the Workbench cannot read the pinned funnel, that card says why, and shows Open Funnels. The cards show these messages.

| Message | Where | What it means | What to do |
|---|---|---|---|
| "No funnel chosen yet. Ask a teammate to pin a saved funnel." | Where people leave, for a viewer | No funnel is pinned. | — |
| "Pin a saved funnel to show it here: Workbench › Funnels, then “Pin to the Simple view” on it." | Where people leave, for an owner, an admin or a member | No funnel is pinned. | See [Pin a saved funnel](#pin-a-saved-funnel). |
| "Couldn’t load the saved funnels. Try again." | Where people leave | The saved funnels do not load. | Click Try again. |
| "Couldn’t run the funnel. Try again." | Where people leave | The funnel does not run. | Click Try again. |
| "No sessions in these dates." | Sessions worth watching | The last 7 days have no session. | — |
| "Couldn’t load the sessions." | Sessions worth watching | The list does not load. The card shows Try again. | — |
| "Heatmaps are switched off for this project (or its replay, or its web platform). Turn them on in project settings." | Where people click | Heatmaps are off. | — |
| "Replay reads are switched off here, and heatmaps are made from recordings, so they are off too." | Where people click | Replay reads are off. | — |
| "No clicks in these dates." | Where people click | No page has heatmap data in these dates. | — |
| "Heatmaps could not be read just now. Nothing is lost; try again in a minute." | Where people click | Sequential cannot read the heatmaps. The card shows Try again. | — |

## Pin a saved funnel

A project has at most one pinned funnel, the same for everyone. Only owners, admins and members see the pin button.

1. Go to **Workbench › Funnels**.

2. In Saved funnels, find the funnel.

3. Click the pin button beside its name. Its tooltip says "Pin to the Simple view".

Result: The page says "Pinned: the Simple view shows this funnel."

If another funnel was pinned, Sequential unpins it. It does not ask first.

### How a pin works, and why it can fail

The first card, Where people leave, shows one saved funnel. After a pin, the list shows "On the Simple view" with that funnel.

- To unpin a funnel, click its pin button again. The tooltip then says "Unpin from the Simple view". The page says "Unpinned: the Simple view shows no funnel."
- Only owners, admins and members see the pin button. Everyone in the project sees "On the Simple view".
- A pin does not change the saved funnel. Its steps, its version and who saved it last stay the same.
- Each pin and each unpin makes one entry in the [audit log](/docs/audit-log).

If a pin fails, the page says why, and the list loads again. See also [Filters, date ranges and saved views](/docs/filters-and-saved-views#save-and-open-views).

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Another funnel was pinned at the same time. Try again." | Workbench › Funnels | The pin failed. The list loads again. | — |
| "This funnel no longer exists. The list is up to date again." | Workbench › Funnels | The pin failed. The list loads again. | — |
| "Your role cannot pin funnels here." | Workbench › Funnels | The pin failed. The list loads again. | — |
| "Couldn’t pin the funnel. Try again." | Workbench › Funnels | The pin failed. The list loads again. | — |

## It changes no permission

Simple view changes only the rail and the page that Brief opens. It hides no data and gives no more access. Your role, not Simple view, decides what you can see and change ([Roles and permissions](/docs/roles-and-permissions)).

## Next steps

- [Funnels: where users drop off](/docs/funnels): build a funnel to pin.
- [Evidence: the sessions worth a look](/docs/watch): read the full list.
- [Filters, date ranges and saved views](/docs/filters-and-saved-views): save and open views.
