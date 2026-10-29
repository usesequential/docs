# Users and accounts

> Find a person by the id your app sends, see their sessions and open the replays. See the accounts that your people belong to.

> **In short**
>
> - The **People** page lists who used the product in the last 7 days, grouped by user id. Events without a user id are never a row.
> - Search by a name, an email, an account name or the exact id that your app sends to identify.
> - A person's page shows who the person is and their visits of the last 30 days, by day. It also shows the cases they ran into and what your app sent about them. Click a visit to watch it beside the page.
> - Workbench › **Accounts** lists the accounts of the project, the ones with problems first. Only Pendo and `sequential.account()` fill accounts. Sessions without an account are counted on one line, never as a row.
> - Click an account to open the account's page: its activity, its counts, its people, its cases and its properties.
> - A filter on **People** lists only the people who had a matching event in the window.
> - In Workbench › **Funnels**, **View them in People** lists the people of a funnel step. The list stays only in the browser tab that opened it.
> - **People** shows the last 7 days, or the last 14, 30 or 90 days that you choose in **Window**. **Accounts** and an account's page show the last **7 days**, **30 days** or **90 days**. A person's page has no date bar.

## What it is for

Use **People** and Workbench › **Accounts** to answer questions like:

- "A customer says checkout failed yesterday. What did they do?"
- "Who was active this week, on which browser, from which country?"
- "Which people at Acme Corp used the product this month?"

## How it works

Every stored event carries exactly one user id.

- **Before your app identifies the visitor**, the user id is an anonymous id. The Sequential SDK creates one the first time a browser loads your site. It keeps the id in that browser's storage.
- **After your app identifies the visitor**, the user id is the value your app passes. The Sequential SDK keeps the value, so later visits from that browser carry it too. The SDK keeps the value until your app calls `sequential.reset()` on sign-out.

Other SDKs have their own anonymous ids. Sequential does not store an id as anonymous. The lists decide it when they show the id: a user id with an identify event, or with a linked anonymous id, is identified.

The lists show a person by their name, or else by their email. Without either, they show the last 6 characters of an id that is longer than 14 characters. For an anonymous person, "Visitor" comes first, such as "Visitor 5b2f8a". For an identified person, "…" comes first, such as "…9c41e7". A list that does not know if the person is identified also shows "…". They show a shorter id as it is. A person without a name has a dashed avatar.

Sequential stores the value that your app passes to identify exactly as it is. If your app identifies one person with two values, Sequential sees two users.

With the Sequential SDK, PostHog or Mixpanel, a visitor who identifies counts as one person. This applies on **People**, on each person's page and on **Evidence**. A **Person id** condition with the identified value, or with a linked anonymous id, finds all of that person's events. See [Users and identity](/docs/users-and-identity).

An event without a user id is not a person. **People** does not list it or count it.

An event without a session id is not a session. The **Visits** column does not count it.

## Find a customer who reported a problem

1. Click **People** in the sidebar.
2. In the box "Name, email or account", type the person's name, email or account name. You can also type the exact value that your app passes to identify for that person.
3. Wait. The list shows up to 8 people who match.
4. Click the person. The person's page opens.

Type at least 2 characters. A name, an email or an account name can match in part, and upper and lower case do not matter. An id must match exactly. For a person who is identified, the start of the id also matches.

The search finds only the people seen in the last 7 days. If it finds nobody, it says "Nobody matching" and your text, then "was here in the last 7 days."

"This person is not in this project." means that no event that Sequential keeps has the id. Check that you have the exact id your app sends.

## Find the people who did something

