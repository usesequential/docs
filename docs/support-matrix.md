# What each SDK supports

> Which capabilities you get from each SDK that can send to Sequential, in one table, with every partial and missing cell explained.

> **Key facts**
>
> - The Sequential SDK has every capability except feature flags, surveys and experiments. User properties, errors and server-side SDKs are Partial.
> - PostHog (web), Mixpanel, Amplitude and Pendo need [Sequential’s recorder](/docs/session-replay) for replay and DevTools. It joins your SDK’s session id automatically.
> - Groups / accounts is Yes only for the Sequential SDK (`sequential.account()`) and Pendo. Errors is Yes only for Smartlook.
> - No SDK gives feature flags, surveys or experiments. With PostHog, flags evaluate as off; with Pendo, no guides show while Pendo’s agent points at Sequential.
> - Sequential accepts only browser SDKs and PostHog’s mobile SDKs. It rejects server-side SDKs (posthog-node, mixpanel-python, Segment and similar) as bots, by design. For your own server, use the backend SDK for Node.

| Capability | Sequential SDK | PostHog (web) | PostHog (mobile) | Mixpanel | Amplitude | Pendo | Smartlook |
|---|---|---|---|---|---|---|---|
| Custom events | Yes | Yes | Yes | Partial | Yes | Partial | Yes |
| Page / screen views | Yes | Yes | Yes | Yes | Partial | Yes | Yes |
| Autocaptured clicks & forms | Yes | Yes | Partial | Yes | Yes | Yes | Partial |
| Identify (user id) | Yes | Yes | Yes | Yes | Yes | Yes | Yes |
| User properties | Partial | Partial | Partial | No | Partial | Yes | Yes |
| Groups / accounts | Yes | No | No | No | No | Yes | No |
| Errors | Partial | Partial | Partial | No | No | No | Yes |
| Session replay | Yes | Partial (recorder) | Yes | Partial (recorder) | Partial (recorder) | Partial (recorder) | Yes |
| DevTools: errors, console, network, performance | Yes | Yes (recorder) | Partial | Yes (recorder) | Yes (recorder) | Yes (recorder) | Yes |
| Feature flags, surveys, experiments | No | No | No | No | No | No | No |
| Server-side SDKs | Partial | No | No | No | No | No | No |

| In the grid | Meaning |
|---|---|
| Yes | The capability works as you would expect. |
| Yes (recorder) | It works after you add Sequential’s recorder to the page. |
| Partial | It works with a limit, explained in that SDK’s notes. The same notes appear on that SDK’s install page. |
| Partial (recorder) | Sequential does not play your SDK’s own recording. Add Sequential’s recorder to the page. |
| No | Sequential does not get it from that SDK. |
| Errors (row) | Error events. For errors in a replay, see the DevTools row. |

Sequential accepts data from its own SDK and from several vendor SDKs you may already run. Each one sends what its maker designed it to send, so what you can do in Sequential depends on the SDK.

## Extra steps for some capabilities

| If you use | Do this | To get |
|---|---|---|
| Sequential SDK | Call `captureException` where you handle errors. | Errors. |
| PostHog (web) or PostHog (mobile) | Capture `$exception` events yourself. On web, send them with `captureException`. | Errors. |
| PostHog (mobile) | Make sure the project records message text. On iOS, also set `captureLogs` in the app. On Android, logcat is on by default. | Console logs. Flutter apps get none. |
| PostHog (mobile) | On Android, add `PostHogOkHttpInterceptor` (see [Mobile apps](/docs/mobile)). On iOS, URLSession timing is on by default. | Network timing. Flutter apps get none. |
| Amplitude | Leave batching (`useBatch`) off. | Custom events. |
| A server-side SDK (posthog-node, mixpanel-python, Segment and similar) | Sequential rejects these as bots, by design. Use the [backend SDK for Node](/docs/backend-sdk) (`@usesequential/node`) with a server key instead. It has its own route. | Your server’s events and errors. |

