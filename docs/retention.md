# Retention: do people come back?

> Retention shows how many people who did a start event came back to do a return event on day N. It shows one cohort for each day or week.

> **At a glance**
>
> - **Who can:** Any organisation role can open Retention ([Roles and permissions](/docs/roles-and-permissions)).
> - **Before you start:** Events from any supported source ([Install Sequential](/docs/install)), and a stable user id on your events ([User ids and identity](/docs/users-and-identity)).
> - **Default:** New people cohorts, Any event as the return, a window of 30 days, and days 1, 7, 14 and 28.
> - **Know this:** A day that a cohort has not reached yet shows "not yet", not a percentage.
> - **Know this:** Without `identify`, retention counts browsers and app installs, not people.

> **In short**
>
> - A person returns on day N with a return event on the UTC day exactly N days later.
> - For "did people who did A then do B, at any time?", use [Funnels](/docs/funnels).

## Build a retention question

1. Choose your project.

2. Go to **Workbench › Retention**.

3. In **Start**, add conditions for the start event, as for a funnel step. With no conditions, any event counts.

   **If you want to count only some people**

   Select **Only people who match a filter** under **Start**. A filter bar opens, with the line "These conditions choose who is counted. Their start event must match them." A person joins a cohort on the day of their first event that matches Start and this filter.

   The definition line then names both, in the form "Each cohort is the people whose first <start>, and that is also an <filter>, ever fell on that day." With Everyone active, it says "in the window" in place of "ever". The address and a saved view keep the filter. If you clear the box, its conditions stay until you leave the page.

4. In **Return**, keep Any event, or click **A specific event** and add its conditions.

5. In **Days**, click a day to add it or remove it.

6. To add another day, type a number in **Day…**, then press Enter or click **Add**.

7. In **Cohort**, choose New people or Everyone active.

   Result: A line under it explains the choice. New people uses each person's first start event ever. Everyone active uses their first start event in the window, so an existing person joins a cohort as if they were new. With Everyone active, read the first-day cohort with care: see [Exact counting rules](#exact-counting-rules).

8. In **Window**, choose 7 days, 14 days, 30 days or 90 days. Or click **Custom** and set two days.

9. Optional: above the cohort table, choose Auto, By day or By week.

Result: The page counts a short time after each change. To count again, press `r`.