Under the chips and the box, **People** has a filter bar. It works as the filter bar on the Workbench pages. See [Build a filter](/docs/filters-and-saved-views#build-a-filter).

1. Click **People** in the sidebar.
2. Click **Add a filter**.
3. Choose a field, an operator and a value, for example **Event** **is** `checkout_started`.
4. Press Enter, or click outside the condition. The list shows only the people who had a matching event in the window.

- The page says "A person matches when they had such an event in the window." Each top-level condition can match a different event.
- An **All of** or **Any of** group needs one event that matches the whole group. See [Groups](/docs/filters-and-saved-views#groups).
- A top-level negative condition finds the people who have no such event. The page says "A top-level “Is not” finds the people without one."
- **Past filters** lists your own last filters on **People**. See [Past filters](/docs/filters-and-saved-views#past-filters).
- **Saved filters**, under the filter bar, keeps a filter for everyone in the project. Workbench › **Sessions** and **Events** list the same saved filters. Opening one sets what they did. The window, the order and the team stay as they are. See [Save and open views](/docs/filters-and-saved-views#save-and-open-views).
- With a filter, the sentence at the top starts with "With this filter:". It then counts only the people who match.
- A row counts all of the person's visits in the window, not only the visits with a matching event. See **How a filter picks rows** below.
- If nobody matches, the list says, for example, "Nobody in the last 7 days matches this filter." and "Change or remove a condition to see more people."
- Sequential checks at most 5 conditions on what people did together. See **A filter on People: 5 conditions** under **Limits**.
- If Sequential refuses the filter, the reason shows under the bar. The list says "This filter could not run, so no people are shown. The bar says why."
- The box does not use the filter, the window or the order. While you search, the page says "The search finds a person by name, email or account; the filter, window and order apply to the list."

### Window and order

Under the filter bar, **Window** sets the days of the list: **Last 7 days**, **Last 14 days**, **Last 30 days** or **Last 90 days**. Sequential writes your choice into the address as `?days=`. Each window ends now.

**Order** sets the order of the list:

- **Latest activity first**: the person with the latest event comes first. This is the default.
- **Most visits**: the person with the most sessions in the window comes first.
- **Most actions**: the person with the most events in the window comes first.

With **Most visits** or **Most actions**, when two people have the same count, the person with the latest event comes first.

### People of one account

An address with `?account_id=` and an account id opens **People** with that account in the filter. For example, `/people?account_id=acme` adds the condition **Account id** **is** `acme`. The list then shows the people with an event of that account in the window. Click the **×** on the condition to remove it.

To open it from the app, click **Open in People** on an account's page, after **People in this account**. **People** then opens with that account and the window of the account's page: 7, 30 or 90 days. The button does not show when the account has no people in the list. An old address `/users?account_id=` opens **People** in the same way, with the shortest window that covers its old start date.

### People from a funnel

In Workbench › **Funnels**, **View them in People** opens a list of the people of a funnel step. Under the answer, the button opens the people who did every step. In **Who left here**, it opens the people who did the step and not the next step. See [See who dropped](/docs/funnels#see-who-dropped).

The title counts the people and tells who they are, for example "1,140 people who did every step" or "240 people who stopped after step 2". The line under it names the steps, for example "They did “Pricing” and not “Sign-up”." The list holds at most 1,000 people. With more, the line adds "This list shows the first 1,000 of them." These are the first 1,000 in the order of their ids, so the same funnel answer always gives the same list. The title still counts all of them.

The page has two tabs:

- **People** lists the people, the person with the latest event first. A row shows the person, **Visits** and **Last seen**, on the funnel's dates. Under the name, a row shows the email, or "Identified" or "Anonymous". Click a row to open the person's page. The page then shows a note: "From a funnel" and the dates of the funnel, then one sentence, such as "They did “Pricing” and did not go on to “Sign-up”." for a person who stopped, or "They did every step:" and the steps for a person who did every step. **Back to the list** opens the list again, and **×** closes the note. The note shows only in the tab that opened the list, as the list does. If the list is no longer open in the tab, for example after a reload, the person's page says once "The funnel list this link came from is no longer open in this tab." **Show 50 more** lists the next 50.
- **Their events** lists the latest 100 events of these people, on the funnel's dates. A line over them says, for example, "The latest events of these 240 people, 20 Oct to 27 Oct." For the people who stopped after a step, each of their events that matches that step gets the tag **Step** and the number of the step, and the line adds, for example, "Their events that match step 2, “Sign-up”, are marked." Sequential marks a step only when the step uses exact event names or event types. For any other step, the line says, for example, "Step 2’s events can’t be marked here." and no event gets a tag. For the people who did every step, no event gets a tag. Click an event to watch its session beside the page. **Person** shows the person beside the page. **Details** shows the fields of the event.

If none of them has an event on the funnel's dates, the page says "None of them were seen in the funnel's window." and "The funnel's people may have been removed since it ran." If Sequential cannot read the list, the page says why, with **Try again**.

The list stays only in the browser tab that opened it. In that tab, **Back** from a person's page shows the list again. This works for one hour after you click **View them in People**. A tab keeps at most 5 such lists. A reload, another tab, another project or a sign-out shows no list. A sign-out removes every such list from the tab, also a list that you did not open yet. This also happens when an open tab finds that your sign-in has ended, or that the tab is now in use by another member. The page then says "This list is no longer here." and "A list from a funnel stays only in the tab that opened it, until a reload and for one hour at most. Open it again from Funnels." **Open Funnels** opens Workbench › **Funnels**.

The address of the page holds only a random key, never the ids of the people. The ids go into the session storage of the tab. When the page opens, it removes them from the storage and keeps them in its memory.

## Read a person's page

The title shows the person in the same way as the lists. **All people** goes back to **People**.

The top of the page tells who the person is:

- **Who and how often**, for example "Amara Mensah from Mensah Events, on the Pro plan, has been here 9 times since 3 Sept." A person with no name and no email is "An identified person" when your app identified them, else "An anonymous visitor", with their country when Sequential knows it. The count is the person's sessions in all the data that Sequential keeps.
- **What went wrong**: how many of those sessions had a JavaScript error, and how many had a failed request. A request that the page stopped itself does not count. If the person ran into cases that are not dismissed, it says how many.
- **When and where**: when the person was last seen, on which browser and operating system, and the flag of their country. Then the time in recorded sessions, added up, with the words "in the product in all."

Under it are the buttons:

- **Watch their latest visit** opens the newest visit beside the page. If the newest visit has no recording to play, the button reads **Watch their latest recorded visit**. It opens the newest visit that has one.
- **All events of this person** opens Workbench › **Events** with the person's events since they were first seen.
- **All sessions in the finder** opens Workbench › **Sessions** with the person's sessions since they were first seen.

**Visits, last 30 days** lists the person's sessions of the last 30 days, by day, the most recent first. Each visit shows how long ago it started, its length and the verdict of background judging in one sentence. On the right, it shows the moment worth seeing and its time in the recording. In its place, it can show "No recording", or "Ready by" and a time while Sequential prepares the recording. It can also say why the recording cannot play. If the state of the recording did not come with the list, a visit can show "Recording state not known" until the page gets the state a moment later. Click a visit to watch it beside the page. **Events of this visit** opens its events in Workbench › **Events**.

The list shows 50 visits first. **Load more visits** shows the next 50, and a line counts the visits shown. If they do not load, it says "Could not read more visits." and the button reads **Try again**. With no visit, it says "No visit in the last 30 days."

**Cases they ran into** lists up to 20 cases that the person's own events hit in the last 7 days, the most recently seen first. The dismissed cases come last. Each row shows the case's number, its title, its kind and page, how many times it happened and when it was last seen. With none, the page says "No case in the last 7 days." If Sequential cannot read the cases, it says "Cases could not be read right now."

**What your app sent about them** shows the person's account and their user properties. It shows the newest value of each property that is not blank, up to 50, by name. When there are more than 50, it says "They have more traits than are shown here." If your app sends none, it says "No traits. Your app sends them with identify." **Raw values** shows the same traits as JSON, with **Copy JSON**. The last line gives the user id, then "· Identified" or "· Anonymous".

If Sequential cannot read the person, the page says why, with **Try again**. If more than 200 ids point to the person, often a shared or a test login, the page says "This person has more than 200 linked ids, too many to total on one page."

## Open a person's sessions and replays

On **People**, click a row to open the person's page. To see a person beside the list instead, select the row with **j** or **k** and press **o**.

On the person's page:

| Choose | Result |
|---|---|
| A visit | The replay of that visit, beside the page. |
| **All sessions in the finder** | Workbench › **Sessions**, filtered to that person. |
| **All events of this person** | Workbench › **Events** for that person. |

On a session's page, **All about** and the person's name open the person's page.

## The Accounts list

Open **Workbench** and click **Accounts**. The list shows every account of the project, up to 10,000, the ones with problems first.

Above the list are the filters: the range (**7 days**, **30 days** or **90 days**), the plan list and a box. The plan list reads "Every plan". The box reads "Find an account by name or exact id". The plan list shows only when an account has a plan. The list opens on **7 days**: today and the 6 days before it, as UTC days. A change applies a short time after you make it. If Sequential refuses the search or the plan, a message beside the box says why. To filter by health, use the health chips. See **Health** below. The page keeps the range and the filters in its address, so you can share a link to them.

Each row shows:

- **Account**: the account's name. An account without a name reads as its id. Under the name are the plan and, for an account with a name, the id. Click the row to open the account's page, with the range of the list.
- **People active**: the people active in the range, "of" all the people of the account, for example "9 of 14". When Sequential cannot count them, it reads "Unavailable". From 14 October 2026, a person counts in an account only when one of their own events carries the account id. Before, every person of a session that carried the account counted. The two differ only when two people used one session, for example on a shared device.
- **Sessions**: the sessions in the range that carry the account.
- **Health**: "3 sessions with a problem", "No problems" or "Quiet for 4 days".
- **Last 30 days**: the sessions of each day in the last 30 days, ending today, as a small chart. This column does not change with your range.
- **Last active**: when the account was last active, at any time.

The list shows 50 accounts at a time. **Show 50 more** shows the next 50. If they do not load, the list says why, with **Try again**. Above the rows, a line counts the sessions in the range that have no account, for example "11 sessions in the last 7 days carried no account id, so they are in no account here."

Pendo fills accounts, from the `account.id` you pass to `pendo.initialize`. The Sequential SDK fills them from `sequential.account(id, traits)`. See [Sequential SDK](/docs/sequential). Group calls from PostHog (`posthog.group`), Mixpanel (`set_group`) and Amplitude (`setGroup`) are not used for accounts yet. From the Sequential SDK, Sequential reads an account id only from the top-level `account_id` of an event, never from an event property named `account_id`. The id can be a string or a number. Sequential trims it and keeps an id of 1 to 200 characters. A longer id gives no account: Sequential does not cut it.

### Accounts that did something

To list only the accounts that did something, build a filter under **What they did**, in the **Accounts that did something** card. The list then shows the accounts with an event that matches the filter in the range. Its columns are **People**, **Sessions**, **Events**, **Latest event** and **Last did it**. The plan, the health and the search do not apply then. **Show every account** removes the filter. See **How a filter picks rows** below.

### Health

- **With problems**: at least one session of the account in the range had a JavaScript error or a failed request. A request that the page or the browser stopped is not a failure.
- **No problems**: the account had sessions in the range, and none had a problem.
- **Quiet**: the account had no session in the range. "Quiet for 4 days" counts the days since its last activity.

Over the list, a chip for each health shows how many accounts have it, with your range, plan and name filters. **All** shows how many there are in all. Click a chip to show only those accounts. Click **All** to show all of them again. A line then says what the list shows, for example "Showing the 3 accounts with a problem."

The list shows the accounts with problems first, the most sessions with problems first. Then it shows the accounts with no problems and the quiet accounts, the most recently active first.

### Name and plan

Sequential reads an account's name and plan from the account properties that your app sends. For the name, it uses the first of `$name`, `name`, `company_name`, `account_name`, `organization_name`, `organisation_name`, `org_name` and `business_name` that has a value. For the plan, it uses `plan`, `$plan` or `plan_name`. Sequential keeps the newest value of each property that is not blank, so a later call without the name does not remove it. With the Sequential SDK, these properties are the traits of `sequential.account(id, traits)`.

When no account in the list has a name or a plan, a note over the list says so.

### Find an account

Type an account's name, or a part of it, in the box. Upper and lower case do not matter for a name. You can also type the full id of an account. An id must match exactly, with its case.

## Read an account's page

Click an account on **Accounts** to open its page. A session belongs to the account when one of its events carries the account id.

The title is the account's name, else its id. A sentence under it counts the account's sessions and people in the range. It compares the sessions with the same number of days before, and counts the sessions with a problem. **All accounts**, or the key **u**, goes back to the list with the same range.

Under the title are the range chips: **7 days**, **30 days** and **90 days**. A link from **Accounts** keeps the range of the list. A range is today and the days before it, as UTC days.

A line of facts shows:

- **Account id**.
- **Plan**, or "Not sent".
- **People**: all the people of the account, or "Unavailable".
- **First seen**: the day of the account's first event that Sequential keeps.
- **Last active**.

When the account has no name and no plan, a note says that your site sends none.

The cards under the facts:

- **Activity**: the account's sessions per day in the range. A sentence over the chart gives the total and the busiest day.
- **This range and the one before**: a table that compares the range with the same number of days before it. Its columns are, for example, **Last 7 days** and **7 days before**. Its rows are **Sessions**, **People active**, **Sessions with a problem** and **People who hit a problem**. Under it, a line gives the share, for example "3 of 41 sessions (7.3%) had a JavaScript error or a failed request." **See the 41 sessions**, or the key **s**, opens Workbench › **Sessions** with the account's sessions in the range. **The 3 with a problem** opens only the sessions with a problem.
- **People in this account**: up to 6 people, from all the data that Sequential keeps. The card lists the same people that the **People** fact counts. The people with the most sessions with a problem in the range come first, then the most recently seen. A line over the list counts them and the people not seen in the last 7 days, for example "Showing 6 of 14 people, problems first; 3 not seen in the last 7 days." Each row shows the person, their sessions with a problem in the range, and when they were last seen. Click a person to see them beside the page. With no one, it says "No person carries this account yet. People join it when their own events carry its id."
- **Cases its people ran into**: the cases that the account's people hit in the last 7 days, the most people first. Each row shows the case's number, its title, its kind and page, and how many of the account's people it hit. It also shows "from your server" for a case from your server, when the case was last seen, and "dismissed" for a dismissed case. With none, it says "No case in the last 7 days."
- **What your site sent about it**: the newest value of each account property that is not blank, and when it was set. It shows up to 50 properties, by name. A value shows up to 200 characters. With 50, a line says "The first 50 traits, by name." If your app sends none, it says "No account traits. Your site sends them with the account (for example name, company_name and plan)."

Each card has its own state. If Sequential cannot read one card, only that card says so, for example "The people could not be read right now.", with **Try again**.

If no event that Sequential keeps carries the id, the page says "No account with this id in this project." with the link **See every account**. If Sequential cannot read the account, it says "This account could not be read right now." with **Try again**. An id of more than 200 characters gets a message, and Sequential does not read it.

## When the Accounts list is empty

| The page says | What it means |
|---|---|
| "No account yet." and "Accounts appear once your site sends an account id with its events." | The project has no account. |
| "No account matches." and "Clear the plan or the search to see every account." | No account matches your plan or your search. |
| "No account hit a problem in the last 7 days." | You chose **With problems**, and no account had a problem in the range. |
| "No account had sessions without a problem in the last 7 days." | You chose **No problems**. |
| "Every account had a session in the last 7 days." | You chose **Quiet**. |
| "No account did this in 7 days." and "Try a longer range, or change what they did." | No account had an event that matches **What they did** in the range. |
| "Accounts could not be read right now." | Sequential could not read the list. The message says when to try again. Click **Try again**. |

The range alone never empties the list: an account without sessions in the range shows as quiet.

If Sequential cannot count the people of an account, the **People active** cell shows "Unavailable".

## What it needs

- **Identify.** Without it, every row is an anonymous id. Until your app identifies the visitor, a second device, a private window or cleared storage makes the same person a new user. And you cannot find anyone by your own id. See [Identify your users](/docs/identify-users).
- **An account id, for accounts.** Send it with Pendo or with the Sequential SDK's `sequential.account()`. See [Pendo](/docs/pendo) and [Sequential SDK](/docs/sequential).

## Limits

- **Amplitude, Pendo or Smartlook: identify does not join the ids.** Only the Sequential SDK, PostHog or Mixpanel sends the link. With Amplitude, Pendo or Smartlook, the anonymous id and the identified id stay two people on every page. A person's page, **All sessions in the finder**, **All events of this person** and a **Person id** filter find only the events stored under that id.
- **Amplitude, Pendo or Smartlook: a sign-up session shows twice.** With Amplitude, Pendo or Smartlook, if your app identifies a visitor mid-session, that session counts in two rows of **People**, once under each id.
- **Pages of 50.** The **People** list shows 50 people at a time. **Show 50 more** lists the next 50. The person seen most recently comes first, unless you choose another **Order**.
- **The counts cover the window.** The sentence at the top of **People** counts every person of the window, not only the rows that are loaded. It also counts the hidden one-page visitors. When Sequential cannot count the people in 2 seconds, the sentence reads "Who used the product in the last 7 days." When it cannot count the segments in 2 seconds, those counts read "—".
- **Events without a user id are not on the People page.** An event without a user id is not a person. **People** does not list it or count it.
- **Smartlook splits people.** With Smartlook, each identified person appears as two people.
- **The People page shows only a name and an email.** The **People** list does not show user properties. Like the other lists, it shows only a name and an email from an identify call. A person's page shows user properties under **What your app sent about them**.
- **Some sources give no user properties.** The Sequential SDK and PostHog give none. Mixpanel's browser SDK gives no user properties.
- **A recording without a user id has no Earlier or Later.** On a site with only Smartlook, a session page shows no **Earlier** or **Later** button. See **Why a recording has no user id** below.
- **Identified uses all the data.** Under the name, a row of **People** shows the email when the name is not the email. Otherwise it shows "Identified" for an identified person and "Anonymous" for any other. This rule uses all the data that Sequential keeps, not only the days that the list shows. A person's page uses the same rule. The **Identified** chip lists the people of the list's days who are identified by this rule. The "identified" count in the sentence at the top of **People** uses the same rule. A row's name and email also come from all the data that Sequential keeps. The hidden one-page visitors use the rule too: a person who is identified is never one of them.
- **Search finds a name set earlier.** The box on **People** and [Search or jump to](/docs/search-or-jump-to) also find a person by a name or an email set more than 7 days ago. The person must be seen in the last 7 days.
- **Search results count whole weeks.** The box on **People** always searches the last 7 days. **Window**, **Order** and the filter do not change it. In its results, the column reads "Visits since" and a Monday, for example "Visits since 19 Oct". It counts the sessions from that Monday (UTC) up to now. The Monday starts the week of the day 7 days ago.
- **People's window ends now.** The **People** list covers the last 7 days, or the 14, 30 or 90 days that you choose in **Window**. It counts them to the hour, up to now. Workbench › **Accounts** counts whole UTC days, today included.
- **A filter on People: 5 conditions.** Sequential checks at most 5 conditions on what people did together. An **All of** or **Any of** group counts as one. The items of a **None of** or **Not all of** group count one by one. Over 5, the bar says, for example, "Sequential checks at most 5 conditions on what people did together (this filter has 6)." The page says "The list waits until the filter fits." The list stays as it is until the filter has 5 conditions or fewer.
- **Accounts keeps its view in the address.** The range, the plan, the health, the search and **What they did** are in its link. An account's page keeps its range in its link. **People** keeps only a `?days=` window, and the `?account_id=` that it opens with. Its filter, its order and its chips are not in its link.
- **Accounts: 50 at a time, up to 10,000.** A project with more accounts shows its 10,000 most recently active accounts, and the sentence at the top says so.
- **Accounts: the Last 30 days column does not follow the range.** It always shows the last 30 days, ending today.
- **Accounts: no export, no column choice and no saved filters.**
- **An account's page: the people, the facts and the properties use all the data that Sequential keeps.** Only the counts, the order of the people and **Activity** follow the range. The cases always cover the last 7 days.
- **A person's page has no date bar.** A person's page lists their visits of the last 30 days. **Backend activity** also covers the last 30 days. The sentence at the top of a person's page covers all the data that Sequential keeps. The cases cover the last 7 days.

### How the People page and dates work

Sequential does not rank identifier types, and it does not guess that two values are one person. Only the Sequential SDK, PostHog or Mixpanel sends the link. [Users and identity](/docs/users-and-identity) explains the model.

The People page groups the events of the window by the id, after that link, for the project selected in the sidebar. A row shows:

- **Person**: the person, as **How it works** describes. The avatar shows the initials of the name. A person without a name has a dashed avatar. A flag shows the person's country. A red dot means a session with an error or a failed request in the window. For the line under the name, see **Identified uses all the data** under **Limits**.
- **Visits, 7 days**: the person's sessions in the window. With another window, the head names its days, for example "Visits, 30 days".
- **Last seen**: their latest event, as a time ago.

The sentence at the top counts the people of the window, for example "120 people visited in the last 7 days; 40 of them are identified, 31 came back, 12 hit a problem." With a filter, it counts only the people who match, and it starts with "With this filter:".

The chips above the list are its segments:

- **Everyone**.
- **Identified**: the people of the list's days who are identified by the rule in **Identified uses all the data**, under **Limits**.
- **Came back**: 2 or more sessions in the window.
- **Hit a problem**: a session with a JS error or a failed request in the window.

Click a chip to show that segment in the list. With a segment that has nobody, the list says so, for example "Nobody came back in the last 7 days."

The person seen most recently comes first. **Order** can put the most visits or the most actions first. See **Window and order**.

The one-page visitors are hidden at first. They are the people who are not identified and sent at most one event in the window. A chip, for example **Show 12 one-page visitors**, shows them. **Hide one-page visitors** hides them again.

The window is the last 7 days to the hour, up to now. **Window** changes it to the last 14, 30 or 90 days. An address with `?days=30` opens the last 30 days: the Brief links to it. `?days=` takes 7, 14, 30 or 90. Any other value opens the last 7 days.

### What a person's page shows

- **The top** shows the name and sentences about the person: who they are, how often they came and what went wrong. It also says when and where they were last seen. It has **Watch their latest visit**, **All events of this person** and **All sessions in the finder**.
- **Backend activity, last 30 days** is above the visits. It shows the events that your server sent for this person with the [backend SDK](/docs/backend-sdk), newest first, at most 20. Each row shows the event name and how long ago it happened. **in a visit** opens the event's browser session. The card shows names only, never property values. **Raw** in a row shows the row as JSON: the event name, its time and its session id, with **Copy JSON**. If the last 30 days have no server event, the card does not show.
- **Visits, last 30 days** lists the person's sessions by day, the most recent activity first. It shows 50 at a time. **Load more visits** shows the next 50.
- **Cases they ran into** and **What your app sent about them** come after the visits.

### Which dates a person's page uses

A person's page has no date bar. **Visits** and **Backend activity** cover the last 30 days, as UTC days, today included. The sentences at the top and **What your app sent about them** use all the data that Sequential keeps. **Cases they ran into** covers the last 7 days.

The page opens in the same way from every link.

### More actions in the People list

- On **People**, press **j** and **k** to move through the rows. Press **↵** to open the selected person's page, or **o** to see the person beside the list.
- On a person's page, **j** and **k** move through the visits. **↵** opens the selected visit beside the page.

You can also open a person from other pages:

- On a session's page, click **All about** and the person's name. In a session beside a page, click the person's name.
- In Workbench › **Funnels**, under **Who left here**, click a person under **The people**.
- On the page that **View them in People** opens, click a row.
- In Workbench › **Events**, click **Person** on a matching event.
- On an account's page, click a person under **People in this account**.
- In [Search or jump to](/docs/search-or-jump-to), type a name, an email or an account name.

From Funnels, Events and an account's page, the person opens beside the page. [Find and replay sessions](/docs/sessions-and-replay) covers the player.

### Open a person's page from a URL

If you already know the id, you can open `/people/<the id>` directly.

URL-encode the id first. For example, write a `/` in the id as `%2F`. An older `/user-detail?user_id=<the id>` link opens the same page.

"This person is not in this project." means that no event that Sequential keeps has the id. Under it, the page says "They may belong to another project, or Sequential has not seen them yet."

### A session that starts before identify, on a person's page

Sequential stores the events sent before identify under the anonymous id. If someone signs up during a session, this is the first part of that session. With the Sequential SDK, PostHog or Mixpanel, the People page shows the whole session under the identified value and counts it once. With Amplitude, Pendo or Smartlook, if your app identifies a visitor mid-session, that session counts in two rows of **People**, once under each id.

With the Sequential SDK, PostHog or Mixpanel, the person's page also shows the whole session. Its start time and duration include the part before identify. The person's page also lists the earlier sessions from before identify. With Amplitude, Pendo or Smartlook, the session on the person's page covers only the part after identify, and the earlier sessions are not listed.

### How a filter picks rows

A filter picks whole rows. Under **Accounts that did something**, each row counts all of the account's events in the range, not only the matching events. On **People**, each row counts all of the person's visits in the window, not only the visits with a matching event. For example, with the filter **Event** is `checkout`, an account with a page view, a checkout and a sign-up shows 3 events.

- With **All of**, each condition is checked on its own. An account is listed when it has an event that matches each condition. On **People**, a person is listed in the same way, with events in the window.
- The line about sessions without an account counts only the sessions that did what the filter says.
- An agent's `list_users` and `list_entities` with a filter count in the same way: all of each row's events.

### Why Smartlook splits people

With Smartlook, only the identify call carries your id. Every other event stays under the Smartlook visitor id. Because of this, each identified person appears as two people.

### Why a recording has no user id

On a session page, **Earlier** and **Later** step through that person's recordings. The keys are [ and ]. They use the recording's own user id.

On the web, the recording takes that id from the page while it records. It takes it from PostHog, Mixpanel, Pendo or the Sequential SDK, or from Amplitude after `setUserId()`. Smartlook is not in that list.

In these cases the session page shows neither button:

- Only Smartlook is on the page.
- The visitor is an anonymous Amplitude visitor.
- The Sequential SDK is on the page, and the browser blocks storage.

A button also does not show when that person has no earlier or later recording. The session page and the person's page still show the person, from the session's events.

### Where to see user and account properties

Sequential stores user and account properties on each event.

- **User properties.** The lists do not show them. They show only a name and an email, from identify events. A person's page shows user properties under **What your app sent about them**. The **Info** tab of a session page shows them under **Their properties**, when the latest event of the session carries them.
- **Account properties.** The **Accounts** list shows an account's name and plan. The account's page shows all of its account properties, under **What your site sent about it**.
- **Filters.** The **Visitor property** and **Account property** filter fields. Each matches one property by its name, with a type and an operator. See [Property conditions](/docs/filters-and-saved-views#property-conditions).

### Properties by source

Whether you have properties depends on the source.

| Source | User properties | Accounts |
|---|---|---|
| Sequential SDK | None. Properties passed to `identify()` are stored on its `$identify` event, and `register()` properties on every later event. The text props of `identify(id, props)` show as traits on a person's page | The traits of `sequential.account(id, traits)` |
| PostHog | None. `posthog.setPersonProperties()` leaves `$set` and `$set_once` on its `$set` event as JSON. From `posthog.identify()` on the web, a name or email shows on the lists, in the title of a session page and on a person's page. Other properties passed there do not appear. | None |
| Mixpanel | Not from `mixpanel.people.set`: Sequential does not store it. A group update (`/groups`) is stored as user properties on a user with no id. | None |
| Amplitude | `set` and `setOnce` from an `Identify`. `add`, `append` and `unset` are ignored. | None |
| Pendo | Visitor metadata, and the properties on `pendo.track` calls. | `account.id` and account metadata |
| Smartlook | `identify` properties and `smartlook('properties', …)`, on the identify event only | None |

[What each SDK supports](/docs/support-matrix) has the details.

## Related

- [Users and identity](/docs/users-and-identity)
- [Identify your users](/docs/identify-users)
- [Find and replay sessions](/docs/sessions-and-replay)
- [Filters, date ranges and saved views](/docs/filters-and-saved-views)
- [Funnels](/docs/funnels)
- [Pendo](/docs/pendo)
- [What each SDK supports](/docs/support-matrix)