## Sequential SDK

Install: [Sequential SDK](/docs/sequential).

What Sequential does with Sequential SDK traffic:

| Capability | Support | Notes |
|---|---|---|
| Custom events | Yes | `sequential.capture(name, props)`; properties are kept. Names starting with `$` are reserved for Sequential’s own events: `capture()` throws on them. |
| Page / screen views | Yes | `$pageview` on load, and on SPA navigation (`pushState`, `replaceState`, `popstate`) only when the page changes. An in-page `#anchor` is not a new page; a `#/` or `#!/` hash route is. From 22 October 2026, a `replaceState` that changes only the query is not a new page. |
| Autocaptured clicks & forms | Yes | Clicks on interactive elements and form submits; never input values. Rage clicks and dead clicks too. Click text is redacted, not only truncated, and anything inside `data-sq-mask` contributes no text or `data-*` values. Autocapture waits for the project’s config and stays off if it cannot load it. |
| Identify (user id) | Yes | `sequential.identify(id)`. The previous anonymous id is sent as `$anon_distinct_id`, and Sequential counts the events from before `identify` under the identified user. |
| User properties | Partial | `register()` properties go on every later event, but Sequential does not store them as user properties. |
| Groups / accounts | Yes | `sequential.account(id, traits)`: the account id on every later event, and its traits in an `$account` event. |
| Errors | Partial | `sequential.captureException(err)` is stored as an error. Uncaught errors and unhandled rejections are not captured, so call `captureException` where you handle them. |
| Session replay | Yes | The same tag records sessions. The SDK starts Sequential’s recorder itself, with the replay key from the project’s config, so there is no second tag and no second key. Masking comes from the project’s recording settings. |
| DevTools: errors, console, network, performance | Yes | Captured by the recorder the SDK starts, on the same terms as every other source, subject to the project’s DevTools settings. |
| Feature flags, surveys, experiments | No | None, deliberately: flags, surveys and experiments need server-side products Sequential does not have, which is also why the SDK is a fraction of a vendor SDK’s size. |
| Server-side SDKs | Partial | With the backend SDK for Node (`@usesequential/node`) and a server key: your server’s events and errors, on the same person as browser events and in the browser session. Node only, and a server event cannot identify a person. On the browser route, server-side user agents are rejected as bots (403). |

## PostHog (web)

Install: [PostHog (web)](/docs/posthog).

What Sequential does with PostHog (web) traffic:

| Capability | Support | Notes |
|---|---|---|
| Custom events | Yes | `posthog.capture(name, props)`; properties are kept. |
| Page / screen views | Yes | `$pageview`, including SPA navigation. |
| Autocaptured clicks & forms | Yes | Clicks, form submits, rage clicks and dead clicks. |
| Identify (user id) | Yes | `posthog.identify(id)`; the user id comes from `distinct_id`. |
| User properties | Partial | `$set` / `$set_once` are kept on the event but not stored as user properties. |
| Groups / accounts | No | Sequential accepts `posthog.group()`, but `$groups` stays an event property: no accounts. |
| Errors | Partial | Sequential keeps the `$exception` events that you send with `captureException`. Sequential’s remote config turns exception autocapture off. |
| Session replay | Partial | Sequential's remote config turns PostHog's own web recording off. Add Sequential's recorder: it joins PostHog's session id automatically. |
| DevTools: errors, console, network, performance | Yes | Captured by Sequential's recorder, after you add the recorder to the page. `captureException` events and `$web_vitals` also show in the replay's DevTools drawer. |
| Feature flags, surveys, experiments | No | Sequential’s remote config turns flags, surveys and heatmaps off; `/flags` and `/decide` have no route. Flags evaluate as off. |
| Server-side SDKs | No | Browser and PostHog mobile SDKs only. Sequential rejects server-side SDK user agents as bots (403). To send events from your own server, use Sequential’s backend SDK for Node. |

