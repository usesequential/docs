# Add session replay to a website

> The Sequential SDK records session replays and sends events, with one key. Next to another analytics SDK, the recorder on its own adds replay only.

> **At a glance**
>
> - **For:** No analytics SDK yet: the Sequential SDK. PostHog, Amplitude, Mixpanel or Pendo: the recorder on its own. Smartlook: [Smartlook session replay](/docs/smartlook#session-replay).
> - **Default:** Strict masking. It masks every input and all text.
> - **You get:** Session replays. With the recorder on its own, the other analytics SDK’s events show on the replay timeline.
> - **Know this:** Settings › Recording & data, not code, controls what is recorded, the masking level and DevTools.
> - **Know this:** In a normal browser, look for requests to the API URL that answer 2xx. Setup step 3 says "It works" when the first event arrives (up to about a minute).

## Install

Choose the tag for your site.

| Your site | Use | Key |
|---|---|---|
| No analytics SDK yet | The Sequential SDK | The Sequential ingest key (`sq_sequential_…`): one key for events and replay. A trial key works only with the Sequential SDK. |
| Sends events with PostHog, Amplitude, Mixpanel, Pendo or Smartlook | The recorder on its own (`/rec/recorder.js`), for replay only | The replay ingest key (`sq_replay_…`): the Session replay key on Settings › Setup. A trial does not give this key: claim the trial first. |

### For coding agents

- **Coding agents:** if the person has no Sequential key yet, create a trial for them. Do not leave a placeholder key in the code. Send one call: `POST https://api.usesequential.com/api/agent/provision` with the JSON body `{"owner_email": "<the person's email>", "platform": "web"}`. Ask the person for their email if you do not have it. The answer has the key and the snippet. Until the person claims the trial, it accepts events only from `localhost` and other local addresses, and keeps up to 100 sessions. Sequential sends the person an email with a claim link. Tell the person to claim the trial within 72 hours. If nobody claims it, Sequential erases it. See [Let your agent set up a trial](/docs/agent-trial).
- The recording settings in Settings › Recording & data: There is no client-side option for any of these, so do not invent one.
- DevTools: Sequential applies the project’s current settings to every upload on the server, whatever the page sends, so there is nothing to configure in code. Do not add client-side options for it.

Variants (tabs on the page; each is written out below): Install: the Sequential SDK · Replay only, next to another analytics SDK

### Install: the Sequential SDK

Paste the code once into your site's `<head>`. In a single-page app, add it once, to the HTML shell (`index.html`, `app.html`, the root layout). Keep both parts: the small inline script and the tag. Nothing else to change.

```html
<!-- Sequential · analytics and session replay -->
<script>
(function(w){if(w.sequential)return;var q=[],s=w.sequential={_q:q},
m=['capture','identify','account','register','unregister','reset','optOut','optIn','captureException'];
for(var i=0;i<m.length;i++)(function(n){s[n]=function(){q.push([n,arguments])}})(m[i]);
s.flush=function(){q.push(['flush',arguments]);return typeof Promise=='function'?Promise.resolve():{then:function(f){if(f)f()}}}})(window);
</script>
<!-- Optional: add data-release="<your app version>" to the tag below to put the build on every event. -->
<script async src="https://cdn.usesequential.com/sdk/sequential/v1/sequential.js"
        data-key="YOUR_SEQUENTIAL_INGEST_KEY"
        data-api="https://api.usesequential.com"></script>
```

One tag for analytics and session replay, served from Sequential's CDN: no third-party origin in your page, and no second key to find.

For Google Tag Manager, see [A Custom HTML tag in Google Tag Manager](/docs/sequential#a-custom-html-tag-in-google-tag-manager).

The options, the opt-out and the Content-Security-Policy of the SDK are on [Sequential SDK](/docs/sequential).

### Replay only, next to another analytics SDK

Use the recorder on its own only if the site already sends events with PostHog, Amplitude, Mixpanel, Pendo or Smartlook, and you want to add replay only.

Add this to every page you want to replay, in the `<head>` or before `</body>`. In a single-page app, add it once, to the HTML shell (`index.html`, `app.html`, the root layout). It keeps recording across client-side navigation.

```html
<script src="https://api.usesequential.com/rec/recorder.js/YOUR_REPLAY_INGEST_KEY"></script>
```

It works from a tag manager too: a Custom HTML tag on All Pages. Every key works with one source only. The Sequential ingest key and an analytics SDK’s key do not work in the recorder’s tag.

## Events on the timeline

The recorder reads the session id of PostHog, Amplitude, Mixpanel, Pendo or Smartlook on the page, so that SDK’s events show on the replay timeline. No extra code is needed.

### How the recorder finds the other SDK

The recorder looks for an analytics SDK on the page, for up to two seconds after it starts. It reads the SDK’s session id: PostHog, Amplitude, Mixpanel, Pendo and Smartlook in that order. It reads the user id from PostHog, Amplitude, Mixpanel or Pendo. That is what puts every event those SDKs send on the replay timeline. No extra code is needed.

With no SDK on the page, the recorder makes its own session id. It also registers that id as a super property on PostHog, Mixpanel and Pendo if they load later (Amplitude excepted). `window.__lxReplaySessionId` holds the current id.

## Content-Security-Policy

Only if the site sets a Content-Security-Policy. Add these origins to the directives it already has; do not replace them.

```text
script-src https://api.usesequential.com https://cdn.usesequential.com
connect-src https://api.usesequential.com
```

## What gets recorded is set in Sequential, not in the page

The table gives the defaults. Your project’s own values are in Settings › Recording & data.

| Setting | Default |
|---|---|
| Share of sessions recorded | 100 % |
| Shortest session kept | 2 s |
| Longest recording | 60 min |
| Largest recording | 25 MB |
| Masking level | Strict |

To keep one element out of a recording under Strict or Balanced, add the `data-rr-block` attribute: it is replaced by an empty box of the same size.

### Each recording setting in detail

- Record sessions. Off makes the script inert.
- Share of sessions recorded: the share of sessions recorded, decided once per session (100 % by default). Staging and development projects made before 1 November 2026 started at 10 %.
- Shortest session kept (2 s by default): shorter visits are never uploaded.
- Longest recording and Largest recording (60 min and 25 MB by default).
- "Record only these pages" and "Never record these pages", matched against the whole path: `*` matches within one path segment, `**` across segments. Deny wins. Each list holds at most 100 wildcards and 8,192 characters in total (so does "Requests ignored"). A save that would push a list over that limit is refused, with a message naming the list. A list saved before the limit existed keeps working, and a save that leaves it unchanged or shorter still goes through.
- Masking level. *Strict* (the default) masks every input and all text, and blocks images, video, audio, iframes, SVG and embeds. It also masks attribute values such as `title`, `alt` and `data-*`, cuts link and image addresses to their domain, and keeps only the route of the page address, with id-like segments masked. *Balanced* masks every input plus text marked `data-sq-mask` or class `sq-mask`, and blocks video, audio, iframes and embeds; it records attribute values and the full page address. *Custom* sets each rule, attribute masking included. Both presets also mask the value of a checkbox or radio button that a user picks, the name of a chosen file and the value of hidden fields. Sequential’s servers mask attribute values and input values again when a recording arrives.

## DevTools: errors, console, network, performance

Every recording can carry JavaScript errors, the console, network requests and performance timings, in a DevTools drawer in the player. Everything except console message text and the console debug level is on by default.

### What DevTools keeps, redacts and limits

Every recording can carry what a browser’s developer tools would show. It works the same whichever analytics SDK is on the page, because the recorder captures it.

- JavaScript errors: uncaught errors and unhandled promise rejections, with message and stack.
- Console: for the levels the project records, each call’s level, how often it happened and where. Message text isn’t recorded unless the project turns on "Console message text", which is off by default, because message text is free-form and no rule can reliably redact it. Exception messages are always kept.
- Network requests: method, URL, status, timing and size. Query-string values are redacted unless their key is listed under "Query values kept". Fragments and credentials in URLs are dropped. Under *Strict* ("Attribute values": *Masked*), a file the page loads keeps only its domain, an API call keeps its route with id-like segments masked, and error and console text lose ids after a `/`. Request and response headers and bodies are never recorded.
- Performance: LCP, INP, CLS, FCP and TTFB, plus navigation timing, per page load.
- Settings: Settings › Recording & data › "What a recording carries" has "JavaScript errors", "Console output" (with the levels error, warn, info, log and debug; debug is off by default), "Console message text", "Network requests" (with "Query values kept" and "Requests ignored") and "Performance timings". Sequential applies the project’s current settings to every upload on the server, whatever the page sends, so there is nothing to configure in code.
- Redaction: on top of that, values with a recognisable shape are redacted wherever DevTools data appears: JWTs, `Bearer` / `Basic` credentials, email addresses, card numbers, and values under keys such as `password`, `token` or `session`.
- Limits: bursts of console messages and exceptions are rate-limited, DevTools data is capped at about 1 MB per page, and a single entry at 64 KB.

> **Important**
>
> Redaction of values with a recognisable shape is a safety net, not a guarantee. A JWT written straight after a letter, digit, `_` or `-` can slip through. That is why console message text stays opt-in.

## What is not recorded

- Canvas and WebGL content. Strict and Balanced leave canvas recording off.
- The inside of cross-origin iframes.

Mobile apps record through PostHog’s mobile SDKs instead; see [Mobile apps](/docs/mobile).

## Check it works

1. (Web) Load a page of the site in a normal browser.

2. Open the network panel.

3. Look for requests to the API URL that answer 2xx.

Done when: In Sequential, step 3 of the project setup says "It works" when the first event arrives. Then your source's line on Settings › Setup says "receiving". The first event can take up to about a minute to appear.

### If it does not work

| Symptom | Cause | Fix |
|---|---|---|
| A request answers 401 | The key is wrong, or belongs to another source. Every key works with one SDK only. | — |
| A request answers 403 | The request looked like a bot. Headless and automated browsers are rejected as bots. | Load the page in a normal browser, not a headless or automated one. |

More checks: [Check that your install works](/docs/verify).

## Next steps

- [Session replay recording settings](/docs/recording-settings): change what a project records.
- [Session replay masking and redaction](/docs/masking-and-redaction): choose a masking level.
- [DevTools in session replays](/docs/devtools): use the DevTools drawer.
