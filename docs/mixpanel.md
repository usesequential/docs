# Send Mixpanel data to Sequential

> Keep the Mixpanel JavaScript SDK and point it at Sequential: your Sequential Mixpanel ingest key as the project token, plus `api_host`.

> **At a glance**
>
> - **Works with:** Sequential speaks Mixpanel’s ingestion protocol, so `track`, `identify`, `track_pageview` and autocapture keep working.
> - **Key:** Your Sequential Mixpanel ingest key as the project token, plus `api_host` ([Where the values come from](/docs/install#where-the-values-come-from)). Events then go to Sequential, not Mixpanel.
> - **You get:** Optional: session replay, with Sequential’s recorder (`/rec/recorder.js`). It picks up Mixpanel’s session and user ids on its own.
> - **Know this:** Check in a normal browser: requests to the API URL answer 2xx, and the project setup says "It works".

> **Before you switch**
>
> - User profile updates from the browser SDK (`mixpanel.people.set` and the other `people.*` calls) are not stored today. Keep the calls; they do no harm. Do not rely on user properties from Mixpanel in Sequential yet.
> - Event properties whose names start with `$` are dropped, apart from autocapture’s element properties, so give your own properties plain names.
> - Not supported: group profiles, error events (track them as custom events), Mixpanel’s own recording, feature flags, surveys, experiments and server-side SDKs (use [Sequential’s backend SDK for Node](/docs/backend-sdk)).

## Install

Pick only one of the three paths.

Variants (tabs on the page; each is written out below): Already using Mixpanel · New install: npm (bundled apps) · New install: Script tag (plain HTML, tag managers)

### Already using Mixpanel

Do not add a second copy. In the mixpanel.init(…) call you already have, replace the project token and add api_host so events go to Sequential instead of Mixpanel.

```js
mixpanel.init('YOUR_MIXPANEL_INGEST_KEY', { api_host: 'https://api.usesequential.com' });
```

Keep every other option you pass. If the init reads the token from an environment variable, change the variable instead of the code.

### New install: npm (bundled apps)

Install the package, then initialise it once, in browser-only code.

```sh
npm install mixpanel-browser
```

```js
import mixpanel from 'mixpanel-browser';

mixpanel.init('YOUR_MIXPANEL_INGEST_KEY', { api_host: 'https://api.usesequential.com' });
```

### New install: Script tag (plain HTML, tag managers)

Mixpanel's own loader plus the one line that points it at Sequential. Paste it once into your site's `<head>`, or into a Google Tag Manager Custom HTML tag that fires on All Pages. Nothing else to change.

```html
<!-- Sequential · analytics (Mixpanel SDK) -->
<script>
  (function(f,b){if(!b.__SV){var e,g,i,h;window.mixpanel=b;b._i=[];b.init=function(e,f,c){function g(a,d){var b=d.split(".");2==b.length&&(a=a[b[0]],d=b[1]);a[d]=function(){a.push([d].concat(Array.prototype.slice.call(arguments,0)))}}var a=b;"undefined"!==typeof c?a=b[c]=[]:c="mixpanel";a.people=a.people||[];a.toString=function(a){var d="mixpanel";"mixpanel"!==c&&(d+="."+c);a||(d+=" (stub)");return d};a.people.toString=function(){return a.toString(1)+".people (stub)"};i="disable time_event track track_pageview track_links track_forms track_with_groups add_group set_group remove_group register register_once alias unregister identify name_tag set_config reset opt_in_tracking opt_out_tracking has_opted_in_tracking has_opted_out_tracking clear_opt_in_out_tracking start_batch_senders people.set people.set_once people.unset people.increment people.append people.union people.track_charge people.clear_charges people.delete_user people.remove".split(" ");for(h=0;h<i.length;h++)g(a,i[h]);var j="set set_once union unset remove delete".split(" ");a.get_group=function(){function b(c){d[c]=function(){call2_args=arguments;call2=[c].concat(Array.prototype.slice.call(call2_args,0));a.push([e,call2])}}for(var d={},e=["get_group"].concat(Array.prototype.slice.call(arguments,0)),c=0;c<j.length;c++)b(j[c]);return d};b._i.push([e,f,c])};b.__SV=1.2;e=f.createElement("script");e.type="text/javascript";e.async=!0;e.src="https://cdn.mxpnl.com/libs/mixpanel-2-latest.min.js";g=f.getElementsByTagName("script")[0];g.parentNode.insertBefore(e,g)}})(document,window.mixpanel||[]);
  // track_pageview: a page view on every load, so data arrives as soon as this is pasted.
  mixpanel.init('YOUR_MIXPANEL_INGEST_KEY', { api_host: 'https://api.usesequential.com', track_pageview: true });
</script>
```

Keep Mixpanel’s loader as is: the Mixpanel SDK refuses `init` without it. The snippet sets `track_pageview: true`, so a page view arrives as soon as it is pasted. Without it, Mixpanel sends nothing until your code calls `mixpanel.track(…)`.

### Content-Security-Policy

Only if the site sets a Content-Security-Policy. Add these origins to the directives it already has; do not replace them.

```text
script-src https://api.usesequential.com https://cdn.mxpnl.com https://cdn.usesequential.com
connect-src https://api.usesequential.com
```

## Add session replay (optional)

One line adds the recorder (`/rec/recorder.js`). It takes your replay ingest key (`sq_replay_…`), not the Mixpanel ingest key. The recorder picks up Mixpanel's session and user ids on its own, so every supported event ([What is supported](#what-is-supported)) lands on the replay timeline. Put it on every page you want to replay, after the SDK.

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
| A request answers 401 | The key is wrong, or belongs to another source. Every key works with one SDK only. | [Where the values come from](/docs/install#where-the-values-come-from) |
| A request answers 403 | The request looked like a bot. Headless and automated browsers are rejected as bots. | Load the page in a normal browser, not a headless or automated one. |

More checks: [Check that your install works](/docs/verify).

## What is supported

| Support | Capabilities |
|---|---|
| Yes | Page / screen views; Autocaptured clicks & forms; Identify (user id); DevTools: errors, console, network, performance (with Sequential’s recorder) |
| Partial | Custom events; Session replay (Sequential’s recorder, not Mixpanel’s own recording) |
| No | User properties; Groups / accounts; Errors; Feature flags, surveys, experiments; Server-side SDKs |

### Full support table

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

## Next steps

- [Check your install](/docs/verify): more on checking that events arrive.
- [What each SDK supports](/docs/support-matrix#mixpanel): Mixpanel next to the other SDKs.
