# Send PostHog (web) data to Sequential

> Keep posthog-js and point it at Sequential: your Sequential PostHog ingest key as the project token, and Sequential's API URL as `api_host`.

Sequential speaks the PostHog wire protocol, so nothing in your tracking code changes. `capture`, `identify` and autocapture keep working. Pick **one** of the three paths below.

## Already using PostHog

Do not add a second copy. Find the posthog.init(…) call you already have — in your code, or in your PostHog tag's settings — and change two values: the project token and api_host. A tag-manager template has fields for both.

```js
posthog.init('YOUR_POSTHOG_INGEST_KEY', { api_host: 'https://api.usesequential.com' });
```

Keep every other option you pass (`person_profiles`, `capture_pageview`, consent settings…). Remove a `ui_host` if you set one, because it points at PostHog’s app. If the init reads the token and host from environment variables, change the variables instead of the code.

## New install: npm (bundled apps)

For React, Vue, Svelte, Next.js and other bundled apps. Install the package, then initialise it once, in browser-only code, as early as possible.

```sh
npm install posthog-js
```

```js
import posthog from 'posthog-js';

posthog.init('YOUR_POSTHOG_INGEST_KEY', { api_host: 'https://api.usesequential.com' });
```

The bundle is built by your own toolchain, so it is part of your supply chain. posthog-js still fetches a few optional modules at runtime from the API URL, which is why the Content-Security-Policy section below applies to this path too.

## New install: script tag (plain HTML, tag managers)

Everything in one block: it loads the SDK from Sequential's CDN — no third-party origin in your page — and points it at Sequential. Paste it once into your site's `<head>`, or into a Google Tag Manager Custom HTML tag that fires on All Pages. Nothing else to change.

```html
<!-- Sequential · analytics (PostHog SDK, served by Sequential) -->
<script>
  (function (d, api, key) {
    var s = d.createElement('script');
    s.src = 'https://cdn.usesequential.com/sdk/posthog-js/1.434.7/array.js';
    s.integrity = 'sha384-wgJLtT/T2y1y9sWIfzkTFpbeBdVyOiLVxN+ydM91CMYgsgb8UFbabiK3Tyba8dQj'; s.crossOrigin = 'anonymous'; s.async = true;
    s.onload = function () { posthog.init(key, { api_host: api }); };
    d.head.appendChild(s);
  })(document, 'https://api.usesequential.com', 'YOUR_POSTHOG_INGEST_KEY');
</script>
```

## What is supported

What Sequential does with PostHog (web) traffic:

| Capability | Support | Notes |
|---|---|---|
| Custom events | Yes | `posthog.capture(name, props)`; properties are kept. |
| Page / screen views | Yes | `$pageview`, including SPA navigation. |
| Autocaptured clicks & forms | Yes | Clicks, form submits, rage clicks and dead clicks. |
| Identify (user id) | Yes | `posthog.identify(id)`; the user id comes from `distinct_id`. |
| User properties | Partial | `$set` / `$set_once` are kept on the event but not stored as user properties. |
| Groups / accounts | No | `posthog.group()` is accepted; `$groups` stays an event property, no accounts. |
| Errors | Partial | `$exception` events sent with `captureException` are kept; exception autocapture is switched off by remote config. |
| Session replay | Partial | PostHog's own web recording is off (remote config). Add Sequential's recorder: it joins PostHog's session id automatically. |
| DevTools: errors, console, network, performance | Yes | Captured by Sequential's recorder once the session-replay line is on the page. `captureException` events and `$web_vitals` also show in the replay's DevTools drawer. |
| Feature flags, surveys, experiments | No | Remote config turns flags, surveys and heatmaps off; `/flags` and `/decide` have no route. Flags evaluate as off. |
| Server-side SDKs | No | Browser and PostHog mobile SDKs only. Server-side SDK user agents are rejected as bots (403). To send events from your own server, use Sequential’s backend SDK for Node. |

Feature flags evaluate as **off**: Sequential tells posthog-js that flags, surveys, heatmaps and PostHog’s own web recording are switched off, so code behind `isFeatureEnabled` / `getFeatureFlag` takes its default path. If the app relies on PostHog flags or surveys, stop and tell the user before switching: they stop working once posthog-js points at Sequential.

## Add session replay (optional)

Optional, one line. The recorder picks up PostHog's session and user ids on its own, so every event above lands on the replay timeline. Put it on every page you want to replay, after the SDK. What it records and masks is set per project in Sequential (Settings › Recording & data), not in the page. See [Session replay](/docs/session-replay).

```html
<script src="https://api.usesequential.com/rec/recorder.js/YOUR_REPLAY_INGEST_KEY"></script>
```

## Content-Security-Policy

Only if the site sets a Content-Security-Policy. Add these origins to the directives it already has; do not replace them.

```text
script-src https://api.usesequential.com https://cdn.usesequential.com
connect-src https://api.usesequential.com
```

## Check it works

1. Load a page of the site in a normal browser (headless and automated browsers are rejected as bots) and open the network panel.
2. Look for requests to the Sequential API URL that answer 2xx. A **401** means the key is wrong, or belongs to another source (every key works with one SDK only). A **403** means the request looked like a bot.
3. In Sequential, step 3 of the project setup says **It works** when the first event arrives. Then your source's line on Settings › Setup says "receiving". The first event can take up to about a minute to appear.

More in [Check your install](/docs/verify).
