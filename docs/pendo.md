# Send Pendo data to Sequential

> For sites that run Pendo: add `dataHost` so Pendo's agent sends its data to Sequential, and register your Pendo API key with your project.

There is no new-install path for Pendo. Pendo serves its agent per subscription, with your Pendo API key, so only an existing Pendo installation can send to Sequential. **If the codebase has no Pendo snippet, stop and tell the user.** Use one of the other SDKs instead.

## 1. Register your Pendo API key

In Sequential, go to Settings › Keys › **Pendo API key**. In **Register your Pendo API key**, paste the `apiKey` from your Pendo snippet. Then select **Register**. You must be an owner or admin. Sequential uses it to tell which project the events belong to. This is a step in the Sequential app, not in code. An agent should ask the user to do it.

## 2. Add `dataHost`

Keep the Pendo snippet as it is and add one option to the `pendo.initialize(…)` call it already has, so Pendo’s agent sends its data to Sequential:

```js
pendo.initialize({
  dataHost: 'https://api.usesequential.com',   // ← add this line; keep everything else
  visitor: { id: '…' },
  account: { id: '…' }
});
```

Change nothing else: `visitor`, `account` and their metadata keep working, and Sequential stores them as user and account properties.

## What is supported

What Sequential does with Pendo traffic:

| Capability | Support | Notes |
|---|---|---|
| Custom events | Partial | `pendo.track(name, props)` arrives under your event name, but its properties are stored as user properties, not on the event. |
| Page / screen views | Yes | Pendo's `load` events. |
| Autocaptured clicks & forms | Yes | Clicks, with a CSS selector. |
| Identify (user id) | Yes | The `visitor.id` you pass to `pendo.initialize`. |
| User properties | Yes | Visitor metadata. |
| Groups / accounts | Yes | Fills accounts: `account.id` and account metadata. |
| Errors | No | No error events. |
| Session replay | Partial | Pendo's own replay is not accepted. Add Sequential's recorder: it joins Pendo's session id automatically. |
| DevTools: errors, console, network, performance | Yes | Captured by Sequential's recorder once the session-replay line is on the page. |
| Feature flags, surveys, experiments | No | Guides are answered with an empty set, so no guides show while the agent points here. |
| Server-side SDKs | No | Browser and PostHog mobile SDKs only. Server-side SDK user agents are rejected as bots (403). To send events from your own server, use Sequential’s backend SDK for Node. |

> **Pendo guides stop showing** while the agent points at Sequential, because Sequential answers the guide request with an empty set. Tell the user before switching if the app relies on Pendo guides.

> **Pendo support is the least proven.** It was built and tested against the format Pendo’s agent is documented to send, not yet against a live Pendo subscription. After the switch, make sure that **Sources** on Settings › Setup shows Pendo as "receiving". If it does not, tell the user.

## Add session replay (optional)

Optional, one line. The recorder picks up Pendo's session and user ids on its own, so every event above lands on the replay timeline. Put it on every page you want to replay, after the SDK. What it records and masks is set per project in Sequential (Settings › Recording & data), not in the page. See [Session replay](/docs/session-replay).

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
