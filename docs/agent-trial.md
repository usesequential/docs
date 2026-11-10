# Let your agent set up a trial

> A coding agent can create a Sequential trial for you with one call, before you have an account. You claim it from an email to keep it.

> **At a glance**
>
> - **For:** Coding agents: [Install Sequential for a person](#install-sequential-for-a-person-coding-agents).
> - **Know this:** [Claim the trial](#claim-the-trial) within 72 hours, or Sequential deletes it. If you do nothing, a reminder email comes after 48 hours.
> - **Know this:** Before the claim: websites only on `localhost`, no mobile recordings, at most 100 sessions, no AI judging.

> **In short**
>
> - From 22 October 2026, a sign-in with the trial's verified address adds the trial to your account. Then [accept the terms](#accept-the-terms-of-a-trial-added-at-sign-in).
> - [Not you?](#not-you) Delete the trial through the email. This blocks your address from agent trials. Nothing undoes the block.

## Install Sequential for a person (coding agents)

No account is needed to start.

### For coding agents

1. **Create a trial.** Send one call: `POST https://api.usesequential.com/api/agent/provision` with the JSON body `{"owner_email": "<the person's email>", "platform": "web"}`. `platform` is `web`, `ios`, `android` or `react-native`. If you do not have the person's email, ask for it. The answer is 201 with `ingest_key`, `install.snippet` (the code that adds the SDK, with the key in it) and `claim_url`. [What the agent calls](#what-the-agent-calls) and [Errors and what the agent should do](#errors-and-what-the-agent-should-do) give the details.
2. **Add the snippet.** On a website, use the [Sequential SDK](/docs/sequential). Keep both parts of the snippet: the small inline script and the tag. The inline script keeps calls such as `sequential.identify()` until the SDK loads. The key of a trial works only with the Sequential SDK on a website, and with the PostHog SDK in an iOS, Android or React Native app ([Mobile apps](/docs/mobile)). To keep the PostHog, Mixpanel, Amplitude, Pendo or Smartlook SDK of a website, the person claims the trial first. Then the person copies the key of that source on Settings › Setup ([Install Sequential](/docs/install)).
3. **Check that events arrive.** Before the claim, a website trial accepts events only from `localhost`. Run the site on your computer and open a few pages in a normal browser, or ask the person to do it. Sequential refuses a browser that runs headless or says that it is a bot, so a check with a headless browser shows nothing. A mobile trial accepts events from any build. Recording starts after the claim.
4. **Tell the person to claim the trial within 72 hours.** The email "A Sequential project was set up for this address" has the link. Before the claim, the trial accepts at most 100 sessions. The claim stops the localhost rule and the limit of 100 sessions. After the claim, Sequential records mobile apps and judges new sessions.

### What the agent calls

POST `/api/agent/provision` with a JSON body. It needs no account and no token.

| Field | Value |
|---|---|
| `owner_email` | The address that will claim the trial. Required. At most 254 characters |
| `platform` | `web`, `ios`, `android` or `react-native`. Required |
| `project_name` | Optional. At most 64 letters, digits, spaces or `-_.`. The default is "Trial project" |

The answer is 201 with:

- `project_id` and `ingest_key`
- `mcp.url` and `mcp.token`: the agent's access to the trial over MCP
- `claim_url`, `expires_at` and `limits`
- `install.snippet`: the code that adds the SDK. For `web`, it is the snippet of [Sequential SDK](/docs/sequential) in two parts: a small inline script and the tag. For a mobile platform, it is one line for the PostHog SDK. And `install.docs`: this page
- `terms_url`: the address of the Sequential [Terms of Service](/terms)

### Errors and what the agent should do

| Answer | Cause | What to do |
|---|---|---|
| 404 `not_found` | Trials are off on this server | Use a normal account |
| 400 `invalid_body` | A field is missing or wrong | Fix the field that the message names |
| 429 `trial_rate_limited` | Too many trials from this network (5 an hour, 20 a day), for this email domain (30 a day), or 3 unclaimed trials for this address | Wait for Retry-After |
| 503 `trial_unavailable` | Sequential cannot check the limits, or there are too many unclaimed trials | Wait for Retry-After |
| 403 `trial_origin_locked` | Events from a site that is not local | Run the app on localhost, or claim the trial |
| 403 `trial_replay_after_claim` | A mobile app sent a recording | Claim the trial |
| 402 `trial_session_cap` | The trial used its 100 sessions | Claim the trial |
| 401 `unknown_ingest_key` | The trial expired. The key stops working within about a minute after expiry. Sequential deletes the trial within the next hour | Set up a new trial |

## Claim the trial

1. Open the link in the email "A Sequential project was set up for this address".

2. Sign in, or create an account, with the same email address. The address must be verified.

   Result: If the link page says "This trial is already yours", Sequential added the trial to your account when you signed in. Then skip steps 3 and 4, and [accept the terms](#accept-the-terms-of-a-trial-added-at-sign-in).

   **If you create your account from the email link**

   From 11 October 2026, the link in the email also proves that you got the email. Create your account from that link, in the same browser tab, with the address the trial was sent to. Sequential then creates the account already verified. It sends no second email, and you go straight back to the link.

   The proof works once, for 24 hours after the email, and only while the trial is not claimed or expired. The link in the agent's answer and the link in the reminder email do not have the proof. A reload, a new tab or another address gets the usual email with a verify link.

3. Enter a **Team name** (at most 64 characters).

4. Click **Claim the project**.

Result: You become the owner of its organisation, and recording and AI start to work as in any project.

Or sign in and go to `/claim`. It lists the trials that wait for your address, each with its own Team name and Claim it button.

No sessions yet? Before the claim, a website trial accepts events only from `localhost`. Sequential refuses a browser that runs headless or says that it is a bot. Until you [accept the terms](#accept-the-terms-of-a-trial-added-at-sign-in) of a trial added at sign-in, the app shows none of its data.

### What a trial can do before you claim it

| What | Before the claim |
|---|---|
| Websites | Only on your own computer. Sequential accepts events only from `localhost`, `*.localhost`, `127.0.0.1` and `[::1]`. |
| Mobile apps | Events, but no recordings. Recording starts after you claim the trial. |
| Sessions | 100 sessions. |
| Time | 72 hours. Data is kept 7 days. The 7 days also apply after you claim the trial. |
| AI | No AI. Sequential does not judge the sessions, and the agent tools withhold visitor text as `{"withheld": "not screened"}`. Sequential sends nothing to the judge. |

What Sequential keeps from a trial, and for how long: [Privacy at a glance](/docs/privacy-overview#agent-trials).

> **What the localhost rule does not prevent**
>
> The localhost rule reads the Origin that the browser sends. A script that sends a false Origin can still send up to 100 sessions into the trial project. Sequential deletes that project after 72 hours if nobody claims it.

### Messages on the claim pages

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Sign in, or create an account, with the email address your agent used. Then the project is yours." | Link page | You are not signed in. Its Sign in and Create account both bring you back to the link. | Sign in, or create an account, with the same email address. |
| "Your address is not verified yet. Verify it, then come back to this link." | Link page | The address must be verified, and it is not. The page shows the message with Verify my address. | Click "Verify my address". |
| "This claim link cannot be used with this account. Sign in with the address the trial was sent to, or create an account with it." | Link page | This account cannot claim the trial. | Click "Sign out and use another address". The page then shows "Sign in" and "Create account" again. |
| "This claim link cannot be used" | Link page | The trial expired or someone claimed it, or the link is not complete. The page adds "The trial may have expired or been claimed already, or the link is incomplete." and "Signed up with the address your agent used? Then the trial is probably yours already: sign in to see it. Otherwise ask your agent to set up a new one." Before it offers the claim, the page checks the link. If Sequential cannot check the link, the page shows the usual steps. | Signed up with the address your agent used? Sign in to see the trial. Otherwise ask your agent to set up a new one. |
| "Already signed in with that address? Then the trial has expired or was claimed. Ask your agent to set up a new one." | After Claim the project | At Claim the project, Sequential checks the link again. Then the page gives one answer in every case: a different address, a trial that expired, or a trial that someone claimed. It never shows the address the trial was sent to. This line is under that answer. | Ask your agent to set up a new one. |
| "This trial is already yours" | Link page | Sequential added the trial to your account when you signed in. | Click "Open it". |
| "For a website, expires in 2 days (24 Oct 2026, 14:00)." | `/claim` | An example. Each trial shows its platform and when it expires, in your browser's time zone. | — |
| "No trial waits for this address. An agent sets one up for the address it is given." | `/claim` | No trial waits for the address that you signed in with. | Click "Sign out" and sign in with the other address. You can also click "Go to your brief". |

## Accept the terms of a trial added at sign-in

From 22 October 2026, when you sign in with a verified address, Sequential adds every trial that waits for that address to your account at once. You do not click Claim.

You become the owner of the organisation of each trial, and Sequential opens the newest project that it added. Before you use a project that Sequential added this way, accept the terms once.

1. On the card "Accept the terms to use this project", click **Accept and continue**.

Result: The card then goes, and the page opens.

### What waits until you accept the terms

Until you accept, the app opens no page of the project except Settings. It shows and reads none of the project's data. This applies to every project in the organisation of the trial, also in your other tabs.

- Ask or jump shows no recent picks, cases, people or saved views of the project.
- While the project is open, the rail shows no decisions that wait for you.
- An open peek of a session or a person closes.
- On All projects, the project says "Accept its Terms to see its activity."

Sequential sends the terms that you still owe together with your list of projects. So every other page opens at once, with no separate read.

A tab can open a project that is not in its list of projects yet, for example a trial that you claimed in another tab. The page then stays empty while the app reads your list of projects again. If the new list has the project, the terms card or the page shows. If not, the app opens another of your projects.

The Sequential API refuses the same reads. Until you accept, a request for the project's data, with your sign-in or with a token that you made, gets 403 `terms_pending` with the message "Accept the trial terms and DPA for this project first." The accept click, your list of projects and the project's settings still work. The token that the agent got when it set up the trial is not yours, so it keeps reading until it expires. When the app gets this answer, it shows the terms card for the project at once, in place of an error, and reads your list of projects again.

Until you accept, Sequential does not judge the sessions of the project, and the agent tools withhold visitor text as `{"withheld": "not screened"}`.

#### Messages after an automatic claim

| Message | Where | What it means | What to do |
|---|---|---|---|
| "We added the project “<name>”, set up for <your email>. Not yours? Delete it in Settings." | Notice | Sequential added a trial to your account. The name is the text that the agent chose. | Click "Dismiss" to close the notice. |
| "An agent token can read this project until <date>." | Notice | The notice also says this while the agent's token works. With it is "Revoke it", which opens Settings › Agents & tokens of that project. | — |
| "Checking for a trial an agent started for you…" | Onboarding | If you have no organisation yet, onboarding first says this. | — |
| "An AI agent set up “<name>” for <your email>. Before you see its data, accept the Terms, which include the data processing terms." | Terms card | The card that Sequential shows in place of the page until you accept the terms. It has links to the Terms and to the data processing terms (section 14). The card does not show in Settings. | Click "Accept and continue". |

## Revoke the agent's token

After the claim, the agent keeps its token until the token expires, 3 days after setup. Claiming does not extend it. To revoke it sooner:

- Go to Agents, where it shows as "Agent trial".
- Until you accept the terms of a project that Sequential added when you signed in, the app opens no page of the project except Settings. Go to Settings › Agents & tokens instead. There it shows "made by an agent trial".

## Not you?

The email says "Did not ask for this? Delete the project", with a link: the erase link. You do not need an account.

> **Nothing undoes the block**
>
> When you click Delete the project, Sequential deletes the trial at once and blocks your address from trials that agents create. Nothing undoes the block. You can still sign up and use Sequential normally.

1. Open the link in the email.

   Result: The page asks first: "Delete a trial project you did not ask for". Opening the link deletes nothing.

2. Click **Delete the project**.

   Result: Sequential keeps only a hash of the address for this block, never the address.

If Sequential already added the trial to your account, the erase link does not work. To remove the trial, open Settings › Organisation and delete the organisation under Delete the organisation.

### When the erase link does not work

The page checks the link first. If the trial is claimed or deleted already, or the link is not complete, it says "This link cannot be used" and "Nothing can be deleted with this link. You can close this page."

From 15 October 2026, the erase link accepts at most 30 requests a minute from one network. Over that, or when Sequential cannot count the requests, it refuses the request for a moment. The page then asks you to click the button again.

### How the link pages stay private

The claim link and the erase link carry a secret in their address. The proof in the claim link comes after `#m=`. Your browser does not send that part to any server, and the app removes it from the address bar at once. Sequential stores only a hash of it.

From 10 October 2026, Sequential's own website does not record these pages. It also does not record a sign-in page that leads back to one. The pages send no referrer, so the next page and other websites do not get the link. Your browser does not keep them in its cache.

More about agent trials and privacy: [Privacy at a glance](/docs/privacy-overview#agent-trials).

## FAQ

### What happens after the agent's call?

1. Your coding agent makes one call. Sequential creates a project, sends you an email, and gives the agent an ingest key and a token. Your coding agent can install Sequential in your app and look at the first sessions, before anyone signs up.
2. You claim the trial to keep it. Until then, the trial has the limits in [What a trial can do before you claim it](#what-a-trial-can-do-before-you-claim-it).
3. If you do nothing, a reminder comes after 48 hours, "Your Sequential trial is erased soon". If you do not claim the trial within 72 hours, Sequential deletes it when it expires.

### When did Sequential start to add trials at sign-in?

From 22 October 2026, when you sign in with a verified address, Sequential adds every trial that waits for that address to your account at once. You do not click Claim.

A trial that you claim with the link or on `/claim` needs no second click, because that claim accepts the terms.

## Next steps

- [Privacy at a glance](/docs/privacy-overview): what Sequential collects, where it sends it and who can see it.
- [Agent tools](/docs/agent-tools): every tool that Sequential's MCP server offers a connected agent.
- [Connect claude.ai](/docs/connect-claude-ai): add Sequential to claude.ai as a custom connector.
