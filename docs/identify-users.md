# Identify your users

> Identify tells Sequential who a person is. Pass one value per person, every time, so they count as one person on each browser and device you identify.

> **At a glance**
>
> - **Before you start:** An SDK that sends to Sequential ([Install Sequential](/docs/install)). Access to your sign-up, sign-in, restore-on-load and sign-out code.
> - **Know this:** Sequential SDK, PostHog or Mixpanel: some pages count events from before identify under the person. Not Amplitude, Pendo or Smartlook.
> - **Know this:** [Evidence](/docs/watch) and [Ask](/docs/ask) do not need identify. They judge anonymous sessions too.

## Add identify and reset to your app

If one person uses your website and your iOS or Android app, see [Identify one person on the web and in your apps](#identify-one-person-on-the-web-and-in-your-apps).

1. Find where your app learns who the person is: the sign-up callback, the sign-in callback, and the code that restores a sign-in on load.

   **If the sign-in is restored from a cookie**

   Identify on app load too. Your app can restore a sign-in from a cookie, in a browser where the SDK has never seen that person. The Sequential SDK keeps the identified value in the browser's storage until `reset()`. So later visits from that browser also have it. A repeat call to the Sequential SDK with the same value and the same properties sends nothing, so it is safe to call identify on every app load.

2. At each place, after the person is known, call identify with the value your app already uses. Use the same value everywhere and every time.

   Sequential SDK (website). The value must be a non-empty string: the SDK ignores anything else, such as a number, without an error. So convert a numeric id with `String(…)`. With another SDK, use its own calls: [Identify with another SDK](#identify-with-another-sdk).

   ```js
   // Sign-up, sign-in, and app load for a user who is already signed in.
   // `identifier` is the value your app already uses for this person, as a string.
   sequential.identify(identifier);

   // Sign-out: the next person on this browser starts as a new anonymous visitor.
   sequential.reset();
   ```

3. Optionally, pass properties. Keep personal data and secrets out of them, as with any event property.

   Result: If identify passes a `name` or an `email`, the lists show them instead of the value.

   **If you pass properties with the Sequential SDK**

   Properties stay on the event. They are properties of that one `$identify` event, not visitor properties. The person's page shows them under "What your app sent about them". The lists show a `name` or `email` from them. The Visitor property filter does not find them. Event property finds the `$identify` event by one of them. If you call `identify` again with the same value and the same properties, the SDK sends nothing. From 11 October 2026, if the properties changed, the SDK sends them again.

4. When a sign-in ends, call reset: on sign-out, and where your app finds that the person is no longer signed in.

   Result: The next person on that browser starts with a new anonymous id. Without reset, an identify for the next person links the previous person's value to the next person, and People shows the previous person's events under the next person.

   **If a sign-in expires or ends in another tab**

   An expired sign-in, or a sign-out in another tab, are examples of where a sign-in ends. Your app learns that a sign-in ended only when it checks. Until then, the SDK sends events under the previous person's id. An example of such an event is the page view that many SDKs send when they start. The reset applies from then on.

5. Do not call reset on every page load for people who are not signed in.

   **If your app finds on load that a sign-in ended**

   Each reset call starts a new anonymous id. To reset on load only after a sign-in ended, use a flag.

   Many apps learn that a sign-in ended only on load, when they find nobody signed in. This looks the same as a person who never signed in. To tell the two apart, keep a small flag of your own:

   - Put no personal data in the flag.
   - Keep the flag in the same storage where your SDK keeps its ids. For the Sequential SDK, this is the browser's local storage. Then the flag lasts exactly as long as the identity it stands for.
   - Set the flag when you call identify. Clear it when you call reset.
   - On load, call reset only if the flag is set.
   - Treat only a definite "not signed in" answer as the end of a sign-in: for example a 401 or 403 from your session check, not a server error or a network failure. If a network or server error also triggers the reset, a signed-in person becomes anonymous. They stay anonymous until the next load identifies them again with the same value.

   Why this works:

   - A person who never signed in has no flag. So nothing resets, and their anonymous id survives every page load.
   - After a sign-in expires, the flag triggers one reset, and your app clears the flag with it. So later loads leave the new anonymous id alone.
   - If the browser's storage is cleared, the SDK's own ids go with the flag. So no stale identity is left to reset. This is why the flag must be in the same storage as the SDK's ids.

### Questions identify helps you answer

Identify tells Sequential which person uses a browser. These features group events by the user id: People and each person's page, the funnel's lists of people who left, retention cohorts, flows, and the People count on Workbench › Events.

- Which people on a trial opened the import wizard last week and never finished it? The funnel's list of the people who left names them.
- Of the people who signed up in March, how many came back a week later? This counts every browser or device they signed in on.
- A person writes to support. Find them on People and open their page. Its "Visits, last 30 days" section lists their sessions.

Without identify, a person who opens a private window or clears their storage is also two people. The lists of people who left then show ids that nobody can act on.

### How identify works in the Sequential SDK

- A repeat call sends only changes. If you call `identify` with the value the SDK already has, and with no properties or the same properties as the last call, the SDK sends nothing. So it is safe to call it on every app load.
- From 11 October 2026, if the properties are different, for example a new email, the SDK sends a new `$identify` event with them. To compare, the SDK keeps a hash of the value and the properties in the browser's local storage (`__sq_ith`), never the properties. `reset` clears it. A browser that already had the value before this change sends the properties once more at its next call.
- Placeholders become people. The SDK accepts any non-empty string. If you identify with `'guest'`, or with a missing value turned into `'undefined'`, everyone given it becomes one person. A sign-up response that nobody checked is one example of a missing value that becomes `'undefined'`.
- TypeScript: sequential.js has no published type declarations. Read it through `window` with a narrow local type, as the [Sequential SDK](/docs/sequential) page describes.
- To check with the Sequential SDK: on your page in People, select "All events of this person". The identify event reads "Identified as" followed by your value.
- After `sequential.optOut()`, `identify` does nothing.
- `reset()` also clears the properties added with `register()`, and it starts a new session.

### Check that it worked

1. Sign in to your app.

2. Open **People** in Sequential and find yourself.

   Result: If identify passed an email, the email shows under your name. Otherwise "Identified" shows under your name. That shows that the identify arrived.

## Identify with another SDK

Sequential reads the id that each SDK already sends, so use that SDK's own calls.

| SDK | Identify with | On sign-out |
|---|---|---|
| PostHog (web and mobile) | `posthog.identify(identifier)`, or the mobile SDK's `identify` | `posthog.reset()`, or the mobile SDK's `reset` |
| Mixpanel | `mixpanel.identify(identifier)` | `mixpanel.reset()` |
| Amplitude | `amplitude.setUserId(identifier)` | `amplitude.reset()` |
| Pendo | `visitor.id` in `pendo.initialize`, plus `account.id` for the account | Pendo's own handling. Sequential reads the `visitor.id` on each event. |
| Smartlook | `smartlook('identify', identifier, props)` | `smartlook('anonymize')` |

### What becomes user properties in each SDK

| SDK | What becomes user properties |
|---|---|
| PostHog (web and mobile) | Nothing. `$set` and `$set_once` stay on the event. |
| Mixpanel | Nothing today. `mixpanel.people.set` from the browser SDK does not reach user properties. |
| Amplitude | An `Identify` with `set` or `setOnce`. `add`, `append` and `unset` are ignored. |
| Pendo | Visitor metadata. Account metadata becomes account properties. Pendo is the only source that fills accounts. |
| Smartlook | Identify properties and `smartlook('properties', …)`. |

PostHog `$set` and Mixpanel `people.set` do not fill user properties. For Amplitude, Sequential ignores `add`, `append` and `unset`.

Identify properties do not become visitor properties, so the Visitor property filter does not find them. The person's page shows them under "What your app sent about them".

To filter on visitor properties, use Visitor property. To filter on Pendo's account properties, use Account property. Both filters have the same types and operators as Event property: see [Property conditions](/docs/filters-and-saved-views#property-conditions).

[Users and identity](/docs/users-and-identity) has the detail.

## Use one value for each person

Pass any value that your app uses to identify that person: a user id, an email or an account key.

### How values are stored and shown

Do not make a new kind of value only for Sequential. If you identify on the web and in your apps, use one value everywhere: the id from your own users table. To make this easy, send every call through one function in your code. Let that function read the value from one place. "Every SDK" means every SDK that sends to Sequential, for example your web app and your mobile app.

- Each event that Sequential stores has exactly one user id. Before identify, the user id is the SDK's anonymous id for that browser. After identify, the user id is the value that your app passed. Sequential uses the value as it is.
- Sequential does not check what kind of identifier a value is. It does not rank one kind above another.
- The one rule is consistency. Two values for one person are two people. This is by design. Sequential does not guess that two values are one person. So your app must keep the value consistent.
- A missing value can become a string like `'undefined'`. Everyone given that value becomes one person.
- The lists mark a user id as identified when it has an identify event, or a linked anonymous id. On People, such a person shows "Identified". Any other person shows "Anonymous".
- The value shows on People, in Evidence, at the top of the person's page, and in the Person id filter. A long value of an identified person shows as its last 6 characters, such as `…9c41e7`. On Evidence rows and Ask results, the user id is only a label and a link.
- The judge never sees the user id or identify properties. It sees only a one-word flag: identified or anonymous. This flag does not mean "signed in". For Evidence and Ask, identified means that an identify event arrived in that session.

## Identify one person on the web and in your apps

From 12 October 2026, a person who uses your website and your iOS or Android app counts as one person, when every platform identifies them with the same id.

1. On the website, call `sequential.identify(userId)`. If you use PostHog or Mixpanel there, call `posthog.identify(userId)` or `mixpanel.identify(userId)`.

2. In the iOS and Android apps, call PostHog's `identify(userId)` with the same `userId`.

3. On sign-out, call `reset()` on each platform: `sequential.reset()` on the website, PostHog's `reset()` in the apps.

   **If your app uses register, or does not call reset**

   `reset()` also removes the properties that the app added with `register`: in the Sequential SDK, and in PostHog's Android SDK from posthog-android 3.72.3. Register them again after `reset()`.

   From 23 October 2026, if your app does not call `reset()` and a second person signs in on the same browser, Sequential no longer moves the first person's history to the second person. sequential.js then also sends no link from the first person to the second.

Result: On People, funnels, flows, retention and the people counts on Workbench › Events, the events from before identify join that person, on every device: the website's and each app's anonymous events.

### Platform and Operating system filters

To see the website or one app, filter on Platform: `web`, `ios` or `android`. To see one operating system, filter on Operating system, for example `iOS` or `Android`. From 12 October 2026, new events from an Android app read `Android`, as a browser on Android does. Events stored before that date can read `android`. The Operating system filter ignores case, so `Android` also finds them.

## What happens to events from before identify

With the Sequential SDK, PostHog or Mixpanel, some pages count the events from before identify under the identified person: People, [funnels](/docs/funnels), flows, retention and the people counts on Workbench › Events.

For Mixpanel, Sequential keeps the identity link from 12 October 2026. A Mixpanel identify stored before that date has no identity link.

### Do earlier visits and funnel steps join the person?

Identify changes the stored user id from that moment on. It does not change the events stored before identify. So a person who browses anonymously and then signs up leaves one session under two ids. With the Sequential SDK, PostHog or Mixpanel, identify also sends an identity link to the anonymous id. Today the pages named above use it, and the identity link also means:

- Their earlier anonymous visits in that browser count too, for example last week's visits. This can take up to 5 minutes.
- A funnel whose early steps happen before sign-up keeps them. The steps before and after identify join.
- Their page lists the earlier anonymous visits too.
- A Person id filter with their value also finds their events from before identify.
- Evidence and Workbench › Sessions show the identified value on those sessions.
- The Brief counts people the same way.

### When your app passes a second value in the same session

- Your app can identify with one value, and later with another in the same session. Sequential then stores that visit under three ids: the anonymous id, the first value and the second value.
- When you call identify, the Sequential SDK also sends the id that it replaces. Sequential records this link. People, each person's page, Accounts, Workbench › Sessions, funnels, flows, retention and Workbench › Events use it. The Brief uses it too.
- Sequential records the link only for the Sequential SDK.
- The link is one step. With two values in one session, People shows the anonymous part under the first value, and the events stored under the first value under the second value. It never shows the anonymous part under the second value.
- A link from the first value to the second applies to every event stored under the first value, on every device. If the first value is linked to two values, those events go to the value that Sequential received first.
- The link covers every session of the replaced id. If that id is linked to two values, each session where identify ran follows its own link. All the other sessions of that id go to the first value that Sequential received for that anonymous id.

[Users and identity](/docs/users-and-identity) explains the identity link.

## Fix one person who shows as two people

| Symptom | Cause | Fix |
|---|---|---|
| Your app passes two values for one person, for example an id at sign-up and an email at a later sign-in, or an email on one platform and a key on another | Two values for one person are two people. | Pass the same value for the same person at every call, on app load, and in every SDK that sends to Sequential. |
| No identify, and the person uses a laptop and a phone, opens a private window or clears their storage | Without identify, the user id is an anonymous id that the SDK makes for each browser. | Call identify at sign-up, at sign-in, and on app load for a person who is already signed in. |
| You use Amplitude, Pendo or Smartlook | Nothing links the two ids. They send no identity link, so their ids from before and after identify stay two people on every page. | — |
| Smartlook: each identified person shows as two people on People | Only the identify event has your value. The other events from Sequential's Smartlook script stay under the Smartlook visitor id. | — |
| Your app calls reset on every page load for people who are not signed in | Each reset call starts a new anonymous id. Each page view then counts as a new person. | To reset on load only after a sign-in ended, use a flag ([If your app finds on load that a sign-in ended](#reset-on-load-with-a-flag)). |
| The browser blocks storage, for example in some private windows | The Sequential SDK cannot keep ids across page loads. Each load starts a new anonymous id until identify runs again. This is one more reason to identify on every app load. | — |
| The events from before identify do not show under the person yet | A new identity link can take up to 5 minutes to show. | — |

## FAQ

### Do Evidence and Ask need identify?

No. Evidence and Ask judge sessions, not people, so the judge also judges anonymous sessions. With the Sequential SDK, an identified person's later sessions read as anonymous to the judge. The reason is that a repeat `identify` sends nothing, unless its properties changed. See [AI judgments of sessions](/docs/judgments).

### Why does a recording have no user id?

With the Sequential SDK, the replay recorder reads the user id from the storage of the browser. If the browser blocks storage, the recording has no user id. Some browsers block storage, for example in some private windows. Evidence and Workbench › Sessions still show the person, taken from events.

## Next steps

- [Send custom events](/docs/custom-events): name the moments that matter.
- [Check that your install works](/docs/verify): see that events arrive.
- [Users and identity](/docs/users-and-identity): how Sequential files events under one user id.
- [Users and accounts](/docs/users-and-accounts): find a person and their sessions.
- [What each SDK supports](/docs/support-matrix)
