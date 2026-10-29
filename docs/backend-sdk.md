# Send events from your server

> The backend SDK for Node sends your server's events and errors to Sequential with a server key. They go to the same person as the browser events, and into the browser session when a browser request caused them.

> **In short**
>
> - The backend SDK `@usesequential/node` sends events and errors from your Node server.
> - It sends with a **server key**. A server key is a secret. Never put it in a web page or a mobile app.
> - Send the user id that your browser code gives to `identify()`. Sequential then puts the event on the same person.
> - Also send the browser context of the request. Sequential then also puts the event in that browser session.
> - An error that your server sends can open a case, as a browser error can. The case shows "your server" in place of a page.

## What it is for

Some facts are known only to your server: a payment that went through, an email that was sent, a job that failed. The browser cannot see them. The backend SDK sends them to Sequential.

- The person's page shows them in **Backend activity, last 30 days**.
- A server event that a browser request caused is in that browser session too.
- An error from your server, such as a 5xx that your API answered, can open a [case](/docs/findings).

## What it needs

- Node 18 or later. The package has no dependencies. It supports CommonJS and ES modules, and it includes types.
- A server key for the project. Owners and admins make server keys.
- The user ids that your browser code sends with `identify()`. See [Identify your users](/docs/identify-users).
- For the browser session: the Sequential SDK (sequential.js) on your pages. Only that SDK writes the context cookie. With another browser SDK, send the user id only.

## Create a server key

You must be an owner or admin. A trial project cannot have server keys.

1. Go to Settings › Keys.
2. Under **Server keys**, in **Make a server key**, type where the key runs, for example "API on production". Use 1 to 80 characters.
3. Select **Make key**.
4. If your account has two-factor authentication (2FA), Sequential can ask for a code. Enter a code from your authenticator app, or a backup code. Then select **Continue**.
5. Copy the key. Sequential shows it one time only.
6. Keep the key in your server's environment, for example as `SEQUENTIAL_SERVER_KEY`. Then select **I have copied it**.

The key starts with `sqs_`. It is not an ingest key. Sequential refuses a server key in a request from a browser. A project can have at most 10 live server keys.

### Server keys: exact behaviour

- A server key is `sqs_` and 40 letters or digits. Sequential stores only a SHA-256 hash of it and its last 4 characters. So it cannot show the key again.
- The list shows each key by its label and as `sqs_…` with the last 4 characters. It also shows "Created <day> · Last used <time ago>", or "Last used never".
- A project can have at most 10 live server keys. At 10, Settings › Keys says "This project has 10 live server keys, the most it may have. Revoke one to make another."
- A trial project cannot have server keys. Settings › Keys says "A trial project cannot have server keys. Claim the project first."
- Members see the list. They cannot make or revoke keys. Viewers do not see the server keys.
- The 2FA step: Sequential asks for a code from your authenticator app, or a backup code, when your account has 2FA. It does not ask if you entered a code in this sign-in in the last 15 minutes.
- The [Audit log](/docs/audit-log) records each new key and each revoked key, with its label and last 4 characters. It never records the key.
- The ingest key list of the project never shows a server key.

### Rotate or revoke a key

To rotate a key, create a new key, deploy it, then revoke the old one. Sequential does not revoke a key on its own.

To revoke a key, select **Revoke…** next to it. Sequential says: "Revoking stops this key at once: every server still sending with it is refused. It cannot be undone." Type the last 4 characters of the key. Then select **Revoke server key**. From then on, Sequential refuses requests with that key with 401. If a Sequential server misses the revoke message, it refuses the key at most 60 seconds later.

## Install the SDK

