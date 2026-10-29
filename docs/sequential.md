# Sequential SDK (sequential.js)

> One script tag for analytics and session replay, served from Sequential's CDN, with one key. The recommended install for a site with no analytics SDK yet.

## Install

One tag for analytics and session replay, served from Sequential's CDN — no third-party origin in your page, and no second key to find. Paste it once into your site's `<head>`, or into a Google Tag Manager Custom HTML tag that fires on All Pages. Nothing else to change. In a single-page app, add it once, to the HTML shell (`index.html`, `app.html`, the root layout).

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

Keep both parts: the small inline script and the tag.

- **The inline script** defines `window.sequential` straight away and queues calls until the SDK arrives. So `sequential.capture(…)` in a click handler or route effect works on a cold page, and does not throw if an ad blocker stops the SDK loading.
- **`data-key`** (required) is the project’s Sequential ingest key.
- **`data-api`** (required) is Sequential’s API URL. It is not worked out from the script’s own address, because the script comes from the CDN.
- **`data-opt-out`** (optional) starts every visitor opted out, for sites that wait for consent. See below.
- **`data-autocapture="false"`** (optional) turns off automatic page views, clicks, form submits, rage clicks and dead clicks. Calls you make still work.
- **`data-release`** (optional) names your app’s build, for example `data-release="2.14.1"` or a commit SHA. Sequential puts it on every event as the release, and [release verification](/docs/findings) uses it to tell sessions before a fix from sessions after it. It must be 1 to 64 printable ASCII characters. The SDK also refuses the placeholder words that an empty build variable can give. For any other value, the SDK sends events without a release and writes one error to the browser console. `sequential.register({ $release: '2.14.1' })` also works, and it wins over the attribute.
- **`data-context-cookie-domain`** (optional) sets the domain of the context cookie, for a backend on a different subdomain. For example, with pages on `www.shop.com` and an API on `api.shop.com`, write `data-context-cookie-domain="shop.com"`. The value can have only letters, digits, `.` and `-`. For any other value, the SDK keeps the cookie on the page’s host and writes one error to the browser console. See **What leaves the page**.

## Already using Sequential

Only two values ever change: the project key and the ingest host. Both are attributes on the script tag — there is no init call to edit, and no second tag for replay.

```html
data-key="YOUR_SEQUENTIAL_INGEST_KEY"
data-api="https://api.usesequential.com"
```

## Configure without attributes

A loader that cannot set `data-*` attributes, such as a Google Tag Manager tag template, can give the SDK its settings in `window.sequentialConfig`. Set it before the SDK loads:

```js
window.sequentialConfig = { key: 'sq_sequential_…', api: 'https://api.usesequential.com', release: '2.14.1' };
```

- The SDK reads it once, when it loads, and only when its own script tag has no `data-key`. A tag with `data-key` always wins.
- It must be an own property of `window` that holds a plain object. Google Tag Manager’s `setInWindow` gives one.
- The SDK reads only `key`, `api` and `release`. For any other name, it writes a warning to the console. `data-opt-out`, `data-autocapture` and `data-context-cookie-domain` have no config property yet.
- `key` must be `sq_sequential_` and 1 to 64 letters or digits. If the key is missing or has another form, the SDK does not use the config. It then looks for a script tag with `data-key` on the page.
- `api` is required. It must be an `https://` origin, such as `https://api.usesequential.com`. A port is allowed, and the SDK drops slashes at the end. A path, a query, a fragment, user information or `http:` is refused, and then the SDK sends nothing.
- `release` works like `data-release`.
- There is no queue on this path: `window.sequential` exists only after the SDK has loaded. Guard each call, for example `if (window.sequential) window.sequential.capture('signup_started')`. If your page must call the SDK before it loads, use the install snippet instead.
- For consent, decide in the loader when the SDK loads. In Google Tag Manager, use the tag’s trigger or its consent settings. This path has no `data-opt-out`, so load the SDK only after consent. A stored opt-out (`__sq_opt`), `sequential.optOut()` and `sequential.optIn()` work the same as with the tag.
- Use the install snippet or a loader, not both on one page.

