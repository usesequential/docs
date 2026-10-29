# Moving from Smartlook

> Move from Smartlook: change where the script loads from, and the key. Your tracking calls keep working, and session replay continues on Sequential.

This page is for sites that already run Smartlook. Sequential serves its own Smartlook-compatible script. Smartlook’s recorder never loads on your page again. `track`, `identify`, `properties`, `navigation` and `error` calls keep working unchanged.

## Script-tag install

Two edits to the snippet the site already has:

1. `c.src` loads `/recorder.js` from the Sequential API URL instead of `https://web-sdk.smartlook.com/recorder.js`.
2. The `init` call uses your Sequential Smartlook ingest key, and the options object is `{}`. Delete `region`: it picks a Smartlook data centre and means nothing here.

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

**Change both lines.** If `c.src` still points at `web-sdk.smartlook.com`, Smartlook’s own recorder runs and sends data Sequential discards. That includes your events, not only the replay.

## npm install (`smartlook-client`)

Keep the package and set `relayProxyUrl` to the Sequential API URL, as an origin only, with no path. That one option points both the script and the data at Sequential. Do **not** also set `host`: the package derives it.

```js
import smartlook from 'smartlook-client';

smartlook.init('YOUR_SMARTLOOK_INGEST_KEY', { relayProxyUrl: 'https://api.usesequential.com' });
```

## What is supported

Smartlook’s `interceptors` still work (returning `false` drops an event). `pause`, `resume`, `restart`, `anonymize`, `disable`, `getData` and `initialized` behave as before. `sessionId`, `visitorId`, `recordId`, `key` and `version` are readable on `window.smartlook`. `record({ forms, ips, numbers, emails, api })` does **not** change masking. Sequential stores the call as a `record` event of the System class. Event lists hide System events. See [Events](/docs/events#hidden-system-events).

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
| Server-side SDKs | No | Web only. Smartlook mobile SDK traffic is answered and dropped. |

## Session replay

Sequential’s recorder starts on its own. It needs no extra snippet, and it shares Smartlook’s session id, so events and recordings line up. It records only if the project has a live replay key. What it masks, samples and skips is set per project in Sequential (Settings › Recording & data). No option in the page changes it. To stop recording, turn off **Record sessions** there. Do not add client-side options for it.

Smartlook’s mobile SDKs are not supported. Their traffic is answered and dropped.

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
