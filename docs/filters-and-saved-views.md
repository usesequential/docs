# Filters, date ranges and saved views

> The filter bar and the window choose which events a Workbench view uses. Saved views let you ask them again.

> **At a glance**
>
> - **For:** Workbench › Events, Sessions, Funnels, Flows, Retention and Accounts share one filter bar. People has the same filter bar.
> - **Who can:** Everyone in the project sees its saved views. Owners, admins and members save, rename and delete them. Viewers only open them.
> - **Before you start:** A filter can match only the data that your SDK sends. See [What it needs](#what-it-needs).
> - **Default:** Each view has its own window, with its own default. Saved funnels and saved filters do not keep the dates.
> - **Know this:** Days run midnight to midnight UTC. A window of days includes today. Every view includes the whole last day of its window.
> - **Know this:** The link of a Workbench view holds its settings, not the project. Add `project=`, or ask the reader to select it.

> **In short**
>
> - Conditions apply to the same event. For "did A, then B", use Funnels.
> - On Sessions, Accounts and People, each condition can match a different event.
> - On a field, "is not" also drops events with no value. On a property, it also matches events without the property.

## Build a filter

1. In the rail, click **Workbench**.

2. Open Events, Sessions, Funnels, Flows, Retention or Accounts.

3. Click **Add a filter**, or **Add** when the filter already has conditions.

4. Choose a field. To find it, type in **Filter by …**.

5. Choose an operator, such as **is** or **contains**.

6. Click the value part of the condition.

   Result: A list shows values that your project has sent for that field.

7. Pick one, or type a value.

8. Press Enter, or click outside the condition.

Result: The view counts again with the new filter. A condition without a value changes nothing.

| Page | Where the filter bar is |
|---|---|
| Workbench › Sessions | What happened in the session |
| Workbench › Accounts | What they did |
| Workbench › Funnels | Each step has its own bar |
| Workbench › Flows | Click a step to show its bar |
| Workbench › Retention | Start has a bar. Return has a bar after you choose A specific event |

On People, from 2 November 2026, the bar is one line under the chips and the search box, with Saved filters, the window, the order and Hide our team. See [Find the people who did something](/docs/users-and-accounts#find-the-people-who-did-something).

- With two or more conditions or groups, a button at the start of the bar says "All of" or "Any of". Click it to switch. This button combines the conditions and groups at the top.
- To remove a condition, click its ×.
- Clear removes every condition and group. It shows only when the bar has a condition or a group.

To clear a filter that has a group:

1. Click **Clear**.

   Result: Clear first asks "Clear every condition and group?".

2. Click **Clear all** to clear it, or **Keep**.

### The sentence under the bar

Under the bar, the filter shows as one sentence, such as "Events from Germany where event is signup_viewed." If a condition is not finished, the sentence says that it is left out until finished. If Sequential refuses the filter, the reason shows under the bar.

## How a filter matches

A filter is a set of conditions. Each condition is one field, an operator and a value.

- Conditions apply to the same event. Event type is `click` AND URL is your pricing page means clicks on the pricing page. For "did A, then B", use [Funnels](/docs/funnels).
- On Workbench › Sessions and Accounts, and on People, each condition can match a different event. But each condition still tests one event at a time.
- On a field, such as Browser or URL, the operator "is" matches one whole value.
- On a field, the operator "is not" also drops events with no value in the field it tests. On a property, it also matches events without the property. For the exceptions, see [How do negative conditions work?](#how-do-negative-conditions-work).
- Sequential ignores a condition that is not finished. A condition needs a value, except with these operators: is set, is not set, is true and is false. A property condition also needs a name. The sentence under the bar names each condition that it leaves out.

### What the filter does on each page

| Page | What the filter does |
|---|---|
| Workbench › Events | The page counts, charts and lists only the matching events |
| Workbench › Sessions | Each top-level condition is tested on its own. A session appears when, for each condition, at least one of its events matches that condition. Two conditions can match different events. A top-level negative condition keeps the sessions that have no event where the positive condition holds: "A top-level “Is not” finds the sessions without one." An All of or Any of group needs one event that matches the whole group. In such a group, a negative condition tests that same event. None of keeps the sessions that have no event for any of its conditions. Not all of keeps the sessions that have no event for at least one of its conditions. From 9 October 2026, a session's counts and times cover all of its events in the range |
| Workbench › Accounts | What they did lists the accounts that sent a matching event in the range |
| People | Each top-level condition is tested on its own. A person appears when, for each condition, at least one of their events in the window matches that condition. A top-level negative condition keeps the people who have no event where the positive condition holds: "A top-level “Is not” finds the people without one." An All of or Any of group needs one event that matches the whole group. None of and Not all of work as on Sessions. A person's row counts all of their events in the window |
| Workbench › Funnels, Flows | Each step has its own filter |
| Workbench › Retention | Start and Return each have their own conditions. With no Start condition, a cohort starts with a person's first event. With Any event, any event counts as a return |

### Fields and what they match

| Field | What it matches |
|---|---|
| Event type | The event's class by its id: `pageview`, `click`, `form_submit`, `identify`, `error`, `rage_click`, `dead_click`, `custom` or `system`. See [Events](/docs/events). From 3 November 2026, the app and the API also read the names that the Sequential SDK sends, `$pageview`, `$click`, `$form_submit`, `$deadclick` and `$rageclick`, as their class. Event still matches the name as it was sent |
| Source | Where an event came from: your website or app (the Sequential SDK), your server (the backend SDK), or a tool that you connected, such as PostHog, Mixpanel, Amplitude, Pendo or Smartlook. Another source shows as it was sent. From 3 November 2026, Source is in the list of fields, after Event type. Its operators are "is", "is not", "is one of" and "is none of". The values show your website or app and your server first, then the other sources in the events of your project. A link can also set it: All N events on a person's page adds "source is your server", as a condition that you can remove |
| Event | The name the SDK sent, such as your custom event names |
| Session id | The session id stored on the event |
| Person id | The person. With the Sequential SDK, PostHog or Mixpanel, your own id also finds the events sent before your app called `identify`. See [How does a Person id condition match?](#how-does-a-person-id-condition-match) |
| Account id | Pendo data, and Sequential SDK events after `sequential.account()` |
| URL | The whole stored address. Sequential stores query values as `[redacted]`, unless the parameter is a campaign or ad-click parameter, such as `utm_source` or `gclid`. It does not keep the `#…` part, except a hash route, such as `#/orders`, from 9 October 2026. Pick the value from the list. Do not type it. Empty for Amplitude events. See [What Sequential keeps from page URLs](/docs/url-policy) |
| Page | The path of the URL, as Workbench › Heatmaps groups pages: no host, no query and no `#…` part, without a slash at the end, and numbers, UUIDs and long hex ids read `:id`. For example, `/orders/:id` matches `/orders/123?tab=2`. From 6 November 2026, for a mobile app event with no URL, it is the page of its screen, for example `/Checkout`. See [Screens are pages](/docs/mobile#screens-are-pages) |
| Referrer | The page the person came from (the referrer). Empty for Amplitude events |
| Element | The clicked element, by its CSS selector. Empty for PostHog, Mixpanel and Amplitude events |
| Country, Operating system, Browser | Sequential finds these from the request: a two-letter country code such as `DE`, the operating system, the browser |
| Platform | The website or the app: `web`, `ios`, `android` or `other`. Safari on an iPhone is `web`, and the iOS app is `ios`. An app view that shows a web page is also `web`. The field suggests only these four values, and Sequential refuses any other value |
| Visitor property, Account property | A property by its name, a type, an operator and a value. Account properties come from Pendo and from `sequential.account()`. Mixpanel and Smartlook send visitor properties only on their profile (identify) events. So a condition finds those events, not the person's other events. PostHog and Sequential SDK events carry none |
| Event property | One of the event's own properties: its name, a type, an operator and a value. See [Property conditions](#property-conditions) |
| Entry page, Exit page | On Workbench › Sessions only: the first or the last page of each session in the window. See Property values |

Property values:

- For "is one of" and "is none of", type the values with commas between them, or pick them one at a time. For "is between", type the low value and the high value in the two fields. Both values count as a match. For "is in the last", type a number of days.
- Number also matches a number that your SDK sent as text, such as "9.99". Date also matches text that starts with a date, such as `2026-10-09`. True or false also matches the text `true` or `false`.
- `$utm_source`, `$utm_medium`, `$utm_campaign`, `$utm_term` and `$utm_content` are the campaign tags of the page address. `$release` is the release of the event. These event properties take Text operators only. The operator "is not set" finds the events without the tag or the release. When your project has a value for them in the last 30 days, the Property name list shows these names first, and the value list suggests their values. To break down by them, see [Break down by a field or a property](/docs/events-explorer).
- If Sequential cannot read a "matches regex" pattern, it refuses the filter with "A regex pattern in the filter is not valid".
- On Workbench › Sessions only, Entry page and Exit page test one value of each session: the first or the last page in the window. Choose "is", "starts with" or "contains", and type a page path, for example `/pricing`. The path is the route, like `/invoices/:id`. Only page views count. If the window ends while a session continues, its exit page can be a page in the middle of the session.
- From 8 November 2026, these filters use the words of the project. In a project with only an app, they say "Entry screen" and "Exit screen", and the hint says "The screen’s page, like /Checkout: its name after a slash. The entry screen is the first screen they saw, the exit screen the last." In a project with a website and an app, they say "Entry page or screen" and "Exit page or screen". A website project keeps "Entry page" and "Exit page". See [Screens are pages](/docs/mobile#screens-are-pages).

## Property conditions

Event property, Visitor property and Account property conditions have a name, a type and an operator. Choose the type in the menu after the name. For value lists, campaign tags and the entry and exit page, see [Fields and what they match](#fields-and-what-they-match).

| Type | Operators |
|---|---|
| Text | is, is not, is one of, is none of, contains, does not contain, starts with, ends with, matches regex, is set, is not set |
| Number | is, is not, is more than, is at least, is less than, is at most, is between, is one of, is none of, is set, is not set |
| True or false | is true, is false, is, is not, is set, is not set |
| Date | is in the last, is after, is on or after, is before, is on or before, is between, is, is not, is set, is not set |

- Four operators also match events that do not have the property: is not, is none of, does not contain and is not set. The other operators never match an event without the property.
- For the limits on property conditions, see [Limits](#limits).

Upper and lower case:

| Condition | is | contains, starts with, ends with | Pattern operator |
|---|---|---|---|
| On a field | Matches one whole value | Respect upper and lower case, except on Operating system | matches pattern: respects upper and lower case, except on Operating system. `*` stands for any text and `?` stands for one character |
| On a Text property | Matches the exact text of the whole value | Ignore upper and lower case | matches regex |

From 12 October 2026, Operating system ignores upper and lower case: `Android` also matches `android`.

## Groups

On Workbench › Sessions and Events, and on People, a filter can have groups. A group combines its own conditions and groups. On Funnels, Flows, Retention and Accounts, a filter has no groups.

1. Add a first condition.

   Result: The buttons All of group, Any of group and None of group show under the bar.

2. Click one of them.

   Result: An empty group shows under the bar.

3. In the group, click **Condition**.

4. Set the condition as in the bar.

5. In the menu at the top of the group, choose how the group combines its items.

| Menu | What the group does |
|---|---|
| All of | Every item must match |
| Any of | One item is enough |
| None of | Leaves out what matches any of its items: NOT (a OR b) |
| Not all of | Leaves out only what matches all of its items together: NOT (a AND b). With one item, None of and Not all of are the same |

On Workbench › Sessions and on People, see [What the filter does on each page](#what-the-filter-does-on-each-page).

- A group can have its own groups, at most 4 levels deep. A filter has at most 20 groups. At a limit, the buttons that add a group do not show.
- The sentence under the bar shows each group in brackets, for example "(a or b)", "none of (a, b)" or "not all of (a, b)".
- To move, fold or remove a group, see [How do I move, fold or remove a group?](#how-do-i-move-fold-or-remove-a-group).

## Past filters

On Workbench › Sessions and Events, and on People, Past filters lists your own last filters on that page, newest first.

1. Click **Past filters**.

2. Click a filter in the list.

   Result: It replaces the filter in the bar.

- The list is yours only. Nobody else in the project can read it, admins included. Viewers keep their own list too. The list says "Only you see this list."
- Sequential keeps the list on its server, for each person and project. When you switch projects, the list of that project shows. See [Privacy overview](/docs/privacy-overview).
- How a filter gets into the list: see [How does a filter get into Past filters?](#how-does-a-filter-get-into-past-filters).

## Choose the window

The window is the date range of a view. Each Workbench view has its own window of days. With no view in the address, each view opens on its default.

| View | Choices | Default |
|---|---|---|
| Events | Window: Last 24 hours, Last 7 days, Last 14 days, Last 30 days, Last 90 days, Pick days… | Last 7 days |
| Sessions, Flows, Retention | Window: 7 days, 14 days, 30 days, 90 days, Custom | Sessions 7 days, Flows 14 days, Retention 30 days |
| Funnels | Dates: 7 days, 14 days, 30 days, 90 days, Custom | 30 days |
| Accounts | 7 days, 30 days, 90 days | 7 days |
| Heatmaps | 7 days, 14 days, 30 days | 7 days |

- Days are UTC. There is no time-zone setting. Days, chart buckets and retention days run midnight to midnight UTC.
- A window of days is the last days in UTC, today included. Last 24 hours on Events is the 24 hours up to now.
- When you open another Workbench view, it uses its own window.
- The Matching events list on Workbench › Events and the table on Workbench › Sessions show local times. See [Why does a time on screen not match the UTC day?](#why-does-a-time-on-screen-not-match-the-utc-day).

### Window controls on each page

On Workbench › Events, Window holds the choices. Pick days… shows two dates: First day and Last day. You cannot pick a day after today. On Sessions, Flows and Retention, Window has chips and Custom. On Funnels, the same chips are under Dates. Custom shows two dates. There is no Apply button. A valid window applies at once.

The window includes the whole last day. Workbench › Events (a window of days), Sessions, Funnels, Flows, Retention and Heatmaps include the last day up to midnight UTC.

| Page | When the dates are not valid |
|---|---|
| Events | The page says "Pick both days.", "The first day comes before the last." or "Pick at most two years.", and nothing changes |
| Sessions, Funnels, Flows, Retention | The page says "Write both days as a date." or "The first day must not be after the last day.", and nothing changes. A window has 1 to 3,650 days |

Every on Events sets the chart's buckets: Hour, Day or Week. Hour works for a window of 14 days or less. A week starts on Monday, in UTC.

- The address holds the window. When you change the window, Sequential writes it into the address with the rest of the view. So a reload or a copied link keeps it. A window such as the last 7 days stays the last 7 days on a later day.
- A new window counts again. The view runs again a short time after you change the window or the filter.

## Save and open views

Owners, admins and members can save, rename and delete any saved view, also one that someone else saved.

Workbench › Events, Sessions, Funnels, Flows and Retention, and [People](/docs/users-and-accounts), each have a card of saved views. On People, Saved filters is a menu in the filter bar. Events, Sessions and People share one list of saved filters.

> **Everyone in the project sees saved items**
>
> - Everyone in the project sees the same saved items, in every browser and on every device.
> - A saved view can hold values such as person ids, email addresses or property values. Everyone in the project can see them.
> - If you delete the project, Sequential deletes its saved items too.

### Save a view

1. Set the view on the page.

2. Find the card of saved views, such as Saved filters.

3. In the card, type a name.

4. Click the button of the card: Save this filter, Save this flow or Save this retention view. On Funnels, click Save, or click Save as a view at the top of the page.

Result: The page says `Saved “Checkout” for everyone on this project.`

A name has at most 200 characters. With no name, Sequential names the view in words: the filter as a sentence, the steps, or the retention question.

### Cards and names of saved views

The cards are Saved filters, Saved funnels, Saved flows and Saved retention views. Each card says "Shared with everyone on this project". It lists the project's saved views of that kind, in the order of their names. Each project has its own saved items. A saved funnel runs on its own project. On a Workbench page, hold the pointer on the name of a saved view. It shows who saved it last, and when.

- Each name must be unique within its kind in the project. Capital letters do not make a name different: "Checkout" and "checkout" are the same name.
- From 3 November 2026, a funnel with no name gets its first and last step and the number of steps, such as "signup_viewed → checkout_started · 2 steps", in at most 48 characters. A page step is the last part of its path.
- If you type a name that the project has already, Sequential refuses it. The card says, for example, "A saved filter with that name is already in this project. Pick another name."
- If the name that Sequential makes is taken, Sequential adds a number: "(2)". This is so on every page, Funnels too. The message names the name that Sequential saved.
- A saved filter needs at least one condition. A saved flow needs a step. A saved funnel needs finished steps. If a part is missing, the card says what to do, for example "Finish the steps first, then save."

### What each saved item keeps

| To save | Click | What it keeps |
|---|---|---|
| A filter on Workbench › Events | Save this filter under Saved filters (needs a condition) | The filter and Break down by, not Then by or the window |
| A filter on Workbench › Sessions | Save this filter under Saved filters (needs a condition) | What happened in the session only |
| A filter on People | Save… in the bar, then Save this filter in the Saved filters menu (needs a condition) | What they did only. The menu says "A saved filter keeps what they did. Opening one leaves the window, the order and the team as they are." |
| A flow | Save this flow under Saved flows on Workbench › Flows (needs a step) | The steps, the columns, the paths and the window, not the followed step |
| A retention view | Save this retention view under Saved retention views on Workbench › Retention | The start and return events, the days, the cohort, the grouping and the window |
| A funnel | Save as a view or Save on Workbench › Funnels (needs finished steps) | The steps and their filters, the conversion window, the breakdown and Your team, not the dates |
| A sessions search | Save to Board on Workbench › Sessions | The search and its window |
| A funnel or retention answer from Ask | Keep on board under the answer in Ask | The answer. See [Ask](/docs/ask) |

Saved funnels and saved filters use the dates on the page.

### Open, rename or delete a saved view

To open a saved view, click its name in the card. The page says `Opened “Checkout”.` The card marks the view that is open.

To rename a saved view:

1. Click the pencil button beside its name.

2. Type the new name.

3. Click **Save name**, or press Enter.

   Result: The page says `Renamed to “Checkout”.`

To stop, click Cancel or press Escape.

To delete a saved view:

1. Click the × beside its name.

   Result: Sequential deletes it at once, for everyone in the project. The page says `Deleted “Checkout”.` with Undo.

2. To save the view again in its project, click **Undo**.

   Result: If the project has that name again, the view comes back as "Checkout (2)". The message stays for 7 seconds.

### What opens on each page, and how to change or pin a saved funnel

What opens on each page:

- On Events, the filter and Break down by open. If the view has no group-by, the page keeps its own. If the Workbench cannot group by the field of the view, the filter opens without a group-by, and the card says so.
- On Sessions, the filter opens in What happened in the session. Each top-level condition can then match a different event of the session. The other filters of the page are cleared. The window, the order and Hide our team stay. The card says "A saved filter keeps what happened in the session. Opening one clears the other filters (country, person, problems and the rest)."
- On Funnels, the steps, the conversion window, the breakdown and Your team open. The dates stay as they are on the page.
- On Flows, the steps open. The columns, the paths and the window open too when the view keeps them.
- On Retention, the start and return events, the days, the cohort and the grouping open. The window opens too when the view keeps it.

A view that the page cannot read stays in the list. Its name does not open, and the card says why, for example "Cannot open here: This view uses a filter the Workbench cannot read yet." A saved retention view that keeps only some people (a segment) opens with that filter. If the Workbench cannot read it, it says "The segment of this view uses a filter the Workbench cannot read yet." You can rename or delete such a view.

Change a saved funnel: open it and change it. The button at the top then says Save changes. Click it to save the changes for everyone. The page says `Saved the changes to “Checkout”.` If you type another name, the funnel saves as a new item. If the page then shows another funnel, for example from a link, no saved funnel is open. The button says Save as a view, and a save makes a new item. It never changes the funnel that you opened before. On the other pages, a save always makes a new item.

On Funnels, one save runs at a time. A save that runs while you go to another funnel, open another saved funnel or delete the open one still completes. The card lists the new item, but the page does not open it. A save that runs while you change project still completes in the first project. The page then shows no message about it.

Pin: on Saved funnels, owners, admins and members can also pin one funnel to the Simple view. Click the pin button beside its name. Its tooltip says Pin to the Simple view. The page says "Pinned: the Simple view shows this funnel." Everyone sees On the Simple view with the pinned funnel. A pin unpins the funnel that was pinned before. It does not change the saved funnel. Click the button again to unpin it. See [Simple view](/docs/simple-view).

Viewers see the cards and open the views. They have no save, rename, delete or pin button. The card says, for example, "Viewers can open the project’s saved filters but not save, rename or delete them." On Funnels, viewers have no Save as a view button and no `s` key. These buttons show only after Sequential has read your role.

## The Board

The Board shows the project's saved funnels, retention answers and sessions searches. It asks each one again when you open it. Saved filters and saved flows do not show on the Board. Open them on their Workbench page.

To save a sessions search to the Board:

1. On Workbench › Sessions, set the search.

2. Click **Save to Board**.

Result: The page says, for example, `Saved to the Board as “Sessions in the last 7 days where they had an event (event is checkout_started)”. Everyone on the project sees it there.` The name is the search in words. If the project has that name already, Sequential adds a number: "(2)".

To rename or remove a saved sessions search, open the Board in the left rail. When you remove an item that the project keeps, Sequential deletes it for everyone in the project.

### How the Board shows saved items

- The Board shows a saved funnel only when each step is one event or one page. It names the other saved views in one line, for example: "One saved view in this project uses filters the Board cannot run yet: “Checkout”. It stays in the project, untouched."
- A search card shows how many sessions match and the first 3 sessions. Open in Workbench opens the search on Workbench › Sessions. Run again runs it again.
- A funnel or retention card has Open in Ask and Ask again.
- Each card on the Board shows who changed the item last, and the day. Hover over it to see the whole line, for example "Saved 26 Oct by Ana, with the project."
- Rename renames an item for everyone on the project. Remove removes it. Viewers cannot rename or remove the project's items. The message then says, for example, "Viewers can read the project’s saved answers but not remove them."
- The order of the cards is yours. Sequential keeps it in this browser.
- The Board reads the project's saved views when you first open it. To see the latest changes of your teammates, reload the page.
- If the list does not load, the Board says why. Click Try again.
- When you remove an item that the project keeps, the message "Removed from the project, for everyone on it." shows with Undo. Click Undo to save the item again. The message stays for 7 seconds.
- If you open another project before you click Undo, Sequential puts nothing back. It says "The open project changed, so nothing was put back."

## Share a view by link

To show someone a view without saving it, send the page address (URL). Every Workbench view takes its whole view from it.

- The address holds the whole view. The filter, the window and the other settings are in the `q=` part of the address. Copy link copies it.
- Pages do not add the project to a link. Ask the reader to select the same project first. Or add `project=` and the project id to the address. The reader must be able to open that project. See [Links that open a project](/docs/sessions-and-replay#links-that-open-a-project).
- Workbench › Accounts and Heatmaps cannot save a view. To keep one, bookmark its address.
- The address of People does not keep the filter. Save it under Saved filters to keep it.

### What each address can carry

To share a filter, flow, funnel, retention view or sessions search with everyone in the project, save it. To share a view with someone outside the project, send its steps or the sentence under the bar. They can then build it again.

| Page | What the address can carry |
|---|---|
| Workbench › Events | The filter, the window, the interval, the count, Break down by, Then by, the compare, a changed Leave out your team, and a compared point while its reasons are open |
| Workbench › Sessions | The whole search, with its window and its order |
| Workbench › Funnels | The steps, the dates, the conversion window, the breakdown and Your team |
| Workbench › Flows | The steps, the columns, the paths, the followed step and the window |
| Workbench › Retention | The start and return events, the days, the cohort and the window |
| Workbench › Accounts | The range, the plan, the health, the search and What they did |
| Workbench › Heatmaps | The page, the device, the window and the element |
| People | The window (`?days=`) and an account (`?account_id=`), not the filter, the order or the chips |

- Each Workbench view keeps these in the `q=` part of its address. On Workbench › Events, a compared point is in `point=` and `why=1`, outside `q=`. See [Compare a point with the usual day](/docs/events-explorer#compare-a-point-with-the-usual-day).
- On Workbench › Events, Funnels, Flows and Retention, a view can be too long for the address: more than 12,000 characters, for example a filter with many values. The page then says that the view "is too long for the address (more than 12,000 characters), so the address does not hold it": a reload, a link, or leaving the page and coming back opens a different view. Save it to keep it. On Events, saving keeps only the filter and its breakdown, and the page says so: the measure, the second breakdown, the dates, the interval, the comparison and the team switch are not saved with it. A viewer is told to ask someone who can save views. Copy link then copies nothing and says, for example, "This funnel is too long to share as a link. Save it, then share the saved view." A link with more than 16,000 characters in its view does not open: the page says that the link is too long and shows its usual view.
- An older address, for example `/events` or `/funnels`, opens the matching Workbench view. Its dates become the window.
- The link opens in the project that the reader has selected, unless the address has `project=`. The reader must belong to the organisation that owns the project. See [Organisations, projects and keys](/docs/organisations-and-projects).

## What it needs

- To filter your own events by Event, send them as custom events. See [Send custom events](/docs/custom-events).
- For Person id to hold your own ids, call `identify`. See [Identify your users](/docs/identify-users).
- Element, Account id and the properties depend on your SDK. Some fields are empty for some SDKs. See [What each SDK supports](/docs/support-matrix).
- A typed URL with query values does not match, because Sequential redacts query values. A `#…` part matches only when it is a hash route, such as `#/orders`. Pick the URL from the list.
- For Mixpanel and Smartlook, a Visitor property condition finds only identify events. PostHog and Sequential SDK events have no visitor properties.

### For agents

Agents can use the same property conditions in the filters of the analytics tools, except the entry and exit page of a session. Agents also have one condition that the app does not have: the first touch of a person. See [Measure a campaign](/docs/measure-a-campaign#agents). They cannot use an identity property, such as `email`. On an element-text property, such as `$el_text`, they can use only "is set" and "is not set".

## FAQ

### What questions can a filter answer?

Use the window and the filter bar for questions like these:

- Which errors happened on the checkout page last week, outside Safari?
- Which sessions this month included a `plan_changed` event?
- What did people from Germany on iOS do on Monday?

Event type is `click` AND URL is your pricing page does not mean people who clicked something and also viewed pricing.

### How do I move, fold or remove a group?

- The arrows move a group, or a condition in a group, up or down. The button with the tooltip Move out of the group moves a condition to the level above. The × with the tooltip Remove the group removes the group with all that it holds.
- To fold a group, click its Hide button, such as Hide (3 filters). The button then says Show (3 filters).

### How does a filter get into Past filters?

- The list holds up to 10 different filters for each page and project. Sequential removes older entries.
- A filter goes into the list when you build it and it stays the same for 4 seconds. A filter that opens from a link is not added.
- Each filter in the list shows as its sentence. Press Escape to close the list.
- With no entry yet, the list says "No past filters yet: a filter you keep for a few seconds is added here." If Sequential cannot read the list, it says "Your past filters could not be read."

### How do negative conditions work?

- There are four negative operators: is not, is none of, does not contain and is not set.
- On a field, three of them also leave out events with no value in the field they test: "is not", "is none of" and "does not contain". For example, Browser "is not" Safari drops events with no browser recorded.
- To leave out either of two values, use one "is none of" condition with both values.
- Account id "is not" … drops every event without an account id. Only Pendo and `sequential.account()` set one.
- Event type, Session id, Person id and property conditions do not have this behaviour.
- On Workbench › Sessions, a top-level negative condition leaves out sessions, not events. It lists the sessions that have no event where the positive condition holds. On People, it lists the people who have no event in the window where the positive condition holds. In an All of or Any of group, a negative condition tests the same event as the rest of the group.

### How does a Person id condition match?

With the Sequential SDK, PostHog or Mixpanel, identify sends a link from the anonymous id to the value that your app passes. A Person id condition uses that link.

- On Workbench › Events and Sessions, and in funnel, flow and retention steps, the condition finds the whole person. The identified value finds the events from before identify too. A linked anonymous id finds the same person.
- A new link can take up to 5 minutes to apply.
- The link is one step. See [User ids and identity](/docs/users-and-identity).
- With Amplitude, Pendo or Smartlook, nothing sends the link. The condition matches the stored id.

For Person id, the operators work like this:

- "is" and "is one of" find each person.
- "contains", "starts with", "ends with" and "matches pattern" match the stored id or the identified value.
- "is set" and "is not set" match the stored id.
- In the `user_id` field of a request to the events API, an empty list matches no event. In a filter condition, an empty list has no effect.

### Which values does the value list show?

- The value list shows up to 50 values that your project has sent for that field, most frequent first.
- If no list opens, the project has sent no value for that field.
- The list covers all time, not only your window. As you type, it shows the values that start with your text first, then the values that contain it.
- For Event, the list shows the custom events of the last 30 days, each with its number of people.
- Property name and the property value suggest up to 100 values each. Values are suggested only for a Text property.

### Why does a time on screen not match the UTC day?

Times on screen are not always UTC.

- The Matching events list on Workbench › Events and the table on Workbench › Sessions show your local time. For example, a session starts at 23:30 UTC on 3 September. It belongs to that day's window. Two hours east of UTC, its time shows as 01:30 on 4 September.
- Dates and times use the language and the 12-hour or 24-hour clock of your browser, without seconds. For example, "14 Oct 2026, 21:51" or "Oct 14, 2026, 9:51 PM".

### What happens when two people change the same item?

- Sequential refuses Save changes on a funnel if someone else changed it after you opened it. The message says "Someone changed this view since you opened it. Open it again, then save."
- Sequential refuses a rename on a Workbench page if someone else changed the view after the list loaded. The card loads the list again and says, for example, "Someone changed this filter since the list loaded. The list now shows the latest; try again."
- Sequential refuses a rename on the Board if someone else changed the item after the Board loaded. The message says "Someone changed this saved view since the Board loaded. The Board now shows their version; rename it again if you still want to."
- If someone deleted the item, the message says "That view is no longer in this project." when you save changes on Funnels, "This filter is no longer in the project." in a card of saved views, or "It is no longer in this project. The Board is loaded again." on the Board.
- Sequential refuses a name that the project already has for that kind: "A saved funnel with that name is already in this project. Pick another name."
- A delete does not check for changes. It deletes the item, also when someone renamed it after you loaded the page.
- Undo saves the deleted item again as a new item. Its card then names you as the person who changed it last.

## Limits

- A filter can have at most 25 property conditions. Only one of them can use the operator "matches regex", with a pattern of at most 256 bytes.
- The operator "is one of" takes at most 1,000 values. A property name has at most 128 bytes. The operator "is in the last" takes 1 to 3,650 days. Sequential refuses a filter over a limit and runs nothing.
- On Workbench › Sessions, Sequential checks at most 5 conditions on what happened, the entry or exit page and rage at an element together. On People, Sequential checks at most 5 conditions on what people did together. Over 5, the People list waits until the filter fits. See [People and accounts](/docs/users-and-accounts#find-the-people-who-did-something).
- On Sessions and on People, an All of or Any of group counts as one. The items of a None of or Not all of group count one by one.
- On Workbench › Sessions and Events, and on People, a filter has at most 20 groups, up to 4 levels deep.

For the limits of a saved item, see [Limits › Saved views](/docs/limits#saved-views).

## Next steps

- [Workbench › Events](/docs/events-explorer): count events, break them down and compare days.
- [Funnels](/docs/funnels): see where people leave a series of steps.
- [Flows](/docs/flows): see the paths people take between events.
- [Retention](/docs/retention): see if people come back.
- [Find and replay sessions](/docs/sessions-and-replay): find a session and watch its recording.
- [People and accounts](/docs/users-and-accounts): find the people who did something.
- [Events](/docs/events): the event classes that Event type matches.
