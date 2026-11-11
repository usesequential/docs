# Send events from your server

> The backend SDK for Node sends your server's events and errors to Sequential with a server key.

> **At a glance**
>
> - **You get:** Events and errors on the same person as browser events, in the browser session when a browser request caused them.
> - **Works with:** Node 18 or later, with `@usesequential/node`. CommonJS and ES modules, with types.
> - **Key:** A server key (`sqs_…`), a secret. Owners and admins make it in Settings › Keys.
> - **Before you start:** The user ids that your browser code sends with `identify()` ([Identify your users](/docs/identify-users)). For the browser session: the Sequential SDK on your pages.
> - **Know this:** Send the user id that your browser code gives to `identify()`, and the browser context of the request: `contextFromRequest(req)`.
> - **Know this:** In a serverless function, call `await sequential.flush()` before it returns. On SIGTERM, `await sequential.shutdown()` sends the queued events.

> **In short**
>
> - A server error opens a [case](/docs/findings) from its first occurrence. The case shows "your server" in place of a page.
> - Server events do not use your sessions. The project's event rate limit counts them.

## Install the SDK

Install the package. It is `@usesequential/node` on npm, under the MIT licence.

```bash
npm install @usesequential/node
```

The package has no dependencies. Its source code is on GitHub: [usesequential/sequential-node](https://github.com/usesequential/sequential-node).

## Create a server key

A trial project cannot have server keys. Claim the project first.

> **A server key is a secret**
>
> A server key writes events as your project. Keep it in your secret store, never in a web page, a mobile app or a repository. Sequential refuses a server key in a request that has an `Origin` header, because a browser sends that header. If a key leaks, create a new key, deploy it, and [revoke the old one](#rotate-or-revoke-a-key).

1. (App) Go to **Settings › Keys**.

2. (App) Under Server keys, in **Make a server key**, enter where the key runs, for example "API on production". Use 1 to 80 characters.

3. (App) Click **Make key**.

   **If Sequential asks for a 2FA code**

   If your account has two-factor authentication (2FA), Sequential can ask for a code. Enter a code from your authenticator app, or a backup code. Then click **Continue**. The 2FA step does not ask if you entered a code in this sign-in in the last 15 minutes.

4. (App) Copy the key.

   Result: Sequential shows it one time only.

5. (Server) Keep the key in your server's environment, for example as `SEQUENTIAL_SERVER_KEY`.

6. (App) Click **I have copied it**.

Done when: the list shows the key by its label and as `sqs_…` with the last 4 characters.

A project can have at most 10 live server keys.

## Rotate or revoke a key

To rotate a key, create a new key, deploy it, then revoke the old one. Sequential does not revoke a key on its own. A revoke stops the key at once, and it cannot be undone.

1. (App) Next to the key, click **Revoke…**.

2. (App) Type the last 4 characters of the key.

3. (App) Click **Revoke server key**.

Result: From then on, Sequential refuses requests with that key with 401.

### How server keys work in detail

- The key starts with `sqs_`. It is not an ingest key.
- A server key is `sqs_` and 40 letters or digits. Sequential stores only a SHA-256 hash of it and its last 4 characters. So it cannot show the key again.
- The list also shows "Created <day> · Last used <time ago>", or "Last used never".
- A project can have at most 10 live server keys. At 10, Settings › Keys says "This project has 10 live server keys, the most it may have. Revoke one to make another."
- On a trial project, Settings › Keys says "A trial project cannot have server keys. Claim the project first."
- Members see the list. They cannot make or revoke keys. Viewers do not see the server keys.
- From 8 November 2026, Server keys on Settings › Keys starts with the line "A server key lets your own servers send events as this project, with the backend SDK." Rows follow the line. Secret says "Yes. Sequential shows it once, when it is made; then only its label and last 4 characters." "Lives in" says "Your server’s environment, never a page". "Managed by" says "Owners and admins make and revoke server keys. Members see each key’s label and last 4 characters; viewers do not." The old note is under "Read the full text ▾".
- The [Audit log](/docs/audit-log) records each new key and each revoked key, with its label and last 4 characters. It never records the key.
- The ingest key list of the project never shows a server key.
- Sequential refuses a server key in a request from a browser.
- When you click Revoke…, Sequential says: "Revoking stops this key at once: every server still sending with it is refused. It cannot be undone."
- After a revoke: if a Sequential server misses the revoke message, it refuses the key at most 60 seconds later.

## Send an event

Some facts are known only to your server: a payment that went through, an email that was sent, a job that failed. The browser cannot see them. Create the client with your server key, and send events with `track()`. This example is for Express:

```ts
import { SequentialServer, contextFromRequest } from '@usesequential/node';

const sequential = new SequentialServer({ secretKey: process.env.SEQUENTIAL_SERVER_KEY! });

app.post('/checkout', async (req, res) => {
  const order = await charge(req.body);
  sequential.track({
    event: 'order charged',
    userId: req.user?.id, // the id that your browser code sends with identify()
    context: contextFromRequest(req), // the browser session of this request
    props: { plan: order.plan, amount_eur: order.amount },
  });
  res.json(order);
});

process.on('SIGTERM', async () => {
  await sequential.shutdown(); // sends the events that are still in the queue
  process.exit(0);
});
```

| Field | What it is |
|---|---|
| `event` | The event name: 1 to 200 characters. It must not start with `$`. Use the naming rules of [Send custom events](/docs/custom-events). |
| `userId` | The id that your browser code sends with `identify()` |
| `context` | The browser context of the request, from `contextFromRequest(req)` |
| `accountId` | The id that your browser code sends with `account()` |
| `props` | Flat properties: ids, enums and counts. Sequential stores an object or an array as JSON text. Sequential stores a server event's `$release` as the event's release, not as a property. |
| `ts` | The time of the event. If you do not give it, the SDK uses the current time. |

Send `userId`, `context` or both: with neither, the SDK does not send the event.

- `track()` returns at once. The SDK sends the events in batches in the background.
- `track()` never throws. It returns `false` when it drops the event, and `stats` counts the reason.

### Serverless functions

A function can stop as soon as it answers. Call `await sequential.flush()` before it returns. If you do not, the events in the queue can be lost. The SDK's timer never keeps a process alive.

## How Sequential finds the person and the session

| You send | The event goes to |
|---|---|
| `userId` and `context` | That user, in that browser session |
| `userId` only, for example from a scheduled job or a queue worker | That user, in no session |
| `context` only: the visitor did not sign in | That visitor, in that session. When the visitor signs in, the event is on the user. |
| Neither | Nothing. The SDK does not send the event. |

When you send a `userId` and a `context`, Sequential keeps the session only when the context belongs to that user.

Right after a visitor calls `identify()`, Sequential cannot check this yet. It must first store that `identify()`, which can take about a minute. Until then, the event keeps the user but not the session, and `stats.context_dropped` counts it.

### How Sequential finds the person and the session in detail

- A visitor can change their own cookie. So Sequential drops a context that belongs to a different visitor. The event then stays on the user, in no session, and `stats.context_dropped` counts it.
- The context belongs to the user when its visitor id is the user id. It also belongs to the user when that visitor called `identify()` with the user id. After `identify()`, the cookie keeps the anonymous visitor id until the next page load.
- A context without a `userId` cannot be checked. Sequential accepts it and counts it in `stats.context_unverified`. This is not a refusal. The Refused line on Settings › Project does not show it.
- Sequential stores the key that it used as the event's user id. The person views find the person from it when they read, as for browser events. See [Identify your users](/docs/identify-users).
- A server event never identifies a person. Only the browser's `identify()` links a visitor to a user.
- Each server event has the property `$context`, which Sequential sets: `user_session`, `user`, `user_context_dropped` or `session_unverified`. Sequential drops a property named `$context` that you send.

## Where the context comes from

While the Sequential SDK records on your pages, it writes the cookie `__sq_ctx` on your own domain. The cookie goes to your backend with each request from your pages. `contextFromRequest(req)` reads it. It first reads the header `x-sequential-context`, and uses the cookie only when the header has no context.

| Your API | What to send |
|---|---|
| Is on a different site than your pages | The header, from your page. The cookie does not go to a different site. |
| Is on a different subdomain, for example pages on `www.shop.com` and the API on `api.shop.com` | The header, or add `data-context-cookie-domain="shop.com"` to the Sequential SDK's script tag. See [Sequential SDK](/docs/sequential). |
| Is called by a native app | The header. Its value is in [How the context cookie and header work in detail](#the-context-cookie-and-header-exact-behaviour). |

To send the header from your page, read the cookie, decode its value one time with `decodeURIComponent`, and send the result. For an API on a different origin, your API must allow the header `x-sequential-context` in its CORS answer.

### How the context cookie and header work in detail

- `contextFromRequest()` accepts a Node request (Express, `ctx.req` in Koa, `request.raw` in Fastify, plain `http`) and a Fetch API `Request` (Next.js route handlers, `c.req.raw` in Hono). It returns `null` when the request has no context.
- Only the Sequential SDK (sequential.js) writes the context cookie. With another browser SDK, send the user id only.
- The value is `v1;d=<visitor id>;s=<session id>`. Each id is URI-encoded. The header holds this value. The cookie holds it URI-encoded one more time, because a cookie value cannot hold `;`.
- The value has at most 600 characters: the browser SDK does not write a longer one, and it clears the cookie. `contextFromRequest()` reads only ids of at most 200 characters, and returns `null` otherwise.
- The cookie has `Path=/` and `SameSite=Lax`. It has `Secure` on an https page. It does not have `HttpOnly`, so your page can read it.
- It lasts 30 minutes, the time without activity after which a session ends.
- Without `data-context-cookie-domain`, the cookie goes only to the host of the page. The attribute accepts only letters, digits, `.` and `-`. For any other value, the SDK writes a host-only cookie and writes this error to the browser console: "data-context-cookie-domain is not a domain; the context cookie is host-only."
- Each tab has its own session, but all tabs share the cookie. So the tab that wrote last wins.
- After `identify()`, the cookie keeps the anonymous visitor id until the next page load. After a reload, it holds the stored id, which is the user id. If your app uses emails as user ids, the cookie then holds an email.

## Send an error

An error from your server, such as a 5xx that your API answered, can open a [case](/docs/findings), as a browser error can. It opens the case from its first occurrence. The case shows "your server" in place of a page.

```ts
// An exception that your code caught, for example a failed job or a failed payment.
try {
  await sendInvoice(order);
} catch (err) {
  sequential.captureError(err, { userId: order.userId, props: { job: 'invoice' } });
  throw err;
}

// A 5xx that your API answered. Send the route template, never the path with its ids.
app.use((req, res, next) => {
  res.on('finish', () => {
    sequential.captureHttpError({
      status: res.statusCode, // the SDK sends only 500-599
      method: req.method,
      route: req.route?.path ?? 'unknown',
      userId: req.user?.id,
      context: contextFromRequest(req),
    });
  });
  next();
});
```

- Send the route template, such as `/orders/:id`. Ids in the path make one problem into many cases.
- Sequential stores your error messages as you send them. Keep personal data out of them.

### How errors work in detail

- `captureError()` sends the error's name as its type, its message, and the first 20 lines of its stack.
- `captureHttpError()` sends only a status from 500 to 599. The type is `HTTP <status>`, for example `HTTP 502`. The message is the method and the route, for example `POST /orders/:id`.
- The SDK sends an error as the event `$exception`, with `$exception_type`, `$exception_message` and `$exception_stack`. The message has at most 2,000 characters. The stack has at most 8,000.
- A value that is not an `Error` becomes an `Error` with that text, or with "Non-Error value thrown".
- `captureHttpError()` without a route sends `(unknown route)`. For any status out of 500-599, it sends nothing and returns `false`.
- A case from a server error says "Opened from its first occurrence: an error from your server opens a case at once."
- An error without a browser session counts in the people and occurrences of its case, not in its sessions. The sample sessions of a case are browser sessions only. A case with only such errors shows "None from a server error." under Evidence.
- When all the occurrences of a case came from your server, the case shows "your server" in place of a page. From 25 October 2026, Sequential measures a release that names such a case by its occurrences and by the days on which your server sent events, not by sessions. See [Read the result](/docs/findings#read-the-result).

## Check it works

The person's page shows the events that your server sent for that person in the last 30 days. See also [Check that your install works](/docs/verify).

### On the person's page

The section "Backend activity, last 30 days" is at the bottom of the person's page. It has one row for each event name, or "Unnamed event", the most recent first. Each visit on the page also says how many server events it had, for example "3 server events".

- If the last 30 days have no server event, the section does not show.
- A person with only server events is not in People and not in the user counts.

### If events do not arrive

- With neither `userId` nor `context`, the SDK does not send the event. See [How Sequential finds the person and the session](#how-sequential-finds-the-person-and-the-session).
- A serverless function that returns before `await sequential.flush()` can lose the events in the queue. See [Serverless functions](#serverless-functions).
- If Sequential drops the context, the event is on the user but in no session, and `stats.context_dropped` counts it.

The SDK calls `onError` with a `SequentialError` for each drop: `reason`, `events` and `status`. The drop reasons in `onError` are `invalid_event`, `no_identity`, `queue_full`, `event_too_large`, `client_error` and `retries_exhausted`. The `stats` counters are in [All options and how delivery works](#delivery-exact-behaviour).

### Answers from Sequential

The SDK handles these answers. You see them in `onError` and `stats`.

| Answer | When |
|---|---|
| 400 `server_key_in_browser` | The request has an `Origin` header. |
| 400 `invalid_body` | The body has no `events` list. |
| 401 `invalid_server_key` | The key is not `sqs_` and 40 letters or digits, for example the browser write key. |
| 401 `unknown_ingest_key` | Sequential does not know the key, or the key is revoked. |
| 402 `billing_limit_reached` or `billing_required` | Billing blocks the organisation. The SDK drops the batch. See [Usage and limits](/docs/usage-and-limits). |
| 403 `trial_origin_locked` | The project is a trial project. |
| 413 `too_many_events` | The request has more than 500 events. A request also cannot be more than 1 MB. |
| 429 `rate_limited` | More than 50 requests a second with one key, or more than the project's event rate limit. The answer has `Retry-After`. |
| 503 `overloaded` or `auth_unavailable` | Sequential cannot take the request now. The SDK tries again. |

## What you see in Sequential

A server event is not a page view. It never makes a session, a user or a visitor.

### How server events show in Sequential in detail

- A server event has the class Custom. A server error has the class Error. See [Events](/docs/events).
- Funnels, flows and retention count them as events of the person who did them.
- Your usage counts sessions, so server events do not use your sessions. See [Usage and limits](/docs/usage-and-limits).
- The event rate limit of the project counts them: 20,000 events a minute for all the SDKs of the project together.
- Agents: `get_user_journey` gives `backend_events`, the names of the server events of that person. `list_errors` gives each error group a `source`: `browser`, `server` or `both`.
- From 2 November 2026, Backend activity starts, for example, "Your server sent 312 events of 4 kinds for Amara Mensah with the backend SDK." "All 312 events" opens Workbench › Events with the person's events from your server.
- The section shows at most 20 kinds, and "Showing 20 of 26 kinds" when there are more.
- Each row shows the count in the last 30 days, a bar for each UTC day, and how long ago the latest one happened. "Latest ›" shows the latest event as JSON.
- Under the name, "Latest:" shows up to 2 text properties of the latest event, in the order of their keys, for example "Latest: currency: EUR · plan: pro". The value of a key that names a secret, such as a key that ends in `token`, `secret`, `key`, `password` or `auth`, shows as `[token]`. In other values, a part that looks like a secret shows as `[token]`. Sequential cuts a key at 40 characters and a value at 60. Your team sees these values, so send only the properties that your team may see.

## Privacy

- Server events store no browser, device, IP address, country or URL. Those would be your server's, shown as the user's.
- Send ids, enums and counts as properties. Do not send names, emails or text that people typed.
- Some property names mean the text of a page element, in any letter case: for example `text`, `form`, `selector`, `element`, `element_text`, `aria_label`, and names that start with `$el_` or `$element`. In such a property, Sequential stores an email, a card number, a JWT or a Bearer or Basic credential as `[redacted]`. This is the same rule as for element text from the browser. Error messages are not in this rule. See [Privacy at a glance](/docs/privacy-overview#what-sequential-removes-automatically).
- The cookie `__sq_ctx` is an analytics cookie. List it with your analytics cookies in your consent banner. See [Privacy at a glance](/docs/privacy-overview).

## Options

Only `secretKey` is required. The other options set batching, retries, `host`, `release`, `disabled` (for example in tests), `onError` and `fetch`. [All options and how delivery works](#delivery-exact-behaviour) lists them all.

### All options and how delivery works

| Option | Default | What it does |
|---|---|---|
| `secretKey` | Required | The server key, `sqs_…` |
| `host` | `https://api.usesequential.com` | The Sequential API. The SDK sends to `<host>/i/v1/server`. |
| `flushAt` | 100, at most 500 | The SDK sends a batch when this many events are in the queue. |
| `flushIntervalMs` | 1000 | The SDK sends the queue at least this often, in milliseconds. |
| `maxBatchBytes` | 512 kB, at most 1 MB | The largest request. The SDK drops one event that is larger. |
| `maxQueue` | 10,000 | The most events in memory. The SDK drops new events above it. |
| `maxRetries` | 3 | The retries after a 5xx or a network error that came without `Retry-After` |
| `maxRetryMs` | 300,000 | How long the SDK keeps a batch while Sequential answers 429 or 503 with `Retry-After`: 5 minutes from the first failure of the batch (from version 1.0.3) |
| `release` | None | The build that your server runs, for example `'backend@' + process.env.GIT_SHA`. The SDK sends it as `$release` on every event, errors included (from version 1.0.4). It must have 1 to 64 printable ASCII characters after trim. The SDK does not send any other value, or a placeholder such as `undefined`, `null`, `none` or `(null)`. An event's own `$release` property wins. |
| `disabled` | `false` | Send nothing, for example in tests. `track()` still checks and counts. |
| `onError` | None | The SDK calls it with a `SequentialError` for each drop: `reason`, `events` and `status`. |
| `fetch` | The global `fetch` | Your own `fetch` |

A number option that is not a finite number, for example `Number(process.env.UNSET)`, takes its default.

- `new SequentialServer()` throws an error when the key is not `sqs_` and 40 letters or digits. The error message does not show the value. It also throws when there is no `fetch`: use Node 18 or later, or give `fetch`.
- On a 429, or on a 503 with `Retry-After`, the SDK waits for the `Retry-After` time, at most 60 seconds each time. Then it sends the batch again. Sequential answers `503 overloaded` when it sheds load, or when its database is unavailable for a short time. The SDK keeps the batch for up to `maxRetryMs` (5 minutes) after the first failure of the batch. Then it drops the batch (`retries_exhausted`). These waits do not count against `maxRetries`. Before version 1.0.3, the SDK sent a batch again after a 503 as after any 5xx, and dropped it after about 1.5 seconds.
- On any other 5xx, on a 429 or 503 without `Retry-After`, or on a network error, it waits about 200 ms, then about 400 ms, and so on, at most about 30 seconds. It sends the batch again at most `maxRetries` times, so 4 times in all with the default.
- On any other 4xx, it drops the batch. This includes a revoked key (401) and a billing block (402).
- If the SDK sends a batch again after its first attempt was stored (a timeout, or a retry after an error), Sequential stores it only once: each event carries its own `uuid`. This is so from 23 October 2026. From 21 to 23 October 2026, a retried batch was stored again and counted twice.
- `track()` makes the JSON of the event at once. If a property cannot be JSON, for example a `BigInt` or an object that refers to itself, the SDK drops the event. A later change to the property object does not change the event in the queue.
- An id (`userId`, `accountId` or an id of the context) of more than 200 characters drops the event.
- `stats` counts: `queued`, `sent`, `batches`, `retries`, `http429`, `dropped_invalid`, `dropped_no_identity`, `dropped_queue_full`, `dropped_too_large`, `dropped_client_error`, `dropped_after_retries`, `context_dropped` and `context_unverified`.
- A throw in `onError` does not reach your code.
- The SDK sends `authorization: Bearer <key>` and the user agent `sequential-node/<version>`.
- A 200 answer means that Sequential accepted the request. The body gives `events_ingested`, `context_dropped`, `context_unverified`, `dropped_no_identity` and `dropped_invalid`.
- Sequential drops an event with a name that is not valid, or with an id of more than 200 characters. It counts it in `dropped_invalid`. Of the names that start with `$`, it accepts only `$exception`.
- The list of allowed origins of the project does not apply to server events.
- Sequential does not refuse server HTTP clients, such as node-fetch, axios or curl, on this route.
- If the store that counts the 50 requests a second is unavailable, Sequential accepts the request.

## Command line

From version 1.1.0, the package also installs the command `sequential`, for example for a deploy step. It records changes and release markers with a project access token (`sq_pat_…`), not with a server key.

### The sequential command: commands, tokens and options

| Command | What it does | Token |
|---|---|---|
| `sequential changes record` | Records one change on Changes. It needs `--kind` and `--title`. | `SEQUENTIAL_TOKEN`, with `changes:write` |
| `sequential changes sync` | Records 1 to 100 changes in one request, from a JSON array in a file or on stdin: `--items <file>` or `--items -`. Use it once for each CI run. | `SEQUENTIAL_TOKEN`, with `changes:write` |
| `sequential releases record` | Records a release marker. Sequential measures fixes against it. It needs `--version`. | `SEQUENTIAL_RELEASES_TOKEN`, with `releases:write` |

- Each token is a project access token (`sq_pat_…`). The command reads it only from its environment variable, and never prints it. A server key (`sqs_…`) is refused. From version 1.2.0, the command does not follow a redirect, so the token never goes to another host.
- The command sends to `https://api.usesequential.com`. `--host` changes that. It must use `https://`. Only `localhost`, `127.0.0.1` and `[::1]` can use `http://`.
- `--dry-run` shows what the command would send, and sends nothing. `--help` shows every option.
- `changes record`: `--kind` is `release`, `product`, `pricing`, `marketing`, `incident`, `company`, `external` or `tracking`. `--title` is one line, at most 140 characters. With the same `--external-id`, a second run finds the same change.
- `changes sync`: each item needs `kind` and `title`. It can have the other fields of `changes record`, with their JSON names, such as `external_id`, `links` and `start`. More than 100 items are refused. `--source` names the source of each item that names none. The default is `ci`. `--covered-from` and `--covered-through` give the time that the run covers, so that no change in that time means that nothing happened. With `--atomic`, Sequential writes nothing if it refuses one item.
- A change of the kind `release` is not a release marker. To have Sequential measure fixes, also run `sequential releases record`. An owner or an admin can also click The fix is live on the case page.
- `releases record`: `--version` is the release exactly as your browser SDK sends it. The other options are `--environment`, `--commit-sha`, `--released-at` and `--finding F-12`. You can give `--finding` up to 50 times. For a release that also reads your pull requests from GitHub, see [The sequential-release command](/docs/findings#the-sequential-release-command).
- The exit code is 0 when Sequential recorded it, or for a dry run. It is 1 when Sequential refused it or could not be reached, and 2 for a mistake in the command. For `changes sync`, it is 3 when Sequential refused some items. Each refused item is printed with its reason.

From 7 November 2026, the [Sequential CLI](/docs/cli) (`npx @usesequential/cli`) also has these commands, with more options: for example, `releases record` can read the merged pull requests from GitHub.

From version 1.2.0 (7 November 2026), the commands of this package moved to the Sequential CLI. They continue to work here. When you run one, it first writes this line to stderr, then runs the command as before:

```text
sequential: these commands moved to the Sequential CLI (npx @usesequential/cli); they leave @usesequential/node in 2.0.
```

The commands leave this package in version 2.0. For a new deploy step, use the Sequential CLI.

## Not in this version

- Node is the only backend SDK.
- A server event cannot identify a person.

## Next steps

- [Identify your users](/docs/identify-users): the user ids that your browser code sends.
- [Send custom events](/docs/custom-events): name your events.
- [Cases](/docs/findings): what a case shows and how a fix is measured.
- [Sequential SDK](/docs/sequential): the browser SDK that writes the context cookie.
- [Limits](/docs/limits): the request and event limits.