**The tag template for Google Tag Manager.** Sequential’s template was submitted for review to Google’s Community Template Gallery on 18 October 2026. Until Google accepts it, import it by hand from [usesequential/gtm-template](https://github.com/usesequential/gtm-template). Its README lists the fields, the import steps and consent. The template:

- checks the key and the API host. If one is wrong, it does not load the SDK.
- loads the SDK only when `analytics_storage` consent is granted, if your site uses Google consent mode. A consent type that your site never sets counts as granted.
- does not load the SDK again when the SDK is already on the page. Set the tag to fire once per page.

In the preview and debug mode of Google Tag Manager, the template writes one of these lines when it does not load the SDK:

- "Sequential: the project key must be sq_sequential_ followed by 1 to 64 letters or digits. The SDK is not loaded."
- "Sequential: the API host must be an https:// origin with no path, such as https://api.usesequential.com. The SDK is not loaded."
- "Sequential: analytics_storage consent is not granted. The SDK is not loaded."
- "Sequential: the SDK is already on this page. The tag does not load it again."

For the console lines of the SDK itself, see [Troubleshooting](/docs/troubleshooting#console-lines-about-the-sdk-settings).

## Replacing a vendor SDK or the replay line

This tag **replaces** both, and running it alongside a vendor SDK is not supported. They are separate sources with separate keys, so every page view would be counted twice, under two identities. When moving an app over:

1. Remove the vendor SDK (its loader or package and its init call) and any `/rec/recorder.js/…` session-replay line. The Sequential SDK starts the recorder itself.
2. Change the vendor calls the app makes to the Sequential equivalents below. The method names are close on purpose: `posthog.capture` becomes `sequential.capture`.
3. Call `sequential.identify(userId)` on load for signed-in users. The SDK starts with a new anonymous id, so without it every known user shows up as new.

## Calling it from your code

- `sequential.capture(name, props)` records an event. **Names starting with `$` are reserved** for Sequential’s own events, and `capture()` throws on them, so pick a plain name (`checkout_started`, not `$checkout`).
- `sequential.identify(userId, props)` marks the visitor as a known user. The previous anonymous id travels with it as `$anon_distinct_id`. Sequential does not change the events stored before `identify`, but **People**, funnels, flows, retention and the user counts on **Events** count them under the identified user. See [Identify your users](/docs/identify-users#what-identify-does-not-do).
- `sequential.register(props)` and `sequential.unregister(name)` add or remove properties that ride on every later event. To put your app’s release on every event, add `data-release` to the tag (see above), or call `sequential.register({ $release: '2.14.1' })` on each page load. [Release verification](/docs/findings) uses it.
- `sequential.account(id, traits)` sets the account, such as a company or a workspace, that the visitor acts for. The id is a string or a number of 1 to 200 characters. The SDK ignores any other id and writes an error to the console. After the call, every event carries the account id. The traits are flat text, number or true/false values: up to 50 names of up to 100 characters, and values of up to 1,000 characters. The SDK drops other traits. It sends the traits in an `$account` event only when the account or the traits change. **Accounts** lists the account.
- A snippet that you copied before 9 October 2026 has no `account` in its stub. With that snippet, a call of `sequential.account()` before the script loads fails. Copy the snippet again from **Setup**, or call `account()` after the script loads.
- `sequential.reset()` starts a new anonymous visitor and forgets the account. It also removes the properties that you added with `register()`, so call `register()` again after it. Call `reset()` on sign-out.
- `sequential.captureException(error, props)` records an error. Uncaught errors are **not** captured automatically, so call it where your app handles errors.
- `sequential.flush()` sends what is queued now and returns a promise.
- If your project has a list of allowed origins and the website is not on it, Sequential refuses the events with 403 `origin_not_allowed`. The SDK then stops sending for the rest of that page load and writes one warning to the console: "[sequential] Events refused: this website is not on the project's allowed websites (origin_not_allowed). This page sends no more events." The next page load tries again.
- If the project sends more than 20,000 events a minute, Sequential refuses the batch with 429. The SDK waits for the time that Sequential gives (1 to 300 seconds), and keeps the refused batch and new events, at most 100. Then it sends them again, once. See [Limits](/docs/limits).
- `sequential.optOut()` and `sequential.optIn()`: see below.

For an app with a build step, the same SDK is also an npm package with types: see [Install the browser SDK with npm](/docs/browser-npm). With the script tag, in a TypeScript app, read it through `window` with a narrow local type rather than adding a global declaration file.

## Page views

The SDK records a `$pageview` when the page loads. In a single-page app, it records one more each time the page changes: after `history.pushState`, after `history.replaceState`, and after the browser’s back and forward buttons (`popstate`).

- The page is the path and the query string. A different query, for example `?plan=team`, is a different page. One exception, from 22 October 2026: a `replaceState` that changes only the query string, and keeps the path and the hash route, is not a page view. A player that writes `?t=` every few seconds, or a list that writes `?sort=` in place, stays on one page. A `pushState` that changes only the query is still a page view.
- The fragment is part of the page only for a hash route, one that starts with `#/` or `#!/`. So `#/a` to `#/b` is a new page. Any other fragment, for example `#features`, is a place on the same page, and it records no page view.
- The SDK compares the page only with the last page that it recorded. If the page did not change, for example when a router calls `replaceState` for its own state, the SDK records no page view. A return to an earlier page records a page view again.
- From 9 October 2026, `$current_url` keeps a hash route, up to its first `?`, `&` or a second `#`. The SDK redacts it with the rest of the address, and drops a route of more than 512 characters. It drops every other fragment. Before that date, `$current_url` had no fragment, so the page views of two hash routes had the same URL.
- Each `$pageview` has `$nav`, which tells how the page was reached:
  - `load`: the first page view of a page load.
  - `push`: `history.pushState`, in every browser. With the Navigation API, also a link to a hash route or a change to `location.hash`.
  - `replace`: `history.replaceState`, in every browser, for example a redirect in your router. With the Navigation API, also a navigation of the replace type.
  - `pop`: with the Navigation API, the Back or Forward button, `history.go`, or a move back or forward across hash routes.
  - `unknown`: every page view from `popstate` in a browser without the Navigation API. The SDK does not guess.
- The `load` page view also has `$load_type`: `navigate`, `reload`, `back_forward`, `prerender` or `unknown`.
- When the browser shows a page again from its back/forward cache, the SDK records no page view.

**From 9 October 2026:** before this date, the SDK recorded a page view after every `pushState`, `replaceState` and `popstate`, also when the page did not change. Thus many single-page apps got duplicate page views. From this date, page-view counts on those sites go down. Funnels and flows with page-view steps change too: repeated steps on the same page go away, and the conversion between page steps can go up. The AI judge also sees fewer repeated page views. Sequential does not change older events, so a chart that spans this date shows a step down on it.

**From 22 October 2026:** a `replaceState` that changes only the query string is no longer a page view. On a site that rewrites its query in place, for example a video or replay position, filters or sorting, page-view counts go down from this date. If your app moves between steps by replacing only the query (a wizard at `?step=2` written with `replaceState`), those steps are no longer page views: use `pushState`, or send your own event for each step. Older events do not change.

## Rage clicks and dead clicks

The SDK also finds clicks that get no response, and sends them as `$rageclick` and `$deadclick` events. Sequential stores them as rage clicks and dead clicks, the same as these events from other SDKs, and [Findings](/docs/findings) use them. `data-autocapture="false"` turns off both.

**Rage click.** A burst is a series of clicks near the first click (30 pixels or less), each less than 1 second after the click before it. The burst is a rage click when 3 of its clicks come within 1 second.

- The SDK sends one event for each burst, 1 second after its last click. The event has the number of clicks (`$click_count`) and the time of the first click.
- If the page responds during the burst, the SDK sends no event. A response is a change to the page, a new URL, a scroll, a text selection, or focus that moves to a different element. A change to the attributes of the clicked element is a response only when it changes a state attribute: `aria-checked`, `aria-pressed`, `aria-expanded`, `aria-selected`, `open`, `checked` or `value`. So a triple click that selects text is not a rage click, and a switch that changes its state when it is clicked is not a rage click. A switch that does not change is.
- If the person leaves the page during a burst, the SDK sends the burst immediately.
- These clicks are not counted: clicks in inputs that are not buttons (for example text, number, range and checkbox inputs), in `select` and `textarea` elements, and in editable areas. To exclude an element and everything in it, add `data-sq-no-rage` to it.
- Clicks on a disabled button count.

**Dead click.** A dead click is a click on a link, a button, a submit input, an element with `role="button"` or an element with `data-sq`, after which nothing happens for 2.5 seconds: no change to the page, no new URL, no scroll, no text selection, and no focus that moves to a different element.

- The event has the wait (`$wait_ms`, 2500) and the time of the click.
- These clicks are not counted: links with `download`, links that open a new tab (`target="_blank"`), `mailto:`, `tel:` and `sms:` links, clicks on or in a `label`, inputs that are not buttons, and clicks while the tab is hidden.
- A new click stops the wait for the click before it, and that click sends no event. If the person leaves the page during the wait, the SDK sends no dead click.
- A click on a disabled button counts.

For both: the SDK counts only clicks with the main mouse button and no modifier key (Ctrl, Cmd, Shift or Alt). Both need `MutationObserver` in the browser. Without it, the SDK sends neither.

The **Rage clicks** signal of the default [rubric](/docs/rubric) also works with this SDK: the judge reads repeated clicks in the session’s events. The replay player also marks the rage clicks and dead clicks that it finds in the recording.

## Consent

`sequential.optOut()` stops analytics **and** session replay. It deletes the ids that the SDK stored in the browser, and keeps one key, `__sq_opt` in `localStorage`, so that the opt-out stays in force across reloads. This key stores only the visitor’s choice: no id and no time. `sequential.optIn()` deletes it. If the recorder has started, `optOut()` stops it for the rest of that page load, and `optIn()` does not start it again. Recording can start again on the next page load. For a site that waits for consent, add `data-opt-out` to the tag: every visitor starts opted out, until your consent banner calls `sequential.optIn()`. The attribute is a default, not a stored choice. Because of the inline script, both calls work before the SDK has loaded.

**Before opt-in, and while a visitor is opted out, the SDK stores no id and no session value:** no visitor id, no session id and no cookie. It keeps its ids in memory, and stores them when `optIn()` is called. With `data-opt-out`, the SDK stores nothing at all, because your page states the choice on each load. After `optOut()`, `__sq_opt` is the only key.

When you need consent, the keys that the SDK stores, and an example for a consent platform: see [Privacy overview](/docs/privacy-overview#consent).

## What leaves the page

- **Page URLs, in the browser:** before sending, the SDK drops the `#fragment` and any `user:pass@` credentials, redacts values that look like JWTs, `Bearer` / `Basic` credentials, emails or card numbers, and caps the URL at 512 characters. Other query values, such as an opaque `token=abc123`, are sent as they are.
- **Page URLs, at Sequential:** before anything is stored, every query value is replaced with `[redacted]` unless it is a marketing-attribution parameter (`utm_*`, `gclid`, `fbclid` and similar). The same rule applies to every source; see [What Sequential keeps from page URLs](/docs/url-policy). So do not treat URLs as a place where secrets are safe from Sequential: some reach its servers, and are only discarded there.
- **Autocapture** records clicks on interactive elements and form submits, never what anyone types. Click text is redacted with the same rules as replay DevTools, which catch JWTs, `Bearer` / `Basic` credentials, emails and card numbers. A JWT written straight after a letter, digit, `_` or `-` can slip through. Anything inside an element marked `data-sq-mask` contributes no text. `data-sq-private` on an element or an ancestor goes further: the click is still recorded, but with no text, no `data-*` values and no element id, and its selector has no ids. From 10 October 2026, the SDK also leaves out a click's text and `data-*` values by default when the element or one of its 3 nearest ancestors is account UI, or when the text names the signed-in person. Account UI has one of these words in its class, id or `data-testid`: `avatar`, `account` or `user-menu` (also `usermenu` or `user_menu`), or an account-menu name with `profile`: `profile-menu`, `profile-dropdown`, `profile-button`, `profile-avatar`, `my-profile` or `user-profile`, with `-` or `_`. A word must stand alone, in any letter case: next to it there can be only the start or end, an underscore, or a character that is not a letter or a digit, such as `-`, a space or `/`. So `account_switcher` and `user-menu/trigger` match, and `accountsTable` and `account2` do not. Or its `aria-label`, in any letter case, names an account menu: it is exactly "Account", "User" or "Profile"; or it has "my account", "your account", "my profile", "your profile", "open account" or "open profile"; or it has "user", "account" or "profile" before "menu", "dropdown" or "options", with only the word "navigation" between them, such as "User menu", "Open account menu" or "User navigation menu". "Contact and social profiles" and "User guide" do not match. From 26 October 2026, `profile` alone, as in `profile-blog`, does not make an element account UI. From 26 October 2026, a click also carries `$el_label`, the `aria-label` of the element, and `$el_href`, where the closest link around the click goes. The label follows the rules of the click text: Sequential redacts it and keeps up to 128 characters. For a link on the same site, `$el_href` is the address with no query, `#fragment` or user name. For a link to another site, it is only the origin of that site, such as `https://www.linkedin.com`. For a link that is not `http(s)`, such as an email or phone link, it is only the type, such as `mailto:`. The SDK leaves out both fields together under `data-sq-mask` or `data-sq-private`. Unless the script tag has `data-identity-text="off"`, it also leaves them out in account UI, and when the text, the label or the link names the signed-in person, as for the click text. When Sequential stores `$el_href`, a project with **Strict** masking keeps only the origin of each link. Other projects keep the route of a link on the same site, with id-like parts masked. The signed-in person is an email, or a word of 3 or more letters of a name, that your app gave to `identify()`: the id, or traits such as `email`, `name` or `first_name`. The SDK keeps these words in memory only. If the selector names the person, it has no ids. To turn this off, add `data-identity-text="off"` to the script tag. Autocapture waits until the project’s configuration has loaded and stays off if it cannot load it, so nothing is captured before the redaction rules arrive.
- In private browsing, or where the site blocks storage, the SDK cannot keep its ids across page loads. Each page view then counts as a new visitor, and those events carry `$ephemeral_id: true`.
- **The context cookie.** While the SDK records, it writes the first-party cookie `__sq_ctx` on your domain. It holds the visitor id and the session id, so that your own backend can put its events in the same session with the [backend SDK](/docs/backend-sdk). The SDK writes it only after the project’s settings have loaded, and never while the visitor is opted out. `optOut()` clears it. `reset()` clears it and writes the new visitor and session. `optIn()` writes it again. It is an analytics cookie, so list it with your analytics cookies. It lasts 30 minutes, and the SDK writes it again while the session continues. It has `Path=/`, `SameSite=Lax` and, on https, `Secure`. It does not have `HttpOnly`. Without `data-context-cookie-domain`, only the page’s host gets it. After a reload of an identified visitor, it holds the user id.

## What is supported

What Sequential does with Sequential SDK traffic:

| Capability | Support | Notes |
|---|---|---|
| Custom events | Yes | `sequential.capture(name, props)`; properties are kept. Names starting with `$` are reserved for Sequential’s own events: `capture()` throws on them. |
| Page / screen views | Yes | `$pageview` on load, and on SPA navigation (`pushState`, `replaceState`, `popstate`) only when the page changes. An in-page `#anchor` is not a new page; a `#/` or `#!/` hash route is. From 2026-10-22, a `replaceState` that changes only the query is not a new page. |
| Autocaptured clicks & forms | Yes | Clicks on interactive elements and form submits; never input values. Rage clicks and dead clicks too. Click text is redacted, not just truncated, and anything inside `data-sq-mask` contributes no text or `data-*` values. Autocapture waits for the project’s config and stays off if it cannot load it. |
| Identify (user id) | Yes | `sequential.identify(id)`. The previous anonymous id is sent as `$anon_distinct_id`, and Sequential counts the events from before `identify` under the identified user. |
| User properties | Partial | `register()` properties ride on every later event, but are not stored as user properties. |
| Groups / accounts | Yes | `sequential.account(id, traits)`: the account id on every later event, and its traits in an `$account` event. |
| Errors | Partial | `sequential.captureException(err)` is stored as an error. Uncaught errors and unhandled rejections are not captured, so call `captureException` where you handle them. |
| Session replay | Yes | The same tag records sessions. The SDK starts Sequential’s recorder itself, with the replay key from the project’s config, so there is no second tag and no second key. Masking comes from the project’s recording settings. |
| DevTools: errors, console, network, performance | Yes | Captured by the recorder the SDK starts, on the same terms as every other source, subject to the project’s DevTools settings. |
| Feature flags, surveys, experiments | No | None, deliberately: flags, surveys and experiments need server-side products Sequential does not have, which is also why the SDK is a fraction of a vendor SDK’s size. |
| Server-side SDKs | Partial | With the backend SDK for Node (`@usesequential/node`) and a server key: your server’s events and errors, on the same person and in the browser session. Node only, and a server event cannot identify a person. On the browser route, server-side user agents are rejected as bots (403). |

Session replay is part of this tag. What is recorded and masked is set per project (Settings › Recording & data), and replay only runs if it is enabled there. See [Session replay](/docs/session-replay) for those settings.

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
