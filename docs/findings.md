# Cases and fixes

> A case is a problem that Sequential counts across sessions. Hand it off, link the fix and mark the release. Then Sequential measures the rate again.

> **At a glance**
>
> - **For:** Problems that Sequential counts across sessions: an error, a failed request, a dead click, a rage click or a dead end.
> - **Who can:** Owners, admins and members confirm, dismiss, mute and link fixes. Viewers read cases and copy the brief.
> - **Default:** Sequential looks for new cases every 15 minutes.
> - **Know this:** Only a release marker starts a measurement. A link or a pull request alone does not.
> - **Know this:** Sequential switches detection on per project. The app has no setting for it. While detection is off, it is paused.

> **When a case opens**
>
> - An error in your own code, a 5xx or a network failure: from its first session.
> - An error from your server: from its first occurrence, also when it is in no browser session.
> - Other problems: at least 3 sessions, of at least 2 people, in the last 7 days. For a dead end, the sessions with Back count only toward a higher bar.

## Take a case to a measured fix

Use Cases to follow a problem from the first time Sequential counts it to the release that is meant to fix it.

1. Open the case from **Cases** in the left rail.

2. Give the fix brief to a developer or an agent: click **Copy brief**.

   Result: On a project with no agent webhook, owners and admins see Copy brief for an agent in its place. See [Copy the brief](#copy-the-brief).

3. Under **Fix**, paste the address of the pull request, commit or issue for the fix.

4. Click **Link**.

5. Record a release marker for each release. Name the case in it, for example `"finding_ids": ["F-12"]`, or with a `Sequential-Finding: F-12` trailer that `sequential-release` reads.

Result: About once an hour, Sequential compares the sessions before the release with the sessions after it. After the release, the Did the fix work? card on the case shows what the rate did. It never says why.

Sequential measures only markers for the project's own environment. As the version, use the same name that your browser SDK sends as its release. See [Mark a release](#mark-a-release).

For noise, [dismiss the case](#confirm-or-dismiss-a-case) or mute cases like it. A muted case still counts. Sequential deletes nothing.

## Find a case

1. In the left rail, click **Cases**, or press G, then C.

2. Choose a tab: All, Open, Fixed, Dismissed or Muted.

   Result: Each tab shows its count. The page opens on Open.

3. Read a row: the id and the title, then the kind, the page, the counts and when Sequential last saw it.

   Result: On the right are bars for the last 14 days, the stage dots and the stage pill. The counts read like "5 people, 12 sessions". A case from your server reads "your server" in place of the page.

4. Click a row to open the case.

| Tab | What it lists |
|---|---|
| Open | The open cases that are not at the stage Fixed and that no mute rule mutes. A case that is Quiet since the fix is not confirmed, so it stays on Open. If the problem comes back, the case goes back to Open. |
| Fixed | The open cases at the stage Fixed: Sequential measured and confirmed the fix. |
| Dismissed | The dismissed cases. Each has Reopen. |
| Muted | The open cases that a mute rule mutes. The tab is there only while a mute rule mutes a case. |

Fixed and Muted list open cases too. Reopen makes a dismissed case open again. For the stage words, see [The stages](#the-stages).

### When the Cases page is empty

| Message | Where | What it means | What to do |
|---|---|---|---|
| "No case here." | A tab with no case | The tab has no case. | — |
| "A case opens when the same problem reaches several sessions; an error opens one at once." | A tab with no case, while detection is on | The page adds this line while detection is on. | — |
| "No case matches." | Filter cases | The filter matches no case. | — |

On the Open tab, an empty list also shows Ask your agent to look for problems. While detection is paused, every empty tab shows it. It is not there while Filter cases has text. It is also not there when no event and no recording has reached the project yet. When Sequential cannot read this, the button shows.

The button opens the menu of [Ask your agent](/docs/sessions-and-replay#ask-your-agent). Its prompt is fixed text, with no data of your project: "Use Sequential's tools for this project to look through the sessions of the last 7 days for problems that are not findings yet: errors or failed requests in only a few sessions, rage clicks, dead clicks and pages where people give up. For each one, say what happened, on which page, how many sessions, and give one session id I can open."

On a project where detection is paused, the line under the title says so. See [How Sequential joins and counts cases](#how-sequential-joins-and-counts-cases).

### The Cases list in detail

- From 4 November 2026, there is also Muted, while a mute rule mutes a case.
- From 1 November 2026, the id of a case, such as F-12, is a button in the list, on the board and on the case page. Click it to copy the id. It does not open the case. The button then reads "Copied" for 2 seconds. If the browser refuses the copy, it says "Could not copy. Select F-12 and copy it." In the list and on the board, a hint shows when you point to the id or move the keyboard focus to it: "Name F-12 in the release that ships the fix, when you or your agent record it. Then Sequential measures the fix." Press Esc to hide it. On the case page, this line shows under the summary of the case. See [Mark a release](#mark-a-release).
- The line under the title counts the open cases, for example "12 open, 3 of them new. 1 has gone quiet." Under the tabs, one line says how the list is sorted, then the rule, for example: "Sorted by impact: people reached, weighted by the share who gave up. Cases open at 3 sessions from 2 people in 7 days, or at once on a failed request or an error in your own code." While detection is paused, the line gives only the order. On the board, it gives only the rule.
- Cases that happen now come first. Quiet cases come after them. Fixed and dismissed cases come last. Inside each group, Sort sets the order: Impact (the default: the people reached, weighted by the share who gave up), People (the most people first), Sessions (the most sessions first, also sessions with no person id) or Newest (the newest case first). A tie goes to the case seen latest. With People or Sessions, each row shows that number darker. The order is in the address, for example `?sort=people`, so you can share it. From 3 November 2026, this browser remembers the order that you chose, for each project, and Cases opens in it the next time. A link with `?sort=` opens in its own order. With nothing remembered, or in a browser that keeps no site data, such as a private window, Cases opens at Impact. To go back to Impact, choose it in Sort. Your teammates and your other browsers keep their own order. When you come back to Cases in the same tab within 10 minutes, the last list shows at once, with its tab, its filter and its scroll, and "Updating…" shows next to the tabs while Sequential reads the list again. The board always uses Impact.
- From 3 November 2026, cases of one pattern show as one row in the list when 2 or more of them have the same standing: live, quiet, fixed or dismissed. Click the row to see its cases. A group only shows the cases together: each case keeps its number, its stage, its fix and its measuring. The patterns are:
  - dead ends where most people came straight back with their own Back button: "People go straight back with the Back button";
  - dead ends where most returns were not recorded as Back: "People come straight back";
  - dead clicks on one control on several pages: "Clicks on "Continue" do nothing", or the selector of the control when Sequential cannot show its text;
  - failed requests with one method to one host, such as "POST requests to api.example.com fail";
  - errors with the label Other sites’ code, by the host of their script, such as "Errors in scripts from cdn.example.com".

  Rage clicks and other errors are not in a group. A group takes its place among the single cases by its total in the chosen order. The address keeps the open groups (`?open=`).
- To filter, enter at least 2 characters in Filter cases. The filter reads the title, the page and the id.
- List and Board change the view. Board puts each case in a column by its step: New, Handed off, Fix linked, Shipped and Measured. On every tab but Open, the dismissed cases are below the columns.
- Press J and K to select a case, and Enter to open it. Press V to change the view.
- The page reads at most 100 cases.
- An open case with no session and no person in the last 7 days is quiet. Its counts read "quiet now". While no fix is linked, the row adds "Not seen since" the day, then "Check that it still happens."
- A case of errors from your server in no browser session, but with people, is not quiet. Its counts name only the people, for example "3 people (server only)".
- From 25 October 2026, Sequential counts a dismissed case again at each check, as it counts an open one. The case stays dismissed. When it had no occurrence in the last 7 days, its counts read "no occurrence this week".

## A case's page

A case's page has a main column and a side panel. On a page 900 px wide or narrower, there is one column.

| Part | What it holds, from the top |
|---|---|
| Main column | A likely-noise note · What happens · How often · Steps before it happened · Since when and Done when · Evidence: up to 5 sample sessions · Who it reaches · Did the fix work? · What the agent receives: the fix brief |
| Side panel | The decision card, with the buttons for your role · Fix · Releases that name this case · Changes · What happened to this case: the history |

### Every part of a case page

A case's page has two columns when the page is wider than 900 px: the main column, and a side panel on the right. The side panel stays in view while you scroll. On a narrower page there is one column: first the decision card, then the main column, then Changes, Fix and the history.

At the top, the page shows:

- The id, the kind and the page, for example "F-12 · Failed request · /checkout". A case from your server reads "your server" in place of the page. A likely-noise case adds Likely noise.
- The title. From 20 October 2026 it is the short title when Sequential has one: the sentence of the kind without its long part. Else it is the full title. When the short title is only a type, such as "HTTP 501", the page uses the full title. In the short title:
  - An exception keeps its type and its message, without its page, for example "TypeError: price.toFixed is not a function" (from 25 October 2026). An exception with no message keeps its type and its page.
  - A failed request is without its host.
- A summary. From 8 November 2026, its headline says how often it happened in the last 7 days, for example "12 sessions from 9 people in the last 7 days." Once a fix release is measured, the headline gives the result, for example "After 2.4.0: 3% of sessions hit it, down from 15%.", and bars show the sessions before and after. While Sequential still measures, the headline starts with "So far after 2.4.0: ". A row of counts follows, for example Last 7 days "12 sessions, 9 people" and, for a case from the browser, Gave up "about 4 of 9 judged (±2)". For a dead end, the scope line also gives the sessions that visited the page, for example "1 of 73 sessions that visited the page (1%, 95% range 0–7%)". A fix that came back shows a red line, for example "It was fixed in 2.4.0, then it came back." The sentence that the page showed before is under How counted ▾.
- The stage rail. See [The stages](#the-stages).

The main column, from the top:

1. A likely-noise note, for example "The browser dropped a page-data request before an answer came back."
2. What happens: the facts of the problem. An error has Error and Where in the code. A failed request has Request and Answer. A request that never completed reads "No answer (the request did not finish)", because it has no HTTP status. A dead end has Element, Selector, Sends people to and How they came back. A click has Element and Selector.
3. How often: bars for each UTC day of the last 30 days. A day that Sequential holds no data for reads "no data", never 0. A day with a partial count has a partial bar. Under the bars: why the case opened, and for a quiet case, "Not seen since" the day.
4. Steps before it happened: the steps from the fix brief. Times count from the session's first event. Replay at and a time opens the session at the moment.
5. Since when and Done when: from the fix brief. Since when also lists the changes that Sequential recorded in the 3 days before the case was first seen, at most 3, the nearest first. Each change shows its kind and when it started, for example "3 h before", or "running" if it had not ended. The line ends with "Nearness is not cause." If no change was recorded, there is no line. If Sequential cannot read the changes, it says "The changes before it could not be read just now."
6. Evidence: the sample sessions. The last paragraphs of this block describe them.
7. Who it reaches: the top 5 Browsers, Systems and Releases of the sessions. A case from your server says "None from a server error."
8. Did the fix work? See [Read the result](#read-the-result).
9. What the agent receives: the fix brief, open by default. Under it, GitHub repository and Open a GitHub issue.

The side panel, from the top:

1. The decision card: the stage pill, what the case needs now, and the buttons for your role. See [Hand off a case](#hand-off-a-case) and [Confirm or dismiss a case](#confirm-or-dismiss-a-case). A viewer sees Dismiss… turned off, with "A viewer reads cases. An owner, admin or member can dismiss them." A case at Fixed says "Fixed. No new occurrence since" the release, "with enough traffic to tell."
2. On a likely-noise case, Dismiss all N like this…. See [Likely noise and other labels](#likely-noise-and-other-labels).
3. Fix, in its own card.
4. Releases that name this case. From 9 November 2026, an owner or an admin can name the case in a release here, or remove it from one. See [Mark a release](#mark-a-release).
5. Changes. From 22 October 2026, a case page has a Changes card under Fix. See [Changes card](#changes-card).
6. What happened to this case: the history. See [The stages](#the-stages).

On a case, Evidence lists up to 5 sample sessions, for example "5 examples from the last 7 days". A sample shows the person, how long ago the session was, the judge's reading and the moment, for example "Error at 1:24". Your own sessions read "You". Click a sample to open the session beside the case, at that moment. In place of the moment, a sample can show No recording, Recording not ready yet, Recording expired or No playable recording.

When the last 7 days hold more sessions than the samples, a button such as "Show all 12 sessions of the last 7 days" lists them. It lists at most the newest 100.

With no sample, Evidence says why. For a quiet case, it says "No sample session: they come from the last 7 days, and it last happened on" the day. For a case from your server, it says "None from a server error." For any other case, it says "No sample session from the last 7 days."

## Confirm or dismiss a case

In the decision card, owners, admins and members get two buttons: Dismiss… and Confirm problem.

| If the case is | Do this |
|---|---|
| A real problem | Click Confirm problem. A mute rule never mutes a case that a person confirmed in their latest verdict. |
| Not a problem, or a problem that you will not fix | Dismiss it, with the steps in this section. |
| A kind of case that you do not want in Open | [Mute cases like it](#mute-cases). |

To dismiss a case:

1. In the decision card, click **Dismiss…**.

   Result: It opens Not a problem and Won’t fix, with a box for an optional reason: "Why is it not a problem? (optional, kept with the case)".

2. Optional: enter a reason, or click a chip such as **Our own test traffic**.

   Result: The chip fills the box.

3. Click **Not a problem** or **Won’t fix**.

Result: A dismissed case says who dismissed it and when, and has Reopen.

A case at Fixed has neither Dismiss… nor Confirm problem. These buttons come back when the case becomes Regressed.

Some cases carry a label:

| Label | What it means | What to do |
|---|---|---|
| Likely noise | A label, not a verdict. The case shows a sentence that says why. A case with the label still opens. It stays open until a member dismisses it. | To dismiss many cases like it, see [Likely noise and other labels](#likely-noise-and-other-labels). |
| Other sites’ code | An error never seen in the own scripts of your site. It is not likely noise. | — |
| Details hidden by the browser | An error in a script from another origin that was loaded without CORS, so the browser hid its message and stack. It is not likely noise. | To see the real error, add `crossorigin="anonymous"` to that script tag and send an `Access-Control-Allow-Origin` header from that host. |

### Likely noise and other labels

On a likely-noise case, Dismiss all N like this… dismisses the open cases of the same kind of noise. Each case is dismissed on its own, with the same reason. If you open another project while it runs, it stops before the next case, for example "2 of 5 cases dismissed. Stopped: You opened another project." The cases that it dismissed stay dismissed. It does not try the other cases. To undo one, click Reopen on the case.

- From 25 October 2026, `list_findings` and `get_finding` also give `noise`. It is a label, not a verdict:
  - `page_data`: a request for the data of a SvelteKit page (a path that ends in `/__data.json`) that the browser dropped before any answer. This is most often a page change or a cancelled preload.
  - `resize_observer`: the ResizeObserver loop notice of the browser. It is usually harmless.
  - `browser_injected`: an error only in code that the browser puts into the page. Such an error opens no case from 1 November 2026, so only a case that opened before that date has this label.
  - `third_party`: from 3 November 2026, an error never seen in the own scripts of your site. See From the first session in [How a case opens in detail](#how-a-case-opens-in-detail).
  - `cors_masked`: from 3 November 2026, the "Script error." of the browser: an error in a script from another origin that was loaded without CORS, so the browser hid its message and stack. It can be your own script on another host, such as your CDN. To see the real error, add `crossorigin="anonymous"` to that script tag and send an `Access-Control-Allow-Origin` header from that host.
  - `null`: any other case.

  A case with a `noise` label still opens. It stays open until a member dismisses it. The app shows the `noise` label as "Likely noise". From 3 November 2026, a case with `third_party` shows "Other sites’ code" in its place, with the sentence "An error only in scripts from other sites, a browser extension, or with no script named, never in your site’s own code. It is usually harmless, but it matters when your page needs that script, such as a payment or sign-in widget." Such a case is not likely noise: the agent prompt and the counts on the Brief keep it. A case with `cors_masked` shows "Details hidden by the browser", with the sentence "The browser hid this error’s message and stack, because the script came from another origin without CORS. It can be your own script on another host, such as your CDN. Add crossorigin="anonymous" to its script tag, with a CORS header on that host, to see the real error." It is not likely noise either.

## Mute cases

You can mute kinds of cases that you do not want in Open. A muted case stays open and still counts. It leaves Open, the Brief and the count of open cases, and shows on the tab Muted. Sequential deletes nothing.

1. On a case, click **Mute cases like this**.

2. Choose the cases that the rule covers.

   Result: The kind is always the kind of this case. The dialog counts the cases now, for example "3 open cases move to Muted now. New ones like them will open there, and they still count."

3. Click **Mute 3 cases**.

| Choice | Options |
|---|---|
| Page | Any page, only the page of this case, or every page under the page one level up. A page with a language part, such as `/:lang/plan`, covers every language. A rule with a page never covers a case from your server, which has no page. |
| How people came back, for a dead end only | Any way, Most came back with their own Back, or The app sent most of them back. When most returns of this case are not known, there is also Most returns are not known. Most means more than half of the returns. |

### How mute rules work

- From 4 November 2026, you can mute kinds of cases that you do not want in Open.
- With no open case that matches, the button is Save rule. When the project has this rule already, the dialog says "You have this rule already", and the button is Edit the rule.
- Under the tabs, a line counts them, for example "3 muted by your rules · See the rules". With rules and no muted case, it says, for example, "1 rule · nothing muted now".
- A rule never mutes a case that someone acted on: a case that was handed off, that has a fix link or a measurement, that a person confirmed or reopened in their latest verdict, or that someone kept in Open. From 5 November 2026, a confirm from an agent does not keep a case out of a rule. The dialog names each of these cases and why, for example "F-12 stays in Open: a person confirmed it" or "F-14 stays in Open: its fix is being checked". When someone acts on a muted case, it goes back to Open at once.
- Each time Sequential looks for problems, it checks the rules again. A new case that matches a rule opens in Muted. A case that no longer matches, for example a dead end where most people now come back in a different way, goes back to Open.
- In the list, a muted case has the pill Muted and a line such as "Muted by “Dead ends on /:lang/plan (every language) where most people came back with Back” · since 3 Nov". For 7 days, a case that went back to Open says why, for example "Back in Open: the rule was removed" or "Back in Open: someone acted on it".
- On a muted case, Keep in Open takes it back to Open, and no rule mutes it after that. Let rules apply undoes this. Unmute: edit the rule opens Settings › Cases.
- Settings › Cases lists the rules, how many cases each one mutes, and the case that it was made from. Edit changes a rule. Remove asks first. When you remove a rule, its cases go back to Open, unless another rule mutes them.
- Owners, admins and members can make, change and remove rules, and use Keep in Open. A viewer sees "Ask a member who can triage to mute cases like this."
- A project has at most 50 rules. Sequential refuses a second rule for the same cases: "A rule like this exists already. Edit it in Settings → Cases."
- The [audit log](/docs/audit-log) records each change, with who made it.

## Hand off a case

Everyone on the project can copy the brief, viewers too. To read the brief first, go to What the agent receives in the main column of the case.

### Copy the brief

At the stage New, the decision card has Copy brief. On a project with no agent webhook, owners and admins see Copy brief for an agent in its place. It records the hand-off and puts the brief on the clipboard.

1. Open the case.

   Result: The decision card is at the top of the side panel.

2. Click **Copy brief**.

### Open a GitHub issue

1. In the main column of the case, go to **What the agent receives**.

2. Under **GitHub repository**, enter the repository as `owner/name`.

3. Click **Open a GitHub issue**.

   Result: The issue opens in a new tab. Its title is "Fix Sequential finding F-12", and its body is the brief.

### Messages when you hand off a case

| Message | Where | What it means | What to do |
|---|---|---|---|
| "The brief is held back until its people check passes. It cannot be copied yet." | The case page | Sequential cannot check the brief for known people. Until then, Copy brief, Copy brief for an agent and Open a GitHub issue do not work. The case and its evidence still show. | — |
| "The clipboard is not available here." | When a copy fails | The copy failed. | — |
| "Remembered in this browser only" | GitHub repository | Sequential remembers the repository in this browser only, for each project. | — |
| "Type the repository as owner/name to open an issue." | The hint under GitHub repository | Open a GitHub issue is off. The hint under the field says why. | — |
| "The brief was copied: paste it as the issue body." | Open a GitHub issue | The brief is too long for the link, so Sequential copied it. | — |
| "The brief was too long for the link. Copy it from the brief and paste it as the issue body." | Open a GitHub issue | The brief is too long for the link, and the copy failed. | — |

To hand cases to a coding agent:

- [Hand to an agent](#hand-to-an-agent): owners and admins hand a case to their own coding agent from the decision card.
- [Let your agent resolve cases](#let-your-agent-resolve-cases): copy a prompt for your coding agent from the bar on Cases.
- [Set up the agent webhook](#set-up-the-agent-webhook): Send to webhook posts the fix brief to whatever starts your coding agent.

### What the brief holds

- From 11 October 2026, the brief in the app is the copy that an agent gets. Element text is withheld, except a click label made only of common interface words, such as "Add to cart" (from 2 November 2026), and the names, emails and phone numbers of known people are removed. See [Privacy at a glance](/docs/privacy-overview#names-emails-and-phone-numbers).
- From 15 October 2026, when an open case had no occurrence in the last 7 days, the brief says "Not seen since" the last time, "(more than 7 days). Check that it still happens before you change code." Its definition of done then says that zero occurrences after a change do not show a fix. For an agent, `list_findings` and `get_finding` give `quiet_since`: the last occurrence of such a case. For any other case, `quiet_since` is `null`.
- From 9 October 2026, the brief has a Steps before it happened section. It shows the last steps before the case in up to 2 sample sessions, sessions with a recording first, and up to 6 steps for each: the pages that the person opened, as route templates, the clicks and the form submits, the names of custom events and the errors. In the copy that a token, an agent, a webhook or a hand-off gets, a click or a form step reads "(element text withheld)", and a click case says "Element text: withheld" and masks the selector. From 2 November 2026, a click step and a click case quote the label when it is made only of common interface words, and the selector keeps its class names and ids that are made only of such words, such as `.add-to-cart`. From 11 October 2026, the brief that you copy in the app is the same copy. The text of each step is in its own quoted block, up to 60 characters, redacted and screened like every quote. The section quotes at most 1,200 bytes in all. It never shows the properties of custom events. When a session has a recording, the section links to the replay at that moment. The link contains the session id, only when the id has 8 to 64 letters, digits and hyphens.
- The brief tells an agent to call `link_fix` only when the agent's token can call it.
- From 9 November 2026, the brief ends with a Report section, the one instruction for the end of a fix. It tells the agent to name the case: "Fixes F-12" in the pull request description, and the trailer `Sequential-Finding: F-12` on the fix commit. Then it says who records the release that ships the fix. When a token recorded a release of the project's environment in the last 30 days, it says "Your release step records releases: do not call record_release." Else it tells the agent that Sequential measures the fix only after a release that names the case is recorded, and to tell you that a release step (CI or the Sequential CLI) can record it. From 10 November 2026, it also names an agent connected with "Also: it records releases" ticked. An agent that can record releases is told how to record it.
- The first lines of the brief give its screening state. If they say "screen paused, N quoted passages withheld", each quoted passage reads `[instruction-like text removed]`. Sequential could not check its allowance. Open the case again later and copy the brief again.

### Hand to an agent

Owners and admins hand a case to their own coding agent from the decision card. The agent opens the pull request, and you review it.

- When the project has no agent webhook, the button is Copy brief for an agent. It records the hand-off and puts the brief on the clipboard: "Brief copied. Paste it into your coding agent." If the browser refuses the copy, the card shows the prompt and the brief to copy.
- When the webhook is ready, the button is Hand to an agent. It records the hand-off, then shows a prompt to copy. From 1 November 2026, it starts with a line that names the project by its slug, for example "Use the Sequential tools on the project "shop": pass project "shop" to every call that takes a project argument." Then: "Fix Sequential finding F-12. Read its brief with get_fix_brief (number 12) and follow it, including its Report section." Copy prompt and Copy the brief copy them.
- Your agent needs Sequential connected, with a token that has `findings:read`. See [Agent tools](/docs/agent-tools).
- Send to webhook appears only when the project has a webhook that is turned on, and the server can sign webhooks. From 26 October 2026, Sequential's hosted service signs webhooks.
- Sequential records the hand-off before it shows the prompt. If it cannot check all the quoted text in the brief, it sends nothing and says so. Try again in a minute.
- The server refuses another hand-off of the same case for 7 days after the last one that succeeded. Until then, the card says "You can hand it to an agent again on" a date. A refused hand-off says "This case went to an agent recently, or a request is waiting. It can go again after 7 days."
- After that date, the card offers the hand-off again. On a case with a result such as No change, the button is Hand back to an agent.
- A dismissed case, or one with a fix link, cannot be handed over. With a link, the card says "A fix is linked. Unlink it to hand the case back to an agent."
- An agent can also ask for a draft, with the tool `request_fix_draft` and a token that has `findings:draft`. The card then shows "An agent asked to take this case" with the time, and the pill Waiting on you. Owners and admins see "Approve to send it the brief." and choose Approve hand-off or Decline. Approve hand-off gives you the prompt and the brief to paste. The agent never receives the brief from this request. To record the request, Sequential prepares the brief and checks its quoted text. If Sequential cannot prepare the brief now, it refuses the request with `screen_incomplete`: "The finding's brief could not be rendered right now. Try again later."
- `request_fix_draft` writes, so it is not on `/mcp/readonly`. claude.ai never gets `findings:draft`: it cannot be granted through OAuth.
- Members and viewers do not see Copy brief for an agent, Hand to an agent or Approve hand-off. Others see "An owner or admin can approve it."
- On the case page, E hands off or approves, X declines or dismisses, and B shows or hides the brief.

### Let your agent resolve cases

From 2 November 2026, a bar under the header of Cases gives you a prompt for your coding agent, such as Claude Code or Cursor, with the Sequential connector, in the repository of your app. It says, for example, "Let your agent resolve 6 open cases · likely noise left out".

- Copy prompt copies the prompt at once: all open cases, without the likely noise. The button says "Copied" for a moment.
- Customize opens the choices: New, All open or Selected. With Selected, select the cases in the list. Leave out likely noise and Leave out quiet cases each show how many cases they leave out. A quiet case is open, with no occurrence in the last 7 days. The panel shows the count and the prompt, which you can read but not edit. Its Copy prompt is under the prompt.
- The prompt names the project and the cases by number only, newest first, at most 20. It never holds a case title. With more, it says "The newest 20 of 34 cases are in the prompt."
- For each case, the prompt tells the agent to call `get_fix_brief`, find the cause in your code, fix it with a test, and do what the brief's Report section says. Getting a fix brief marks the case as handed off. From 9 November 2026, the prompt is the same for every role. At the end, it asks the agent to list each case with what it did and its pull request URL, or why it left it.
- Each open row in the list has its own Copy prompt for that one case.
- If you have no connection yet, the panel says "No agent connected yet? Connect your agent in Agents."
- If the copy fails, the panel opens so that you can select the prompt and copy it.

The pull request alone does not measure the fix. Sequential measures a release that names the case. See [Releases from GitHub: changes and case ids](#releases-from-github-changes-and-case-ids).

### What counts as a handoff

- Copy brief, Copy brief again and Open a GitHub issue in the app.
- Copy brief for an agent, Hand to an agent, Send to webhook and Approve hand-off, once Sequential has recorded the hand-off. A webhook send that fails does not count. The audit log records it as `finding.dispatched`, not `finding.handed_off`.
- A token that reads the case or its brief. GET `/api/findings/:n` carries the fix brief, so it counts as a handoff. So do GET `/api/findings/:n/brief`, the `get_fix_brief` tool and POST `/api/agent/get_fix_brief`.

These do not count: opening the case in the app, the cases list, and the `get_finding` tool. A token request that Sequential refuses, because it could not screen the brief, does not count either.

The `get_fix_brief` tool tells MCP clients that it changes data. Its `readOnlyHint` is false, its `destructiveHint` is false and its `idempotentHint` is true. Its description says that the call writes. If the case has no hand-off time yet, the call sets it to now and records `finding.handed_off` in the audit log. Only a case at the stage `new` then shows `handed_off`. Each call also records a delivery of the brief. If a write fails, the agent still gets the brief. A client can then ask you before it calls the tool. A token with `findings:read` can still call it.

Sequential keeps the time of the first handoff. The audit log records only that first handoff, as `finding.handed_off`. See [Audit log](/docs/audit-log).

### Set up the agent webhook

Owners and admins set up the webhook under Settings › Project › Where hand-offs go. Send to webhook on a case posts the fix brief there. Point it at whatever starts your coding agent.

- Only owners and admins see the section. It shows the address with its query values hidden.
- Type a Webhook address that starts with `https://`. Then click Save address. A new webhook is on. Turn off and Turn on change that.
- The line under the field reads "An https:// address on the standard port, with no user name, password, #part or IP address." For an address that Sequential refuses, it says why, for example "Use an https:// address on the standard port (443), with no user name, password or #part."
- Send a test posts a test body with no case in it, and tells you whether your webhook answered.
- New signing secret… makes a new secret after you click Make a new secret, and shows it once. The old secret stops working at once. Sequential cannot show a secret again.
- Each delivery is a POST with a JSON body of five fields: `finding`, `revision`, `template_version`, `finding_url` and `brief_markdown`, the screened fix brief. It holds no user ids, emails or recordings. Its Steps before it happened section can hold a replay link with a session id.
- Each delivery is signed. The header `X-Sequential-Signature` is `t=<unix seconds>,v1=<hex>`, where `v1` is the HMAC-SHA256 of `<t>.<raw body>` with your secret. With a new secret, the section says how your receiver checks it.
- Sequential sends once per click and waits up to 5 seconds. It does not follow redirects, and it refuses an address in a private network. A test counts too: a project can send up to 20 a day.
- If a send fails, the case says why, for example "Your webhook did not take the brief: it did not answer in time."
- From 26 October 2026, Sequential's hosted service signs webhooks. Each project's secret comes from the server's signing key. A server without a signing key says "This server has no signing key, so it cannot post hand-offs, test the webhook or make a signing secret yet." There, cases offer only the copy.
- From 8 November 2026, beside the address, the section shows On or Off and when it was set, for example "Set 3 hours ago". Under it, one line says what the state means, and rows follow. While the webhook is on, the line is "When a case is handed to an agent by webhook, Sequential posts its brief to this address." "Posts" says "The case’s brief, its number and its link, signed with your signing secret". "Tries" says "Once. Only a 2xx answer counts as delivered; there is no retry." "Limit" says "20 posts a day (UTC) for this project, tests included".
- From 8 November 2026, while the webhook is off, the line is "The webhook is off, so a hand-off is copied as a prompt or opened as an issue instead." One row, "Posts", says "Only a test, when you send one". With no webhook, the line is "No webhook is set, so a hand-off copies the case’s brief for you to paste into a coding agent." and there are no rows.
- From 8 November 2026, on a server without a signing key, a webhook that is on shows the no-signing-key sentence as its line, with no rows. Off or with no webhook, one row, "Signing", says "Not on this server: it posts no hand-off, sends no test and makes no signing secret". In every state, the old text is behind "Read the full text ▾".

## Link the fix

1. On the case, go to **Fix**.

   Result: It is a card of its own in the side panel. On a narrow page, it comes after the main column.

2. Under **Fix**, paste the address of the pull request, commit or issue.

3. Keep the list next to it at **Auto**, or choose the kind: Pull request, Commit or Issue.

4. Click **Link**.

   Result: The link shows with a PR, Commit or Issue pill.

   **If Link stays off or cannot tell the kind**

   Link stays off until the address starts with `https://`. With Auto, Sequential tells the kind from the path of the address. If it cannot tell, choose the kind and click Link again. See [Links in detail](#links-in-detail).

To remove a link, click × next to it. It acts at once. It does not ask you to confirm.

| Who | Add a link | Remove a link |
|---|---|---|
| Owner, admin, member | ✓ | ✓ |
| Viewer | — (sees the links only) | — |
| A token with `findings:link` | ✓ | — |

The form shows only on an open case.

### Links in detail

- The address must start with `https://`. It can have at most 500 characters and no control characters.
- With Auto, Sequential tells the kind from the path of the address. It ignores the query (after `?`) and the fragment (after `#`).
- A pull request is `/pull/<n>`, `/merge_requests/<n>` or `/pull-requests/<n>`. More parts can follow, for example `/pull/42/files`.
- A commit is `/commit/<sha>` or `/commits/<sha>`, with 7 to 40 lowercase hex characters. More parts can follow.
- An issue is a path that ends with `/issues/<n>` or `/-/issues/<n>`. Only a `/` can follow.
- For any other address, choose the kind in the list next to the address. Through the API, send `kind` (`pr`, `commit` or `issue`) to POST `/api/findings/:n/links` or the `link_fix` tool.
- Sequential always uses a kind that you choose. It does not compare it with the address.
- Adding the same address again changes nothing. The first link stays, with its first author.
- Sequential stores and shows a link. The server never opens the address. In the app, you can click the link to open it in a new tab.

## Mark a release

A release marker tells Sequential that you shipped a version, and which cases it is for.

Record the marker with POST `/api/releases`. Name the cases in `finding_ids`, for example `["F-12"]`. The token needs the `releases:write` scope, for example a project access token (`sq_pat_…`) with that scope. An agent can use the `record_release` tool. From 10 November 2026, an agent connected through claude.ai or ChatGPT can use it too, when an owner, an admin or a member ticked "Also: it records releases" for it. See [Connect claude.ai](/docs/connect-claude-ai#the-consent-page).

Sequential checks each release that an agent records, from an agent connection or from an access token marked for an agent. A CI token gets none of these checks. One call names at most 5 cases. Each case must be an open case of this project. It must have opened at or before the release time. It must not have come back after its last fix. An agent cannot name a case again that a person removed from this release. One case that fails refuses the whole call, for example with "F-12 is not a case in this project." Sequential screens the title, the notes and the change list. It drops a text that fails the screen, and the answer lists it under `adjusted`. Daily limits apply to each agent and to each project. See [Limits](/docs/limits).

In CI, install the package `@usesequential/release-cli` (Node.js 18 or later). Its command is `sequential-release`. In GitHub Actions, use `usesequential/release-action@v0`. For example:

```text
npx @usesequential/release-cli --version <v>
```

`SEQUENTIAL_RELEASES_TOKEN` is required. It is a project access token (`sq_pat_…`) of one project, with the `releases:write` scope. Always pass it from a secret store. See [The sequential-release command](#the-sequential-release-command).

Use a build id as the version, such as the commit sha or the number of the CI build. Do not use a branch name or the title of a pull request. Use the same name that your browser SDK sends as its release.

With the Sequential SDK, add `data-release` to the tag, for example `data-release="2.14.1"`, or call `sequential.register({ $release: '2.14.1' })` on each page load, so that every event carries the release name. See [Sequential SDK](/docs/sequential).

Sequential shows the version of a recorded marker to your team and to agents as the name of the release, for example in "It came back on fe@3 in 4 sessions.". So do not put text there that a person outside your team can set.

When a marker names no environment, it gets the project's environment.

On Vercel, run the GitHub Action on `deployment_status`, with the setup in [Releases from GitHub: changes and case ids](#releases-from-github-changes-and-case-ids).

The `sequential-release` command and its GitHub Action read the cases from trailer lines in your commit messages, and name them in the marker. A trailer alone does not name a case: when you send POST `/api/releases` yourself, name the cases in `finding_ids`.

A trailer looks like this:

```text
fix: debounce the retry loop

Sequential-Finding: F-12
```

One commit can name several cases, for example F-12, F-14 and F-19:

```text
Sequential-Finding: F-12, F-14 F-19
```

For one repository with several projects, write the project key before the number, for example `Sequential-Finding: web#F-12`.

> **Recording a version again**
>
> If you record a version again for the same environment, the new marker replaces the old marker: its commit, its time and its texts. From 6 November 2026, it keeps the cases that the old marker names and adds the new ones after them. Together they can be at most 50: Sequential refuses a call with more, and cuts nothing. Only a person removes a case from a release, in the app. From 10 November 2026, a token or an agent connection cannot record a version that a person retracted: Sequential refuses with "A person retracted this release." From 10 November 2026, an agent that a member connected cannot replace a version that your release pipeline or a person recorded. Sequential refuses, for example with "Version 2.4.0 was recorded by your release pipeline or by a person. An agent that a member connected cannot change it. Ask an owner or an admin." An agent that an owner or an admin connected can replace it. See [Changes](/docs/changes). Without `released_at`, the new marker gets the time of the call, so the marker moves.

### Name a case in a release on its page

From 9 November 2026, a case page has the card Releases that name this case, under Fix. It lists the releases of the project's environment that name the case, the newest first. With no such release, it says "No release names this case yet."

Only an owner or an admin can change the list. A member or a viewer sees the list without buttons. The demo, and staff who view as a customer, see no buttons either. A token cannot use the card: an agent or your CI names cases when it records the release.

- To name the case in a release: under Name a release, choose the release in Release to name, then click Name. The list offers only releases of the project's environment that came after the case opened and do not name the case yet. The card says "Sequential measures this case against the release you name."
- To remove the case from a release: click Remove from this release. The card asks "Remove this case from release 2.4.0?" Click Remove, or Keep it to change nothing. "Sequential stops measuring this case against it."

After a change, Sequential measures the case again at once. The card then says, for example, "Release 2.4.0 names this case now. Sequential measures it again." or "Release 2.4.0 no longer names this case."

From 10 November 2026, the card lists every release of the environment that names the case, also an older one. A retracted release is not listed. The choices under Name a release come from the newest 100 releases. When there are 100 or more, the card says "The choices come from the newest 100 releases."

Sequential refuses a change, with these words:

- "This release came before the case opened, so it cannot hold the fix."
- "Only a release in production can name this case, because Sequential measures fixes only there." The name of your project's environment replaces production.
- "This release already names 50 cases, the most it can."

### Release marker fields

From 1 November 2026, a marker can also say what shipped, in words for a person. All three are optional:

| Field | What it holds | Limit |
|---|---|---|
| `title` | One line, for example "Clearer checkout errors" | 120 characters |
| `notes` | The release notes, as plain text or Markdown | 4,000 characters |
| `changes` | The pull requests or commits that the release ships. Each has a `title` (one line, 200 characters), a `url` (https only) and a `number` | 50 items |

- Sequential never refuses a release because of these texts. It removes control characters, masks text that looks like a secret, such as a token, an email address or a card number, and cuts a text that is too long at its limit. The text stays masked when it is stored.
- It drops a link that is not https or that holds a user name or a password, and a change without a title. Sequential does not open the links.
- The answer of POST `/api/releases` has the stored marker. When Sequential changed a text, `adjusted` lists each field and what it did: `cut`, `masked`, `dropped` or `cleaned`.
- The answer of `record_release` has the ids and counts only (`has_title`, `has_notes`, `changes_total`), not the texts.
- Each marker has a `group_key`. Markers with the same environment, the same commit and the same day (UTC) have the same key. Without a commit, the key is the version. The API never merges or hides a marker.

### The sequential-release command

Run the command with npx, for example `npx @usesequential/release-cli --version <v>`. In GitHub Actions, use `usesequential/release-action@v0`, which is on the [GitHub Marketplace](https://github.com/marketplace/actions/sequential-release). You can also send the marker yourself with POST `/api/releases`.

There are two ways to record a release from CI. On GitHub, for example on the deployment events of Vercel, use this command or its Action: they read the merged pull requests and "Fixes F-12" from GitHub. In any other CI, use either. `sequential releases record` takes the cases that you name with `--finding F-12`.

From 7 November 2026, the [Sequential CLI](/docs/cli) (`npx @usesequential/cli`) does both. Its `releases record` takes the options of this command: `--github-changes` reads the merged pull requests and "Fixes F-12" from GitHub, and `--range` reads the trailer lines from git.

`sequential-release --version <v> [--environment <e>] [--commit-sha <sha>] [--released-at <iso>] [--title <t>] [--range <prev..HEAD> | --github-changes [--base auto|<sha>]] [--project-key <key>] [--findings all|qualified] [--host <url>]`

- The command never reads `SEQUENTIAL_TOKEN`.
- Without `--host` or `SEQUENTIAL_API_URL`, the command sends to `https://api.usesequential.com`. Set one only for a server that you run yourself. The address must use `https://`. Only `localhost` and `127.0.0.1` can use `http://`.
- `--version` is required. Use the same name that your browser SDK sends as its release. See [Release basis and time basis](#release-basis-and-time-basis).
- Without `--environment`, the marker gets the project's environment. Without `--released-at`, the release time is now.
- `--range` is a git range, for example `v1.2.0..HEAD`. A base of all zeros, as on a first push, reads only the head commit.
- `--commit-sha` is the deployed commit. `--sha` is the same option.
- `--github-changes` reads the release from the GitHub API, with no checkout. It needs `--commit-sha`, and `GITHUB_TOKEN` and `GITHUB_REPOSITORY`. Use `--range` or `--github-changes`, not both.
- On success, it prints for example "Recorded release v1.3.0 (2 cases: F-12, F-14)" or "Recorded release v1.3.0 (no cases named)". With `--github-changes`, it adds the count of changes, for example "; 3 changes since 3f2a9c1".
- On a refusal or a network error, it prints the error and exits with 1. It never follows a redirect, and it never prints the token.

The GitHub Action takes the same values as inputs: `version`, `environment`, `sha`, `released-at`, `title`, `range`, `github-changes`, `base`, `project-key`, `findings`, `github-token`, `token` and `api-url`. Only `version` and `token` are required. `github-token` is the token of the workflow by default.

### Releases from GitHub: changes and case ids

With `--github-changes` (in the Action: `github-changes: 'true'`), the command reads the GitHub API. The workflow needs the permissions `deployments: read`, `contents: read` and `pull-requests: read`.

1. The previous release. On a `deployment_status` event, it is the newest earlier deployment in the same GitHub environment whose newest status is `success`, of another commit. On a `push` event, it is the `before` commit of the push. You can give a commit with `--base <sha>`.
2. The commits from the previous release to this one. GitHub lists at most 250. With no previous release, only this commit.
3. The merged pull requests of the 100 newest commits. Each one counts once, at most 50. They go to the release as its changes, with title, link and number.
4. The case ids: `Sequential-Finding: F-12` lines in the commit messages, and "Fixes F-12" in pull request titles and texts. These words also count: fix, fixed, close, closes, closed, resolve, resolves and resolved. A list such as "Fixes F-3, F-4 and F-5" counts too. At most 50.

If a GitHub read fails, the command prints one line and records the release without changes and without case ids from GitHub, for example "GitHub: could not compare bbbbbbb...aaaaaaa (HTTP 404); the release is recorded without changes or case ids from GitHub."

On Vercel: Vercel deploys with its own GitHub App, so no workflow of yours runs the deploy. Run the Action on `deployment_status`, only when the state is `success` and the environment starts with `Production`. Set `version` and `sha` to `github.event.deployment.sha`, the full commit sha. Set the SDK's release to the same sha. See [Release basis and time basis](#release-basis-and-time-basis).

One repository, several projects. A case number belongs to one project: `F-12` can exist in each of your projects. Write the project key before the number, for example "Fixes web#F-12, app#F-3" or `Sequential-Finding: web#F-12`.
- With `--project-key web`, only `web#` ids count for this release. An id with no key does not count. To count both, set `--findings all`.
- With no `--project-key`, ids with no key count, and ids with a key do not.
- A key is letters, digits, `.`, `_` and `-`, up to 64 characters. Case does not matter.

## Read the result

The Did the fix work? card on the case shows the measurement for the newest release that names the case.

### Before the first measurement

| Message | Where | What it means | What to do |
|---|---|---|---|
| "No release names F-12 yet. Sequential measures a fix once a release names it." | Did the fix work? | No marker for the project's environment names the case. A marker for another environment does not count. | Name the case in `finding_ids` of the marker. Check the `environment` that your CI job sends. See [Mark a release](#mark-a-release). |

After the first measurement, the card shows:

- The stage pill and one sentence that says what the rate did.
- When both windows were counted, two bars with the Before and After rates on one scale, each with its percent.
- From 9 November 2026, on a case counted in sessions whose summary at the top already shows the before and after bars, the card shows the stage in words in place of its own bars, for example "The rate fell since the fix, but not to zero."
- Under the bars, how many sessions it needs after the release.
- A line that says these are counts, not causes, and how long ago Sequential computed them, then a link to the release.

The card compares two groups of sessions. Other changes can move the rate too, for example another release or a change in traffic. The card lists the ones that Sequential can see. It cannot see all of them.

### Messages on Did the fix work?

| Message | Where | What it means | What to do |
|---|---|---|---|
| "A fix is linked. Name this case in the release that ships it (your release step, or record_release), and Sequential measures it." | Did the fix work? | Before the first measurement: a pull request, commit or issue link is on the case. | Record the release with the case in `finding_ids`. From 10 November 2026, an agent connected through claude.ai or ChatGPT can record it with `record_release`, when "Also: it records releases" was ticked. From 9 November 2026, an owner or an admin can also name the case in a recorded release, under Releases that name this case. |
| "Release v1.4.0 claims to fix it. Measuring starts with the next sessions." | Did the fix work? | A release marker names the case. The first measurement has not run yet. | — |
| "Sequential could not check the releases just now." | Did the fix work? | Before the first measurement: Sequential could not read the release markers. So it does not say that no release named the case. If Sequential cannot read the markers but has a stored result, it shows that result. | Reload the page. |
| "Before fe@2: 12 of 300 (4%) sessions hit it. After: 0 of 150 (0%)." | Did the fix work? | An example of the one sentence next to the stage pill, after the first measurement. It says what the rate did. | — |
| "Counts, not causes: this says what changed, not why. Computed" | Did the fix work? | The line under the bars. Then how long ago, then a link to the release. | — |
| "Release fe@2: the cases it named and what else changed around it" | Did the fix work? | The link to the release. | — |
| "80 of 120 sessions needed after the release to call it." | Did the fix work? | The result is Measuring. The card gives the count so far and the count needed. | — |

| Result | What it needs |
|---|---|
| Measuring | Not enough sessions after the release yet. The card gives the count so far and the count needed. |
| Fixed | No session after the release had it, and enough sessions came: at least 3, and at least 6 divided by the rate before. For example, with 12 of 300 before (4 %), 150 sessions. |
| Improved | Enough sessions came. The rate after is lower than before, and the 95 % interval of the change is wholly below "no change". |
| No change | Enough sessions came. The 95 % interval of the change includes "no change". |
| Worse | Enough sessions came. The rate after is higher, and the 95 % interval is wholly above "no change". |
| Regressed | After Fixed, a session had it again within 30 days. For a case from your server, also after Quiet since the fix. |
| Not measured | Sequential could not compare the two windows. The sentence says why. |
| Quiet since the fix | Only for a case from your server. See [A case from your server](#a-case-from-your-server). |

Improved, No change and Worse are decided once, at the first run with enough sessions. Regressed and Not measured are final for that release. Fixed is final after 30 days with no session that had it. Quiet since the fix is not final.

Before you trust a result, read:

- [When results become final](#when-results-become-final)
- [How many sessions are needed](#how-many-sessions-are-needed)
- [The before and after windows](#the-before-and-after-windows)
- [Notes under the rates](#notes-under-the-rates)

### A case from your server

From 25 October 2026, Sequential also measures a fix for a case whose occurrences all came from your server. Such a case has no sessions to count, so Sequential counts occurrences and days. A day is 24 hours from the start of the window.

- Before: from the first occurrence of the case, at most 14 days before the release, up to the release.
- After: from 2 hours after the release, for at most 28 days. The 2 hours leave out old servers that still run during a deploy.
- Fixed: no occurrence for at least N days, and your server sent events to Sequential on at least N of those days. N is 7, or 6 × the days on which your server sent events before the release ÷ the days on which the error happened before the release, if that is more. The days on which your server sent events before the release count as at least 7. If this is not met by day 28, the result is Not measured. So a server that sends nothing never reads as fixed.
- Quiet since the fix: from 4 November 2026, when N is more than 28, no occurrence came in the 28 days after the release, and your server sent events on each of the 28 days. The error happened too rarely before the release for 28 days to prove a fix. So this is not Fixed: the case stays on Open, and the agents do not see it as `confirmed_fixed`. If your server did not send events on one of the 28 days, the result is Not measured. The card says, for example, "No occurrence in the 28 days after backend@41, and your server sent events on all 28. Before it, it happened on 1 of 6 server days: too rare to prove fixed (that needs 42 days). Still watched: if your server reports it again, this case shows it came back."
- Improved or Worse: from day 7, when the 95 % interval of the occurrences per day after the release ÷ before is wholly below or above 1.
- No change: only at day 28, when the interval still includes 1. Until then, the result stays Measuring.
- Not measured: for example, the error did not happen before the release, so there is nothing to compare.
- Regressed: an occurrence within 30 days after Fixed. After Quiet since the fix, Sequential keeps watching your server for as long as the case is open, and one occurrence from your server makes the result Regressed. The card then says, for example, "It was quiet after backend@41, then it came back."
- The days on which your server sent events count all the server events of the project, also from other processes.

The fix brief of such a case states the same rule in Definition of done. In Did the fix work?, the bars show the occurrences a day before and after the release, for example "2.9 a day", with "40 in 14 days" under them. While nothing came back, a meter counts the quiet server days toward N, for example "Quiet server days: 3 of 7." The sentence counts occurrences and days, not sessions. Agents get the numbers from `get_verification`, in `server`: `days`, `occurrences`, `people`, `error_days` and `server_days` for before and after, and `needed_days`, `min_days`, `max_days` and `rate_ratio`.

### The before and after windows

Each window counts the sessions that had an event on the case's page, and from 4 November 2026 also the sessions in which the case occurred during the window. So an error at page load, which comes after the page view, can be measured too. A session is affected if the case occurred in it during the window. For a failed request, the page is the page where the failure happens most.

| Window | Which sessions | When |
|---|---|---|
| Before | All sessions on the page | From 14 days before the release to the release. If the case was first seen later, the window starts then. |
| After, release basis | Sessions that carry the fix release. From 4 November 2026, also every other session that started 2 hours or more after the release: on a later release, on a release with no marker, or with no release name. A session that also carried an older release never counts. | Sessions on the fix release: from 1 day before the release. Other sessions: from 2 hours after it. Both to 28 days after the release. |
| After, time basis | Sessions that started 2 hours or more after the release | From 2 hours after the release to 28 days after it |

- Sequential counts the before window once, at the first measurement. After that, the count does not change, unless Sequential changes how it finds that kind of problem. Then it counts the before window again with the new rules, so that the two windows use the same rules. If the before window then starts earlier than the project keeps the data, the result is Not measured.
- On the release basis, a session that also carried an older release, for example a tab left open across a deploy, never counts. An older release is one with a marker, for the same environment, from before the fix release. A release with no marker is not an older release. Before 4 November 2026, the after window counted only the sessions that carried the fix release and no other release.
- The release basis starts 1 day before the marker. A session can carry the new release before the marker arrives.
- No window reads the last 2 minutes. Events take up to about a minute to become visible.

The sentences say what the rate did, for example "Before fe@2: 12 of 300 (4%) sessions hit it. After: 0 of 150 (0%)." They never say that the release fixed or caused anything.

### Release basis and time basis

- Sequential uses the release basis when any event carried the release name, from 1 day before the release. The name must match the marker's version exactly. For example, a short commit sha and the full commit sha are two different names.
- Only events from the browser count. The `release` option of the [backend SDK](/docs/backend-sdk) puts the build of your server on its events. Sequential does not use it to choose the basis or to count sessions.
- For how the Sequential SDK sends the release name, see [Mark a release](#mark-a-release).
- On Vercel: record the release with the full commit sha of the deployment as its version. In the SDK, set `release: process.env.NEXT_PUBLIC_VERCEL_GIT_COMMIT_SHA`. In the settings of the Vercel project, turn on Automatically expose System Environment Variables.
- Otherwise it uses the time basis.
- Once a measurement is on the release basis, it stays on it.
- Until the result is final, a measurement on the time basis moves to the release basis once your events carry the release name.

### How many sessions are needed

The needed count is the number of after-window sessions that Sequential needs to tell. While the result is Measuring, the card shows it under the bars, for example "80 of 120 sessions needed after the release to call it."

- While no session after the release had it: at least 3 sessions, and at least 6 divided by the rate before (the rule of three). For a rate before of 4 %, this is 150.
- Once a session after the release had it: the number that a two-proportion test needs to show the rate halved, at 95 % and with 80 % power.
- Improved, No change and Worse use a 95 % interval of the rate after divided by the rate before (Katz). No change means that the interval includes 1.

### Why a result is Not measured

| The card says | Why |
|---|---|
| "It did not happen before fe@2, so there is nothing to compare." | No session in the before window had it, or no session reached the page. The before window is the 14 days before the release. If the case was first seen later, the window starts then. |
| "The sessions before fe@2 are older than Sequential keeps, so there is nothing to compare." | Some of the data that the before window needs is no longer kept. |
| "The sessions after fe@2 are past what Sequential keeps, and there was no verdict before they went." | Some of the data that the after window needs is no longer kept. |
| "Four weeks after fe@2, too few sessions came to tell whether it worked." | 28 days passed and the after window still had too few sessions. |
| "No session has reported release fe@2 yet, so Sequential does not measure it yet. It checks every hour until 28 days after the release." | From 10 November 2026: an agent recorded the release, and your project's sessions report releases, but no session has reported this version since one day before the release. The version is likely not the string that your app sends as its release. A release that your CI or a person recorded is still measured by time. |

- Not measured is final for that release, except for a release that no session has reported yet: Sequential checks it every hour, and measures the fix if sessions report the version within 28 days of the release. A newer marker that names the case starts a new measurement.
- When Sequential did not read a window, it never shows the window as 0.
- Sequential measures a window only while the data that it reads is still stored. It checks the data that is really stored, not the current retention setting. For exceptions and failed requests, it reads the events and the replay data, so the shorter of the two periods decides. For the other kinds, it reads only the events.
- In a project made before 29 September 2026, Sequential does not measure a window that starts before 30 September 2026. It has no record of which data those days hold. If the server sets a [retention limit](/docs/retention-and-deletion#a-server-wide-limit), a daily run deletes a case, with its verdicts, links, verification results and hand-off records, once it was last seen more than the organisation's events retention period plus 8 days ago. That period is the period in force now, under the limit. See [Retention and deletion](/docs/retention-and-deletion).

### Notes under the rates

| Note | When it shows |
|---|---|
| "Release fe@3 also shipped on 12 Oct." | Another marker for the same environment came after the fix release, inside the after window. The card reads up to 50 markers. From 3 November 2026, releases of one commit show as one entry, such as "Release ca26443 (www, next) also shipped on 30 Oct.". With 2 or more entries on one day, the note says, for example, "11 other releases also shipped on 30 Oct.", and Show them lists them. |
| "The mix of traffic moved (20% → 45%)." | The share of all sessions that reached the page changed by more than half, up or down. |
| "Traffic is low: about 30 sessions a week, 120 needed to tell." | In the before window, fewer sessions a week reached the page than the needed count. |
| "It came back on fe@3 in 4 sessions." | From 4 November 2026, on the release basis, sessions in the after window had the problem. Each of these sessions counts under the newest release that it carried. The fix release is left out. The card names a release only when it has a marker for the same environment, and at most 10 releases. "It came back in 3 sessions on releases with no marker, or no release name." counts the other sessions together. "It also came back on 2 more releases (5 sessions)." counts the marked releases after the first 10. |

A note never changes the result. Sequential does not say what moved the rate.

### When results become final

- Improved, No change and Worse are decided once, at the first run with enough sessions. They are then final for that release.
- Fixed starts a regression watch of 30 days. Every run, Sequential looks at the sessions on the page since the confirmation.
  - On the release basis, every session counts, except a session that carries an older release. An older release is one with a marker, for the same environment, from before the fix release. Examples are a stale tab or an app that was not updated. A release with no marker counts.
  - On the time basis, every session counts.
  - If one of these sessions had it, the result becomes Regressed. The history says "came back", with the release when Sequential has one.
  - After 30 days with none, Fixed is final.
- Regressed and Not measured are final for that release.
- Quiet since the fix, for a case from your server, is not final. Sequential watches it for as long as the case is open. See [A case from your server](#a-case-from-your-server).
- A newer marker that names the same case starts a new measurement. The card always shows the newest one.

### When Sequential measures

- The job runs about once an hour.
- It measures only open cases. A dismissed case is not measured.
- It measures only projects where case detection is switched on.
- It measures only the newest marker, for the project's environment, that names the case.
- One run measures at most 200 cases over all projects. Cases not measured yet go first, then the cases measured longest ago.
- A marker less than 2 minutes old waits for the next run.
- If a run fails, the card keeps the last result and says "The last measurement failed; it retries on its own."

### Archived projects

- While a project is archived, Sequential does not look for cases in it and does not measure its cases.
- Its tokens stop working.
- The app opens only live projects, so you cannot open the cases of an archived project.
- Sequential keeps the stored results. A final result does not change. After the project is restored, measuring starts again for the other cases. If a window has aged out of [retention](/docs/retention-and-deletion) in the meantime, the result is Not measured.
- The 30-day regression watch of a Fixed result keeps counting while the project is archived. Sequential does not look at the sessions of that time.

## Where cases come from

Sequential looks for five kinds of problems in your events: Error, Failed request, Dead click, Rage click and Dead end.

| Way | Which problems | When it opens |
|---|---|---|
| From the first session | A JavaScript error in your own code, or a request that fails with a server error (5xx) or a network failure, such as a timeout | The first session it happens in. One session of one person is enough. |
| From your server | An error that your server sends with the [backend SDK](/docs/backend-sdk) | Its first occurrence, also when it is in no browser session |
| When it repeats | A rage click, a dead click, a dead end, or a request that fails with another status, such as 404 | At least 3 sessions, of at least 2 different people, in the last 7 days. For a dead end, the sessions with Back count only toward a higher bar. |

Judgments never create a case. Some problems never open a case, for example an error from a browser extension or a request that the page cancelled.

### How a case opens in detail

Sequential opens a case in one of two ways:

- From the first session. A JavaScript error (Error) in your own code, or a request that fails with a server error (5xx) or a network failure, such as a timeout, opens a case from the first session it happens in. One session of one person is enough, an anonymous person too. Until it repeats in 3 sessions from 2 people, its fix brief says "Opened from its first session", and the agents' `first_session` is `true`. From 3 November 2026, an error is in your own code when one of its occurrences ran in a script from the site of the page, that is the same domain or one of its subdomains, or from a host in Allowed origins. An error from your server is always your own code. From 4 November 2026, an error that says the browser could not load a part of your own code, such as "Importing a module script failed." or "Loading chunk 12 failed.", counts as your own code too. It most often comes after a release that removed a file that an open page still needed. An error only in scripts from other sites, such as a CDN or an ad or social script, or with no script named, such as `[native code]`, opens a case only when it repeats, as in When it repeats. Agents see such a case with `noise: "third_party"` in `list_findings` and `get_finding`. An open error case that is not in your own code gets that label when it happens again.
- From your server. An error that your server sends with the [backend SDK](/docs/backend-sdk) opens a case from its first occurrence, also when it is in no browser session. Until it repeats, its fix brief says "Opened from its first occurrence: an error from your server opens a finding at once." In the list and on the case, its page reads "your server". Its sample sessions are browser sessions only, so a case with only errors in no browser session shows "None from a server error." under Evidence. An error in no browser session counts in the people and occurrences of the case, not in its sessions. From 25 October 2026, Sequential measures a fix for a case from your server by its occurrences, not by sessions. See [A case from your server](#a-case-from-your-server). Agents read `sources`: `browser`, `server` or both.
- When it repeats. A rage click, a dead click, a dead end, or a request that fails with another status, such as 404, opens a case when the same problem happened in at least 3 sessions, of at least 2 different people, in the last 7 days.
- A dead end and how people came back. From 14 October 2026, Sequential also records how each person came back from the page that the click opened:
  - with Back: the person's own Back button or swipe, also a Back that reloads the page. From 3 November 2026, the Sequential SDK also counts a Back that the router of the page answers, for example with `replaceState`;
  - sent by the app: a redirect, or a navigation that the page made;
  - not known: Sequential cannot tell. This is so with a Sequential SDK from before 9 October 2026, with another tool's SDK, and in a browser without the Navigation API, such as Firefox. From 4 November 2026, a return with no click, half a second or more after the step, is not known too, also when the SDK recorded it as a navigation that the page made.

  The sessions sent back by the app and the sessions not known open a dead end at 3 sessions of 2 people, as in When it repeats. The sessions with Back count only toward a higher bar: at least 6 sessions, of at least 4 people, and at least 20 % of the sessions that visited the page. A dead end that opens by that bar is a pattern of people going back, not a fault. Its title reads "People often go straight back from <page> after "<text>" on <page>". From 3 November 2026, when the app took more people back than Back and not known together, the title reads ""<text>" on <page> leads to <page>, and the app goes straight back by itself". This can be a guard or a redirect in your app, so it can still be a problem to check.

  On the case, What happens has a How they came back row. It counts the sessions by how people came back, for example "with Back ×2, in a way not recorded ×1". The other kind reads "by a link in the app". A kind with no sessions is left out. A dead end found before 14 October 2026 has no counts, so it has no row.

### What never opens a case

Some problems never open a case, under either rule:

- an error from a browser extension: its stack, frame or message names a `chrome-extension://`, `moz-extension://` or Safari extension address
- from 1 November 2026, an error only in code that the browser itself puts into the page: its message names `__firefox__` (Firefox for iOS), `__gCrWeb` (Chrome for iOS) or `webkit.messageHandlers`, and its frame names no http or https script, or only the page itself at line 1, such as `global code@https://example.com/:1:20`. From 3 November 2026, it is also an error whose frame names the script of an in-app browser, such as `iabjs://` in the in-app browser of Facebook or Instagram, and no http or https script. On 3 November 2026, Sequential dismissed such a case that was still open, as the last paragraph of this block describes. `list_errors` still lists such an error, with `noise: "browser_injected"`
- an error or a request on an ad, analytics or tag host, such as Google Analytics, Google Tag Manager, Hotjar or Segment. Payment and sign-in services are not on that list, and neither is the API of your own app: their failed requests count as usual. From 3 November 2026, the list also has the logging and remote config hosts of Firebase, the tag of Pinterest, and the paths `/rmkt/` and `/pagead/` on `www.google.com`.
- a request that the page cancelled, or that the browser cancelled because the person left the page
- from 3 November 2026, a request that failed with no HTTP status, as a network failure or hidden, when the session has no stored event later than 1 second after it. This is the page going away. A 4xx or 5xx status always counts, and so does a network failure in the middle of a visit.
- a prefetch request
- from 3 November 2026, a dead click or a rage click on a form field (`input`, `textarea` or `select`): that click only puts the cursor in the field. The recorder does not send the type of an input, so a click on a submit or button input does not count either.
- from 5 November 2026, a dead click on a control that was already selected, such as a tab that is already open or a unit that is already chosen. Nothing changes after such a click, and rightly so. Only the Sequential SDK from the CDN tells Sequential about it (`$el_state: "selected"`). A rage click on such a control still counts.
- from 3 November 2026, a dead click or a rage click on a link that leaves the site: a link to another host, such as an app store, or a link such as `mailto:`, `tel:` or `itms-apps:`. A link on the same host, a `javascript:` link and a click with no link still count.
- from 3 November 2026, a dead end that starts with a click on the own control of a consent manager: Cookiebot, OneTrust, Didomi, Usercentrics or Quantcast Choice. Such a click often reloads the page to store the choice. The own Accept button of your site is not on that list. Later on 3 November 2026, the rule became narrower: Sequential leaves out such a dead end only when the next page is a reload. When the person goes back from the next page instead, the dead end counts.

On 3 November 2026, Sequential checked the open cases again under these rules. It dismissed a case only when the rules no longer count it and a rule gives the reason: in the last 7 days, none of its occurrences counted and a new rule left them out, or it is an error only in code that the browser puts into the page. A case that only stopped happening was not dismissed. Such a case shows under Dismissed, with Reopen. Its history says "Sequential dismissed it:" and the reason, for example "Sequential's detection changed: a click that only puts the cursor in a form field is no longer a dead click. Sequential closed this case." If you reopen the case, Sequential does not dismiss it again for the same rules. Its links, its hand-off and its history stay. When a rule becomes narrower, Sequential can also reopen a case that it closed. On 3 November 2026, it reopened one case of the consent rule. Its history says "Sequential reopened it:" and the reason, "Sequential's detection changed: a click in a cookie consent banner hides a dead end only when the page then reloads, not when the visitor goes back. Sequential reopened this case."

### How Sequential joins and counts cases

From 3 November 2026, one problem is one case in more places:

- A dead click, a rage click or a dead end is one case on every language and version of its page. A language is a first part of the path that is a language code, such as `/en/` or `/en-GB/`. A version is the part right after it, made of letters and then 2 or more digits, such as `/abc01/`. So `/en/abc01/step` and `/hu/xyz02/step` are one page. Nothing else in a path is joined. The case shows the page where it happened most. In the brief, the sessions that visited the page are the sessions on all of those pages.
- From 3 November 2026, a dead click or a rage click is one case for each control on its page. Sequential knows the control by its selector, or by its text when it has no usable selector, so the translated texts of one button are one case. A dead end is one case for each pair of pages, the page and the page that it leads to, whichever control started it. Its title shows the label that people clicked most often. From 6 November 2026, Sequential counts the labels exactly. If two labels have the same count, the title shows the label that is first in sort order. So the title does not change from one check to the next when the clicks do not change.
- An error is one case on every page where it happens, when it has the same type and the same message, and comes from the same side: a browser or your server. Its title names the page where it happened most. Its brief does not count the sessions that visited a page.

On 3 November 2026, Sequential joined the open cases that are now one problem. One case of each group kept its number, its history, its hand-off, its links and its verifications: a case whose page has no language part, or a case that opened after the change, then an open case with a fix link or a verification, then an open case that was handed off, then the case with the lowest number. Sequential dismissed each other open case of the group. Its history gives the reason, for example "Sequential's detection changed: it now counts an error with the same type and message as one case, on every page where it happens. This case is now part of F-12. Sequential closed this case." Later on 3 November 2026, Sequential also joined the open cases of one control or of one pair of pages. Their reason is "Sequential's detection changed: it now counts this problem as one case on every language and version of the same step, also when the text that people clicked differs. This case is now part of F-7. Sequential closed this case." If you reopen such a case after the merge, Sequential does not dismiss it again for the same change.

- The same problem is the same case as it grows. It keeps its id.
- The count of people is the "N people" in the counts of the row, for example "5 people, 12 sessions". With the Sequential SDK, PostHog or Mixpanel, one person counts once, even if they signed in between. Amplitude, Pendo and Smartlook send no link, so there each id counts as one person.
- A case that Sequential already shows never disappears because its count fell below 2. It stays, and the row shows its true count.
- The counts are exact. Sequential counts sessions. It does not estimate.
- Sequential looks for new cases every 15 minutes, by default.
- Judgments never create a case. When sessions with the problem are judged, the case says how many of them gave up after it: Gave up, for example "about 4 of 9 judged (±2)".
- Sequential switches case detection on per project. The app has no setting for it. On a project where detection is off, it is paused. The Cases page still lists the stored cases, under the line "Detection is paused for this project: no new case opens, and the cases below are not updated." With no stored case, the line reads "Detection is paused for this project, so no case opens." From 15 October 2026, an agent's `list_findings` then answers `enabled: false` and still lists the stored cases: no new case opens, and the stored cases are not updated. `get_overview` counts them too.

## The stages

Under the title, a rail shows how far the case got, in five steps: New, Handed off, Fix linked, Shipped and Measured. Every step before the current one is filled. The current step has the colour of its stage. On the last step, the rail shows the result, for example Improved. A dismissed case has no current step.

| Stage | What it means |
|---|---|
| New | Nothing has happened to the case yet. |
| Handed off | Someone copied the fix brief or opened a GitHub issue from it. Or a token read the case or its brief: GET `/api/findings/:n` counts too. The history shows when. See [What counts as a handoff](#what-counts-as-a-handoff). |
| Waiting on you | An agent asked to take the case. An owner or admin approves or declines it. See [Hand to an agent](#hand-to-an-agent). |
| Fix linked | A pull request, commit or issue link is on the case. |
| Shipped | A release marker names the case. The first measurement has not run yet. |
| Measuring | Sequential is counting the sessions after the release, or the days for a case from your server. There are not enough yet to tell. |
| Fixed, Improved, No change, Worse, Regressed, Not measured, Quiet since the fix | The result. See [Read the result](#read-the-result). |
| Dismissed | Someone set Not a problem or Won’t fix. This can happen at any stage except Fixed. Reopen makes the case open again. |

### How the rail and the list show the stage

- When more than one stage applies, the case shows the first of these: Dismissed, the measurement, Fix linked, Handed off, New.
- The rail fills every step before the current one. A release alone can move a case to Measuring. Then Handed off and Fix linked are filled, also with no hand-off and no link. The history shows what really happened.
- New, Worse and Regressed are red. A New case that has gone quiet is not red.
- The list never shows Shipped. Until Sequential measures a new release, the list shows the last result that it stored for the case. This result can be for an older release. With no stored result, the list shows Fix linked, Handed off or New. Open the case to see the stage for the newest release.

What happened to this case lists who did what: the detector opened the case, the brief left Sequential, an agent asked to take the case, someone linked a fix, a release named the case, Sequential confirmed the fix or saw it again, and the last verdict with its reason. Each line says how long ago. Hover over the time to see the date.

## Changes card

A case page has a Changes card under Fix. It shows the changes that are linked to the case, and for each one whether Sequential saw the case again after it. It never says that a change fixed the case: "Seen or not seen is a fact about this case, not proof that a change worked." See [Link a change to a case](/docs/changes#link-a-change-to-a-case).

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| "No release names F-12 yet." | See [Before the first measurement](#read-the-result). | — |
| Not measured | Sequential could not compare. It never shows this as 0. | Read the sentence. See [Why a result is Not measured](#why-a-result-is-not-measured). |
| A note under the bars, such as "Release fe@3 also shipped on 12 Oct." | Something else changed at the same time. The result stays, but read it with care. | See [Notes under the rates](#notes-under-the-rates). |
| Measuring for a long time | Not enough sessions reached the page. | Wait. After 28 days, the result becomes Not measured. |
| An agent gets `{"withheld": "needs findings:verify"}` | Its token does not have `findings:verify`. | Make a token with "checks fixes" (`findings:verify`) under Settings › Agents & tokens. |
| "The last measurement failed; it retries on its own." | The last run failed. It keeps the last good result. | Wait for the next run. |
| "Sequential could not check the releases just now." | See [Messages on Did the fix work?](#read-the-result). | Reload the page. |
| Link says "kind: required (could not be inferred from the url)" | With Auto, Sequential could not tell the kind from the path of the address. | In the list next to the address, choose Pull request, Commit or Issue. Then click Link again. With the API or the `link_fix` tool, send `kind`. |

## For agents and the API

Agents and project access tokens (`sq_pat_…`) read cases with the [Agent tools](/docs/agent-tools) or the API, such as GET `/api/findings`. These two blocks hold most of the fields and scopes for cases.

Text that your visitors typed can try to steer an agent. With Let agents dismiss cases on, such text can close a case. See [Agents that review cases](#agents-that-review-cases).

[Limits](/docs/limits) has the limits for tokens and agents.

### Agents that review cases

From 5 November 2026, an agent connection can review cases, and the judge's readings of sessions. When you connect an agent, the consent page has the box "Also: it can review cases and readings". From 6 November 2026, the instructions that an agent gets say that `get_calibration` tells how far to trust the readings, question by question, and that an agent's checks are counted apart from people's. A connection that was made without the box lists `review_finding` and `review_session` as "(not enabled)". A call to one does nothing and says how to turn it on.

- With `review_finding`, the agent gives a verdict on a case: "real" (the problem is real), "noise", "not a problem", or a "duplicate" of another case of the project. It names the sessions of the case that it checked, up to 20, and gives a reason in its own words, 10 to 500 characters.
- "real" confirms the case at once. On a case that a mute rule holds, "real" is a suggestion: Accept confirms the case and takes it out of Muted, and Keep muted leaves it there.
- "noise", "not a problem" and "duplicate" are suggestions. The case shows them under Agent says, with the name of the connection, how many sessions the agent checked, and the reason under In the agent’s words. An owner, an admin or a member clicks Accept, which dismisses the case, or Keep open. In the list, the case has a pill, for example "Agent says: noise".
- An owner or an admin can turn on Let agents dismiss cases under Settings › Agents & tokens › What agents may do. It is off by default. While it is on, an agent's "not a problem" dismisses the case at once, and a person can reopen the case. "noise" and "duplicate" stay suggestions. A "not a problem" still waits for a person on a case that is past New, that someone is fixing, that a release names (from 8 November 2026, in any environment), that a person confirmed, or that has a hand-off waiting, when the agent checked no session, and after 25 dismissals a day in the project (5 for one connection).
- An agent cannot change a case that a person decided, a dismissed case or a case that is now part of another case.
- Sequential checks the text of each reason. It refuses a reason with an address, a link or an instruction.
- With `review_session`, the agent says whether the judge's reading of a session was right or wrong. Sequential counts this apart from people's checks. It never changes how often people find the judge right. From 9 November 2026, the agent can also check a signal that is unclear, and whether a moment happened. A moment that happened at another event is still right, and the agent names that event in its reason.
- Each project can have 100 case reviews and 500 session checks from agents in a UTC day, and one connection 25 and 100 of them.
- A verdict is the agent's own judgment from the sessions it checked.

### Tokens and agents

- From 3 November 2026, `list_findings` gives `total`, the number of cases that match `status`, with `offset`, `truncated` and `next_offset`. It takes `offset` from 0 to 10000, and `limit` up to 100, with 50 as the default. When `truncated` is true, pass `next_offset` as `offset` to read the next page. `next_offset` is `null` on the last page. From 4 November 2026, `limit` and `offset` also take a number as text, such as `"50"`, or `null`. Pages are not a snapshot: `total` and the order can change between calls when a detection sweep runs, so a case can repeat or be skipped. Compare cases by number. Sequential checks up to 120 different texts in one call. When the rows of a page hold more different texts than that, some rows can come back with `{"withheld": …}` text. Read the page again, or pass a smaller `limit`.
- From 4 November 2026, `list_findings` and `get_finding` also give `dismissed_by_kind`: who dismissed a dismissed case, `person`, `agent` or `detector`. `detector` is a case that Sequential dismissed when its detection changed. It is `null` for a case that is not dismissed.
- Agents see the mute rules too. `list_findings` with `status` `open` leaves out the muted cases. Its argument `muted` is `exclude`, `include` or `only`; with any other status, the default is `include`. Its answer gives `muted_count`. `get_finding`, `get_verification`, `list_finding_sessions` and each case in `list_findings` give `muted`: `null`, or the rule that holds the case, with `since`, `covers` (`kind`, `page` or `pages_under`) and `returns`. `get_overview` gives `findings.muted`, and its `open` and `top` leave the muted cases out. GET `/api/findings` takes `muted` too. An agent cannot make, change or remove a rule.
- `findings:verify` is not on every token. Under Settings › Agents & tokens, a new token starts with the preset Read cases, and it includes `findings:verify`. The token that the app makes for an agent connection includes it too. An existing token does not get the new scope. In the app it reads "checks fixes".
- GET `/api/findings/:n/verification` and the `get_verification` tool need `findings:verify`. Without it, the route answers 403 `insufficient_scope`. A signed-in person does not need a scope.
- The findings list and one finding also carry the stage. For a token without `findings:verify`, the stage is one of `new`, `handed_off`, `fix_linked` or `dismissed`. `measuring` and every result come back as `{"withheld": "needs findings:verify"}`. (`fix_released` is also allowed, but the list and one finding never show it.) The `handed_off_at` time always shows.
- From 26 October 2026, the findings list and one finding also carry `stage_changed_at`: the time when the finding entered its current stage, in UTC. It is null when Sequential has no time for that stage. For a token, it is withheld when the stage is withheld.
- From 19 October 2026, the findings list takes `status=fixed`: the open findings whose fix Sequential measured and confirmed. It needs `findings:verify`. Without it, GET `/api/findings` answers 403 `insufficient_scope`, and the tool `list_findings` answers an error. With `findings:verify`, `status=open` leaves these findings out. Without it, `open` lists every open finding, as before.
- The findings list and one finding also carry `latest_verdict`, the newest verdict on the finding. For a token, its `reason` is screened like visitor text. It comes as `{"observed": …}`, `{"withheld": "removed by screen"}` or `{"withheld": "not screened"}`. A verdict with no reason has `"reason": null`. The name of the person who gave the verdict, `user_name`, always comes as `{"withheld": "person name"}`.
- This applies to GET `/api/findings` and `/api/findings/:n`, to POST `/api/agent/list_findings` and `/api/agent/get_finding`, and to the MCP tools `list_findings` and `get_finding`. The app, with a signed-in person, gets the reason and the name as stored.
- `scope` says where a finding happens. For an error, a dead click, a rage click or a dead end, it is the page where the finding happened most often, the same value as `page_route`. From 6 November 2026, if two pages have the same count, `scope` is the page that is first in sort order, so it does not change from one check to the next. For a failed request, `scope` is the method, the host and the path of the request, for example `POST api.example.com/checkout`.
- For a token, each title in the findings list is only the kind, for example `Exception`. `scope` and `page_route` are screened like visitor text. They come as `{"observed": …}`, a `withheld` form, or `""` if the finding has no page.
- For a token, each `session_id` in one finding's evidence and in a finding's sessions list comes as `{"id": "…", "source": "observed"}`. In the sessions list, a release name comes as `{"withheld": "not screened"}`. `get_session` gives the screened release.
- A token does not get a fix brief or a finding that Sequential could not fully screen. GET `/api/findings/:n` and `/api/findings/:n/brief` answer 503 `screen_unavailable`. The `get_fix_brief` and `get_finding` tools answer an error. The operator setting `FINDINGS_SCREEN_REQUIRED=false` turns this off. See [Privacy at a glance](/docs/privacy-overview).
- When the screen is paused, a token gets the brief and the finding with every quoted passage withheld. The brief says "screen paused". A finding with more quoted passages than the screen reads is still refused.
- `link_fix` needs `findings:link`. `/mcp/readonly` never lists it. No token can remove a link.
- With a token, GET `/api/findings/:n/verification` runs the `get_verification` tool. So REST, POST `/api/agent/get_verification` and MCP give the same answer. The request counts once toward the project read limit for tokens. If a limit refuses it, the answer keeps the status and the Retry-After of that limit. See [Limits](/docs/limits).
- In the answers of `link_fix` and `get_verification`, link addresses, release names, environments and commit SHAs are screened like visitor text. They come as `{"observed": …}` or a `withheld` form. See [Privacy at a glance](/docs/privacy-overview).
- The app, with a signed-in person, gets these values as stored.
- `released_elsewhere` lists up to 5 markers for other environments that name the finding, newest first. It shows only when no marker for the project's environment names the finding. Sequential does not measure these markers.
- `release_check: "unavailable"` means that Sequential could not read the release markers. Then a missing `released` or `released_elsewhere` means "not checked", not "no release".
- In a verification answer, a `null` count means that Sequential never read that window. It is not a zero. A failed run shows only `measurement_failed`, never the error text.

## Next steps

- [Evidence: the sessions worth a look](/docs/watch): find the sessions worth a look.
- [Roles and permissions](/docs/roles-and-permissions): see who can triage, link and hand off a case.
- [Audit log](/docs/audit-log): see who changed a rule or handed off a case.
- [Privacy at a glance](/docs/privacy-overview): read what Sequential removes from what agents get.
- [Retention and deletion](/docs/retention-and-deletion): read how long Sequential keeps each kind of data.
