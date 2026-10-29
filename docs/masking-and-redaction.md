# Session replay masking and redaction

> Masking decides what a session replay shows. Redaction removes known secrets from DevTools data. What each one does, and what neither one catches.

> **In short**
>
> - **Masking** hides page content in the replay. The recorder applies it in the browser, before anything is sent. Sequential's servers mask attribute values, addresses, input values and DevTools addresses again when a recording arrives.
> - **Redaction** replaces recognisable secrets in DevTools data with `[redacted]`. It catches shapes, not meaning.
> - **Strict** is the default preset. It masks all text, every input and most attribute values. It cuts link and image addresses down to their domain. It cuts the page address, and the addresses of web font files, down to their route. In DevTools, it keeps only the domain of each file that the page loads, and the route of each API call.
> - **Balanced** records all page text, images and attribute values that you do not mark, and the page's full address.
> - Both presets mask what users type, the value of a checkbox or radio button that a user picks, the name of a file that a user picks and the value of hidden fields.
> - Every preset records element ids and classes, and whether a checkbox or radio button is ticked.
> - Choosing **Strict** or **Balanced** also sets attribute masking. To set it on its own, use **Attribute values (titles, labels, alt text, data-*)** under **Privacy and masking**.
> - No change is retroactive. Mark your pages before you loosen masking.

### What it is for

Session replay records what your users see. Masking and redaction decide how much of it Sequential keeps. They answer questions like these:

- Can support watch a failed checkout without seeing the card number the user typed?
- Your account page shows each user's name and email. Can you record it and keep those out?
- An API call carries a password-reset token in its query string. Does the token reach the replay's network tab?
- Should your team turn on console message text in production?

## How it works

**Masking** covers the page itself: text, form inputs, images and media. Under **Strict**, it also covers attribute values, addresses, the page address and the addresses in DevTools data.

**Redaction** covers DevTools data: JavaScript errors, console entries and network requests. Redaction is not the main protection. Three fixed rules keep secrets out:

- Console message text is off unless you turn it on.
- Network query values are redacted unless you list them. List only parameters that identify nothing, such as `page` or `sort`.
- Sequential never stores request headers or bodies.

### Where redaction runs

| | Where redaction runs |
|---|---|
| **Websites** | In the browser, and again on Sequential's servers. |
| **Mobile apps** | On the servers, before storage. |

### Where masking runs: two scrubs

| What | Where Sequential masks it |
|---|---|
| Page text and blocked elements | In the visitor's browser only. |
| Input values | In the visitor's browser. Then again on Sequential's servers when the recording arrives, under the project's **current** **Mask every input** setting. The servers mask what users type, and the values of hidden fields and file inputs. |
| Attribute values, addresses and the page address | In the visitor's browser. Then again on Sequential's servers when the recording arrives, under the project's **current** **Attribute values** setting. |
| DevTools addresses: network requests, code locations, and addresses in error and console text | In the visitor's browser. Then again on Sequential's servers when the recording arrives, under the project's **current** **Attribute values** setting. |

The browser and the servers use the same rules file. So the second scrub also covers a recorder that a browser cached before a change, and any other client that sends recordings to your project.

The second scrub cannot unmask or unblock anything. It can only mask more.

## What each preset masks (web)

The third column is a **Custom** set-up with **Attribute values** set to **Kept, URLs cut to the path**. "Your setting" means that the row follows your own value of another field under **Privacy and masking**, not **Attribute values**.

