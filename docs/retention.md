# Retention: do users come back?

> Retention shows how many people who did a start event came back to do a return event on day N. It shows one cohort for each day or week.

> **In short**
>
> - Workbench › **Retention** has five parts: **Start**, **Return**, **Days**, **Cohort** and **Window**.
> - **Cohort** chooses who joins a cohort. **New people**, the default: each person joins the cohort of the UTC day of their first start event ever, when that day is in the window. **Everyone active**: each person joins the cohort of their first start event in the window.
> - A person returns on day N with a return event on the UTC day exactly N days later.
> - With no conditions in **Start**, a cohort starts with a person's first event. **Any event** is the default return.
> - A day that a cohort has not reached yet shows "not yet", not a percentage.
> - Without `identify`, retention counts browsers and app installs, not people.

## What it is for

Retention answers the question "do people come back?" For example: of the people who signed up last month, what share came back to create an invoice a week later?

For "did people who did A then do B, at any time?", use [Funnels](/docs/funnels).

## How it works

- **Start event.** The event that puts a person in a cohort. With no conditions, it is any event, so a cohort starts with a person's first event.
- **Cohort date.** The UTC calendar day of the person's first start event ever. The person joins a cohort only when that day is in the window. With **Everyone active**, it is the day of the first start event in the window.
- **Return event.** The event that counts as coming back. **Any event** counts every event. This is the default. **A specific event** counts only the events that match its conditions.
- **Day N.** A person returns on day N if they have at least one return event on the calendar day exactly N days after their cohort date. Several return events on that day count as one return.

## How to use it

1. Select your project.
2. Open **Workbench** and click **Retention**.
3. In **Start**, add conditions for the start event, as for a funnel step. With no conditions, any event counts.
   To count only some people, tick **Only people who match a filter** under **Start**. A filter bar opens, with the line "These conditions choose who is counted. Their start event must match them." A person joins a cohort on the day of their first event that matches **Start** and this filter. The definition line then names both, in the form "Each cohort is the people whose first <start>, and that is also an <filter>, ever fell on that day." With **Everyone active**, it says "in the window" in place of "ever". The address and a saved view keep the filter. If you clear the box, its conditions stay until you leave the page.
4. In **Return**, keep **Any event**, or click **A specific event** and add its conditions.
5. In **Days**, click a day to add it or remove it. The default days are 1, 7, 14 and 28.
6. To add another day, type a number in **Day…**, then press Enter or click **Add**.
7. In **Cohort**, choose **New people** (the default) or **Everyone active**. A line under it explains the choice.
8. In **Window**, choose **7 days**, **14 days**, **30 days** or **90 days**. Or click **Custom** and set two days. The default is **30 days**.
9. Optional: above the cohort table, choose **Auto**, **By day** or **By week**.

The page counts a short time after each change. To count again, press **r**. The page opens on the question in its address. Without one, it opens on the defaults.

If your project has not sent an event or a recording yet, the page shows "No events yet" in place of the question. It says, for example, "Acme hasn’t sent any events yet. Once it does, this page shows how many people come back in the days after their first visit." The button, such as **Set up Acme**, opens Settings › **Setup**. The key **r** then does nothing. **Copy link** still works. If Sequential cannot read the status of the project, the page shows the question as usual.

The filter bar and the window work as on the other Workbench views. See [Filters, date ranges and saved views](/docs/filters-and-saved-views).

## Read the answer

The answer shows under the controls:

- **The sentence.** For example "41 of 230 new people (17.8%) came back on day 28." It uses the latest of your days that has 30 people or more to measure. If no day has 30, it uses the day with the most people. With **Everyone active**, it says "people", not "new people". If no cohort has reached any of your days yet, it says that nothing can be measured yet.
- **The definition.** A line under the sentence says what a cohort and a return are.
- **Notes.** Lines under it say when a day counts only the older cohorts. They also name a base of fewer than 30 people, and the days that no cohort has reached yet. With **New people**, a line can say "Some people's first visit is older than the history this project keeps, so a cohort may hold people who are not new." It shows when the project's retention can have deleted older events.
- **The curve.** The share of each day. A day that no cohort has reached shows "not yet" under the axis. A hollow point is measured on fewer than 30 people.
- **Cohorts.** An **All cohorts** row, then one row for each cohort. **Auto** shows one row for each week when there are more than 14 daily cohorts.

| Column | What it shows |
|---|---|
| **Cohort** | The day. By week, the column is **Week**, and a row shows "Week of" and the Monday of the UTC week. A **Sessions** button can open the sessions with the start event on that day or in that week |
| **People** | The people whose first start event fell in that day or week |
| **Day N** | The share of the people who could return by then, with "X of Y" under it. "so far" marks a week in which only some days reached day N. The shading gets darker as the share increases |

