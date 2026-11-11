# People and accounts: find a person and see what they did

> Find a person by the id your app sends, see their sessions and open the replays. See the accounts that your people belong to.

> **At a glance**
>
> - **Default:** People shows the last 7 days. Window chooses 14, 30 or 90 days.
> - **Before you start:** [Identify the people in your app](/docs/identify-users). Without it, every row is an anonymous id.
> - **Before you start:** Accounts: only [Pendo](/docs/pendo) and `sequential.account()` fill accounts.
> - **Know this:** People groups events by user id. Events without a user id are never a row.
> - **Know this:** With Amplitude, Pendo or Smartlook, one person can show as two people.

## Find a customer who reported a problem

1. Click **People** in the sidebar.

2. In the box "Name, email or account", type a name, an email, an account name or the exact id that your app sends to identify.

3. Wait.

   Result: The list shows at most 8 people who match. The search finds only the people seen in the last 7 days.

4. Click the person.

   Result: The person's page opens. It shows who the person is and their sessions of the last 30 days, by day. It also shows the cases they ran into and what your app sent about them.

5. Under Visits, last 30 days, click a session.

Result: The replay of that session opens in the peek. In the app, a visit is a session.

Type at least 2 characters. A name, an email or an account name can match in part, and upper and lower case do not matter. An id matches exactly, or by its start for a person who is identified.