| What | **Strict** (the default) | **Balanced** | **Custom**, **Attribute values** set to **Kept, URLs cut to the path** |
|---|---|---|---|
| Page text | All masked | Masked only inside elements with the `data-sq-mask` or `data-sq-private` attribute or the `sq-mask` class | Your setting (**Masked text**), and always inside elements with `data-sq-private` |
| Images and SVG | Blocked | Recorded | Your setting (**Blocked elements**) |
| Video, audio, iframes, embeds, objects and elements with `data-rr-block` | Blocked | Blocked | Your setting (**Blocked elements**) |
| Canvas | Not recorded | Not recorded | Your setting (**Record canvas**) |
| **Inputs:** what users type into text inputs and text areas | Masked | Masked | Masked while **Mask every input** is on |
| **Inputs:** the value of a checkbox or radio button that a user picks | Masked | Masked | Masked while **Mask every input** is on |
| **Inputs:** the name of a file that a user picks to upload | Masked | Masked | Masked while **Mask every input** is on |
| **Inputs:** the value of a hidden field (`type="hidden"`) | Masked | Masked | Masked while **Mask every input** is on |
| **Inputs:** whether a checkbox or radio button is ticked | Recorded | Recorded | Recorded |
| **Inputs:** the `value` of checkboxes, radio buttons and drop-down options in the page's HTML | Masked | Recorded as the page has it | Recorded as the page has it |
| Other attribute values, such as `title`, `alt`, `aria-label` and `data-*` | Masked, except a fixed list (below) | Recorded as they are | Recorded as they are |
| Addresses in attributes and CSS, such as links and image sources | Domain kept. Every path segment masked, except the address of a web font file and some stylesheets in CSS (see below). No query or fragment | Recorded as they are | Domain and path kept. No query, fragment or `;` parameters |
| The page address | Domain and route kept. Id-like segments masked. No query or fragment | Recorded in full | Domain and path kept. No query, fragment or `;` parameters |
| **DevTools:** files that the page loads, such as images, CSS, scripts, fonts and media | Domain kept. Every path segment masked. No query | Path kept. Query values `[redacted]` | Path kept. No `;` parameters. Query values `[redacted]` |
| **DevTools:** API calls (fetch and XHR), and the page itself | Domain and route kept. Id-like segments masked. No `;` parameters. Query values `[redacted]` | Path kept. Query values `[redacted]` | Path kept. No `;` parameters. Query values `[redacted]` |
| **DevTools:** code locations: the file of an error, the stack frames, and where a console entry came from | A script or other asset file: domain kept, every path segment masked, no query. Any other address: domain and route kept, id-like segments masked, query values `[redacted]`. Line and column kept | Path kept. Query values `[redacted]` | Path kept. No `;` parameters. Query values `[redacted]` |
| **DevTools:** `http(s)` and `ws(s)` addresses written in error messages and console text | Changed as code locations are | Kept. Only redaction runs | Changed as code locations are |
| **DevTools:** ids after a `/` in error messages, console text and stack frames | UUIDs, hex runs of 16 or more characters and runs of 6 or more digits masked | Kept | Kept |

Balanced records any text you have not marked, names and addresses included. It also records what users type into a rich-text editor or other `contenteditable` element. To mask it, put the editor inside an element with `data-sq-mask`.

Text in a rich-text editor is page text, not a form input. Redaction does not apply to page content. Masking is the only protection there.

### DevTools rows in detail

- The DevTools rows follow **Attribute values**, not the preset name. A **Custom** set-up with **Attribute values** set to **Masked** gets the **Strict** column.
- A network request with no kind, or a kind that Sequential does not know, counts as a file that the page loads.
- Query parameter names stay in every preset, so an address still shows what was asked: `?user_id=[redacted]&page=2`.
- In network requests, Sequential keeps the values of the parameters that you list under **Query values kept**. Code locations and addresses in text keep no query values.
- In every preset, network addresses lose the `#fragment` and any `user:pass@`.
- Under **Masked** and **Kept, URLs cut to the path**, a query item with no `=`, such as `?<uuid>`, becomes `[redacted]`. Under **Balanced**, Sequential keeps it, unless it looks like a JWT, email address or card number.
- In code locations and in text, a script or other asset file is an address whose last segment ends in a script, stylesheet, image, font, media or `.pdf` extension, such as `.js`, `.css`, `.png` or `.woff2`. A `.json` address counts as a route.
- Console text is kept only while **Console message text** is on. Error messages are always kept.
- The id rule in text reads each word that holds a `/`. It masks only what comes after the first `/` in that word. Prose such as `and/or`, `2026/09/29` and `v1/2` stays as it is. A trailing `:line:col` stays.

Example, under **Strict**:

| Recorded | Stored |
|---|---|
| An image, `https://cdn.example.com/avatars/jane.png?v=2` | `https://cdn.example.com/███████/████████` |
| An API call, `https://api.example.com/api/orders/1234567/items?user_id=42` | `https://api.example.com/api/orders/███████/items?user_id=[redacted]` |
| An error message, `Failed to fetch https://api.example.com/users/<uuid>?user_id=42` | The UUID masked, `user_id=[redacted]` |
| Console text, `GET /api/users/<uuid> failed` | The UUID masked |

### What "masked" means for inputs