## PostHog (mobile)

Install: [PostHog (mobile)](/docs/mobile).

What Sequential does with PostHog (mobile) traffic:

| Capability | Support | Notes |
|---|---|---|
| Custom events | Yes | Same wire protocol as web (`/batch`, gzipped). |
| Page / screen views | Yes | `$screen` events. |
| Autocaptured clicks & forms | Partial | Sequential sorts the `$autocapture` events that the SDK's own autocapture sends into event classes. Mobile autocapture varies by platform. |
| Identify (user id) | Yes | Top-level `distinct_id`. |
| User properties | Partial | As on web: `$set` / `$set_once` are kept on the event but not stored as user properties. |
| Groups / accounts | No | As on web: Sequential accepts group calls, but `$groups` stays an event property: no accounts. |
| Errors | Partial | Manually captured `$exception` events only. |
| Session replay | Yes | Sequential stores PostHog's mobile session replay (iOS, Android) as sent and plays it. iOS replay is tested with a real app on the iOS simulator. Android replay is tested with a real Jetpack Compose app on the Android emulator (posthog-android 3.72.3). Masking is set in the SDK on the device. React Native and Flutter are accepted but unverified. |
| DevTools: errors, console, network, performance | Partial | No JavaScript errors or page performance. Console logs only when the project records message text and the app sets iOS `captureLogs` (Android logcat is on by default). Network timing: iOS URLSession by default, Android needs `PostHogOkHttpInterceptor`. Flutter: none. See [Mobile apps](/docs/mobile). |
| Feature flags, surveys, experiments | No | As on web: Sequential’s remote config turns flags, surveys and heatmaps off; `/flags` and `/decide` have no route. Flags evaluate as off. |
| Server-side SDKs | No | Browser and PostHog mobile SDKs only. Sequential rejects server-side SDK user agents as bots (403). To send events from your own server, use Sequential’s backend SDK for Node. |

## Mixpanel

Install: [Mixpanel](/docs/mixpanel).

What Sequential does with Mixpanel traffic:

| Capability | Support | Notes |
|---|---|---|
| Custom events | Partial | `mixpanel.track(name, props)`. Sequential drops properties whose names start with `$` (except element properties). |
| Page / screen views | Yes | `track_pageview` / `$mp_web_page_view`. |
| Autocaptured clicks & forms | Yes | Mixpanel's autocapture clicks, submits, rage and dead clicks. |
| Identify (user id) | Yes | `mixpanel.identify(id)`. |
| User properties | No | `mixpanel.people.set` from the browser SDK is not stored today: Sequential refuses its form-encoded `/engage` request. Tracked as a known issue. |
| Groups / accounts | No | Group profiles are not supported. Sequential stores a `/groups` update as user properties on a user with no id. |
| Errors | No | No error events; track them as custom events. |
| Session replay | Partial | Mixpanel's own recording is not accepted (`/record` has no route). Add Sequential's recorder: it joins Mixpanel's session id automatically. |
| DevTools: errors, console, network, performance | Yes | Captured by Sequential's recorder, after you add the recorder to the page. |
| Feature flags, surveys, experiments | No | No `/decide` or flags route. |
| Server-side SDKs | No | Browser and PostHog mobile SDKs only. Sequential rejects server-side SDK user agents as bots (403). To send events from your own server, use Sequential’s backend SDK for Node. |

## Amplitude

Install: [Amplitude](/docs/amplitude).

What Sequential does with Amplitude traffic:

