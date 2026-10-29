# Changes: record what your company changed

> Record releases, price changes, campaigns, incidents and other changes, so people and agents can read your analytics against them. Members record changes in the app, CI and coding agents record them with a token, and chat agents propose them.

> **In short**
>
> - A change is one thing that your company changed, or one thing that changed around it: a release, a price, a campaign, an incident, a holiday.
> - Members record changes in the app. A CI job or a coding agent records them with a project access token. A chat agent, such as claude.ai, only proposes them. A person confirms each proposal in Sequential.
> - Changes are optional. Nothing in Sequential needs them.
> - Sequential never says that a change caused a movement in your data. It shows the changes that were recorded near a time that you look at, for example the first sighting of a case or a release check.
> - `get_overview` and `get_verification` show the recorded changes of their period. On a case, **Since when** lists the changes of the 3 days before Sequential first saw the case.
> - On the page of a session, under **Around this session**, **That day** lists the changes and releases of the day that the session started. See [Sessions and replay](/docs/sessions-and-replay).
> - In `get_overview`, a connection without `changes:read` gets `{"withheld": "needs changes:read"}` in place of the changes, when the project has a confirmed change that the connection can see (organisation-wide changes included), or when Sequential cannot check. Otherwise the briefing has no changes section. With `changes:read`, the section is `{"withheld": "not available"}` when Sequential cannot read the changes.
> - When `get_overview` shows no change and no release for its period, it says: "No changes are recorded for this period. That says nothing about whether anything changed." When the project has no confirmed change that the connection can see (organisation-wide changes included), it adds: "No changes you can see are recorded in this project."
> - If no change is recorded for a period, that does not mean that nothing changed.

## What Changes is

Changes record what your company did, and what happened outside it.

Each change has:

- **a time:** a moment, or a range with a start and an end. The time keeps its precision: a time of day, a day, a week or a month.
- **a kind and a subkind**, such as **Pricing** and `discount`.
- **an importance:** `major`, `minor` or `note`.
- **a title**, up to 140 characters, and an optional summary, up to 1,000 characters. Both are one line.
- **links and evidence**, up to 10 of each.
- **a source**, such as `github`, `stripe` or `manual`, and who wrote it.

A change belongs to one project, or to the whole organisation.

## Kinds

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

Releases that you send with `record_release`, `POST /api/releases` or the CLI also show as changes of the kind **Release**. You do not have to record them again. A release has no change id, so you cannot edit or retract it. On the **Changes** page, a release opens its release page. Agents get releases by default: send `include_releases: false` to leave them out.

## Who records changes

| Who | What they can do |
|---|---|
| Owner, admin | Read every change, also the admins-only ones. Record, edit, retract and restore changes. Confirm proposals. Link changes to cases. Record organisation-wide changes |
| Member | Read changes that everyone can see. Record, edit, retract and restore changes in the project. Confirm proposals. Link changes to cases |
| Viewer | Read changes that everyone can see, and the proposals |
| A project access token with `changes:write` (a CI job or a coding agent) | Record confirmed changes in its project |
| A chat agent with `changes:propose` (claude.ai, ChatGPT) | Propose changes. A person confirms them in Sequential |

A member can record a change that only owners and admins can see, for example a planned **Pricing** change or a **Company** change of the subkind `sales`. The kind, the subkind and the time set who sees the change by default. Under **Who sees it**, **Only owners and admins see it** can make a change admins-only. Only an owner or admin can widen who sees it. After the member saves an admins-only change, the member cannot see it. The page says: "Recorded. Only owners and admins see it, so it does not show for you."

- `changes:write` is for project access tokens only. `changes:propose` is for agent connections only.
- A connection made with the default access choice gets `changes:read`. A connection made before Changes must reconnect to see changes.
- Only an owner or admin can create or adopt a token with `changes:read_sensitive`, or a token that can write organisation-wide changes. With two-factor authentication on, Sequential asks for a code. From 23 October 2026, a person without two-factor authentication can also create or adopt such a token, after a sign-in in the last hour.
- The organisation-wide setting needs `changes:write`.