- Each character except a space becomes a solid block (█). A file name such as `C:\fakepath\passport_jane_doe.pdf` becomes one block for each character.
- Sequential keeps whether a checkbox or radio button is ticked. So the replay still shows the tick.
- The option that a user picks in a drop-down list does not show, under either preset.
- A hidden field's value is masked in page snapshots, in fields that the page adds later, and when a script changes the value later.
- Under **Balanced**, the `value` of a checkbox, radio button or drop-down option in the page's HTML is page markup, not user input. Sequential records it as the page has it. The visible label shows the same choice, because **Balanced** records page text. **Strict** masks it.
- Only a **Custom** set-up with **Mask every input** off records input values as users type them.

### What each preset looks like in a replay

Masked text shows as solid blocks (█), one per character. Spaces stay in place, so a masked full name still shows as two words. A blocked element becomes an empty box of the same size.

Strict replays look like wireframes. You see the layout and where users clicked, not what they read. Balanced shows your page text and images.

### Strict: which attributes keep their value

**Strict** uses an allowlist. An attribute keeps its value only if it is on this list. Sequential masks every other value like text: one █ per character.

| Kind | Examples | Under **Strict** |
|---|---|---|
| Structure and layout | `id`, `class`, `rel`, `width`, `height`, `sizes`, `media`, and SVG geometry such as `viewBox`, `d` and `fill` | Kept |
| Id references | `for`, `aria-labelledby`, `aria-describedby`, `aria-controls` | Kept |
| Masking controls | `data-rr-block`, `data-sq-mask` | Kept |
| Colour theme. From 16 October 2026 | `data-theme`, `data-color-mode`, `data-mode`, `data-color-scheme` | Kept only when the value is exactly `dark`, `light`, `system` or `auto`, in lower case. Any other value is masked. So a page that sets dark mode with one of these attributes replays dark. A session recorded before then keeps the masked value, and can replay light. |
| State | `role`, `aria-expanded`, `aria-hidden`, `aria-selected`, `hidden`, `open`, `disabled`, `data-state`, `data-orientation`, `data-side`, `data-align`, `tabindex`, `type`, `dir`, `lang` | Kept only when the value is in that attribute's fixed list, such as `role="menu"`, `aria-expanded="true"` or `data-state="open"`. Any other value is masked. |
| Everything else | `title`, `alt`, `aria-label`, `placeholder`, `value`, `name`, every other `data-*`, and framework attributes such as `hx-get` and `x-data` | Masked |

Sequential masks attribute values, never attribute names. A name such as `data-customer-42` stays as it is.

Under **Balanced**, attribute values are recorded as they are. The exceptions are the values of hidden fields and file inputs, which both presets mask.

### Strict: addresses and the page address

| Address | Under **Strict** | Example |
|---|---|---|
| Links, image sources and other URL attributes (`href`, `src`, `srcset`, `action`, `poster`), and other `url(…)` in CSS and SVG | Domain kept. Every path segment masked. No query, fragment or `;` parameters | `https://cdn.example.com/avatars/jane.png?v=2` becomes `https://cdn.example.com/███████/████████` |
| From 26 October 2026: the address of a web font file in CSS or in the recorded fonts. The file name ends in `.woff2`, `.woff`, `.ttf`, `.otf` or `.eot` | Domain and route kept. Id-like segments masked. No query or fragment | `https://cdn.example.com/fonts/inter.woff2?v=3` becomes `https://cdn.example.com/fonts/inter.woff2` |
| From 26 October 2026: a `.css` file in `url(…)` in CSS, when the first folder of its path is `_app`, `_next`, `assets`, `static`, `dist`, `build`, `css`, `styles`, `fonts`, `wp-content` or `wp-includes` | Domain and route kept. Id-like segments masked. No query or fragment | `/assets/app.css` keeps its route. `/u/jane/css/theme.css` does not start with such a folder, so every segment is masked |
| A stylesheet link, and `@import '…'` in CSS | Domain and route kept. Id-like segments masked. No query | |
| The page address | Domain and route kept. Id-like segments masked. No query, fragment or `;` parameters | `https://app.example.com/orders/1234567?tab=2#notes` becomes `https://app.example.com/orders/███████` |
| A link to an element on the page, such as `#pricing` | Kept | |
| Other fragment-only links, such as `#/users/42` | `#` | |
| `javascript:` links | Removed | |
| `data:` addresses | `data:` only | |
| `mailto:` and `tel:` links | Scheme kept, address masked | `mailto:████████████████` |

Under **Balanced**, all of these are recorded as they are.

### Id-like segments in the page address

Under **Strict**, Sequential keeps the route of the page address. It masks a whole path segment in these cases:

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