| Capability | Support | Notes |
|---|---|---|
| Custom events | Yes | `amplitude.track(name, props)` through `serverUrl`. Leave batching (`useBatch`) off: the batch endpoint does not reach Amplitude handling today. |
| Page / screen views | Partial | `[Amplitude] Page Viewed` is a page view, but the URL is kept only as an event property, not as the event's URL. |
| Autocaptured clicks & forms | Yes | Element clicks and form submits from autocapture. |
| Identify (user id) | Yes | `amplitude.setUserId(id)`. |
| User properties | Partial | Sequential stores `Identify` with `set` / `setOnce`, and ignores `add`, `append` and `unset`. |
| Groups / accounts | No | Sequential does not read `setGroup` and `groupIdentify` data, and drops it: no accounts. |
| Errors | No | No error events; track them as custom events. |
| Session replay | Partial | Amplitude's own replay plugin sends to Amplitude, not here. Add Sequential's recorder: it joins Amplitude's session id automatically. |
| DevTools: errors, console, network, performance | Yes | Captured by Sequential's recorder, after you add the recorder to the page. |
| Feature flags, surveys, experiments | No | Amplitude Experiment is not supported. |
| Server-side SDKs | No | Browser and PostHog mobile SDKs only. Sequential rejects server-side SDK user agents as bots (403). To send events from your own server, use Sequential’s backend SDK for Node. |

## Pendo

Install: [Pendo](/docs/pendo).

What Sequential does with Pendo traffic:

| Capability | Support | Notes |
|---|---|---|
| Custom events | Partial | `pendo.track(name, props)` arrives under your event name, but Sequential stores its properties as user properties, not on the event. |
| Page / screen views | Yes | Pendo's `load` events. |
| Autocaptured clicks & forms | Yes | Clicks, with a CSS selector. |
| Identify (user id) | Yes | The `visitor.id` you pass to `pendo.initialize`. |
| User properties | Yes | Visitor metadata. |
| Groups / accounts | Yes | Fills accounts: `account.id` and account metadata. |
| Errors | No | No error events. |
| Session replay | Partial | Pendo's own replay is not accepted. Add Sequential's recorder: it joins Pendo's session id automatically. |
| DevTools: errors, console, network, performance | Yes | Captured by Sequential's recorder, after you add the recorder to the page. |
| Feature flags, surveys, experiments | No | Sequential answers Pendo’s guide requests with an empty set, so no guides show while Pendo’s agent points at Sequential. |
| Server-side SDKs | No | Browser and PostHog mobile SDKs only. Sequential rejects server-side SDK user agents as bots (403). To send events from your own server, use Sequential’s backend SDK for Node. |

## Smartlook

Install: [Smartlook](/docs/smartlook).

What Sequential does with Smartlook traffic:

| Capability | Support | Notes |
|---|---|---|
| Custom events | Yes | `smartlook('track', name, props)`. |
| Page / screen views | Yes | Page loads and in-page (pushState) navigation, plus `navigation(path)`. |
| Autocaptured clicks & forms | Partial | Clicks with a CSS selector and element text. No form, focus, input or network events. |
| Identify (user id) | Yes | `smartlook('identify', id, props)`. |
| User properties | Yes | `identify` props and `smartlook('properties', …)`. |
| Groups / accounts | No | Smartlook has no groups. |
| Errors | Yes | Uncaught errors, unhandled rejections and `smartlook('error', …)`. |
| Session replay | Yes | Smartlook's recorder is replaced: Sequential's recorder starts automatically and shares the Smartlook session id. Masking comes from the project's recording settings, not from `record()`. |
| DevTools: errors, console, network, performance | Yes | Captured by the recorder the Smartlook script starts. `smartlook('error', …)` shows as an error. Smartlook's `interceptors` and `advancedNetwork` options do not apply to it. |
| Feature flags, surveys, experiments | No | Smartlook has none. |
| Server-side SDKs | No | Web only. Sequential answers Smartlook mobile SDK traffic and drops it. |

## Related pages

- [Install Sequential](/docs/install): choose the install page for your app.
- [Add session replay to a website](/docs/session-replay): add the recorder next to your SDK.
- [DevTools in session replays](/docs/devtools): what the replay shows.
- [Send events from your server](/docs/backend-sdk): the backend SDK and its server key.
