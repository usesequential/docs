# Install Sequential

> Install Sequential's SDK for analytics and session replay, or point PostHog, Mixpanel, Amplitude, Pendo or Smartlook at Sequential with a config change.

## Which page do I follow?

1. **The app already uses one of these SDKs:** follow that SDK’s page and change two values in its existing init. Nothing else in your tracking code changes. If it uses several, do each one. Every SDK has its own ingest key.
2. **A website with no analytics SDK yet:** install the [Sequential SDK](/docs/sequential). One tag gives analytics and session replay, with no vendor code on your page.
3. **A mobile app:** [Mobile apps](/docs/mobile), through PostHog’s mobile SDK.
4. **Replay only, no analytics:** [Session replay](/docs/session-replay) is one script tag.

The PostHog, Mixpanel, Amplitude, Pendo and Smartlook SDKs are compatible with Sequential. Their makers do not endorse Sequential and are not affiliated with it.

## Where the values come from

Each project in Sequential has one **ingest key per source** (`sq_sequential_…`, `sq_posthog_…`, `sq_mixpanel_…`, `sq_amplitude_…`, `sq_smartlook_…`, `sq_replay_…`) and one API URL. Both are in the install snippet for your source on Settings › Setup. The keys are also on Settings › Keys. Pendo is the exception: it uses your own Pendo API key. Register it in Settings › Keys › **Pendo API key**.

Ingest keys are public. They ship in your site’s HTML, like any analytics key. A key accepts data for its project and exposes the project’s recording settings. It is not a login or API credential.

## What Sequential keeps from page URLs

Before anything is stored, from every source: page URLs lose their `#fragment` (a hash route, such as `#/orders`, stays) and any `user:pass@` credentials, a secret in the path reads `[token]`, and every query-string value becomes `[redacted]` unless it is a marketing-attribution parameter (`utm_*`, `gclid`, `fbclid` and similar). URLs your own code puts into event properties are cleaned the same way only when they are complete `http(s)://` or `ws(s)://` addresses, so do not put secrets into event properties. The full rule, with examples: [What Sequential keeps from page URLs](/docs/url-policy).

## What each SDK supports

| Capability | Sequential SDK | PostHog (web) | PostHog (mobile) | Mixpanel | Amplitude | Pendo | Smartlook |
|---|---|---|---|---|---|---|---|
| Custom events | Yes | Yes | Yes | Partial | Yes | Partial | Yes |
| Page / screen views | Yes | Yes | Yes | Yes | Partial | Yes | Yes |
| Autocaptured clicks & forms | Yes | Yes | Partial | Yes | Yes | Yes | Partial |
| Identify (user id) | Yes | Yes | Yes | Yes | Yes | Yes | Yes |
| User properties | Partial | Partial | Partial | No | Partial | Yes | Yes |
| Groups / accounts | Yes | No | No | No | No | Yes | No |
| Errors | Partial | Partial | Partial | No | No | No | Yes |
| Session replay | Yes | Partial | Yes | Partial | Partial | Partial | Yes |
| DevTools: errors, console, network, performance | Yes | Yes | Partial | Yes | Yes | Yes | Yes |
| Feature flags, surveys, experiments | No | No | No | No | No | No | No |
| Server-side SDKs | Partial | No | No | No | No | No | No |

Each SDK’s page explains every partial and missing capability, and [What each SDK supports](/docs/support-matrix) has all the notes in one place. The boundary that applies to all of them: **browser SDKs and PostHog’s mobile SDKs only.** Server-side SDKs (posthog-node, mixpanel-python, Segment and similar) are rejected as bots by design. To send events from your own server, use Sequential’s [backend SDK for Node](/docs/backend-sdk), which has its own route and a server key.
