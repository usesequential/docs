# Let your agent set up a trial

> A coding agent can create a Sequential trial for you with one call, before you have an account. You claim it from an email to keep it.

## What it is for

Your coding agent can install Sequential in your app and look at the first sessions, before anyone signs up. It makes one call. Sequential creates a project, sends you an email, and gives the agent an ingest key and a token. You claim the trial to keep it. If you do not claim it within 72 hours, Sequential erases it.

## What the agent calls

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
- `install.snippet`: one line to add the SDK, and `install.docs`: this page
- `terms_url`: the address of the Sequential [Terms of Service](/terms)

## What a trial can do before you claim it

- **Web: only on your own computer.** Sequential accepts events only from `localhost`, `*.localhost`, `127.0.0.1` and `[::1]`.
- **Mobile: events, but no recordings.** Recording starts after you claim the trial.
- **100 sessions.**
- **72 hours.** Data is kept 7 days, and also after you claim the trial.
- **No AI.** Sequential does not judge the sessions, and the agent tools withhold visitor text as `{"withheld": "not screened"}`. Sequential sends nothing to the judge.

> **What the lock does not prevent**
>
> The localhost rule reads the Origin that the browser sends. A script that sends a false Origin can still send up to 100 sessions into the trial project. Sequential erases that project after 72 hours if nobody claims it.

## Claim the trial

**Automatic claim.** From 22 October 2026, when you sign in with a verified address, Sequential adds every trial that waits for that address to your account at once. You do not click **Claim**. You become the owner of the organisation of each trial, and Sequential opens the newest project that it added. A notice says "We added the project “<name>”, set up for <your email>. Not yours? Delete it in Settings." The name is the text that the agent chose. While the agent's token works, the notice also says "An agent token can read this project until <date>." with **Revoke it**, which opens **Settings** › **Agents & tokens** of that project. Click **Dismiss** to close the notice. If you have no organisation yet, onboarding first says "Checking for a trial an agent started for you…".

Before you use a project that Sequential added this way, accept the terms once. In place of the page, Sequential shows "Accept the terms to use this project" and "An AI agent set up “<name>” for <your email>. Before you see its data, accept the Terms, which include the data processing terms." It has links to the Terms and to the data processing terms (section 14). Click **Accept and continue**. The card then goes, and the page opens. The card does not show in **Settings**.

Until you accept, the app opens no page of the project except **Settings**. It shows and reads none of the project's data. This applies to every project in the organisation of the trial, also in your other tabs. **Ask or jump** shows no recent picks, cases, people or saved views of the project. While the project is open, the rail shows no decisions that wait for you. An open peek of a session or a person closes. On **All projects**, the project says "Accept its Terms to see its activity." Sequential sends the terms that you still owe together with your list of projects. So every other page opens at once, with no separate read. A tab can open a project that is not in its list of projects yet, for example a trial that you claimed in another tab. The page then stays empty while the app reads your list of projects again. If the new list has the project, the terms card or the page shows. If not, the app opens another of your projects.

The Sequential API refuses the same reads. Until you accept, a request for the project's data, with your sign-in or with a token that you made, gets 403 `terms_pending` with the message "Accept the trial terms and DPA for this project first." The accept click, your list of projects and the project's settings still work. The token that the agent got when it set up the trial is not yours, so it keeps reading until it expires. When the app gets this answer, it shows the terms card for the project at once, in place of an error, and reads your list of projects again.

Until you accept, Sequential does not judge the sessions of the project, and the agent tools withhold visitor text as `{"withheld": "not screened"}`. A trial that you claim with the link or on `/claim` needs no second click, because that claim accepts the terms.

To claim a trial yourself:

