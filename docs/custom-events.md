# Send custom events

> Custom events name the moments that matter, such as a finished checkout. They become filters, funnel steps and flow steps, and they help the AI judge.

> **In short**
>
> - Send custom events for the few moments that show if your product helped a person.
> - Name events `object_action` in the past tense and lowercase, with nothing variable in the name.
> - Add a few short properties. Never put personal data in a name or a property.
> - Use the SDK that already sends your app's data to Sequential.
> - To check an event, open Workbench › **Events** and filter on **Event**.

## What it is for

Autocapture records what happened on screen, such as a click on "Continue". It cannot know what the click meant. A custom event names it, such as `checkout_started`.

The AI judge answers mostly from the session's events. Without custom events, it must guess what clicks and page paths mean.

## What it needs

- A supported SDK that sends to your project. See [Check your install](/docs/verify).
- The same user id on all of a person's events, so a funnel or flow can follow the person. See [Identify your users](/docs/identify-users).

### Questions that named events answer

Autocapture records what happened on screen: a page view, a click on "Continue", a form sent. It cannot know what that click meant in your product. A custom event names it: `checkout_started`, `invite_sent`, `report_exported`.

With named events, you can answer questions such as these:

| Question | How to answer it |
|---|---|
| Of the people who started checkout this week, how many finished? | A funnel from `checkout_started` to `checkout_completed`. |
| In what order do people reach `project_created`, `invite_sent` and `integration_connected`? | A flow with those three steps. |
| Which sessions started an export and did not finish it? | [Ask](/docs/ask) and [Evidence](/docs/watch). They read your events when they judge sessions. |

Custom events also give the AI judge evidence. The default questions ask what the person came to do (**Intent**). It also asks how the session ended (**Outcome**). The judge answers mostly from the session's events.

Without custom events, the judge sees page paths, clicks, sent forms and errors. It must guess what they mean in your product. With custom events, it reads `checkout_completed` or `payment_declined`.

### How Sequential handles a custom event

1. Your code calls the SDK's capture or track method with an event name. Properties are optional.
2. Sequential stores the name exactly as sent. It gives the event the class **Custom**, because the name is not one of the SDK's own event names. See [Events](/docs/events).
3. The name becomes a value of the **Event** field. You can filter on it in Workbench › **Events** and Workbench › **Sessions**. You can use it in Workbench › **Funnels** and **Flows**.
4. When Sequential judges a session, each custom event becomes one line for the judge: the name, then its properties as `key=value` pairs. An event from the [backend SDK](/docs/backend-sdk) gives the judge its name only.

## Decide what to send

- **Milestones:** `signup_completed`, `onboarding_completed`, `project_created`
- **Money:** `checkout_started`, `checkout_completed`, `plan_upgraded`, `subscription_cancelled`
- **Your product's core job:** `report_exported`, `invoice_sent`, `integration_connected`
- **Failures people hit:** `payment_declined`, `export_failed`, `import_failed`

Without failure events, the judge can only guess the outcome. Do not send what autocapture already records. See **Sending rules**.

### Naming rules

| Rule | Write |
|---|---|
| `object_action`, past tense | `checkout_started`, `report_exported` |
| Lowercase, words joined by `_` | `plan_upgraded` |
| Nothing variable in the name | `invoice_sent` with `{ currency: 'EUR' }` |
| Never starts with `$` | `checkout_started` |
| Short | under 60 characters |

Do not use names that the SDKs use or that Sequential hides. See **Names to avoid**.

### Sending rules

Names not to write, for each naming rule:

| Rule | Not |
|---|---|
| `object_action`, past tense | `startCheckout`, `export` |
| Lowercase, words joined by `_` | `Plan Upgraded`, `planUpgraded` |
| Nothing variable in the name | `invoice_sent_4812`, `checkout_started_pro` |
| Never starts with `$` | `$checkout` |
| Short | a sentence |

- Send each event once, from the code where the moment happens.
- If one action means two things, send both events.
- Filters and funnel steps match the name exactly. `Checkout Started` and `checkout_started` are two different events.
- Without failure events, the judge can only guess the outcome from behaviour.
- Name a failure after what failed, for example `checkout_failed` or `export_failed`. Use a specific outcome such as `payment_declined` only when the app can tell.
- Send only the few moments that show if your product helped a person.
- Do not send events that autocapture already records, such as page views and button clicks. `button_clicked` adds nothing. [What each SDK supports](/docs/support-matrix) lists what each SDK autocaptures.
- Send `checkout_completed` after your server confirms the payment, not when the button is pressed. Send `export_failed` from the error branch.
- In component code, make sure that a re-render does not send the event again.
- An upgrade paid through checkout is a `checkout_completed` and a `plan_upgraded`. Then each name means the same thing in every funnel and count.
- A name with an id in it is a new event every time.
- Steps and filters cannot match an event's properties. To use a moment as its own funnel step, give it its own event name. Send `plan_upgraded` and `plan_downgraded`, not `plan_changed` with `direction: 'up'`.

