# Workbench › Events: count what happened

> Workbench › Events counts the events your project receives, or the people who sent them, over time.

> **At a glance**
>
> - **For:** Counts of events or people over time. For ordered steps, paths or returning people, use [Funnels](/docs/funnels), [Flows](/docs/flows) or [Retention](/docs/retention).
> - **Who can:** Every role can use it, viewers included.
> - **Before you start:** Events from a supported SDK. See [What it needs](#what-it-needs).
> - **Default:** The last 7 days, today included, counted every day, with no filter and no breakdown. Days and weeks are in UTC. A week starts on Monday.
> - **Takes effect:** At once, after each change. There is no Run button.
> - **Know this:** Each condition tests one event at a time. So Event type is `click` AND Page is `/pricing` means clicks on the pricing page, not people who did both.
> - **Know this:** With Count on Events, Every on Day or Hour and no breakdown, click a point on the chart to compare it with its usual value. No sentence names a cause.

## Count people who used a feature

1. In the rail, go to **Workbench › Events**.

2. In **Window**, choose a period, or **Pick days…** for exact days: for last week, First day is last Monday and Last day is last Sunday.

3. Click **Add a filter**.

4. Choose **Event**.

5. Type or choose the event name, such as `export_started`.

   Result: Sequential suggests the names your project sends, with their people counts.

6. Press Enter.

   Result: The page counts again. The field menu opens for a next condition. Press Esc to close it.

7. Under **Count**, click **People**.

Result: The headline at the top gives the number of people.

With Count set to Events, the headline gives the events. The scope line under it gives the people who sent them. Every sets the interval: Hour, Day or Week.

To count a page instead, choose Page and type its route, such as `/invoices/:id`.

People are the distinct person ids of the events counted. People counts only the events that have a person id. An event without a person id counts as an event, never as a person.

When your app calls `identify`, Sequential links the visitor's anonymous id to the person. The People count then counts that visitor once. Events that your server sends count too. See [User ids and identity](/docs/users-and-identity).

### Window and interval

A window of days runs from 00:00 UTC of the first day to the end of the last day, in UTC. Last 24 hours is different: it is the 24 hours up to now.

- Window has Last 24 hours, Last 7 days, Last 14 days, Last 30 days, Last 90 days and Pick days….
- Last 7 days is the last 7 UTC days, today included, up to now. With no view in the address, the page opens on the last 7 days, today included, up to now.
- Pick days… shows two dates: First day and Last day. You cannot choose a day after today. If a day is missing, the page says "Pick both days." If the first day is after the last day, it says "The first day comes before the last." The window has at most two years ("Pick at most two years.").
- Days, weeks and hours are in UTC.
- Hour works only for a window of 14 days or less. For a longer window, Hour is not available. A link that asks for hours on a longer window counts days and says "Hours work for 14 days or less, so this counts days."
- A week starts on Monday at 00:00 UTC. The chart names it "Week of" and its first day.
- If your computer clock is not in UTC, a note under the chart says that each day or week is in UTC. The events in the list show your own time. So an event near midnight can be on the day before or after.

### Build a filter

Add a filter opens a menu. Type to narrow it, use the arrow keys to move, and press Enter to choose. The menu has these groups:

| Group | Fields |
|---|---|
| Event | Event, Event type, Page, URL, Element, Referrer |
| Place and device | Country, Browser, Operating system, Platform |
| Ids | Person id, Account id, Session id |
| Properties | Event property …, Visitor property …, Account property … |

When you type, the menu also shows the property names that your project sends.

Each condition has a field, an operator and a value. For a property, it also has a name and a type: Text, Number, True or false or Date.

- For a field, the operators are is, is not, is one of, is none of, contains, does not contain, starts with, ends with, matches pattern, is set and is not set. On Person id, they read "is set (anonymous too)" and "is not set": an anonymous visitor has an id too. On Session id, they read "is set (in a session)" and "is not set (not in a session)". The filter on Workbench › Sessions has no is set or is not set for Session id. If a link brings such a condition to Sessions, its chip shows the operator as text, with the reason "This page's menu does not offer this operator. Remove the condition to change it." The condition still applies.
- Platform takes is, is not, is one of and is none of, with `web`, `ios`, `android` or `other`.
- A Text property also takes matches regex. A Number property takes is more than, is at least, is less than, is at most and is between. A True or false property takes is true and is false. A Date property takes is in the last, is after, is on or after, is before, is on or before and is between.

With two or more conditions or groups, a button at the start says All of or Any of. Click it to switch. Clear removes every condition and group. When the filter has a group, it first asks "Clear every condition and group?".

After the first condition, All of group, Any of group and None of group show under the bar. Each adds a group. A group can also be Not all of. See [Groups](/docs/filters-and-saved-views#groups).

Past filters lists up to 10 of your own filters on this page, newest first. Click one to use it again. Only you see the list. See [Past filters](/docs/filters-and-saved-views#past-filters).

Under the bar, the filter shows as a sentence, such as "Events from Germany where event is signup_viewed." An unfinished condition is not used. The sentence says which conditions it leaves out.

When you write a value, Sequential suggests the values that your project sends. For a property, it suggests values only for the Text type.

- is is an exact match. Operating system ignores upper and lower case.
- For a field, contains, starts with, ends with and matches pattern respect upper and lower case, except for Operating system. For a property, contains, starts with and ends with ignore case.
- A negative property operator, such as is not, also matches events that do not have the property.
- Person id with an anonymous id finds all the events of that person.

For Event type, type the stored value: `pageview`, `click`, `rage_click`, `dead_click`, `form_submit`, `error`, `identify`, `custom` or `system`. Sequential suggests these values.

Sequential tests each condition against one event at a time. So Event type is `click` AND Page is `/pricing` means clicks on the pricing page. It does not mean people who clicked anywhere and also visited the pricing page.

## Find pages with errors

The JavaScript errors in a replay are not events, so they do not show here. See [DevTools in replays](/docs/devtools).

1. Click **Add a filter**.

2. Choose **Event type**.

3. Type `error`, then press Enter.

4. In **Break down by**, choose **Page**.

   Result: The table shows each page with its errors and its Share of all the errors. In the table, the row with the most errors comes first.

5. To keep only one page, click **Only this** in its row.

   Result: The page goes into the filter, and the breakdown goes back to **Nothing**. Matching events shows each error with its message.

6. To see if most errors come from one browser, set **Break down by** to **Browser** now.

7. To watch the sessions with such an error, click **Sessions** in a row instead.

   Result: Workbench › Sessions opens with the same days.

## Break down a count

1. In **Break down by**, choose a field, such as **Country**.

   Result: A ranked table shows each value. Its heading names the field, such as By country.

2. To split each value by a second field, choose it in **Then by**.

   Result: In the table, each value of the first level opens to its values of the second field.

3. To watch the sessions of a value, click **Sessions** in its row.

4. To keep only one value, click **Only this** in its row.

   Result: The value goes into the filter. Then by becomes Break down by. Without Then by, Break down by goes back to **Nothing**.

In Break down by, the First touch (person) choices, such as First campaign source, credit each person who did the counted events to one value. The First touch (account) choices credit each account. A first touch counts people (or accounts), not events. See [Measure a campaign](/docs/measure-a-campaign).

### Break down by a field or a property

Break down by has Nothing and these groups:

| Group | Choices |
|---|---|
| What happened | Event, Page, Element |
| Where they came from | Referrer, Traffic source |
| Place and device | Country, Browser, Operating system, Platform |
| Who | Person, Account, Session |
| First touch (person) | First campaign source, First campaign medium, First campaign name, Last campaign before converting, First visit source, Landing page |
| First touch (account) | The same six, each with Account at the start, such as Account first campaign name |
| Properties | Event property…, Visitor property…, Account property… |

- Event lists every event name with its counts.
- Country shows the name of the country.
- Platform shows Website, iOS app, Android app or Other.
- Traffic source is the other site that a visit came from. A visit with no referrer, or from a page of the same site, is in Direct or internal.
- Person, Account and Session show one row for each id.
- Page is the route of the URL, without the host and the query. Parts that look like ids show as `:id`. So one page with different ids is one row.
- Errors sent without a URL are in the row (empty).
- The two First touch groups show only when the Sequential server offers them.
- For a property, choose its family. Then type the property name, or choose one of the names that your project sends. Press Enter or leave the field. A name has at most 128 bytes.
- After you choose Break down by, Then by shows. It splits each value by a second field.

The event properties `$utm_source`, `$utm_medium`, `$utm_campaign`, `$utm_term` and `$utm_content` read the campaign values that Sequential keeps from the page address. `$release` reads the release that your SDK sent. A `utm_source` property that you send yourself is a different property.

The breakdown table. The heading names the field, such as By country. With Then by, it names both fields, such as By country, then by browser. Each row shows:

- its rank and the value;
- Events (or People, when you count people);
- Share: a bar and the percent of all the events (or people) in the window;
- People (or Events);
- with Compare, the count in the period before and Change, such as "+12.5%", "−5%", "same" or "new";
- Sessions and Only this.

A first-touch table shows People (or Accounts) and a Share bar only. Its rows have no Sessions and no Only this.

The breakdown has at most two levels. It reads the top 1,000 values, and with Then by the top 1,000 pairs.

The table shows the first 20 rows. Click Show all and the number of rows to see the others. Click Show the first 20 to go back. Sequential reads the top 1,000 values. When there are more, a line says "The list stops at 1,000 values; there are 2,345 in all."

When you count people, one person can have several values. So the shares can add up to more than 100%.

In the breakdown table, some rows do not show a plain value:

| The row reads | It counts |
|---|---|
| (not set) | The events that do not have the property. Its Only this adds the condition is not set. |
| (empty) | The events with an empty value. This row has no Only this. |
| (no id) | Person, Account or Session: the events without that id. This row has no Only this. |
| Direct or internal | Traffic source: the visits with no referrer, or from a page of the same site. |
| (no website visit) | A first touch: the people (or accounts) with no website visit before the conversion. |

Only this adds the value of the row to the filter as is. Then the grouping moves down one level: Then by becomes Break down by. Without Then by, Break down by goes back to Nothing. In a row of the second level, Only this adds the values of both levels, and Break down by goes back to Nothing. Traffic source rows and (no id) rows have no Only this, because the filter cannot say them. When the filter is Any of with two or more conditions or groups, Only this cannot add the value. A message tells you to switch the filter to All of first.

Then by:

- Then by shows after you choose Break down by. It does not offer the choice of the first level.
- A field or a property pairs with any other field or property. A first touch pairs only with a first touch of the same kind: a person with a person, an account with an account.
- If you type the property of the first level again, the page says "That property is already the first level. Name another one."
- When you change Break down by, Then by stays only when the two still pair.
- In the table, the first value of the first level is open. Click a value to open or close it.
- Under each value, the table shows the first 10 values. Click the button such as Show all 14 under Germany to see the others. Click Show the first 10 to go back.
- A value without a value of the second field says "No value of … here."
- Sequential reads the top 1,000 pairs. When there are more, a line says "Some values of … are not listed: the list stops at 1,000 pairs."

First touch:

- The filter and the window select the conversions. Each person counts one time, at their first matching event in the window.
- Then Sequential reads the person's visits before that event, in all the data that it keeps for the project.
- The table counts People (or Accounts). The Share is of all the people (or accounts) that it credits.
- Under the table, a line says "Credited to each person's first touch since" and a date. The date is the first day of the data that Sequential still keeps.
- When Sequential cannot confirm that it still keeps all the earlier data, a line says "Earlier visits may be missing from the data, so some first touches can be later visits."
- Leave out your team is ticked by default. See [Leave out your team](#leave-out-your-team).

If no event in the window has a value for the field, the page says so instead of the table.

## Compare with the period before

1. Under **Compare**, click **With the 7 days before**, or press c. The words follow the window, such as "the 24 hours before" or "the day before".

   Result: The headline adds the change, such as "up 12%", "the same as before" or "up from none". The scope line adds, for example, "Compared with the 7 days before".

- The period before has the same length and ends just before the window starts.
- Without a breakdown, the chart shows the period before as a second line. With a breakdown, the table shows it in two more columns.

## Read the result

From 8 November 2026, a headline gives the answer first. A scope line is under it. Under them are the chart, the breakdown table and the newest matching events.

### Parts of the page

| Part | What it shows |
|---|---|
| Title | Events, with Copy link at the right |
| Filter bar | Add a filter, the conditions and Past filters. Under them, the groups and the filter as a sentence |
| Controls | Window, Every (Hour, Day, Week), Count (Events, People), Break down by, Then by (after Break down by), Compare and Your team |
| The answer | A headline with the number and, with a filter, the share of all events. Under it, a scope line with the window and How counted ▾, and a link to the sessions |
| Chart | The events or people per interval, with four totals above it. Show as a table shows the same numbers as a table |
| The comparison | Under the chart, after you click a day or an hour: that point against its usual value. See [Compare a point with the usual day](#compare-a-point-with-the-usual-day) |
| By … | Only with Break down by: a ranked table, such as By country |
| Matching events | The 50 newest matching events. Each one opens its session. Details in a row shows the event details |
| Saved filters | The saved filters of the project. See [Save and share a view](#save-and-share-a-view) |

If no events match, the page says "Nothing to count here" and "Widen the window, or take a condition out of the filter."

While Sequential counts, the last answer stays on the page, dimmed, with "Counting again…". After 4 seconds, the text changes to "Still counting. A long window over many events takes a while."

From 8 November 2026, the headline gives the number first. For example:

- Without a filter: "1,204 events".
- With a filter: "1,204 of 18,330 events (6.6%)". The second number is all the events in the same window.
- With Count set to People, the headline counts people, such as "312 of 2,140 people (14.6%)".
- With Compare, the headline adds the change, such as "1,204 events, up 12%". A change of less than 0.05% is "about the same as before".
- When nothing matches, the headline is "No event to count.". With Count set to People, it is "Nobody to count.".

The scope line under the headline has these parts, with "·" between them:

- "With this filter", when a filter narrows the count.
- The window, such as "Last 24 hours, rolling" or "7 calendar days to today". A window of days has whole UTC days, today included.
- With Count set to Events, the people who sent the events, such as "312 people".
- With Compare, the period before, such as "Compared with the 7 days before".

At the end of the scope line, "How counted ▾" shows the sentence that the page showed before, word for word. For example:

- Without a filter: "1,204 events happened in the last 7 days, by 312 people."
- With a filter: "Events where event is signup_viewed: 1,204 of 18,330 events (6.6%) in the last 7 days, by 312 people."
- With Compare, the sentence adds the change, such as "up 12.5% on the 7 days before (1,075)".

When the count is more than 0, "How counted ▾" also says how People here is different from the People page.

With Break down by, a second sentence names the largest value, such as "Chrome leads with 640 of 1,204 events (53.2%)." A first touch has no such sentence.

Numbers and percents follow the number format of your browser. A percent has at most one decimal.

If the period before, or the count of all events, fails, the main numbers still show. The headline then does not show that part. A line says "Part of the count is missing:" and names the part.

Events without a person id:

- When Count is People and some events have no person id, a line says how many, such as "84 of these events carry no person id, so no person is counted for them."

The chart:

- The chart has one point for each interval of the window. An interval without events shows 0. The chart draws nothing after now.
- With Count set to People, each point counts the people active in that interval. One person can be in several points.
- With Compare, a second line shows the period before, interval by interval.
- With Break down by and Count set to Events, the chart draws one line for each of the 4 largest values. A line named Everything else counts the events of all the other values. It shows only when they have events.
- With Break down by and Count set to People, the chart counts all the people. The table splits them by the value.
- With Break down by and Compare, the period before is in the table, not on the chart.
- With a first touch in Break down by, the chart has one line for all the events (or people). A note says "The chart counts all events; the table credits each person who did them to one value."
- The lines have different patterns, not different colours. The legend above the chart names them and gives each total.
- With two or more lines, each name in the legend is a button. Click it to hide or show that line. The scale follows the lines that show. When you point at an interval, its values leave out the hidden lines. If you hide every line, the chart says "Every line is hidden. Turn one on above to draw it."
- Above the legend are four totals: Events, Busiest day, Average per day and People. With Every set to Hour or Week, they say hour or week, such as Busiest hour. Under each total, a line says what it counts, such as "All matching events in the last 7 days".
- Busiest day and Average per day count events, also when Count is People. People counts the people with events in the window.
- Average per day uses only the complete days from the first day with events. A day that is still running is not in it. If the busiest day is still running, its line ends with "so far".
- Move the pointer over the chart to read the values of one interval. Or move to the chart with Tab and use the left and right arrow keys. Home and End go to the first and last interval. Page Up and Page Down move 7 intervals.
- When you point at an interval, a link Sessions, and the interval shows above the chart. It opens the sessions of that interval.
- Show as a table shows a row for each interval, a column for each line, and a Sessions link in each row. When the chart can compare, each row also has Compare this day or Compare this hour. When the chart has marks of changes, the table also has a Changes column. Show the chart goes back.

The list of matching events:

- The list holds the 50 newest matching events. Above it, a line says "The 50 newest of 1,204 matching events." When all of them fit, it says "All 12 matching events, newest first."
- Each row shows the time, the event as a short line, the path of its URL, and the country, browser and operating system.
- The short line says what happened, for example "Opened /invoices", "Sent a form", "Identified as" and the user id, or "Error:" with the message. A custom event shows its name.
- From 8 November 2026, each short line uses the words of its own event. An event from PostHog's iOS, Android, React Native or Flutter SDK says "Tapped …" for a tap, and "Unnamed screen" for a screen with no name. Every other event keeps the page words, also an event from a web page inside an app. See [Screens are pages](/docs/mobile#screens-are-pages).
- A row without a session id cannot open. Its Details button works.
- Details shows the details of the event. See [The event details](#the-event-details).
- With the keyboard, press j or k to move through the rows. Press Enter or o to open the session, p to open the person and d to see the event details. Press Esc to clear the selection. When Person or Details has the focus, Enter clicks that button.

## Compare a point with the usual day

Compare one day or one hour of the chart with its usual value. This works when Count is Events, Every is Day or Hour, and Break down by is Nothing.

1. Click a day or an hour on the chart.

   Result: The comparison opens under the chart.

   **If you use the keyboard or the table**

   Move to the chart with Tab, go to a day with the arrow keys and press Enter. Or, after Show as a table, click **Compare this day** or **Compare this hour** in a row. If you hide the main line in the legend, a click on the chart does not choose a point. Compare this day in the table still works.

2. Wait for the usual value.

   Result: The comparison adds it, such as "820 events, usual Tuesday 1,410 · −42%". For a day, the usual value is the average of the same weekday 7, 14, 21 and 28 days before, when Sequential holds 2 or more of these days.

3. To see what changed at the same time, click the button under the numbers, such as **Why did this drop?**.

   Result: The reasons open. They can show the pages with the largest change, their errors, and the cases, releases and recorded changes near that time.

4. Next to that button, click **Ask your agent about this day** or **Ask your agent about this hour**.

   Result: It gives your coding agent a prompt about this day or hour. See [Ask your agent](/docs/sessions-and-replay#ask-your-agent).

5. To watch the sessions behind the change, click the link at the bottom, such as Watch 312 sessions on /invoices.

6. To close the comparison, click **Close** or press Esc.

   Result: The focus goes back to where you chose the point.

For the messages of the comparison, see [When the comparison does not work](#when-the-comparison-does-not-work).

### What the comparison shows

Its title is the day, such as "Tue 14 Oct", or the day and the hour. First it shows the count of the chart, such as "820 events", and "Comparing with earlier days…". Then it adds the usual value.

The usual value:

- Day: the average of the same weekday 7, 14, 21 and 28 days before. Sequential uses it when it holds 2 or more of these days. The text then says, for example, "usual Tuesday 1,410".
- If not, the usual value is the average of the 6 days before, when Sequential holds 2 or more of them. The text then says, for example, "usual 1,200 (the 6 days before)".
- Hour: the average of the same hour on the 7 days before, when Sequential holds 2 or more of them. The text says, for example, "usual 64 (the same hour, 7 days before)".
- Sequential uses only the days that it holds in full. The number in the text counts the days that it used.
- A day or an hour that is still running counts only up to now. Each usual day counts up to the same time of its day or hour. The text then says "so far" and "by this time".
- Without 2 such days, there is no usual value. A line says why, such as "No usual value. Sequential holds data from 7 Oct only."
- A change under 10 % is "about the same". A word and a sign give the direction. A rise and a fall have the same colour.
- When the usual value is 0, there is no percent. The text then says "Sequential gives no percentage for a usual value of 0."
- A usual value under 10 has one decimal, such as 2.5.
- A day is a UTC day. An hour shows on the clock of your computer.
- The button says Why did this drop? or Why did this rise? only for a change of 10 % or more. Else it says What happened on this day? or What happened in this hour?.

The button under the usual value opens the reasons. Each part shows only when it has something to say:

- A headline, such as "Events fell 42% against the usual Tuesday (820, usual 1,410)." or "Events were about the same as the 6 days before (1,180, usual 1,200)."
- Lines about the same time. They can name the page with the largest change in the same direction, and the newest release. They can also name a page whose errors at least doubled, and up to 3 cases. Examples are "Most of the fall is on /invoices: 300, usual 900.", "Release 2.4.1 went out at 09:12 UTC the same day.", "Errors on /checkout (all sessions) rose 3×: 30, usual 10." and "Finding F-12 was open at that time."
- If Sequential holds only part of these days, a line says so, such as "Sequential holds data from 7 Oct only. Earlier days are left out."
- By page: a table with Page, Events, Usual and Change. It shows the 5 pages with the largest change, then All other pages. Events without a URL show as "(no page)". A page with a usual value of 0 shows "new".
- Errors by page: Page, Errors and Usual for the same pages. It counts the errors and failed requests of all sessions on these pages. The filter of the chart does not apply to it. A line says "Errors on all sessions on these pages."
- Evidence: up to 5 cases seen at that time, each with its number, such as F-12, its title, and "Open" or "Seen". Under them are the releases of the project's environment from 24 hours before the point to its end. Then up to 10 recorded changes near that time that you can see. A case opens its page. A change opens Changes.
- The closing line: "These changes happened at the same time. Sequential does not prove that one caused the other."
- A line such as "Based on 312 sessions on Tue 14 Oct."
- At the bottom, a link such as Watch 312 sessions on /invoices.

Sequential makes each sentence from the counts, with fixed words. No AI writes them. No sentence names a cause.

Watch the sessions of a point:

- Watch 312 sessions on /invoices opens Workbench › Sessions on the day of the point. It keeps the filter of the chart, with its groups, and adds Page is that page.
- The link uses the page with the largest change that has a URL. The number counts the sessions of the point with events on that page.
- For an hour, the link says, for example, "Watch sessions on /invoices, all of Tue 14 Oct". The finder counts whole days, so it shows the whole UTC day.
- There is no link when the filter is Any of with two or more conditions or groups. There is also no link when that page has no session in the point.

By page in a comparison shows 5 pages and All other pages. Sequential reads at most 1,000 pages of the point. Evidence shows at most 5 cases from the newest 100, at most 10 releases from 24 hours before the point to its end, and at most 10 recorded changes.

The point in the address:

- While the reasons are open, the address also holds the point, such as `point=2026-10-07&why=1`. For an hour, it is `point=2026-10-07T10:00Z&why=1`, in UTC. It holds a date, never a count.
- Copy link copies the address. So the link opens the same point with its reasons.
- A reload or a link opens the point again when the chart still has that point and can compare it. If not, Sequential ignores the point and shows no message.
- When you close the reasons or the comparison, the point goes out of the address. A comparison with its reasons closed is not in the address.

## Changes on the chart

Under the chart, a lane of marks shows the changes that started in the window of the chart. These are the confirmed changes on the Changes timeline and the releases of the project. Each interval with changes gets one mark. A line under the chart says "Marks under the chart are recorded changes and releases. Nearness is not cause."

### Record a change for an interval

Owners, admins and members can record a change from the chart:

1. Point at an interval of the chart, or choose a day or an hour to compare.

2. Above the chart, click **Record a change** and the interval, such as Record a change, 14 Oct.

   Result: The form to record a change opens. Its **When** starts at the start of the interval and ends at its end.

3. Fill in the rest of the form, as in [Record a change in the app](/docs/changes#record-a-change-in-the-app).

The link uses the chosen point when there is one. Else it uses the interval that you pointed at last. It does not show when Sequential cannot read the changes.

## Open the session of an event

Matching events lists the 50 newest matching events. There is no paging.

1. Under **Matching events**, click a row.

   Result: The session opens in the peek beside the page. The recording starts at that event.

2. To see the person, click **Person** in the row.

   Result: The person opens in the peek.

## See the details of an event

> **Important**
>
> Raw event data, at the bottom, shows the whole event as JSON, as the server sent it. The JSON also holds fields that the details do not list, such as the project id (`tenant_id`) and the IP address of the visitor as Sequential stored it (`user_ip`). Every role that can open Events sees it, viewers included. See [What Sequential collects](/docs/privacy-overview#what-sequential-collects).

1. Under **Matching events**, click **Details** in a row.

   Result: The event details open at the side of the page.

2. To copy a value, click **Copy** beside it.

   Result: A message names what you copied, such as "URL copied."

3. To filter on a value, click **Filter** beside it.

   Result: The filter gets the condition, and the page counts again. The details close.

4. To see the whole event, click **Raw event data**. To copy it, click **Copy JSON**.

5. To close the details, press Esc, click outside them or click **Close**.

Or select a row with j or k and press d.

### The event details

At the top are the short line of the event, its date and time, and how long ago it happened. Under them are the fields of the event:

| Field | Shows | Filter adds |
|---|---|---|
| Event | The source and the event name. An event without a name shows its class | Event is the name. Without a name, Event type is the class |
| URL | The full URL | URL is the URL |
| Selector | The CSS selector of the element | Element is the selector |
| Visitor ID | The user id of the event | Person id is the id |
| Session ID | The session id | Session id is the id |
| Event ID | An id for this row of the list | No Filter |
| Account ID | The account id | Account id is the id |
| Referrer | The referrer | Referrer is the referrer |
| Country | The two-letter country code | Country is the code |
| Browser | The browser | Browser is the browser |
| Operating system | The operating system | Operating system is the system |

- The event details show only the events in the list. Event ID has no Filter.
- A field without a value does not show.
- Event has no Copy. Each other field has Copy.
- Some events do not have a selector field. Then Selector shows the Amplitude property `[Amplitude] Element Selector`, or the Mixpanel tag and id, such as `button#buy`. This selector has no Filter, because Element does not read properties.
- Event ID is not stored with the event. The server makes it for this list from the project id, the session id, the time and the place of the row in the list.

Under the fields are the groups Properties, Visitor properties and Account properties. Each group shows its number of pairs. A group without pairs does not show. Each pair has its name, its value, Copy and Filter. Filter adds Event property, Visitor property or Account property with the type Text, is and the value. An empty value, or a value that is not text, has no Filter.

Filter and copy:

- Filter adds the condition that the filter bar makes for that value: the field, is and the value. The details close, and the page counts again.
- If the filter is Any of with two or more conditions or groups, Sequential adds nothing. It says "The filter matches any of its conditions, so a value cannot narrow it. Switch it to “All of” first."
- If the filter has the condition already, Sequential says "The filter already has this condition."
- After Copy, a message names what you copied, never the value. Examples are "Visitor ID copied.", "Value copied." for a property and "Raw event data copied.".
- If the browser does not let Sequential copy, Sequential selects the text. The message says "The browser did not let Sequential copy. The text is selected: copy it yourself."
- The details close when you press Esc, click outside them, click Close or click Filter. The focus then goes back to the row or to its Details button.

## Leave out your team

Under Your team, the Leave out your team box leaves out the events of the people that your project marks as its team. By default, the box is ticked only for a first touch. When you change Break down by to or from a first touch, the box goes back to its default.

If nobody is marked, you cannot tick the box. Mark your team in Settings opens Your team in Settings › Recording & data, where an owner or admin marks your team.

The line under the box says what the counts left out or included. For its messages, see [When it does not work](#when-it-does-not-work).

## Save and share a view

1. In **Saved filters**, at the bottom of the page, type a name, or type nothing to use the filter as the name.

2. Click **Save this filter**.

3. To share the whole view, click **Copy link**, or press l.

   Result: The page says "Link to this view copied."

## How it works

Events in the Workbench counts the events from any SDK, or the people who sent them. Filter them, break them down by a field and compare them with the period before.

The address keeps the whole view. The filter changes when you choose a value, press Enter or leave the field. It does not change while you type.

## When it does not work

Find the message or the symptom that you see.

### When the count does not work

| Symptom | Cause | Fix |
|---|---|---|
| "Sequential has answered many questions for you in a short time. Try again in N seconds." | You used your query budget. | Wait, then click Try again. |
| A red sentence under a control | Sequential cannot count that part as written. | Change that control. |
| "The filter is over a limit; fix it above to count again." | The filter has more than 25 property conditions or more than one regex. | Remove conditions. |
| "Nothing to count here" | No events match in the window. | Widen the window, or remove a condition. |
| "Hours work for 14 days or less, so this counts days." | The window is longer than 14 days. | Choose a shorter window for hours. |
| "This link did not hold an events view that Sequential can read, so it shows the last 7 days." | The address is damaged or too old. | Build the view again and copy a new link. |
| An error note with a retry | The request failed, or the query took more than 30 seconds. | Retry, or use a shorter window or a filter. |

#### Your team

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Leaves out 12 events by 2 people marked as your team." | The line under the box | What the counts left out. | — |
| "Includes 12 events by 2 people marked as your team." | The line under the box | What the counts included. | — |
| "Nobody is marked as your team, so everyone is counted." | The line under the box | Nobody is marked. You cannot tick the box. | See [Leave out your team](#leave-out-your-team). |
| "Sequential could not read who is marked as your team right now. Try again shortly, or include your team." | Under a ticked box | Sequential cannot read who is on your team. | Untick the box, or try again shortly. |
| "Sequential could not read who is marked as your team right now, so its events are counted." | The line, with the box not ticked | Sequential cannot read who is on your team. | — |

If your team is larger than Sequential checks at once, the line under the box says so. The Sessions links keep the choice of the box.

### When the comparison does not work

Leave out your team must not be ticked, unless nobody is marked as your team. A usual value needs 2 or more earlier days that Sequential holds in full.

Under a chart that can compare, a line says "Click a day to compare it with its usual value, or focus the chart, move with the arrow keys and press Enter." Under a chart that cannot compare, a line says why:

| The chart | The line says |
|---|---|
| Has Break down by | "Comparing works on the chart without a breakdown." |
| Counts People | "Comparing works on the chart that counts events." |
| Counts every Week | "Comparing works on hour and day charts. Change the interval to Day." |

- With Leave out your team ticked, the comparison leaves your team out too, so it counts what the chart draws. The comparison then says, for example, "Leaves out 12 events by 2 people marked as your team."
- If Sequential cannot read who is marked as your team, the comparison says "Sequential could not read who is marked as your team right now. Try again shortly, or include your team." with Try again and Include your team. Include your team unticks Leave out your team, which closes the comparison.
- The comparison closes when the project, the filter, the window, Every, Count, Break down by or the team choice changes. So it closes when you tick or untick Leave out your team.
- When you choose another point, the comparison shows that point. Its reasons start closed.

When the comparison does not work, you can see:

| Symptom | Cause | Fix |
|---|---|---|
| "Too many queries right now. Try again in N s." | You used your query budget. | Wait, then click Retry. |
| "Could not load the comparison. Try again." | The request failed, or Sequential could not tell yet if it holds data for that time. | Click Retry. |
| "Sequential holds no data for that time." | Sequential does not hold that day or hour. | Choose a later point. |
| "Sequential cannot compare this time." | Sequential refused the point. | Choose another point. |
| "No usual value." and a reason | Sequential holds fewer than 2 earlier days to compare with, or it could not check how far back the data goes. | Choose a later point. |
| "Sequential has no error records for these days. DevTools capture may be off." | No error records exist for these days. | Make sure that [DevTools](/docs/devtools) capture is on. |
| "Sequential holds no error records for this day." | The error records start after this point. | Choose a later point. |
| "Could not load errors.", "Could not load findings.", "Sequential could not check releases." or "Sequential could not check recorded changes." | Sequential could not read that part. For releases, Sequential can also not know the environment of the project. The other parts still show. | Try again later. |
| "No changes are recorded for this period. That says nothing about whether anything changed." | The project records changes, but none is near this point. | — |
| "Entries marked admins-only are not shown to you. Their absence here says nothing about whether any exist." | Your role does not see the changes marked admins-only. | — |
| "Findings aren’t switched on for this project." | Case detection is off for the project. | — |
| "Some pages are counted only in All other pages." | The point has 1,000 or more pages. | — |
| "Showing findings from the newest 100." | Sequential reads only the newest 100 cases. | — |

## What it needs

- Events from a supported SDK. See [Install Sequential](/docs/install), then [Check your install](/docs/verify).
- Custom events for the features you want to count by name. See [Send custom events](/docs/custom-events).
- `identify` calls, so the page counts people, not visitors. See [Identify your users](/docs/identify-users).
- For errors, an SDK that sends error events. See [What each SDK supports](/docs/support-matrix).

## FAQ

### What questions can Events answer?

Use Events for questions like these:

- How many people started an export last week?
- Which pages have errors, and how many?
- Which custom events does this project receive at all?
- Did a page get more visits than in the week before?

To count your own events by name, see [Send custom events](/docs/custom-events).

### Why does People here differ from the People page?

People here counts the people who sent the counted events in this window, also from your server. The People page counts everyone who visited in a browser or an app in the last 7 days. So either number can be the larger. From 8 November 2026, this note is behind "How counted ▾", under the headline.

### Why can the Sessions links find other sessions?

The Sessions finder looks at whole sessions, not at single events. Hover a link to read how its sessions can differ.

These links open Workbench › Sessions with the same days:

- Sessions with these events under the scope line, or All sessions in this window without a filter;
- Sessions, and the interval, under the chart;
- Sessions in a row of the chart table or the breakdown table;
- Watch and a number of sessions on a page, in the reasons of a compared point. See [What the comparison shows](#what-the-comparison-shows).

How the finder reads the filter:

- A filter with a group goes to the finder as one group. The finder then looks for one event that matches the whole filter, as Events does.
- If that group is over the finder's limits, the finder looks for each condition and each group at the top on its own event. Its hover text then says: "The finder looks for each condition and each group on its own event of the session, so these are the sessions where each one happened, not always on the same event."
- In a filter without groups, a Country, Browser, Operating system, Platform or Person id condition with is goes to the finder's own controls.
- The finder looks for each other condition on its own event of the session. So these are the sessions where each one happened, not always on the same event.
- A "not" condition finds the sessions that had no such event.
- The finder counts whole days. Last 24 hours becomes today and yesterday, and an hour becomes its whole day.
- In a row of the second level, Sessions opens the sessions with the values of both levels.
- Each link uses the team rule of the counts. It leaves your team out only when the counts left it out.
- The (not set), (empty) and (no id) rows, the Traffic source rows and the first-touch rows have no Sessions link. With an Any of filter of two or more conditions or groups, the rows have no Sessions link.

### What does a saved filter or a link keep?

A saved filter keeps the filter and Break down by. It does not keep Then by, the window or the other settings. The address holds the whole view: the filter, the window, the interval, the count, Break down by, Then by, the compare and a changed Leave out your team. While the reasons of a compared point are open, it also holds that point (see [What the comparison shows](#what-the-comparison-shows)).

Saved filters:

- Workbench › Sessions lists the same saved filters.
- A saved filter needs at least one condition: "Add a filter first: a saved filter keeps at least one condition."
- To open a saved filter, click its name. If the view has no group-by, the page keeps its own. If the page cannot group by the field of the view, the filter opens without a group-by, and the card says so.
- Viewers can open saved filters but not save, rename or delete them.
- You cannot save an Events view on the Board. Copy its link instead.
- See [Save and open views](/docs/filters-and-saved-views#save-and-open-views).

Links:

- If the browser does not let Sequential copy, copy the address bar instead.
- If a link does not hold a view that Sequential can read, the page says "This link did not hold an events view that Sequential can read, so it shows the last 7 days."
- On a person's page, All events of this person opens Events with a filter: the person's events from their first visit to today, at most two years back. If the first visit is not known, the last 90 days.
- Beside a session, All events of this session opens Events with a filter: the UTC day or days of the session. If they are not known, the last 30 days. All events of this person is there too.
- These two links count every hour for 2 days or less, and every week for more than 180 days.
- An address of the old Events page opens here too. Its `user_id`, `account_id` and `session_id` become conditions. Its `from_date` and `to_date` become the window. The first field of `breakdown_by` becomes the breakdown, when this page offers it.

### Which fields are empty for some SDKs?

| Field | Empty for |
|---|---|
| Account id | PostHog, Mixpanel and Amplitude events. It has values only from Pendo, or after `sequential.account()`. |
| Element | PostHog, Mixpanel and Amplitude events |
| URL, Page and Referrer | Amplitude events |

Visitor property finds nothing in Sequential SDK or PostHog data. Account property finds nothing in PostHog data. With the Sequential SDK, it finds only the account events that `sequential.account()` sends. See [What each SDK supports](/docs/support-matrix).

### What does a mark on the chart show?

Hold the pointer on a mark to read what it holds. When the chart can compare, a click on a mark chooses its day or hour for the comparison. When the chart cannot compare, a click on a mark opens the change, or the page of the release.

- One change shows its title, its kind and its time, such as "Release web@2.14 (Release, 14 Oct, 15:02)". More changes show their number and the first three, such as "2 changes: …".
- A mark with more changes opens the earliest of them.
- A change that is recorded as one that did not happen gets no mark.
- In Show as a table, the Changes column shows the words of each mark. Click them to open the change.
- The lane reads at most 100 changes for the window. With more, a line says "Only the newest 100 changes in this window are marked."
- If Sequential cannot read the releases, a line says "Releases could not be read just now, so they are not marked."
- If Sequential cannot read the changes, the chart has no marks.

See [Compare a point with the usual day](#compare-a-point-with-the-usual-day).

## Limits

- Each count is part of the query budget of each person for each project. By default, the budget is 300 requests a minute. Each comparison of a point is one more request of the same budget.
- The list stops at the 50 newest matching events. There is no paging.
- Hour works only for a window of 14 days or less. A window has at most two years.
- A filter has at most 25 property conditions and one matches regex. A pattern has at most 256 bytes, a list at most 1,000 values, and a property name at most 128 bytes.
- A request stops after 30 seconds. On a busy project, use a shorter window or add a filter.

## Next steps

- [Events](/docs/events): the event classes and what each one means.
- [Filters, date ranges and saved views](/docs/filters-and-saved-views): operators, groups and saved views.
- [Funnels](/docs/funnels): count people through steps in order.
- [People and accounts](/docs/users-and-accounts): find a person and see what they did.
- [Find and replay sessions](/docs/sessions-and-replay): watch the sessions behind a number.
