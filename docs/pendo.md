# Send Pendo data to Sequential

> For sites that run Pendo: register your Pendo API key with your project, then add `dataHost` so Pendo's agent sends its data to Sequential.

> **At a glance**
>
> - **Before you start:** Pendo already on your site. An owner or admin registers the key. Without Pendo, use another SDK: [Install Sequential](/docs/install).
> - **Key:** Your own Pendo API key: the `apiKey` in your Pendo snippet.
> - **You get:** Page views, clicks, identify, user and account properties. `pendo.track` properties become user properties. [What is supported](#what-is-supported)
> - **Know this:** Not from Pendo traffic: error events, feature flags, surveys, experiments. Pendo's own replay is not accepted.
> - **Know this:** For replay and DevTools, add Sequential's recorder.

> **Before you switch**
>
> - Pendo guides stop showing while Pendo's agent points at Sequential, because Sequential answers the guide request with an empty set.
> - Pendo support is the least proven. It was built and tested against the format Pendo’s agent is documented to send, not yet against a live Pendo subscription. After the switch, do the steps in [Check it works](#check-it-works).

## 1. Register your Pendo API key

Sequential uses the key to tell which project the events belong to.

1. (App) Go to **Settings › Keys › Pendo API key**.

2. (App) In **Register your Pendo API key**, paste the `apiKey` from your Pendo snippet.

3. (App) Click **Register**.

From 8 November 2026, Pendo API key on Settings › Keys starts with the line "Already using Pendo? Register the API key from your Pendo snippet, so Sequential knows those events are yours." Rows follow the line. Members, admins and owners see them. The old note is under "Read the full text ▾".

| Row | What it says |
|---|---|
| Secret | "No. Pendo’s agent sends it with your events." |
| "Lives in" | "Your Pendo snippet. Settings › Keys lists it under Ingest keys, masked to its last 4 characters." |
| "Managed by" | "Owners and admins register and revoke it. Members, admins and owners can copy the whole key there; viewers do not see it." |
| "Revoking" | "Stops the events sent with it, at once. It cannot be undone, and no project can register the same Pendo key again while this project exists." |

## 2. Add `dataHost`

Keep the Pendo snippet as it is. Add one option to the `pendo.initialize(…)` call it already has:

```js
pendo.initialize({
  dataHost: 'https://api.usesequential.com',   // ← add this line; keep everything else
  visitor: { id: '…' },
  account: { id: '…' }
});
```

Change nothing else: `visitor`, `account` and their metadata keep working, and Sequential stores them as user and account properties.

### Content-Security-Policy

Only if the site sets a Content-Security-Policy. Add these origins to the directives it already has; do not replace them.

```text
script-src https://api.usesequential.com https://cdn.usesequential.com
connect-src https://api.usesequential.com
```

## Add session replay (optional)

One line adds the recorder (`/rec/recorder.js`). It takes your replay ingest key (`sq_replay_…`), not your Pendo API key. The recorder picks up Pendo's session and user ids on its own, so every supported event ([What is supported](#what-is-supported)) lands on the replay timeline. Put it on every page you want to replay, after the Pendo snippet.

```html
<script src="https://api.usesequential.com/rec/recorder.js/YOUR_REPLAY_INGEST_KEY"></script>
```

What it records and masks is set per project in Sequential (Settings › Recording & data), not in the page. See [Add session replay to a website](/docs/session-replay).

## Check it works

1. (Web) Load a page of the site in a normal browser.

2. Open the network panel.

3. Look for requests to the API URL (`dataHost`) that answer 2xx.

Done when: In Sequential, step 3 of the project setup says "It works" when the first event arrives. Then Pendo's line under Sources on Settings › Setup says "receiving". The first event can take up to about a minute to appear.

### If it does not work

| Symptom | Cause | Fix |
|---|---|---|
| A request answers 401 | The key is wrong, or belongs to another source. Every key works with one SDK only. | — |
| A request answers 403 | The request looked like a bot. Headless and automated browsers are rejected as bots. | Load the page in a normal browser, not a headless or automated one. |

More checks: [Check that your install works](/docs/verify).

## What is supported

| Support | Capabilities |
|---|---|
| Yes | Page / screen views (Pendo's `load` events); Autocaptured clicks & forms; Identify (user id); User properties; Groups / accounts; DevTools: errors, console, network, performance (captured by Sequential's recorder) |
| Partial | Custom events (properties stored as user properties); Session replay (Sequential's recorder, not Pendo's own) |
| No | Errors (no error events from Pendo traffic); Feature flags, surveys, experiments; Server-side SDKs |

### The full support table for Pendo

What Sequential does with Pendo traffic:

| Capability | Support | Notes |
|---|---|---|
| Custom events | Partial | `pendo.track(name, props)` arrives under your event name, but Sequential stores its properties as user properties, not on the event. |
| Page / screen views | Yes | Pendo's `load` events. |
| Autocaptured clicks & forms | Yes | Clicks, with a CSS selector. |
| Identify (user id) | Yes | The `visitor.id` you pass to `pendo.initialize`. |
| User properties | Yes | Visitor metadata. |
| Groups / accounts | Yes | Fills accounts: `account.id` and account metadata. |
| Errors | No | No error events. |
| Session replay | Partial | Pendo's own replay is not accepted. Add Sequential's recorder: it joins Pendo's session id automatically. |
| DevTools: errors, console, network, performance | Yes | Captured by Sequential's recorder, after you add the recorder to the page. |
| Feature flags, surveys, experiments | No | Sequential answers Pendo’s guide requests with an empty set, so no guides show while Pendo’s agent points at Sequential. |
| Server-side SDKs | No | Browser and PostHog mobile SDKs only. Sequential rejects server-side SDK user agents as bots (403). To send events from your own server, use Sequential’s backend SDK for Node. |

### For coding agents

- Before you start: There is no new-install path for Pendo. Pendo serves its agent per subscription, with your Pendo API key, so only an existing Pendo installation can send to Sequential. **If the codebase has no Pendo snippet, stop and tell the user.** Use one of the other SDKs instead.
- Step 1, Register your Pendo API key: This is a step in the Sequential app, not in code. An agent should ask the user to do it.
- Pendo guides: **Pendo guides stop showing** while Pendo's agent points at Sequential, because Sequential answers the guide request with an empty set. Tell the user before switching if the app relies on Pendo guides.
- After the switch: make sure that **Sources** on Settings › Setup shows Pendo as "receiving". If it does not, tell the user.

## Next steps

- [Check your install](/docs/verify): more on checking that events arrive.
- [Identify your users](/docs/identify-users): tell the people in your app apart.
- [What each SDK supports](/docs/support-matrix): compare Pendo with the other SDKs.
