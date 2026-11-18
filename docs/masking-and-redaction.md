# Session replay masking and redaction

> Masking decides what a session replay shows. Redaction removes known secrets from DevTools data. What each one does, and what neither one catches.

> **Key facts**
>
> - Strict is the default. Replays look like wireframes: you see the layout and where people clicked, not the text.
> - Strict and Balanced both mask what people type. Balanced records all page text that you do not mark.
> - The recorder masks in the browser. Sequential's servers mask input values, attribute values and addresses (DevTools addresses included) again.
> - Mark elements and deploy them before you loosen masking. No change is retroactive.
> - Masking presets apply to replays only. Sequential SDK autocapture clicks carry element text. `data-sq-mask` or `data-sq-private` keeps it out.

## How it works

Page text masking depends on the recorder only: the servers do not re-mask page text.

Redaction replaces recognisable secrets in DevTools data with `[redacted]`. It catches shapes, not meaning. Redaction is not the main protection. Three fixed rules keep secrets out:

- Console message text is off unless you turn it on.
- Network query values are redacted unless you list them. List only parameters that identify nothing, such as `page` or `sort`.
- Sequential never stores request headers or bodies.

Even Strict leaves some things readable, such as element ids, classes, domain names and parts of routes ([What masking does not cover](#what-masking-does-not-cover)).

### How masking and redaction work in detail

Masking hides page content in the replay. The recorder applies it in the visitor's browser, before anything is sent.

Session replay records what people see. Masking and redaction decide how much of it Sequential keeps. They answer questions like these:

- Can support watch a failed checkout without seeing the card number the person typed?
- Your account page shows each person's name and email. Can you record it and keep those out?
- An API call carries a password-reset token in its query string. Does the token reach the replay's network tab?
- Should your team turn on console message text in production?

Masking covers the page itself: text, form inputs, images and media. Under Strict, it also covers attribute values, addresses, the page address and the addresses in DevTools data.

Redaction covers DevTools data: JavaScript errors, console entries and network requests.

Masking runs in two scrubs:

| What | Where Sequential masks it |
|---|---|
| Page text and blocked elements | In the visitor's browser only. |
| Input values | In the visitor's browser. Then again on Sequential's servers when the recording arrives, under the project's current Mask every input setting. The servers mask what people type, and the values of hidden fields and file inputs. |
| Attribute values, addresses and the page address | In the visitor's browser. Then again on Sequential's servers when the recording arrives, under the project's current Attribute values setting. |
| DevTools addresses: network requests, code locations, and addresses in error and console text | In the visitor's browser. Then again on Sequential's servers when the recording arrives, under the project's current Attribute values setting. |

The browser and the servers use the same rules file. So the second scrub also covers a recorder that a browser cached before a change, and any other client that sends recordings to your project.

The second scrub cannot unmask or unblock anything. It can only mask more.

Redaction runs in these places:

| | Where redaction runs |
|---|---|
| Websites | In the browser, and again on Sequential's servers. |
| Mobile apps | On the servers, before storage. |

## Choose a preset

| What | Strict (the default) | Balanced |
|---|---|---|
| Page text | All masked | Recorded, unless you mark it |
| Images and SVG | Blocked | Recorded |
| What people type, a checkbox or radio value that a person picks, the name of a file that a person picks, hidden field values | Masked | Masked |
| Other attribute values | Masked, except a fixed list | Recorded as they are |
| Link and image addresses, and the page address | Full path. Query values follow **Remove query values** | The same as Strict |
| DevTools addresses | Full path. Query values follow **Remove query values** | The same as Strict |

Every preset records element ids and classes, and whether a checkbox or radio button is ticked.

Custom is any other combination of the six fields under Masking level ([Custom masking, selectors and the settings API](#custom-masking)).

From 18 November 2026, addresses follow one rule under both presets. See [URL policy](/docs/url-policy).

A Strict replay can lose the styles that select on a masked attribute value. Balanced has none of these costs ([What each preset masks (web)](#what-each-preset-masks-web)).

### What each preset masks (web)

Masked text shows as solid blocks (█), one per character. Spaces stay in place, so a masked full name still shows as two words. A blocked element becomes an empty box of the same size.

Strict replays look like wireframes. You see the layout and where people clicked, not what they read. Balanced shows your page text and images.

What "masked" means for inputs:

- Each character except a space becomes a solid block (█). A file name such as `C:\fakepath\passport_jane_doe.pdf` becomes one block for each character.
- Sequential keeps whether a checkbox or radio button is ticked. So the replay still shows the tick.
- The option that a person picks in a drop-down list does not show, under either preset.
- A hidden field's value is masked in page snapshots, in fields that the page adds later, and when a script changes the value later.
- Under Balanced, the `value` of a checkbox, radio button or drop-down option in the page's HTML is page markup, not user input. Sequential records it as the page has it. The visible label shows the same choice, because Balanced records page text. Strict masks it.
- Only a Custom set-up with Mask every input off records input values as people type them.

Under Strict, CSS rules that select on a masked attribute value stop matching, such as `[data-variant="primary"]` or `[title="Close"]`. Rules on `id`, `class` and the state values in [Strict in detail: attributes, addresses and id-like segments](#strict-which-attributes-keep-their-value) still match, such as `[data-state="open"]`.

Balanced has none of these costs.

Recordings made under Strict before 18 November 2026 have masked addresses. In those replays, a web font with an id-like file name shows a fallback font, CSS background images do not show, and a stylesheet with a build hash in its file name cannot load if the recorder could not copy its CSS. In DevTools, a file that the page loaded shows only its domain and masked path segments. From 18 November 2026, addresses keep their path under Strict, so new recordings do not have these costs.

The third column is a Custom set-up with Attribute values set to Kept, or to the older choice. "Your setting" means that the row follows your own value of another field under Privacy and masking, not Attribute values. From 18 November 2026, the address rows are the same in all three columns.

| What | Strict (the default) | Balanced | Custom, Attribute values not Masked |
|---|---|---|---|
| Page text | All masked | Masked only inside elements with the `data-sq-mask` or `data-sq-private` attribute or the `sq-mask` class | Your setting (Masked text), and always inside elements with `data-sq-private` |
| Images and SVG | Blocked | Recorded | Your setting (Blocked elements) |
| Video, audio, iframes, embeds, objects and elements with `data-rr-block` | Blocked | Blocked | Your setting (Blocked elements) |
| Canvas | Not recorded | Not recorded | Your setting (Record canvas) |
| Inputs: what people type into text inputs and text areas | Masked | Masked | Masked while Mask every input is on |
| Inputs: the value of a checkbox or radio button that a person picks | Masked | Masked | Masked while Mask every input is on |
| Inputs: the name of a file that a person picks to upload | Masked | Masked | Masked while Mask every input is on |
| Inputs: the value of a hidden field (`type="hidden"`) | Masked | Masked | Masked while Mask every input is on |
| Inputs: whether a checkbox or radio button is ticked | Recorded | Recorded | Recorded |
| Inputs: the `value` of checkboxes, radio buttons and drop-down options in the page's HTML | Masked | Recorded as the page has it | Recorded as the page has it |
| Other attribute values, such as `title`, `alt`, `aria-label` and `data-*` | Masked, except a fixed list (see [Strict in detail: attributes, addresses and id-like segments](#strict-which-attributes-keep-their-value)) | Recorded as they are | Recorded as they are |
| Addresses in attributes and CSS, such as links and image sources | Domain and full path. A link, a form address or a frame that points to another site keeps only its domain. A file that the player loads keeps its full path on any site. No `;` parameters. Query values follow **Remove query values** | The same as Strict | The same as Strict |
| The page address | Domain and full path. No `;` parameters. Query values follow **Remove query values** | The same as Strict | The same as Strict |
| DevTools: network requests, and code locations: the file of an error, the stack frames, and where a console entry came from | Domain and full path. No `;` parameters and no `#fragment`. Query values follow **Remove query values** (see [Redaction and network requests in detail](#exact-shapes-redaction-catches)). Line and column kept | The same as Strict | The same as Strict |
| DevTools: `http(s)` and `ws(s)` addresses written in error messages and console text | Changed as code locations are | The same as Strict | The same as Strict |
| DevTools: ids after a `/` in error messages, console text and stack frames, outside an `http(s)` or `ws(s)` address | UUIDs, hex runs of 16 or more characters and runs of 6 or more digits masked | Kept | Kept |

Balanced records any text you have not marked, names and addresses included. It also records what people type into a rich-text editor or other `contenteditable` element. To mask it, put the editor inside an element with `data-sq-mask`.

Text in a rich-text editor is page text, not a form input. Redaction does not apply to page content. Masking is the only protection there.

### Strict in detail: attributes, addresses and id-like segments

Which attributes keep their value:

Strict uses an allowlist. An attribute keeps its value only if it is on this list. Sequential masks every other value like text: one █ per character.

| Kind | Examples | Under Strict |
|---|---|---|
| Structure and layout | `id`, `class`, `rel`, `width`, `height`, `sizes`, `media`, and SVG geometry such as `viewBox`, `d` and `fill` | Kept |
| Id references | `for`, `aria-labelledby`, `aria-describedby`, `aria-controls` | Kept |
| Masking controls | `data-rr-block`, `data-sq-mask` | Kept |
| Colour theme. From 16 October 2026 | `data-theme`, `data-color-mode`, `data-mode`, `data-color-scheme` | Kept only when the value is exactly `dark`, `light`, `system` or `auto`, in lower case. Any other value is masked. So a page that sets dark mode with one of these attributes replays dark. A session recorded before then keeps the masked value, and can replay light. |
| State | `role`, `aria-expanded`, `aria-hidden`, `aria-selected`, `hidden`, `open`, `disabled`, `data-state`, `data-orientation`, `data-side`, `data-align`, `tabindex`, `type`, `dir`, `lang` | Kept only when the value is in that attribute's fixed list, such as `role="menu"`, `aria-expanded="true"` or `data-state="open"`. Any other value is masked. |
| Everything else | `title`, `alt`, `aria-label`, `placeholder`, `value`, `name`, every other `data-*`, and framework attributes such as `hx-get` and `x-data` | Masked |

Sequential masks attribute values, never attribute names. A name such as `data-customer-42` stays as it is.

Under Balanced, attribute values are recorded as they are. The exceptions are the values of hidden fields and file inputs, which both presets mask.

Addresses and the page address:

From 18 November 2026, Strict does not mask the path of an address. These rules hold under every preset:

| Address | Stored | Example |
|---|---|---|
| Any address on your own site. On any site, a file that the player loads: the source of an image, a script, a video, audio, an embed or an SVG image (`src`, `srcset`, `poster`, the `data` of an object element, `background`), a stylesheet, an icon, a preload or manifest link, the `xlink:href` of SVG `<image>`, `<use>` and `<feImage>`, a web font, and `url(…)` and `@import` in CSS | Domain and full path. Query values follow **Remove query values**. No `;` parameters | `https://cdn.example.com/avatars/jane.png?v=2` stays as it is. With Remove query values on, it becomes `https://cdn.example.com/avatars/jane.png?v=[redacted]` |
| A reference to another site that the player does not load: a link (`<a>`, `<area>`, `<base>`, and a `<link>` such as `canonical` or `alternate`), a form address (`action`, `formaction`), a frame (an iframe or a frame element), `cite`, `longdesc`, `itemid`, `codebase`, `ping`, and the address in `<meta http-equiv="refresh">`, with or without `url=` | The domain only | `https://www.linkedin.com/in/jane-doe` becomes `https://www.linkedin.com` |
| The page address | Domain and full path. Query values follow **Remove query values**. No `;` parameters | `https://app.example.com/orders/1234567?tab=2#notes` stays as it is |
| A link to an element on the page, such as `#pricing`, or a hash route, such as `#/users/42` | Kept | |
| Another `#fragment`, such as `#access_token=…` | Dropped | |
| `javascript:` links | Removed | |
| `data:` addresses | Under Strict, `data:` only. Under Balanced, kept | |
| `mailto:` links | Under Strict, the scheme is kept, the address is masked and the query is dropped. Under Balanced, the email address becomes `[redacted]`, and the query follows Remove query values | `mailto:████████████████` |
| `tel:`, `sms:` and `callto:` links, also in the `tel://` form | The scheme is kept and the number is masked | `tel:█████████████` |

When a page changes an attribute later, the new address follows the rule of its element. For example, the `src` that a page sets later on an iframe keeps only its domain if it points to another site. If the element came in an earlier part of the recording, Sequential cannot see what kind of element it is. Then every `href` and `src` that points to another site keeps only its domain. So an image from another site that a page loads late can be missing in the replay.

In an address, an email address, a JWT, a credential or a card number becomes `[redacted]`, and a secret becomes `[token]`. See [URL policy](/docs/url-policy).

Recordings from before 18 November 2026 keep their addresses as they were stored then. Under Strict, that was the domain with masked path segments, and the route of the page address with id-like segments masked.

Id-like segments in heatmap page keys:

Heatmap data groups clicks by page. For that page key, Sequential uses the rule from before 18 November 2026 under every preset. It keeps the route, and masks a whole path segment in these cases:

- A UUID, a hex run of 16 or more characters or an email address is anywhere in the segment. Examples are `<uuid>.json`, `<uuid>:activate` and `uuid:<uuid>`. Sequential decodes the segment first, so `id%3A<uuid>` is masked too.
- The segment is id-like.
- A piece of the segment is id-like, or holds 6 or more digits in a row. Sequential splits a segment into pieces at `-`, `_`, `.`, `~`, `+`, `:`, `,`, `;`, `@`, `[`, `]`, `(`, `)`, `=` and `?`. Examples are `ORD-1234567`, `9876543.pdf` and `id:1234567`.

Id-like means one of these:

- a UUID
- 6 or more digits, such as `1234567`
- a hex token of 16 or more characters
- a base64 token of 20 or more characters that contains a digit
- an email address
- a JWT

| Path | In the page key |
|---|---|
| `/settings/2fa`, `/blog/2026/09`, `/v2/api`, `/users/me` | Kept |
| `/orders/1234567` | `/orders/███████` |
| `/u/jane@example.com` | `/u/████████████████` |
| `/invoices/ORD-1234567` | `/invoices/███████████` |
| `/files/<uuid>.json` | `/files/` and one block for each character of the segment |

From 18 November 2026, recordings and DevTools keep these segments. Before 18 November 2026, Strict also masked them in the page address, in stylesheet links and in DevTools API calls.

## What it needs

- On websites, Sequential's recorder, from [Session replay (web)](/docs/session-replay) or the [Sequential SDK](/docs/sequential).
- On mobile, PostHog's iOS or Android SDK sending to Sequential ([Mobile apps](/docs/mobile)).
- An owner or admin to change the settings ([Roles and permissions](/docs/roles-and-permissions)).

## Mark sensitive elements

Mark your pages before you loosen masking.

| Marker | What it does | What to mark |
|---|---|---|
| `data-sq-mask` (attribute) or `sq-mask` (class) | Masks the text inside the element under Balanced. With the attribute, click events from the Sequential SDK also leave out its text and `data-*` values. With the class, they do not | Anything that shows personal data, such as a profile header or an address block |
| `data-sq-private` (attribute) | Masks the text inside the element under every preset, whatever the Masked text setting under Masking level holds, from 10 October 2026. Click events from the Sequential SDK also leave out its text, `data-*` values and ids | The same kind of element, when its text must also stay out of click events, such as an account menu with the person's name |
| `data-rr-block` | Leaves the element out of the recording entirely, under both presets | Anything that must never be captured, such as a document preview, an API key on screen, or profile photos under Balanced |

## Change the preset

If you choose Strict or Balanced, the preset overwrites all six fields under Masking level. Your custom selectors are lost.

1. If you move to Balanced or Custom, first add `data-sq-mask` and `data-rr-block` to your pages. Deploy them.

2. In **Settings › Recording & data**, under **Privacy and masking › Masking level**, choose Strict, Balanced or Custom.

3. Click **Save changes**. If the app asks for the slug, type the project slug in the field and click **Save and record more**.

   **If the box that asks for the slug opens**

   The box opens if the change records more (for example, Strict to Balanced). It says "This records more than before." and lists what the change records.

   The field shows the slug, for example "Type `web-shop`, the project’s slug, to save". Spaces before or after the slug do not matter. **Save and record more** stays unavailable until the text matches.

   Every save appears in the [Audit log](/docs/audit-log).

Result: A looser preset applies from the next page load.

### Custom masking, selectors and the settings API

Custom is any other combination. Under Masking level, set these six fields:

- Mask every input
- Masked text (CSS)
- Blocked elements (CSS)
- Attribute values (titles, labels, alt text, data-*)
- Collect fonts
- Record canvas

If you choose Strict or Balanced, the preset overwrites all six. If you edit any of them, the level changes to Custom, unless the six then match Strict or Balanced exactly.

Masking level shows Custom whenever the saved six settings do not match Strict or Balanced exactly.

Attribute values (titles, labels, alt text, data-*) is under Privacy and masking. It sets attribute masking on its own. From 18 November 2026, it does not change addresses. It has three choices:

| Choice | What it does |
|---|---|
| Masked | Masks attribute values as the Strict column of [What each preset masks (web)](#what-each-preset-masks-web) and [Strict in detail: attributes, addresses and id-like segments](#strict-which-attributes-keep-their-value) describe. Strict uses it. |
| Kept | Records attribute values as they are. Balanced uses it. |
| Kept (an older choice: addresses are no longer cut) | Shows only on a project that saved "Kept, URLs cut to the path" before 18 November 2026. From 18 November 2026, it records the same as Kept. No preset uses it. |

From 18 November 2026, addresses follow one rule under every choice. Links, image sources, `url(…)` in CSS, the page address and DevTools network requests keep their full path. Their query values follow **Remove query values**. See [URL policy](/docs/url-policy).

Before 18 November 2026, this choice was named Kept, and it kept every address as it was on the page. From 18 November 2026, it is named Kept. From 18 November 2026, Sequential changes these parts under it too, as under the other choices:

- A `javascript:` link. The address is stored empty.
- The email address in a `mailto:` link becomes `[redacted]`. The query of the link, such as `?subject=…`, follows **Remove query values**.
- The number in a `tel:`, `sms:` or `callto:` link is masked, one █ per character, under every choice. The query of such a link is dropped.
- `;` parameters in a path, such as `;jsessionid=…`.
- The path and the query of a link, a form address or a frame that points to another site. Only its domain stays.
- A `#fragment`, except an element id or a hash route.

So for addresses, Kept records less than before, not more. A `data:` address stays as it is.

- Choosing Strict sets it to Masked. Choosing Balanced sets it to Kept.
- The older choice is a Custom choice only.
- A change from Masked to another choice records more. When you save, the app asks you to confirm with the project slug. From 18 November 2026, a change between the other two choices records the same, and the app does not ask.
- A project saved before this setting existed gets Masked if its preset is Strict or Custom, and Kept if its preset is Balanced.

A selector browsers cannot read: if a Masked text or Blocked elements selector is not valid CSS, Sequential records nothing rather than record unmasked content. An empty part in Masked text is the one exception. An example is a comma at the end of the list. Sequential sends Masked text to the recorder without its empty parts, so the page still records.

One invalid part stops the whole list from working, so check each part, for example `#2nd-step` (an id cannot start with a digit) or `.a..b`.

#### Messages for a selector browsers cannot read

| Message | Where | What it means | What to do |
|---|---|---|---|
| ""#2nd-step" is not a valid CSS selector." | On save in the app: the field | Your browser checks the selector. The field gives the reason in the same words as Sequential's server. The message is an example. | — |
| "The recorder records no session in a browser that cannot read it." | On save in the app: the field | The field adds this if the list that the recorder gets also fails. | — |
| "An empty part is not a valid CSS selector." | On save in the app: the field | An empty part in Masked text, as in `[data-sq-mask],`, gets only this. | — |
| "Fix 1 field first; each says why." | On save in the app: the page, after you click Save changes | Sequential saves nothing. The message is an example. | — |
| "Web recording is off: the saved Blocked elements selector isn't valid in browsers ("div:nope" is not a valid CSS selector). No web session is recorded until it is fixed under Privacy and masking." | On the settings page: the top of Settings › Recording & data | A saved selector is not valid in your browser. Your browser checks Masked text as the recorder gets it. The line shows only while Record sessions and Web are on. The message is an example. | — |

On save through the API. Sequential's server checks the selector with its own parser. It refuses only what that parser can tell is invalid, such as `##x`, with a 422 `invalid_config` error that names those parts. Some selectors that browsers refuse still save, for example `#2nd-step`, `.a..b` or `div:nope`. Then nothing is recorded. So check a selector in the app before you send it through the API. The parser also refuses a few forms that browsers accept, such as an attribute bracket left open at the end: `[data-x`.

In the visitor's browser. Before it records, the recorder tries both selectors in the visitor's browser. If the browser refuses either one, that page is not recorded. The browser console shows one line: `[sequential] replay: masking_selector_invalid`. Browsers differ a little in what they accept, so a selector can fail in only some browsers.

The settings API: Strict with looser attribute masking.

Owners and admins can also change masking through the settings API, with PATCH `/api/projects/:id/config`. The app's settings form never sends the combination in this list.

- If a request names the preset `strict` and also sets `mask_attributes` to `urls` or `off`, Sequential refuses it with 400 `masking_preset_conflict`. It saves nothing.
- The message is: `preset "strict" cannot be combined with a looser mask_attributes; send preset "custom" to loosen`. The `fields` list names `mask_attributes`.
- To loosen attribute masking, send the preset `custom`. If the change records more than before, also send `confirm` with the project slug.
- Sequential checks only `mask_attributes` in this way. If a request names `strict` and loosens a different masking setting, such as `mask_all_inputs`, Sequential saves it as `custom`. If that records more than before and the request has no `confirm` with the project slug, the API answers 403 `confirm_required` and saves nothing.
- A stored configuration can say `strict` and have a looser `mask_attributes`, for example from before this check. Sequential then applies `strict` attribute masking. It does not change the other settings.

## What masking does not cover

> **What Strict does not mask**
>
> Keep personal data out of ids, classes, domain names and paths. If a path must carry it, add that path to Never record these pages in [Recording settings](/docs/recording-settings).
>
> These are known and accepted. Do not read Strict as more than this:
>
> - `id`, `class` and id references keep their values. An id such as `user-jane@example.com` stays readable.
> - Domain names stay everywhere: in addresses, in the page address and in DevTools. A domain such as `janedoe.example.com` stays readable.
> - From 18 November 2026, every path segment stays, such as `/orders/1234567` or `/users/jane-doe`. Only an email address, a JWT, a credential, a card number or a secret in it is replaced.
> - Query values stay, unless the project turns on Remove query values. Query parameter names always stay, such as `user_id` in `?user_id=[redacted]`.
>
> The other items of this list are in [What Sequential records as it is](#attributes-that-balanced-records).

Sequential records some things as they are under both presets, and more under Balanced ([What Sequential records as it is](#attributes-that-balanced-records)). To protect these:

- Put `data-rr-block` on any element whose state or attributes carry personal data. If you edit the Blocked elements field, keep `[data-rr-block]` in it. That entry makes the attribute work.
- If a page's address carries a token, such as a password-reset link, do not record that page. Add its path to Never record these pages in [Recording settings](/docs/recording-settings). It matches the path only, never the query string or fragment. An entry works only if the page with the token has its own path.

### What Sequential records as it is

What Strict does not mask, continued:

- Custom-event values that are not addresses stay, such as `{ email: 'jane@example.com' }` or a path with no `?`, `#` or `;`.
- In DevTools text, an id with no `/` before it in its word stays, such as `id=<uuid>` or `order 1234567 failed`. The keys of a logged object stay. A user name in a file path stays, such as `jane` in `/Users/jane/app.js`.

Under both presets, Sequential records these as they are:

- Whether a checkbox or radio button is ticked.
- Element `id` and `class` values, and every item of [What Strict does not mask](#what-masking-does-not-cover).

Heatmap data records where visitors click on masked elements: the element's place in the page structure and a cell inside it, never its text. A click inside a blocked element is not counted, unless the blocked part is inside a button or link: then the click counts for that button or link, with no position. See [Heatmap data](/docs/privacy-overview#heatmap-data).

An agent's heatmap answer withholds element text, class names, ids and the names of custom elements: it names an element by its kind, its place and a path of tags, with `…` for an unknown tag.

Under Balanced, Sequential also records these as they are:

- All attribute values except the values of hidden fields and file inputs. Examples: `title`, `aria-label`, `placeholder`, `alt` and `data-*` values; the labels of `<input type="submit">` and `type="button"` buttons; and the `value` of checkboxes, radio buttons and drop-down options in the page's HTML. Under Strict, Sequential masks all of these. From 18 November 2026, addresses are not on this list. They follow one rule under every preset. See [URL policy](/docs/url-policy).
- Inline styles, including CSS background images such as avatars.
- The page's full address, with its query string and its `#fragment`.
- The paths of network requests and code locations in DevTools, and the addresses in error and console text.

Under both presets, a blocked element keeps none of its attributes except `class`.

Both presets mask the name of a file that a person picks to upload, such as `passport_jane_doe.pdf`. Only a Custom set-up with Mask every input off records it.

Some sign-in flows put an access token in the `#fragment`. Sequential drops the fragment from network request URLs. Under Strict, the replay's page address has no fragment and no query. Under Balanced, the replay's page address keeps them.

Strict masks the replay's page address only. Your analytics events keep their own page URL, cleaned as [Page URLs](/docs/url-policy) describes.

## Clicks and analytics events

> **Autocapture clicks carry element text**
>
> Click events from the [Sequential SDK](/docs/sequential)'s autocapture carry the clicked element's text and up to 12 of its `data-*` values, under any preset, Strict included. From 26 October 2026, they also carry its `aria-label` (`$el_label`) and where a clicked link goes (`$el_href`).
>
> The `data-sq-mask` and `data-sq-private` attributes keep them out. The `sq-mask` class does not. Prefer the attributes.

### What click events carry

When Sequential stores `$el_href`, it keeps only the origin of a link to another site. From 18 November 2026, it keeps the origin and the full path of a link on the same site, under every preset. Before 18 November 2026, Strict kept only the origin, and the other presets masked id-like segments. In the path, an email address, a JWT or a card number becomes `[redacted]`, and a secret becomes `[token]`. A query, a `#fragment`, `;` parameters and a user name never stay. A `mailto:`, `tel:` or other non-web link keeps only its scheme, such as `mailto:`.

`data-sq-private` also keeps out the element's id and the ids in its selector. From 10 October 2026, the Sequential SDK also leaves out the text and `data-*` values of a click in account UI, or whose text names the signed-in person. See [Sequential SDK](/docs/sequential).

From 26 October 2026, Sequential stores the link targets that other SDKs send by the same rule: Mixpanel's `$el_attr__href`, Amplitude's `[Amplitude] Element Href`, PostHog's `$external_click_url`, and the `href` values inside PostHog's `$elements` and `$elements_chain`. If Sequential cannot read such a field, it drops the whole field when it holds a link, so a link is never stored unread. Other addresses inside PostHog's elements, such as `attr__src`, stay as they are. Each is up to 128 characters, after redaction.

From 18 October 2026, Sequential also checks element text from every SDK when it stores an event: an email, a card number, a JWT or a Bearer or Basic credential becomes `[redacted]`. See [Privacy at a glance](/docs/privacy-overview#what-sequential-removes-automatically).

## Redaction in DevTools data

Redaction is always on. It replaces JWTs, `Bearer` and `Basic` credentials, email addresses, card numbers and values under sensitive keys with `[redacted]`. Sensitive-key redaction does not work on an object your app turns into a string first, such as `JSON.stringify(user)`.

Redaction does not catch names, phone numbers, postal addresses, one-time links, or API keys that are not JWTs. Keep secrets out of what your app logs and throws.

### Redaction and network requests in detail

Redaction replaces these values with `[redacted]`:

- JWTs.
- `Bearer` and `Basic` credentials. The word `Bearer` or `Basic` stays.
- Email addresses.
- 15- and 16-digit card numbers that pass the card-number checksum. The digits can be one run, or have a single space, dash or `+` between them.
- In objects your app logs to the console, the value under a key such as `password`, `secret`, `token`, `auth`, `cookie`, `session` or `apikey`. This does not work on an object your app turns into a string first, such as `JSON.stringify(user)`.

Forms that redaction misses: redaction catches only the exact shapes in this list. The exception is a value under a sensitive key in a logged object. Redaction also misses a recognisable value in a slightly different form.

These are kinds of gap, not a complete list:

- A JWT written straight after a letter, digit, `_` or `-`.
- A JWT whose dots are encoded in console or error text (`%2E`, `.`).
- A `Bearer` or `Basic` credential shorter than 8 characters.
- A `Bearer` or `Basic` credential joined to the word by anything other than a space (`Bearer:…`, or `Bearer%20…` in console or error text).
- An email address with an accented or other non-ASCII letter (`josé@…`, `…@münchen.de`). Redaction misses all of the address, or part of it.
- An email address written with `%40` in console or error text.
- A card number of another length, or split another way: two spaces, ` - `, a tab, a non-breaking space or dots between the groups.
- An object your app turns into a string before it logs it (`JSON.stringify(user)`). The result is text, so redaction does not check its keys.

Network requests and DevTools addresses:

Sequential stores each request's method, URL, status, timing and size. It never stores the headers or the body.

Two lists control the URL:

- They are under Network requests, in What a recording carries.
- They work only while Network requests is on. The app shows them only then.
- Each list takes one entry per line.

| Setting | What it does |
|---|---|
| Query values kept | From 18 November 2026, it is used only when **Remove query values** is on. Then it keeps the values of the query parameters you list, and Sequential replaces every other `name=value` value with `[redacted]`. With Remove query values off, request addresses keep every query value. |
| Requests ignored | Leaves out every request whose URL matches a pattern. For example, `**/oauth/**` leaves out every call under an `/oauth/` path. |

When you add a parameter to Query values kept, the app asks for the project slug.

- Parameter names stay. For a redacted value, the request in a replay shows `[redacted]`.
- With Remove query values on, a query item with no `=` (such as `?a1b2c3`) becomes `[redacted]`. With it off, Sequential keeps it, unless it looks like a JWT, email address or card number.
- If a kept value contains a JWT, a `Bearer` or `Basic` credential, an email address or a card number, Sequential replaces the whole value with `[redacted]`.
- Sequential drops the `#fragment`, any `user:pass@` and `;` parameters.
- Sequential replaces a path segment that looks like a JWT, email address or card number, and stores a secret as `[token]`.
- From 18 November 2026, the preset does not change the address. Every request keeps its full path under every preset.

Pattern syntax. Patterns match the full URL without its query. `*` stays within a path segment. `**` crosses segments. The help under the field says: "One pattern per line, matched against the whole URL without its query. * stays within a path segment, ** crosses them. For example https://api.example.com/health*."

Errors and console entries. Script URLs, stack traces and addresses in error and console text follow the same rule as request addresses: the full path, and the query values as sent. With Remove query values on, they keep no `name=value` query values: each value becomes `[redacted]`, whatever "Query values kept" lists. A query item with no `=` follows the same rule as in request URLs.

The DevTools rows of [What each preset masks (web)](#what-each-preset-masks-web), in detail:

- From 18 November 2026, the addresses are the same under every preset. Only the id rule in text follows Attribute values: a Custom set-up with Attribute values set to Masked gets it, as Strict does.
- Query parameter names stay in every preset, so an address still shows what was asked: `?user_id=[redacted]&page=2`.
- Console text is kept only while Console message text is on. Error messages are always kept.
- The id rule in text reads each word that holds a `/`, outside an `http(s)` or `ws(s)` address. It masks only what comes after the first `/` in that word. Prose such as `and/or`, `2026/09/29` and `v1/2` stays as it is. A trailing `:line:col` stays.

Example, under Strict:

| Recorded | Stored |
|---|---|
| An image, `https://cdn.example.com/avatars/jane.png?v=2` | Unchanged. With Remove query values on: `?v=[redacted]` |
| An API call, `https://api.example.com/api/orders/1234567/items?user_id=42` | Unchanged. With Remove query values on: `?user_id=[redacted]`, unless `user_id` is in Query values kept |
| An error message, `Failed to fetch https://api.example.com/users/<uuid>?user_id=42` | The address is unchanged. With Remove query values on: `user_id=[redacted]` |
| Console text, `GET /api/users/<uuid> failed` | The UUID masked, because it is not in an `http(s)` address |

## Console message text

Console message text is off by default. Turning it off again does not remove text that is already stored.

| Question | Answer |
|---|---|
| What you gain | The words your app logged, such as "payment failed: card_declined" or an API error body. You know why `console.error` fired at `cart.js:42`, not only that it fired. |
| The risk | Sequential stores whatever your app writes to the console, with the recording. Everyone with access to the project can watch its replays, viewers included. Redaction does not catch `console.log("reset link for", user, "is", url)`, or a logged API response full of personal data. |
| What Sequential recommends | Leave it off in production by default. You can turn it on in a staging or development project. Turn it on in production only after you check what your app writes to the console. |

Settings are per project. Separate staging and production projects give you both ([Organisations, projects and keys](/docs/organisations-and-projects)).

With Console message text off, each console entry keeps its level, how often it happened, where it was logged, and a stack trace for warnings and errors.

### Turn on message text

1. Go to **Settings › Recording & data**.

2. Under What a recording carries, make sure that **Console output** is on. It is on by default.

3. Turn on **Console message text**. It shows only while Console output is on.

4. Click **Save changes**. In the box that opens, type the project slug and click **Save and record more**.

When you turn message text off again:

- Turning it off stops Sequential from storing new text. It does not remove text that is already stored. [Retention and deletion](/docs/retention-and-deletion) covers what happens to existing recordings.
- While it is off, Sequential's servers empty message text as it arrives. This includes text from an older recorder or a mobile SDK that sends it anyway.
- Sequential asks iOS and Android apps for logs only while it is on. The page says: "On iOS and Android, logs are requested from the app only when Console message text is on."

## Mobile apps

On iOS and Android, PostHog's mobile SDK masks on the device. Its defaults are private. You set the masking in your app's code. The project's masking settings do not apply to the recording itself: the configuration that a mobile SDK reads from Sequential has no masking settings.

Attribute values still applies to the DevTools data that an app sends ([What do the project settings do for app recordings?](#what-do-the-project-settings-do-for-app-recordings)).

On iOS, the default image masking can make every frame of a replay black. See [Mobile apps](/docs/mobile#ios-swift). On Android, turning off `maskAllTextInputs` shows typed text in the replay, in every field except password fields. See [Mobile apps](/docs/mobile#masking-on-android).

On iOS, autocapture can also send the text that a person types in a text field. This happens only if your app turns it on.

[Mobile apps](/docs/mobile) covers the SDK's defaults, how to mask your own views and how to keep a text field out.

## Limits

- Sequential's servers cannot block an element. Sequential cannot enforce text masking on a modified recorder, or on anyone who sends data with your project's public replay key.
- A hidden field that changes later: the servers check a later value change of a hidden field only within one upload. The recorder masks every such change before it sends. A recorder that a browser cached from before this rule does not.
- Tighter masking does not re-mask existing recordings. You cannot undo looser masking for recordings made while it was in force, or fix a recording made before you marked an element.
- Masked text keeps its shape. Spaces stay, so a viewer can see how long each word was.
- Error messages are kept even with message text off. On websites, uncaught errors and unhandled promise rejections keep their message, after redaction.
- If you also send an error as an analytics event, such as with `captureException`, the judge can see a short excerpt of it.

## FAQ

### Errors that reach the judge

Keep personal data out of the errors your code throws.

The judge never sees the replay's copy of an error. At most, it sees how many errors there were.

If you also send an error as an analytics event, the judge can see a short excerpt of it. For example, the Sequential SDK's `captureException` sends one. [AI and third parties](/docs/ai-and-third-parties) covers this.

### What do the project settings do for app recordings?

Attribute masking (`mask_attributes`) does not apply to mobile recordings. They are not web pages and carry no HTML attributes. The mobile SDK's own masking still masks them.

"Attribute values" still applies to the DevTools data that an app sends. Sequential's servers shorten its request addresses and the code locations of its logs under that setting, as they do for the web. Under Record on, the settings page says: "What an app sends is then filtered by the console and network settings under What a recording carries and by Attribute values, and refused past Largest recording."

## Related pages

- [Recording settings](/docs/recording-settings): change what a recording carries.
- [DevTools](/docs/devtools): read the errors, console entries and network requests of a replay.
- [Page URLs](/docs/url-policy): what Sequential keeps from page URLs.
- [AI and third parties](/docs/ai-and-third-parties): what reaches the judge and other third parties.
- [Retention and deletion](/docs/retention-and-deletion): how long Sequential keeps recordings.
- [Privacy at a glance](/docs/privacy-overview): what Sequential records and what it removes.