| Path | Under **Strict** |
|---|---|
| `/settings/2fa`, `/blog/2026/09`, `/v2/api`, `/users/me` | Kept |
| `/orders/1234567` | `/orders/███████` |
| `/u/jane@example.com` | `/u/████████████████` |
| `/invoices/ORD-1234567` | `/invoices/███████████` |
| `/files/<uuid>.json` | `/files/` and one block for each character of the segment |

The same rule applies to a stylesheet link, and to API calls and the page itself in DevTools. A stylesheet file name with a build hash, such as `app.0123456789abcdef.css`, is masked too.

> **What Strict does not mask**
>
> These are known and accepted. Do not read **Strict** as more than this:
>
> - `id`, `class` and id references keep their values. An id such as `user-jane@example.com` stays readable.
> - Domain names stay everywhere: in addresses, in the page address and in DevTools. A domain such as `janedoe.example.com` stays readable.
> - Numbers of 5 digits or fewer in a route stay, such as `/orders/12345`.
> - Name slugs in a route stay, such as `/users/jane-doe`.
> - A digit run joined to letters with no separator stays in a route, such as `/u/user1234567`.
> - Custom-event values that are not addresses stay, such as `{ email: 'jane@example.com' }` or a path with no `?`, `#` or `;`.
> - In DevTools, query parameter names stay, such as `user_id` in `?user_id=[redacted]`.
> - In DevTools text, an id with no `/` before it in its word stays, such as `id=<uuid>` or `order 1234567 failed`. The keys of a logged object stay. A user name in a file path stays, such as `jane` in `/Users/jane/app.js`.
> - The route of a web font file stays, such as `/fonts/inter.woff2`. So does the route of a `.css` file in a known asset folder, such as `/assets/app.css`.
> - In DevTools, you cannot see which file failed to load. A failed image, script or font shows only its domain, its kind, its status and its timing.
>
> Keep personal data out of ids, classes, domain names and routes. If a route must carry it, add that path to **Never record these pages** in [Recording settings](/docs/recording-settings).

### What Strict costs in the replay

Under **Strict**, the player cannot load what the masked addresses pointed to:

- From 26 October 2026, a web font loads when the recording has the address of its file. If its file name has an id-like part, Sequential masks the name, the font does not load, and the replay shows a fallback font. A build hash of 16 or more hex characters is id-like, as in `a34f9d1a6d4c0d1e-s.p.woff2`. A shorter hash stays, as in `inter.4f2a9c8d.woff2` or `inter-latin-400-normal.Bx3k2_9c.woff2`. Recordings from before that date keep fallback fonts.
- CSS background images do not show.
- CSS rules that select on a masked attribute value stop matching, such as `[data-variant="primary"]` or `[title="Close"]`. Rules on `id`, `class` and the state values above still match, such as `[data-state="open"]`.
- A stylesheet whose file name has a build hash cannot load, if the recorder could not copy its CSS. The recorder usually copies it.
- In DevTools, the address of a file that the page loads shows only its domain and masked path segments. To find a file that failed, reproduce the issue in a browser, or use a **Custom** set-up with **Attribute values** set to **Kept, URLs cut to the path** on a staging project.

**Balanced** has none of these costs.

### Custom masking

**Custom** is any other combination. Under **Masking level**, set these six fields:

- **Mask every input**
- **Masked text** (CSS)
- **Blocked elements** (CSS)
- **Attribute values (titles, labels, alt text, data-*)** (see the next section)
- **Collect fonts**
- **Record canvas**

If you choose **Strict** or **Balanced**, the preset overwrites all six. If you edit any of them, the level changes to **Custom**, unless the six then match **Strict** or **Balanced** exactly.

**Masking level** shows **Custom** whenever the saved six settings do not match **Strict** or **Balanced** exactly.

### A selector browsers cannot read

If a **Masked text** or **Blocked elements** selector is not valid CSS, Sequential records nothing rather than record unmasked content. An empty part in **Masked text** is the one exception. An example is a comma at the end of the list. Sequential sends **Masked text** to the recorder without its empty parts, so the page still records.