> **Days a cohort has not reached yet show "not yet"**
>
> A cohort's day N counts only when that whole UTC day is in the past. Today is never complete. Until then, the cell shows "not yet".
>
> By week, a cell counts only the daily cohorts of that week that reached day N. If only some reached it, the cell says "so far". If none reached it, the cell shows "not yet".
>
> The **All cohorts** row and the curve count only the cohorts that reached day N. If no cohort reached day N, they show "not yet".
>
> To read day N for every cohort, click **Custom** in **Window** and set the last day more than N days ago.

## How Sequential counts users

Without `identify`, retention counts browsers or app installs, not people. So cohorts look bigger and return rates look lower than they really are.

Call `identify`, and always use the same value for one person. [Identify your users](/docs/identify-users) shows how.
- On a shared device, call `sequential.reset()` at sign-out. Without it, Sequential counts the next person as the previous user returning.

## What it needs

- Events from any supported source. See [Install Sequential](/docs/install).
- A stable user id on your events. See [Identify your users](/docs/identify-users) and [Users and identity](/docs/users-and-identity).
- Any organisation role can open Retention. See [Roles and permissions](/docs/roles-and-permissions).

## Limits

- The start event and the return event are each one event that matches conditions, as a funnel step is. With no conditions, every event that your SDK sends counts, including page views, clicks and custom events.
- With **Any event** as the return, any event on day N counts, also a new start event.
- With **New people**, a cohort starts from each person's first start event ever, not their sign-up date. A person who did the start event before the window joins no cohort. With **Everyone active**, a cohort starts from the first start event in the window, so an existing user joins a cohort as if they were new. Before 12 October 2026, that was the only rule. An agent chooses the same with `cohort`. See **Retention from an agent** below.
- Sequential can see only the events that it still holds. If retention deleted a person's first visit, that person can join a cohort as if they were new.
- Returns count only on the exact day. There are no "on or after" returns, no rolling windows and no monthly cohorts. A weekly row adds up the daily cohorts of its week.
- Days are UTC calendar days, whatever your time zone. The default window is also in UTC, so if you are west of UTC, late in your day its last day can already be tomorrow's date.
- Events with no user id are not a user. They join no cohort.
- With the Sequential SDK, PostHog or Mixpanel, retention joins the events from before `identify` to the identified user, as the **People** list does. This also applies when the person identifies after the window, so the result for a past period can change. A new link can take up to 5 minutes to apply.
- With Amplitude, Pendo or Smartlook, nothing links the anonymous id to the identified value. They count as two users.
- If you moved from Smartlook, each identified person counts as two users. See **Moving from Smartlook** below.
- Workbench › **Retention** cannot save a question. Only its address keeps it. If you open the page without that address, the page opens on the defaults. To keep a question, keep its link.
- A query stops after 30 seconds, and the page shows an error with **Try again**. If this happens, shorten the window, or remove the largest day.
- Days are whole numbers from 1 to 365. You can measure at most 10 days. There is no day 0.

### More example questions

- Of the people who signed up, what share came back to create a report on day 7?
- After you changed onboarding, did the later cohorts return on day 7 more often than the earlier cohorts?
- Does the day 1 return rate stay the same as more people arrive, or does it fall?

Retention cannot answer "how many people who signed up created a report at any time later?" It counts a return only on the exact day. For that question, use [Funnels](/docs/funnels).

### Exact counting rules

- **Returns after the window.** Sequential looks for returns up to the last day of the window plus your largest day. So a cohort near the end of the window can still show a day 28, if that day has already happened.
- **The All cohorts row.** Each cell adds the returned people of the cohorts that reached that day. It then divides that sum by the total size of those cohorts. So larger cohorts have more weight.
- **Exact day only.** Day N is not "on or after". A person who returns on days 5 and 9 does not count on day 7.
- **Existing users.** With **New people**, a person who did the start event before the window is in no cohort, so Retention shows how new people come back. With **Everyone active**, that person joins the cohort of their first start event in the window, as if they were new.
- **The first-day cohort.** With **New people**, the cohort of the first day of the window holds only the people who are new on that day, as every other cohort does. With **Everyone active**, it holds every existing user who did the start event on that day. Read it with care.
- **Weekly rows.** Each person has one cohort day. So a week row is the sum of the daily cohorts of that week, with no person counted twice.
- **Before-and-after comparisons.** To compare cohorts before and after a change, start the window well before the change. A cohort holds the people whose first start event is on its day. A person can be new to Sequential but not new to your product, for example after you install the SDK. So treat the comparison as a trend only.

### A worked example

Suppose that the row for 1 September has **People** 120. Its **Day 7** cell shows 18.3 % with "22 of 120" under it. So 22 of the 120 people whose first start event ever was on 1 September had a return event on 8 September.

### The window, the days and errors

**While the page counts the first time**, it says, for example, "Counting who came back in the last 30 days. On a busy project this takes a few seconds." After a change, the old answer stays, paler, under "Counting again for the new definition…".

**The window.** A valid window applies at once. See [Filters, date ranges and saved views](/docs/filters-and-saved-views).

