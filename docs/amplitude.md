# Send Amplitude data to Sequential

> Keep the Amplitude Browser SDK (`@amplitude/analytics-browser`) and point it at Sequential: your Amplitude ingest key as the API key, plus `serverUrl`.

> **At a glance**
>
> - **Works with:** The Amplitude Browser SDK. Sequential accepts Amplitude’s HTTP V2 protocol, so `track`, `setUserId`, `identify` and autocapture keep working.
> - **Key:** See [Where the values come from](/docs/install#where-the-values-come-from). Your Amplitude ingest key replaces your Amplitude API key.
> - **Know this:** Replay and DevTools (errors, console, network, performance) come from Sequential’s recorder, not from Amplitude: one more line. [Add session replay](#add-session-replay-optional)
> - **Know this:** Not supported: groups and accounts, Amplitude error events (track them as custom events), feature flags, surveys, experiments, server-side SDKs.

> **Before you switch**
>
> - Do not enable batching: remove `useBatch: true` if it is set. Sequential does not handle Amplitude’s batch endpoint today, so batched events are lost.
> - The legacy `amplitude-js` SDK (`amplitude.getInstance().init(…)`) has not been verified against Sequential. Migrate it to `@amplitude/analytics-browser` first.

## Install

Pick one of the three paths.

| Your site | Tab |
|---|---|
| Already calls `amplitude.init(…)` | Already using |
| A bundled app (npm) | npm |
| Plain HTML, or a tag manager such as Google Tag Manager | Script tag |

Variants (tabs on the page; each is written out below): Already using Amplitude · New install: npm (bundled apps) · New install: Script tag (plain HTML, tag managers)

### Already using Amplitude

Do not add a second copy. In the amplitude.init(…) call you already have, replace the API key and add serverUrl so events go to Sequential instead of Amplitude.

Keep every other option you pass, with two exceptions:

- Remove `useBatch: true` if it is set (see Before you switch).
- Remove a `serverZone` option: `serverUrl` replaces it.

Changed: the API key and `serverUrl`.

```js
amplitude.init('YOUR_AMPLITUDE_INGEST_KEY', { serverUrl: 'https://api.usesequential.com/2/httpapi' });
```

### New install: npm (bundled apps)

Install the package, then initialise it once, in browser-only code.

```sh
npm install @amplitude/analytics-browser
```

```js
import * as amplitude from '@amplitude/analytics-browser';

amplitude.init('YOUR_AMPLITUDE_INGEST_KEY', { serverUrl: 'https://api.usesequential.com/2/httpapi' });
```

### New install: Script tag (plain HTML, tag managers)

Everything in one block: it loads the Amplitude SDK and points it at Sequential. Paste it once into your site's `<head>`, or into a Google Tag Manager Custom HTML tag that fires on All Pages. Nothing else to change.

```html
<!-- Sequential · analytics (Amplitude SDK) -->
<script>
  (function (d, api, key) {
    var s = d.createElement('script');
    s.src = 'https://cdn.amplitude.com/libs/analytics-browser-2.11.0-min.js.gz'; s.async = true;
    s.onload = function () { amplitude.init(key, { serverUrl: api + '/2/httpapi' }); };
    d.head.appendChild(s);
  })(document, 'https://api.usesequential.com', 'YOUR_AMPLITUDE_INGEST_KEY');
</script>
```

### Content-Security-Policy

Only if the site sets a Content-Security-Policy. Add these origins to the directives it already has; do not replace them.

```text
script-src https://api.usesequential.com https://cdn.amplitude.com https://cdn.usesequential.com
connect-src https://api.usesequential.com
```

## Add session replay (optional)

One line adds the recorder (`/rec/recorder.js`). It takes your replay ingest key (`sq_replay_…`), not the Amplitude ingest key. The recorder picks up Amplitude's session and user ids on its own, so every supported event ([What is supported](#what-is-supported)) lands on the replay timeline. Put it on every page you want to replay, after the SDK.

```html
<script src="https://api.usesequential.com/rec/recorder.js/YOUR_REPLAY_INGEST_KEY"></script>
```

What it records and masks is set per project in Sequential (Settings › Recording & data), not in the page. See [Add session replay to a website](/docs/session-replay).

## Check it works

1. (Web) Load a page of the site in a normal browser.

2. Open the network panel.

3. Look for requests to the API URL (`serverUrl`) that answer 2xx.

Done when: In Sequential, step 3 of the project setup says "It works" when the first event arrives. Then your source's line on Settings › Setup says "receiving". The first event can take up to about a minute to appear.

### If it does not work

| Symptom | Cause | Fix |
|---|---|---|
| A request answers 401 | The key is wrong, or belongs to another source. Every key works with one SDK only. | [Where the values come from](/docs/install#where-the-values-come-from) |
| A request answers 403 | The request looked like a bot. Headless and automated browsers are rejected as bots. | Load the page in a normal browser, not a headless or automated one. |

More checks: [Check that your install works](/docs/verify).

## What is supported

| Support | Capabilities |
|---|---|
| Yes | Custom events; Autocaptured clicks & forms; Identify (user id); DevTools: errors, console, network, performance |
| Partial | Page / screen views (the URL is kept only as an event property); User properties (`add`, `append` and `unset` are ignored); Session replay (Sequential’s recorder, not Amplitude’s own replay plugin) |
| No | Groups / accounts; Errors; Feature flags, surveys, experiments; Server-side SDKs |

All SDKs side by side: [What each SDK supports](/docs/support-matrix).

### Full support table

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

## Next steps

- [Identify your users](/docs/identify-users): tell Sequential who a person is.
- [Send custom events](/docs/custom-events): name the moments that matter.
- [Send events from your server](/docs/backend-sdk): the backend SDK for Node.