- **On save in the app.** Your browser checks the selector. The field gives the reason in the same words as Sequential's server, for example: ""#2nd-step" is not a valid CSS selector." If the list that the recorder gets also fails, the field adds: "The recorder records no session in a browser that cannot read it." So an empty part in **Masked text**, as in `[data-sq-mask],`, gets only "An empty part is not a valid CSS selector." If you click **Save changes**, the page says, for example, "Fix 1 field first; each says why." and saves nothing.
- **On save through the API.** Sequential's server checks the selector with its own parser. It refuses only what that parser can tell is invalid, such as `##x`, with a 422 `invalid_config` error that names those parts. Some selectors that browsers refuse still save, for example `#2nd-step`, `.a..b` or `div:nope`. Then nothing is recorded. So check a selector in the app before you send it through the API. The parser also refuses a few forms that browsers accept, such as an attribute bracket left open at the end: `[data-x`.
- **In the visitor's browser.** Before it records, the recorder tries both selectors in the visitor's browser. If the browser refuses either one, that page is not recorded. The browser console shows one line: `[sequential] replay: masking_selector_invalid`. Browsers differ a little in what they accept, so a selector can fail in only some browsers.
- **On the settings page.** If a saved selector is not valid in your browser, the top of **Settings** › **Recording & data** says so, for example: "Web recording is off: the saved Blocked elements selector isn't valid in browsers ("div:nope" is not a valid CSS selector). No web session is recorded until it is fixed under Privacy and masking." Your browser checks **Masked text** as the recorder gets it. The line shows only while **Record sessions** and **Web** are on.

One invalid part stops the whole list from working, so check each part, for example `#2nd-step` (an id cannot start with a digit) or `.a..b`.

### Attribute values

**Attribute values (titles, labels, alt text, data-*)** is under **Privacy and masking**. It sets attribute masking on its own. It also sets how DevTools shortens addresses. It has three choices:

| Choice | What it does |
|---|---|
| **Masked** | Masks attribute values, addresses and DevTools addresses as the **Strict** column and tables above describe. **Strict** uses it. |
| **Kept, URLs cut to the path** | Keeps attribute values. Removes the query, the `#fragment` and `;` parameters from addresses: links, image sources, `url(…)` in CSS and the page address. In DevTools, keeps paths and redacts query values. No preset uses it. |
| **Recorded as on the page** | Records attribute values and addresses as they are. DevTools keeps paths and redacts query values. **Balanced** uses it. |

- Choosing **Strict** sets it to **Masked**. Choosing **Balanced** sets it to **Recorded as on the page**.
- **Kept, URLs cut to the path** is a **Custom** choice only. If you choose it, the level changes to **Custom**.
- A change from **Masked** to either other choice, or from **Kept, URLs cut to the path** to **Recorded as on the page**, records more. When you save, the app asks you to confirm with the project slug.
- A project saved before this setting existed gets **Masked** if its preset is **Strict** or **Custom**, and **Recorded as on the page** if its preset is **Balanced**.

### The settings API: Strict with looser attribute masking

Owners and admins can also change masking through the settings API, with PATCH `/api/projects/:id/config`. The app's settings form never sends the combination below.

- If a request names the preset `strict` and also sets `mask_attributes` to `urls` or `off`, Sequential refuses it with 400 `masking_preset_conflict`. It saves nothing.
- The message is: `preset "strict" cannot be combined with a looser mask_attributes; send preset "custom" to loosen`. The `fields` list names `mask_attributes`.
- To loosen attribute masking, send the preset `custom`. If the change records more than before, also send `confirm` with the project slug.
- Sequential checks only `mask_attributes` in this way. If a request names `strict` and loosens a different masking setting, such as `mask_all_inputs`, Sequential saves it as `custom`. If that records more than before and the request has no `confirm` with the project slug, the API answers 403 `confirm_required` and saves nothing.
- A stored configuration can say `strict` and have a looser `mask_attributes`, for example from before this check. Sequential then applies `strict` attribute masking. It does not change the other settings.

### What masking does not cover

Under both presets, Sequential records these as they are:

- Whether a checkbox or radio button is ticked.
- Element `id` and `class` values, and what **What Strict does not mask** lists.
- Where visitors click on masked elements, as heatmap data: the element's place in the page structure and a cell inside it, never its text. A click inside a blocked element is not counted, unless the blocked part is inside a button or link: then the click counts for that button or link, with no position. See [Heatmap data](/docs/privacy-overview#heatmap-data). An agent's heatmap answer withholds element text, class names, ids and the names of custom elements: it names an element by its kind, its place and a path of tags, with `…` for an unknown tag.

Under **Balanced**, Sequential also records these as they are:

- All attribute values except the values of hidden fields and file inputs. This includes link targets, `title`, `aria-label` and `alt`, and the `value` of checkboxes, radio buttons and drop-down options in the page's HTML.
- Inline styles, including CSS background images such as avatars.
- The page's full address, with its query string and its `#fragment`.
- The paths of network requests and code locations in DevTools, and the addresses in error and console text.

To protect these:

