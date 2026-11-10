# Install the browser SDK with npm

> Install @usesequential/browser, the Sequential SDK as an npm package, in an app with a build step. One init() call gives you analytics and session replay.

> **At a glance**
>
> - **Works with:** Apps with a build step, for example Vite, webpack, Next.js or SvelteKit, and a build tool that installs npm packages.
> - **You get:** An import instead of a script tag. Same code as the tag; all limits of the [Sequential SDK](/docs/sequential) apply.
> - **Key:** The project's Sequential ingest key (`sq_sequential_…`) and the API URL, from Settings › Setup.
> - **Know this:** On one page, use the package or the script tag, not both.
> - **Know this:** The package gets a fix only in a new version, so keep the package up to date.

## Install

1. Copy the Sequential ingest key (`sq_sequential_…`) and the API URL from the install snippet on **Settings › Setup**.

2. Install the package `@usesequential/browser`.

3. Call `init()` one time, as early as possible, in code that runs in the browser (see [Call init() in a server-rendered app](#call-init-in-a-server-rendered-app)).

   **If the script tag is also on the page**

   If both are on the page, this happens:

   - If the tag already loaded the SDK, `init()` returns that SDK, does not read its options and writes a warning.
   - If the install snippet of the tag ran first, `init()` sends the calls that the snippet kept.

Step 2:

```bash
npm install @usesequential/browser
```

Step 3:

```ts
import { init } from '@usesequential/browser';

const sequential = init({
  key: 'sq_sequential_…',
  api: 'https://api.usesequential.com',
  release: 'web@2.14.1', // optional: your app's build, on every event
});

sequential.identify(user.id, { email: user.email });
sequential.capture('checkout_started', { plan: 'pro' });
```

## Call init() in a server-rendered app

Importing the package does nothing, so it is safe in apps that render on a server. Without a window, `init()` returns an object whose methods do nothing. Call it in code that runs in the browser: in SvelteKit in `onMount`, in Next.js in `useEffect` of a client component.

`init()` returns the SDK. It also sets `window.sequential` to the same object, so code that you wrote for the script tag works.

## Check it works

To check your install, see [Check that your install works](/docs/verify).

If you see a `[sequential]` message, find it in this table:

| Message | Where | What it means | What to do |
|---|---|---|---|
| "[sequential] init() ran before on this page; the first instance is used and these options are not read." | — | One time only. A second `init()` returns the SDK that runs, and writes this warning. | Call `init()` one time. |
| "[sequential] init() needs key (the sq_sequential_ key from Setup) and api (the ingest host); no events will be sent." | — | Key and API URL ("ingest host" in this message) are necessary. Without them, `init()` writes this line. It sends nothing. | Copy both from the install snippet on Settings › Setup. |

For the script tag warning, see [If the script tag is also on the page](#if-the-script-tag-is-also-on-the-page).

## Options

Each option does the same as a tag attribute of the [Sequential SDK](/docs/sequential).

### All options and their tag attributes

| Option | Tag attribute | What it does |
|---|---|---|
| `key` | `data-key` | Necessary. The Sequential ingest key. |
| `api` | `data-api` | Necessary. The API URL. |
| `release` | `data-release` | Your app's build on every event: 1 to 64 printable ASCII characters. |
| `optOut: true` | `data-opt-out` | Every visitor starts opted out. |
| `autocapture: false` | `data-autocapture="false"` | No automatic page views, clicks, form submits, rage clicks or dead clicks. |
| `identityText: false` | `data-identity-text="off"` | Click text that names the signed-in person is no longer withheld. Without this option, that text is withheld. |
| `contextCookieDomain` | `data-context-cookie-domain` | `Domain=` for the context cookie `__sq_ctx`. |

## Consent

For a site that waits for consent, start every visitor opted out, and call `optIn()` when the visitor agrees:

```ts
const sequential = init({ key: 'sq_sequential_…', api: 'https://api.usesequential.com', optOut: true });

consentBanner.onAccept(() => sequential.optIn());
```

- Before opt-in, and while a visitor is opted out, the SDK stores no id, no session value and no cookie on the device. With the option `optOut: true`, it stores nothing.
- The method `optOut()` deletes the ids that the SDK stored. It keeps one key, `__sq_opt`, which holds only the visitor's choice, so the opt-out stays in force on the next pages. `optIn()` deletes it.

The option `optOut: true` does the same as the tag attribute `data-opt-out`: see [Consent in the Sequential SDK](/docs/sequential#consent).

See [Privacy overview](/docs/privacy-overview) for the full consent steps.

## Methods and types

The methods are the same as with the script tag: `capture`, `identify`, `account`, `register`, `unregister`, `reset`, `optOut`, `optIn`, `captureException` and `flush`. See [Calling it from your code](/docs/sequential).

The package has ES modules and CommonJS, each with types. It has no dependencies. To type your own code, import the types:

```ts
import type { Sequential, InitOptions } from '@usesequential/browser';
```

## FAQ

### How does the package compare with the script tag?

The package sends the same data as the [script tag](/docs/sequential): page views, clicks, form submits, rage clicks and dead clicks, custom events, `identify` and accounts. In Sequential, events from the package and events from the tag look the same. When session replay is on for the project, the package loads the recorder from your API URL, as the tag does. The script tag on the CDN gets each fix of the SDK at once.

## Next steps

- [Identify your users](/docs/identify-users): tell Sequential who each person is.
- [Send custom events](/docs/custom-events): name the actions that matter in your app.
