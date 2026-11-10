# Send custom events

> Custom events name the moments that matter, such as a finished checkout. They become filters, funnel steps and flow steps, and they help the AI judge.

> **At a glance**
>
> - **Before you start:** A supported SDK that sends to your project ([Install Sequential](/docs/install), [Check your install](/docs/verify)).
> - **Before you start:** The same user id on all of a person's events ([Identify your users](/docs/identify-users)).
> - **Know this:** Autocapture records a click on "Continue". It cannot know what the click meant. A custom event names it, such as `checkout_started`.
> - **Know this:** The judge answers mostly from the session's events. Without custom events, it must guess what clicks and page paths mean.

## Add a custom event

1. [Decide what to send](#decide-what-to-send): a few moments, such as milestones, money, the core job and failures.
2. [Name your events](#name-your-events) `object_action`, past tense, lowercase, joined by `_`, with nothing variable. Filters and funnel steps match the name exactly. `Checkout Started` and `checkout_started` are two different events.
3. [Add the calls](#add-the-calls) in the SDK that already sends to Sequential.
4. [Add properties](#add-properties): a few short ones. Never put personal data in a name or a property. Every role can read properties.
5. [Check it arrived](#check-it-arrived) in Workbench › Events, with the filter Event.
6. [Use it in funnels, flows and retention](#use-it-in-funnels-flows-and-retention).

## Decide what to send

Send these kinds of moments:

| Moment | Examples |
|---|---|
| Milestones | `signup_completed`, `onboarding_completed`, `project_created` |
| Money | `checkout_started`, `checkout_completed`, `plan_upgraded`, `subscription_cancelled` |
| Your product's core job | `report_exported`, `invoice_sent`, `integration_connected` |
| Failures people hit | `payment_declined`, `export_failed`, `import_failed` |

Without failure events, the judge can only guess the outcome from behaviour. Do not send what autocapture already records.

- Send each event once, from the code where the moment happens.
- Send `checkout_completed` after your server confirms the payment, not when the button is pressed. Send `export_failed` from the error branch.
- In component code, make sure that a re-render does not send the event again.

### Questions that named events answer

Autocapture records what happened on screen: a page view, a click on "Continue", a form sent. It cannot know what that click meant in your product. A custom event names it: `checkout_started`, `invite_sent`, `report_exported`.

With named events, you can answer questions such as these:

| Question | How to answer it |
|---|---|
| Of the people who started checkout this week, how many finished? | A funnel from `checkout_started` to `checkout_completed`. |
| In what order do people reach `project_created`, `invite_sent` and `integration_connected`? | A flow with those three steps. |
| Which sessions started an export and did not finish it? | [Ask](/docs/ask) and [Evidence](/docs/watch). They read your events when they judge sessions. |

Custom events also give the judge evidence. The default questions ask what the person came to do (Intent). It also asks how the session ended (Outcome). The judge answers mostly from the session's events.

Without custom events, the judge sees page paths, clicks, sent forms and errors. It must guess what they mean in your product. With custom events, it reads `checkout_completed` or `payment_declined`.

### What to send and what to skip

- Send only the few moments that show if your product helped a person.
- If one action means two things, send both events. An upgrade paid through checkout is a `checkout_completed` and a `plan_upgraded`. Then each name means the same thing in every funnel and count.
- Do not send events that autocapture already records, such as page views and button clicks. `button_clicked` adds nothing. [What each SDK supports](/docs/support-matrix) lists what each SDK autocaptures.
- Name a failure after what failed, for example `checkout_failed` or `export_failed`. Use a specific outcome such as `payment_declined` only when the app can tell.
- For the `error_code` property: if the app has no error code at that point, send the HTTP status or a small fixed set that you define, for example `network` or `http_402`. Do not send the message that your server returned, because messages vary and can contain personal data.
- To use a moment as its own funnel step, give it its own event name. Send `plan_upgraded` and `plan_downgraded`, not `plan_changed` with `direction: 'up'`. A step can also test an Event property: see [Can a step match part of a name, or a property?](#can-a-step-match-part-of-a-name-or-a-property)

## Name your events

| Rule | Write | Not |
|---|---|---|
| `object_action`, past tense | `checkout_started`, `report_exported` | `startCheckout`, `export` |
| Lowercase, words joined by `_` | `plan_upgraded` | `Plan Upgraded`, `planUpgraded` |
| Nothing variable in the name | `invoice_sent` with `{ currency: 'EUR' }` | `invoice_sent_4812`, `checkout_started_pro` |
| Never starts with `$` | `checkout_started` | `$checkout` |
| Short | under 60 characters | a sentence |

A name with an id in it is a new event every time.

Do not use names that the SDKs use or that Sequential hides. See [Names to avoid](#names-to-avoid).

### Names to avoid

Names that start with `$` belong to the SDKs. Some plain names do too:

| SDK | Taken names |
|---|---|
| Pendo | `click`, `load`, `focus` |
| Amplitude | `session_start` |
| Smartlook | `navigation`, `error` |

Sequential gives an event with one of these names the class of that SDK's own events. It gives some of them the class System and hides them. See [Events](/docs/events).

Do not give a custom event a name that carries little meaning, such as `scroll`, `scroll_depth`, `hover`, `resize`, `focus`, `blur`, `heartbeat`, `ping`, `idle`, `set`, `change`, `session_start`, `session_end`, `app_backgrounded` or `feature_flag_called`. Names like `checkout_started` and `report_exported` say what happened.

Follow the `object_action` rule in [Name your events](#name-your-events) instead.

The judge may see only the first 60 characters of a long name.

## Add the calls

Use the SDK that already sends your app's data, not a second one. If there is none, see [Install Sequential](/docs/install).

To send events from your own server, see [Send events from your server](/docs/backend-sdk). For a mobile app, see [Mobile apps](/docs/mobile).

Variants (tabs on the page; each is written out below): Sequential SDK · PostHog (web) · Mixpanel · Amplitude · Pendo · Smartlook

### Sequential SDK

```js
sequential.capture('checkout_completed', { plan: 'pro', seats: 5 });
```

`capture()` throws an error on a name that starts with `$`. Do not rely on that error. Some calls drop the event silently. See [Sequential SDK: exact behaviour](#sequential-sdk-exact-behaviour).

### PostHog (web)

```js
posthog.capture('checkout_completed', { plan: 'pro', seats: 5 });
```

### Mixpanel

```js
mixpanel.track('checkout_completed', { plan: 'pro', seats: 5 });
```

Mixpanel drops properties whose keys start with `$`. See [Per-SDK differences](#per-sdk-differences).

### Amplitude

```js
amplitude.track('checkout_completed', { plan: 'pro', seats: 5 });
```

Leave batching (`useBatch`) off. Batched events do not reach Sequential today.

### Pendo

```js
pendo.track('checkout_completed', { plan: 'pro', seats: 5 });
```

Pendo support is the least proven. If your events appear with the name `track`, the event name was lost. See [Per-SDK differences](#per-sdk-differences).

### Smartlook

```js
smartlook('track', 'checkout_completed', { plan: 'pro', seats: 5 });
```

### Sequential SDK: exact behaviour

Dropped events:

- If a call with a `$` name was queued before the SDK loaded, the SDK skips it silently. It does not throw.
- If the properties cannot be turned into JSON, the SDK drops the event silently. Examples are a `BigInt` or an object that refers to itself.
- In TypeScript, sequential.js has no published type declarations. Read it through `window` with a narrow local type, as the [Sequential SDK](/docs/sequential) page describes.

Super properties:

- Super properties are for properties that belong on every event. An example is the experiment variant that a visitor is in.
- The SDK adds super properties to every later event from the page, autocaptured events included.
- If `capture()` passes the same key, the `capture()` value wins.
- Super properties come before the event's own properties. The judge's 80-character line fills in that order. So each super property can take the place of one of the event's own properties.
- `sequential.unregister('experiment')` removes one super property.
- `sequential.reset()` clears them all. It also starts a new anonymous visitor and a new session. So call it only on sign-out.

### Per-SDK differences

PostHog: Sequential keeps the properties on the event. In a mobile app, use the capture call of PostHog's SDK for your platform. See [Mobile apps](/docs/mobile).

Mixpanel: Mixpanel drops properties whose keys start with `$`, except autocapture's element properties.

Amplitude: leave batching (`useBatch`) off. Batched events do not reach Sequential today.

Pendo: Pendo support is the least proven. The event should arrive with your event name. This has not been checked against a live Pendo agent yet. If your events appear with the name `track`, the event name was lost.

Sequential stores Pendo properties as user properties, not on the event. So the judge's line for a Pendo event is the name alone.

See [What each SDK supports](/docs/support-matrix).

## Add properties

Add a few short properties that explain the event, such as `plan`, `seats` or `error_code`. Other useful properties are `format`, `step` and `item_count`.

> **Anyone in the organisation can read properties**
>
> Sequential stores properties as you send them. From 18 October 2026, a property with an element-text name, such as `text` or `selector`, is the exception: Sequential stores an email, a card number, a JWT or a Bearer or Basic credential in it as `[redacted]`. See [Privacy at a glance](/docs/privacy-overview#what-sequential-removes-automatically). Every role can read them on the Events page, including viewers. Sequential keeps them for the organisation's events retention period. You cannot delete one event or one property. See [Retention and deletion](/docs/retention-and-deletion).

### Never send personal data

Keep these out of event names and properties:

- people's names, email addresses, phone numbers and postal addresses
- anything a person typed
- tokens, passwords, card details and one-time links

The judge's key filter reads key names only, so it does not protect a personal value under an ordinary key.

Send who the person is with `identify`, not in event properties. See [Identify your users](/docs/identify-users).

### Keep properties readable for the judge

- Do not start a key with `$`. The judge and the property preview on the Events page skip properties whose keys start with `$`.
- Keep personal words, such as `name`, `user` and `email`, out of keys that the judge must read. The judge skips those keys (the key filter). This includes words inside a key, so the judge skips `plan_name` and `account_type`.
- Keep values short. The judge sees an event's properties as one line of at most 80 characters.
- For a failure, send a code that you choose, such as `error_code: 'card_declined'`.

### Which properties the judge reads

The judge skips a property if its key contains one of these words: email, mail, phone, tel, password, pass, token, secret, address, addr, name, ip, user, username, account, ssn, iban, card. Sequential calls this the key filter. It applies wherever the judge reads events: Evidence, Ask and the Try it preview on the Questions page. See [AI and third parties](/docs/ai-and-third-parties).

Sequential splits a key into words at `_`, `-`, `.`, spaces and capital letters. So the judge skips `plan_name`, `userRole` and `account_type`. It reads `plan`, `role`, `workspace_tier` and `description`.

Sequential stores a value written as a date and time, such as `2026-10-01T09:00:00Z`, as a date. Evidence and Ask do not pass it to the judge. Sequential still stores it.

If a value is a web address, Sequential replaces its query values with `[redacted]` before it stores the value. It keeps `utm_*` parameters. See [What happens to a web address in a property value?](#what-happens-to-a-web-address-in-a-property-value)

## Check it arrived

1. Trigger the moment in your app.

2. Open **Workbench › Events**.

3. In **Window**, keep a window that includes today, for example **Last 24 hours**.

4. Click **Add a filter**.

5. Choose the field **Event**.

6. Type your event name, or choose it from the name list.

   Result: The name list shows the custom event names of the last 30 days. The name that the most people sent is first.

Result: Each row of the event list shows your event name. Click a row to open its session at that event. Not there? See [Sequential SDK: exact behaviour](#sequential-sdk-exact-behaviour) and [Per-SDK differences](#per-sdk-differences).

### How Sequential handles a custom event

1. Your code calls the SDK's capture or track method with an event name. Properties are optional.
2. Sequential stores the name exactly as sent. It gives the event the class Custom, because the name is not one of the SDK's own event names. See [Events](/docs/events).
3. The name becomes a value of the Event field. You can filter on it in Workbench › Events and Workbench › Sessions. You can use it in Workbench › Funnels and Flows.
4. When Sequential judges a session, each custom event becomes one line for the judge: the name, then its properties as `key=value` pairs. An event from the [backend SDK](/docs/backend-sdk) gives the judge its name only.

To see a count per event name, open Workbench › Events. In Break down by, choose Event. The chart shows the top names and Everything else. The table lists the names.

The judge reads at most 255 events per session. If a session is longer than 255 events, Sequential leaves out mobile gestures and plain clicks first. Custom events are among the next events that it leaves out.

Custom events give the judge evidence. How much one event changes an answer depends on the model and on your questions.

## Use it in funnels, flows and retention

Use a custom event as a step in Workbench › Funnels and Flows. On Retention, a custom event can be the start event or the return event. See [Funnels](/docs/funnels).

### Build a funnel from an event

1. Open **Workbench › Funnels**.

2. In a step, click **Add a filter**.

3. Choose the field **Event**.

4. Type your event name, or choose it from the list.

5. Click **Add a step**.

6. Set the next step in the same way.

Result: The funnel runs again when you change it. There is no button to run it.

## FAQ

### How do I add a property to every event?

With the Sequential SDK, register super properties:

```js
sequential.register({ experiment: 'onboarding_b' });
```

Super properties last only as long as the page. So call `register()` on every page load. Register only a few short ones. Sequential shows super properties first, so too many can hide the event's own properties.

`sequential.reset()` clears super properties. It also starts a new anonymous visitor and a new session. So call it only on sign-out. [Sequential SDK: exact behaviour](#sequential-sdk-exact-behaviour) has the rest.

### Can a step match part of a name, or a property?

A filter or a step can match the event name with "is", "contains", "starts with" and other operators. It can also match an Event property. An Event property has a type and an operator, for example a number that "is more than" `5`, or text that "contains" `pro`. "is" on text matches the exact text of the whole value. See [Property conditions](/docs/filters-and-saved-views#property-conditions).

### Which hours and days does a window count?

In Window, Last 24 hours counts the 24 hours up to now. The other windows count whole days in UTC, up to today. Pick days… includes both days, and all of the last day. The count changes when you change the filter. There is no button to run it.

### What happens to a web address in a property value?

If a property value is a web address, Sequential replaces its query values with `[redacted]` before it stores the value. It keeps marketing parameters such as `utm_*`. This does not filter personal data. Keep personal data out of properties. See [What Sequential keeps from page URLs](/docs/url-policy).

### Can a custom event be a retention event?

Yes. On Workbench › [Retention](/docs/retention), set the start event or the return event to your custom event, with an Event filter. For example: people who signed up came back to `invoice_created` on day 7. With no filter, each of them is any event.

## Limits

- Sequential does not judge a session with fewer than 3 events that the judge can read.
- Custom events do not guarantee an answer. To ask about your own moments, add questions in [Customise the questions](/docs/rubric).

## Next steps

- [Identify your users](/docs/identify-users): so a funnel or flow can follow the person.
- [Explore events](/docs/events-explorer): count and break down events.
- [Funnels](/docs/funnels) and [Flows](/docs/flows): use your events as steps.
- [Judgments](/docs/judgments): how the judge reads a session.
- [Customise the questions](/docs/rubric): ask about your own moments.