- Put `data-rr-block` on any element whose state or attributes carry personal data. If you edit **Blocked elements**, keep `[data-rr-block]` in it. That entry makes the attribute work.
- If a page's address carries a token, such as a password-reset link, do not record that page. Add its path to **Never record these pages** in [Recording settings](/docs/recording-settings).

**Never record these pages** matches the path only, never the query string or fragment. An entry works only if the page with the token has its own path.

### Tokens, file names and the page address

Both presets mask the name of a file that a user picks to upload, such as `passport_jane_doe.pdf`. Only a **Custom** set-up with **Mask every input** off records it.

Some sign-in flows put an access token in the `#fragment`. Sequential drops the fragment from network request URLs. Under **Strict**, the replay's page address has no fragment and no query. Under **Balanced**, the replay's page address keeps them.

**Strict** masks the replay's page address only. Your analytics events keep their own page URL, cleaned as [Page URLs](/docs/url-policy) describes.

### Attributes that Balanced records

Under **Balanced**, Sequential records every attribute value as it is, except the values of hidden fields and file inputs. Examples:

- Link targets, `mailto:` addresses included.
- `title`, `aria-label`, `placeholder`, `alt` and `data-*` values.
- The labels of `<input type="submit">` and `type="button"` buttons.
- The `value` of checkboxes, radio buttons and drop-down options.

Under **Strict**, Sequential masks all of these.

Under both presets, a blocked element keeps none of its attributes except `class`.

### Mark sensitive elements

| Marker | What it does |
|---|---|
| `data-sq-mask` (attribute) or `sq-mask` (class) | Masks the text inside the element under **Balanced** |
| `data-sq-private` (attribute) | Masks the text inside the element under every preset and every **Masked text** selector, from 10 October 2026. Click events from the Sequential SDK also leave out its text, `data-*` values and ids |
| `data-rr-block` | Leaves the element out of the recording entirely, under both presets |

What to mark:

- `data-sq-mask`: anything that shows personal data, such as a profile header or an address block.
- `data-sq-private`: the same kind of element, when its text must also stay out of click events, such as an account menu with the person's name.
- `data-rr-block`: anything that must never be captured, such as a document preview, an API key on screen, or profile photos under **Balanced**.

