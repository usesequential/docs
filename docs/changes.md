# Changes: record what your company changed

> Record releases, price changes, campaigns, incidents and other changes, so people and agents can read your analytics against them.

> **At a glance**
>
> - **Who can:** Owners, admins and members record changes in the app. Viewers read the changes that everyone can see, and the proposals.
> - **Works with:** CI jobs and coding agents record with a project access token (`sq_pat_…`): [Record changes from an agent](#record-changes-from-an-agent).
> - **Works with:** Chat agents, such as claude.ai, only propose. A person confirms each proposal in Sequential: [Confirm proposals](#confirm-proposals).
> - **Default:** A planned Pricing change and some Company changes are admins-only by default. See [Kinds](#kinds).
> - **You get:** Changes beside your data: a case's Since when line, a session's page and agent briefings.
> - **Know this:** Changes are optional. Nothing in Sequential needs them. Sequential never says that a change caused a movement in your data.
> - **Know this:** If no change is recorded for a period, that does not mean that nothing changed.

## Record a change in the app

A change is one thing that your company changed, or one thing that changed around it: a release, a price, a campaign, an incident, a holiday.

1. Open **Changes** in the left rail, after People, for every role. Or press G, then H, or use the search palette.

2. Click **Record a change**, or press N.

   **If you start from the Events chart**

   You can also start from the chart on Workbench › Events. There, the label is "Record a change" and an interval, for example "Record a change, 14 Oct". It opens this form. "When" then starts at the start of that interval and ends at its end (At a known time). See [Changes on the chart](/docs/events-explorer#changes-on-the-chart).

3. Choose a **Kind**. See [Kinds](#kinds).

   **If the change is for owners and admins only**

   **Who sees it › Only owners and admins see it** can make a change admins-only. Only an owner or admin can widen who sees it.

   A member can record a change that only owners and admins can see, for example a planned Pricing change or a Company change of the subkind `sales`. After the member saves an admins-only change, the member cannot see it. The page says: "Recorded. Only owners and admins see it, so it does not show for you."

4. Enter **What changed**.

5. Set **When**.

   Result: By default, the time is now, in your own time.

6. Click **Record the change**.

Result: The page of the change opens. For a member who records an admins-only change, see [If the change is for owners and admins only](#if-the-change-is-for-owners-and-admins-only).

## What Changes is

Changes record what your company did, and what happened outside it. A change belongs to one project, or to the whole organisation.

### What a change holds

Each change has:

| Field | What it holds |
|---|---|
| Time | A moment, or a range with a start and an end. The time keeps its precision: a time of day, a day, a week or a month |
| Kind and subkind | Such as Pricing and `discount` |
| Importance | `major`, `minor` or `note` |
| Title | At most 140 characters, one line |
| Summary | Optional, at most 1,000 characters, one line |
| Links and evidence | At most 10 of each |
| Source | Such as `github`, `stripe` or `manual`, and who wrote it |

### Kinds

| Kind | Subkinds | Default importance | Who sees it by default |
|---|---|---|---|
| Release | — | major | Everyone |
| Product | `feature`, `flag`, `experiment`, `copy`, `design` | minor | Everyone |
| Pricing | `price`, `plan`, `trial`, `discount` | major | Owners and admins while it is planned. Everyone after it happened |
| Marketing | `campaign`, `email`, `ads`, `pr`, `social`, `launch` | minor | Everyone |
| Incident | `outage`, `degradation`, `vendor`, `infra` | major | Everyone |
| Company | `support`, `policy`, `sales`, `team` | note | Everyone for `support` and `policy`. Owners and admins for `sales`, `team` or no subkind |
| Outside world | `holiday`, `competitor`, `store`, `search`, `season` | note | Everyone |
| Tracking | `sdk`, `recording_policy`, `event_rename`, `tracking_plan` | minor | Everyone |

Releases that you send with `record_release`, `POST /api/releases` or the CLI also show as changes of the kind Release, and so does a release from The fix is live on a case page. You do not have to record them again. A change of the kind Release that you record here names no case. The form says: "This puts a release on the timeline. It names no case. To measure a fix, an owner or admin uses “The fix is live” on the case's page." A release has no change id, so you cannot edit or retract it. On the Changes page, a release opens its release page.

### How a release shows on the Changes page

From 1 November 2026, a release row on the Changes page says what shipped, in words for a person:

| Part | What it shows |
|---|---|
| The title | It is the title of the release. Without one, it comes from the changes of the release: the title of the one change, "2 changes:" with both titles, or for 3 or more, the first two titles and how many more, for example "5 changes: A, B and 3 more". Without changes, it is "New version of" and the app that the version names, for example `backend` from `backend@a02a2a41bd43`, or "New version" |
| The line under it | The environment, the version and who recorded the release. Click the version to copy it. From 9 November 2026, it says who recorded the release, for example "Recorded by your release pipeline (token “Release bot”).", "Recorded by an agent (Claude) for Ana Novak." or "Recorded by Ana Novak." From 10 November 2026, a release from an access token marked for an agent reads like an agent's, for example "Recorded by an agent (Release bot) for Ana Novak.", with the person who made the token. A token that was deleted reads "Recorded by a removed connection." A person who left the organisation reads "a former member". When the releases of one row were recorded by different writers, the line shows each of them once |
| The cases | "Claims to fix" and the cases that the release names, each with a link to its case. Sequential shows what the release says. It does not say that the release holds a fix |
| What changed | It opens the list of changes, with their links and numbers, and the notes as plain text. The label shows how many changes there are, for example "What changed (2)" |
| Add a description | It shows on a release that has only its version, if you can record changes. It opens a new change of the kind Release, with the same environment, version and time. When that change is confirmed, it shows in place of the release, with its own title. It keeps the cases, the changes and the notes of the release |
| One row for one release | Releases next to each other with the same environment, the same commit and the same day show as one row, for example the website and the app. The row shows each version |

On the release page, the heading is the title of the release, or "Release" and the version. Its section What changed shows the notes and the changes.

### Retract a release, or correct its time

From 10 November 2026, an owner or an admin can retract a release, or correct its time, on the release page. A member, a viewer, the demo and staff who view as a customer see no buttons.

- Retract this release: "Use it for a release that should not be there, such as one an agent recorded by mistake." Sequential asks: "Retract 2.4.0? Sequential stops measuring the cases it names against it. No agent and no release pipeline can record it again. A person can record it again from here." Click Retract, or Keep it.
- A retracted release is left out of every list of releases, and nothing is measured against it. Its page says "Release 2.4.0 is retracted." and when a person retracted it.
- An access token or an agent connection cannot record a retracted version again, from an agent or from your CI. Sequential refuses with "A person retracted this release."
- Record it again, on the page of a retracted release, records it again at the time that you give. It then names no case: name it in this release from each case's page. If you open the page again later, the release is recorded again without its title, notes and change list, and the page says so.
- Correct the time: "Record this release again with the right time and commit. Its words and the cases it names stay." From 11 November 2026, when the time moves by 1 second or more, Sequential measures the cases that the release names again from the new time: the before window, the after window and the result, also a result that was final. After your correction, Sequential starts to measure them at once. A change of the commit alone measures nothing again. You cannot move the time to before an open case that the release names opened. Sequential says, for example: "This release came before F-12 opened, so it cannot hold the fix." When an agent's post replaced an earlier time, the form shows the time and commit from before it, after "Before the agent’s post:".

## Confirm proposals

A proposal from a chat agent does not show on the timeline until a person confirms it. A confirmation in the chat, or a button in the chat, is not a confirmation.

Before you start:

- Members, admins and owners confirm or reject proposals. An admins-only proposal needs an owner or admin.
- To confirm several proposals at once, or a proposal that only owners and admins see, you need two-factor authentication and a code from the last 15 minutes. Without two-factor authentication, confirm one proposal at a time.

1. Open **Changes**, or the link that `propose_changes` returns.

   Result: Proposals wait under Proposed, at the top of the Changes page. The link opens the Changes page with those proposals first, marked "From your link". A batch of proposals can also show as a decision on the Brief.

2. On a proposal, click **Confirm** or **Reject**. Or select it, then press E to confirm or X to reject.

3. For a batch of more than one, click **Confirm all** or **Reject all**.

   **If Confirm all leaves proposals open**

   You can confirm several proposals at once only when each one is clean:

   - no possible duplicate
   - no time that disagrees with a release
   - not uncertain
   - with evidence if it was late
   - from 30 October 2026, with a title that the check did not flag (see [Why does a proposal say "Check this title"?](#why-does-a-proposal-say-check-this-title))

   **Confirm all** leaves the other proposals open, and each one then says "not confirmed: it needs a closer look. Confirm it on its own", with its reasons.

An owner or admin can also click "Confirm for the whole company". The change then applies to every project of the organisation. A release cannot be confirmed for the whole company.

A proposal stays open for 30 days. After that, it expires. See [What happens to a proposal that nobody confirms?](#what-happens-to-a-proposal-that-nobody-confirms)

## Link a change to a case

From 22 October 2026, you can link a change to a case that the change is meant to address. Examples: a release, a flag, a copy change or a new price. Only a confirmed change that happened or is planned can be linked. After the link, the case page shows the change and one fact: whether Sequential saw the case again after the change.

Owners, admins and members can link and unlink changes. These are the roles that can record changes. Viewers cannot.

Linking is optional. Cases and Changes work the same without it.

### On the case page

1. On the page of the case, go to the **Changes** card under Fix.

2. Click **Link a change**.

   Result: A list opens with the confirmed changes of this project and of the whole organisation from the last 90 days. You can link more than one change at a time.

Result: Under each linked change, the card shows one fact. The facts are in [What the card says](#what-the-card-says).

To unlink a change, click Unlink next to it.

The card says: "Seen or not seen is a fact about this case, not proof that a change worked." Sequential does not say that a change fixed or caused something.

### What the card says

When no change is linked, the card says: "Fixed it with a flag, a copy change or a price? Link that change here."

Under each linked change, the card shows one of these facts:

- "Not seen since this change. Last seen <time>, before it."
- "Last seen <time>, around the time of this change."
- "Seen again after this change: last seen <time>."
- "This change starts later. Nothing to compare yet."
- "Planned. Nothing to compare yet."

Every role can see the Changes card when a change is linked. You see only the changes that you can see on the Changes page. A change marked admins-only shows only to owners and admins, with the label "Admins only".

Above the limits in [Limits](#limits), Sequential refuses the link: "A finding can have at most 10 linked changes." or "A change can address at most 50 findings."

### On the page of a change

1. Open the page of the change.

2. Under **Cases it addresses**, choose a case in **Choose a case…**.

3. Click **Link**.

Result: "Cases it addresses" lists the linked cases.

On the Changes page, a change with links shows "Addresses F-12" for each case. An incident shows "Explains F-12". Each number opens that case.

Agents link changes with `link_change_to_finding`. See [Changes tools for agents](#changes-tools-for-agents).

## Read the Changes page

The Timeline on the Changes page lists the confirmed changes by day, newest first, with the project's releases. It shows the latest 100. Chips above it show one kind at a time.

Click a change to open its page:

| Action | What it does |
|---|---|
| Edit | Opens the form. "Save the change" saves your edit |
| Retract… | Asks for a reason. The change leaves the timeline and is no longer read against any case. Its history stays |
| Merge into another… | Retracts a duplicate into the change that it repeats. A merged change cannot be restored |
| History | Lists each version, and who wrote it |

Retracted changes are under Retracted on the Changes page. Each one has Restore.

At the top of the Changes page, the tile "Changes, 30 days" shows how many changes happened in the last 30 days, today included. Click the number to go to the Timeline. The tile counts what is recorded. A 0 in "Changes, 30 days" says that nothing is recorded, not that nothing changed.

When nothing is on the timeline, the page says "Nothing is on the timeline yet."

### How the tile counts changes

The days are UTC days. A change counts on the day that it starts, not on the day that someone recorded it, so a change that you record today for last month does not count today. Changes for the whole company count too. Proposals, and rejected, expired or retracted changes, do not count. A change that is marked as did not happen does not count.

Releases count too, on the UTC day of the release. The releases of one deploy count once a day for each environment: releases with the same environment and the same commit on one day count once, so a deploy that your website and your app both send counts once. A release without a commit counts once for each version. A release that you also confirmed as a change counts once.

If Sequential cannot read the releases, or the project has more than 10,000 releases in the 60 days that the tile reads, the page shows no tile. You count only the changes that you can see, so a member and an admin can see different numbers.

Under the number, a line shows the changes of each day. Put the pointer on a day, or select the line and use the left and right arrow keys, to read the day, for example "2 Nov: 1 change". The tile compares the 30 days with the 30 days before, for example "+25% vs the 30 days before". When the 30 days before have no changes, it says "no 30 days to compare".

## Find changes beside your data

Sequential shows the changes that were recorded near a time that you look at, for example the first sighting of a case or a release check.

- `get_overview` and `get_verification` show the recorded changes of their period.
- On a case, the Since when line lists the changes of the 3 days before Sequential first saw the case. It names at most 3 changes, each with how long before the first sighting it started, for example "3 h before".
- On the page of a session, go to Around this session › That day. It lists the changes and releases of the day that the session started. It names at most 20 changes and releases. A change at a known time says "before this visit" or "after it started". See [Sessions and replay](/docs/sessions-and-replay).

## Nothing recorded is not nothing changed

Changes are only as complete as what your team and your agents record. So Sequential never reads a period with no changes as a quiet period. Sequential shows no score or percentage for how complete your changes are.

| Place | What it says |
|---|---|
| The Changes page, with an empty timeline | "Nothing is on the timeline yet." It never says that nothing changed |
| A list near a time, a case or a session, and the Since when line of a case | "Nearness is not cause." |
| Around this session › That day, on the page of a session | "Changes recorded that day. Nearness is not cause." |

## Who can see and do what

Each change is visible to everyone who can open its project, or to owners and admins only. An organisation-wide change is visible to everyone in the organisation, or to owners and admins only. The kind, the subkind and the time set who sees the change by default. See [Kinds](#kinds).

A change that a reader cannot see answers in the same way as a change that does not exist. A count, a list or a page never shows that a hidden change exists. Shared pages and shared replays never show changes.

### Roles, and what a viewer sees

| Who | What they can do |
|---|---|
| Owner, admin | Read every change, also the admins-only ones. Record, edit, retract and restore changes. Confirm proposals. Link changes to cases. Record organisation-wide changes |
| Member | Read changes that everyone can see. Record, edit, retract and restore changes in the project. Confirm proposals. Link changes to cases |
| Viewer | Read changes that everyone can see, and the proposals |
| A project access token with `changes:write` (a CI job or a coding agent) | Record confirmed changes in its project |
| A chat agent with `changes:propose` (claude.ai, ChatGPT) | Propose changes. A person confirms them in Sequential |

A viewer can open Changes, but "Record a change" is off for a viewer: "Viewers read the timeline; an owner, admin or member records and edits changes."

A viewer sees the proposals without Confirm or Reject. Under Proposed, the page says "Viewers read proposals; an owner, admin or member confirms or rejects them."

## Record changes from an agent

A CI job or a coding agent records changes with a project access token (`sq_pat_…`) that has `changes:write`. A chat agent proposes them with `changes:propose`. An agent records changes through MCP, or with `POST /api/agent/<tool>`.

The smallest call is `record_change` with a kind and a title. Sequential sets the time to now and fills in the rest. Its answer names the defaults that it used.

- [Changes tools for agents](#changes-tools-for-agents): each tool with its scope, the token rules and what the answers hold.
- [How a sync from an agent works](#how-a-sync-from-an-agent-works): preview, safe re-runs, time zones, evidence, title checks and coverage.
- [Day limits for tokens and agents](#day-limits-for-tokens-and-agents): how many changes, proposals and previews a day, and how many items one call takes.

### Changes tools for agents

| Tool | Scope | What it does |
|---|---|---|
| `record_change` | `changes:write` | Records one change. The same key again returns the existing change and changes nothing |
| `record_changes` | `changes:write` | Syncs 1 to 100 changes from one source. It updates only the fields that the source owns |
| `preview_changes` | `changes:read` | Shows what `record_changes` would do, item by item. It writes nothing. From 2 November 2026, on a connection that can propose but not record, such as a claude.ai connection, it shows what `propose_changes` would do, for 1 to 50 items |
| `update_change` | `changes:write` | Edits one change that this token wrote. It also closes a range and sets whether the change happened |
| `retract_change` | `changes:write` | Retracts one change that this token wrote. Only a person can restore it |
| `propose_changes` | `changes:propose` | Proposes 1 to 50 changes. It returns a link to the proposals in Sequential |
| `list_changes` | `changes:read` | Lists the changes in a period, or near a time, a case or a session |
| `get_change` | `changes:read` | Returns one change in full, with its summary and, if you ask, its history |
| `get_change_schema` | `changes:read` | Lists the kinds, sources, time forms, limits and the shortest call. It holds no project data |
| `get_change_coverage` | `changes:read` | Shows what the record holds for each kind and each source, and its gaps |
| `list_finding_changes` | `changes:read` and `findings:read` | Lists the changes linked to a case, each with the same fact as the card |
| `link_change_to_finding` | `changes:write` and `findings:read` | Links a change to a case. With `unlink: true`, it removes the link |

- `changes:write` is for project access tokens only. `changes:propose` is for agent connections only.
- A connection made with the default access choice gets `changes:read`. A connection made before Changes must reconnect to see changes.
- A token can make a change admins-only. It can make a change visible to everyone only where that is the default for its kind and subkind.
- An agent sees only the linked changes that its token can see. Without `changes:read_sensitive`, admins-only linked changes are left out.
- An agent sees admins-only changes only with the scope `changes:read_sensitive`. Only owners and admins can give it. Creating a token with it needs a code from your second factor when your two-factor authentication is on. Without two-factor authentication, it needs a sign-in in the last hour.
- An agent without `changes:read_sensitive` gets this sentence: "Entries marked admins-only are not shown to this connection. Their absence here says nothing about whether any exist."
- Only an owner or admin can create or adopt a token with `changes:read_sensitive`, or a token that can write organisation-wide changes. With two-factor authentication on, Sequential asks for a code. From 23 October 2026, a person without two-factor authentication can also create or adopt such a token, after a sign-in in the last hour.
- A token records changes only in its own project, unless an owner or admin allowed organisation-wide changes when they created the token. That setting cannot be changed later. The organisation-wide setting needs `changes:write`.

Agents get releases by default: send `include_releases: false` to leave them out. From 30 October 2026, a release in the answer of `list_changes` has `marker: true`, `id` null and `version` 0, and the same keys as a change, plus `environment`. From 1 November 2026, it also has `release`: the commit, the title of the release as text that your team typed, `has_notes`, `changes_total`, the cases that it names (`finding_ids`) and `group_key`. The notes and the list of changes are not in the answer. When a person confirmed a release row with the same environment and version, that row takes the place of the release, and from 1 November 2026 its `release` has the same fields. The title and the summary of the row stay the person's.

- In `get_overview`, a connection without `changes:read` gets `{"withheld": "needs changes:read"}` in place of the changes, when the project has a confirmed change that the connection can see (organisation-wide changes included), or when Sequential cannot check. Otherwise the briefing has no changes section. With `changes:read`, the section is `{"withheld": "not available"}` when Sequential cannot read the changes.
- When `get_overview` shows no change and no release for its period, it says: "No changes are recorded for this period. That says nothing about whether anything changed." When the project has no confirmed change that the connection can see (organisation-wide changes included), it adds: "No changes you can see are recorded in this project."

### How a sync from an agent works

- Preview first. `preview_changes` runs every free check and costs no AI screening. From 2 November 2026, on a connection with `changes:propose` and no `changes:write`, it checks the items as `propose_changes` keeps them: a late change without evidence is kept as uncertain, not refused. It then takes 1 to 50 items and no `sync` or `atomic`. On such a connection, `get_change_schema` names `propose_changes` as the first call and 50 items a call. On every connection, it lists the evidence types: `url`, `commit`, `tag`, `ticket`, `doc` and `file`. From 30 October 2026, a title that the check already passed shows `screen: "clean"`. A title that the check did not check yet shows `screen: "at_commit"`: `record_changes` checks it when it writes it, and can still keep it as a proposal or refuse it. A title that the check already flagged shows as `record_changes` would keep it: `proposed`, or refused with the reason `reads_as_agent_instruction` for an entry that a person already confirmed. The preview reads what the check remembers and does not check the title again. Send its `plan_hash` with `record_changes`. If the result would be different, `record_changes` stops and returns the new plan.
- Re-runs are safe. Each change has a key: its source, its source detail and its external id. A second run of the same sync updates the same changes. Send `external_id` when the source has one. Without it, the key comes from the kind, the start day and the title, so a changed title makes a new change.
- A token updates only its own changes. A new token does not update changes that an older token wrote. For the same key, `record_changes` answers `skip_duplicate` and `record_change` answers `exists`. `update_change` and `retract_change` answer `not_owned`. A person can still retract those changes in Sequential.
- A person's change wins. A sync never changes a change that a person recorded or confirmed. A change that someone retracted stays retracted.
- Times need a time zone. Send a date-time with an offset, such as `2026-10-21T09:00:00+02:00`. Or send a day (`2026-10-21`), a week (`2026-W43`) or a month (`2026-10`) together with `tz`, such as `Europe/Prague`. Sequential never guesses a time zone.
- Late entries need evidence. A token that records a change more than about a day after it happened must send at least one evidence entry, such as a commit, a ticket or a URL, and a confidence. A chat agent's late proposal without evidence is accepted, but it is marked as uncertain. A change with the source `conversation` and no evidence is also marked as uncertain, on time or late. From 2 November 2026, the answer of `record_changes` and `propose_changes` says so for such an item: `confidence: "uncertain"` and `confidence_reason`, which is `conversation_without_evidence` or `late_without_evidence`.
- Text is checked. Sequential refuses a title with a line break, a secret, an email address, a URL or an @handle. It replaces names of people with `[person]`. It checks agent titles for instructions to an AI before it stores them. A refused text gets a reason and a fixed hint, never the text itself: `text_shape`, `text_has_link`, `text_has_secret`, `reads_as_agent_instruction`, or `not_checked` when Sequential cannot check it now.
- From 30 October 2026, Sequential checks the title of a change from an agent with a question for change logs. If the title of a new entry reads as an instruction to an AI, Sequential does not refuse the entry. It keeps the entry as a proposal, with the outcome `proposed`, the reason `reads_as_agent_instruction` and a hint. The answer has `confirm_url`. The entry shows on the timeline only after a person confirms it. A new title on the agent's own open proposal also keeps it a proposal. An edit of a confirmed entry with such a title is still refused. With `atomic: true`, a proposed item does not stop the batch. A proposed item counts against the proposal limits. If the project already has 1,000 open proposals, Sequential refuses only that item, with `queue_full`. `propose_changes` keeps such a title as a proposal too, with the reason `reads_as_agent_instruction`.
- Coverage. A sync can declare the period that its source covers. Only then does an empty stretch mean "nothing happened, according to this source". Each connection records its own coverage. A source line merges the coverage of the connections whose entries you can see.
- Empty answers and gaps. To an agent, an empty list says: "No changes are recorded for this period. That says nothing about whether anything changed." For each kind, `get_change_coverage` says, for example: "Marketing: nothing recorded before 1 Sep 2026. A gap in the record, not a quiet period." Between two declared ranges of a source, it names the gap: "No coverage is declared between 1 Sep 2026 and 15 Sep 2026: a stretch there with no entries from this source is a gap in the record, not a quiet period."

## FAQ

### Why does a proposal say "Check this title"?

From 30 October 2026, a proposal whose title the check flagged shows "Check this title" beside its title. Under it, the line says "Its title reads like an instruction to an AI, not a record of what changed." Read the title, then click Confirm on that proposal, or Reject. When you confirm it, Sequential removes the flag. A release never has this flag.

On the Brief, a batch with such a title starts with "One title reads like an instruction to an AI: check it before you confirm.", or "2 titles read like instructions to an AI: check them before you confirm."

### What happens to a proposal that nobody confirms?

Expired proposals show under Expired on the Changes page, with Restore. A person can restore an expired proposal for up to 60 days after it was proposed.

From 22 October 2026, Sequential does not keep the text of a proposal that nobody confirmed. Once a day, it clears the title, summary, links and evidence of each proposal that was rejected more than 30 days ago, or that was proposed more than 61 days ago and not confirmed. A restore starts the count again. It also clears them in the history of the proposal. The title then reads: "Text cleared: this proposal was not confirmed". The record that the proposal existed stays, with its status.

A project can have at most 1,000 open proposals.

See also [Data retention and deletion](/docs/retention-and-deletion).

## Limits

| Limit | Value |
|---|---|
| Open proposals | 1,000 per project |
| Title, summary | 140 and 1,000 characters, one line |
| Tags, links, evidence | 10 each |
| Time | From 1 January 2000 to 366 days from now |
| Links between changes and cases | 10 changes per case, 50 cases per change |

### Day limits for tokens and agents

The day limits reset at 00:00 UTC.

| Limit | Value |
|---|---|
| Changes that tokens record | 2,000 a day per project |
| Proposals | 500 a day per project, 200 a day per connection |
| `preview_changes` calls | 100 a day per project, 20 a day per token |
| Items in one call | `record_changes` 100, `propose_changes` 50, `list_changes` 50 rows |

A change that a sync leaves unchanged does not count. From 29 October 2026, only what Sequential writes counts toward the day limits, and a `preview_changes` call counts only when it gets an answer. A refused call does not count. If a counted write then fails, Sequential gives the count back.

## Next steps

- [Changes on the chart](/docs/events-explorer#changes-on-the-chart): record a change for an interval of the Events chart.
- [Cases and fixes](/docs/findings): the Changes card under Fix on a case.
- [Sessions and replay](/docs/sessions-and-replay): That day on the page of a session.
- [Roles and permissions](/docs/roles-and-permissions): what each role can do.
- [Connect claude.ai](/docs/connect-claude-ai): connect a chat agent.
