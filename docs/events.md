# Events and event classes

> An event is one thing that happened in a session. Sequential gives each event one of ten classes, so a click means the same thing from every SDK.

> **Key facts**
>
> - Sequential never rewrites the event name that your SDK sent.
> - Sequential gives each event one of ten classes when it arrives. There is nothing to set up.
> - Filters, judgments and the session page's What they did list use the class.
> - The What they did list hides System events until you turn on the All chip. Workbench › Events shows them.
> - Rage clicks, dead clicks and errors depend on the SDK that sends them.

## What an event is

An event in a [session](/docs/sessions) can be a page view, a click or `checkout_started`. Sequential stores each event with its class, its event name exactly as your SDK sent it, and its source. The source is the SDK that sent the event.

### What Sequential stores for each event

- Examples of events: your app showed a page or screen, someone clicked a button, someone submitted a form, or your app recorded `checkout_started`.
- The class: one of the ten classes.
- The event name, exactly as your SDK sent it.
- The source: the SDK that sent the event.
- The time.
- The page URL and the referrer.
- The operating system, browser, country and IP address.
- The user and the session that the event belongs to.
- The event properties.

## The ten classes

Sequential gives every event exactly one class.

| Class | A row reads | What it means |
|---|---|---|
| `pageview` | "Opened" and the path, such as "Opened /pricing" | Your app showed a page or screen |
| `click` | "Clicked" and the element | Someone clicked or tapped an element |
| `form_submit` | "Sent a form" | Someone submitted a form |
| `identify` | "Identified as" and the user id | Your app tied the visitor to your user id |
| `error` | "Error:" and the message | Your app reported an error |
| `rage_click` | "Clicked" and the element, with the number of clicks | Repeated clicks on one spot, as the sending SDK detects them |
| `dead_click` | "Clicked" and the element, then "nothing happened" | A click that got no response, as the sending SDK detects it |
| `custom` | The event name | Any name not recognised as one of the above. Usually these are your own events |
| `system` | The event name | SDK housekeeping and telemetry, not something the user did |

These lines show in the session page's What they did list and in Matching events rows on Workbench › Events, such as "Opened /pricing" or "Clicked “Start trial”".

- Sequential does not drop an event because of its name.
- The set of classes is fixed. You cannot add, rename or remap classes.

### Which SDK events get each class

Sequential takes the class from the event name and from the SDK that sent it.

| Class | Produced by, for example |
|---|---|
| `pageview` | PostHog `$pageview` and `$screen`, Mixpanel `$mp_web_page_view`, `[Amplitude] Page Viewed`, Pendo `load`, Sequential `$pageview` |
| `click` | PostHog `$autocapture` clicks and taps, Mixpanel `$mp_click`, `[Amplitude] Element Clicked`, Pendo `click`, Sequential `$click` |
| `form_submit` | PostHog `$autocapture` submits, Mixpanel `$mp_submit`, `[Amplitude] Form Submitted`, Sequential `$form_submit` |
| `identify` | `$identify` from PostHog, Mixpanel, Amplitude or Sequential; Pendo `meta` |
| `error` | PostHog and Sequential `$exception`, Smartlook `error` |
| `rage_click` | PostHog `$rageclick`, Mixpanel `$mp_rage_click`, Sequential `$rageclick` |
| `dead_click` | PostHog `$dead_click`, Mixpanel `$mp_dead_click`, Sequential `$deadclick` |
| `custom` | `checkout_started` sent with `sequential.capture`, `posthog.capture`, `mixpanel.track`, `amplitude.track` or `pendo.track`; mobile `Application Opened` |
| `system` | `$pageleave`, `$web_vitals`, `$set`, PostHog mobile `Application Backgrounded`, Amplitude `session_start`, Pendo `focus` |
| `gesture` | PostHog mobile `$autocapture` swipes, pans, scrolls, pinches, rotations and long presses |

The events that your server sends with the [backend SDK](/docs/backend-sdk) are custom events too, and its errors are errors.

The same name can get different classes from different SDKs. For example, `click` from Pendo is a Click, but `click` from PostHog is Custom.

For PostHog autocapture, the kind of interaction also counts. From 6 November 2026, a swipe, a pan, a scroll, a pinch, a rotation or a long press from a PostHog mobile SDK is a `gesture`, not a `click`.