> **Autocapture clicks carry element text**
>
> Masking presets apply to replays only. Click events from the [Sequential SDK](/docs/sequential)'s autocapture carry the clicked element's text and up to 12 of its `data-*` values, under any preset, Strict included. From 26 October 2026, they also carry its `aria-label` (`$el_label`) and where a clicked link goes (`$el_href`). When Sequential stores `$el_href`, a project with **Strict** keeps only the origin of each link. Other projects keep the origin of a link to another site, and the route of a link on the same site, with id-like segments masked. A query, a `#fragment` and a user name never stay. From 26 October 2026, Sequential stores the link targets that other SDKs send by the same rule: Mixpanel's `$el_attr__href`, Amplitude's `[Amplitude] Element Href`, PostHog's `$external_click_url`, and the `href` values inside PostHog's `$elements` and `$elements_chain`. If Sequential cannot read such a field, it drops the whole field when it holds a link, so a link is never stored unread. Other addresses inside PostHog's elements, such as `attr__src`, stay as they are. Each is up to 128 characters, after redaction.
>
> The `data-sq-mask` and `data-sq-private` attributes keep them out. `data-sq-private` also keeps out the element's id and the ids in its selector. The `sq-mask` class does not. Prefer the attributes. From 10 October 2026, the SDK also leaves out the text and `data-*` values of a click in account UI, or whose text names the signed-in person. See [Sequential SDK](/docs/sequential).
>
> From 18 October 2026, Sequential also checks element text from every SDK when it stores an event: an email, a card number, a JWT or a Bearer or Basic credential becomes `[redacted]`. See [Privacy at a glance](/docs/privacy-overview#what-sequential-removes-automatically).

### Change the preset

1. If you move to **Balanced** or **Custom**, first add `data-sq-mask` and `data-rr-block` to your pages. Deploy them.
2. Go to **Settings** › **Recording & data**.
3. Under **Privacy and masking** › **Masking level**, choose **Strict**, **Balanced** or **Custom**. Click **Save changes**.
4. If the app asks for the slug, type the project slug in the field. Click **Save and record more**.

A looser preset applies from the next page load.

### The box that asks for the slug

The box opens if the change records more (for example, **Strict** to **Balanced**). It says "This records more than before." and lists what the change records.

The field shows the slug, for example "Type `web-shop`, the project’s slug, to save". Spaces before or after the slug do not matter. **Save and record more** stays unavailable until the text matches.

Every save appears in the [Audit log](/docs/audit-log).

### Mobile apps

On iOS and Android, PostHog's mobile SDK masks on the device. Its defaults are private. You set the masking in your app's code. The project's masking settings do not apply to the recording itself.

Attribute masking (`mask_attributes`) does not apply to mobile recordings. They are not web pages and carry no HTML attributes. The mobile SDK's own masking still masks them.

**Attribute values** still applies to the DevTools data that an app sends. Sequential's servers shorten its request addresses and the code locations of its logs under that setting, as they do for the web. Under **Record on**, the settings page says: "What an app sends is then filtered by the console and network settings under What a recording carries and by Attribute values, and refused past Largest recording."

On iOS, autocapture can also send the text that a person types in a text field. This happens only if your app turns it on.

[Mobile apps](/docs/mobile) covers the SDK's defaults, how to mask your own views and how to keep a text field out.

## Redaction in DevTools data

Redaction is always on. It replaces JWTs, `Bearer` and `Basic` credentials, email addresses, card numbers and values under sensitive keys with `[redacted]`. Sensitive-key redaction does not work on an object your app turns into a string first, such as `JSON.stringify(user)`.

Redaction catches shapes, not meaning. It does not catch names, phone numbers, postal addresses, one-time links, or API keys that are not JWTs. Keep secrets out of what your app logs and throws.

### Exact shapes redaction catches

Redaction replaces these values with `[redacted]`:

- JWTs.
- `Bearer` and `Basic` credentials. The word `Bearer` or `Basic` stays.
- Email addresses.
- 15- and 16-digit card numbers that pass the card-number checksum. The digits can be one run, or have a single space, dash or `+` between them.
- In objects your app logs to the console, the value under a key such as `password`, `secret`, `token`, `auth`, `cookie`, `session` or `apikey`. This does not work on an object your app turns into a string first, such as `JSON.stringify(user)`.

### Forms that redaction misses

Redaction catches only the exact shapes above. The exception is a value under a sensitive key in a logged object. Redaction also misses a recognisable value in a slightly different form.

These are kinds of gap, not a complete list:

- A JWT written straight after a letter, digit, `_` or `-`.
- A JWT whose dots are encoded in console or error text (`%2E`, `.`).
- A `Bearer` or `Basic` credential shorter than 8 characters.
- A `Bearer` or `Basic` credential joined to the word by anything other than a space (`Bearer:…`, or `Bearer%20…` in console or error text).
- An email address with an accented or other non-ASCII letter (`josé@…`, `…@münchen.de`). Redaction misses all of the address, or part of it.
- An email address written with `%40` in console or error text.
- A card number of another length, or split another way: two spaces, ` - `, a tab, a non-breaking space or dots between the groups.
- An object your app turns into a string before it logs it (`JSON.stringify(user)`). The result is text, so redaction does not check its keys.

### Network requests: how Sequential cleans a URL

Sequential stores each request's method, URL, status, timing and size. It never stores the headers or the body.

Two lists control the URL:

- They are under **Network requests**, in **What a recording carries**.
- They work only while **Network requests** is ticked. The app shows them only then.
- Each list takes one entry per line.

| Setting | What it does |
|---|---|
| **Query values kept** | Keeps the values of the query parameters you list. Sequential replaces every other `name=value` value with `[redacted]`. |
| **Requests ignored** | Leaves out every request whose URL matches a pattern. For example, `**/oauth/**` leaves out every call under an `/oauth/` path. |

When you add a parameter to **Query values kept**, the app asks for the project slug.

- Parameter names stay. For a redacted value, the request in a replay shows `[redacted]`.
- Under **Masked** and **Kept, URLs cut to the path**, a query item with no `=` (such as `?a1b2c3`) becomes `[redacted]`. Under **Balanced**, Sequential keeps it, unless it looks like a JWT, email address or card number.
- If a kept value contains a JWT, a `Bearer` or `Basic` credential, an email address or a card number, Sequential replaces the whole value with `[redacted]`.
- Sequential drops the `#fragment` and any `user:pass@`.
- Sequential replaces a path segment that looks like a JWT, email address or card number.
- **Attribute values** also changes the path. Under **Strict**, a file that the page loads keeps only its domain and has no query, and an API call keeps its route. See **What each preset masks**.

**Pattern syntax.** Patterns match the full URL without its query. `*` stays within a path segment. `**` crosses segments. The help under the field says: "One pattern per line, matched against the whole URL without its query. * stays within a path segment, ** crosses them. For example https://api.example.com/health*."

**Errors and console entries.** Script URLs and stack traces keep no `name=value` query values. Each value becomes `[redacted]`, whatever **Query values kept** lists. A query item with no `=` follows the same rule as in request URLs.

## Console message text

**Console message text** is off by default. We recommend that you leave it off in production until you check what your app writes to the console. Turning it off again does not remove text that is already stored.

### What a console entry keeps without message text

Without **Console message text**, each console entry keeps:

- its level,
- how often it happened,
- where it was logged,
- a stack trace, for warnings and errors.

### Should you turn on message text?

| Question | Answer |
|---|---|
| **What you gain** | The words your app logged, such as "payment failed: card_declined" or an API error body. You know why `console.error` fired at `cart.js:42`, not only that it fired. |
| **The risk** | Sequential stores whatever your app writes to the console, with the recording. Everyone with access to the project can watch its replays, viewers included. Redaction does not catch `console.log("reset link for", user, "is", url)`, or a logged API response full of personal data. |
| **What we recommend** | Leave it off in production by default. You can turn it on in a staging or development project. Turn it on in production only after you check what your app writes to the console. |

Settings are per project. Separate staging and production projects give you both ([Organisations, projects and keys](/docs/organisations-and-projects)).

### Turn on message text

1. Go to **Settings** › **Recording & data**.
2. Under **What a recording carries**, make sure that **Console output** is ticked. It is ticked by default.
3. Tick **Console message text**. It shows only while **Console output** is ticked.
4. Click **Save changes**.
5. In the box that opens, type the project slug.
6. Click **Save and record more**.

### When you turn message text off again

- Turning it off stops Sequential from storing new text. It does not remove text that is already stored. [Retention and deletion](/docs/retention-and-deletion) covers what happens to existing recordings.
- While it is off, Sequential's servers empty message text as it arrives. This includes text from an older recorder or a mobile SDK that sends it anyway.
- Sequential asks iOS and Android apps for logs only while it is on. The page says: "On iOS and Android, logs are requested from the app only when Console message text is on."

## What it needs

- On websites, Sequential's recorder, from [Session replay (web)](/docs/session-replay) or the [Sequential SDK](/docs/sequential). The recorder applies the masking settings. Sequential's servers also apply attribute masking, input masking and DevTools address masking to every web recording that arrives.
- On mobile, PostHog's iOS or Android SDK sending to Sequential. The project's masking settings do not apply to the recording there ([Mobile apps](/docs/mobile)). **Attribute values** still shortens the DevTools addresses that the app sends.
- An owner or admin to change the settings ([Roles and permissions](/docs/roles-and-permissions)).

## Limits

- If you choose **Strict** or **Balanced**, the preset overwrites all six fields under **Masking level**. Your custom selectors are lost.
- **Text masking depends on the recorder.** Sequential's servers do not re-mask page text, and cannot block an element. Sequential cannot enforce that masking on a modified recorder, or on anyone who sends data with your project's public replay key. The servers do mask attribute values, addresses, input values and DevTools addresses again, under the project's current settings.
- **A hidden field that changes later.** The servers check a later value change of a hidden field only within one upload. The recorder masks every such change before it sends. A recorder that a browser cached from before this rule does not.
- **Nothing is retroactive.** Tighter masking does not re-mask existing recordings. You cannot undo looser masking for recordings made while it was in force, or fix a recording made before you marked an element.
- **Masked text keeps its shape.** Spaces stay, so a viewer can see how long each word was.
- **Error messages are kept even with message text off.** On websites, uncaught errors and unhandled promise rejections keep their message, after redaction.
- Under **Balanced**, Sequential keeps a query item with no `=`, such as `?a1b2c3`, unless it looks like a JWT, email address or card number.
- If you also send an error as an analytics event, such as with `captureException`, the judge can see a short excerpt of it.

### Errors that reach the judge

Keep personal data out of the errors your code throws.

The judge never sees the replay's copy of an error. At most, it sees how many errors there were.

If you also send an error as an analytics event, the judge can see a short excerpt of it. For example, the Sequential SDK's `captureException` sends one. [AI and third parties](/docs/ai-and-third-parties) covers this.

## Related

- [Recording settings](/docs/recording-settings)
- [DevTools](/docs/devtools)
- [Page URLs](/docs/url-policy)
- [AI and third parties](/docs/ai-and-third-parties)
- [Retention and deletion](/docs/retention-and-deletion)
- [Privacy at a glance](/docs/privacy-overview)
