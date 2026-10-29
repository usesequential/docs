# Identify your users

> Identify tells Sequential who a visitor is. Pass one value per person, every time, so they count as one user on each browser and device you identify.

> **In short**
>
> - Call identify at sign-up, at sign-in, and on app load for a user who is already signed in.
> - Pass the value your app already uses for that person. Use the same value everywhere and every time.
> - Call reset when a sign-in ends.
> - With the Sequential SDK, PostHog or Mixpanel, **People**, each person's page, funnels, flows, retention and Workbench › **Events** count the activity from before identify under the identified user. The **Brief** does too.
> - Evidence and Ask do not need identify. They judge anonymous sessions too.

## What it is for

Identify tells Sequential which person uses a browser. These features group events by the user id: **People** and each person's page, funnel drop-off lists, retention cohorts, flows, and the **People** count on Workbench › **Events**.

Without identify, the user id is an anonymous id that the SDK makes for each browser. So one person on a laptop and a phone is two users.

### Questions identify helps you answer

- Which trial users opened the import wizard last week and never finished it? The funnel's drop-off list names them.
- Of the people who signed up in March, how many came back a week later? This counts every browser or device they signed in on.
- A customer writes to support. Find them on **People** and open their page. Its **Visits, last 30 days** section lists their sessions.

Without identify, a person who opens a private window or clears their storage is also two users. Drop-off lists then show ids that nobody can act on.

## How it works

Each event that Sequential stores has exactly one user id.

- **Before identify**, the user id is the SDK's anonymous id for that browser.
- **After identify**, the user id is the value that your app passed. Sequential uses the value as it is.

## Use one value for each person

Pass the value that your app uses to identify that person: a user id, an email or an account key. Any of them works.

The one rule is **consistency**. Pass the same value for the same person at every call, on app load, and in every SDK that sends to Sequential. If your app identifies one person with two different values, Sequential sees two users.

### How values are stored and shown

- The lists mark a user id as identified when it has an identify event, or a linked anonymous id. On **People**, such a person shows **Identified**. Any other person shows **Anonymous**.
- The value shows on **People**, in **Evidence**, at the top of the person's page, and in the **Person id** filter. If identify also passes a `name` or an `email`, the lists show them instead. A long value of an identified person shows as its last 6 characters, such as `…9c41e7`.
- Sequential does not check what kind of identifier a value is. It does not rank one kind above another.
- Two values for one person are two users. For example: an id at sign-up and an email at a later sign-in. This is by design. Sequential does not guess that two values are one person. So your app must keep the value consistent.
- Every SDK means every SDK that sends to Sequential, for example your web app and your mobile app.
- Identify on app load too. Your app can restore a sign-in from a cookie, in a browser where the SDK has never seen that user.
- The Sequential SDK keeps the identified value in the browser's storage until `reset()`. So later visits from that browser also have it.
- To make this easy, send every call through one function in your code. Let that function read the value from one place.

## Identify a user

1. Find the places where your app learns who the user is: the sign-up callback, the sign-in callback, and the code that restores a sign-in on load.
2. At each place, call identify with the value your app already uses for that person.
3. Optionally, pass properties. Keep personal data and secrets out of them, as with any event property.
4. When a sign-in ends, call reset. Do this on sign-out, and where your app finds that the user is no longer signed in.
5. Check the result. Sign in to your app, open **People** in Sequential and find yourself. If identify passed an email, the email shows under your name. Otherwise **Identified** shows under it, and that shows that the identify arrived.

To check the rest of your install, see [Check your install](/docs/verify).

### More about the steps and warnings

- **Where a sign-in ends:** an expired sign-in, or a sign-out in another tab, are examples. After reset, the next person on that browser starts as a new anonymous visitor, not under the previous user's id. Without reset, an identify for the next person links the previous user's value to the next person, and **People** shows the previous user's events under the next person.
- **Check with the Sequential SDK:** on your page in **People**, select **All events of this person**. The identify event reads **Identified as** followed by your value.
- **Missing values:** a sign-up response that nobody checked is one example of a missing value that becomes `'undefined'`.
- **Reset on every load:** each reset call starts a new anonymous visitor. To reset on load only after a sign-in ended, use a flag.

> **Do not do these**
>
> - Do not make a new kind of value only for Sequential.
> - Do not call identify before the user is known. A missing value can become a string like `'undefined'`. Everyone given that value becomes one user.
> - Do not call reset on every page load for visitors who are not signed in. Each page view then counts as a new user. See **Reset on load with a flag** below.

### Sequential SDK

```js
// Sign-up, sign-in, and app load for a user who is already signed in.
// `identifier` is the value your app already uses for this person, as a string.
sequential.identify(identifier);

// Sign-out: the next person on this browser starts as a new anonymous visitor.
sequential.reset();
```

**The value must be a non-empty string.** The SDK ignores anything else, such as a number, without an error. So convert a numeric id with `String(…)`.

### Other SDKs

