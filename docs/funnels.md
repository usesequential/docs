# Funnels: where users drop off

> Count how many users complete a series of steps in order, see where the others leave, and open the exact users who left.

> **In short**
>
> - A funnel counts users, not events, through a series of steps in order.
> - Each step is a filter on one event, usually on **Event**, **Event type** or **URL**.
> - A later step counts only within the conversion window after step 1. The default is 7 days.
> - The table shows two percentages for each step: of step 1, and of the step before.
> - Select a drop to see who left there.
> - **View them in People** lists the people who did every step, or the people who left after a step, in **People**.
> - Saved funnels belong to the project. Everyone in the project sees them.

## What it is for

Use a funnel when you know the path that users must take, and you want to see where they leave it. For example: does checkout lose more people at payment or at confirmation?

## How it works

Each step is a filter on the fields and properties of one event. The usual fields are **Event**, **Event type** and **URL**.

Sequential sorts each user's matching events in the date range by time. A user enters at their first step-1 event. The user reaches step 2 at the first step-2 event after it. Each later step works the same way: the user reaches it only at an event after the event that reached the step before it. The steps can be in different sessions.

- A user who skipped a step reaches no later step. So a step never has more users than the step before it, and the last step counts the people who did every step in order.
- An event can count for any step that it matches. But each step needs a later event than the event that reached the step before it, so one event never counts for two steps. For example, with the steps "any event" → `purchase`, a later `purchase` event reaches step 2.
- From 9 October 2026, a funnel whose steps can match the same event shows higher numbers after step 1, and these numbers are correct. Before that date, each event counted only toward the first step that it matched. Examples of such funnels: a first step that matches every event, two steps that share a property, or the same event name at two steps. Step 1 does not change. A funnel whose steps never match the same event does not change.
- The agent tool `funnel_analysis` uses the same rule.
- The conversion window is a time limit too. A step after step 1 counts only within this number of days after the person's step-1 event. The default is 7 days.

## Build a funnel