- A value change is `system`.
- A long press on a view that takes taps as long presses is a `click`: inside a web view (WebKit's `WKContentView`), and on the buttons of an alert.
- When posthog-ios sends the same interaction twice, with the same session, the same class and the same `$elements_chain`, at most 5 ms apart, Sequential stores the second as `system`. So a tap that arrives as a touch and a long press counts as one click.

Events stored before 6 November 2026 keep their class.

To see which of these events each SDK sends, read the What is supported section of its install page: [Sequential SDK](/docs/sequential), [PostHog (web)](/docs/posthog), [Mobile apps](/docs/mobile), [Mixpanel](/docs/mixpanel), [Amplitude](/docs/amplitude), [Pendo](/docs/pendo) or [Moving from Smartlook](/docs/smartlook).

## What the class is for

Each SDK names the same action differently. The class gives these events one name. To filter on the event name as your SDK sent it, use the Event filter.

### How each feature uses the class

| Feature | How it uses the class |
|---|---|
| Event type filter | Filter with a class name, such as `rage_click`. See [Filters, date ranges and saved views](/docs/filters-and-saved-views). |
| The session page | The What they did list shows the events of some classes, and each class has its own words. Its chips show or hide each kind of event. Each Error event is a red mark on the replay's timeline. See [Find and replay sessions](/docs/sessions-and-replay). |
| Judgments | Sequential writes each line of the judge's session digest from the event's class. See [Judgments](/docs/judgments). |

- For example, a page view is `$pageview` in PostHog, `[Amplitude] Page Viewed` in Amplitude and `load` in Pendo.
- A filter on Event type with the value `rage_click` means the same thing for every SDK.
- Workbench › Events, Sessions, Funnels, Flows, Retention and Accounts share these filter fields. On Workbench › Events and on the other Workbench views, the list of filter fields also has Event.
- The What they did list on the session page opens with page views, clicks, mobile gestures, rage clicks, dead clicks, form submits, errors and custom events. The Identify chip adds Identify events. The All chip adds System events.
- The What they did list groups events with the chips Pages, Clicks, Gestures, Forms, Custom, Identify and Frustration. Frustration holds rage clicks, dead clicks and errors.
- From 6 November 2026, Gestures shows only in a session with a mobile gesture. Each gesture reads as Swipe, Pan, Scroll, Pinch, Rotate or Long press, else Gesture. In the Event type menu of a filter, `gesture` reads "Swipe, pan, scroll … (mobile)".
- On a Matching events row, a custom event or a System event shows its event name as your SDK sent it. Rows of the other classes show a short line, such as "Opened /pricing" or "Clicked “Start trial”".
- In a Matching events row, Details shows the fields, the properties and the raw data of the event.

See [Workbench › Events](/docs/events-explorer).

### How the judge reads events

- The judge reads a short digest of each session.
- In the judge's digest, the line for a page view is the path. For a click, it is the element text. For an error, it is the message. For a custom event, it is the name and a few properties.
- The judge answers the default Intent and Outcome questions from the session's events. A custom event gives the judge a named milestone. Without one, the judge has mostly page paths and click text.
- The judge reads at most 255 events per session. When a session has more than 255 events, the judge leaves out mobile gestures first, then plain clicks, then custom events. It keeps errors, rage clicks and dead clicks longest.
- From 14 October 2026, a page that the visitor reached with their own Back button or swipe reads "went back (u-turn)" with the page. From 3 November 2026, with the Sequential SDK, this is also so when the router of the page answers the Back. This needs a Sequential SDK that sends how the page was reached. It changes only the judgments made after that date.
- From 17 October 2026, a Back that comes at most 300 ms after a click shows as a plain page. Sequential takes it as a Back button on your page, not the visitor's own Back.
- From 18 October 2026, the first page of a session never reads "went back (u-turn)". A Back to that page came from outside the session: from another site, or from your site before the session started. A later Back in the same session still reads "went back (u-turn)". Older judgments do not change.

## Autocaptured and custom events

- Autocaptured events are page views, clicks and form submits that an SDK sends without code from you. With the Sequential SDK, autocapture is on by default. It never records what a user types.
- Custom events are events that you send by name from your own code, such as `checkout_started`. See [Send custom events](/docs/custom-events).

## Hidden System events

SDKs send many housekeeping events. Sequential gives SDK housekeeping events the System class. It stores them like any other event. The judge's digest leaves them out completely.

### Where System events show

- In the What they did list, the All chip shows them. It carries a number, such as "All +12".
- Workbench › Events includes System events: in the count, the chart, the breakdown and Matching events.
- Examples of System events: page-leave and web-vitals events, feature-flag calls, profile updates such as `$set`, app backgrounding, and session start and end.
- To list only System events, open Workbench › Events. Filter on Event type, with the operator "is" and the value `system`.

## Event, super and user properties

Events carry three kinds of properties: event properties, such as `plan` on `checkout_started`; super properties, which you set with `sequential.register()`; and user properties.

| Kind | Describes | Comes from | Where you see it |
|---|---|---|---|
| Event properties | One event | The properties on a capture or track call, such as `plan` on `checkout_started` | The Event property filter, and Event property… in Break down by on Workbench › Events |
| Super properties | Every later event from the page | `sequential.register()`. They arrive as event properties on each event | As event properties |
| User properties | The user | Profile calls: Pendo visitor metadata, Amplitude `Identify` with `set`/`setOnce`, Smartlook `identify` properties and `smartlook('properties', …)` | What your app sent about them on a person's page, Their properties in the Info tab of a session page, and the Visitor property filter |

Sequential SDK super properties last only as long as the page. To keep them, call `register()` on every page load.

Sequential stores `pendo.track` properties as user properties, not event properties.

### How each SDK's data becomes properties

- Sequential SDK super properties last only as long as the page. To keep them, call `register()` on every page load.
- If a call passes a property with the same key as a super property, Sequential uses the value from the call.
- Not every SDK's "user" data becomes user properties. PostHog `$set` and `$set_once` stay as event properties on that one event. The properties that you pass to the Sequential SDK's `identify` also stay as event properties on that one event. A person's page shows them under What your app sent about them, with the user properties.
- The Visitor property filter does not find PostHog `$set`, `$set_once` or Sequential SDK `identify` properties. A person's page shows the Sequential SDK `identify` properties with the user properties, but not PostHog `$set` and `$set_once`.
- Pendo works the other way. Sequential stores `pendo.track` properties as user properties.
- Sequential does not accept Mixpanel's `people.set` from the browser today.
- Only Pendo and the Sequential SDK's `sequential.account()` fill account properties. See [What each SDK supports](/docs/support-matrix).
- Pass `identify` the same identifier for a user every time. Sequential takes the value as given. It does not merge two different values for one user. See [Identify your users](/docs/identify-users).

### How property values are stored and filtered

- Sequential stores values as text. It stores a value that looks like a date and time, such as `2026-10-01T09:00`, as a date.
- If a text value or a key has half of a character pair, for example half of an emoji (an unpaired UTF-16 surrogate), Sequential stores "�" (U+FFFD) in place of that half. It stores the rest of the event. A complete pair, such as a full emoji, does not change.
- The Event property filter matches one of the event's own properties by its name, with a type and an operator. The operator "is" with the type Text matches the exact text of the whole value. To compare a number or a date, choose the type Number or Date. See [Property conditions](/docs/filters-and-saved-views#property-conditions).
- To filter on a date and time value, choose the type Date in a property condition.

## When an event does not show

- System events: Sequential stores them, but the What they did list hides them. See [Hidden System events](#hidden-system-events).
- Errors from the Sequential SDK: it stores an Error event only for errors that you pass to `captureException`. Uncaught errors do not become events. If replay is on, the recording's [DevTools](/docs/devtools) still captures them. The setting Settings › Recording & data › What a recording carries › JavaScript errors is on by default.
- Errors from other SDKs: Sequential turns off PostHog's exception autocapture. So by default, only errors that you send with `posthog.captureException` arrive. Mixpanel, Amplitude and Pendo send no error events.
- Rage and dead clicks: Sequential stores them only if the sending SDK detects them. PostHog's dead-click detection is off with Sequential, unless your `posthog.init` sets `capture_dead_clicks`. See [What each SDK supports](/docs/support-matrix).
- Reserved names: if your custom event uses a name that the sending SDK keeps for itself, the event gets the class of that name. For example, through Amplitude, `session_start` is System, so the What they did list hides it.
- Names that start with `$`: with the Sequential SDK, `capture()` throws on any event name that starts with `$`.

### Rage clicks, dead clicks and name collisions per SDK

- Rage and dead clicks from the Sequential SDK: it detects them and sends `$rageclick` and `$deadclick`. See [Rage clicks and dead clicks](/docs/sequential#rage-clicks-and-dead-clicks). An older copy of the SDK, for example a self-hosted copy, sends neither.
- If Amplitude sends rage-click or dead-click events, Sequential stores them as Custom.
- Examples of name collisions: through Amplitude, `session_start` is System and hidden. Through Pendo, `focus` is System and `click` is Click.
- The Sequential SDK guards its own names: `capture()` throws on any name that starts with `$`.

## FAQ

### Why send custom events?

Use custom events for moments that only your app knows about. Autocapture can show that someone clicked "Continue". A custom event shows that they started checkout. A funnel or flow step can use the exact name of a custom event.

### How do I name custom events?

Keep names stable and few, such as `checkout_started`, `invoice_sent` or `plan_changed`. Put what changes, such as plan, amount or item count, in properties. Do not use names such as `scroll`, `change`, `idle` or `heartbeat`. These events stay Custom.

See [Send custom events](/docs/custom-events).

## Related pages

- [How Sequential works](/docs/how-it-works): from event to judgment.
- [User ids and identity](/docs/users-and-identity): who an event belongs to.
- [Workbench › Events](/docs/events-explorer): count your events.
- [DevTools in replays](/docs/devtools): uncaught errors in a recording.
- [Glossary](/docs/glossary): the terms in these docs.