## Record a change in the app

Open **Changes**, then click **Record a change**, or press N. Pick a **Kind**, type **What changed**, and set **When**. By default, the time is now, in your own time. Click **Record the change**. The page of the change opens.

You can also start from the chart on Workbench › **Events**. There, **Record a change** and an interval, such as **Record a change, 14 Oct**, opens this form. **When** then starts at the start of that interval and ends at its end, **At a known time**. See [Changes on the chart](/docs/events-explorer#changes-on-the-chart).

**Changes** is in the left rail, after **People**, for every role. Press G, then H. It is also in the search palette. A viewer can open it, but **Record a change** is off for a viewer: "Viewers read the timeline; an owner, admin or member records and edits changes."

When nothing is on the timeline, the page says "Nothing is on the timeline yet."

The **Timeline** on the **Changes** page lists the confirmed changes by day, newest first, with the project's releases. It shows the latest 100. Chips above it show one kind at a time. Click a change to open its page:

- **Edit** opens the form. **Save the change** saves your edit.
- **Retract…** asks for a reason. The change leaves the timeline and is no longer read against any case. Its history stays.
- **Merge into another…** retracts a duplicate into the change that it repeats. A merged change cannot be restored.
- **History** lists each version, and who wrote it.

Retracted changes are under **Retracted** on the **Changes** page. Each one has **Restore**.

## Record changes from an agent

An agent records changes through MCP, or with `POST /api/agent/<tool>`.

| Tool | Scope | What it does |
|---|---|---|
| `record_change` | `changes:write` | Records one change. The same key again returns the existing change and changes nothing |
| `record_changes` | `changes:write` | Syncs 1 to 100 changes from one source. It updates only the fields that the source owns |
| `preview_changes` | `changes:read` | Shows what `record_changes` would do, item by item. It writes nothing |
| `update_change` | `changes:write` | Edits one change that this token wrote. It also closes a range and sets whether the change happened |
| `retract_change` | `changes:write` | Retracts one change that this token wrote. Only a person can restore it |
| `propose_changes` | `changes:propose` | Proposes 1 to 50 changes. It returns a link to the proposals in Sequential |
| `list_changes` | `changes:read` | Lists the changes in a period, or near a time, a finding or a session |
| `get_change` | `changes:read` | Returns one change in full, with its summary and, if you ask, its history |
| `get_change_schema` | `changes:read` | Lists the kinds, sources, time forms, limits and the shortest call. It holds no project data |
| `get_change_coverage` | `changes:read` | Shows what the record holds for each kind and each source, and its gaps |

The smallest call is `record_change` with a kind and a title. Sequential sets the time to now and fills in the rest. Its answer names the defaults that it used.

- **Preview first.** `preview_changes` runs every free check and costs no AI screening. A title that Sequential checks only when `record_changes` writes it shows `screen: "at_commit"`. A title that the check already refused shows as refused, with the reason `reads_as_agent_instruction`: the preview reads what the check remembers and does not check the title again. Send its `plan_hash` with `record_changes`. If the result would be different, `record_changes` stops and returns the new plan.
- **Re-runs are safe.** Each change has a key: its source, its source detail and its external id. A second run of the same sync updates the same changes. Send `external_id` when the source has one. Without it, the key comes from the kind, the start day and the title, so a changed title makes a new change.
- **A token updates only its own changes.** A new token does not update changes that an older token wrote. For the same key, `record_changes` answers `skip_duplicate` and `record_change` answers `exists`. `update_change` and `retract_change` answer `not_owned`. A person can still retract those changes in Sequential.
- **A person's change wins.** A sync never changes a change that a person recorded or confirmed. A change that someone retracted stays retracted.
- **Times need a time zone.** Send a date-time with an offset, such as `2026-10-21T09:00:00+02:00`. Or send a day (`2026-10-21`), a week (`2026-W43`) or a month (`2026-10`) together with `tz`, such as `Europe/Prague`. Sequential never guesses a time zone.
- **Late entries need evidence.** A token that records a change more than about a day after it happened must send at least one evidence entry, such as a commit, a ticket or a URL, and a confidence. A chat agent's late proposal without evidence is accepted, but it is marked as uncertain.
- **Text is checked.** Sequential refuses a title with a line break, a secret, an email address, a URL or an @handle. It replaces names of people with `[person]`. It checks agent titles for instructions to an AI before it stores them. A refused text gets a reason and a fixed hint, never the text itself: `text_shape`, `text_has_link`, `text_has_secret`, `reads_as_agent_instruction`, or `not_checked` when Sequential cannot check it now.
- **Organisation-wide changes.** A token records changes only in its own project, unless an owner or admin allowed organisation-wide changes when they created the token. That setting cannot be changed later.

## Confirm proposals

A proposal from a chat agent does not show on the timeline until a person confirms it. Proposals wait under **Proposed**, at the top of the **Changes** page. The link that `propose_changes` returns opens the **Changes** page with those proposals first, marked **From your link**. A batch of proposals can also show as a decision on the **Brief**. A confirmation in the chat, or a button in the chat, is not a confirmation.

- Members, admins and owners confirm or reject proposals. An admins-only proposal needs an owner or admin.
- A viewer sees the proposals without **Confirm** or **Reject**. Under **Proposed**, the page says "Viewers read proposals; an owner, admin or member confirms or rejects them."
- Each proposal has **Confirm** and **Reject**. A batch of more than one has **Confirm all** and **Reject all**. Select a proposal, then press E to confirm or X to reject.
- An owner or admin can also click **Confirm for the whole company**. The change then applies to every project of the organisation. A release cannot be confirmed for the whole company.
- You can confirm several proposals at once only when each one is clean: no possible duplicate, no time that disagrees with a release, not uncertain, and with evidence if it was late.
- To confirm several proposals at once, or a proposal that only owners and admins see, you need two-factor authentication and a code from the last 15 minutes. Without two-factor authentication, confirm one proposal at a time.
- A proposal stays open for 30 days. After that, it expires. A person can restore it for up to 60 days after it was proposed. Expired proposals show under **Expired** on the **Changes** page, with **Restore**.
- From 22 October 2026, Sequential does not keep the text of a proposal that nobody confirmed. Once a day, it clears the title, summary, links and evidence of each proposal that was rejected more than 30 days ago, or that was proposed more than 61 days ago and not confirmed. A restore starts the count again. It also clears them in the history of the proposal. The title then reads: "Text cleared: this proposal was not confirmed". The record that the proposal existed stays, with its status.
- A project can have at most 1,000 open proposals.

## Who sees a change

Each change is visible to everyone who can open its project, or to owners and admins only. An organisation-wide change is visible to everyone in the organisation, or to owners and admins only. The kind and subkind set the default. See **Kinds** above.

- A token can make a change admins-only. It can make a change visible to everyone only where that is the default for its kind and subkind.
- An agent sees admins-only changes only with the scope `changes:read_sensitive`. Only owners and admins can give it. Creating a token with it needs a code from your second factor when your two-factor authentication is on. Without two-factor authentication, it needs a sign-in in the last hour.
- A change that a reader cannot see answers in the same way as a change that does not exist. A count, a list or a page never shows that a hidden change exists.
- An agent without `changes:read_sensitive` gets this sentence: "Entries marked admins-only are not shown to this connection. Their absence here says nothing about whether any exist."
- Shared pages and shared replays never show changes.

## Link a change to a case

From 22 October 2026, you can link a change to a case that the change is meant to address. Examples: a release, a flag, a copy change or a new price. After the link, the case page shows the change and one fact: whether Sequential saw the case again after the change. Linking is optional. Cases and Changes work the same without it.

### On the case page

- The **Changes** card is under **Fix**.
- When no change is linked, the card says: "Fixed it with a flag, a copy change or a price? Link that change here."
- **Link a change** opens a list of the confirmed changes of this project and of the whole organisation from the last 90 days. You can link more than one change at a time.
- Under each linked change, the card shows one of these facts:
  - "Not seen since this change. Last seen <time>, before it."
  - "Last seen <time>, around the time of this change."
  - "Seen again after this change: last seen <time>."
  - "This change starts later. Nothing to compare yet."
  - "Planned. Nothing to compare yet."
- The card says: "Seen or not seen is a fact about this case, not proof that a change worked." Sequential does not say that a change fixed or caused something.
- To unlink a change, click **Unlink** next to it.

### On the Changes page

- A change with links shows "Addresses F-12" for each case. An incident shows "Explains F-12". Each number opens that case.
- On the page of a change, **Cases it addresses** lists the linked cases. Pick a case in **Choose a case…**, then click **Link**. Only a confirmed change that happened or is planned can be linked.

### Who can do it

- Every role can see the **Changes** card when a change is linked. You see only the changes that you can see on the Changes page. A change marked admins-only shows only to owners and admins, with the label "Admins only".
- Owners, admins and members can link and unlink changes. These are the roles that can record changes. Viewers cannot.
- A case can have at most 10 linked changes. A change can address at most 50 cases. Above the limit, Sequential refuses the link: "A finding can have at most 10 linked changes." or "A change can address at most 50 findings."

### For agents

| Tool | Scopes | What it does |
|---|---|---|
| `list_finding_changes` | `changes:read` and `findings:read` | Lists the changes linked to a case, each with the same fact as the card |
| `link_change_to_finding` | `changes:write` and `findings:read` | Links a change to a case. With `unlink: true`, it removes the link |

- An agent sees only the changes that its token can see. Without `changes:read_sensitive`, admins-only changes are left out.

## Nothing recorded is not nothing changed

Changes are only as complete as what your team and your agents record. So Sequential never reads a period with no changes as a quiet period.

- An empty timeline says: "Nothing is on the timeline yet." It never says that nothing changed.
- To an agent, an empty list says: "No changes are recorded for this period. That says nothing about whether anything changed."
- A list near a time, a finding or a session says: "Nearness is not cause." The **Since when** line of a case says it too. That line names at most 3 changes, each with how long before the first sighting it started, for example "3 h before".
- On the page of a session, **That day** says "Changes recorded that day. Nearness is not cause." It names at most 20 changes and releases. A change at a known time says "before this visit" or "after it started". See [Sessions and replay](/docs/sessions-and-replay).
- A sync can declare the period that its source covers. Only then does an empty stretch mean "nothing happened, according to this source".
- Each connection records its own coverage. A source line merges the coverage of the connections whose entries you can see.
- For each kind, `get_change_coverage` says, for example: "Marketing: nothing recorded before 1 Sep 2026. A gap in the record, not a quiet period." Between two declared ranges of a source, it names the gap: "No coverage is declared between 1 Sep 2026 and 15 Sep 2026: a stretch there with no entries from this source is a gap in the record, not a quiet period."
- Sequential shows no score or percentage for how complete your changes are.

## Limits

| Limit | Value |
|---|---|
| Changes that tokens record | 2,000 a day per project |
| Proposals | 500 a day per project, 200 a day per connection |
| `preview_changes` calls | 100 a day per project, 20 a day per token |
| Items in one call | `record_changes` 100, `propose_changes` 50, `list_changes` 50 rows |
| Open proposals | 1,000 per project |
| Title, summary | 140 and 1,000 characters, one line |
| Tags, links, evidence | 10 each |
| Time | From 1 January 2000 to 366 days from now |

The day limits reset at 00:00 UTC. A change that a sync leaves unchanged does not count. From 29 October 2026, only what Sequential writes counts toward the day limits, and a `preview_changes` call counts only when it gets an answer. A refused call does not count. If a counted write then fails, Sequential gives the count back.