### Names to avoid

**Names that SDKs use.** Names that start with `$` belong to the SDKs. Some plain names do too:

| SDK | Taken names |
|---|---|
| Pendo | `click`, `load`, `focus` |
| Amplitude | `session_start` |
| Smartlook | `navigation`, `error` |

Sequential gives an event with one of these names the class of that SDK's own events. It gives some of them the class System and hides them.

**Names with little meaning.** Do not give a custom event a name that carries little meaning, such as `scroll`, `scroll_depth`, `hover`, `resize`, `focus`, `blur`, `heartbeat`, `ping`, `idle`, `set`, `change`, `session_start`, `session_end`, `app_backgrounded` or `feature_flag_called`. Names like `checkout_started` and `report_exported` say what happened.

**Long names.** The judge may see only the first 60 characters of a name.

## Properties

Add a few short properties that explain the event, such as `plan`, `seats` or `error_code`.

- Do not start a key with `$`.
- Keep personal words, such as `name`, `user` and `email`, out of keys that the judge must read.
- Keep values short. The judge sees an event's properties as one line of at most 80 characters.
- For a failure, send a code that you choose, such as `error_code: 'card_declined'`.
- Evidence and Ask do not pass date values to the judge.
- If a value is a web address, Sequential replaces its query values with `[redacted]` before it stores the value. It keeps `utm_*` parameters.

## Never send personal data

Keep these out of event names and properties:

- people's names, email addresses, phone numbers and postal addresses
- anything a user typed
- tokens, passwords, card details and one-time links

The key filter reads key names only, so it does not protect a personal value under an ordinary key.

Send who the user is with `identify`, not in event properties. See [Identify your users](/docs/identify-users).