1. In the rail, click **Workbench**. Then open **Funnels**.
2. Under **Dates**, pick a window, such as **30 days**. To pick two days, click **Custom**.
3. In **Step 1**, click the **value** box of the condition **Event** **is**.
4. Pick an event, or type its name and press Enter.
5. Set **Step 2** in the same way.
6. You can also start a funnel from a session: in **What they did**, click **New funnel from this event** on a row. See [Session replay](/docs/sessions-and-replay#what-they-did-and-info). To add a step, click **Add a step**. To use a saved filter as a step, click **Step from saved filter**. It copies the conditions of the filter into a new step. To swap the conditions of a step for a saved filter, click **Replace with saved filter** under the header of the step. The menu lists the saved filters of the project, newest first. Type to narrow it. A filter that cannot be a step is grey, with the reason: "Only saved filters can be steps", "No conditions yet", "Too large to use as a step" or "Uses a filter the Workbench cannot read yet". A later change to the saved filter does not change the step. Under a step that came from a saved filter, a line says "From saved filter:" and the name of the filter. It adds **edited** when you changed the conditions of the step after the copy, and "view changed" when someone changed the conditions of the saved filter. **Update from view** reads the saved filter again and gives the step its current conditions. It is off, with the reason when you hold the pointer on it, while the saved filters load, when the saved filter no longer exists, or when the filter can no longer be a step. If you edited the step, Sequential asks first: "This step was edited after it was copied. Replace it with the saved filter’s current conditions?" Click **Replace**, or **Keep my edits**. **Replace with saved filter** on a step that already has conditions asks too, with **Replace** or **Cancel**. Set it in the same way.

A new funnel has two steps. Each new step starts with the condition **Event** **is**. A funnel has 2 to 10 steps. Between two steps, the page says, for example, "then, within 7 days of step 1".

There is no **Run** button. The funnel counts again a short time after each change to a step, the dates or a setting. Until each step has a finished condition, the page says "Pick at least two steps to see the funnel." and the reason, such as "Step 2 needs a finished condition." The old result stays, dimmed, with "Counting again…", until the new one is ready. If the count fails, the page shows an error with **Try again**. If the backend refuses a setting, the page says "The backend did not run this funnel. The reason is beside the setting it is about." The reason then shows beside that setting.

If your project has not sent an event or a recording yet, the page shows "No events yet" in place of the funnel. It says, for example, "Acme hasn’t sent any events yet. Once it does, you can build a funnel here: how many people go through each step, and where they stop." The button, such as **Set up Acme**, opens Settings › **Setup**. The save button does not show then, and the keys **s**, **n**, **r**, **j** and **k** do nothing. **Copy link** still works. If Sequential cannot read the status of the project, the page shows the funnel as usual.

## Read the results

At the top, one sentence gives the share of step 1 who reached the last step. For example: "1,140 of 3,120 (36.5%) people who did “Viewed pricing” went on to “Created project” within 7 days, in the last 30 days." A second sentence names the biggest drop. For example: "The biggest drop is after “Pricing”: 240 of 600 (40%) did not go on to “Sign-up”."

The chart has one bar for each step. Each bar shows the step's people as a share of step 1. The bar also marks the part that the step lost from the step before. Between two bars, a line counts the people who left, such as "412 left (34%); the others took 4 min on average". The biggest drop has the tag **biggest drop**.

**Show as a table** shows the same numbers as a table. **Show as bars** shows the chart again. The table has these columns:

| Column | What it shows |
|---|---|
| **Step** | The step's number and name |
| **People** | The people who reached the step |
| **Of step 1** | The share of step 1's people |
| **Of the step before** | The share of the previous step's people |
| **Left before the next** | The people who reached this step but not the next one, and their share. Click it to open the drop |
| **Time to the next (average)** | The mean time to the next step, for the people who went on, such as "2 h 5 min" |
| **Sessions** | **Sessions that reached this step** and **Sessions that stopped here** |

If fewer than 20 people did step 1, a line says, for example, "Only 12 people did step 1, so one person more or less moves these shares a lot." If nobody did step 1, the page says "Nobody entered this funnel."

Under the answer, a line counts the people who did every step, for example "1,140 people did every step". **View them in People** opens these people in **People**. See [People from a funnel](/docs/users-and-accounts#people-from-a-funnel). The line does not show while you compare before and after a change. It also does not show when nobody did every step, or when the answer does not name the people. The demo project does not name them.

## See who dropped

Each new result marks the largest drop: the one where the most people left. A tie goes to the earlier step. To open a drop, click its line between two bars. In the table, click its number under **Left before the next**.

The panel **Who left here** opens under the chart. Its title names the step, such as "After step 2: Pricing". It shows:

- a sentence such as "240 of 600 (40%) people who did “Pricing” did not go on to “Sign-up”."
- **Sessions that stopped here**: the sessions where the step happened and the next step did not. See **What the session links show**, below
- **View them in People**: opens the people who did the step and not the next step, in **People**. See [People from a funnel](/docs/users-and-accounts#people-from-a-funnel)
- how long they stayed, such as "Half of them left within 5 min of “Pricing”, in that same visit (the median of 18 visits)."
- **The cases that hit them**: the open cases in their visits after the step, in the last 7 days. Each row has the case number, such as F-37, its title and its number of visits. Click a row to open the case. With none, the panel says "No open case hit their visits after “Pricing” in the last 7 days." If Sequential cannot read them, it says "The cases could not be read just now."
- **The people**, with their number: each person by name or email, or by the end of a long id, such as "Visitor 5b2f8a" for an anonymous person and "…9c41e7" for any other, and when they did the step. The person who did the step last comes first. Click a person to open them beside the page. **Watch** opens the session where they did the step, beside the page, at that moment. A button such as **Show 50 more** lists more people
- **Why fewer sessions than people?**: see **Why funnel and replay counts differ**, below

With more than 1,000 people who left, the panel says "The lists below look at the latest 1,000 of them." **View them in People** counts all of the people who left, and its list shows the first 1,000 of them in the order of their ids. So the same answer always gives the same list. These are not always the 1,000 people of the panel.

A new result closes the panel. If the panel cannot read the people who left, it shows an error with **Try again**. If only the time cannot be read, the panel says "How long they stayed could not be read just now." For the cases, see **The cases that hit them**, above.

Press **Close** or Esc to close the panel.

## Break a funnel down by campaign

Under the steps, two settings show:

- **Conversion window**: a later step counts only when the person does it within this number of days after step 1, from 1 to 90. The default is 7. **Who left here** uses the same window.
- **Break down by** splits each step into groups. **Nothing** is the default. **Their first …**, **Their first visit’s …** and **Their last … before step 1** read each person's visits up to their step 1. Then pick a field, such as **campaign name** or **traffic source**. **The step-1 visit’s first …** takes a page or an event property name. **The step-1 event’s …** takes a campaign field of that event.

Under the bars, each group then has a small funnel. Each group is drawn against its own step 1. The answer shows the 20 largest groups by step-1 people. **Everyone else** holds the other people.

See [Measure a campaign](/docs/measure-a-campaign#break-a-funnel-down-by-campaign).

## Leave out your team, or compare around a change

- **Leave out people marked as your team**, under **Your team**, leaves out the people that your project marks as its team. While nobody is marked, you cannot select the box. The page then says "Nobody is marked as your team yet, so there is no one to leave out." and **Mark them in Settings**, which opens **Your team** in Settings › **Recording & data**.
- In a new funnel, the box is clear. When you pick a breakdown in **Break down by**, Sequential selects the box. When you set **Break down by** back to **Nothing**, Sequential clears the box. After you select or clear the box yourself, a breakdown does not change it. While nobody is marked as your team, the box stays clear.
- A funnel that you open from a link or from **Saved funnels** keeps its own setting. A funnel that you saved keeps its setting too.
- If Sequential cannot read who is marked as your team, a funnel with the box selected does not count. Under the box, the page says "Sequential could not read who is marked as your team right now. Try again shortly, or include your team." Click **Include your team** to clear the box and count with your team in.
- **Before / after a change**, next to **Dates**, counts the same funnel twice: before a change on the **Changes** timeline, and after it. Pick the change, then **7 days**, **14 days** or **30 days**. The two windows are never longer than the time since the change. The page says "Counts, not causes: other changes in the same days move these numbers too." The breakdown is left out while you compare.
- A release page in **Changes** has a link such as **Compare a funnel before and after**. It opens Funnels with this comparison. A link for a saved funnel keeps the **Your team** setting of that funnel.

## Why funnel and replay counts differ

A funnel counts people. It counts them from events. A replay exists only for a session that Sequential recorded. So not every person who left has a session that you can play.

In **Who left here**, a person with a session id has a session button. It says **Watch**. It says **Visit** when Sequential knows that the session has no recording that you can play now. A recording that is older than the replay period of the project also gets **Visit**. Both open the session beside the page. A person whose event has no session id has no button.

Under the people, the panel gives the retention periods of the project, for example "Recordings are kept 30 days here, events 30 days." These are the periods in force for the project. See [Data retention and deletion](/docs/retention-and-deletion).

Under the people, **Why fewer sessions than people?** is closed until you click it. It counts the people who left by the session where they did the step. It shows only when some of them have no session that you can play now. Its rows are:

- **Can play now**
- **Processing**
- **Recording expired**
- **No playable recording**: "The recording was never fully received." This row shows only when its count is more than 0.
- **No recording**: "Sampling left it out, the browser blocked it, or the recorder was not on that page."
- **No session id**
- **Not checked**: Sequential could not check the recording of the session. This row shows only when its count is more than 0.

The rows add up to **People who left**. With more than 1,000 people who left, the total is **In scope**, and a line says, for example, "From the latest 1,000 of 4,210 people who left." Under the rows, the panel says "Funnels count people from events. Replays exist only for recorded sessions." If the counts do not add up, the panel says "Couldn’t count the sessions." **Show 50 more** does not change these counts. If Sequential cannot read the sessions, the panel does not show this part.

> **The session links use the funnel's dates**
>
> - **Sessions that reached this step** and **Sessions that stopped here** open Workbench › **Sessions** on the funnel's dates.

## Read a funnel in words

Under the definition, open **Explain in words**. It says the whole funnel in sentences: whom it counts and over which dates, that a later step counts only after the step before it and within the window after the first step-1 event, each step, the split, and whether your team is left out. For a comparison, it names the two windows. If the change is recent, both windows are as long as the time since the change.

## Save a funnel

Saved funnels belong to the project. Everyone in the project sees them. **Saved funnels**, at the bottom of the page, lists them. Click a name to open a funnel. Owners, admins and members can also rename and delete a funnel there. They can also pin one saved funnel to the Simple view with the pin button, **Pin to the Simple view**. Everyone sees **On the Simple view** with the pinned funnel. See [Simple view](/docs/simple-view). To save, open, change, rename or delete a saved funnel, see [Save and open views](/docs/filters-and-saved-views#save-and-open-views).

- Each project has its own saved funnels.
- A saved funnel keeps its steps but not its dates. It uses the dates on the page.

## What it needs

Funnels work with events from any supported SDK. Every role can use them, viewers included.

- **Without identify, one person can be several users.** Drop-off lists then hold anonymous ids, not your customers.
- **Two values for one person are two users.** Your app must keep the value consistent. See [Identify your users](/docs/identify-users).

> **A funnel across sign-up counts one person once**
>
> With the Sequential SDK, PostHog or Mixpanel, a funnel counts a visitor who identifies during the date range as one person. The steps before and after identify join. This also applies when the visitor identifies after the date range, so the result for a past period can change. A new link can take up to 5 minutes to apply. With Amplitude, Pendo or Smartlook, nothing links the two ids, so keep a funnel on one side of identify. See [Users and identity](/docs/users-and-identity).

## Limits

- Events with no user id are not a user. They never enter a funnel, and no drop-off list shows them.
- Each condition has an operator, such as **is**, **contains** or **is more than**. **is** matches one whole value.
- If a run takes longer than 30 seconds, it stops. The page says "Internal Server Error", with **Try again**. Shorten the date range and try again.
- Each step needs a finished condition. Until then, the funnel counts nothing.
- A **URL** step cannot tell pages apart if your app routes by query string, because Sequential does not keep query values. In an app that routes by `#/…`, it can for events from 9 October 2026, because Sequential keeps the route from that date.
- A step can test an event property with **Event property**. For example, `checkout_completed` with `plan` **is** `pro`, or with `amount` **is more than** `100`.

### The step fields

Each step is a filter from the same filter bar as the rest of the Workbench. The usual fields are:

- **Event**: the name that your SDK sends, such as your custom `checkout_completed`.
- **Event type**: the [event class](/docs/events), such as `form_submit`.
- **URL**.

### Dates and values in the steps

- The page opens on **30 days**, unless its address holds other dates. A window of days is whole UTC days, today included.
- The value list suggests values that your project has sent. For **Event type**, these are class names such as `form_submit`.

### Left before the next, and percentages

**Left before the next** on a step counts the people who reached this step but not the next step.

For example, steps 1 to 3 have 200, 120 and 60 people. Step 3 shows 50 % **Of the step before** and 30 % **Of step 1**.

### Why custom events give better steps

Autocaptured events give broad steps. For example, **Event type** **is** `click` matches any click on any page. A custom event for each milestone, such as `checkout_completed`, gives each step one clear **Event**. See [Send custom events](/docs/custom-events).

### Step matching examples

The order applies to every step. A step-3 event before the user reached step 2 does not count.

Other events between two steps do not matter.

| Step 1 | Step 2 | Result |
|---|---|---|
| **Event type** is `pageview` | **Event type** is `pageview` and **URL** is your pricing page | Every pricing page view counts for step 1. Step 2 stays at 0. |
| **Event type** is `pageview` | **URL** is your pricing page | Step 2 counts only the other events of that page, such as clicks. It never counts the page view. |

### Conditions and an example funnel

With two or more conditions in a step, a button at the start of the step's bar says **All of** or **Any of**. Click it to switch.

All the conditions in a step test one event. So a step cannot combine an **Event** from one event with a **URL** from another event.

- To move a step up or down, use the arrow buttons on the step.
- To remove a step, click **×** on the step. A funnel keeps at least 2 steps.
- To check one step, read the sentence under its bar. It says what the step matches.

This is a trial funnel built on custom events:

| # | Step | Condition |
|---|---|---|
| 1 | Trial started | **Event** is `trial_started` |
| 2 | Project created | **Event** is `project_created` |
| 3 | Teammate invited | **Event** is `teammate_invited` |

A funnel answers questions like these:

- Of the people who started a trial this month, how many created a project? How many of those invited a teammate?
- Which users started onboarding and did not finish, and what did they do instead?

### Step-to-step rates and time to convert

**Time to the next (average)** is the mean time from the event that reached a step to the event that reached the next step. It uses only the people who reached the next step. It reads like "45 s", "12 min" or "2 h 5 min". A dash shows on the last step, and when the mean time is 0.

**Of the step before** is never more than 100 %.

### What the session links show

- A funnel follows people across their visits. The session list looks at one session at a time.
- **Sessions that reached this step** lists every session with this step, also when the steps before it did not happen.
- **Sessions that stopped here** lists the sessions where the step happened and the next step did not. A person who went on in a later visit still shows here.
- **Sessions that stopped here** shows only when the session list can say "not" of the next step. For example, it does not show for a next step with two conditions joined by **All of**.
- Hover over a link to read what it looks at.

### How Sequential matches users

Sequential matches steps per person. It uses the value that your app passes to identify, exactly as it is. Events sent before identify carry an anonymous id, and events after identify carry the id that you pass.

With the Sequential SDK, PostHog or Mixpanel, identify also sends a link to the anonymous id. The funnel uses the link, so the steps before and after identify belong to one person. The link is one step. See [Users and identity](/docs/users-and-identity).

Example: a funnel has the steps Viewed pricing → Started sign-up → Created project. Your app calls identify when it creates the account.

- With the Sequential SDK, PostHog or Mixpanel, each new sign-up counts through all three steps.
- With Amplitude, Pendo or Smartlook, new sign-ups seem to drop off after step 2. Steps 1 and 2 belong to the anonymous id. Step 3 belongs to an id that never did step 1.

Another device, a private window or cleared storage gives a new anonymous id. So without identify, one person can be several users.

### URL steps and event properties

- A **URL** step must match the whole stored address.
- Sequential does not store the part of the address after `#`, except a hash route such as `#/orders`, from 9 October 2026.
- Sequential stores query values as `[redacted]`, except campaign and ad-click parameters. See [What Sequential keeps from page URLs](/docs/url-policy).
- So a **URL** step cannot tell pages apart in an app that routes by query string, or by `#/…` for events before 9 October 2026.
- To separate outcomes by a number or a range, use **Event property** with the type **Number**, for example **is between**.
- **Visitor property** tests visitor properties. PostHog and the Sequential SDK do not send them.

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
