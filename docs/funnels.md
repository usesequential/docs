# Funnels: where users drop off

> Count how many users complete a series of steps in order, see where the others leave, and open the exact users who left.

> **In short**
>
> - A funnel counts users, not events, through a series of steps in order. The steps can be in different sessions.
> - Each step is a filter on one event, usually on the fields Event, Event type or URL.
> - A later step counts only within the conversion window after step 1, from 1 to 90 days. The default is 7 days.
> - Select a drop to see who left there.
> - Without identify, one person can be several users. With Amplitude, Pendo or Smartlook, nothing links the ids before and after identify.

## What it is for

Use a funnel when you know the path that people must take, and you want to see where they leave it. For example: does checkout lose more people at payment or at confirmation?

## Build a funnel

1. In the rail, click **Workbench**.
2. Open **Funnels**.
3. Under Dates, pick a window, such as **30 days**. To pick two days, click **Custom**.
4. In Step 1, click the **value** box of the condition "Event is".
5. Pick an event, or type its name and press Enter.
6. Set Step 2 in the same way.

There is no Run button. The funnel counts again a short time after each change to a step, the dates or a setting. The page opens on 30 days, unless its address holds other dates.

A new funnel has two steps. A funnel has 2 to 10 steps. Each new step starts with the condition Event is. Between two steps, the page says, for example, "then, within 7 days of step 1".

Under the steps, two settings show: Conversion window and Break down by. Conversion window sets the time limit: a later step counts only when the person does it within this number of days after step 1, from 1 to 90. The default is 7. Who left here uses the same window.

All the conditions in a step test one event. So a step cannot combine an Event from one event with a URL from another event.

A custom event for each milestone, such as `checkout_completed`, gives each step one clear Event. A URL step cannot tell pages apart if your app routes by query string, because Sequential does not keep query values.