> **Anyone in the organisation can read properties**
>
> Sequential stores properties as you send them. From 18 October 2026, a property with an element-text name, such as `text` or `selector`, is the exception: Sequential stores an email, a card number, a JWT or a Bearer or Basic credential in it as `[redacted]`. See [Privacy at a glance](/docs/privacy-overview#what-sequential-removes-automatically). Every role can read them on the Events page, including viewers. Sequential keeps them for the organisation's events retention period. You cannot delete one event or one property. See [Retention and deletion](/docs/retention-and-deletion).

### Property rules: exact behaviour

- Other useful properties are `format`, `step` and `item_count`.
- Mixpanel drops properties whose keys start with `$`. The judge and the property preview on the Events page skip them.
- The full list of personal words is in **Which properties the judge reads**.
- If the app has no error code at that point, send the HTTP status or a small fixed set that you define, for example `network` or `http_402`. Do not send the message that your server returned, because messages vary and can contain personal data.
- Sequential stores a value written as a date and time as a date. See **Which properties the judge reads**.

### Which properties the judge reads

The judge skips a property if its key contains one of these words: email, mail, phone, tel, password, pass, token, secret, address, addr, name, ip, user, username, account, ssn, iban, card. Sequential calls this the key filter.

Sequential splits a key into words at `_`, `-`, `.`, spaces and capital letters. So the judge skips `plan_name`, `userRole` and `account_type`. It reads `plan`, `role`, `workspace_tier` and `description`.

**Dates.** Sequential stores a value written as a date and time, such as `2026-10-01T09:00:00Z`, as a date. Evidence and Ask do not pass it to the judge. Sequential still stores it.

### Where the key filter does not apply

- The key filter applies wherever the judge reads events: Evidence, Ask and the **Try it** preview on the **Questions** page. See [AI and third parties](/docs/ai-and-third-parties).

### Web addresses in property values

If a property value is a web address, Sequential replaces its query values with `[redacted]` before it stores the value. It keeps marketing parameters such as `utm_*`. This does not filter personal data. Keep personal data out of properties. See [What Sequential keeps from page URLs](/docs/url-policy).

## Add the calls

Use the SDK that already sends your app's data, not a second one. If there is none, see [Install Sequential](/docs/install). To send events from your own server, see [Send events from your server](/docs/backend-sdk).

- **Amplitude:** leave batching (`useBatch`) off. Batched events do not reach Sequential today.
- **Pendo:** not checked against a live Pendo agent yet. The judge sees the event name alone.

### Sequential SDK

```js
sequential.capture('checkout_completed', { plan: 'pro', seats: 5 });
```

`capture()` throws an error on a name that starts with `$`. Do not rely on that error. Some calls drop the event silently. See **Sequential SDK: exact behaviour**.

To add properties to every event, register super properties:

```js
sequential.register({ experiment: 'onboarding_b' });
```

Super properties last only as long as the page. So call `register()` on every page load. Register only a few short ones. Sequential shows super properties first, so too many can hide the event's own properties.

`sequential.reset()` clears super properties. It also starts a new anonymous visitor and a new session. So call it only on sign-out.

### Sequential SDK: exact behaviour

**Dropped events**

- If a call with a `$` name was queued before the SDK loaded, the SDK skips it silently. It does not throw.
- If the properties cannot be turned into JSON, the SDK drops the event silently. Examples are a `BigInt` or an object that refers to itself.
- In TypeScript, sequential.js has no published type declarations. Read it through `window` with a narrow local type, as the [Sequential SDK](/docs/sequential) page describes.

**Super properties**

- Super properties are for properties that belong on every event. An example is the experiment variant that a visitor is in.
- The SDK adds super properties to every later event from the page, autocaptured events included.
- If `capture()` passes the same key, the `capture()` value wins.
- Super properties come before the event's own properties. The judge's 80-character line fills in that order. So each super property can take the place of one of the event's own properties.
- `sequential.unregister('experiment')` removes one super property.
- `sequential.reset()` clears them all. It also starts a new anonymous visitor and a new session. So call it only on sign-out.

### PostHog (web)

```js
posthog.capture('checkout_completed', { plan: 'pro', seats: 5 });
```

### Mixpanel

```js
mixpanel.track('checkout_completed', { plan: 'pro', seats: 5 });
```

### Amplitude

```js
amplitude.track('checkout_completed', { plan: 'pro', seats: 5 });
```

### Pendo

```js
pendo.track('checkout_completed', { plan: 'pro', seats: 5 });
```

### Smartlook

```js
smartlook('track', 'checkout_completed', { plan: 'pro', seats: 5 });
```

### Per-SDK differences

**PostHog.** Sequential keeps the properties on the event. In a mobile app, use the capture call of PostHog's SDK for your platform. See [Mobile apps](/docs/mobile).

**Mixpanel.** Mixpanel drops properties whose keys start with `$`, except autocapture's element properties.

**Amplitude.** Leave batching (`useBatch`) off. Batched events do not reach Sequential today.

**Pendo.** Pendo support is the least proven. The event should arrive with your event name. This has not been checked against a live Pendo agent yet. If your events appear with the name `track`, the event name was lost.

Sequential stores Pendo properties as user properties, not on the event. So the judge's line for a Pendo event is the name alone.

## Check it arrived

1. Trigger the moment in your app.
2. Open Workbench › **Events**.
3. Select **Add a filter**, then the field **Event**.
4. Type your event name, or pick it from the list. The list shows the custom event names of the last 30 days. The name that the most people sent is first.
5. In **Window**, keep a window that includes today, for example **Last 24 hours**.

The count changes when you change the filter. There is no button to run it. Each row of the list shows your event name.

### Check it arrived: exact behaviour

- **Last 24 hours** counts the 24 hours up to now. The other windows count whole days in UTC, up to today. **Pick days…** includes both days, and all of the last day.
- Select a row to open its session at that event.

### Build a funnel from an event

1. Open Workbench › **Funnels**.
2. In a step, select **Add a filter**, then the field **Event**.
3. Type your event name, or pick it from the list.
4. Select **Add a step**, and set the next step in the same way.

The funnel runs again when you change it. There is no button to run it.

## Limits

- A filter or a step can match the event name with **is**, **contains**, **starts with** and other operators. It can also match an **Event property**.
- On [Retention](/docs/retention), a custom event can be the start event or the return event.
- The judge reads at most 255 events per session. After plain clicks, custom events are among the next events that it leaves out.
- Sequential does not judge a session with fewer than 3 events that the judge can read.
- Custom events do not guarantee an answer. To ask about your own moments, add questions in [Customise the questions](/docs/rubric).

### Limits: exact behaviour

- An **Event property** has a type and an operator, for example a number that **is more than** `5`, or text that **contains** `pro`. **is** on text matches the exact text of the whole value. See [Property conditions](/docs/filters-and-saved-views#property-conditions).
- On Workbench › **Retention**, set the start event or the return event to your custom event, with an **Event** filter. For example: people who signed up came back to `invoice_created` on day 7. With no filter, each of them is any event.
- If a session is longer than 255 events, Sequential leaves out plain clicks first. Custom events are among the next events that it leaves out.
- Custom events give the judge evidence. How much one event changes an answer depends on the model and on your questions.

### Count each event name

To see a count per event name, open Workbench › **Events**. In **Break down by**, select **Event**. The chart shows the top names and **Everything else**. The table lists the names.

## Related

- [Identify your users](/docs/identify-users)
- [Install Sequential](/docs/install)
- [Events](/docs/events)
- [Explore events](/docs/events-explorer)
- [Funnels](/docs/funnels)
- [Flows](/docs/flows)
- [Judgments](/docs/judgments)
- [Customise the questions](/docs/rubric)
- [What each SDK supports](/docs/support-matrix)
