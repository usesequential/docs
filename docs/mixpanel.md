# Send Mixpanel data to Sequential

> Keep the Mixpanel JavaScript SDK and point it at Sequential: your Sequential Mixpanel ingest key as the project token, plus `api_host`.

Sequential speaks Mixpanel’s ingestion protocol, so `track`, `identify`, `track_pageview` and autocapture keep working. Pick **one** of the three paths below.

## Already using Mixpanel

Do not add a second copy. In the mixpanel.init(…) call you already have, replace the project token and add api_host so events go to Sequential instead of Mixpanel.

```js
mixpanel.init('YOUR_MIXPANEL_INGEST_KEY', { api_host: 'https://api.usesequential.com' });
```

Keep every other option you pass. If the init reads the token from an environment variable, change the variable instead of the code.

## New install: npm (bundled apps)

Install the package, then initialise it once, in browser-only code.

```sh
npm install mixpanel-browser
```

```js
import mixpanel from 'mixpanel-browser';

mixpanel.init('YOUR_MIXPANEL_INGEST_KEY', { api_host: 'https://api.usesequential.com' });
```

## New install: script tag (plain HTML, tag managers)

Mixpanel's own loader plus the one line that points it at Sequential. Paste it once into your site's `<head>`, or into a Google Tag Manager Custom HTML tag that fires on All Pages. Nothing else to change. The loader is Mixpanel’s own. The Mixpanel SDK refuses `init` without it, so keep it as is. It sets `track_pageview: true`, so a page view arrives as soon as it is pasted. Without it, Mixpanel sends nothing until your code calls `mixpanel.track(…)`.

```html
<!-- Sequential · analytics (Mixpanel SDK) -->
<script>
  (function(f,b){if(!b.__SV){var e,g,i,h;window.mixpanel=b;b._i=[];b.init=function(e,f,c){function g(a,d){var b=d.split(".");2==b.length&&(a=a[b[0]],d=b[1]);a[d]=function(){a.push([d].concat(Array.prototype.slice.call(arguments,0)))}}var a=b;"undefined"!==typeof c?a=b[c]=[]:c="mixpanel";a.people=a.people||[];a.toString=function(a){var d="mixpanel";"mixpanel"!==c&&(d+="."+c);a||(d+=" (stub)");return d};a.people.toString=function(){return a.toString(1)+".people (stub)"};i="disable time_event track track_pageview track_links track_forms track_with_groups add_group set_group remove_group register register_once alias unregister identify name_tag set_config reset opt_in_tracking opt_out_tracking has_opted_in_tracking has_opted_out_tracking clear_opt_in_out_tracking start_batch_senders people.set people.set_once people.unset people.increment people.append people.union people.track_charge people.clear_charges people.delete_user people.remove".split(" ");for(h=0;h<i.length;h++)g(a,i[h]);var j="set set_once union unset remove delete".split(" ");a.get_group=function(){function b(c){d[c]=function(){call2_args=arguments;call2=[c].concat(Array.prototype.slice.call(call2_args,0));a.push([e,call2])}}for(var d={},e=["get_group"].concat(Array.prototype.slice.call(arguments,0)),c=0;c<j.length;c++)b(j[c]);return d};b._i.push([e,f,c])};b.__SV=1.2;e=f.createElement("script");e.type="text/javascript";e.async=!0;e.src="https://cdn.mxpnl.com/libs/mixpanel-2-latest.min.js";g=f.getElementsByTagName("script")[0];g.parentNode.insertBefore(e,g)}})(document,window.mixpanel||[]);
  // track_pageview: a page view on every load, so data arrives as soon as this is pasted.
  mixpanel.init('YOUR_MIXPANEL_INGEST_KEY', { api_host: 'https://api.usesequential.com', track_pageview: true });
</script>
```

## What is supported

What Sequential does with Mixpanel traffic:

| Capability | Support | Notes |
|---|---|---|
| Custom events | Partial | `mixpanel.track(name, props)`; properties whose names start with `$` are dropped (except element properties). |
| Page / screen views | Yes | `track_pageview` / `$mp_web_page_view`. |
| Autocaptured clicks & forms | Yes | Mixpanel's autocapture clicks, submits, rage and dead clicks. |
| Identify (user id) | Yes | `mixpanel.identify(id)`. |
| User properties | No | `mixpanel.people.set` from the browser SDK does not land today: its form-encoded `/engage` request is refused. Tracked as a known issue. |
| Groups / accounts | No | Group profiles are not supported. A `/groups` update is stored as user properties on a user with no id. |
| Errors | No | No error events; track them as custom events. |
| Session replay | Partial | Mixpanel's own recording is not accepted (`/record` has no route). Add Sequential's recorder: it joins Mixpanel's session id automatically. |
| DevTools: errors, console, network, performance | Yes | Captured by Sequential's recorder once the session-replay line is on the page. |
| Feature flags, surveys, experiments | No | No `/decide` or flags route. |
| Server-side SDKs | No | Browser and PostHog mobile SDKs only. Server-side SDK user agents are rejected as bots (403). To send events from your own server, use Sequential’s backend SDK for Node. |

> **Known issue:** user profile updates from the browser SDK (`mixpanel.people.set` and the other `people.*` calls) are not stored today. Keep the calls, since they do no harm, but do not rely on user properties from Mixpanel in Sequential yet. Event properties whose names start with `$` are also dropped, apart from autocapture’s element properties, so give your own properties plain names.

## Add session replay (optional)

Optional, one line. The recorder picks up Mixpanel's session and user ids on its own, so every event above lands on the replay timeline. Put it on every page you want to replay, after the SDK. What it records and masks is set per project in Sequential (Settings › Recording & data), not in the page. See [Session replay](/docs/session-replay).

```html
<script src="https://api.usesequential.com/rec/recorder.js/YOUR_REPLAY_INGEST_KEY"></script>
```

## Content-Security-Policy

Only if the site sets a Content-Security-Policy. Add these origins to the directives it already has; do not replace them.

```text
script-src https://api.usesequential.com https://cdn.mxpnl.com https://cdn.usesequential.com
connect-src https://api.usesequential.com
```

## Check it works

1. Load a page of the site in a normal browser (headless and automated browsers are rejected as bots) and open the network panel.
2. Look for requests to the Sequential API URL that answer 2xx. A **401** means the key is wrong, or belongs to another source (every key works with one SDK only). A **403** means the request looked like a bot.
3. In Sequential, step 3 of the project setup says **It works** when the first event arrives. Then your source's line on Settings › Setup says "receiving". The first event can take up to about a minute to appear.

More in [Check your install](/docs/verify).