If the search finds nobody, it says "Nobody matching" and your text, then "was here in the last 7 days." If you already know the id, open `/people/<the id>` directly: see [How do I open a person's page from a URL?](#open-a-person-s-page-from-a-url) in the FAQ.

| Message | Where | What it means | What to do |
|---|---|---|---|
| "This person is not in this project." | A person's page | No event that Sequential keeps has the id. | Check that you have the exact id your app sends. |

## Find the people who did something

1. Click **People** in the sidebar.

2. Click **Add a filter**.

3. Choose a field, an operator and a value, for example **Event** **is** `checkout_started`.

4. Press Enter, or click outside the condition.

Result: The list shows only the people who had a matching event in the window.

A row counts all of the person's sessions in the window, not only the sessions with a matching event. The filter works as the filter bar on the Workbench pages: [Build a filter](/docs/filters-and-saved-views#build-a-filter).

### How filters on People work in detail

From 2 November 2026, under the chips and the box, People has one bar for the filter, the window and the order. On a wide screen, it holds Add a filter (with conditions: the conditions and Add), Saved filters with their count, Save…, Past filters, Window, Order and Hide our team. On a phone, Window, Order, Past filters and Hide our team are behind one button, for example 7 days · Latest.

- With a condition, the page shows the filter as a sentence, with Clear. Without a condition, it shows neither. Each top-level condition can match a different event.
- An All of or Any of group needs one event that matches the whole group. See [Groups](/docs/filters-and-saved-views#groups).
- A top-level negative condition finds the people who have no such event.
- Past filters lists your own last filters on People. See [Past filters](/docs/filters-and-saved-views#past-filters).
- Saved filters in the bar opens a menu of the filters that the project keeps for everyone. With a filter, Save… opens the menu at the name of the new saved filter. Viewers do not see Save…. Workbench › Sessions and Events list the same saved filters. Opening one sets what they did. The window, the order and the team stay as they are. See [Save and open views](/docs/filters-and-saved-views#save-and-open-views).
- With a filter, the scope line under the headline starts with "With this filter". The sentence behind How counted ▾ starts with "With this filter:". The headline and the sentence then count only the people who match.
- Sequential checks at most 5 conditions on what people did together. See A filter on People: 5 conditions, in How the People and Accounts limits work in detail, under Limits.
- If Sequential refuses the filter, the reason shows under the bar.
- The box does not use the filter, the window or the order.

People of one account: for example, `/people?account_id=acme` adds the condition Account id is `acme`. The list then shows the people with an event of that account in the window. Click the × on the condition to remove it. To open it from the app, click Open in People on an account's page, after People in this account. People then opens with that account and the window of the account's page: 7, 30 or 90 days. The button does not show when the account has no people in the list. An old address `/users?account_id=` opens People in the same way, with the shortest window that covers its old start date.

#### Messages of the filter

| Message | Where | What it means | What to do |
|---|---|---|---|
| "A person matches when they had such an event in the window." | With a condition | The page shows the filter as a sentence, with Clear, and this line. | — |
| "A top-level “Is not” finds the people without one." | With a top-level negative condition | A top-level negative condition finds the people who have no such event. | — |
| "Nobody in the last 7 days matches this filter." | The list | If nobody matches, the list says, for example, this message. It also says "Change or remove a condition to see more people." | — |
| "This filter could not run, so no people are shown. The bar says why." | The list | Sequential refused the filter. The reason shows under the bar. | — |
| "The search finds a person by name, email or account; the filter, window and order apply to the list." | While you search | The box does not use the filter, the window or the order. | — |

### Window and order

| In the bar | What it does |
|---|---|
| Window | Sets the days of the list: Last 7 days, Last 14 days, Last 30 days or Last 90 days. Each window ends now. Sequential writes your choice into the address as `?days=`. |
| Order: Latest activity first | The person with the latest event comes first. This is the default. |
| Order: Most visits | The person with the most sessions in the window comes first. |
| Order: Most actions | The person with the most events in the window comes first. |
| Hide our team | Leaves out the sessions of the people marked as your team. When nobody is marked, click Mark your team next to it to open your team in Settings › Project. |

With Most visits or Most actions, when two people have the same count, the person with the latest event comes first.

The one-page visitors are hidden at first. A chip at the end of the scope line, for example Show 12 one-page visitors, shows them.

From 8 November 2026, a project whose events of the last 30 days come from a mobile app uses app words. The chip says, for example, "Show 12 one-event visitors" or "Hide one-event visitors", and the headline says "Everyone did one thing and left." A one-event visitor is an anonymous person with one event in the window, such as one screen view or one app start. A project with both a website and an app uses the app words too. A project with only a website keeps the page words.

### How the People page and dates work

Sequential does not rank identifier types, and it does not guess that two values are one person. Only the Sequential SDK, PostHog or Mixpanel sends the link. [User ids and identity](/docs/users-and-identity) explains the model.

The People page groups the events of the window by the id, after that link, for the project selected in the sidebar. A row shows:

- Person: the person, as How People names and counts a person describes. The avatar shows the initials of the name. A person without a name has a dashed avatar. A flag shows the person's country. A red dot means a session with an error or a failed request in the window. For the line under the name, see Identified uses all the data, in How People names and counts a person.
- Visits, 7 days: the person's sessions in the window. With another window, the head names its days, for example "Visits, 30 days".
- Last seen: their latest event, as a time ago.

From 8 November 2026, the top of People has a headline and a scope line:

- The headline counts the people that the list shows, for example "33 of 147 people hit a problem." When none of them hit a problem, it says "Nobody hit a problem." When nobody used the product in the window, it says "Nobody used the product." When the list hides everyone as one-page visitors, it says "Everyone viewed one page and left." When Sequential cannot count the segments in time, it says only how many people visited, for example "120 people visited."
- The scope line gives the window, for example "Last 7 days, rolling". With a filter, it starts with "With this filter". When Hide our team leaves out people, it adds, for example, "Your team’s 12 left out". The one-page visitors chip is at its end. Then comes "How counted ▾".
- "How counted ▾" shows the sentence that the page showed before, word for word. It counts all the people of the window, for example "120 people visited in the last 7 days; 40 of them are identified, 31 came back, 12 hit a problem." With a filter, it counts only the people who match, and it starts with "With this filter:". While the one-page visitors are hidden, it adds, for example, "The headline and the chips count the 147 people the list shows." When Sequential cannot count the people of the list, the sentence shows under the headline. When the sentence only repeats the headline, it does not show.

The chips above the list are its segments. From 8 November 2026, each chip shows the number of people that it lists. While the search box shows its results, the chips show no number:

- Everyone.
- Identified: the people of the list's days who are identified by the rule in Identified uses all the data.
- Came back: 2 or more sessions in the window.
- Hit a problem: a session with a JS error or a failed request in the window.

Click a chip to show that segment in the list. With a segment that has nobody, the list says so, for example "Nobody came back in the last 7 days."

The person seen most recently comes first. Order can put the most visits or the most actions first. See Window and order.

The one-page visitors are hidden at first. They are the people who are not identified and sent at most one event in the window. A chip at the end of the scope line, for example Show 12 one-page visitors, shows them. Hide one-page visitors hides them again.

The window is the last 7 days to the hour, up to now. Window changes it to the last 14, 30 or 90 days. An address with `?days=30` opens the last 30 days: the Brief links to it. `?days=` takes 7, 14, 30 or 90. Any other value opens the last 7 days.

### People from a funnel

1. Go to **Workbench › Funnels**.

2. Click **View them in People**, under the answer or in **Who left here**.

Result: A list of the people of the funnel step opens.

Under the answer, the button opens the people who did every step. In Who left here, it opens the people who did the step and not the next step. See [See who dropped](/docs/funnels#see-who-dropped).

The list stays only in the browser tab that opened it, for one hour at most. A reload, another tab, another project or a sign-out shows no list.

### How the funnel list works

The title counts the people and tells who they are, for example "1,140 people who did every step" or "240 people who stopped after step 2". The line under it names the steps, for example "They did “Pricing” and not “Sign-up”." The list holds at most 1,000 people. With more, the line adds "This list shows the first 1,000 of them." These are the first 1,000 in the order of their ids, so the same funnel answer always gives the same list. The title still counts all of them.

The page has two tabs:

- People lists the people, the person with the latest event first. A row shows the person, Visits and Last seen, on the funnel's dates. Under the name, a row shows the email, or "Identified" or "Anonymous". Click a row to open the person's page. The page then shows a note: "From a funnel" and the dates of the funnel, then one sentence, such as "They did “Pricing” and did not go on to “Sign-up”." for a person who stopped, or "They did every step:" and the steps for a person who did every step. Back to the list opens the list again, and × closes the note. The note shows only in the tab that opened the list, as the list does. If the list is no longer open in the tab, for example after a reload, the person's page says once "The funnel list this link came from is no longer open in this tab." Show 50 more lists the next 50.
- Their events lists the latest 100 events of these people, on the funnel's dates. A line over them says, for example, "The latest events of these 240 people, 20 Oct to 27 Oct." For the people who stopped after a step, each of their events that matches that step gets the tag Step and the number of the step, and the line adds, for example, "Their events that match step 2, “Sign-up”, are marked." Sequential marks a step only when the step uses exact event names or event types. For any other step, the line says, for example, "Step 2’s events can’t be marked here." and no event gets a tag. For the people who did every step, no event gets a tag. Click an event to watch its session in the peek. Person shows the person in the peek. Details shows the fields of the event.

If none of them has an event on the funnel's dates, the page says "None of them were seen in the funnel's window." and "The funnel's people may have been removed since it ran." If Sequential cannot read the list, the page says why, with Try again.

How long the list stays: the list stays only in the browser tab that opened it. In that tab, Back from a person's page shows the list again. This works for one hour after you click View them in People. A tab keeps at most 5 such lists. A reload, another tab, another project or a sign-out shows no list. A sign-out removes every such list from the tab, also a list that you did not open yet. This also happens when an open tab finds that your sign-in has ended, or that the tab is now in use by another member. The page then says "This list is no longer here." and "A list from a funnel stays only in the tab that opened it, until a reload and for one hour at most. Open it again from Funnels." Open Funnels opens Workbench › Funnels.

The address of the page holds only a random key, never the ids of the people. The ids go into the session storage of the tab. When the page opens, it removes them from the storage and keeps them in its memory.

## Read a person's page

The title shows the person in the same way as the lists. From 8 November 2026, a pill next to the title says what they ran into, for example "Ran into 1 open case" or "No error or failed request". Click All people to go back to People.

| Part, from the top | What it shows | Dates |
|---|---|---|
| The top | How often they came, the cases they ran into, the facts about them and their visits per day. Then the buttons Watch their latest visit, All events of this person and All sessions in the finder. | All the data that Sequential keeps. The cases: the last 7 days. The visits per day: the last 30 days |
| Cases they ran into | At most 20 cases that the person's own events hit, the most recently seen first. | The last 7 days |
| Visits, last 30 days | The person's sessions by day, the most recent first. It first shows at most 5 sessions of the newest day. | The last 30 days |
| What your app sent about them | The person's account and their user properties, at most 50, by name. | All the data that Sequential keeps |
| Backend activity, last 30 days | The events that your server sent for this person, by event name, at most 20 kinds. Only on the full page, and only with a server event. | The last 30 days |

### How a person's page works in detail

From 8 November 2026, the top of the page has a headline, some rows and a scope line:

- The headline says how often the person came, for example "3 visits since 10 Sept" or "1 visit, on 10 Sept". A person with no visit has "No recorded visit yet." The count is the person's sessions in all the data that Sequential keeps. When the person ran into an open case, the headline also says what the visits recorded, for example "3 visits since 10 Sept · 1 with a failed request".
- The pill next to the name: when the person ran into a case that is not fixed and not dismissed, it says, for example, "Ran into 1 open case". Else it says what the visits recorded, for example "2 visits with an error", "1 visit with a failed request" or "Errors and failed requests". When no visit recorded an error or a failed request, it says "No error or failed request". A person with no visit has no pill.
- Ran into: the cases that the person ran into and that are not dismissed. Each case is a link, with its stage, for example Fixed. After 3 cases, a link such as "2 more" opens Cases they ran into.
- The facts: when the person was last seen, the browser and operating system, the flag of each country of their visits, the time in recorded sessions, added up, with "in all", and the account.
- Visits per day, on the full page: a bar for each of the last 30 days, as UTC days, when the person has 2 visits or more in them. A line under the bars says, for example, "3 visits on 3 days of the last 30." While more visits can be read, the line starts with "At least". The oldest day that is read is then a partial count. The days before it show no data. From 8 November 2026, point to a bar, tap it, or move along the bars with the arrow keys: the line under the bars then names that day and its visits, for example "30 Oct 2026 (UTC): 1 visit" or "10 Oct 2026 (UTC): no visit counted (a partial count)". Move away, or tap outside the bars, to see the sentence again.
- The scope line says "Counts from the recorded events" and "Cases: last 7 days". If Sequential cannot read the cases, it says "Cases could not be read right now".
- A person without a name has a dashed circle in place of the initials.

"How counted ▾" shows the sentences that the page showed before, word for word:

- Who and how often, for example "Amara Mensah from Mensah Events, on the Pro plan, has been here 9 times since 3 Sept." A person with no name and no email is "An identified person" when your app identified them, else "An anonymous visitor", with their country when Sequential knows it. The count is the person's sessions in all the data that Sequential keeps.
- What went wrong: how many of those sessions had a JavaScript error, and how many had a failed request. A request that the page stopped itself does not count. The next sentence names the cases that the person ran into and that are not dismissed, for example "They ran into 2 cases:" and the two titles. With more than 3, it says, for example, "They ran into 7 cases."
- When and where: when the person was last seen, and on which browser and operating system. Then the time in recorded sessions, added up, with the words "in the product in all." From 2 November 2026, when the visits in the list came from 2 countries or more, it adds, for example, "Visits from Czechia, Germany and France." The country with the most visits is first. After 3 countries, it says, for example, "and 2 other countries". On the full page, when your server sent events for the person in the last 30 days, it adds, for example, "Backend activity: 312 events in the last 30 days, the last 2 hours ago."

Under it are the buttons:

- Watch their latest visit opens the newest visit in the peek. If the newest visit has no recording to play, the button reads Watch their latest recorded visit. It opens the newest visit that has one.
- All events of this person opens Workbench › Events with the person's events since they were first seen.
- All sessions in the finder opens Workbench › Sessions with the person's sessions since they were first seen.

Cases they ran into is under the top of the page, before the visits. It lists up to 20 cases that the person's own events hit in the last 7 days, the most recently seen first. The dismissed cases come last. From 2 November 2026, each case is a card with its title and, for example, "3 of their visits". From 8 November 2026, the stage of the case follows, for example "3 of their visits · Fixed". For a case that none of their visits had, such as an error from your server outside a visit, it shows how many times it happened, for example "2 times · New". A dismissed case says "Dismissed". Point to a card to see the case's number, its kind and page, and when it was last seen.

Visits, last 30 days lists the person's sessions of the last 30 days, by day, the most recent first. From 2 November 2026, each visit has a line that shows how long ago it started, its length, the flag and the name of its country, an icon for the device (phone, tablet or desktop) and the browser on the operating system. When your server sent events in the visit, it also says, for example, "3 server events". Sequential leaves out a part that it does not know. Under the line is the verdict of background judging in one sentence. On the right are Events and a play button. The label of the play button names the moment worth seeing and its time in the recording: "Play from", the moment, "at" and the time. Without a moment, it says "Play the visit". In place of the play button, it can show "No recording", or "Ready by" and a time while Sequential prepares the recording. It can also say why the recording cannot play. If the state of the recording did not come with the list, a visit can show "Recording state not known" until the page gets the state a moment later. Click the verdict or the play button to watch the visit in the peek. Events opens the events of the visit in Workbench › Events.

From 2 November 2026, the list first shows up to 5 visits of the newest day. Show 2 more visits from 2 Nov shows the rest of that day, and All 14 visits shows all of them. When all are shown, Load more visits reads the next 50, and a line counts the visits shown. If they do not load, the button reads Try again.

What your app sent about them comes after the visits. It shows the person's account and their user properties. It shows the newest value of each property that is not blank, up to 50, by name. Raw values shows the same traits as JSON, with Copy JSON. The last line gives the user id, then "· Identified" or "· Anonymous".

Backend activity, last 30 days is at the bottom of the full page. From 2 November 2026, it groups the events that your server sent for this person with the [backend SDK](/docs/backend-sdk) by event name, at most 20 kinds. Each row shows the count, a bar for each day, how long ago the latest one happened, and up to 2 text properties of the latest one, with secrets shown as `[token]`. Latest › shows the latest event as JSON, with Copy JSON. All N events opens them in Workbench › Events. See [On the person's page](/docs/backend-sdk#on-the-person-s-page). If the last 30 days have no server event, the section does not show.

Which dates the page uses: a person's page has no date bar. Visits and Backend activity cover the last 30 days, as UTC days, today included. The headline, the sentences behind How counted ▾ and What your app sent about them use all the data that Sequential keeps. Visits per day covers the last 30 days. Cases they ran into and Ran into cover the last 7 days. The page opens in the same way from every link.

If Sequential cannot read the person, the page says why, with Try again.

#### Messages on a person's page

| Message | Where | What it means | What to do |
|---|---|---|---|
| "No visit in the last 30 days." | Visits, last 30 days | The person has no visit in the last 30 days. | — |
| "Could not read more visits." | Visits, last 30 days | More visits did not load. The button reads Try again. | — |
| "No case in the last 7 days." | Cases they ran into | The person ran into no case in the last 7 days. | — |
| "Cases could not be read right now." | Cases they ran into | Sequential cannot read the cases. | — |
| "They have more traits than are shown here." | What your app sent about them | The person has more than 50 properties. | — |
| "No traits. Your app sends them with identify." | What your app sent about them | Your app sends no user properties. | — |
| "This person has more than 200 linked ids, too many to total on one page." | A person's page | More than 200 ids point to the person, often a shared or a test login. | — |

### Open a person's sessions and replays

On People, click a row to open the person's page. To see a person in the peek instead, select the row with `j` or `k` and press `o`.

On the person's page:

| Choose | Result |
|---|---|
| A session | The replay of that session, in the peek. |
| All sessions in the finder | Workbench › Sessions, filtered to that person. |
| All events of this person | Workbench › Events for that person. |

On a session's page, click All about and the person's name to open the person's page.

## Why a person shows twice or as anonymous

Before your app identifies the person, the user id is an anonymous id. After, it is the value your app passes. With the Sequential SDK, PostHog or Mixpanel, a person who identifies counts as one person. With Amplitude, Pendo or Smartlook, the anonymous id and the identified id stay two people on every page.

- [User ids and identity](/docs/users-and-identity) explains the model.
- FAQ: [What happens to a session that starts before identify?](#a-session-that-starts-before-identify-on-a-person-s-page)
- FAQ: [Why does a recording have no user id?](#why-a-recording-has-no-user-id)

### How People names and counts a person

Every stored event carries exactly one user id.

- Before your app identifies the visitor, the user id is an anonymous id. The Sequential SDK creates one the first time a browser loads your site. It keeps the id in that browser's storage.
- After your app identifies the visitor, the user id is the value your app passes. The Sequential SDK keeps the value, so later visits from that browser carry it too. The SDK keeps the value until your app calls `sequential.reset()` on sign-out.

Without identify, every row is an anonymous id. Until your app identifies the person, a second device, a private window or cleared storage makes the same person a new person. And you cannot find anyone by your own id. See [Identify your users](/docs/identify-users).

Other SDKs have their own anonymous ids. Sequential does not store an id as anonymous. The lists decide it when they show the id: a user id with an identify event, or with a linked anonymous id, is identified.

The lists show a person by their name, or else by their email. Without either, they show the last 6 characters of an id that is longer than 14 characters. For an anonymous person, "Visitor" comes first, such as "Visitor 5b2f8a". For an identified person, "…" comes first, such as "…9c41e7". A list that does not know if the person is identified also shows "…". They show a shorter id as it is. A person without a name has a dashed avatar.

Sequential stores the value that your app passes to identify exactly as it is. If your app identifies one person with two values, Sequential sees two people.

With the Sequential SDK, PostHog or Mixpanel, a visitor who identifies counts as one person. This applies on People, on each person's page and on Evidence. A Person id condition with the identified value, or with a linked anonymous id, finds all of that person's events. See [User ids and identity](/docs/users-and-identity).

Amplitude, Pendo or Smartlook: identify does not join the ids. Only the Sequential SDK, PostHog or Mixpanel sends the link. With Amplitude, Pendo or Smartlook, the anonymous id and the identified id stay two people on every page. A person's page, All sessions in the finder, All events of this person and a Person id filter find only the events stored under that id.

With Smartlook, only the identify call carries your id. Every other event stays under the Smartlook visitor id, so each identified person appears as two people.

An event without a user id is not a person. People does not list it or count it.

An event without a session id is not a session. The Visits column does not count it.

Identified uses all the data. Under the name, a row of People shows the email when the name is not the email. Otherwise it shows "Identified" for an identified person and "Anonymous" for any other. This rule uses all the data that Sequential keeps, not only the days that the list shows. A person's page uses the same rule. The Identified chip lists the people of the list's days who are identified by this rule. The "identified" count in the sentence behind "How counted ▾" on "People" uses the same rule. A row's name and email also come from all the data that Sequential keeps. The hidden one-page visitors use the rule too: a person who is identified is never one of them.

## The Accounts list

1. Open **Workbench**.

2. Click **Accounts**.

Result: The list shows every account of the project, at most 10,000, the ones with problems first.

Pendo fills accounts from the `account.id` you pass to `pendo.initialize`. The Sequential SDK fills them from `sequential.account(id, traits)`. Group calls from PostHog (`posthog.group`), Mixpanel (`set_group`) and Amplitude (`setGroup`) are not used for accounts yet.

Sessions without an account are counted on one line, never as a row. Accounts and an account's page show the last 7 days, 30 days or 90 days. Accounts calls this window the range. The list opens on 7 days: today and the 6 days before it, as UTC days. Click a health chip over the list to show only those accounts.

| Column | What it shows |
|---|---|
| Account | The account's name. An account without a name reads as its id. Under the name are the plan and, for an account with a name, the id. Click the row to open the account's page, with the range of the list. |
| People active | The people active in the range, "of" all the people of the account, for example "9 of 14". When Sequential cannot count them, it reads "Unavailable". |
| Sessions | The sessions in the range that carry the account. |
| Health | "3 sessions with a problem", "No problems" or "Quiet for 4 days". |
| Last 30 days | The sessions of each day in the last 30 days, ending today, as a small chart. This column does not change with your range. |
| Last active | When the account was last active, at any time. |

### All options on the Accounts list

From 8 November 2026, a headline over the list says, for example, "14 of 143 accounts hit a problem.", "No account hit a problem." or "No account to count." A scope line under it names the range, for example "Last 30 days". It starts with "With this filter" when a plan or a search narrows the list, and it ends with "Only the 10,000 most recently active accounts are counted" when that applies. The sentence that the page showed before is under How counted ▾.

Above the list are the filters: the range (7 days, 30 days or 90 days), the plan list and a box. The plan list reads "Every plan". The box reads "Find an account by name or exact id". The plan list shows only when an account has a plan. A change applies a short time after you make it. If Sequential refuses the search or the plan, a message beside the box says why. To filter by health, use the health chips. Over the list, a chip for each health shows how many accounts have it, with your range, plan and name filters. All shows how many there are in all. Click a chip to show only those accounts. Click All to show all of them again. A line then says what the list shows, for example "Showing the 3 accounts with a problem." The page keeps the range and the filters in its address, so you can share a link to them.

The list shows 50 accounts at a time. Show 50 more shows the next 50. If they do not load, the list says why, with Try again. Above the rows, a line counts the sessions in the range that have no account, for example "11 sessions in the last 7 days carried no account id, so they are in no account here."

People active: from 14 October 2026, a person counts in an account only when one of their own events carries the account id. Before, every person of a session that carried the account counted. The two differ only when two people used one session, for example on a shared device. If Sequential cannot count the people of an account, the People active cell shows "Unavailable".

The account id: send it with Pendo or with the Sequential SDK's `sequential.account()`. See [Pendo](/docs/pendo) and [Sequential SDK](/docs/sequential). From the Sequential SDK, Sequential reads an account id only from the top-level `account_id` of an event, never from an event property named `account_id`. The id can be a string or a number. Sequential trims it and keeps an id of 1 to 200 characters. A longer id gives no account: Sequential does not cut it. [Sequential SDK](/docs/sequential) has the call.

### Accounts that did something

1. Open **Workbench › Accounts**.

2. In the **Accounts that did something** card, build a filter under **What they did**.

Result: The list shows the accounts with an event that matches the filter in the range.

Its columns are People, Sessions, Events, Latest event and Last did it. The plan, the health and the search do not apply then. Click Show every account to remove the filter. A row counts all of the account's events: see [How does a filter pick rows?](#how-a-filter-picks-rows) in the FAQ.

### Health

| Health | What it means |
|---|---|
| With problems | At least one session of the account in the range had a JavaScript error or a failed request. A request that the page or the browser stopped is not a failure. |
| No problems | The account had sessions in the range, and none had a problem. |
| Quiet | The account had no session in the range. "Quiet for 4 days" counts the days since its last activity. |

The list shows the accounts with problems first, the most sessions with problems first. Then it shows the accounts with no problems and the quiet accounts, the most recently active first.

### Name and plan

Sequential reads an account's name and plan from the account properties that your app sends. With the Sequential SDK, these properties are the traits of `sequential.account(id, traits)`.

| Field | Sequential uses |
|---|---|
| Name | The first of `$name`, `name`, `company_name`, `account_name`, `organization_name`, `organisation_name`, `org_name` and `business_name` that has a value |
| Plan | `plan`, `$plan` or `plan_name` |

Sequential keeps the newest value of each property that is not blank, so a later call without the name does not remove it. When no account in the list has a name or a plan, a note over the list says so.

### Find an account

Type an account's name, or a part of it, in the box. Upper and lower case do not matter for a name. You can also type the full id of an account. An id must match exactly, with its case.

### When the Accounts list is empty

The range alone never empties the list: an account without sessions in the range shows as quiet.

| Message | Where | What it means | What to do |
|---|---|---|---|
| "No account yet." | — | The project has no account. The page also says "Accounts appear once your site sends an account id with its events." | Send an account id with Pendo or with the Sequential SDK's `sequential.account()`. See [Pendo](/docs/pendo) and [Sequential SDK](/docs/sequential). |
| "No account matches." | — | No account matches your plan or your search. | The page says "Clear the plan or the search to see every account." |
| "No account hit a problem in the last 7 days." | — | You chose With problems, and no account had a problem in the range. | — |
| "No account had sessions without a problem in the last 7 days." | — | You chose No problems. | — |
| "Every account had a session in the last 7 days." | — | You chose Quiet. | — |
| "No account did this in 7 days." | — | No account had an event that matches What they did in the range. | The page says "Try a longer range, or change what they did." |
| "Accounts could not be read right now." | — | Sequential could not read the list. The message says when to try again. | Click Try again. |

## Read an account's page

1. Open **Workbench › Accounts**.

2. Click an account.

Result: The account's page opens: its activity, its counts, its people, its cases and its properties.

A session belongs to the account when one of its events carries the account id.

| Part, from the top | What it shows | Dates |
|---|---|---|
| Title | The account's name, else its id, and a sentence that counts its sessions and people. | The range |
| Range chips | 7 days, 30 days and 90 days. A link from Accounts keeps the range of the list. | — |
| Facts | Account id, Plan, People, First seen and Last active. | All the data that Sequential keeps |
| Activity | The account's sessions per day. | The range |
| This range and the one before | Sessions, People active, Sessions with a problem and People who hit a problem, for both. | The range and the same number of days before |
| People in this account | At most 6 people, the most sessions with a problem first. | All the data that Sequential keeps; the order follows the range |
| Cases its people ran into | The cases that the account's people hit, the most people first. | The last 7 days |
| What your site sent about it | At most 50 account properties, by name. | All the data that Sequential keeps |

### How an account's page works in detail

The title is the account's name, else its id. From 8 November 2026, a headline under it says, for example, "3 of 7 sessions hit a problem, for 2 people.", "None of the 5 sessions hit a problem.", "No session in this range." or "The counts could not be read right now." A scope line names the range and the active people, for example "Last 30 days · 2 people active". The sentence that compares the sessions with the same number of days before is under How counted ▾. All accounts, or the key `u`, goes back to the list with the same range.

Under the title are the range chips: 7 days, 30 days and 90 days. A link from Accounts keeps the range of the list. A range is today and the days before it, as UTC days.

A line of facts shows:

- Account id.
- Plan, or "Not sent".
- People: all the people of the account, or "Unavailable".
- First seen: the day of the account's first event that Sequential keeps.
- Last active.

When the account has no name and no plan, a note says that your site sends none.

The cards under the facts:

- Activity: the account's sessions per day in the range. A sentence over the chart gives the total and the busiest day.
- This range and the one before: a table that compares the range with the same number of days before it. Its columns are, for example, Last 7 days and 7 days before. Its rows are Sessions, People active, Sessions with a problem and People who hit a problem. Under it, a line gives the share, for example "3 of 41 sessions (7.3%) had a JavaScript error or a failed request." See the 41 sessions, or the key `s`, opens Workbench › Sessions with the account's sessions in the range. The 3 with a problem opens only the sessions with a problem.
- People in this account: up to 6 people, from all the data that Sequential keeps. The card lists the same people that the People fact counts. The people with the most sessions with a problem in the range come first, then the most recently seen. A line over the list counts them and the people not seen in the last 7 days, for example "Showing 6 of 14 people, problems first; 3 not seen in the last 7 days." Each row shows the person, their sessions with a problem in the range, and when they were last seen. Click a person to see them in the peek. With no one, it says "No person carries this account yet. People join it when their own events carry its id."
- Cases its people ran into: the cases that the account's people hit in the last 7 days, the most people first. Each row shows the case's number, its title, its kind and page, and how many of the account's people it hit. It also shows "from your server" for a case from your server, when the case was last seen, and "dismissed" for a dismissed case. With none, it says "No case in the last 7 days."
- What your site sent about it: the newest value of each account property that is not blank, and when it was set. It shows up to 50 properties, by name. A value shows up to 200 characters. With 50, a line says "The first 50 traits, by name." If your app sends none, it says "No account traits. Your site sends them with the account (for example name, company_name and plan)."

Each card has its own state. If Sequential cannot read one card, only that card says so, for example "The people could not be read right now.", with Try again.

An id of more than 200 characters gets a message, and Sequential does not read it.

#### Messages on an account's page

| Message | Where | What it means | What to do |
|---|---|---|---|
| "No account with this id in this project." | An account's page | No event that Sequential keeps carries the id. The page has the link See every account. | — |
| "This account could not be read right now." | An account's page | Sequential cannot read the account. | Click Try again. |

### People of one account

To see the account's people on People, click Open in People, after People in this account. People then opens with that account and the window of the account's page. An address with `?account_id=` and an account id opens People with that account in the filter.

## FAQ

### What questions do People and Accounts answer?

Use People and Workbench › Accounts to answer questions like:

- "A customer says checkout failed yesterday. What did they do?"
- "Who was active this week, on which browser, from which country?"
- "Which people at Acme Corp used the product this month?"

### How do I open a person's page from a URL?

If you already know the id, you can open `/people/<the id>` directly.

URL-encode the id first. For example, write a `/` in the id as `%2F`. An older `/user-detail?user_id=<the id>` link opens the same page.

"This person is not in this project." means that no event that Sequential keeps has the id. Under it, the page says "They may belong to another project, or Sequential has not seen them yet."

### Which keys and other pages open a person?

- On People, press `j` and `k` to move through the rows. Press `↵` to open the selected person's page, or `o` to see the person in the peek.
- On a person's page, `j` and `k` move through the visits. `↵` opens the selected visit in the peek.

You can also open a person from other pages:

- On a session's page, click All about and the person's name. In a session in the peek, click the person's name.
- In Workbench › Funnels, under Who left here, click a person under The people.
- On the page that View them in People opens, click a row.
- In Workbench › Events, click Person on a matching event.
- On an account's page, click a person under People in this account.
- In [Search or jump to](/docs/search-or-jump-to), type a name, an email or an account name.

From Funnels, Events and an account's page, the person opens in the peek. [Find and replay sessions](/docs/sessions-and-replay) covers the player.

### What happens to a session that starts before identify?

Sequential stores the events sent before identify under the anonymous id. If someone signs up during a session, this is the first part of that session. With the Sequential SDK, PostHog or Mixpanel, the People page shows the whole session under the identified value and counts it once. With Amplitude, Pendo or Smartlook, if your app identifies a visitor mid-session, that session counts in two rows of People, once under each id.

With the Sequential SDK, PostHog or Mixpanel, the person's page also shows the whole session. Its start time and duration include the part before identify. The person's page also lists the earlier sessions from before identify. With Amplitude, Pendo or Smartlook, the session on the person's page covers only the part after identify, and the earlier sessions are not listed.

### Why does a recording have no user id?

On a session page, Earlier and Later step through that person's recordings. The keys are `[` and `]`. They use the recording's own user id.

On the web, the recording takes that id from the page while it records. It takes it from PostHog, Mixpanel, Pendo or the Sequential SDK, or from Amplitude after `setUserId()`. Smartlook is not in that list.

In these cases the session page shows neither button:

- Only Smartlook is on the page.
- The visitor is an anonymous Amplitude visitor.
- The Sequential SDK is on the page, and the browser blocks storage.

A button also does not show when that person has no earlier or later recording. The session page and the person's page still show the person, from the session's events.

### How does a filter pick rows?

A filter picks whole rows. Under Accounts that did something, each row counts all of the account's events in the range, not only the matching events. On People, each row counts all of the person's visits in the window, not only the visits with a matching event. For example, with the filter Event is `checkout`, an account with a page view, a checkout and a sign-up shows 3 events.

- With All of, each condition is checked on its own. An account is listed when it has an event that matches each condition. On People, a person is listed in the same way, with events in the window.
- The line about sessions without an account counts only the sessions that did what the filter says.
- An agent's `list_users` and `list_entities` with a filter count in the same way: all of each row's events.

### Where do I see user and account properties?

Sequential stores user and account properties on each event.

- User properties. The lists do not show them. They show only a name and an email, from identify events. A person's page shows user properties under What your app sent about them. The Info tab of a session page shows them under Their properties, when the latest event of the session carries them.
- Account properties. The Accounts list shows an account's name and plan. The account's page shows all of its account properties, under What your site sent about it.
- Filters. The Visitor property and Account property filter fields. Each matches one property by its name, with a type and an operator. See [Property conditions](/docs/filters-and-saved-views#property-conditions).

### Which sources send user properties and accounts?

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

## Limits

| Limit | Value |
|---|---|
| People | 50 people at a time; Show 50 more lists the next 50. The search shows at most 8 people who match. |
| A filter on People | At most 5 conditions on what people did together. Over 5, the page says "The list waits until the filter fits." |
| A list from a funnel | At most 1,000 people. Their events: the latest 100 events. |
| A person's page | At most 20 cases and 50 user properties. More than 200 linked ids are too many to total on one page. |
| Accounts | 50 at a time, at most 10,000. Account id from the Sequential SDK: Sequential trims it and keeps an id of 1 to 200 characters. A longer id gives no account. No export, no column choice and no saved filters. |

### How the People and Accounts limits work in detail

- Pages of 50. The People list shows 50 people at a time. Show 50 more lists the next 50. The person seen most recently comes first, unless you choose another Order.
- The counts cover the window. The sentence behind How counted ▾ on People counts every person of the window, not only the rows that are loaded. It also counts the hidden one-page visitors. From 8 November 2026, the headline and the chips count the people that the list shows, so they leave out the hidden one-page visitors. When Sequential cannot count the people in 2 seconds, the headline reads "Who used the product in the last 7 days." When it cannot count the segments in 2 seconds, the headline gives only the people, for example "120 people visited.", and the chips show no number.
- The People page shows only a name and an email. The People list does not show user properties. Like the other lists, it shows only a name and an email from an identify call. A person's page shows user properties under What your app sent about them.
- Some sources give no user properties. The Sequential SDK and PostHog give none. Mixpanel's browser SDK gives no user properties. See [What each SDK supports](/docs/support-matrix).
- A recording without a user id has no Earlier or Later. On a site with only Smartlook, a session page shows no Earlier or Later button. See [Why does a recording have no user id?](#why-a-recording-has-no-user-id) in the FAQ.
- Search finds a name set earlier. The box on People and [Search or jump to](/docs/search-or-jump-to) also find a person by a name or an email set more than 7 days ago. The person must be seen in the last 7 days.
- Search results count whole weeks. The box on People always searches the last 7 days. Window, Order and the filter do not change it. In its results, the column reads "Visits since" and a Monday, for example "Visits since 19 Oct". It counts the sessions from that Monday (UTC) up to now. The Monday starts the week of the day 7 days ago.
- People's window ends now. The People list covers the last 7 days, or the 14, 30 or 90 days that you choose in Window. It counts them to the hour, up to now. Workbench › Accounts counts whole UTC days, today included.
- A filter on People: 5 conditions. Sequential checks at most 5 conditions on what people did together. An All of or Any of group counts as one. The items of a None of or Not all of group count one by one. Over 5, the bar says, for example, "Sequential checks at most 5 conditions on what people did together (this filter has 6)." The page says "The list waits until the filter fits." The list stays as it is until the filter has 5 conditions or fewer.
- Accounts keeps its view in the address. The range, the plan, the health, the search and What they did are in its link. An account's page keeps its range in its link. People keeps only a `?days=` window, and the `?account_id=` that it opens with. Its filter, its order and its chips are not in its link.
- Accounts: 50 at a time, up to 10,000. A project with more accounts shows its 10,000 most recently active accounts, and the scope line says "Only the 10,000 most recently active accounts are counted".

## Next steps

- [Identify your users](/docs/identify-users): send your own id for each person, so People can find them.
- [User ids and identity](/docs/users-and-identity): how Sequential joins one person's ids.
- [Find and replay sessions](/docs/sessions-and-replay): watch a session in the player.
- [Funnels](/docs/funnels): see where people leave, then open them in People.
- [Filters, date ranges and saved views](/docs/filters-and-saved-views): how the filter bar works.
