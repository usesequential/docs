# Send Amplitude data to Sequential

> Keep the Amplitude Browser SDK (`@amplitude/analytics-browser`) and point it at Sequential: your Amplitude ingest key as the API key, plus `serverUrl`.

Sequential accepts Amplitude’s HTTP V2 protocol, so `track`, `setUserId`, `identify` and autocapture keep working. Pick **one** of the three paths below.

## Already using Amplitude

Do not add a second copy. In the amplitude.init(…) call you already have, replace the API key and add serverUrl so events go to Sequential instead of Amplitude.

```js
amplitude.init('YOUR_AMPLITUDE_INGEST_KEY', { serverUrl: 'https://api.usesequential.com/2/httpapi' });
```

Keep every other option you pass, with two exceptions:

- **Do not enable batching.** Remove `useBatch: true` if it is set. Sequential does not handle Amplitude’s batch endpoint today, so batched events are lost.
- Remove a `serverZone` option: `serverUrl` replaces it.

The legacy `amplitude-js` SDK (`amplitude.getInstance().init(…)`) has not been verified against Sequential. Migrate it to `@amplitude/analytics-browser` first.

## New install: npm (bundled apps)

Install the package, then initialise it once, in browser-only code.

```sh
npm install @amplitude/analytics-browser
```

```js
import * as amplitude from '@amplitude/analytics-browser';

amplitude.init('YOUR_AMPLITUDE_INGEST_KEY', { serverUrl: 'https://api.usesequential.com/2/httpapi' });
```

## New install: script tag (plain HTML, tag managers)

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

## What is supported

What Sequential does with Amplitude traffic:

| Capability | Support | Notes |
|---|---|---|
| Custom events | Yes | `amplitude.track(name, props)` via `serverUrl`. Leave batching (`useBatch`) off: the batch endpoint does not reach Amplitude handling today. |
| Page / screen views | Partial | `[Amplitude] Page Viewed` is a page view, but the URL is kept only as an event property, not as the event's URL. |
| Autocaptured clicks & forms | Yes | Element clicks and form submits from autocapture. |
| Identify (user id) | Yes | `amplitude.setUserId(id)`. |
| User properties | Partial | `Identify` with `set` / `setOnce` is stored; `add`, `append`, `unset` are ignored. |
| Groups / accounts | No | `setGroup` and `groupIdentify` data is not read and is dropped; no accounts. |
| Errors | No | No error events; track them as custom events. |
| Session replay | Partial | Amplitude's own replay plugin sends to Amplitude, not here. Add Sequential's recorder: it joins Amplitude's session id automatically. |
| DevTools: errors, console, network, performance | Yes | Captured by Sequential's recorder once the session-replay line is on the page. |
| Feature flags, surveys, experiments | No | Amplitude Experiment is not supported. |
| Server-side SDKs | No | Browser and PostHog mobile SDKs only. Server-side SDK user agents are rejected as bots (403). To send events from your own server, use Sequential’s backend SDK for Node. |

## Add session replay (optional)

Optional, one line. The recorder picks up Amplitude's session and user ids on its own, so every event above lands on the replay timeline. Put it on every page you want to replay, after the SDK. What it records and masks is set per project in Sequential (Settings › Recording & data), not in the page. See [Session replay](/docs/session-replay).

```html
<script src="https://api.usesequential.com/rec/recorder.js/YOUR_REPLAY_INGEST_KEY"></script>
```

## Content-Security-Policy

Only if the site sets a Content-Security-Policy. Add these origins to the directives it already has; do not replace them.

```text
script-src https://api.usesequential.com https://cdn.amplitude.com https://cdn.usesequential.com
connect-src https://api.usesequential.com
```

## Check it works

1. Load a page of the site in a normal browser (headless and automated browsers are rejected as bots) and open the network panel.
2. Look for requests to the Sequential API URL that answer 2xx. A **401** means the key is wrong, or belongs to another source (every key works with one SDK only). A **403** means the request looked like a bot.
3. In Sequential, step 3 of the project setup says **It works** when the first event arrives. Then your source's line on Settings › Setup says "receiving". The first event can take up to about a minute to appear.

More in [Check your install](/docs/verify).