The package is `@usesequential/node` on npm, under the MIT licence. Its source code is on GitHub: [usesequential/sequential-node](https://github.com/usesequential/sequential-node).

```bash
npm install @usesequential/node
```

## Send an event

This example is for Express. `track()` returns at once. The SDK sends the events in batches in the background.

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

- `event` is the event name: 1 to 200 characters. It must not start with `$`. Use the naming rules of [Send custom events](/docs/custom-events).
- `userId` is the id that your browser code sends with `identify()`. `accountId` is the id that it sends with `account()`.
- `props` are flat properties: ids, enums and counts. Sequential stores an object or an array as JSON text.
- Sequential stores a server event's `$release` as the event's release, not as a property.
- `ts` is the time of the event. If you do not give it, the SDK uses the current time.
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

When you send a `userId` and a `context`, Sequential keeps the session only when the context belongs to that user. A visitor can change their own cookie. So Sequential drops a context that belongs to a different visitor. The event then stays on the user, in no session, and `stats.context_dropped` counts it.

### The person and the session: exact behaviour

- The context belongs to the user when its visitor id is the user id. It also belongs to the user when that visitor called `identify()` with the user id. Sequential can check this only after it has stored that `identify()`, which can take about a minute. Until then, the event keeps the user but not the session, and `stats.context_dropped` counts it. After `identify()`, the cookie keeps the anonymous visitor id until the next page load.
- A context without a `userId` cannot be checked. Sequential accepts it and counts it in `stats.context_unverified`. This is not a refusal. The **Refused** line on Settings › Project does not show it.
- Sequential stores the key that it used as the event's user id. The person views find the person from it when they read, as for browser events. See [Identify your users](/docs/identify-users).
- A server event never identifies a person. Only the browser's `identify()` links a visitor to a user.
- Each server event has the property `$context`, which Sequential sets: `user_session`, `user`, `user_context_dropped` or `session_unverified`. Sequential drops a property named `$context` that you send.

## Where the context comes from

While the Sequential SDK records on your pages, it writes the cookie `__sq_ctx` on your own domain. The cookie goes to your backend with each request from your pages. `contextFromRequest(req)` reads it. It first reads the header `x-sequential-context`, and uses the cookie only when the header has no context.

- **Your API is on a different site than your pages.** The cookie does not go to a different site. Send the header from your page.
- **Your API is on a different subdomain,** for example pages on `www.shop.com` and the API on `api.shop.com`. Send the header, or add `data-context-cookie-domain="shop.com"` to the Sequential SDK's script tag. See [Sequential SDK](/docs/sequential).
- **A native app calls your API.** Send the header.

`contextFromRequest()` accepts a Node request (Express, `ctx.req` in Koa, `request.raw` in Fastify, plain `http`) and a Fetch API `Request` (Next.js route handlers, `c.req.raw` in Hono). It returns `null` when the request has no context.

### The context cookie and header: exact behaviour

- The value is `v1;d=<visitor id>;s=<session id>`. Each id is URI-encoded. The header holds this value. The cookie holds it URI-encoded one more time, because a cookie value cannot hold `;`.
- The value has at most 600 characters: the browser SDK does not write a longer one, and it clears the cookie. `contextFromRequest()` reads only ids of at most 200 characters, and returns `null` otherwise.
- The cookie has `Path=/` and `SameSite=Lax`. It has `Secure` on an https page. It does not have `HttpOnly`, so your page can read it.
- It lasts 30 minutes, the time without activity after which a session ends.
- Without `data-context-cookie-domain`, the cookie goes only to the host of the page. The attribute accepts only letters, digits, `.` and `-`. For any other value, the SDK writes a host-only cookie and writes this error to the browser console: "data-context-cookie-domain is not a domain; the context cookie is host-only."
- To send the header from your page, read the cookie, decode its value one time with `decodeURIComponent`, and send the result. For an API on a different origin, your API must allow the header `x-sequential-context` in its CORS answer.
- Each tab has its own session, but all tabs share the cookie. So the tab that wrote last wins.
- After `identify()`, the cookie keeps the anonymous visitor id until the next page load. After a reload, it holds the stored id, which is the user id. If your app uses emails as user ids, the cookie then holds an email.

## Send an error

An error from your server can open a [case](/docs/findings), as a browser error can. The case shows "your server" in place of a page.

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

- `captureError()` sends the error's name as its type, its message, and the first 20 lines of its stack.
- `captureHttpError()` sends only a status from 500 to 599. The type is `HTTP <status>`, for example `HTTP 502`. The message is the method and the route, for example `POST /orders/:id`.
- Send the route template, such as `/orders/:id`. Ids in the path make one problem into many cases.
- Sequential stores your error messages as you send them. Keep personal data out of them.

### Errors: exact behaviour

- The SDK sends an error as the event `$exception`, with `$exception_type`, `$exception_message` and `$exception_stack`. The message has at most 2,000 characters. The stack has at most 8,000.
- A value that is not an `Error` becomes an `Error` with that text, or with "Non-Error value thrown".
- `captureHttpError()` without a route sends `(unknown route)`. For any status out of 500-599, it sends nothing and returns `false`.
- An error from your server opens a case from its first occurrence. The case says "Opened from its first occurrence: an error from your server opens a case at once."
- An error without a browser session counts in the people and occurrences of its case, not in its sessions. The sample sessions of a case are browser sessions only. A case with only such errors shows "None from a server error." under **Evidence**.
- When all the occurrences of a case came from your server, the case shows "your server" in place of a page. From 25 October 2026, Sequential measures a release that names such a case by its occurrences and by the days on which your server sent events, not by sessions. See [Read the result](/docs/findings#read-the-result).

## Options

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

### Delivery: exact behaviour

- `new SequentialServer()` throws an error when the key is not `sqs_` and 40 letters or digits. The error message does not show the value. It also throws when there is no `fetch`: use Node 18 or later, or give `fetch`.
- On a 429, or on a 503 with `Retry-After`, the SDK waits for the `Retry-After` time, at most 60 seconds each time. Then it sends the batch again. Sequential answers `503 overloaded` when it sheds load, or when its database is unavailable for a short time. The SDK keeps the batch for up to `maxRetryMs` (5 minutes) after the first failure of the batch. Then it drops the batch (`retries_exhausted`). These waits do not count against `maxRetries`. Before version 1.0.3, the SDK sent a batch again after a 503 as after any 5xx, and dropped it after about 1.5 seconds.
- On any other 5xx, on a 429 or 503 without `Retry-After`, or on a network error, it waits about 200 ms, then about 400 ms, and so on, at most about 30 seconds. It sends the batch again at most `maxRetries` times, so 4 times in all with the default.
- On any other 4xx, it drops the batch. This includes a revoked key (401) and a billing block (402).
- If the SDK sends a batch again after its first attempt was stored (a timeout, or a retry after an error), Sequential stores it only once: each event carries its own `uuid`. This is so from 23 October 2026. From 21 to 23 October 2026, a retried batch was stored again and counted twice.
- `track()` makes the JSON of the event at once. If a property cannot be JSON, for example a `BigInt` or an object that refers to itself, the SDK drops the event. A later change to the property object does not change the event in the queue.
- An id (`userId`, `accountId` or an id of the context) of more than 200 characters drops the event.
- `stats` counts: `queued`, `sent`, `batches`, `retries`, `http429`, `dropped_invalid`, `dropped_no_identity`, `dropped_queue_full`, `dropped_too_large`, `dropped_client_error`, `dropped_after_retries`, `context_dropped` and `context_unverified`.
- The drop reasons in `onError` are `invalid_event`, `no_identity`, `queue_full`, `event_too_large`, `client_error` and `retries_exhausted`. A throw in `onError` does not reach your code.
- The SDK sends `authorization: Bearer <key>` and the user agent `sequential-node/<version>`.

## What server events count as

- A server event has the class **Custom**. A server error has the class **Error**. See [Events](/docs/events).
- A server event is not a page view. It never makes a session, a user or a visitor. A person with only server events is not in **People** and not in the user counts.
- Your usage counts sessions, so server events do not use your sessions. See [Usage and limits](/docs/usage-and-limits).
- The event rate limit of the project counts them: 20,000 events a minute for all the SDKs of the project together.
- Funnels, flows and retention count them as events of the person who did them.
- Agents: `get_user_journey` gives `backend_events`, the names of the server events of that person. `list_errors` gives each error group a `source`: `browser`, `server` or `both`.

## On the person's page

The person's page shows **Backend activity, last 30 days**: "Events your server sent with the backend SDK."

- Each row shows the event name, or "Unnamed event", and how long ago it happened. When the event joined a browser session, the row has **in a visit**, which opens that session.
- The rows are from the last 30 days, newest first. The section shows at most 20, and "Showing 20 of N" when there are more.
- The section shows only names, never property values.
- If the last 30 days have no server event, the section does not show.

> **A server key is a secret**
>
> A server key writes events as your project. Keep it in your secret store, never in a web page, a mobile app or a repository. Sequential refuses a server key in a request that has an `Origin` header, because a browser sends that header. If a key leaks, create a new key, deploy it, and revoke the old one.

## Privacy

- Server events store no browser, device, IP address, country or URL. Those would be your server's, shown as the user's.
- Send ids, enums and counts as properties. Do not send names, emails or text that people typed.
- Some property names mean the text of a page element, in any letter case: for example `text`, `form`, `selector`, `element`, `element_text`, `aria_label`, and names that start with `$el_` or `$element`. In such a property, Sequential stores an email, a card number, a JWT or a Bearer or Basic credential as `[redacted]`. This is the same rule as for element text from the browser. Error messages are not in this rule. See [Privacy at a glance](/docs/privacy-overview#what-sequential-removes-automatically).
- The cookie `__sq_ctx` is an analytics cookie. List it with your analytics cookies in your consent banner. See [Privacy at a glance](/docs/privacy-overview).

### Answers from Sequential

The SDK handles these answers. You see them in `onError` and `stats`.

| Answer | When |
|---|---|
| 200 | Sequential accepted the request. The body gives `events_ingested`, `context_dropped`, `context_unverified`, `dropped_no_identity` and `dropped_invalid`. |
| 400 `server_key_in_browser` | The request has an `Origin` header. |
| 400 `invalid_body` | The body has no `events` list. |
| 401 `invalid_server_key` | The key is not `sqs_` and 40 letters or digits, for example the browser write key. |
| 401 `unknown_ingest_key` | Sequential does not know the key, or the key is revoked. |
| 402 `billing_limit_reached` or `billing_required` | Billing blocks the organisation. The SDK drops the batch. |
| 403 `trial_origin_locked` | The project is a trial project. |
| 413 `too_many_events` | The request has more than 500 events. A request also cannot be more than 1 MB. |
| 429 `rate_limited` | More than 50 requests a second with one key, or more than the project's event rate limit. The answer has `Retry-After`. |
| 503 `overloaded` or `auth_unavailable` | Sequential cannot take the request now. The SDK tries again. |

- Sequential drops an event with a name that is not valid, or with an id of more than 200 characters. It counts it in `dropped_invalid`. Of the names that start with `$`, it accepts only `$exception`.
- The list of allowed origins of the project does not apply to server events.
- Sequential does not refuse server HTTP clients, such as node-fetch, axios or curl, on this route.
- If the store that counts the 50 requests a second is unavailable, Sequential accepts the request.

## Not in this version

- Node is the only backend SDK.
- A server event cannot identify a person.

## Related

- [Identify your users](/docs/identify-users)
- [Send custom events](/docs/custom-events)
- [Cases](/docs/findings)
- [Sequential SDK](/docs/sequential)
- [Limits](/docs/limits)
