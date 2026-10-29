# Install the browser SDK with npm

> The npm package @usesequential/browser is the Sequential browser SDK for apps with a build step. It has the same code as the script tag: analytics and session replay from one init() call.

> **In short**
>
> - `@usesequential/browser` is the [Sequential SDK](/docs/sequential) as an npm package. Its code is the same as the code of the script tag.
> - Call `init()` one time, in the browser, with the project key and the API host.
> - Importing the package does nothing, so it is safe in apps that render on a server.
> - On one page, use the package or the script tag, not both.

## What it is for

Use the package when your app has a build step, for example Vite, webpack, Next.js or SvelteKit, and you want an import instead of a script tag. The package sends the same data as the tag: page views, clicks, form submits, rage clicks and dead clicks, custom events, `identify` and accounts. When session replay is on for the project, it loads the recorder from your API host, as the tag does.

## What it needs

- The project's **sequential** key (`sq_sequential_…`) and the API host. Copy both from the install snippet on Settings › Setup.
- A build tool that installs npm packages. The package has ES modules and CommonJS, each with types. It has no dependencies.

```bash
npm install @usesequential/browser
```

## Start it

Call `init()` one time, as early as possible, in code that runs in the browser:

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

- `init()` returns the SDK. It also sets `window.sequential` to the same object, so code that you wrote for the script tag works.
- **Server rendering.** Without a window, `init()` returns an object whose methods do nothing. Call it in code that runs in the browser: in SvelteKit in `onMount`, in Next.js in `useEffect` of a client component.
- **One time only.** A second `init()` returns the SDK that runs, and writes this warning: "[sequential] init() ran before on this page; the first instance is used and these options are not read."
- **Key and API host are necessary.** Without them, `init()` writes "[sequential] init() needs key (the sq_sequential_ key from Setup) and api (the ingest host); no events will be sent." It sends nothing.
- **With the script tag.** If the tag already loaded the SDK, `init()` returns that SDK, does not read its options and writes a warning. If the install snippet of the tag ran first, `init()` sends the calls that the snippet kept.

## Options

Each option does the same as an attribute of the script tag. See [Sequential SDK](/docs/sequential).

| Option | Tag attribute | What it does |
|---|---|---|
| `key` | `data-key` | Necessary. The project key. |
| `api` | `data-api` | Necessary. The API host. |
| `release` | `data-release` | Your app's build on every event: 1 to 64 printable ASCII characters. |
| `optOut: true` | `data-opt-out` | Every visitor starts opted out. |
| `autocapture: false` | `data-autocapture="false"` | No automatic page views, clicks, form submits, rage clicks or dead clicks. |
| `identityText: false` | `data-identity-text="off"` | Click text that names the signed-in person is no longer withheld. |
| `contextCookieDomain` | `data-context-cookie-domain` | `Domain=` for the context cookie `__sq_ctx`. |

## Consent

For a site that waits for consent, start every visitor opted out, and call `optIn()` when the visitor agrees:

```ts
const sequential = init({ key: 'sq_sequential_…', api: 'https://api.usesequential.com', optOut: true });

consentBanner.onAccept(() => sequential.optIn());
```

- Before opt-in, and while a visitor is opted out, the SDK stores no id, no session value and no cookie on the device. With `optOut: true`, it stores nothing.
- `optOut()` deletes the ids that the SDK stored. It keeps one key, `__sq_opt`, which holds only the visitor's choice, so the opt-out stays in force on the next pages. `optIn()` deletes it.

See [Privacy overview](/docs/privacy-overview) for the full consent steps.

## Methods and types

The methods are the same as with the script tag: `capture`, `identify`, `account`, `register`, `unregister`, `reset`, `optOut`, `optIn`, `captureException` and `flush`. See [Calling it from your code](/docs/sequential).

The package includes types. To type your own code, import them:

```ts
import type { Sequential, InitOptions } from '@usesequential/browser';
```

## Limits

- **Updates.** The script tag on the CDN gets each fix of the SDK at once. The package gets a fix only in a new version, so keep the package up to date.
- **Same data.** In Sequential, events from the package and events from the tag look the same.
- All limits of the [Sequential SDK](/docs/sequential) apply.
