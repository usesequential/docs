# Audit log of organisation changes

> The audit log records who changed what in your organisation, when, and from which IP address. Owners and admins read it in Settings › Organisation › Audit log.

> **Key facts**
>
> - It records changes that succeeded: teammates, roles, projects, keys, access tokens, claude.ai connections, recording settings and the questions.
> - It also records saved views, a case's fix links and its first hand-off, and each data export and download link.
> - Only owners and admins can see it. No one can edit or delete an entry. Entries expire after 400 days.
> - Sequential can fail to write an entry, and sign-ins rarely appear. A missing entry does not prove that nothing changed.
> - A support change starts with "Sequential support", never with the name of the staff member.

## What is recorded

| Group | Changes that Sequential records |
|---|---|
| Members | Invitations, joins, role changes, removals and teammates who leave |
| Organisation | Creation, renames, the two-factor policy, two-factor reminders, and the organisation limits and the retention exemption that Sequential support sets |
| Projects | Creation, detail saves, archive, restore and delete |
| Exports | Each export that starts, finishes or fails, and each download link that someone gets. The entry never holds the link |
| Ingest keys | Creation and revocation |
| Server keys | Creation and revocation of the keys of the [backend SDK](/docs/backend-sdk) |
| Access tokens | Creation and revocation of access tokens, for example project access tokens (`sq_pat_…`), and releases that a CI job or agent records with a token |
| claude.ai connections | Allow, the completed connection, a disconnect, each connection that Sequential ends, and each disconnect that the connected app reports. A Deny does not show in your log |
| Project settings | Recording settings, the background judging switch and changes to the questions |
| Cases | Fix links added and removed, the first hand-off of each case, hand-offs to an agent, and the settings of Where hand-offs go |
| Saved views | Saving, renaming and deleting a saved view. Also each funnel put on or taken off Simple view |
| Account | Rarely in your log: most account actions (sign-in, sign-out, password changes and resets, and two-factor codes) never reach your organisation's log. Do not use the log as a sign-in history. See [Why do sign-ins rarely appear?](#account-actions-and-sign-ins) |