If the page shows "No events yet" or an error, see [Messages, empty states and errors](#messages-empty-states-and-errors).

### Messages, empty states and errors

If your project has not sent an event or a recording yet, the page shows "No events yet" in place of the question. It says, for example, "Acme hasn’t sent any events yet. Once it does, this page shows how many people come back in the days after their first visit." The button, such as Set up Acme, opens Settings › Setup.

The key `r` then does nothing. Copy link still works. If Sequential cannot read the status of the project, the page shows the question as usual.

A valid window applies at once. See [Filters, date ranges and saved views](/docs/filters-and-saved-views).

The filter bar and the window work as on the other Workbench views. See [Filters, date ranges and saved views](/docs/filters-and-saved-views).

Each day is a chip in Days. A day that you typed has a ×. The page refuses a day that it cannot use, and says why. The list does not change then. With 10 days in the list, Day… and Add are off.

If Sequential refuses a part of the question, the page shows the reason beside that part. If the query fails for another reason, the page shows the error with Try again.

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Counting who came back in the last 30 days. On a busy project this takes a few seconds." | While the page counts the first time | An example of what the page says while it counts. | — |
| "Counting again for the new definition…" | After a change | The old answer stays, paler, under this line. | — |
| "Enter a whole number of days from 1 to 365." | Days | The page refuses the day. The list does not change. | — |
| "Day N is already measured." | Days | The page refuses the day. The list does not change. | — |
| "At most 10 days at once. Remove one first." | Days | The page refuses the day. The list does not change. | — |
| "Keep at least one day to measure." | Days | The page refuses the day. The list does not change. | — |
| "No new people started in this window." | Instead of a table of zeros | An example. No one did the start event in the window, so the page says why, instead of a table of zeros. | The page suggests a wider window or a looser start event. |
| "Sequential is answering many questions for you at once, so this one waits. Try again in a minute." | — | Sequential answers many questions for you at once. The message can name the seconds to wait instead of "in a minute". Try again is next to it. | — |

## How it works

Retention answers the question "do people come back?" For example: of the people who signed up last month, what share came back to create an invoice a week later?

| Term | Meaning |
|---|---|
| Start event | The event that puts a person in a cohort. With no conditions, it is any event, so a cohort starts with a person's first event |
| Cohort date | The UTC calendar day of the person's first start event ever. The person joins a cohort only when that day is in the window. With Everyone active, it is the day of the first start event in the window |
| Return event | The event that counts as coming back. Any event counts every event. This is the default. A specific event counts only the events that match its conditions |
| Day N | A person returns on day N if they have at least one return event on the calendar day exactly N days after their cohort date. Several return events on that day count as one return |

### Exact counting rules

| Rule | What happens |
|---|---|
| Start and return events | The start event and the return event are each one event that matches conditions, as a funnel step is. With no conditions, every event that your SDK sends counts, including page views, clicks and custom events |
| Any event as the return | Any event on day N counts, also a new start event |
| Returns after the window | Sequential looks for returns up to the last day of the window plus your largest day. So a cohort near the end of the window can still show a day 28, if that day has already happened |
| The All cohorts row | Each cell adds the returned people of the cohorts that reached that day. It then divides that sum by the total size of those cohorts. So larger cohorts have more weight. The All cohorts row and the curve count only the cohorts that reached day N. If no cohort reached day N, they show "not yet" |
| Exact day only | Day N is not "on or after". A person who returns on days 5 and 9 does not count on day 7. Returns count only on the exact day. There are no "on or after" returns, no rolling windows and no monthly cohorts |
| Existing people | With New people, a cohort starts from each person's first start event ever, not their sign-up date. A person who did the start event before the window joins no cohort, so Retention shows how new people come back. With Everyone active, that person joins the cohort of their first start event in the window, as if they were new. Before 12 October 2026, that was the only rule |
| The first-day cohort | With New people, the cohort of the first day of the window holds only the people who are new on that day, as every other cohort does. With Everyone active, it holds every existing person who did the start event on that day. Read it with care |
| Weekly rows | Each person has one cohort day. So a week row is the sum of the daily cohorts of that week, with no person counted twice. A weekly row adds up the daily cohorts of its week. A week cell counts only the daily cohorts of that week that reached day N. If only some reached it, the cell says "so far". If none reached it, the cell shows "not yet" |
| Deleted history | Sequential can see only the events that it still holds. If retention deleted a person's first visit, that person can join a cohort as if they were new |
| Before-and-after comparisons | To compare cohorts before and after a change, start the window well before the change. A cohort holds the people whose first start event is on its day. A person can be new to Sequential but not new to your product, for example after you install the SDK. So treat the comparison as a trend only |

### Retention from an agent

An agent chooses New people or Everyone active with `cohort`. An agent with `analytics:read` reads retention with the tool `retention_analysis`. It takes `cohort`:

- `first_time`, the default: the page's New people. Each person joins the cohort of their first start event ever, when it is in the window.
- `first_in_range`: the page's Everyone active, the rule before 12 October 2026. Each person joins the cohort of their first start event in the window, so a person who was active before the window joins a cohort as if they were new.

The answer gives `cohort` and `cohorts_complete`:

- `true`: Sequential still holds all the events of the project, so the new people are new.
- `false`: retention can have deleted older events of the project. A person whose first visit was deleted can look new. Sequential checks the period that each stored day of events was kept with, so a shorter or longer period of the organisation does not change the answer for events already stored.
- `null`: Sequential could not check it.

With `first_in_range`, `cohorts_complete` is always `true`. POST `/api/retention` takes the same `cohort`.

Through the API, a saved retention view keeps the cohort as `cohort`: `first_time` (New people) or `first_in_range` (Everyone active). A view without `cohort` reads as `first_time`. From 13 October 2026, Sequential refuses any other value with 422 `invalid_definition` at `/cohort`. The page offers only the two values.

## Read the answer

The answer shows under the controls: a sentence, a definition line, notes, a curve and the cohort table. The sentence uses the latest of your days that has 30 people or more to measure. On the curve, a hollow point is measured on fewer than 30 people. [Each part of the answer](#each-part-of-the-answer) has the rest.

In the cohort table, a Day N cell shows the share of the people who could return by then, with "X of Y" under it. The shading gets darker as the share increases. "so far" marks a week in which only some of its daily cohorts reached day N.

For example, suppose that the row for 1 September has People 120. Its Day 7 cell shows 18.3 % with "22 of 120" under it. So 22 of the 120 people whose first start event ever was on 1 September had a return event on 8 September.

The All cohorts row adds the cohorts that reached day N, so larger cohorts have more weight. See [Exact counting rules](#exact-counting-rules).

A cohort's day N counts only when that whole UTC day is in the past. Today is never complete. Until then, the cell shows "not yet". To read day N for every cohort, click Custom in Window and set the last day more than N days ago.

### Each part of the answer

| Part | What it shows |
|---|---|
| The sentence | For example "41 of 230 new people (17.8%) came back on day 28." It uses the latest of your days that has 30 people or more to measure. If no day has 30, it uses the day with the most people. With Everyone active, it says "people", not "new people". If no cohort has reached any of your days yet, it says that nothing can be measured yet |
| The definition | A line under the sentence says what a cohort and a return are |
| Notes | Lines under it say when a day counts only the older cohorts. They also name a base of fewer than 30 people, and the days that no cohort has reached yet. With New people, a line can say "Some people's first visit is older than the history this project keeps, so a cohort may hold people who are not new." It shows when the project's retention can have deleted older events |
| The curve | The share of each day. A day that no cohort has reached shows "not yet" under the axis. A hollow point is measured on fewer than 30 people |
| Cohorts | An All cohorts row, then one row for each cohort. Auto shows one row for each week when there are more than 14 daily cohorts |

The cohort table has these columns:

| Column | What it shows |
|---|---|
| Cohort | The day. By week, the column is Week, and a row shows "Week of" and the Monday of the UTC week. A Sessions button can open the sessions with the start event on that day or in that week |
| People | The people whose first start event fell in that day or week |
| Day N | A share, or "not yet": see [Read the answer](#read-the-answer) |

## Keep or share the question

To copy the address of the question, click Copy link, or press `l`. To keep the question for the project, save it:

1. At the bottom of the page, go to **Saved retention views**.

2. Click **Save this retention view**.

Result: A saved view keeps the start and return events, the days, the cohort, the grouping and the window. Everyone in the project sees it. Viewers can only open it.

### The address, segments and the Board

Workbench › Retention keeps the question in its address: the start and return events, the days, the cohort, the window and the grouping. The page opens on the question in its address. Without one, it opens on the defaults. To keep a question, keep its link.

A saved view that keeps only some people (a segment) opens with its filter under Only people who match a filter. If the Workbench cannot read that filter, it says "The segment of this view uses a filter the Workbench cannot read yet." See [Save and open views](/docs/filters-and-saved-views#save-and-open-views).

The Board shows the project's saved retention questions that it can run. It names the others in one line. See [Filters, date ranges and saved views](/docs/filters-and-saved-views).

## How Sequential counts people

Without `identify`, cohorts look bigger and return rates look lower than they really are. Call `identify`, and always use the same value for one person. [Identify your users](/docs/identify-users) shows how.

| Source | Are events from before `identify` joined to the person? |
|---|---|
| Sequential SDK, PostHog or Mixpanel | Yes. Retention joins them to the identified person, as the People list does ([People and accounts](/docs/users-and-accounts)). This also applies when the person identifies after the window, so the result for a past period can change. A new identity link can take up to 5 minutes to apply |
| Amplitude, Pendo or Smartlook | No. Nothing links the anonymous id to the identified value. The anonymous id and the identified value count as two user ids |

A person who uses a laptop and a phone counts as two user ids in two cohorts. A return on the second device is not a return for the first.

On a shared device, call `sequential.reset()` at sign-out. Without it, Sequential counts the next person as the previous person returning.

For the exact-day rule, deleted history and the first-day cohort, see [Exact counting rules](#exact-counting-rules).

### How one person becomes several user ids

Call `identify`:

- when a person signs up or signs in
- on each page load, for a person who is already signed in

Always use the same value for one person. Sequential counts two different values as two people. See [Identify your users](/docs/identify-users).

Retention counts people by the user id on each event. After your app calls `identify`, that id is the value you passed. Before that, it is an anonymous id that the SDK keeps in that browser or app.

- A private window or cleared browser storage starts a new anonymous id. The same person then joins a new cohort as if they were new.
- If the browser blocks all storage, the Sequential SDK starts a new id on every page load.

Events with no user id are not a person. They join no cohort.

With the Sequential SDK, PostHog or Mixpanel, the visit where a person is identified is not split. Retention uses the link from `identify` to the anonymous id. So the events from before identify count for the identified person.

With Amplitude, Pendo or Smartlook, nothing links the two ids. Each time a person starts anonymous and is then identified, an extra anonymous user id joins the cohort of that day. That user id usually does not return. This happens:

- on a sign-up
- on a sign-in on a new device or in a private window
- on a sign-in after a sign-out reset

This makes cohorts bigger and makes their rates lower.

Shared devices need a sign-out reset. When a person signs out, call your SDK's reset. In the Sequential SDK, this is `sequential.reset()`. The next person on that device then gets a new anonymous id. Without the reset, Sequential counts that person as the previous person returning.

## FAQ

### What questions can Retention answer?

- Of the people who signed up, what share came back to create a report on day 7?
- After you changed onboarding, did the later cohorts return on day 7 more often than the earlier cohorts?
- Does the day 1 return rate stay the same as more people arrive, or does it fall?

Retention cannot answer "how many people who signed up created a report at any time later?" It counts a return only on the exact day. For that question, use [Funnels](/docs/funnels).

### Why does each identified person count twice after a move from Smartlook?

If you moved from Smartlook, each identified person counts as two user ids. Sequential's Smartlook-compatible script stores only the `identify` call under your user id. Every other event stays under the Smartlook visitor id. So each identified person counts as two user ids:

- the visitor, with all their activity
- your user id, which is active only on the days when `identify` runs

See [Moving from Smartlook](/docs/smartlook).

## Limits

- Days are whole numbers from 1 to 365. You can measure at most 10 days. There is no day 0.
- Days are UTC calendar days, whatever your time zone. The default window is also in UTC. If you are west of UTC, late in your day the last day of the window can already be tomorrow's date.
- A query stops after 30 seconds, and the page shows an error with Try again. If this happens, shorten the window, or remove the largest day.

The other numbers are on [Limits](/docs/limits).

## Next steps

- [Funnels](/docs/funnels): did people do A, then B, at any time?
- [Flows](/docs/flows): the order in which people move between events.
- [Identify your users](/docs/identify-users): one `identify` value for each person.
- [User ids and identity](/docs/users-and-identity): how Sequential files each event under one user id.
- [Filters, date ranges and saved views](/docs/filters-and-saved-views): the filter bar, the window and saved views.
