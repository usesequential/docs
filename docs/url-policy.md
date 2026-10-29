# What Sequential keeps from page URLs

> Before it stores an event, Sequential cleans the page URL and referrer. It keeps the host, path and attribution parameters, and redacts other query values.

> **In short**
>
> - Sequential cleans the page URL and the referrer of every event before it stores them. You do not set anything up, and you cannot turn it off.
> - It keeps the scheme, the host, the path and a fixed list of attribution parameters: campaign labels and ad-click ids.
> - It replaces every other query value with `[redacted]`, and drops the `#fragment`. Sequential drops the whole `user:pass@` part of a URL. From 27 October 2026, this also holds when the password contains an `@`. From 9 October 2026, it keeps a hash route, such as `#/orders`. See **Hash routes** below.
> - From 11 October 2026, it stores a secret in the path or the hash route as `[token]`, such as the token in a sign-in link. See **Secrets** below.
> - This cleaning does **not** apply to web recordings, except the `[token]` rule for the page address. Masking decides what a recording keeps of the page URL. See **Page URLs in recordings**, below.
> - Sequential does not clean events that it stored earlier.

## What it is for

A page URL can carry the campaign that brought a visitor to you. It can also carry a password-reset token, an email address or a session id. Sequential keeps the first kind of value and redacts the second.

The rule is **whether a value identifies a real person**. Campaign labels and ad-click ids tell you where visitors come from, not who they are. This page calls their parameters the attribution parameters.

## What Sequential keeps and drops

| Part of the URL | What Sequential stores |
|---|---|
| Scheme, host and path | Kept |
| An attribution parameter | Kept, unless the value looks like a personal identifier |
| Every other query value | `[redacted]`. The parameter name stays, so you can see which parameters a URL carried |
| The `#fragment` | Dropped, except a hash route (from 9 October 2026) |
| `user:pass@` credentials | Dropped. From 27 October 2026, also when the password contains an `@` |
| A path segment that is an email address, JWT or card number | `[redacted]` |
| A secret in the path or the hash route (from 11 October 2026) | `[token]` |

The attribution parameters are the standard `utm_*` campaign parameters, Mailchimp's `mc_cid` and the click ids of the main ad platforms. The list is the same for every project. You cannot add to it.

## Hash routes

From 9 October 2026, Sequential keeps the route of a hash-routed page in the stored URL, for example `https://example.com/app#/orders`.

- It keeps a fragment only when it starts with `#/` or `#!/`, and only up to its first `?`, `&` or a second `#`. It still drops every other fragment, such as `#features` or `#access_token=…`.
- It cleans each part of the route between slashes like a path segment: an email address, a JWT or a card number becomes `[redacted]`.
- It drops a route of more than 512 characters whole.
- This applies to SDKs that send the full page address, such as PostHog, and to URLs in properties. The Sequential SDK sends the route too, from 9 October 2026.
- Events stored before 9 October 2026 keep their URL without the route.
- A filter or a funnel step with **URL** **is** `https://example.com/app` does not find the later events of a page that has a route. Pick the URL with the route from the value list.
- From 9 October 2026, the **Rage & dead clicks** tile on the **Brief** shows the pages of a hash-routed app one route at a time, for example `/app#/orders/:id`. In Workbench › **Sessions**, so do **Entry page** and the count in **Pages**. A bare `#/` or `#!/` is the same page as the address without it.
- Cases, their verification and the AI judge still group pages by the path, without the route. So do the session summaries that agents get from `get_session` and `get_session_full`. See [Cases and fixes](/docs/findings).

## Secrets

