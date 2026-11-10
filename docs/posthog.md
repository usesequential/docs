# Send PostHog (web) data to Sequential

> Keep posthog-js and point it at Sequential: your Sequential PostHog ingest key as the project token, and Sequential's API URL as `api_host`.

> **At a glance**
>
> - **Works with:** posthog-js in a web app. Server-side PostHog SDKs are rejected as bots (403); use the [backend SDK for Node](/docs/backend-sdk).
> - **Key:** Your Sequential PostHog ingest key; for replay, also your replay ingest key (`sq_replay_…`). [Where the values come from](/docs/install#where-the-values-come-from)
> - **Know this:** Sequential speaks the PostHog wire protocol, so nothing in your tracking code changes. `capture`, `identify` and autocapture keep working.

> **Before you switch**
>
> - PostHog feature flags and surveys stop working; experiments are not supported. Flags evaluate as off, so code behind `isFeatureEnabled` / `getFeatureFlag` takes its default path.
> - PostHog heatmaps and PostHog’s own web recording are off. For replay, add Sequential's recorder.
> - Groups / accounts are not supported, and `$set` / `$set_once` are not stored as user properties. Full list: [What is supported](#what-is-supported).

## Install

Pick one of the three paths:

- Your app already has posthog-js, in your code or in a tag: [Already using](#already-using-posthog).
- New to PostHog, in a bundled app (React, Vue, Svelte, Next.js): [npm](#new-install-npm-bundled-apps).
- New to PostHog, in plain HTML or a tag manager: [Script tag](#new-install-script-tag-plain-html-tag-managers).

Variants (tabs on the page; each is written out below): Already using PostHog · New install: npm (bundled apps) · New install: Script tag (plain HTML, tag managers)

### Already using PostHog

1. Find the `posthog.init(…)` call you already have: in your code, or in your PostHog tag's settings.

2. If the init reads the token and host from environment variables, change the variables instead of the code.

3. Set PostHog's project token to your Sequential PostHog ingest key.

4. Set `api_host` to the API URL, `https://api.usesequential.com`.

5. If you set a `ui_host`, remove it, because it points at PostHog’s app.

```js
posthog.init('YOUR_POSTHOG_INGEST_KEY', { api_host: 'https://api.usesequential.com' });
```

Do not add a second posthog-js or a second `posthog.init`: change the one you have. A tag-manager template has fields for the project token and `api_host`. Keep every other option you pass, for example `person_profiles`, `capture_pageview` and consent settings.

### New install: npm (bundled apps)

For React, Vue, Svelte, Next.js and other bundled apps. Install the package, then initialise it once, in browser-only code, as early as possible.

```sh
npm install posthog-js
```

```js
import posthog from 'posthog-js';

posthog.init('YOUR_POSTHOG_INGEST_KEY', { api_host: 'https://api.usesequential.com' });
```

posthog-js still fetches a few optional modules at runtime from the API URL. So the [Content-Security-Policy](#content-security-policy) section applies to this path too.

### New install: Script tag (plain HTML, tag managers)

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

If the site sets a Content-Security-Policy, add the origins in [Content-Security-Policy](#content-security-policy).

### Content-Security-Policy

Only if the site sets a Content-Security-Policy. Add these origins to the directives it already has; do not replace them.

```text
script-src https://api.usesequential.com https://cdn.usesequential.com
connect-src https://api.usesequential.com
```

On the npm path, the bundle is built by your own toolchain, so it is part of your supply chain.

Done when: in a normal browser, requests to the API URL answer 2xx. See [Check it works](#check-it-works).

## Add session replay (optional)

One line adds the recorder (`/rec/recorder.js`). It takes your replay ingest key (`sq_replay_…`), not the PostHog ingest key. The recorder picks up PostHog's session and user ids on its own, so every supported event ([What is supported](#what-is-supported)) lands on the replay timeline. Put it on every page you want to replay, after the SDK.

```html
<script src="https://api.usesequential.com/rec/recorder.js/YOUR_REPLAY_INGEST_KEY"></script>
```

What it records and masks is set per project in Sequential (Settings › Recording & data), not in the page. See [Add session replay to a website](/docs/session-replay).

## Check it works

1. (Web) Load a page of the site in a normal browser.

2. Open the network panel.

3. Look for requests to the API URL (`api_host`) that answer 2xx.

Done when: In Sequential, step 3 of the project setup says "It works" when the first event arrives. Then your source's line on Settings › Setup says "receiving". The first event can take up to about a minute to appear.

### If it does not work

| Symptom | Cause | Fix |
|---|---|---|
| A request answers 401 | The key is wrong, or belongs to another source. Every key works with one SDK only. | Set the project token to your Sequential PostHog ingest key. For the recorder, use your replay ingest key. |
| A request answers 403 | The request looked like a bot. Headless and automated browsers are rejected as bots. | Load the page in a normal browser, not a headless or automated one. |

More checks: [Check that your install works](/docs/verify).

## What is supported

| Support | Capabilities |
|---|---|
| Yes | Custom events; Page / screen views; Autocaptured clicks & forms; Identify (user id); DevTools: errors, console, network, performance |
| Partial | User properties; Errors; Session replay |
| No | Groups / accounts; Feature flags, surveys, experiments; Server-side SDKs |

- User properties: `$set` / `$set_once` are kept on the event but not stored as user properties.
- Errors: Sequential keeps the `$exception` events that you send with `captureException`. Sequential’s remote config turns exception autocapture off.
- Session replay: Sequential's remote config turns PostHog's own web recording off. Add Sequential's recorder: it joins PostHog's session id automatically.
- DevTools: errors, console, network, performance: Captured by Sequential's recorder, after you add the recorder to the page. `captureException` events and `$web_vitals` also show in the replay's DevTools drawer.

### Full support table

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

### For coding agents

Feature flags evaluate as off: Sequential tells posthog-js that flags, surveys, heatmaps and PostHog’s own web recording are switched off, so code behind `isFeatureEnabled` / `getFeatureFlag` takes its default path. If the app relies on PostHog flags or surveys, stop and tell the user before switching: they stop working once posthog-js points at Sequential.

## Next steps

- [Identify your users](/docs/identify-users): tell Sequential who a person is.
- [What each SDK supports](/docs/support-matrix): PostHog next to the other SDKs.