Every action code, its sentence and the fields it stores are in [Action codes and stored fields](#action-codes-and-stored-fields).

## Read the log

1. Go to **Settings › Organisation › Audit log**.

   Result: The newest 50 entries show first.

   **If you need another organisation's log**

   Each organisation has its own log. Settings › Organisation shows the log of the organisation of the open project. Owners and admins can also click their name at the bottom of the rail, then Audit log, for the same log. If you belong to several organisations, open another one: in Settings › Your profile › Organisations, click the name of that organisation.

2. To see older entries, click **Show older entries**.

   Result: Each click adds 50 entries. At the end, the list says "That is the whole log."

3. To narrow the list, choose an action from **What**, a teammate from **Who**, or both.

   Result: The Who filter lists the teammates in the organisation. The filters search the whole log, not only the loaded entries. You can filter by action and by teammate, not by project or date.

   **If the action is not in What**

   The What filter lists only some actions, in words, in its own groups: Members, Organisation, Sign-in and security, Projects and keys, and Agents and tokens. It always lists the same actions. Other actions never show in it. To find another action, keep Everything in What and read the log.

4. To see all entries again, click **Show everything**.

| Part | What it shows |
|---|---|
| Sentence | Who did it and what they did. For example: "Ana Novak invited bo@example.com as an admin." |
| Time | How long ago it happened, for example "3 hours ago". Hover over it to see the date and the time, in the language and the time zone of your browser. |
| Address | The IP address the change came from, if Sequential recorded one. On a narrow screen, the address does not show. |

> **A missing entry is not proof**
>
> If Sequential cannot write an entry, the change still happens without an entry. So a missing entry does not prove that nothing changed.

## Find who changed something

Use the audit log to find who changed something, and when. For example:

- Replays of the sign-up form show what people type. See [How do I find who changed the recording settings?](#find-who-changed-the-recording-settings)
- A contractor has admin access. Who invited them, and with which role? See [How do I find who invited whom?](#find-who-invited-whom)
- Evidence shows different sessions this week. Did someone edit the questions? See [How do I find who changed the questions?](#find-who-changed-the-questions)
- PostHog events stopped. Did someone revoke the key, or archive the project?

## What the log does not show

- Removals and cancellations do not name the teammate. Case entries do not name the case or the project. Key and token entries do not name the project.
- The app does not show the browser, although each entry stores the browser's user agent.
- The app does not show the details of an entry. An entry stores more than its sentence says.

### What makes no entry, and what entries leave out

Everyday use makes no entry. These actions make no entry: watch a replay, run an Ask search, apply a saved view, give feedback on a verdict, or set a verdict on a case.

Sequential records only changes that succeeded. A wrong password, a rejected save or a looser recording setting that you do not confirm makes no entry. Exports are the exception. If an export starts and then fails, Sequential records the failure. Each download link also makes an entry. A refused export request makes no entry.

Sequential never writes passwords, tokens or one-time codes into an entry.

Sequential does not record these:

- creating an account
- regenerating backup codes
- changing your profile name
- declining an invitation
- failed sign-in attempts

What entries leave out:

- A details save reads as a rename. A save of the project's name, slug or environment reads "changed the name of the project …", also when only the slug or environment changed. The entry stores the values after the save, not before.
- A removal stores only the teammate's id or email address. With an id, it reads "removed a former member". "cancelled an invitation" stores only the invitation's id.
- Case entries do not name the case or the project, for example "linked a fix to a case". They do not show in Recent changes.
- An entry names its project while that project is in your list of projects. If it is not, the entry uses the name that it stores, or says "a project".
- The What filter has no `oauth.consent_denied`: Sequential records a Deny without an organisation, so no organisation's log shows it.
- To see what an entry stores, see [Action codes and stored fields](#action-codes-and-stored-fields).

## Who can see it, and how long entries last

Only owners and admins can see the log. Members and viewers see one line in its place, and Sequential refuses their requests for it. See [Roles and permissions](/docs/roles-and-permissions).

From 23 October 2026, a daily job deletes each entry 400 days after Sequential recorded it. Until the job deletes it, Sequential keeps the entry with its IP address. No setting in the app changes this. The exception is a `project.deleted` entry: after 90 days, Sequential removes the project name, the IP address and the browser from it. The entry then reads "deleted a project".

Deleting the organisation deletes its log. Sequential keeps its own record of the deletion outside the log. See [Retention and deletion](/docs/retention-and-deletion#delete-an-organisation).

Deleting a project keeps its entries and records the deletion.

## Changes by Sequential support

Sequential staff can make support changes to your organisation. They can change the project settings, archive or restore a project, and revoke an ingest key or an access token, for example a project access token (`sq_pat_…`). They can also turn the two-factor requirement on or off and set the organisation's limits. Each of these changes makes an entry in your audit log.

- The entry starts with "Sequential support", for example "Sequential support archived the project Checkout." It never shows the name of the staff member. A change that Sequential makes by itself starts with "Sequential".
- Sequential writes the entry together with the change. If it cannot write the entry, it does not make the change.
- The entry is the same as for the same change by a teammate, but it has no IP address. It does not hold the reason that the staff member gave.

### Support changes to recording settings and limits

After a support change to the recording settings, Who changed what under Settings › Recording & data names "Sequential support" in place of a teammate for that version.

From 13 October 2026, a change to the organisation's limits keeps only its values. For example: "Sequential support set the organisation’s limits: 15,000 sessions a month, events kept 30 days, recordings kept 30 days." The sentence leaves out a value that Sequential does not set. With no values, it reads "Sequential support changed the organisation’s limits." Older entries name one retention, which the sentence does not show. A limit that ends on its end date makes the same entry.

The action code is `organization.limits_changed`. See Organisation in [All action codes](#all-action-codes).

## A project's recent changes

The Recent changes list is at Settings › Recording & data. Only owners and admins see it. It lists the last 10 entries about the open project, with how long ago each happened. Each entry is the same sentence as in the audit log, for example "Ana Novak changed the settings of the project Checkout."

To see the whole log, click Audit log under the list. It opens the full organisation log, not filtered to the project. Some changes never show in the list: see [Why is a change missing from Recent changes?](#the-recent-changes-list)

### Messages in the log

| Message | Where | What it means | What to do |
|---|---|---|---|
| "That is the whole log." | Audit log, after the last entry | You reached the end of the list. | — |
| "Nothing recorded yet." | Audit log | The log is empty. | — |
| "Owners and admins read the audit log; you are a member." | Audit log and Recent changes | For members and viewers, the app shows one line like this in place of the entries. It does not ask Sequential for the log. | — |
| "Someone no longer in the organisation" | In an entry, in place of a name | The teammate left the organisation. Names come from your current list of teammates. | — |
| "Someone (the member list could not be read just now)" | Audit log and Recent changes, in place of a name | Sequential cannot read your list of teammates. | — |
| "Someone" | Recent changes, in place of a name | The list is still loading. | — |

## Action codes and stored fields

Look up an action code, its sentence, or the fields that an entry stores. The app does not show the stored fields.

### All action codes

The codes are in groups. Each group has a table: the action code, when Sequential records it, and the words of its sentence.

An action that has no sentence yet reads "recorded", then its words in quotes. For example: "Sequential recorded “retention cap exempt changed” for a project."

If no teammate did it, the entry starts with "Sequential support" for a support change, with the access token or agent connection that did it, or with "Sequential" for a job that Sequential runs by itself. For example: "The access token “CI” marked a release." The app finds the name in the token lists of the organisation's projects that you can open. If it cannot find the token, the entry starts with "An access token", or "An agent" for an agent connection.

When a token starts an export or gets a download link, the entry names the teammate who created the token, then the token. For example: "Ana Novak started a data export of the project Checkout with the access token “CI”." Entries for a finished or failed export start with "Sequential". See [Export your data](/docs/export-your-data#use-the-api-with-an-access-token).

Members

| Action code | Recorded when | Reads as |
|---|---|---|
| `member.invited` | Someone sends or resends an invitation | "invited bo@example.com as an admin" |
| `invitation.cancelled` | Someone cancels a pending invitation | "cancelled an invitation" |
| `member.joined` | Someone accepts an invitation | "joined the organisation" |
| `member.role_changed` | Someone changes a teammate's role | "made Maya Chen a viewer" |
| `member.removed` | Someone removes a teammate | "removed a former member" |
| `member.left` | A teammate leaves | "left the organisation" |

Organisation

| Action code | Recorded when | Reads as |
|---|---|---|
| `organization.created` | Someone creates the organisation | "created the organisation" |
| `organization.updated` | Someone renames the organisation | "renamed the organisation to “Acme Ltd”" |
| `organization.policy_changed` | Someone, or Sequential support, turns the two-factor requirement on or off | "made two-factor required for every member" or "made two-factor optional again" |
| `organization.settings_changed` | An owner or admin changes Who may invite. Only a real change makes an entry | "let only owners and admins invite people" or "let every member invite people" |
| `organization.limits_changed` | From 13 October 2026, Sequential support sets the organisation's limits, or a limit ends on its end date. Only the values are kept | "set the organisation’s limits: 15,000 sessions a month, events kept 30 days, recordings kept 30 days" |
| `organization.two_factor_reminder_sent` | From 13 October 2026, an owner or admin sends two-factor reminders. Only the number of teammates is kept | "sent 2 two-factor reminders" |
| `organization.bootstrapped` | Sequential set up the organisation for you, not through sign-up. Each later run of that setup adds another entry, for example when it adds a project or key for you | "set up the organisation" |
| `organization.retention_cap_exempt_changed` | From 13 October 2026, Sequential support exempts the events of the organisation's projects from the server-wide retention limit, or ends the exemption. The actor is "Sequential support" | "changed whether the organisation’s events may be kept longer than this server’s usual limit" |
| `organization.warehouse_export_changed` | Sequential support turns the warehouse export on or off for the organisation. The actor is "Sequential support" | "changed whether the organisation may export to a data warehouse" |
| `organization.share_offer_requested` | An owner or admin sends the link to a LinkedIn post with Send the link. The entry never holds the link | "asked for more sessions with a LinkedIn post (the share offer)" |
| `organization.share_offer_decided` | Sequential support decides on a share offer request. The actor is "Sequential support" | "decided on the organisation’s share offer request" |

Projects

Before 13 October 2026, the log also recorded a retention exemption for one project by Sequential support.

| Action code | Recorded when | Reads as |
|---|---|---|
| `project.created` | Someone creates a project | "created the project Checkout" |
| `project.updated` | Someone saves the name, slug or environment under Settings › Recording & data › The project | "changed the name of the project Checkout" |
| `project.archived`, `project.unarchived` | Someone archives or restores the project, or Sequential support archives or restores the project | "archived the project Checkout" or "restored the project Checkout" |
| `project.deleted` | Someone deletes a project | "deleted the project Checkout". From 27 October 2026, the entry also stores how the teammate confirmed the delete: an authenticator code, a backup code, a passkey or a recent sign-in |
| `project.retention_cap_exempt_changed` | Before 13 October 2026, Sequential support exempted the events of one project, or ended the exemption. The actor is "Sequential support" | "recorded “retention cap exempt changed” for a project" |

Exports

| Action code | Recorded when | Reads as |
|---|---|---|
| `project.export_requested` | An owner or admin clicks Yes, export this personal data under Settings › Data out, or a token with `exports:write` starts an export, and Sequential accepts it. A refused request makes no entry | "started a data export of the project Checkout" |
| `project.export_ready` | Sequential finishes the files of an export. No teammate is the actor | "finished a data export of the project Checkout" |
| `project.export_failed` | Sequential cannot finish an export. No teammate is the actor | "could not finish a data export of the project Checkout" |
| `project.export_downloaded` | An owner or admin clicks Download on a file, or a token gets a download link. Each link makes one entry | "downloaded a data export of the project Checkout" |

Ingest keys and server keys

| Action code | Recorded when | Reads as |
|---|---|---|
| `ingest_key.created` | Someone creates a key with Create key or Rotate under Settings › Keys | "created an ingest key" |
| `ingest_key.revoked` | Someone revokes a key with Revoke key, or with Revoke old key… after Rotate, or Sequential support revokes a key. Keep both leaves the old key live and records nothing | "revoked an ingest key" |
| `server_key.created` | Someone creates a server key for the backend SDK | "created a server key". The entry stores the last 4 characters of the key |
| `server_key.revoked` | Someone, or Sequential support, revokes a server key | "revoked a server key" |

Access tokens and releases

| Action code | Recorded when | Reads as |
|---|---|---|
| `access_token.created` | Someone creates a token, for example under Settings › Agents & tokens › Make a token | "created the agent access token “CI”". An older entry without the name reads "created an agent access token" |
| `access_token.revoked` | Someone revokes a token, or disconnects or cancels a claude.ai connection, in the app. Or a teammate ends a claude.ai connection of their own through the API. Or Sequential support revokes a token | "revoked the agent access token “CI”", or "disconnected the agent connection “…”" for a connection |
| `access_token.orphaned` | From 20 October 2026: Sequential sees that the teammate who created an access token lost access, and marks the token. It stops working 7 days later unless an owner or admin adopts it | "noted that an access token’s creator lost access", after "Sequential" |
| `access_token.unorphaned` | The token's creator got their access back before the 7 days ended, and the daily check removed the mark | "noted that an access token’s creator has access again", after "Sequential" |
| `access_token.adopted` | An owner or admin adopts a token whose creator lost access, with Adopt… under Settings › Agents & tokens or with the API, and becomes its creator | "took over the access token “CI”, whose creator lost access" |
| `release.created` | Someone records a release. From a CI job's access token, no teammate is the actor. From 10 November 2026, when a person posts a release, or an agent records one with an access token marked for an agent or with an agent connection, that person is the actor: for a token, the person who made it, and for a connection, the person who connected it | "marked a release". From a CI token, after the token, for example "The access token “CI” marked a release." Else after the person, for example "Ana Novak marked a release." |
| `release.finding_named` | From 9 November 2026: an owner or admin names a case in a release, under Releases that name this case on the case page. From 10 November 2026, also once for each case that an agent adds to a release it records again, with the person who made its token, or who connected it, as the actor | "named a case in a release" |
| `release.finding_unnamed` | From 9 November 2026: an owner or admin removes a case from a release on the case page | "removed a case from a release" |
| `release.retracted` | From 10 November 2026: an owner or admin retracts a release on its page in Changes | "retracted a release" |

claude.ai connections

| Action code | Recorded when | Reads as |
|---|---|---|
| `oauth.consent_granted` | Someone presses Allow on the consent page to connect claude.ai, and Sequential creates the connection | "allowed an agent to connect" |
| `oauth.default_project_changed` | From 1 November 2026: the teammate who made a connection to all projects of an organisation chooses another default project under Agents. The entry keeps the old and the new project id | "recorded “default project changed” for agent connections" |
| `oauth.token_issued` | claude.ai finishes the connection. No teammate is the actor | "finished connecting", after the agent connection, for example "The agent connection “…” finished connecting." |
| `oauth.grant_revoked` | Sequential ends a connection: its teammate lost access, changed or reset their password, or a sign-in code of the connection was used twice | "ended an agent connection" |
| `oauth.refresh_reuse_detected` | An old renewal credential of a connection was used again, so Sequential ended the connection. No teammate is the actor | "ended an agent connection whose refresh token was used twice" |
| `oauth.revoked_by_client` | The connected app told Sequential that it disconnected. No teammate is the actor | "ended its own connection", after the agent connection |

Cases

A token with `findings:link` can add fix links.

| Action code | Recorded when | Reads as |
|---|---|---|
| `finding.handed_off` | The first time a case is handed off: someone clicks Copy brief or Write a GitHub issue yourself on the case, or a token reads the case or its fix brief. Later hand-offs make no entry | "copied a case’s brief" (Copy brief), "opened a GitHub issue from a case" (Write a GitHub issue yourself) or "fetched a case’s brief" (a token) |
| `finding.link_added` | Someone, or a token with `findings:link`, adds a fix link. Adding a link that is already there makes no entry | "linked a fix to a case" |
| `finding.link_removed` | Someone removes a fix link. A token cannot remove one | "removed a fix link from a case" |
| `finding.mute_rule_created`, `finding.mute_rule_updated`, `finding.mute_rule_deleted` | From 4 November 2026: someone makes, changes or removes a mute rule | "recorded “mute rule created” for a case", and the same with "updated" or "deleted" |
| `finding.review_suggested` | From 5 November 2026: an agent suggests that a case is noise, not a problem or a duplicate | "suggested a case is noise", and so on |
| `finding.review_applied` | From 5 November 2026: an agent confirms a case, or dismisses it while Let agents dismiss cases is on | "confirmed a case is a problem" or "dismissed a case as noise", and so on |
| `finding.review_accepted`, `finding.review_kept_open` | From 5 November 2026: a teammate clicks Accept or Keep open on an agent's suggestion | "accepted an agent’s verdict on a case" or "kept a case open against an agent’s verdict" |
| `finding.review_declined` | From 5 November 2026: a teammate clicks Keep muted on an agent's “real” on a muted case | "recorded “review declined” for a case" |
| `session.reading_reviewed` | From 5 November 2026: an agent says whether the judge's reading of a session was right or wrong | "said the judge’s reading of a session was right" or "… was wrong" |
| `finding.kept_open`, `finding.keep_open_removed` | From 4 November 2026: someone clicks Keep in Open or Let rules apply on a case. A click that changes nothing makes no entry | "recorded “kept open” for a case" or "recorded “keep open removed” for a case" |
| `finding.dispatched` | An owner or admin clicks Hand to an agent or Copy brief for an agent on a case | "sent a case to the webhook", "tried to send a case to the webhook, which did not accept it", "took a case’s brief to paste to an agent" or "took a case’s brief for a GitHub issue" |
| `finding.draft_requested` | An agent asks for a draft fix with the tool `request_fix_draft` (a token with `findings:draft`). No teammate is the actor | "asked for a fix draft" |
| `finding.draft_approved` | An owner or admin approves an agent's request on the case | "approved a fix draft", then what happened to the case, for example "approved a fix draft and sent the case to the webhook" |
| `finding.draft_declined` | An owner or admin declines an agent's request | "declined a fix draft" |
| `dispatch_target.updated` | An owner or admin clicks Save address, Turn on or Turn off under Settings › Project › Where hand-offs go | "changed where hand-offs go" |
| `dispatch_target.rotated` | An owner or admin clicks New signing secret… in that part | "replaced the webhook’s signing secret" |

Project settings and the questions

| Action code | Recorded when | Reads as |
|---|---|---|
| `project.config_changed` | Someone saves the settings under Settings › Recording & data, or Sequential support changes the project settings | "changed the settings of the project Checkout" |
| `project.rubric_changed` | Someone saves the questions on the Questions page | "edited the judge’s questions in the project Checkout" |
| `project.rubric_reset` | Someone resets the questions to the default on the Questions page | "reset the judge’s questions in the project Checkout" |
| `project.rubric_restored` | Someone brings back an earlier version of the questions on the Questions page | "brought back an earlier version of the judge’s questions in the project Checkout" |
| `project.rubric_proposed` | A teammate, or an agent with an access token, proposes an edit to the questions. The entry stores counts and ids, never the text | "proposed an edit to the judge’s questions in the project Checkout" |
| `project.rubric_proposal_refused` | Sequential refuses the text of a proposed edit at one of its checks. The entry stores the check, never the text | "had a proposed edit to the judge’s questions refused in the project Checkout" |
| `project.rubric_proposal_applied` | Someone applies a proposed edit to the questions | "applied a proposed edit to the judge’s questions in the project Checkout" |
| `project.rubric_proposal_rejected` | Someone turns down a proposed edit to the questions | "turned down a proposed edit to the judge’s questions in the project Checkout" |

Saved views

| Action code | Recorded when | Reads as |
|---|---|---|
| `project.saved_view_created` | Someone saves a view | "saved the funnel “Sign-ups” as a view in the project Checkout" |
| `project.saved_view_updated` | Someone renames a saved view | "changed the saved funnel “Sign-ups” in the project Checkout" |
| `project.saved_view_deleted` | Someone deletes a saved view | "deleted the saved funnel “Sign-ups” from the project Checkout" |
| `project.saved_view_pinned_simple` | Someone pins a saved funnel to the Simple view with Pin to the Simple view on Workbench › Funnels, or through the API. See [Simple view](/docs/simple-view). | "put the saved funnel “Sign-ups” on the simple view of the project Checkout" |
| `project.saved_view_unpinned_simple` | Someone unpins a saved funnel with Unpin from the Simple view on Workbench › Funnels, or through the API. See [Simple view](/docs/simple-view). | "took the saved funnel “Sign-ups” off the simple view of the project Checkout" |

Changes timeline

| Action code | Recorded when | Reads as |
|---|---|---|
| `change.created` | A teammate, or an agent with an access token, records one new change on the Changes timeline. From a token, no teammate is the actor | "added a change to the timeline of the project Checkout" |
| `change.batch_recorded` | A teammate or an agent records several changes in one call. The entry stores counts and the ids of the changes written | "added several changes at once to the timeline of the project Checkout" |
| `change.updated` | Someone edits a change on the timeline | "edited a change on the timeline of the project Checkout" |
| `change.proposed` | An agent with an access token proposes changes for a teammate to confirm. No teammate is the actor | "proposed 3 changes for the timeline of the project Checkout", or "proposed a change for …" |
| `change.confirmed` | A teammate confirms a proposed change | "confirmed a proposed change on the timeline of the project Checkout" |
| `change.rejected` | A teammate turns down a proposed change | "turned down a proposed change on the timeline of the project Checkout" |
| `change.retracted` | Someone takes a change off the timeline, or merges it into another change | "took a change off the timeline of the project Checkout", or "merged a change into another on the timeline of …" |
| `change.restored` | Someone puts a change back that was taken off or turned down | "put a change back on the timeline of the project Checkout" |
| `change.finding_linked` | A teammate or a token links a change to a case. A link that is already there makes no entry | "linked a change to a case" |
| `change.finding_unlinked` | A teammate or a token removes the link between a change and a case | "unlinked a change from a case" |

Warehouse export

| Action code | Recorded when | Reads as |
|---|---|---|
| `project.warehouse_created` | An owner or admin sets up the warehouse export under Settings › Data out › Warehouse export | "set up a warehouse export for the project Checkout" |
| `project.warehouse_changed` | An owner or admin changes the warehouse export | "changed the warehouse export of the project Checkout" |
| `project.warehouse_tested` | An owner or admin tests the connection, or resumes the export, which tests it first. The entry stores whether the test passed | "recorded “warehouse tested” for a project" |
| `project.warehouse_started` | An owner or admin starts the warehouse export | "started the warehouse export of the project Checkout" |
| `project.warehouse_paused` | An owner or admin pauses the export. Or Sequential pauses it after failures, at the read limit or when the organisation may no longer export. Then no teammate is the actor | "paused the warehouse export of the project Checkout" |
| `project.warehouse_resumed` | An owner or admin resumes a paused export, after a test that passes | "resumed the warehouse export of the project Checkout" |
| `project.warehouse_deleted` | An owner or admin removes the warehouse export. The files in your bucket stay | "removed the warehouse export of the project Checkout" |

Agent trials

| Action code | Recorded when | Reads as |
|---|---|---|
| `trial.provisioned` | Sequential sets up an agent trial project for an agent. No teammate is the actor | "set up an agent trial" |
| `trial.claimed` | A teammate claims an agent trial project | "claimed an agent trial" |
| `trial.terms_accepted` | The teammate accepts the full terms and the data processing agreement for a trial that was claimed at sign-in | "accepted the terms for an agent trial" |

Account

| Action code | Recorded when | Reads as |
|---|---|---|
| `auth.sign_in` | A teammate signs in with a password, an emailed code, Google or GitHub, a passkey or the invitation mail. Sequential also signs in an account without a second factor after a password reset. That entry has no organisation | "signed in", "signed in with GitHub", "signed in from their invitation mail" or "signed in after resetting their password" |
| `auth.sign_in_pending_2fa` | The password is right, and Sequential asks for a two-factor code | "entered their password and was asked for a two-factor code" |
| `auth.two_factor_verified` | A teammate enters a code from the authenticator app or a backup code | "entered a two-factor code" |
| `auth.two_factor_enabled` | Two-factor turns on for the account | "turned on two-factor" |
| `auth.two_factor_disabled` | A teammate turns off two-factor | "turned off two-factor" |
| `auth.passkey_added` | A teammate adds a passkey | "added a passkey" |
| `auth.passkey_deleted` | A teammate removes a passkey | "removed a passkey" |
| `auth.account_link_started` | A teammate starts to link a Google or GitHub account | "started linking a GitHub account" |
| `auth.account_linked` | The provider completes the link. The entry has no organisation, so no organisation's log shows it. From 11 November 2026, for GitHub, it also has `login`, the GitHub login | "linked a GitHub account for signing in" |
| `auth.account_unlinked` | A teammate unlinks an account that they sign in with | "unlinked an account they signed in with" |
| `auth.sign_out` | A teammate signs out | "signed out" |
| `auth.session_revoked` | A teammate signs out one of their sessions | "signed out one of their devices" |
| `auth.sessions_revoked` | Sequential signs out the teammate's other sessions, for example after a password change. The entry stores how many. After a password reset, the entry has no organisation | "signed out their other devices" |
| `auth.password_changed` | A teammate changes their password | "changed their password" |
| `auth.password_reset` | A teammate resets their password with the reset mail. The entry has no organisation, so no organisation's log shows it | "reset their password" |
| `auth.password_set` | A teammate who has no password sets one. The entry has no organisation, so no organisation's log shows it | "set a password" |
| `auth.tokens_revoked` | A password reset revokes the access tokens that the teammate created. The entry stores the reason and the count. The entry has no organisation, so no organisation's log shows it | "had their personal access tokens revoked" |
| `auth.passkeys_removed_all` | A teammate removes all passkeys of the account with the link in a reset mail. The entry has no organisation, so no organisation's log shows it | "removed all their passkeys" |
| `auth.reauthenticated` | A teammate confirms their sign-in again before a sensitive change. The entry stores the outcome. The entry has no organisation, so no organisation's log shows it | "confirmed it was them again before a sensitive change" |
| `auth.new_device_mail` | Sequential mails the teammate about a sign-in from a new device. The entry holds no device data. The entry has no organisation, so no organisation's log shows it | "was mailed about a sign-in from a new device" |
| `auth.unfinished_two_factor_mail` | Sequential mails a teammate who did not finish a two-factor challenge in time. No teammate is the actor. The entry has no organisation, so no organisation's log shows it | "recorded “unfinished two factor mail” for their account" |
| `user.two_factor_step_up` | A teammate enters a two-factor code before a sensitive change. The entry stores the outcome and the method. The entry has no organisation, so no organisation's log shows it | "entered a two-factor code before a sensitive change" |
| `user.passkey_counter_regression` | A passkey answers with a counter that did not go up, which can show a copied passkey. Sequential refuses that check. The entry has no organisation, so no organisation's log shows it | "recorded “passkey counter regression” for their account" |

Sequential files an account action in the log of the organisation that was active in the teammate's session at that time. If no organisation was active, for example at a new sign-in, the entry is in no organisation's log. Some account actions never have an organisation. The Account table says which.

### What access token, case and saved-view entries store

The app does not show these values. Each entry stores them.

- `access_token.created`: `project_id`, `name` and `scopes`. A token that can write organisation-wide changes also has `changes_org_wide` `true`. From 23 October 2026, it also has `step_up`, the proof that Sequential checked: `recent_sign_in` for a sign-in on this device in the last hour, or `totp` or `backup` for a code. `access_token.adopted` has `step_up` too.
- `access_token.revoked`: `project_id`, `name`, `scopes` and `kind`. `kind` is `pat` for the tokens that you create, and `oauth` for a claude.ai connection. A revocation by Sequential support also has `kind`. From 20 October 2026, a token that the daily check revokes 7 days after its mark also has `reason`: `access_lost:` and why, for example `access_lost:member`.
- `access_token.orphaned`: `project_id` and `reason` (`user_deleted`, `org`, `member` or `role`). `access_token.unorphaned`: `project_id`, `reason` `access_restored` and `was`, the old reason. `access_token.adopted`: `project_id`, `name`, `scopes` and `was`, and `changes_org_wide` `true` for such a token.
- `oauth.consent_granted`: `client_id`, `redirect_host`, `project_id`, `grant_id`, `scopes`, `preset`, `role`, `feedback_auto` and `step_up`. `role` is the teammate's role in the organisation when they pressed Allow. `feedback_auto` is `true` only when the teammate let the agent send feedback without asking. `step_up` is the second factor that the teammate entered before Allow: `totp` for a code from the authenticator app, or `backup` for a backup code. It is `unknown` when Sequential could not read the factor. From 23 October 2026, for a teammate without two-factor authentication, it is `recent_sign_in`: the teammate signed in on this device in the last hour. Entries from before that day have `not_enrolled` for such a teammate. Entries from before 19 October 2026 have `totp_or_backup` for both kinds of code.
- `oauth.grant_revoked`, `oauth.refresh_reuse_detected` and `oauth.revoked_by_client`: `project_id`, `kind`, `reason` and `client_id`. When the connected app ends only one of its access credentials, `oauth.revoked_by_client` also has `token_kind`.
- These entries never hold the token itself.
- `release.created` from a CI token: `token_id`, `project_id`, `version`, `environment` and `commit_sha`. From 10 November 2026, also `released_at`, `finding_ids`, `source` (`token`) and `previous`: the release as it was stored before, or null. The entry has no teammate as actor.
- `release.created` from a person, from a token marked for an agent or from an agent connection (from 10 November 2026): the same keys, with `source` `api` for a person or `agent` for the token or the connection. From the token or the connection, also `via` (`token`), `token_id`, `token_kind` (`pat` for a token, `oauth` for a connection) and `for_agent`. The person is the actor. Sequential writes this entry before it stores the release, and does not store the release if it cannot write the entry.
- `release.created`, from 11 November 2026: also `remeasured` (`true`) when the post moved the time of a release that is not retracted and names cases, so that Sequential measures them again.
- `release.finding_named` from such a token or connection: `project_id`, `environment`, `version` and `number`, with `via`, `token_id`, `token_kind` and `for_agent`.
- `release.finding_named` and `release.finding_unnamed`: `project_id`, `environment`, `version` and `number`, the number of the case. The teammate who named or removed the case is the actor.
- `release.retracted`: the release as it was (`project_id`, `environment`, `version`, `released_at`, `commit_sha`, `finding_ids`, `source`, `created_by`) and `verifications_deleted`. The teammate who retracted it is the actor.
- `finding.link_added`: `number`, `kind` and `url`. From a token, also `token_id`, and the entry has no teammate as actor.
- `finding.link_removed`: `number` and `url`.
- `finding.mute_rule_created`: the rule (`kind`, `route`, `route_match`, `returns`), `from_finding`, `applies`, `muted` and `unmuted`. `finding.mute_rule_updated`: `before` and `after`, each with the rule and `applies`, and `muted` and `unmuted`. `finding.mute_rule_deleted`: the rule, `applies`, `muted` and `unmuted`. They hold no text from your sessions.
- `finding.kept_open` and `finding.keep_open_removed`: `number` and `muted_by`.
- `finding.handed_off`: `number` and `via`, and from a token also `token_id`. `via` tells how the case was handed off: `copy`, `issue`, `rest` or `mcp`.
- `finding.dispatched`: `number`, `kind` (`issue`, `prompt` or `webhook`) and `outcome`, and `failure` when a webhook send failed.
- `finding.draft_requested`: `number` and `token_id`. `finding.draft_approved`: `number`, `kind`, `outcome`, and `failure` when a webhook send failed. `finding.draft_declined`: `number`. None of them holds the brief or an address.
- `project.export_requested`: `project_id`, `export_id`, `from`, `to`, `format`, `via` and `projected_rows`. From a token, also `token_id`. `project.export_ready`: `project_id`, `export_id`, `rows_events`, `rows_sessions`, `bytes` and `files`, the number of files. `project.export_failed`: `project_id`, `export_id` and `code`. `project.export_downloaded`: `project_id`, `export_id` and `file`. From a token, also `via` and `token_id`. No export entry holds a download link.
- `organization.retention_cap_exempt_changed` and `project.retention_cap_exempt_changed`: `retention_cap_exempt` and `previous`, each `true` or `false`.
- `dispatch_target.updated`: `project_id` and `enabled`. `dispatch_target.rotated`: `project_id` and `generation`. Neither holds the webhook address or the secret.
- From a token, a case entry starts with "Sequential", for example "Sequential linked a fix to a finding."
- `project.saved_view_created`, `project.saved_view_updated` and `project.saved_view_deleted`: `kind`, `name` and `project_id`, then `before` and `after`. `kind` is `filter`, `funnel`, `flow`, `retention` or `sessions`. `before` and `after` hold the name, the conditions or steps and the version, as raw JSON. A save has no `before` and a delete has no `after`. So the log keeps the conditions of a deleted item, including any values in them.
- `project.saved_view_pinned_simple` and `project.saved_view_unpinned_simple`: `kind`, `name`, `project_id` and `previous_id`. `previous_id` is the id of the funnel that was on Simple view before. The entry has only its id, not its name.

See [Cases and fixes](/docs/findings).

### What a recording-settings entry stores

- Each setting that changed is in the entry, with the value before and after. For example: `/replay/masking/mask_all_inputs: true → false`.
- A change that made recording less private also stores what the teammate confirmed. To save such a change, the teammate typed the project slug and clicked Save and record more.
- The entry also stores the settings version.
- The audit log shows none of these. To see the changes, open Settings › Recording & data › Who changed what. The page also shows the current version and who saved it.

### What a new project records

A new project gets one default key per source. A staging or development project also gets its first recording-settings version, v1. None of these has its own entry. Sequential records only `project.created`.

So a staging project's Settings › Recording & data can show version 1 and who saved it, with no `project.config_changed` entry to match.

## FAQ

### How do I find who changed the recording settings?

1. Go to **Settings › Recording & data**.

2. In **Recent changes**, find a sentence such as "Ana Novak changed the settings of the project Checkout."

   Result: It names the teammate who saved. Note how long ago it happened.

3. Click **Audit log**.

4. From **What**, choose **Project settings changed**.

   Result: The name before each sentence is the teammate who saved, or "Sequential support".

5. Find the entry at the time that you noted.

   Result: If it is not loaded, click **Show older entries** until you reach that time.

6. To see which settings changed, go back to **Settings › Recording & data**.

7. Open **Who changed what**.

   Result: Each version opens to its changes, with the value before and after.

Recordings made while the looser settings were on keep what they captured. See [Recording settings](/docs/recording-settings) and [Masking and redaction](/docs/masking-and-redaction).

### How do I find who invited whom?

1. Go to **Settings › Organisation › Audit log**.

2. From **What**, choose **Someone was invited**.

   Result: Each entry reads like "Ana Novak invited bo@example.com as an admin." A resent invitation adds another entry.

3. To see when teammates accepted, choose **Someone joined**.

4. To see later role changes, choose **A role changed**.

   Result: For example: "Ana Novak made Maya Chen a viewer."

5. To see cancelled invitations and removed teammates, choose **An invitation was cancelled** or **Someone was removed**.

   Result: These entries do not name the teammate. See [What the log does not show](#what-the-log-does-not-show).

How invitations work: [Sign-up and invitations](/docs/sign-up-and-invitations).

### How do I find who changed the questions?

1. Go to **Settings › Recording & data**.

2. In **Recent changes**, look for "edited the judge’s questions" or "reset the judge’s questions".

   Result: The name before it is the teammate who saved. Note how long ago it happened.

3. For older changes, click **Audit log**.

   Result: The What filter has no choice for the questions, so keep Everything.

4. Click **Show older entries** until you reach that time.

5. To see which questions changed, open **Questions** and read **History**.

   Result: Each line names the version, when, the questions added, removed or reworded, and who changed it.

A change to the questions applies to sessions judged after the change. Sequential does not re-judge old sessions in bulk. See [Questions: what the judge asks](/docs/rubric).

### Who is named in an entry?

Names come from your current list of teammates. Messages in the log lists what shows in place of a name.

If no teammate made the change, the entry starts with "Sequential support" for a support change, with the access token or agent connection for a change by a token, and with "Sequential" for the jobs that Sequential runs by itself. The app finds the name in the token lists of the organisation's projects that you can open. If it cannot find the token, the entry starts with "An access token", or "An agent" for an agent connection.

### Why do sign-ins rarely appear?

Sequential also records account actions: sign-in, sign-out, password changes and resets, and two-factor codes. The two-factor codes include the code that turns on two-factor. Turning off two-factor and revoking sessions are account actions too.

Sequential files an account action under the organisation that the teammate's session had selected at that time. A new sign-in has no selected organisation yet, so sign-ins normally do not reach your log. An empty log shows "Nothing recorded yet."

Account actions other than sign-in, such as a password change or a sign-out, reach an organisation's log only in these cases. Earlier in that same sign-in, the teammate did one of these:

- created the organisation
- accepted an invitation to it
- opened a project in it after a project in another organisation

See [Two-factor authentication and account security](/docs/two-factor-and-security).

### Why is a change missing from Recent changes?

The list includes creation, detail saves, archive and restore, recording settings and changes to the questions. These do not show in it:

- Key changes, because Sequential files them under the key, not the project. Find them in the audit log.
- Changes to saved views. Find them in the audit log.
- Export entries. Find them in the audit log.
- Case entries.

## Related pages

- [Roles and permissions](/docs/roles-and-permissions): what each role can do.
- [Organisations, projects and keys](/docs/organisations-and-projects): projects and their keys.
- [Recording settings](/docs/recording-settings): what each setting records.
- [Masking and redaction](/docs/masking-and-redaction): what recordings hide.
- [Questions: what the judge asks](/docs/rubric): edit the judge's questions.
