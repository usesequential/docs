# Simple view

> A short rail and three cards in place of the Brief, for people who watch sessions but do not build analyses. Turn it on or off in the account menu. It changes no permission.

> **In short**
>
> - Simple view shows four places in the rail: **Brief**, **Evidence**, **Funnels** and **Heatmaps**.
> - In place of the Brief, it shows "Your last 7 days, at a glance" with three cards: **Where people leave**, **Sessions worth watching** and **Where people click**.
> - A viewer starts in Simple view. Owners, admins and members do not.
> - The choice applies to this browser only.
> - Simple view changes no permission. Every page still opens from a link and from **Ask or jump** (⌘K).

## What it is for

Simple view is for people who watch sessions and read results, but do not build funnels or filters. It makes the rail shorter. In place of the Brief, it shows three cards that answer three questions: where people leave, which sessions to watch, and where people click.

## Who starts in it

- If this browser has no choice yet, Sequential uses your role. A viewer starts in Simple view. An owner, an admin or a member starts with the full rail.
- Sequential then keeps that choice in the browser. A later change of your role does not change it.
- The choice belongs to the browser, not to the person. Another person who uses the same browser gets the same choice.
- When a viewer starts in Simple view, a note shows under the title of **Your last 7 days**: "You are in Simple view. Turn it off any time with Simple view in your account menu." Click **Got it** to close it. The note shows until you click **Got it**, or until you turn Simple view off.
- The demo does not set this default.

Every role can turn Simple view on or off. See [Roles and permissions](/docs/roles-and-permissions).

## Turn it on or off

1. Click your name at the bottom of the rail. The account menu opens.
2. Click **Simple view**. Beside it, the menu shows **On** or **Off**.

The change applies at once, and the menu closes. There is no **Save** button. Hold the pointer on **Simple view** to read its hint: "Show only Brief, Evidence, Funnels and Heatmaps. Other pages still open from a link or from Ask or jump (⌘K)."

To turn Simple view off from **Your last 7 days**, click **Show everything** beside the title. The Brief comes back at once.

Sequential keeps the choice in this browser. Another browser or another computer has its own choice. If the browser blocks site storage, the switch still works on the page, but the browser does not keep the choice. After a reload, the default of your role applies again.

## What the rail shows

In Simple view the rail shows, in this order:

1. **Brief**
2. **Evidence**
3. **Funnels**: Workbench › **Funnels**
4. **Heatmaps**: Workbench › **Heatmaps**

The rail does not show **Cases**, **Ask**, **People**, **Changes**, **Agents**, **Questions**, **Workbench**, **Board** or **Settings**. The project switcher, **Ask or jump**, **Invite people**, **Get more sessions**, **Help** and the row with your name stay.

- **Brief** does not show the number of decisions that wait for you. **Evidence** can still show its number.
- Only **Brief** and **Evidence** show their G keys. The G keys of every page still work.
- On a phone, the menu shows the same places.
- A screen reader names the rail "Main, Simple view".

To see the full rail, turn off **Simple view** in the account menu, or click **Show everything** on **Your last 7 days**.

## Your last 7 days

While Simple view is on, the **Brief** in the rail opens "Your last 7 days, at a glance" in place of the Brief. Above the title, it says **Last 7 days**. The browser tab says "Your last 7 days · Sequential". The keys of the Brief do not work on this page.

All three cards use the last 7 days: today and the 6 days before, in UTC. You cannot change the dates on this page.

Each card loads on its own. If one card fails, it shows an error and **Try again**. The other cards still show. When you change the project, the cards load again for the new project.

### Where people leave

This card runs the saved funnel that your team pinned to the Simple view. See **Pin a saved funnel**, below.

- Under the title, the card shows the name of the funnel.
- It runs the steps, the conversion window and the team setting of the saved funnel on the last 7 days. It does not use the breakdown.
- It shows a sentence such as "292 of 800 people (36.5%) who reached “/pricing” went on to “signup” in the last 7 days."
- It shows the biggest drop, such as "The biggest drop: 63.5% left between “/pricing” and “signup”." If two drops are equal, it shows the earlier one.
- It shows one bar for each step, with the number of people and their share of step 1. Between two steps, a line shows the share of people that left.
- **See why people left** opens Workbench › **Funnels** with the saved funnel on the last 7 days. There, the breakdown of the saved funnel applies again. See [Funnels: where users drop off](/docs/funnels).

If nobody reached step 1, the card says, for example, "Nobody reached “/pricing” in the last 7 days."

