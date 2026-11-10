# User ids and identity: who counts as one person

> Sequential files every event under one user id. It is an anonymous id until your app identifies the person, then exactly the value your app passes.

> **Key facts**
>
> - Pass one value for each person, every time. Two values for one person make two people.
> - With the Sequential SDK, pass a non-empty string. A call such as `sequential.identify(42)` has no effect and shows no error. The person stays under the anonymous id.
> - Call `sequential.reset()` on sign-out. Without it, Sequential files the next person on that browser under the previous person's id.
> - With the Sequential SDK, PostHog or Mixpanel, a person who identifies counts as one person on People, each person's page, Evidence, Workbench › Sessions, Funnels, Flows, Retention and the people counts of Events.
> - The judge never sees the user id.

## How identity works

1. Before identify, the user id is the anonymous id. The Sequential SDK creates it the first time a browser loads your site, and keeps it in that browser's storage.
2. After identify, the user id is the identified value: the value your app passes. The Sequential SDK keeps it for later visits from that browser, until your app calls `sequential.reset()`.
3. With the Sequential SDK, PostHog or Mixpanel, identify also sends an identity link from the anonymous id to the identified value. With Amplitude, Pendo or Smartlook, there is no identity link: the anonymous id and the identified value stay two people on every page.
4. The pages that use the identity link count the events from before identify under the identified value. See [What uses the user id](#what-uses-the-user-id).

Each answer is only as good as the user ids your app sends.

### Example: a person who identifies mid-session

Ana reads your pricing page on Monday and leaves. On Tuesday she returns in the same browser and starts a trial. Your app identifies her as `ana@example.com`. With the Sequential SDK:

- Sequential stores Monday's session, and Tuesday's up to sign-up, under her anonymous id. It stores the rest of Tuesday, and later visits from that browser, under `ana@example.com`.
- People shows one row for her, with 2 visits. Tuesday counts once.
- Evidence and Workbench › Sessions show the same person on Monday's session and on Tuesday's.
- Her page lists both visits. All events of this person includes all of Tuesday.
- Funnels, flows and retention count her once. Her steps from before sign-up join her steps after it.
- A Person id condition with `ana@example.com` finds Monday's events too.
- "People, 30 days" on the Brief counts her once.

### The link to the anonymous id

When identify runs, the Sequential SDK also sends the anonymous id that it replaces. Sequential records that identity link. Sequential does not change the stored events. It applies the identity link each time a page that uses it loads. See [What uses the user id](#what-uses-the-user-id):

- The session where identify ran shows under the value from that identify.
- The other sessions of that anonymous id, earlier or later, show under the same value.
- All other events keep the stored user id.

When the identity link applies:

- It also applies to events from before identify, on any date. So the result for a past period can change after a later identify.
- A new identity link can take up to 5 minutes to show.
- For Mixpanel, Sequential keeps the identity link from 12 October 2026. A Mixpanel identify stored before that date has no identity link.

Two values, and sign-out:

- The identity link is one step. If your app identifies Ana by her email and then by an account key in the same session, the anonymous part shows under the email. The events stored under the email show under the account key.
- If one anonymous id is linked to two values, each session where identify ran shows under its own value. The other sessions of that id show under the first value that Sequential received for that anonymous id.
- "First" means the first identity link to arrive at Sequential, not the earliest identify call. If two identity links arrive together, do not rely on which one is first. This applies on People, each person's page, Workbench › Accounts, Evidence, Workbench › Sessions and Events, the Person id filter, funnels, flows and retention.
- Two identity links from one anonymous id are not frequent. Identify links the id that the page has at that moment. So if two people sign in one after the other on one page without `sequential.reset()`, the second identify links the first person's value, not the anonymous id. See [Call `sequential.reset()` on sign-out](#what-you-need-to-do).
- After `sequential.reset()`, the browser has a new anonymous id. Nothing links it to the previous person.

### Where each source's user id comes from

| Source | Stored user id | Falls back to | Sends the identity link |
|---|---|---|---|
| Sequential SDK | Its anonymous id, then the value you pass to `sequential.identify()` | — | Yes |
| PostHog (web and mobile) | `distinct_id`, which PostHog's `identify` sets | — | Yes |
| Mixpanel | `distinct_id`, which `mixpanel.identify()` sets | `$device_id` | Yes. A Mixpanel identify stored before 12 October 2026 has no identity link. |
| Amplitude | The id from `amplitude.setUserId()` | `device_id` | No |
| Pendo | The `visitor.id` you pass to `pendo.initialize` | — | No |
| Smartlook | The id in `smartlook('identify', …)` | The Smartlook visitor id | No |

Other SDKs have their own anonymous ids. For each SDK's other features, see [What each SDK supports](/docs/support-matrix).

## What you need to do

Any stable identifier works, for example your own account id, an email or an account key. Your app must keep the value the same.

1. [Identify your users](/docs/identify-users) with one value for each person, every time.
2. With the Sequential SDK, pass a non-empty string, for example `String(id)`.
3. [Call `sequential.reset()` on sign-out](/docs/identify-users#add-identify-and-reset-to-your-app).

> **Important**
>
> If your app does not call `sequential.reset()`, Sequential files the next person on that browser under the previous person's id.
>
> If your app then identifies the next person, the SDK links the previous person's value to the next person's value. People then shows the visits stored under the previous person's value as visits of the next person, from every device.

## What the judge sees

Judgments are about sessions, not people. The judge never sees the user id or anything your app passes to identify. See [Judgments](/docs/judgments).

### What the judge learns about a person

[Evidence](/docs/watch) does not use the user id to pick sessions. The one exception is Hide our team, which leaves out the sessions of the people marked as your team. The judge reads each session's events and a few facts about it. Sequential judges anonymous sessions like any other.

For Evidence and [Ask](/docs/ask), the judge learns only whether the person identified during the session.

On Evidence and in Ask's answers, each session shows the person only as a label. More about judgments: [AI judgments of sessions](/docs/judgments).

## What uses the user id

With the Sequential SDK, PostHog or Mixpanel, the pages marked Yes also apply the identity link, so they count a person who identifies as one person.

| Page | Uses the identity link |
|---|---|
| The People list and each person's page | Yes |
| The person on each session of Evidence, and on each row of Workbench › Sessions | Yes |
| Workbench › [Funnels](/docs/funnels), [Flows](/docs/flows) and [Retention](/docs/retention) | Yes |
| People under Count on Workbench › Events | Yes |
| A Person id condition on Workbench › Events and Sessions, and in funnel and flow steps ([Filters, date ranges and saved views](/docs/filters-and-saved-views)) | Yes. With the identified value, or with a linked anonymous id, it finds all of that person's events. |
| "People, 30 days" on the Brief | Yes |
| Earlier and Later on a session page | No. They use the recording's own user id. |
| Person in Break down by on Workbench › Events | No. It groups by the user id that each event holds. So the events sent before identify are in a row of their own, under the anonymous id. |

The People list covers the last 7 days. Window changes it to the last 14, 30 or 90 days. See [Window and order](/docs/users-and-accounts#window-and-order).

### How each page uses the user id

Page by page:

- People lists one row per user id, with Person, "Visits, 7 days" and Last seen. With the Sequential SDK, PostHog or Mixpanel, an anonymous id that is linked to one identified value is counted in that value's row. Click a row to open that person's page, with their visits and All events of this person. See [People and accounts](/docs/users-and-accounts).
- Workbench › Funnels match each person's events to the steps in order. With the Sequential SDK, PostHog or Mixpanel, the steps before and after identify join.
- On Funnels, Who left here lists the people who left after a step. For a person who identified, it uses the identified value. Click a person to open them beside the page.
- By default, Workbench › Retention puts each person in the cohort of the day of their first start event ever, when that day is in the window. This is not their first day ever. Then it checks whether they did a return event exactly N days later. [Retention](/docs/retention) has the other cohort rules.
- Workbench › Flows build paths per person. With the Sequential SDK, PostHog or Mixpanel, one path covers the events from before and after identify.
- Workbench › Events counts distinct people when Count is People. With the Sequential SDK, PostHog or Mixpanel, a person who identifies counts once. A blank id is not a person.
- "People, 30 days" on the Brief counts people the same way.

Workbench › Events, People, Workbench › Accounts and the session lists never count a blank id as a person, an account or a session. Workbench › Funnels, Flows and Retention never count an event without a user id as a person. An event without a user id is not a person. People does not list it or count it.

How People shows a person:

Sequential does not store an id as anonymous. The lists decide it when they show the id: a user id with an identify event, or with a linked anonymous id, is identified.

Under the name, a row of People shows the email when the name is not the email. Otherwise it shows "Identified" for an identified person and "Anonymous" for any other. This rule uses all the data that Sequential keeps, not only the days that the list shows.

A person's page uses the same rule. The Identified chip lists the people of the list's days who are identified by this rule. The "identified" count in the sentence behind "How counted ▾" on "People" uses the same rule.

The lists show a person by their name, or else by their email. Without either, they show the last 6 characters of an id that is longer than 14 characters. For an anonymous person, "Visitor" comes first, such as "Visitor 5b2f8a". For an identified person, "…" comes first, such as "…9c41e7". A list that does not know if the person is identified also shows "…". They show a shorter id as it is.

A person without a name has a dashed avatar.

What the user id is for:

With the user id, Sequential answers questions about people, not only events:

- How many people, not clicks, used the new export this week?
- Of the people who signed up in March, how many came back a week later?
- What did this customer do before they emailed support?

### Replays and the user id

On a session page, Earlier and Later step through that person's recordings. The keys are [ and ]. They use the recording's own user id, not the identity link.

On the web, the recording takes that id from the page while it records. It takes it from PostHog, Mixpanel, Pendo or the Sequential SDK, or from Amplitude after `setUserId()`.

In these cases the session page shows neither button:

- Only Smartlook is on the page.
- With Amplitude, the person is anonymous.
- The Sequential SDK is on the page, and the browser blocks storage.

A button also does not show when that person has no earlier or later recording.

## Why one person can count as two

Find what you see, then its cause.

| Symptom | Cause | Fix |
|---|---|---|
| The same person shows as two anonymous people | Before identify, the user id is the anonymous id. Until your app identifies the person, a second device, a private window or cleared storage makes the same person a new person. | — |
| Each page load shows as a new person | If the browser blocks storage, every page load starts a new anonymous id. | — |
| Sequential sees one person as two identified people | Your app identifies one person with two values, for example an email on one screen and an account key on another. Sequential does not rank identifier types, and it does not guess that two values are one person. | Pick one identifier and pass it for that person every time. |
| The visits from before identify are a second person | The source is Amplitude, Pendo or Smartlook. Only the Sequential SDK, PostHog or Mixpanel sends the identity link. | — |
| With Smartlook, each identified person appears as two people | Only the identify call carries your id. Every other event stays under the Smartlook visitor id. | — |
| One session counts in two rows of People | With Amplitude, Pendo or Smartlook, if your app identifies a person mid-session, that session counts in two rows of People, once under each id. | — |

## User properties and accounts

User properties describe the person, not one event. Only Pendo and `sequential.account()` fill accounts.

### User properties

The filter fields call user properties Visitor property.

| Source | Stored as user properties |
|---|---|
| Sequential SDK | None. Properties passed to `identify()` are stored on its `$identify` event, and `register()` properties on every later event. |
| PostHog | None. `posthog.setPersonProperties()` leaves `$set` and `$set_once` on its `$set` event as JSON. From `posthog.identify()` on the web, a name or email shows on the lists, in the title of a session page and on a person's page. Other properties passed there do not appear. |
| Mixpanel | Not from `mixpanel.people.set`: Sequential does not store it. Mixpanel's browser SDK gives no user properties. A group update (`/groups`) is stored as user properties on a user with no id. |
| Amplitude | `set` and `setOnce` from an `Identify`. `add`, `append` and `unset` are ignored. |
| Pendo | Visitor metadata, and the properties on `pendo.track` calls. Account metadata becomes account properties. |
| Smartlook | `identify` properties and `smartlook('properties', …)`. |

You find user properties in these places:

- The Visitor property and Account property filter fields. Each matches one property by its name, with a type and an operator.
- A person's page, under What your app sent about them.
- The Info tab under the player on a session page, under Their properties, when the latest event of the session carries them.

The lists do not show them. They show only a name and an email, from identify events.

### Accounts

Pendo fills accounts, from the `account.id` you pass to `pendo.initialize`. The Sequential SDK fills them from `sequential.account(id, traits)`. No other source fills accounts.

To see accounts:

1. Go to **Workbench › Accounts**.
2. Choose 7 days, 30 days or 90 days.

See [The Accounts list](/docs/users-and-accounts#the-accounts-list).

## Related pages

- [Identify your users](/docs/identify-users): add identify and reset for each SDK.
- [People and accounts](/docs/users-and-accounts): find a person and what they did.
- [Events](/docs/events) and [Sessions](/docs/sessions): what Sequential stores.
- [Glossary](/docs/glossary): the terms of these pages.