1. Open the link in the email "A Sequential project was set up for this address". Or sign in and go to `/claim`, which lists the trials that wait for your address.
2. Sign in, or create an account, with the same email address. If you are not signed in, the link page says "Sign in, or create an account, with the email address your agent used. Then the project is yours." Its **Sign in** and **Create account** both bring you back to the link. The address must be verified. If it is not, the page says "Your address is not verified yet. Verify it, then come back to this link." with **Verify my address**. If the page says "This claim link cannot be used with this account. Sign in with the address the trial was sent to, or create an account with it.", click **Sign out and use another address**. The page then shows **Sign in** and **Create account** again. Before it offers the claim, the page checks the link. If the trial expired or someone claimed it, or the link is not complete, the page says "This claim link cannot be used" and "The trial may have expired or been claimed already, or the link is incomplete." It adds "Signed up with the address your agent used? Then the trial is probably yours already: sign in to see it. Otherwise ask your agent to set up a new one." If Sequential cannot check the link, the page shows the usual steps. At **Claim the project**, Sequential checks the link again. Then the page gives one answer in every case: a different address, a trial that expired, or a trial that someone claimed. It never shows the address the trial was sent to. Under that answer, it says "Already signed in with that address? Then the trial has expired or was claimed. Ask your agent to set up a new one." If Sequential added the trial to your account when you signed in, the link page says "This trial is already yours", with **Open it**.

   From 11 October 2026, the link in the email also proves that you got the email. Create your account from that link, in the same browser tab, with the address the trial was sent to. Sequential then creates the account already verified. It sends no second email, and you go straight back to the link. The proof works once, for 24 hours after the email, and only while the trial is not claimed or expired. The link in the agent's answer and the link in the reminder email do not have the proof. A reload, a new tab or another address gets the usual email with a verify link.
3. Type a **Team name** (at most 64 characters) and click **Claim the project**. On `/claim`, each trial has its own **Team name** and **Claim it** button. Each trial shows its platform and when it expires, in your browser's time zone, for example "For a website, expires in 2 days (24 Oct 2026, 14:00)." If `/claim` says "No trial waits for this address. An agent sets one up for the address it is given.", click **Sign out** and sign in with the other address. You can also click **Go to your brief**. You become the owner of its organisation, and recording and AI start to work as in any project.

After the claim, the agent keeps its token until the token expires, 3 days after setup. Claiming does not extend it. You can revoke it sooner on **Agents**, where it shows as "Agent trial". Until you accept the terms of a project that Sequential added when you signed in, revoke the token in **Settings** › **Agents & tokens**. There it shows "made by an agent trial".

## Not you?

If Sequential already added the trial to your account, the erase link does not work. To remove the trial, open Settings › Organisation and delete the organisation under **Delete the organisation**.

The email says "Did not ask for this? Delete the project", with a link. The link opens a page that asks first: "Delete a trial project you did not ask for". Opening the link deletes nothing. Click **Delete the project**. Sequential then erases the trial at once and blocks your address from trials that agents create. Sequential keeps only a hash of the address for this, never the address. You do not need an account. The page checks the link first. If the trial is claimed or erased already, or the link is not complete, it says "This link cannot be used" and "Nothing can be deleted with this link. You can close this page." You can still sign up and use Sequential normally. Nothing undoes the block. From 15 October 2026, the erase link accepts at most 30 requests a minute from one network. Over that, or when Sequential cannot count the requests, it refuses the request for a moment. The page then asks you to press the button again.

If you do nothing, a reminder comes after 48 hours, "Your Sequential trial is erased soon", and Sequential erases the trial when it expires.

**The link pages.** The claim link and the erase link carry a secret in their address. The proof in the claim link comes after `#m=`. Your browser does not send that part to any server, and the app removes it from the address bar at once. Sequential stores only a hash of it. From 10 October 2026, Sequential's own website does not record these pages. It also does not record a sign-in page that leads back to one. The pages send no referrer, so the next page and other websites do not get the link. Your browser does not keep them in its cache.

## Errors and what the agent should do

| Answer | Cause | What to do |
|---|---|---|
| 404 `not_found` | Trials are off on this server | Use a normal account |
| 400 `invalid_body` | A field is missing or wrong | Fix the field that the message names |
| 429 `trial_rate_limited` | Too many trials from this network (5 an hour, 20 a day), for this email domain (30 a day), or 3 unclaimed trials for this address | Wait for Retry-After |
| 503 `trial_unavailable` | Sequential cannot check the limits, or there are too many unclaimed trials | Wait for Retry-After |
| 403 `trial_origin_locked` | Events from a site that is not local | Run the app on localhost, or claim the trial |
| 403 `trial_replay_after_claim` | A mobile app sent a recording | Claim the trial |
| 402 `trial_session_cap` | The trial used its 100 sessions | Claim the trial |
| 401 `unknown_ingest_key` | The trial expired. The key stops working within about a minute after expiry. Sequential erases the trial within the next hour | Set up a new trial |

## Related

- [Privacy at a glance](/docs/privacy-overview)
- [Agent tools](/docs/agent-tools)
- [Connect claude.ai](/docs/connect-claude-ai)