A saved funnel can leave out your team. If Sequential cannot read who is on your team, the card counts with your team in. It then says "Who is on your team could not be read for this answer."

### Sessions worth watching

Beside the title, the card says "Top 5 from Evidence". It shows the first 5 sessions of the last 7 days, in the attention order that **Evidence** uses.

- Each row is a session card, as on **Evidence**: the person, when the visit started and how long it was, the sentence of the judge, and the moment worth seeing.
- If the recording cannot play, the row says why, for example "No recording" or "Ready by" with a time.
- Click a row to open the session beside the page.
- **All sessions** opens **Evidence**. See [Evidence: the sessions worth a look](/docs/watch).

If the last 7 days have no session, the card says "No sessions in these dates." If the list does not load, the card says "Couldn’t load the sessions." with **Try again**.

### Where people click

This card shows the page with the most views in the last 7 days. It shows the path and the host of the page, and then its views and clicks, for example "1,204 views, 312 clicks". If two pages have the same number of views, the card shows the page that Workbench › **Heatmaps** lists first.

**Open heatmap** opens Workbench › **Heatmaps** on that page, on the last 7 days. It opens the device that most of the views came from: desktop, tablet or mobile. See [Heatmaps](/docs/sessions-and-replay#heatmaps).

- If heatmaps are off, the card says "Heatmaps are switched off for this project (or its replay, or its web platform). Turn them on in project settings."
- If replay reads are off, the card says "Replay reads are switched off here, and heatmaps are made from recordings, so they are off too."
- If no page has heatmap data in these dates, the card says "No clicks in these dates."
- If Sequential cannot read the heatmaps, the card says "Heatmaps could not be read just now. Nothing is lost; try again in a minute." with **Try again**.

### When the card Where people leave has no answer

- **No funnel is pinned.** A viewer sees "No funnel chosen yet. Ask a teammate to pin a saved funnel." An owner, an admin or a member sees "Pin a saved funnel to show it here: Workbench › Funnels, then “Pin to the Simple view” on it." Both see **Open Funnels**.
- **The Workbench cannot read the pinned funnel.** The card says why, and shows **Open Funnels**.
- **The saved funnels do not load.** The card says "Couldn’t load the saved funnels. Try again." Click **Try again**.
- **The funnel does not run.** The card says "Couldn’t run the funnel. Try again." Click **Try again**.

## Pin a saved funnel

The card **Where people leave** shows one saved funnel. Each project has at most one pinned funnel, and everyone in the project sees the same one.

1. Open Workbench › **Funnels**.
2. In **Saved funnels**, find the funnel.
3. Click the pin button beside its name. Its tooltip says **Pin to the Simple view**.

The page says "Pinned: the Simple view shows this funnel." The list then shows **On the Simple view** with that funnel.

- If another funnel was pinned, Sequential unpins it. It does not ask first.
- To unpin a funnel, click its pin button again. The tooltip then says **Unpin from the Simple view**. The page says "Unpinned: the Simple view shows no funnel."
- Only owners, admins and members see the pin button. Everyone in the project sees **On the Simple view**.
- A pin does not change the saved funnel. Its steps, its version and who saved it last stay the same.
- Each pin and each unpin makes one entry in the [audit log](/docs/audit-log).

If a pin fails, the page says why, and the list loads again:

- "Another funnel was pinned at the same time. Try again."
- "This funnel no longer exists. The list is up to date again."
- "Your role cannot pin funnels here."
- "Couldn’t pin the funnel. Try again."

See also [Filters, date ranges and saved views](/docs/filters-and-saved-views#save-and-open-views).

## It changes no permission

Simple view changes only the rail and the page that **Brief** opens. It does not hide any data from you, and it does not give you more access.

- A page that the rail does not show still opens from its link.
- **Ask or jump** (⌘K) still lists every place of the full rail. See [Ask or jump (⌘K)](/docs/search-or-jump-to).
- What you can see and change depends on your role, not on Simple view. See [Roles and permissions](/docs/roles-and-permissions).

## Related

- [Funnels: where users drop off](/docs/funnels)
- [Evidence: the sessions worth a look](/docs/watch)
- [Find and replay sessions](/docs/sessions-and-replay)
- [Filters, date ranges and saved views](/docs/filters-and-saved-views)
- [Roles and permissions](/docs/roles-and-permissions)
- [Ask or jump (⌘K)](/docs/search-or-jump-to)