From 11 October 2026, Sequential stores a secret in a link as `[token]`, for new data. It uses the same rule as for the text that an agent receives. See [Privacy at a glance](/docs/privacy-overview#secrets-in-links).

- It applies the rule to the path, to the hash route and to each query value that is not an attribution value. The host and the attribution values, such as `gclid`, stay.
- It applies the rule to the page URL and the referrer of an event, to a property value that is a URL, and to a property value that starts with `/`, such as `$pathname`.
- It applies the rule to the page address of a web or mobile recording, with every masking setting, and to the page of a JavaScript error or a failed request.
- Data that Sequential stored before 11 October 2026 keeps its secrets.

## Where it applies

- **Every source.** Sequential cleans the page URL and referrer in the same way for the [Sequential SDK](/docs/sequential) and every vendor SDK. See "Sources and properties" below.
- **Some properties.** Sequential cleans a URL in a property only when the value starts with `http://`, `https://`, `ws://` or `wss://`.
- **Only partly in the browser.** The Sequential SDK does only part of the cleaning before it sends. So a URL is never a safe place for a secret.

## Examples

| Sent | Stored |
|---|---|
| `/checkout?utm_source=newsletter&gclid=Cj0KCQjw` | Unchanged |
| `/reset?token=eyJhbGci…&email=jane@example.com` | `/reset?token=[redacted]&email=[redacted]` |
| `/search?q=blue+shoes&page=2` | `/search?q=[redacted]&page=[redacted]` |
| `https://admin:hunter2@app.example.com/billing#invoice-42` | `https://app.example.com/billing` |
| `/claim/k3J9xQ2mV8pL4nR7tY1wZ6bA` (from 11 October 2026) | `/claim/[token]` |

## What this means for your reports

- **Pages differ by path, not by query.** Sequential stores `/search?q=shoes` and `/search?q=boots` as the same URL. If a query value matters, send it as an event property. See [Send custom events](/docs/custom-events).
- **In a hash-routed app, events stored before 9 October 2026 have no route.** Sequential stored `https://app.example.com/#/settings/billing` as `https://app.example.com/`. From that date, it keeps the route. See **Hash routes** above.
- **Use the lower-case `utm_*` campaign parameters.** Sequential redacts your own referral codes, such as `?ref=partner42`, and any other parameter, such as `utm_keyword`.
- **Keep personal data out of paths.** Sequential replaces only segments shaped like an email address, JWT or card number, and, from 11 October 2026, secrets. It stores numeric ids and usernames in a path as sent.

> **Page URLs in recordings**
>
> | Masking | What a web recording keeps of the page URL |
> |---|---|
> | **Strict** (the default) | The domain and the route. Id-like segments are masked. No query, fragment or `;` parameters. |
> | **Balanced** | The full URL, with query values and the fragment. |
> | **Custom**, with **Attribute values (titles, labels, alt text, data-*)** set to **Kept, URLs cut to the path** | The domain and the full path. No query, fragment or `;` parameters. |
>
> For example, under **Strict**, `https://app.example.com/orders/1234567?tab=2#notes` becomes `https://app.example.com/orders/███████`.
>
> Under **Strict**, some parts of a route stay: numbers of 5 digits or fewer, and name slugs such as `/users/jane-doe`. [Masking and redaction](/docs/masking-and-redaction) lists the exact rule.
>
> From 11 October 2026, with every masking setting, a secret in the page address of a new recording is stored as `[token]`. A short or readable secret can still pass. If a page has secrets in its URL, keep it out of recordings. Add its path to **Never record these pages**, under **Recording** in **Settings** › **Recording & data**. See [Masking and redaction](/docs/masking-and-redaction).

## Limits

- **Sequential does not clean stored events again.** It cleans each event once, when the event arrives. A stored event stays as it was cleaned until its retention period ends or you delete the project. See [Retention and deletion](/docs/retention-and-deletion).
- **Identifier detection recognises shapes, not meaning.** Sequential stores names, phone numbers, numeric ids and short or readable tokens as sent, in paths and in kept parameters. From 11 October 2026, it stores a long random token in a path as `[token]`.
- **Sequential does not redact parameter names or bare query words.** An identifier in either is stored as sent. See "Exact behaviours of the query check" below.
- **Parameter names are case-sensitive.** Sequential stores `UTM_SOURCE=newsletter` as `UTM_SOURCE=[redacted]`.
- **Sequential does not clean URL parts that an SDK sends as separate properties.** Examples are Mixpanel's `current_url_search` and PostHog's `$pathname`. From 11 October 2026, the one exception is the `[token]` rule for a value that starts with `/`, such as `$pathname`.
- **Sequential does not change values that are not URLs.** Keep secrets and personal data out of properties. Do not rely on URL cleaning for them.
- **The Sequential SDK cuts long URLs.** It sends at most the first 512 characters of a page URL or referrer. Campaign parameters past that point are lost. So keep landing-page URLs short.
- **DevTools network requests use a different rule.** Sequential redacts every query value there, including attribution parameters, unless you list its key under **Query values kept**.

### The full list of attribution parameters

- **Campaign labels:** `utm_source`, `utm_medium`, `utm_campaign`, `utm_term`, `utm_content`, `utm_id`, `utm_source_platform`, `utm_creative_format`, `utm_marketing_tactic`, and Mailchimp's campaign id `mc_cid`. They are meant to describe a campaign, not a visitor.
- **Ad-platform click ids:** `gclid`, `gbraid`, `wbraid`, `dclid`, `gad_source`, `fbclid`, `msclkid`, `ttclid`, `twclid`, `li_fat_id`, `rdt_cid` and `igshid`. Ad and social platforms add these ids to links. Most of these ids are different for each click.

The list is all lower case. Parameter names are case-sensitive. So Sequential redacts `UTM_SOURCE`.

### Kept parameters that look like an identifier

The attribution parameters are for marketing labels. They are not for any value that someone puts in them. Sequential still replaces a kept value when the value looks like one of these:

- an email address
- a JWT
- a `Bearer` or `Basic` credential
- a 15- or 16-digit card number that passes the standard checksum

Sequential keeps card numbers of other lengths.

| Sent | Stored |
|---|---|
| `utm_campaign=spring_sale_2026` | Unchanged |
| `utm_campaign=jane@example.com` | `utm_campaign=[redacted]` |
| `utm_campaign=4111111111111111` | `utm_campaign=[redacted]` |

This check recognises shapes, not meaning. Sequential keeps an opaque value such as `utm_content=a8f3k2` as sent. So do not put identifiers into campaign parameters.

### More examples

| Sent | Stored |
|---|---|
| `/?ref=partner42` | `/?ref=[redacted]` |
| `/users/jane@example.com/settings` | `/users/[redacted]/settings` |
| `/users/48213/settings` | Unchanged |
| Referrer `https://www.google.com/search?q=session+replay` | `https://www.google.com/search?q=[redacted]` |

For example, if the plan that a user picks on a sign-up page matters, send the plan as an event property.

Sequential cleans the referrer too. Its name in filters is **Referrer**. It is the referring URL, not a campaign parameter.

### Exact behaviours of the query check

- **Sequential checks values, not parameter names.** It stores a name that is an identifier as sent. For example, `?jane@example.com=1` becomes `?jane@example.com=[redacted]`.
- **Sequential keeps a bare query word.** Sequential stores a query part with no `=`, such as `/invite?8f3a9c2b1d`, as sent, unless it has one of the identifier shapes.

### Why ad-click ids are kept

Of the attribution parameters, ad-click ids come closest to identifying a person. The ad or social platform can link a click id to a person. Sequential cannot. Ad attribution does not work without these ids, so Sequential keeps them.

### Parameters that are not on the list, such as mc_eid

Mailchimp adds two parameters to the links in its emails. The names differ by one character.

- `mc_cid` is the campaign id. It describes a send. It is a campaign label, so Sequential keeps it.
- `mc_eid` is the email id. It describes a subscriber. It identifies a person, so Sequential redacts it.

This pair shows the rule behind the list. A parameter is on the list because of what its value says about a person, not because its name looks like the others.

Other parameters look as if they belong, but they are not on the list. Sequential stores all of them as `[redacted]`:

- `_ga` and `_gid`: Google Analytics client ids. They identify a device or a person.
- `email`, `user_id`, `uid` and `session_id`.
- `msisdn`: a phone number.

### Sources and properties

Sequential cleans the page URL and referrer from every source in the same way. This includes the [Sequential SDK](/docs/sequential) and every vendor SDK: PostHog on web and mobile, Mixpanel, Amplitude, Pendo and Smartlook.

Sequential cleans a URL in an event, visitor or account property only when the value starts with `http://`, `https://`, `ws://` or `wss://`. See "URLs inside event properties" below.

Sequential stores an email address, a name or a phone number in a property exactly as you send it. From 18 October 2026, element text is the exception: an email in it becomes `[redacted]`. See [Privacy at a glance](/docs/privacy-overview#what-sequential-removes-automatically).

### URLs inside event properties

Sequential cleans the page URL and the referrer because it knows they are URLs. It cleans a URL in an event, visitor or account property the same way only when the value starts with `http://`, `https://`, `ws://` or `wss://`, in any letter case.

Sequential does not recognise these, and stores them as sent:

- relative paths, such as `/checkout?token=…`
- protocol-relative URLs, such as `//app.example.com/reset?token=…`
- a URL inside longer text, such as `see https://app.example.com/reset?token=… for details`
- a URL inside an object or array property, such as `{"link": {"href": "https://…?token=…"}}`
- percent-encoded URLs (`https%3A%2F%2F…`) and URLs inside a JSON string
- a value with a space before the URL

Sequential stores object and array values as JSON text. So it does not recognise a URL inside them.

Sequential leaves protocol-relative URLs alone on purpose. A match on `//` would also change ordinary text that was never a URL.

A full URL in a property loses its fragment too, except a hash route.

### URL parts that an SDK sends as separate properties

Some SDKs also send parts of the page URL as their own properties. These parts do not start with `http(s)://`, so Sequential stores them as sent. The page URL itself is still cleaned.

- Mixpanel's page views carry the whole query string in `current_url_search`, for example `?token=…&email=…`.
- PostHog's `$pathname` and Mixpanel's `current_url_path` keep path segments that Sequential replaced in the page URL.

This is true in the stored event.

### What the Sequential SDK does in the browser

Before it sends an event, the Sequential SDK:

- drops the whole `user:pass@` part, also when the password contains an `@`, and every fragment except a hash route that starts with `#/` or `#!/`
- redacts identifier-shaped values
- sends at most the first 512 characters of a page URL or referrer, and ends a cut URL with `…`

Other query values still reach Sequential, which redacts them.

Sequential does not receive campaign parameters after the 512th character. It stores a parameter that crosses that point cut short. So keep landing-page URLs short.

### Network requests in DevTools

Network requests in [DevTools](/docs/devtools) follow their own rule. Sequential redacts every query value, unless you list its key in **Query values kept**. This list is under **Network requests**, in **Settings** › **Recording & data** › **What a recording carries**. Sequential does not keep the attribution parameters there unless you list them. Under **Strict** masking, DevTools also masks paths: a file that the page loads keeps only its domain, and an API call keeps its route with id-like parts masked. See [DevTools](/docs/devtools).

## Related

- [Privacy at a glance](/docs/privacy-overview)
- [Masking and redaction](/docs/masking-and-redaction)
- [Retention and deletion](/docs/retention-and-deletion)
- [Send custom events](/docs/custom-events)
- [Install Sequential](/docs/install)