Sequential reads the id that each SDK already sends. So use that SDK's own calls. See **Calls in other SDKs** below.

## What identify does not do

Identify changes the stored user id from that moment on. It does not change the events stored before identify. A visitor who browses anonymously and then signs up leaves one session under two ids.

With the Sequential SDK, PostHog or Mixpanel, identify also sends a link to the anonymous id. For Mixpanel, Sequential keeps the link from 12 October 2026. A Mixpanel identify stored before that date has no link. Some pages use the link. Today this means:

- **People**, funnels, flows, retention and the people counts on Workbench › **Events** count them as one user. Their earlier anonymous visits in that browser count too, for example last week's visits. This can take up to 5 minutes.
- A funnel whose early steps happen before sign-up keeps them. The steps before and after identify join.
- Their page lists the earlier anonymous visits too.
- A **Person id** filter with their value also finds their events from before identify.
- Evidence and Workbench › **Sessions** show the identified value on those sessions.
- The **Brief** counts people the same way.
- If your app identifies with a second value in the same session, see **Two values in one session, and the recorded link** below.

With Amplitude, Pendo or Smartlook, nothing links the two ids. They count as two users on every page. [Users and identity](/docs/users-and-identity) explains the link.

## One person on the web and in your apps

From 12 October 2026, a person who uses your website and your iOS or Android app counts as one person, when every platform identifies them with the same id.

1. On the website, call `sequential.identify(userId)`. If you use PostHog or Mixpanel there, call `posthog.identify(userId)` or `mixpanel.identify(userId)`.
2. In the iOS and Android apps, call PostHog's `identify(userId)` with the same `userId`.
3. On sign-out, call `reset()` on each platform: `sequential.reset()` on the website, PostHog's `reset()` in the apps. `reset()` also removes the properties that the app added with `register`: in the Sequential SDK, and in PostHog's Android SDK as of posthog-android 3.72.3. Register them again after `reset()`. From 23 October 2026, if your app does not call `reset()` and a second person signs in on the same browser, Sequential no longer moves the first person's history to the second person. sequential.js then also sends no link from the first person to the second.

- The events from before identify join that person, on every device: the website visitor's and each app's anonymous events. **People**, funnels, flows, retention and the people counts on Workbench › **Events** count them under your id. A new link can take up to 5 minutes to show.
- Use one id everywhere: the id from your own users table. An email on one platform and a key on another are two people.
- To see the website or one app, filter on **Platform**: `web`, `ios` or `android`. To see one operating system, filter on **Operating system**, for example `iOS` or `Android`. From 12 October 2026, new events from an Android app read `Android`, as a browser on Android does. Events stored before that date can read `android`. The **Operating system** filter ignores case, so `Android` also finds them.
- Amplitude, Pendo and Smartlook send no link, so their ids from before and after identify stay two people.

## Evidence and Ask do not need it

Evidence and Ask judge sessions, not people. So the judge also judges anonymous sessions. With the Sequential SDK, an identified user's later sessions read as anonymous to the judge. See [Judgments](/docs/judgments).

## What it needs

- An SDK that sends to Sequential. See [Install Sequential](/docs/install).
- Access to the code where a user signs up, signs in, is restored on load and signs out.

## Limits

