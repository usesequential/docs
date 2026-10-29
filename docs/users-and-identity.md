# Users and identity

> Sequential files every event under one user id. It is an anonymous id until your app identifies the visitor, then exactly the value your app passes.

> **In short**
>
> - Pass one value for each person. Two values for one person make two users.
> - Sequential stores the value exactly as your app passes it. It does not rank identities.
> - With the Sequential SDK, PostHog or Mixpanel, a visitor who identifies counts as one person. This applies on **People**, on each person's page and on **Evidence**. It also applies on Workbench › **Sessions**, **Funnels**, **Flows**, **Retention** and the people counts of **Events**.
> - A **Person id** condition with the identified value, or with a linked anonymous id, finds all of that person's events.
> - **People, 30 days** on the Brief counts people the same way.
> - The judge never sees the user id.

## What it is for

The user id lets Sequential answer questions about people, not only events:

- How many people, not clicks, used the new export this week?
- Of the people who signed up in March, how many came back a week later?
- What did this customer do before they emailed support?

Each answer is only as good as the user ids your app sends.

## How it works

Every stored event carries exactly one user id.

- **Before your app identifies the visitor**, the user id is an anonymous id. The Sequential SDK creates one the first time a browser loads your site. It keeps the id in that browser's storage.
- **After your app identifies the visitor**, the user id is the value your app passes. The Sequential SDK keeps the value, so later visits from that browser carry it too. The SDK keeps the value until your app calls `sequential.reset()` on sign-out.

Other SDKs have their own anonymous ids. Sequential does not store an id as anonymous. The lists decide it when they show the id: a user id with an identify event, or with a linked anonymous id, is identified.

Under the name, a row of **People** shows the email when the name is not the email. Otherwise it shows "Identified" for an identified person and "Anonymous" for any other. This rule uses all the data that Sequential keeps, not only the days that the list shows. A person's page uses the same rule. The **Identified** chip lists the people of the list's days who are identified by this rule. The "identified" count in the sentence at the top of **People** uses the same rule.

The lists show a person by their name, or else by their email. Without either, they show the last 6 characters of an id that is longer than 14 characters. For an anonymous person, "Visitor" comes first, such as "Visitor 5b2f8a". For an identified person, "…" comes first, such as "…9c41e7". A list that does not know if the person is identified also shows "…". They show a shorter id as it is. A person without a name has a dashed avatar.

> **Call `sequential.reset()` on sign-out**
>
> If your app does not call `sequential.reset()`, Sequential files the next person on that browser under the previous user's id. If your app then identifies the next person, the SDK links the previous user's value to the next person's value. **People** then shows the visits stored under the previous user's value as visits of the next person, from every device.

## Use one value for each person

Sequential stores the value that your app passes to identify exactly as it is. Any stable identifier works. For example: your own account id, an email or an account key.

Sequential does not rank identifier types, and it does not guess that two values are one person. If your app identifies one person with two values, Sequential sees two users. For example: an email on one screen and an account key on another.

Your app must keep the value the same. Pick one identifier and pass it for that person every time. [Identify your users](/docs/identify-users) shows how for each SDK.

> **Pass a string**
>
> With the Sequential SDK, the value must be a non-empty string. A call such as `sequential.identify(42)` has no effect and shows no error. The visitor stays under the anonymous id, so pass `String(id)`.

## What uses the user id

These pages use the stored user id and the identify link. With the Sequential SDK, PostHog or Mixpanel, they count a visitor who identifies as one person:

- The **People** list and each person's page.
- The person on each session of **Evidence**, and on each row of Workbench › **Sessions**.
- Workbench › [Funnels](/docs/funnels), [Flows](/docs/flows) and [Retention](/docs/retention).
- **People** under **Count** on Workbench › **Events**.
- A **Person id** condition on Workbench › **Events** and **Sessions**, and in funnel and flow steps. See [Filters, date ranges and saved views](/docs/filters-and-saved-views).
- **People, 30 days** on the Brief.

See **The link to the anonymous id** below.

Workbench › **Events**, **People**, Workbench › **Accounts** and the session lists never count a blank id as a person, an account or a session. Workbench › **Funnels**, **Flows** and **Retention** never count an event without a user id as a person.

The **Earlier** and **Later** buttons of a session page are the exception. They use the recording's own user id. See **Replays and the user id** below.

**Person** in **Break down by** on Workbench › **Events** is an exception too. It groups by the user id that each event holds. So the events sent before identify are in a row of their own, under the anonymous id.

## What does not use the user id

Judgments are about sessions, not people. The judge never sees the user id or anything your app passes to identify. See [Judgments](/docs/judgments).

## Limits