**The days.** Each day is a chip in **Days**. A day that you typed has a ×. The page refuses a day that it cannot use, and says why. The list does not change then:

- "Enter a whole number of days from 1 to 365."
- "Day N is already measured."
- "At most 10 days at once. Remove one first."
- "Keep at least one day to measure."

With 10 days in the list, **Day…** and **Add** are off.

**No cohorts.** If no one did the start event in the window, the page says why, instead of a table of zeros. For example: "No new people started in this window." It then suggests a wider window or a looser start event.

**Errors.** If Sequential refuses a part of the question, the page shows the reason beside that part. If Sequential answers many questions for you at once, the page says "Sequential is answering many questions for you at once, so this one waits. Try again in a minute." It can name the seconds to wait instead of "in a minute". **Try again** is next to it. If the query fails for another reason, the page shows the error with **Try again**.

### Keep or share the question

Workbench › **Retention** keeps the question in its address: the start and return events, the days, the cohort, the window and the grouping.

- **Copy link**, or the key **l**, copies the address.
- To keep the question for the project, save it under **Saved retention views**, at the bottom of the page. Click **Save this retention view**. A saved view keeps the start and return events, the days, the cohort, the grouping and the window. Everyone in the project sees it. Viewers can only open it. A saved view that keeps only some people (a segment) opens with its filter under **Only people who match a filter**. If the Workbench cannot read that filter, it says "The segment of this view uses a filter the Workbench cannot read yet." See [Save and open views](/docs/filters-and-saved-views#save-and-open-views).
- The **Board** shows the project's saved retention questions that it can run. It names the others in one line. See [Filters, date ranges and saved views](/docs/filters-and-saved-views).
- Through the API, a saved retention view keeps the cohort as `cohort`: `first_time` (**New people**) or `first_in_range` (**Everyone active**). A view without `cohort` reads as `first_time`. From 13 October 2026, Sequential refuses any other value with 422 `invalid_definition` at `/cohort`. The page offers only the two values.

### When to call identify

Call `identify`:

- when a person signs up or signs in
- on each page load, for a person who is already signed in

Always use the same value for one person. Sequential counts two different values as two people.

### How one person becomes several users

Retention counts users by the user id on each event. After your app calls `identify`, that id is the value you passed. Before that, it is an anonymous id that the SDK keeps in that browser or app.

- A person who uses a laptop and a phone counts as two users in two cohorts. A return on the second device is not a return for the first.
- A private window or cleared browser storage starts a new anonymous id. The same person then joins a new cohort as a new user.
- If the browser blocks all storage, the Sequential SDK starts a new id on every page load.

### Effects that remain after you identify

**With the Sequential SDK, PostHog or Mixpanel, the visit where a person is identified is not split.** Retention uses the link from `identify` to the anonymous id. So the events from before identify count for the identified person.

With Amplitude, Pendo or Smartlook, nothing links the two ids. Each time a person starts anonymous and is then identified, an extra anonymous user joins the cohort of that day. That user usually does not return. This happens:

- on a sign-up
- on a sign-in on a new device or in a private window
- on a sign-in after a sign-out reset

This makes cohorts bigger and makes their rates lower.

**Shared devices need a sign-out reset.** When a person signs out, call your SDK's reset. In the Sequential SDK, this is `sequential.reset()`. The next person on that device then gets a new anonymous id. Without the reset, Sequential counts that person as the previous user returning.

### Moving from Smartlook

Sequential's Smartlook-compatible script stores only the `identify` call under your user id. Every other event stays under the Smartlook visitor id. So each identified person counts as two users:

- the visitor, with all their activity
- your user id, which is active only on the days when `identify` runs

See [Moving from Smartlook](/docs/smartlook).

### Retention from an agent

An agent with `analytics:read` reads retention with the tool `retention_analysis`. It takes `cohort`:

- `first_time`, the default: the page's **New people**. Each person joins the cohort of their first start event ever, when it is in the window.
- `first_in_range`: the page's **Everyone active**, the rule before 12 October 2026. Each person joins the cohort of their first start event in the window, so a person who was active before the window joins a cohort as if they were new.

The answer gives `cohort` and `cohorts_complete`:

- `true`: Sequential still holds all the events of the project, so the new people are new.
- `false`: retention can have deleted older events of the project. A person whose first visit was deleted can look new. Sequential checks the period that each stored day of events was kept with, so a shorter or longer period of the organisation does not change the answer for events already stored.
- `null`: Sequential could not check it.

With `first_in_range`, `cohorts_complete` is always `true`. POST `/api/retention` takes the same `cohort`.

## Related

- [Funnels](/docs/funnels)
- [Flows](/docs/flows)
- [Users and accounts](/docs/users-and-accounts)
- [Identify your users](/docs/identify-users)
- [Users and identity](/docs/users-and-identity)
- [Filters, date ranges and saved views](/docs/filters-and-saved-views)
- [Limits](/docs/limits)