| Limit | What happens |
|---|---|
| Smartlook | Only the identify event has your value. So each identified person shows as two users on **People**. |
| The first event after a sign-in expires | Until your app checks, the SDK sends events under the previous user's id. |
| Blocked storage | The Sequential SDK cannot keep ids across page loads. Each load starts a new anonymous visitor until identify runs again. |
- Identify properties do not become visitor properties, so the **Visitor property** filter does not find them. The person's page shows them under **What your app sent about them**.
- PostHog `$set` and Mixpanel `people.set` do not fill user properties. For Amplitude, Sequential ignores `add`, `append` and `unset`.
- If you call `identify` again with the same value and the same properties, the SDK sends nothing. From 11 October 2026, if the properties changed, the SDK sends them again. See **A repeat call** below.
- The **Visitor property** and **Account property** filters have the same types and operators as **Event property**. See [Property conditions](/docs/filters-and-saved-views#property-conditions).

### More about the limits

- **Replay:** with the Sequential SDK, the replay recorder reads the user id from the storage of the browser. If the browser blocks storage, the recording has no user id. Evidence and Workbench › **Sessions** still show the user, taken from events.
- **Smartlook:** the other events from Sequential's Smartlook script stay under the Smartlook visitor id.
- **Expired sign-in:** your app learns that a sign-in ended only when it checks. An example of such an event is the page view that many SDKs send when they start. The reset applies from then on.
- **Blocked storage:** some browsers block storage, for example in some private windows. This is one more reason to identify on every app load.

### Two values in one session, and the recorded link

- Your app can identify with one value, and later with another in the same session. Sequential then stores that visit under three ids: the anonymous id, the first value and the second value.
- When you call identify, the Sequential SDK also sends the id that it replaces. Sequential records this link. **People**, each person's page, **Accounts**, Workbench › **Sessions**, funnels, flows, retention and Workbench › **Events** use it. The **Brief** uses it too.
- Sequential records the link only for the Sequential SDK.
- The link is one step. With two values in one session, **People** shows the anonymous part under the first value, and the events stored under the first value under the second value. It never shows the anonymous part under the second value.
- A link from the first value to the second applies to every event stored under the first value, on every device. If the first value is linked to two values, those events go to the value that Sequential received first.
- The link covers every session of the replaced id. If that id is linked to two values, each session where identify ran follows its own link. All the other sessions of that id go to the first value that Sequential received for that anonymous id.

### Reset on load with a flag

Many apps learn that a sign-in ended only on load, when they find nobody signed in. This looks the same as a visitor who never signed in. To tell the two apart, keep a small flag of your own:

- Put no personal data in the flag.
- Keep the flag in the same storage where your SDK keeps its ids. For the Sequential SDK, this is the browser's local storage. Then the flag lasts exactly as long as the identity it stands for.
- Set the flag when you call identify. Clear it when you call reset.
- On load, call reset only if the flag is set.
- Treat only a definite "not signed in" answer as the end of a sign-in: for example a 401 or 403 from your session check, not a server error or a network failure. If a network or server error also triggers the reset, a signed-in user becomes anonymous. They stay anonymous until the next load identifies them again with the same value.

Why this works:

- A visitor who never signed in has no flag. So nothing resets, and their anonymous id survives every page load.
- After a sign-in expires, the flag triggers one reset, and your app clears the flag with it. So later loads leave the new anonymous id alone.
- If the browser's storage is cleared, the SDK's own ids go with the flag. So no stale identity is left to reset. This is why the flag must be in the same storage as the SDK's ids.

### More about the Sequential SDK

- **A repeat call sends only changes.** If you call `identify` with the value the SDK already has, and with no properties or the same properties as the last call, the SDK sends nothing. So it is safe to call it on every app load. From 11 October 2026, if the properties are different, for example a new email, the SDK sends a new `$identify` event with them. To compare, the SDK keeps a hash of the value and the properties in the browser's local storage (`__sq_ith`), never the properties. `reset` clears it. A browser that already had the value before this change sends the properties once more at its next call.
- **Placeholders become users.** The SDK accepts any non-empty string. If you identify with `'guest'`, or with a missing value turned into `'undefined'`, every visitor given it becomes one user.
- **Properties stay on the event.** They are properties of that one `$identify` event, not visitor properties. The person's page shows them under **What your app sent about them**. The lists show a `name` or `email` from them. The **Visitor property** filter does not find them. **Event property** finds the `$identify` event by one of them.
- **TypeScript:** sequential.js has no published type declarations. Read it through `window` with a narrow local type, as the [Sequential SDK](/docs/sequential) page describes.
- After `sequential.optOut()`, `identify` does nothing.
- `reset()` also clears the properties added with `register()`, and it starts a new session.

### Calls in other SDKs

| SDK | Identify with | On sign-out | What becomes user properties |
|---|---|---|---|
| PostHog (web and mobile) | `posthog.identify(identifier)`, or the mobile SDK's `identify` | `posthog.reset()`, or the mobile SDK's `reset` | Nothing. `$set` and `$set_once` stay on the event. |
| Mixpanel | `mixpanel.identify(identifier)` | `mixpanel.reset()` | Nothing today. `mixpanel.people.set` from the browser SDK does not reach user properties. |
| Amplitude | `amplitude.setUserId(identifier)` | `amplitude.reset()` | An `Identify` with `set` or `setOnce`. `add`, `append` and `unset` are ignored. |
| Pendo | `visitor.id` in `pendo.initialize`, plus `account.id` for the account | Pendo's own handling. Sequential reads the `visitor.id` on each event. | Visitor metadata. Account metadata becomes account properties. Pendo is the only source that fills accounts. |
| Smartlook | `smartlook('identify', identifier, props)` | `smartlook('anonymize')` | Identify properties and `smartlook('properties', …)`. |

### Filters and user properties

- To filter on visitor properties, use **Visitor property**. To filter on Pendo's account properties, use **Account property**. Both filters have a type and an operator, as **Event property** has.

[Users and identity](/docs/users-and-identity) has the detail.

### What the identified flag means

The judge never sees the user id or identify properties. It sees only a one-word flag: identified or anonymous. This flag does not mean "signed in".

- **Evidence and Ask:** identified means that an identify event arrived in that session. With the Sequential SDK, an identified user's later sessions read as anonymous to the judge. The reason is that a repeat `identify` sends nothing, unless its properties changed.

On Evidence rows and Ask results, the user id is only a label and a link.

## Related

- [Users and identity](/docs/users-and-identity)
- [Users and accounts](/docs/users-and-accounts)
- [Funnels](/docs/funnels)
- [Send custom events](/docs/custom-events)
- [What each SDK supports](/docs/support-matrix)