You can also start a funnel from a session: in What they did, click New funnel from this event on a row. See [Session replay](/docs/sessions-and-replay#what-they-did-and-info).

### The step fields

Each step is a filter from the same filter bar as the rest of the Workbench. The usual fields are:

- Event: the name that your SDK sends, such as your custom `checkout_completed`.
- Event type: the [event class](/docs/events), such as `form_submit`.
- URL. A URL step must match the whole stored address.

Each condition has an operator, such as "is", "contains" or "is more than". "is" matches one whole value. A step can test an event property with Event property. For example, `checkout_completed` with `plan` is `pro`, or with `amount` is more than `100`.

### Dates and values in the steps

- A window of days is whole UTC days, today included.
- The value list suggests values that your project has sent. For Event type, these are class names such as `form_submit`.

### Why custom events give better steps

Autocaptured events give broad steps. For example, Event type is `click` matches any click on any page. A custom event for each milestone, such as `checkout_completed`, gives each step one clear Event. See [Send custom events](/docs/custom-events).

### Change the steps

- To add a step, click Add a step. Set it in the same way.
- To move a step up or down, use the arrow buttons on the step.
- To remove a step, click × on the step. A funnel keeps at least 2 steps.
- To check one step, read the sentence under its bar. It says what the step matches.
- To use a saved filter as a step, click Step from saved filter. See [How do I use a saved filter as a step?](#how-do-i-use-a-saved-filter-as-a-step)

### Conditions and an example funnel

With two or more conditions in a step, a button at the start of the step's bar says All of or Any of. Click it to switch.

This is a trial funnel built on custom events:

| # | Step | Condition |
|---|---|---|
| 1 | Trial started | Event is `trial_started` |
| 2 | Project created | Event is `project_created` |
| 3 | Teammate invited | Event is `teammate_invited` |

A funnel answers questions like these:

- Of the people who started a trial this month, how many created a project? How many of those invited a teammate?
- Which people started onboarding and did not finish, and what did they do instead?

## Read the results

From 8 November 2026, a headline at the top gives the share of step 1 who reached the last step. For example: "30 of 200 people (15%) went on to the last step". When nobody went on, it says, for example, "None of the 50 people went on to the last step." When nobody did step 1, it says "Nobody did the first step."

A scope line under the headline gives the conversion window and the dates, for example "Within 7 days of the first step · 30 calendar days to today". At its end, "How counted ▾" shows the sentence that the page showed before, word for word. For example: "1,140 of 3,120 (36.5%) people who did “Viewed pricing” went on to “Created project” within 7 days, in the last 30 days." While you compare before and after a change, one sentence shows in place of the headline and the scope line.

Under the scope line, a second sentence names the biggest drop. For example: "The biggest drop is after “Pricing”: 240 of 600 (40%) did not go on to “Sign-up”."

The chart has one bar for each step. Each bar shows the step's people as a share of step 1. The bar also marks the part that the step lost from the step before. Between two bars, a line counts the people who left, such as "412 left (34%); the others took 4 min on average". The biggest drop has the tag "biggest drop".

To see the numbers as a table, click Show as a table. To see the chart again, click Show as bars. The table shows two percentages for each step: of step 1, and of the step before. The table has these columns:

| Column | What it shows |
|---|---|
| Step | The step's number and name |
| People | The people who reached the step |
| Of step 1 | The share of step 1's people |
| Of the step before | The share of the previous step's people |
| Left before the next | The people who reached this step but not the next one, and their share. Click it to open the drop |
| Time to the next (average) | The mean time to the next step, for the people who went on, such as "2 h 5 min" |
| Sessions | Sessions that reached this step and Sessions that stopped here |

Under the answer, a line counts the people who did every step, for example "1,140 people did every step". To open these people in People, click View them in People. See [People from a funnel](/docs/users-and-accounts#people-from-a-funnel).

### If the result shows a message, or a part is missing

| Message | What it means | What to do |
|---|---|---|
| "Pick at least two steps to see the funnel." | A step does not have a finished condition yet. The page also gives the reason, such as "Step 2 needs a finished condition." | — |
| "Counting again…" | The funnel counts again. The old result stays, dimmed, until the new one is ready. | — |
| An error, with Try again | The count failed. | — |
| "The backend did not run this funnel. The reason is beside the setting it is about." | The backend refused a setting. The reason then shows beside that setting. | — |
| A line such as "Only 12 people did step 1, so one person more or less moves these shares a lot." | Fewer than 20 people did step 1 | — |
| "Nobody entered this funnel." | Nobody did step 1 | — |
| "No events yet", in place of the funnel | Your project has not sent an event or a recording yet. | The button, such as Set up Acme, opens Settings › Setup. |

With "No events yet", the page says, for example, "Acme hasn’t sent any events yet. Once it does, you can build a funnel here: how many people go through each step, and where they stop." The save button does not show then, and the keys s, n, r, j and k do nothing. Copy link still works. If Sequential cannot read the status of the project, the page shows the funnel as usual.

The line of people who did every step does not show while you compare before and after a change. It also does not show when nobody did every step, or when the answer does not name the people. The demo project does not name them. See [List people in funnels](#list-people-in-funnels).

### Left before the next, and percentages

Left before the next on a step counts the people who reached this step but not the next step.

For example, steps 1 to 3 have 200, 120 and 60 people. Step 3 shows 30 % Of step 1, and 50 % Of the step before.

### Step-to-step rates and time to convert

Time to the next (average) is the mean time from the event that reached a step to the event that reached the next step. It uses only the people who reached the next step. It reads like "45 s", "12 min" or "2 h 5 min". A dash shows on the last step, and when the mean time is 0.

Of the step before is never more than 100 %.

## See who dropped

Each new result marks the largest drop: the one where the most people left. A tie goes to the earlier step.

To watch the session of a person who left:

1. To open a drop, click its line between two bars. Or, after you click Show as a table, click its number under **Left before the next**.
2. In Who left here › The people, find the person.
3. Click their **Watch** button. It opens the session where they did the step, in the peek, at that moment.

Not every person has a Watch button. See [Why funnel and replay counts differ](#why-funnel-and-replay-counts-differ).

The panel Who left here opens under the chart. Its title names the step, such as "After step 2: Pricing". It shows:

| Part | What it shows |
|---|---|
| A sentence | For example, "240 of 600 (40%) people who did “Pricing” did not go on to “Sign-up”." |
| Sessions that stopped here | The sessions where the step happened and the next step did not. See [What the session links show](#what-the-session-links-show). |
| View them in People | Opens the people who did the step and not the next step, in People. See [People from a funnel](/docs/users-and-accounts#people-from-a-funnel). |
| How long they stayed | For example, "Half of them left within 5 min of “Pricing”, in that same visit (the median of 18 visits)." |
| The cases that hit them | The open cases in their visits after the step, in the last 7 days. Each row has the case number, such as F-37, its title and its number of visits. Click a row to open the case. |
| The people | The people, with their number: each person by name or email, or by the end of a long id, such as "Visitor 5b2f8a" for an anonymous person and "…9c41e7" for any other, and when they did the step. The person who did the step last comes first. |
| Why fewer sessions than people? | See [What do the rows under Why fewer sessions than people mean?](#what-do-the-rows-under-why-fewer-sessions-than-people-mean). |

In the list of people in Who left here:

- Click a person to open them in the peek.
- A button such as Show 50 more lists more people.

A new result closes the panel. Press Close or Esc to close the panel.

### If Who left here shows a message

| Message | What it means | What to do |
|---|---|---|
| "No open case hit their visits after “Pricing” in the last 7 days." | No open case hit their visits after the step. | — |
| "The cases could not be read just now." | Sequential cannot read the cases. | — |
| An error, with Try again | The panel cannot read the people who left. | — |
| "How long they stayed could not be read just now." | Only the time cannot be read. | — |

### What the session links show

- Sessions that reached this step and Sessions that stopped here open Workbench › Sessions on the funnel's dates.
- A funnel follows people across their visits. The session list looks at one session at a time.
- Sessions that reached this step lists every session with this step, also when the steps before it did not happen.
- Sessions that stopped here lists the sessions where the step happened and the next step did not. A person who went on in a later visit still shows here.
- Sessions that stopped here shows only when the session list can say "not" of the next step. For example, it does not show for a next step with two conditions joined by All of.
- Hover over a link to read what it looks at.

## Break a funnel down by campaign

To split each step into groups, pick a choice in Break down by, under the steps:

| Choice | What it does |
|---|---|
| Nothing | The default. |
| Their first …, Their first visit’s … or Their last … before step 1 | These three read each person's visits up to their step 1. Then pick a field, such as campaign name or traffic source. |
| The step-1 visit’s first … | Takes a page or an event property name. |
| The step-1 event’s … | Takes a campaign field of that event. |

Under the bars, each group then has a small funnel. Each group is drawn against its own step 1. The answer shows the 20 largest groups by step-1 people. The other people are in one group, named Everyone else.

See [Measure a campaign](/docs/measure-a-campaign#break-a-funnel-down-by-campaign).

## Leave out your team, or compare around a change

To leave out your team, select Your team › Leave out people marked as your team. It leaves out the people that your project marks as its team. While nobody is marked, you cannot select the box. The page then says "Nobody is marked as your team yet, so there is no one to leave out.", with Mark them in Settings. Mark them in Settings opens Your team in Settings › Recording & data.

In a new funnel, the box is clear. When you pick a breakdown in Break down by, Sequential selects the box. When you set Break down by back to Nothing, Sequential clears the box.

To count the same funnel twice, before and after a change on the Changes timeline, use Before / after a change, next to Dates. Pick the change, then 7 days, 14 days or 30 days. The two windows are never longer than the time since the change.

The page says "Counts, not causes: other changes in the same days move these numbers too." The breakdown is left out while you compare.

A release page in Changes has a link such as Compare a funnel before and after. It opens Funnels with this comparison. A link for a saved funnel keeps the Your team setting of that funnel. See [How does the team box work?](#how-does-the-team-box-work)

## Save a funnel

Saved funnels belong to the project. Everyone in the project sees them. You find them in Saved funnels, at the bottom of the page. Click a name to open a funnel.

Owners, admins and members can rename and delete a funnel in Saved funnels. To save, open, change, rename or delete a saved funnel, see [Save and open views](/docs/filters-and-saved-views#save-and-open-views).

Owners, admins and members can also pin one saved funnel to the Simple view with the pin button, Pin to the Simple view. Everyone sees On the Simple view with the pinned funnel. See [Simple view](/docs/simple-view).

- Each project has its own saved funnels.
- A saved funnel keeps its steps but not its dates. It uses the dates on the page.

## List people in funnels

From 3 November 2026, owners and admins can set List people in funnels under Settings › Recording & data, in the block People in funnels:

| Choice | What funnels show |
|---|---|
| Not chosen yet | Funnels list people, as before. A project shows this choice only until an owner or admin chooses On or Off. |
| On | Funnels list who left at each step and who did every step. |
| Off | Funnels show only counts. They do not show who left or who did every step, in the app or to agents. |

With Off, every count, step and share stays the same. A change applies within 30 seconds.

The setting does not cover the other places that show people: "People, Accounts and breakdowns by user id still show people, in the app and to agents." See [What does Off show, in the app and to agents?](#what-does-off-show-in-the-app-and-to-agents)

From 8 November 2026, the block shows the choices as a grid with the caption "What funnels show with each choice". Its columns are "Choice", "In the app" and "To agents". Each row starts with the button of one choice:

| Choice | In the app | To agents |
|---|---|---|
| Not chosen yet | "People listed, as before". A note says "No funnel suggestion until an owner or admin chooses On or Off". | "People listed, as before" |
| On | "Who left at each step and who did every step" | "Who left at each step and who did every step" |
| Off | "Counts only" | "Counts only" |

From 8 November 2026, a risk line under the grid always shows: "Only funnels follow this choice. Sessions, People, Accounts and breakdowns by user id still show people, in the app and to agents." The old help of each choice and the old line about the other places are word for word under Read the full text ▾. Members and viewers see the full text open.

## Read a funnel in words

Under the definition, open Explain in words. It says the whole funnel in sentences: whom it counts and over which dates, that a later step counts only after the step before it and within the window after the first step-1 event, each step, the split, and whether your team is left out. For a comparison, it names the two windows. If the change is recent, both windows are as long as the time since the change.

## How it works

Each step is a filter on the fields and properties of one event. The usual fields are Event, Event type and URL.

Sequential sorts each person's matching events in the date range by time. A person enters at their first step-1 event. The person reaches step 2 at the first step-2 event after it. Each later step works the same way: the person reaches it only at an event after the event that reached the step before it. The steps can be in different sessions.

- A person who skipped a step reaches no later step. So a step never has more people than the step before it, and the last step counts the people who did every step in order.
- An event can count for any step that it matches. But each step needs a later event than the event that reached the step before it, so one event never counts for two steps. For example, with the steps "any event" → `purchase`, a later `purchase` event reaches step 2.
- From 9 October 2026, a funnel whose steps can match the same event shows higher numbers after step 1, and these numbers are correct. Before that date, each event counted only toward the first step that it matched.
- The agent tool `funnel_analysis` uses the same rule.
- The conversion window is a time limit too. A step after step 1 counts only within this number of days after the person's step-1 event. The default is 7 days.

### Step matching examples

The order applies to every step. A step-3 event before the person reached step 2 does not count.

Other events between two steps do not matter.

| Step 1 | Step 2 | Result |
|---|---|---|
| Event type is `pageview` | Event type is `pageview` and URL is your pricing page | Every pricing page view counts for step 1. Step 2 stays at 0. |
| Event type is `pageview` | URL is your pricing page | Step 2 counts only the other events of that page, such as clicks. It never counts the page view. |

## What it needs

Funnels work with events from any supported SDK. Every role can use them, viewers included.

- Without identify, one person can be several users. Drop-off lists then hold anonymous ids, not your customers.
- Two values for one person are two users. Your app must keep the value consistent. See [Identify your users](/docs/identify-users).

> **A funnel across sign-up counts one person once**
>
> With the Sequential SDK, PostHog or Mixpanel, a funnel counts a visitor who identifies during the date range as one person. The steps before and after identify join. This also applies when the visitor identifies after the date range, so the result for a past period can change. A new link can take up to 5 minutes to apply. With Amplitude, Pendo or Smartlook, nothing links the two ids, so keep a funnel on one side of identify. See [Users and identity](/docs/users-and-identity).

### How Sequential matches users

Sequential matches steps per person. It uses the value that your app passes to identify, exactly as it is. Events sent before identify carry an anonymous id, and events after identify carry the id that you pass.

With the Sequential SDK, PostHog or Mixpanel, identify also sends a link to the anonymous id. The funnel uses the link, so the steps before and after identify belong to one person. The link is one step. See [Users and identity](/docs/users-and-identity).

Example: a funnel has the steps Viewed pricing → Started sign-up → Created project. Your app calls identify when it creates the account.

- With the Sequential SDK, PostHog or Mixpanel, each new sign-up counts through all three steps.
- With Amplitude, Pendo or Smartlook, new sign-ups seem to drop off after step 2. Steps 1 and 2 belong to the anonymous id. Step 3 belongs to an id that never did step 1.

Another device, a private window or cleared storage gives a new anonymous id. So without identify, one person can be several users.

## Why funnel and replay counts differ

A funnel counts people. It counts them from events. A replay exists only for a session that Sequential recorded. So not every person who left has a session that you can play.

In Who left here, a person with a session id has a session button:

| Button | When it shows |
|---|---|
| Visit | Sequential knows that the session has no recording that you can play now. A recording that is older than the replay period of the project also gets Visit. |
| Watch | Any other person with a session id. |
| No button | The person's event has no session id. |

Both Watch and Visit open the session in the peek.

Under the people, the panel gives the retention periods of the project, for example "Recordings are kept 30 days here, events 30 days." These are the periods in force for the project. See [Data retention and deletion](/docs/retention-and-deletion).

## FAQ

### How do I use a saved filter as a step?

Click Step from saved filter. It copies the conditions of the filter into a new step. To swap the conditions of a step for a saved filter, click Replace with saved filter under the header of the step.

The menu lists the saved filters of the project, newest first. Type to narrow it. A filter that cannot be a step is grey, with the reason:

| Message | What it means | What to do |
|---|---|---|
| "Only saved filters can be steps" | This filter cannot be a step. | — |
| "No conditions yet" | This filter cannot be a step. | — |
| "Too large to use as a step" | This filter cannot be a step. | — |
| "Uses a filter the Workbench cannot read yet" | This filter cannot be a step. | — |

A later change to the saved filter does not change the step. Under a step that came from a saved filter, a line says "From saved filter:" and the name of the filter. The line can add:

| Message | What it means | What to do |
|---|---|---|
| "edited" | You changed the conditions of the step after the copy. | — |
| "view changed" | Someone changed the conditions of the saved filter. | — |

Update from view reads the saved filter again and gives the step its current conditions. It is off, with the reason when you hold the pointer on it, while the saved filters load, when the saved filter no longer exists, or when the filter can no longer be a step.

If you edited the step, Sequential asks first: "This step was edited after it was copied. Replace it with the saved filter’s current conditions?" Click Replace, or Keep my edits. Replace with saved filter on a step that already has conditions asks too, with Replace or Cancel.

### Why can the panel and View them in People list different people?

With more than 1,000 people who left, the panel says "The lists below look at the latest 1,000 of them." View them in People counts all of the people who left, and its list shows the first 1,000 of them in the order of their ids. So the same answer always gives the same list. These are not always the 1,000 people of the panel.

### What do the rows under Why fewer sessions than people mean?

Under the people, Why fewer sessions than people? is closed until you click it. It counts the people who left by the session where they did the step. It shows only when some of them have no session that you can play now.

| Row | What it means |
|---|---|
| Can play now | — |
| Processing | — |
| Recording expired | — |
| No playable recording | "The recording was never fully received." This row shows only when its count is more than 0. |
| No recording | "Sampling left it out, the browser blocked it, or the recorder was not on that page." |
| No session id | — |
| Not checked | Sequential could not check the recording of the session. This row shows only when its count is more than 0. |

The rows add up to People who left. With more than 1,000 people who left, the total is In scope, and a line says, for example, "From the latest 1,000 of 4,210 people who left." Under the rows, the panel says "Funnels count people from events. Replays exist only for recorded sessions." Show 50 more does not change these counts. If Sequential cannot read the sessions, the panel does not show this part.

| Message | What it means | What to do |
|---|---|---|
| "Couldn’t count the sessions." | The counts do not add up. | — |

### How does the team box work?

- After you select or clear the box yourself, a breakdown does not change it.
- While nobody is marked as your team, the box stays clear.
- A funnel that you open from a link or from Saved funnels keeps its own setting. A funnel that you saved keeps its setting too.

If Sequential cannot read who is marked as your team, a funnel with the box selected does not count. Under the box, the page says:

| Message | What it means | What to do |
|---|---|---|
| "Sequential could not read who is marked as your team right now. Try again shortly, or include your team." | Sequential cannot read who is marked as your team. | Click Include your team to clear the box and count with your team in. |

### What does Off show, in the app and to agents?

With Off, the line under the answer and Who left here › The people say "This project does not list people in funnels, so only the counts show.", with a link to Settings. View them in People does not show.

To agents, `funnel_analysis` gives empty id lists with `people_withheld: "project_setting_off"`, and its `_total` fields still count the people. The audit log records a change of the setting as `project.config_changed`.

If Sequential cannot read the settings of the project and holds no earlier copy of them, it holds the people back for every choice. The page then says "The project’s settings could not be read just now, so the people are not listed. The counts are complete.", and agents get `people_withheld: "setting_unavailable"`.

### Why can later steps show higher numbers from 9 October 2026?

Before 9 October 2026, each event counted only toward the first step that it matched. Examples of funnels whose steps can match the same event: a first step that matches every event, two steps that share a property, or the same event name at two steps. Step 1 does not change. A funnel whose steps never match the same event does not change.

## Limits

- A funnel has 2 to 10 steps, and a conversion window of 1 to 90 days. See [Build a funnel](#build-a-funnel).
- Each step needs a finished condition. Until then, the funnel counts nothing.
- If a run takes longer than 30 seconds, it stops. The page says "Internal Server Error", with Try again. Shorten the date range and try again.
- A breakdown shows the 20 largest groups by step-1 people. See [Break a funnel down by campaign](#break-a-funnel-down-by-campaign).
- With more than 1,000 people who left, the lists in Who left here look at the latest 1,000 of them. See [Why can the panel and View them in People list different people?](#why-can-the-panel-and-view-them-in-people-list-different-people)
- Events with no user id are not a user. They never enter a funnel, and no drop-off list shows them.
- A URL step cannot tell pages apart if your app routes by query string, because Sequential does not keep query values. See [URL steps and event properties](#url-steps-and-event-properties).

### URL steps and event properties

- A URL step must match the whole stored address.
- Sequential does not store the part of the address after `#`, except a hash route such as `#/orders`, from 9 October 2026.
- Sequential stores query values as `[redacted]`, except campaign and ad-click parameters. See [What Sequential keeps from page URLs](/docs/url-policy).
- So a URL step cannot tell pages apart in an app that routes by query string, or by `#/…` for events before 9 October 2026.
- In an app that routes by `#/…`, a URL step can tell pages apart for events from 9 October 2026, because Sequential keeps the route from that date.
- To separate outcomes by a number or a range, use Event property with the type Number, for example is between.
- Visitor property tests visitor properties. PostHog and the Sequential SDK do not send them.

## Related

- [Flows](/docs/flows)
- [Retention](/docs/retention)
- [Filters, date ranges and saved views](/docs/filters-and-saved-views)
- [Workbench › Events](/docs/events-explorer)
- [Users and accounts](/docs/users-and-accounts)
- [Users and identity](/docs/users-and-identity)
- [Identify your users](/docs/identify-users)
- [Send custom events](/docs/custom-events)
- [Roles and permissions](/docs/roles-and-permissions)
