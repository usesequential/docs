# Install Sequential

> Install Sequential's SDK for analytics and session replay, or point PostHog, Mixpanel, Amplitude, Pendo or Smartlook at Sequential with a config change.

## Which page do I follow?

| Your app | Follow |
|---|---|
| A website that already uses PostHog, Mixpanel, Amplitude, Pendo or Smartlook | That SDK’s page: [PostHog (web)](/docs/posthog), [Mixpanel](/docs/mixpanel), [Amplitude](/docs/amplitude), [Pendo](/docs/pendo) or [Smartlook](/docs/smartlook). Change two values in its existing init. Nothing else in your tracking code changes. If your app uses several, do each one. Every SDK has its own ingest key. |
| A website with no analytics SDK yet | The [Sequential SDK](/docs/sequential). One tag gives analytics and session replay, with no vendor code on your page. |
| A mobile app | [Mobile apps](/docs/mobile), through PostHog’s mobile SDK. |
| Replay only, no analytics | [Session replay](/docs/session-replay): one script tag. |
| A coding agent does the install, and you have no key yet | [Let your agent set up a trial](/docs/agent-trial). The agent creates a trial for you. |
| Events from your own server | Sequential’s [backend SDK for Node](/docs/backend-sdk). It has its own route and a server key. |

The boundary that applies to all of them (the Sequential SDK, PostHog, Mixpanel, Amplitude, Pendo and Smartlook): browser SDKs and PostHog’s mobile SDKs only. Server-side SDKs (posthog-node, mixpanel-python, Segment and similar) are rejected as bots by design. To send events from your own server, use Sequential’s backend SDK for Node.

Ingest keys are public. They ship in your site’s HTML, like any analytics key. A key accepts data for its project and exposes the project’s recording settings. It is not a login or API credential.

### For coding agents

If the person has no Sequential key yet, create a trial for them. Do not leave a placeholder key in the code. Send one call: `POST https://api.usesequential.com/api/agent/provision` with the JSON body `{"owner_email": "<the person's email>", "platform": "web"}`. Ask the person for their email if you do not have it. The answer has the key and the snippet. Until the person claims the trial, it accepts events only from `localhost` and other local addresses, and keeps up to 100 sessions. Sequential sends the person an email with a claim link. Tell the person to claim the trial within 72 hours. If nobody claims it, Sequential erases it. See [Let your agent set up a trial](/docs/agent-trial).

## Where the values come from

Each project in Sequential has one ingest key per source (`sq_sequential_…`, `sq_posthog_…`, `sq_mixpanel_…`, `sq_amplitude_…`, `sq_smartlook_…`, `sq_replay_…`) and one API URL. Both are in the install snippet for your source on Settings › Setup. The keys are also on Settings › Keys. Sequential refuses a key of another source with 401 `unknown_ingest_key`.

Pendo is the exception: it uses your own Pendo API key. Register it in Settings › Keys › Pendo API key.

### Which key each SDK uses

Use the key of the SDK that sends the data:

| SDK that sends the data | Key |
|---|---|
| The Sequential SDK | `sq_sequential_…` |
| posthog-js and PostHog’s mobile SDKs (iOS, Android, React Native and Flutter) | `sq_posthog_…` |
| The Mixpanel SDK | `sq_mixpanel_…` |
| The Amplitude SDK | `sq_amplitude_…` |
| The Smartlook SDK | `sq_smartlook_…` |
| The recorder (`/rec/recorder.js`) | `sq_replay_…` |

From 6 November 2026, on Settings › Setup, a line under each key says which SDK it is for, for example "For PostHog SDKs: iOS, Android, React Native, Flutter, posthog-js." That page also says that mobile apps use the PostHog ingest key.

## What Sequential keeps from page URLs

The full rule, with examples: [What Sequential keeps from page URLs](/docs/url-policy).

> **Important**
>
> URLs your own code puts into event properties are cleaned the same way as page URLs only when they are complete `http(s)://` or `ws(s)://` addresses, so do not put secrets into event properties.

### How Sequential cleans page URLs

Before anything is stored, from every source: page URLs lose their `#fragment` (a hash route, such as `#/orders`, stays) and any `user:pass@` credentials, a secret in the path reads `[token]`, and every query-string value becomes `[redacted]` unless it is a marketing-attribution parameter (`utm_*`, `gclid`, `fbclid` and similar).

## What each SDK supports

Each SDK’s page explains every partial and missing capability, and [What each SDK supports](/docs/support-matrix) has all the notes in one place.

### Compare the SDKs

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

## Next steps

1. [Check that your install works](/docs/verify): see that events arrive.
2. [Identify your users](/docs/identify-users): tell the people in your app apart.
3. [Send custom events](/docs/custom-events): name the moments that matter.
4. [Quickstart: your first hour with Sequential](/docs/quickstart): from a new account to your first judged sessions.

> **Note**
>
> The PostHog, Mixpanel, Amplitude, Pendo and Smartlook SDKs are compatible with Sequential. Their makers do not endorse Sequential and are not affiliated with it.
