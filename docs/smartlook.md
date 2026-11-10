# Send Smartlook data to Sequential

> Keep your Smartlook snippet or package. Change where the script loads from, and the key. Tracking calls keep working; session replay continues on Sequential.

> **At a glance**
>
> - **For:** This page is for sites that already run Smartlook.
> - **Works with:** Web only. Smartlook’s mobile SDKs are not supported. Smartlook has no groups, feature flags, surveys or experiments. [What is supported](#what-is-supported).
> - **Key:** [Your Sequential Smartlook ingest key](/docs/install#where-the-values-come-from).
> - **Know this:** `track`, `identify`, `properties`, `navigation` and `error` calls keep working unchanged. [How Retention counts identified people](/docs/retention#why-does-each-identified-person-count-twice-after-a-move-from-smartlook).
> - **Know this:** After the change, Smartlook’s recorder never loads on your page again.

## Install

Variants (tabs on the page; each is written out below): Script tag install · npm install (`smartlook-client`)

### Script tag install

Make two edits to the snippet the site already has:

1. `c.src`: load `/recorder.js` from the API URL (`https://api.usesequential.com`) instead of `https://web-sdk.smartlook.com/recorder.js`.
2. `init`: use your Sequential Smartlook ingest key, and make the options object `{}`. Delete `region`: it picks a Smartlook data centre and means nothing here.

> **Change both lines**
>
> If `c.src` still points at `web-sdk.smartlook.com`, Smartlook’s own recorder runs and sends data Sequential discards. That includes your events, not only the replay.

The snippet with both lines changed and marked:

```html
<!-- keep your existing snippet; change the two marked lines -->
<script type='text/javascript'>
  window.smartlook||(function(d) {
    var o=smartlook=function(){ o.api.push(arguments)},h=d.getElementsByTagName('head')[0];
    var c=d.createElement('script');o.api=new Array();c.async=true;c.type='text/javascript';
    c.charset='utf-8';c.src='https://api.usesequential.com/recorder.js';   // ← was web-sdk.smartlook.com
    h.appendChild(c);
    })(document);
    smartlook('init', 'YOUR_SMARTLOOK_INGEST_KEY', {});   // ← your Sequential key; drop { region: … }
</script>
```

### npm install (`smartlook-client`)

Keep the package. Make two edits to the `init` call:

1. Use your Sequential Smartlook ingest key.
2. Set `relayProxyUrl` to the API URL, as an origin only, with no path. That one option points both the script and the data at Sequential. Do not also set `host`: the package derives it.

```js
import smartlook from 'smartlook-client';

smartlook.init('YOUR_SMARTLOOK_INGEST_KEY', { relayProxyUrl: 'https://api.usesequential.com' });
```

### Content-Security-Policy

Only if the site sets a Content-Security-Policy. Add these origins to the directives it already has; do not replace them.

```text
script-src https://api.usesequential.com https://cdn.usesequential.com
connect-src https://api.usesequential.com
```

## Session replay

Sequential’s recorder records only if the project has a live [replay ingest key](/docs/install#where-the-values-come-from) (`sq_replay_…`).

- It starts on its own. It needs no extra snippet, and it shares Smartlook’s session id, so events and recordings line up.
- What it masks, samples and skips is set per project in Sequential (Settings › Recording & data). No option in your page changes it. To stop recording, turn off Record sessions there. Do not add client-side options for it.

## Check it works

1. (Web) Load a page of the site in a normal browser.

2. Open the network panel.

3. Look for requests to the API URL that answer 2xx.

Done when: In Sequential, step 3 of the project setup says "It works" when the first event arrives. Then your source's line on Settings › Setup says "receiving". The first event can take up to about a minute to appear.

### If it does not work

| Symptom | Cause | Fix |
|---|---|---|
| A request answers 401 | The key is wrong, or belongs to another source. Every key works with one SDK only. | Use your [Sequential Smartlook ingest key](/docs/install#where-the-values-come-from). |
| A request answers 403 | The request looked like a bot. Headless and automated browsers are rejected as bots. | Load the page in a normal browser, not a headless or automated one. |

To confirm that recordings arrive: [Check session replay](/docs/verify#check-session-replay).

More checks: [Check that your install works](/docs/verify).

## What is supported

| Support | Capabilities |
|---|---|
| Yes | Custom events; Page / screen views; Identify (user id); User properties; Errors; Session replay; DevTools: errors, console, network, performance |
| Partial | Autocaptured clicks & forms |
| No | Groups / accounts; Feature flags, surveys, experiments; Server-side SDKs |

### Full support table

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

### Smartlook API calls, options and `record()`

Sequential serves its own Smartlook-compatible script. Smartlook’s `interceptors` still work (returning `false` drops an event). `pause`, `resume`, `restart`, `anonymize`, `disable`, `getData` and `initialized` behave as before. `sessionId`, `visitorId`, `recordId`, `key` and `version` are readable on `window.smartlook`.

`record({ forms, ips, numbers, emails, api })` does not change masking. Sequential stores the call as a `record` event of the System class. Event lists hide System events. See [Events](/docs/events#hidden-system-events).

## Next steps

- [Check your install](/docs/verify): more checks that your data arrives.
- [Session replay recording settings](/docs/recording-settings): set what the recorder masks, samples and skips.
- [What each SDK supports](/docs/support-matrix#smartlook): Smartlook next to the other SDKs.
