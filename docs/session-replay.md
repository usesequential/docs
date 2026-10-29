# Add session replay to a website

> One script tag adds session replay to a website. With an analytics SDK on the page, its events show on the replay timeline. Without one, it works alone.

## Install

Add this to every page you want to replay, in the `<head>` or before `</body>`. In a single-page app, add it once, to the HTML shell (`index.html`, `app.html`, the root layout). It keeps recording across client-side navigation. It works from a tag manager too: a Custom HTML tag on All Pages.

```html
<script src="https://api.usesequential.com/rec/recorder.js/YOUR_REPLAY_INGEST_KEY"></script>
```

The key is the project’s **replay** key, not an analytics SDK’s key. Every key works with one source only.

## Events on the timeline

The recorder looks for an analytics SDK on the page, for up to two seconds after it starts. It reads the SDK’s session id: PostHog, Amplitude, Mixpanel, Pendo and Smartlook in that order. It reads the user id from PostHog, Amplitude, Mixpanel or Pendo. That is what puts every event those SDKs send on the replay timeline. No extra code is needed.

With no SDK on the page, the recorder makes its own session id. It also registers that id as a super property on PostHog, Mixpanel and Pendo if they load later (Amplitude excepted). `window.__lxReplaySessionId` holds the current id.

## What gets recorded is set in Sequential, not in the page

Settings › Recording & data controls these. The numbers below are the defaults; a project’s own values are on that page:

- **Record sessions.** Off makes the script inert.
- **Share of sessions recorded**: the share of sessions recorded, decided once per session. New non-production projects start at 10 %.
- **Shortest session kept** (2 s by default): shorter visits are never uploaded.
- **Longest recording** and **Largest recording** (60 min and 25 MB by default).
- **Record only these pages** and **Never record these pages**, matched against the whole path: `*` matches within one path segment, `**` across segments. Deny wins. Each list holds at most 100 wildcards and 8,192 characters in total (so does **Requests ignored**). A save that would push a list over that limit is refused, with a message naming the list. A list saved before the limit existed keeps working, and a save that leaves it unchanged or shorter still goes through.
- **Masking level.** *Strict* (the default) masks every input and all text, and blocks images, video, audio, iframes, SVG and embeds. It also masks attribute values such as `title`, `alt` and `data-*`, cuts link and image addresses to their domain, and keeps only the route of the page address, with id-like segments masked. *Balanced* masks every input plus text marked `data-sq-mask` or class `sq-mask`, and blocks video, audio, iframes and embeds; it records attribute values and the full page address. *Custom* sets each rule, attribute masking included. Both presets also mask the value of a checkbox or radio button that a user picks, the name of a chosen file and the value of hidden fields. Sequential’s servers mask attribute values and input values again when a recording arrives.

There is no client-side option for any of these, so do not invent one. To keep one element out of a recording under Strict or Balanced, add the `data-rr-block` attribute: it is replaced by an empty box of the same size.

## DevTools: errors, console, network, performance

Every recording can carry what a browser’s developer tools would show, in a DevTools drawer in the player. It works the same whichever analytics SDK is on the page, because the recorder captures it:

- **JavaScript errors**: uncaught errors and unhandled promise rejections, with message and stack.
- **Console**: for the levels the project records, each call’s level, how often it happened and where. Message **text** isn’t recorded unless the project turns on **Console message text**, which is off by default, because message text is free-form and no rule can reliably redact it. Exception messages are always kept.
- **Network requests**: method, URL, status, timing and size. Query-string **values** are redacted unless their key is listed under **Query values kept**. Fragments and credentials in URLs are dropped. Under *Strict* (**Attribute values**: *Masked*), a file the page loads keeps only its domain, an API call keeps its route with id-like segments masked, and error and console text lose ids after a `/`. Request and response headers and bodies are never recorded.
- **Performance**: LCP, INP, CLS, FCP and TTFB, plus navigation timing, per page load.

It is set per project in Settings › Recording & data › **What a recording carries**: **JavaScript errors**, **Console output** (with the levels error, warn, info, log and debug; debug is off by default), **Console message text**, **Network requests** (with **Query values kept** and **Requests ignored**) and **Performance timings**. Everything except message text is on by default. Sequential applies the project’s current settings to every upload on the server, whatever the page sends, so there is nothing to configure in code. Do not add client-side options for it.

On top of that, values with a recognisable shape are redacted wherever DevTools data appears: JWTs, `Bearer` / `Basic` credentials, email addresses, card numbers, and values under keys such as `password`, `token` or `session`. That is a safety net, not a guarantee. A JWT written straight after a letter, digit, `_` or `-` can slip through. That is why message text stays opt-in.

Limits: bursts of console messages and exceptions are rate-limited, DevTools data is capped at about 1 MB per page, and a single entry at 64 KB.

## What is not recorded

Canvas and WebGL content (Strict and Balanced leave canvas recording off), and the inside of cross-origin iframes. Mobile apps record through PostHog’s mobile SDKs instead; see [Mobile apps](/docs/mobile).

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