- Sequential stores the events sent before identify under the anonymous id. The pages that use the link count them under the identified value.
- **People, 30 days** on the Brief uses the identify link too.
- Only the Sequential SDK, PostHog or Mixpanel sends the link. With Amplitude, Pendo or Smartlook, the anonymous id and the identified id stay two people on every page.
- Until your app identifies the visitor, a second device, a private window or cleared storage makes the same person a new user. If the browser blocks storage, every page load starts a new anonymous id.
- With Smartlook, each identified person appears as two people.
- On a site with only Smartlook, a session page shows no **Earlier** or **Later** button.
- The **People** list shows 50 people at a time. **Show 50 more** lists the next 50. The person seen most recently comes first, unless you choose another **Order**.
- The **People** list covers the last 7 days. **Window** changes it to the last 14, 30 or 90 days. An address with `?days=30` opens the last 30 days: the Brief links to it. `?days=` takes 7, 14, 30 or 90. A person's page lists their visits of the last 30 days. The sentence at the top of a person's page covers all the data that Sequential keeps. "This person is not in this project." means that no event that Sequential keeps has the id.
- The **People** list does not show user properties. Like the other lists, it shows only a name and an email from an identify call. A person's page shows user properties under **What your app sent about them**.
- Only Pendo and `sequential.account()` fill accounts.
- From `posthog.identify()` on the web, only a name or email shows: on the lists, in the title of a session page and on a person's page. Other properties passed there do not appear.
- Sequential does not store `mixpanel.people.set`. Mixpanel's browser SDK gives no user properties.
- From an Amplitude `Identify`, Sequential stores only `set` and `setOnce`. It ignores `add`, `append` and `unset`.
- With Amplitude, Pendo or Smartlook, if your app identifies a visitor mid-session, that session counts in two rows of **People**, once under each id.
- By default, Workbench › **Retention** puts each person in the cohort of the day of their first start event ever, when that day is in the window. A person who did the start event before the window is in no cohort. With **Cohort** set to **Everyone active**, it uses the first start event in the window.

### Where each source's user id comes from

| Source | Stored user id | Falls back to |
|---|---|---|
| Sequential SDK | Its anonymous id, then the value you pass to `sequential.identify()` | — |
| PostHog (web and mobile) | `distinct_id`, which PostHog's `identify` sets | — |
| Mixpanel | `distinct_id`, which `mixpanel.identify()` sets | `$device_id` |
| Amplitude | The id from `amplitude.setUserId()` | `device_id` |
| Pendo | The `visitor.id` you pass to `pendo.initialize` | — |
| Smartlook | The id in `smartlook('identify', …)` | The Smartlook visitor id |

With Smartlook, only the identify call carries your id. Every other event stays under the Smartlook visitor id. Because of this, each identified person appears as two people.

### How each page uses the user id

- **People** lists one row per user id, with **Person**, **Visits, 7 days** and **Last seen**. With the Sequential SDK, PostHog or Mixpanel, an anonymous id that is linked to one identified value is counted in that value's row. Click a row to open that person's page, with their visits and **All events of this person**. See [Users and accounts](/docs/users-and-accounts).
- An event without a user id is not a person. **People** does not list it or count it.
- Workbench › **Funnels** match each person's events to the steps in order. With the Sequential SDK, PostHog or Mixpanel, the steps before and after identify join. **Who left here** lists the people who left after a step. For a person who identified, it uses the identified value. Click a person to open them beside the page.
- By default, Workbench › **Retention** puts each person in the cohort of the day of their first start event ever, when that day is in the window. This is not their first day ever. Then it checks whether they did a return event exactly N days later.
- Workbench › **Flows** build paths per person. With the Sequential SDK, PostHog or Mixpanel, one path covers the events from before and after identify.
- Workbench › **Events** counts distinct people when **Count** is **People**. With the Sequential SDK, PostHog or Mixpanel, a visitor who identifies counts once. A blank id is not a person.

### Replays and the user id

On a session page, **Earlier** and **Later** step through that person's recordings. The keys are [ and ]. They use the recording's own user id.

On the web, the recording takes that id from the page while it records. It takes it from PostHog, Mixpanel, Pendo or the Sequential SDK, or from Amplitude after `setUserId()`.

In these cases the session page shows neither button:

- Only Smartlook is on the page.
- The visitor is an anonymous Amplitude visitor.
- The Sequential SDK is on the page, and the browser blocks storage.

A button also does not show when that person has no earlier or later recording.

### What the judge learns about the user

[Evidence](/docs/watch) does not use the user id to pick sessions. The one exception is **Hide our team**, which leaves out the sessions of the people marked as your team. The judge reads each session's events and a few facts about it. Sequential judges anonymous sessions like any other.

