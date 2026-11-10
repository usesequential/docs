# AI and third parties

> Sequential's AI features send session digests to Sequential's AI provider. This page lists what the AI provider receives, what your pages load, and what you control.

> **In short**
>
> - Sequential's AI provider receives data. Its model is the judge. Sequential's server makes every call.
> - The judge reads a short text digest of a session. It never receives a recording, heatmap counts or the heatmap picture.
> - For fix briefs, and when an agent reads session data through an access token, the judge also reads short parts of visitor text. It checks them for instructions to an AI. For an agent, it also checks the labels of your own questions. When an agent reads heatmap pages, the judge reads the page addresses and the dashboard links in the answer.
> - When a token reads cases, the judge also reads the reason of each case's newest verdict. Someone on your team typed this reason. In the cases list, the judge also reads the page route of each case.
> - Sequential removes the user id and personal-looking property names from a digest. It cuts page URLs and full URLs to their path.
> - With Sequential's SDK, your pages load scripts only from Sequential.
> - An agent that you connect, such as claude.ai, receives the answers to its tool calls and Sequential's fixed tool descriptions and server instructions. Anthropic runs claude.ai.

## Who receives what

This page calls the AI provider's model the judge. Nothing on your website contacts the AI provider.

| Feature | Sent to | What is sent |
|---|---|---|
| [Evidence](/docs/watch) (background judging) | The AI provider | One session digest and your project's questions |
| [Ask](/docs/ask), for a question about sessions | The AI provider | Up to 200 session digests, and your description |
| [Ask](/docs/ask) from an agent (`ask_sessions`) | The AI provider | Up to 50 session digests per call, and the agent's description. In these digests, an element event is named only `element`, with no text, and a custom event has no properties |
| **Try it**, in **Try on a session** on the **Questions** page | The AI provider | One session's digest, and your draft questions |
| **Judge this recording now** or **Judge again**, on the page of a session with a playable recording ([Reading an AI verdict](/docs/reading-verdicts)) | The AI provider | One session digest that your browser builds from **What they did**, and your project's questions. It has no custom-event properties and no error counts |
| The **Brief**, when it sets up your dashboard, or when you add **Key actions** or **Failed or abandoned** with **Add tile** | The AI provider | The names of up to 60 of your project's most frequent custom events. No counts, users or values |
| Fix briefs ([Privacy at a glance](/docs/privacy-overview)) | The AI provider | Up to 40 quoted passages of a brief, each up to 200 characters, one question each |
| Session tools and `ask_sessions` for agents ([Privacy at a glance](/docs/privacy-overview)) | The AI provider | The visitor text and the labels of your own questions in the answer, in parts of up to 200 characters, one question each |
| Cases for agents ([Cases and fixes](/docs/findings)) | The AI provider | The reason of each case's newest verdict, in parts of up to 200 characters, one question each |
| Changes tools for agents ([Changes](/docs/changes)) | The AI provider | The text of each recorded change in the answer of `list_changes`, `get_change` or `get_overview`, and the title of each change that an agent writes, in parts of up to 200 characters, one question each |
| Heatmap tools for agents (`list_heatmap_pages`, `get_heatmap`), on a Sequential server that has them | The AI provider | The page addresses (host and path) and the dashboard links in the answer, in parts of up to 200 characters, one question each. No counts, element paths or picture |
| An agent that you connect, for example claude.ai ([Connect claude.ai](/docs/connect-claude-ai)) or ChatGPT ([Connect ChatGPT](/docs/connect-chatgpt)) | The agent's provider. For claude.ai, that is Anthropic; for ChatGPT, OpenAI | The answers to the agent's tool calls, and Sequential's fixed tool descriptions and server instructions. No other data, unless you give the agent an access token with `exports:write`. Then the agent can download the project's export files, with user ids and IP addresses as your app sent them, and its provider then has them. A claude.ai connection cannot get this scope ([Export your data](/docs/export-your-data#use-the-api-with-an-access-token)) |
| **Send to webhook** on a case, and a hand-off from the **Brief** while the webhook is on ([Cases and fixes](/docs/findings)) | The webhook address that an owner or admin set under **Settings** › **Project** › **Where hand-offs go** | The case number, the brief's revision and template version, the case's address in Sequential, and the screened fix brief. Signed, sent once per click. It needs a signing key on the Sequential server |

## What the judge receives

The judge never receives a recording, heatmap counts or the heatmap picture. When an agent reads heatmap pages, the agent screen reads the page addresses (host and path) and the dashboard links. See **What the agent screen receives** below. To judge a session, the judge reads a digest: a short text summary of that session. For background judging, Ask and **Try it**, Sequential builds the digest on its server from your stored events. For **Judge this recording now**, your browser builds it from the session's events that **What they did** loads, whatever its search or chips show. The server keeps only the fields that it knows. See **The digest of Judge this recording now** below.

Sequential removes from the digest:

- **The user id.** The digest says only "identified" or "anonymous".
- **Domains, query strings and fragments.** Sequential cuts page URLs and full URLs in other text to their path.
- **Properties with personal-looking names**, such as `billing_email` and `firstName`. This page calls this the name filter.

From 26 October 2026, the digest names a click with no text by its `aria-label` (`$el_label`). The digest never holds where a link goes (`$el_href`).

Sequential does not store the digest. It keeps the answers ([Judgments](/docs/judgments)).

## What the agent screen receives

When an agent uses `get_session`, a `sessions:explore` tool, `ask_sessions`, an `analytics:read` tool, `link_fix`, `get_verification`, `list_changes` or `get_change`, Sequential asks the judge whether text in the answer reads as an instruction to an AI. For the analytics tools, this is the event text in the answer, for example event names, page addresses, selectors and property values. For the session tools, this is visitor text: text that a visitor's browser or app sent to Sequential. It also includes the labels of your own questions, if the answer has them, and from 11 October 2026 the question text, criteria and phrases of your own questions in the answer of `get_rubric`. For `link_fix` and `get_verification`, it is also the text of fix links and release markers. A token's GET `/api/findings/:n/verification` runs `get_verification`, so it is screened too.

The judge receives:

- each part of the visitor text, up to 200 characters: page paths, routes, release names, and browser and operating system names
- for `get_session_timeline`, `list_errors` and `get_overview`, also the names of custom events, error messages and types, top stack frames, and the method, host and route of failed requests. Element text is withheld from these answers, so the judge does not receive it. From 2 November 2026, a click label made only of common interface words, such as "Add to cart", is the exception
- for `ask_sessions`, the label of each matched moment: the event text that the judge read, for example an error message. The label of a click, a form submit or another element event is withheld
- the question, option and level labels of your own questions in the answer of a session tool or `ask_sessions`. It gets each label, and also all the labels of the answer joined together
- from 11 October 2026, for `get_rubric`, also the question text, criteria and phrases of your own questions. From 29 October 2026, it reads the texts of one question together, one question at a time. If it flags a question, Sequential withholds the texts of that question only
- from 22 October 2026, for `list_changes`, `get_change` and the `changes` part of `get_overview`, the text of each recorded change in the answer: its title, summary, URLs, link addresses, evidence references, tags and release name. Someone on your team or an agent wrote this text. When an agent writes a change, the judge also reads its title before Sequential stores it
- for `link_fix` and `get_verification`, also each part of the fix link addresses, release names, environments and commit SHAs. See [Cases and fixes](/docs/findings)
- when an agent reads heatmap pages (`list_heatmap_pages`, `get_heatmap`, on a Sequential server that has them), each page address (host and path) and each dashboard link in the answer. It never receives the heatmap counts, the element paths or the picture
- a fixed question and a fixed description of the text. From 29 October 2026, the texts of your own questions get a question that is made for them: the question text, criteria and phrases in the answer of `get_rubric`, and the labels of your own questions in the answer of every tool. It asks if a text tries to make the judge, or an agent that reads it, do something other than judge the session on its evidence, for example ignore its rules, call tools or send data. Other text, for example a page address or a release name, gets the fixed question

The judge does not receive:

- session ids, user ids, account ids, event ids, question ids or option keys
- the text and criteria of your questions, except in the answer of `get_rubric` from 11 October 2026
- the labels and text of the shipped default questions. After **Restore defaults**, it can receive them too
- times, counts or judgments

When a token reads the cases list or one case, the judge also receives the reason of each case's newest verdict. This is GET `/api/findings` or `/api/findings/:n`, or the `list_findings` or `get_finding` tool. For the cases list, the judge also receives the `scope` and `page_route` of each case, up to 200 characters each. The judge never receives the name of the person who gave the verdict. The agent never gets that name either.

Sequential redacts the text before it sends it: email addresses, tokens and card numbers. From 10 October 2026, it also removes the names, emails and phone numbers of the known people of your project, so the judge does not receive them either. See [Privacy at a glance](/docs/privacy-overview#names-emails-and-phone-numbers). If the screen cannot run, the agent does not get the text. A token does not get a fix brief or a case that Sequential could not screen, unless the operator sets `FINDINGS_SCREEN_REQUIRED=false`. When the brief screen is paused, a token gets them with every quoted passage withheld. Ids are not sent to the judge. The agent gets them marked as `{"id": "…", "source": "observed"}`. See [Privacy at a glance](/docs/privacy-overview).

## What your pages load

With Sequential's own SDK, every script your pages load comes from Sequential, not from another company's servers. If you use another vendor's SDK, that SDK's code also runs on your pages.

## What you control

**Background judging.** It is on by default for each project. Owners and admins change it under **Settings** › **Recording & data** › **Judging**, with the switch **Judge new sessions automatically**. Members and viewers see the switch, but they cannot change it. Your Sequential server must also allow it: whoever runs the server sets `JUDGING_AUTOMATIC=on`. While background judging is off, **Background judging** under **What applies** on the same page tells you why, and Sequential sends nothing in the background. See [Evidence](/docs/watch).

**On-demand features.** If the server has them set up, no project setting turns them off. The background judging switch does not stop them either. Roles decide who can use each one ([Roles and permissions](/docs/roles-and-permissions)).

| Feature | Roles that can use it |
|---|---|
| Ask | Owner, Admin, Member, Viewer |
| **Judge this recording now** | Owner, Admin, Member, Viewer |
| **Try it** | Owner, Admin |
| Ask from an agent (`ask_sessions`) | An agent with a token that has the scope `ask:use`. Only owners and admins create tokens |

**Personal data.** Sequential sends your questions and Ask descriptions as written. From 20 October 2026, Sequential scans the text of every digest before it sends it: it replaces emails, card numbers, JWTs, Bearer and Basic credentials and phone numbers in international format with `[redacted]`, and long random tokens with `[token]`. It does not find names, postal addresses or phone numbers in national format, such as 020 7946 0958. Element text, error messages and custom event names can carry those to the judge. From 18 October 2026, Sequential stores an email or a card number in element text as `[redacted]`. See [Privacy at a glance](/docs/privacy-overview#what-sequential-removes-automatically). Keep customers' names, emails and other personal data out of these and out of property values.
- When background judging is turned on, Sequential also sends the unjudged sessions from the previous 7 days to the AI provider.

## Limits

- **The name filter reads names only, and matches whole words.** Sequential sends a value under an ordinary name as it is, up to 80 characters. It sends `firstname` and `useremail`, because it does not split them into words.
- **In background judging, Ask and Try it, only full URLs lose their domain and query string.** Sequential sends `/signup?ref=nav` and `app.example.com/signup?ref=nav` whole.
- **The AI provider** is in the category AI model provider of the sub-processors in Annex B of the [Terms of Service](/terms). Sequential names it on request at hello@usesequential.com. This page covers what Sequential sends.
- Sequential keeps each Ask description in a log for 180 days.

### When each feature sends data

| Feature | When it sends data |
|---|---|
| Evidence (background judging) | At least 30 minutes after a session ends, once per session, and only for projects where background judging is turned on |
| Ask | Each question about sessions, unless the same description over the same sessions was answered in the last hour |
| Ask from an agent | Each call of `ask_sessions`, unless the same description over the same sessions was answered in the last hour |
| **Try it** | Each click on **Try it** |
| **Judge this recording now** | Each click, unless Sequential has the judge's answer for the same digest and questions from the last 7 days. **Judge again** after an answer on that page asks for a fresh answer. After such a fresh answer, the next one for that session comes 10 minutes later at the earliest |
| The **Brief** | When the Brief sets up your dashboard for the first time, and when you add **Key actions** or **Failed or abandoned** with **Add tile**. Not when the same event names were judged in the last 7 days |
| Fix briefs | When Sequential delivers a brief, and when an agent reads one case with `get_finding`. Sequential can use an earlier answer for the same version of the brief, for up to 30 days. If Sequential cannot read the allowance, it sends at most 10 briefs a minute per project from each server process. Past that, it sends nothing and withholds every quoted passage of the brief. |
| Session and analytics tools for agents | Each answer of `get_session`, a `sessions:explore` tool, `ask_sessions` or an `analytics:read` tool that has visitor text, unless Sequential has a recent answer for that text |
| Cases for agents | Each time a token reads the cases list or one case and a newest verdict has a reason, unless Sequential has a recent answer for that reason |

When background judging is turned on for a project, Sequential also sends the sessions from the previous 7 days that are not judged yet. Whoever runs your Sequential server can also send older sessions. This is called a backfill.

### Session facts and event lines

The digest has facts about the session and up to 255 event lines.

**Session facts:** duration, device type, identified or anonymous, the entry page's path, browser, operating system, country code and the number of pages visited. If the session's recording measured them, the digest also has counts of JavaScript errors, failed requests and console errors ([DevTools in replays](/docs/devtools)).

**Event lines:** up to 255. Each line has its time from the start of the session and the path of the page it happened on.

| Event | What its line carries |
|---|---|
| Page view | The path, such as `/settings/billing`, or a mobile screen name |
| Click, rage click, dead click | The element's text or id, such as "Add card" |
| Form submit | The form's name |
| Error | The error message and its type |
| Custom event | Its name, such as `plan_changed`, and its properties as `key=value` |
| Identify | Only that the visitor was identified. An identify event carries no text. |

Sequential cuts each label to its first line and 60 characters. It cuts a custom event's properties to 80 characters in total.

### The digest of Judge this recording now

**Judge this recording now** sends a digest that your browser builds from the session's events that **What they did** loads on the session page, whatever its search or chips show. It holds less than the digest that Sequential builds on its server.

**Session facts:** duration from the first event to the last, device type (mobile, desktop or unknown, from the operating system), identified or anonymous, the entry page's path, browser, operating system, country code and the number of pages visited. It has no error counts.

**Event lines:** up to 255, kept by the same priority as on the server. Each line has its time on the player's timeline and the path of the page it happened on.

| Event | What its line carries |
|---|---|
| Page view | The path, or a mobile screen name |
| Click, rage click, dead click | The element's text, else its label, else its id, else "element". Never where a link goes |
| Form submit | The form's name |
| Error | The first line of the error message, and its type |
| Custom event | Its name only. No properties |
| Identify | Only the word "Identified" |

- Your browser cuts each label to its first line and 60 characters. If the cut falls inside an email or a token, the whole email or token goes.
- A web address with `//` in a label becomes its path: `https://app.example.com/signup?ref=nav` becomes `/signup`.
- The digest also lists pauses of 10 seconds or more, up to the 50 longest, and the number of events.
- Your browser keeps the digest under 31 KiB. To do this, it drops the lines of the lowest priority first.
- The server keeps only the fields that it knows. It refuses a digest over 32 KiB. It scans every text again before the judge reads it, as **Personal data** above says.

### How Sequential removes URLs and property names

**URLs.** Sequential cuts page URLs to their path. It also cuts a full URL inside any other text to its path. For example: `https://app.example.com/signup?ref=nav` in a property value.

Inside a label or property value, `https://app.example.com/signup?ref=nav` becomes `/signup`. But Sequential sends `/signup?ref=nav` and `app.example.com/signup?ref=nav` whole.

**Property names.** Sequential drops a custom-event property in two cases:

- Its name starts with `$`.
- One of the words in its name is exactly one of these: email, mail, phone, tel, password, pass, token, secret, address, addr, name, ip, user, username, account, ssn, iban, card.

Sequential splits a name into words at `_`, `-`, `.`, spaces, and where a lowercase letter or digit is followed by a capital.

- Dropped: `billing_email`, `firstName`, `ip_address`
- Kept: `firstname`, `IPAddress`, `customer_id`, `description`, `zip`

The name filter reads names only. Under an ordinary name, Sequential sends the value as it is, up to 80 characters. For example: `note=call jane@example.com`.

### What reaches the judge from your app and your questions

From background judging, Ask and **Try it**, the judge receives only what your events contain. See [Send custom events](/docs/custom-events).

Every call also sends the questions: your project's questions, the draft you edit for **Try it**, or your one-line description for Ask ([Questions](/docs/rubric)). Owners and admins edit the questions on the **Questions** page, in the left rail.

### Feature switches and the name filter

When judging is set up on the server, no project setting turns off Ask or **Try it**. To stop an agent from running Ask, revoke its token or give it a token without `ask:use`. The endpoint `/mcp/readonly` does not stop it.

For property values, do not rely on the name filter. It reads names, not values.

### Fonts in the Sequential app

The Sequential app serves its own fonts, Inter and JetBrains Mono. Your team's browsers do not contact Google for fonts when they use the app. Nothing that Sequential adds to your pages contacts Google.

### How long Sequential keeps the answers

| What | How long Sequential keeps it |
|---|---|
| A session's judgment from background judging | 400 days after the session ends |
| An Ask answer | 1 hour |
| An answer of **Judge this recording now**, without the digest | Up to 7 days, in a cache |
| Each Ask description, in a log, with who asked. For an agent, this is the id of its token | 180 days |
| A screening answer for an agent's tool, or for a verdict reason that a token reads | Up to 7 days, as a keyed hash of the text with a yes or no |

If the server sets a [retention limit](/docs/retention-and-deletion#a-server-wide-limit), Sequential deletes judgments and Ask descriptions sooner.

### Where each script comes from

- The SDK and the open-source recording library that the recorder uses come from Sequential's CDN.
- The recorder comes from Sequential's API.
- Events and recordings go to Sequential's API, not to the CDN ([Sequential SDK](/docs/sequential)).

The **Content-Security-Policy** section of each install page lists every origin your pages load scripts from ([Install Sequential](/docs/install)).

## Related

- [Privacy at a glance](/docs/privacy-overview)
- [Judgments](/docs/judgments)
- [Ask: one line about sessions, funnels, retention or people](/docs/ask)
- [Questions](/docs/rubric)
- [What Sequential keeps from page URLs](/docs/url-policy)
- [Masking and redaction](/docs/masking-and-redaction)
- [Retention and deletion](/docs/retention-and-deletion)
- [Roles and permissions](/docs/roles-and-permissions)