For **Evidence** and [Ask](/docs/ask), the judge learns only whether the visitor identified during the session.

On **Evidence** and in Ask's answers, each session shows the person only as a label.

### Example: a visitor who identifies mid-session

Ana reads your pricing page on Monday and leaves. On Tuesday she returns in the same browser and starts a trial. Your app identifies her as `ana@example.com`. With the Sequential SDK:

- Sequential stores Monday's session, and Tuesday's up to sign-up, under her anonymous id. It stores the rest of Tuesday, and later visits from that browser, under `ana@example.com`.
- **People** shows one row for her, with 2 visits. Tuesday counts once.
- **Evidence** and Workbench › **Sessions** show the same person on Monday's session and on Tuesday's.
- Her page lists both visits. **All events of this person** includes all of Tuesday.
- Funnels, flows and retention count her once. Her steps from before sign-up join her steps after it.
- A **Person id** condition with `ana@example.com` finds Monday's events too.
- **People, 30 days** on the Brief counts her once.

### The link to the anonymous id

When identify runs, the Sequential SDK also sends the anonymous id that it replaces. Sequential records that link. Sequential does not change the stored events. It applies the link each time a page that uses it loads. See **What uses the user id** above:

- **The session where identify ran** shows under the value from that identify.
- **The other sessions of that anonymous id**, earlier or later, show under the same value. If the anonymous id is linked to two values, they show under the first value that Sequential received for that anonymous id.
- **All other events** keep the stored user id.

More about the link:

- It also applies to events from before identify, on any date. So the result for a past period can change after a later identify.
- A new link can take up to 5 minutes to show.
- Only the Sequential SDK, PostHog or Mixpanel sends the link. For Mixpanel, Sequential keeps the link from 12 October 2026. A Mixpanel identify stored before that date has no link.
- The link is one step. If your app identifies Ana by her email and then by an account key in the same session, the anonymous part shows under the email. The events stored under the email show under the account key.
- If one anonymous id is linked to two values, each session where identify ran shows under its own value. The other sessions of that id show under the first value that Sequential received for that anonymous id. "First" means the first link to arrive at Sequential, not the earliest identify call. If two links arrive together, do not rely on which one is first. This applies on **People**, each person's page, Workbench › **Accounts**, **Evidence**, Workbench › **Sessions** and **Events**, the **Person id** filter, funnels, flows and retention.
- Two links from one anonymous id are not frequent. Identify links the id that the page has at that moment. So if two people sign in one after the other on one page without `sequential.reset()`, the second identify links the first person's value, not the anonymous id. See **Call `sequential.reset()` on sign-out** above.
- After `sequential.reset()`, the browser has a new anonymous id. Nothing links it to the previous user.

### User properties

User properties describe the person, not one event. The filter fields call them **Visitor property**.

| Source | Stored as user properties |
|---|---|
| Sequential SDK | None. Properties passed to `identify()` are stored on its `$identify` event, and `register()` properties on every later event. |
| PostHog | None. `posthog.setPersonProperties()` leaves `$set` and `$set_once` on its `$set` event as JSON. From `posthog.identify()` on the web, a name or email shows on the lists, in the title of a session page and on a person's page. Other properties passed there do not appear. |
| Mixpanel | Not from `mixpanel.people.set`: Sequential does not store it. A group update (`/groups`) is stored as user properties on a user with no id. |
| Amplitude | `set` and `setOnce` from an `Identify`. `add`, `append` and `unset` are ignored. |
| Pendo | Visitor metadata, and the properties on `pendo.track` calls. Account metadata becomes account properties. |
| Smartlook | `identify` properties and `smartlook('properties', …)`. |

You find user properties in these places:

- The **Visitor property** and **Account property** filter fields. Each matches one property by its name, with a type and an operator.
- A person's page, under **What your app sent about them**.
- The **Info** tab under the player on a session page, under **Their properties**, when the latest event of the session carries them.

The lists do not show them. They show only a name and an email, from identify events.

### Accounts

Pendo fills accounts, from the `account.id` you pass to `pendo.initialize`. The Sequential SDK fills them from `sequential.account(id, traits)`. No other source fills accounts.

To see accounts:

1. Open **Workbench**, then **Accounts**.
2. Pick **7 days**, **30 days** or **90 days**.

See [The Accounts list](/docs/users-and-accounts#the-accounts-list).

## Related

- [Identify your users](/docs/identify-users)
- [Users and accounts](/docs/users-and-accounts)
- [Events](/docs/events)
- [Sessions](/docs/sessions)
- [Judgments](/docs/judgments)
- [What each SDK supports](/docs/support-matrix)
- [Glossary](/docs/glossary)
