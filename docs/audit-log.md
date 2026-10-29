# Audit log of organisation changes

> The audit log records who changed what in your organisation, when, and from which address. Owners and admins read it under Settings › Organisation › Audit log.

> **In short**
>
> - The audit log records changes to invitations, roles, projects, keys, access tokens, claude.ai connections, recording settings, the questions, a case's fix links and its first handoff, and saved views. It also records data exports, and each time someone gets a download link for an export file.
> - Only owners and admins can see it. No one can edit or delete an entry.
> - Each entry shows who, what, when and, if Sequential recorded one, the IP address.
> - Sequential can fail to write an entry. A missing entry does not prove that nothing changed.
> - Sign-ins rarely appear. Do not use the log as a sign-in history.

## What it is for

Use the audit log to find who changed something, and when. For example:

- Replays of the sign-up form show what people type. Who changed the recording settings?
- A contractor has admin access. Who invited them, and with which role?

The log records changes that succeeded, not everyday use. Data exports are the exception: a failed export and each download link also make an entry. See What makes no entry, below.

## Who can see it

Only owners and admins can see the log. For members and viewers, the app shows one line in its place, and Sequential refuses their requests for it. See [Roles and permissions](/docs/roles-and-permissions).

Each organisation has its own log. **Settings** › **Organisation** shows the organisation of the open project. To see the log of another organisation, open **Settings** › **Your profile**. Under **Organisations**, click the name of that organisation.

## Read the log

1. Open **Settings** › **Organisation** and go to **Audit log**. The newest 50 entries show first.
2. To see older entries, click **Show older entries**. Each click adds 50 entries. At the end, the list says "That is the whole log."
3. To narrow the list, choose an action from **What**, a person from **Who**, or both. To see all entries again, click **Show everything**. The filters search the whole log, not only the loaded entries.

**What** shows some actions in words, in groups: **Members**, **Organisation**, **Sign-in and security**, **Projects and keys** and **Agents and tokens**. **Who** lists the members of the organisation.

| Part | What it shows |
|---|---|
| Sentence | Who did it and what they did. For example: "Ana Novak invited bo@example.com as an admin." |
| Time | How long ago it happened, for example "3 hours ago". Hover over it to see the date and the time, in the language and the time zone of your browser. |
| Address | The IP address the change came from, if Sequential recorded one. On a narrow screen, the address does not show. |

> **A missing entry is not proof**
>
> If Sequential cannot write an entry, the change still happens without an entry. So a missing entry does not prove that nothing changed.

## What is recorded

| Group | Changes that Sequential records |
|---|---|
| **Members** | Invitations, joins, role changes, removals and members who leave |
| **Organisation** | Creation, renames, the two-factor policy, two-factor reminders, and the organisation limits and the retention exemption that Sequential support sets |
| **Projects** | Creation, detail saves, archive, restore and delete. Before 13 October 2026, also a retention exemption by Sequential support |
| **Exports** | Each export that starts, finishes or fails, and each download link that someone gets. The entry never holds the link |
| **Ingest keys** | Creation and revocation |
| **Server keys** | Creation and revocation of the keys of the [backend SDK](/docs/backend-sdk) |
| **Access tokens** | Creation and revocation, and releases that a CI job or agent records with a token |
| **claude.ai connections** | **Allow**, the completed connection, a disconnect, each connection that Sequential ends, and each disconnect that the connected app reports. Not **Deny** |
| **Project settings** | Recording settings, the background judging switch and changes to the questions |
| **Cases** | Fix links added and removed, and the first handoff of each case. A token with `findings:link` can add links. Also hand-offs to an agent, and the settings of **Where hand-offs go** |
| **Saved views** | Saving, renaming and deleting a saved view. Also each funnel put on or taken off Simple view |
| **Account** | Sign-in, sign-out, password changes and resets, and two-factor codes. Most account actions never reach your organisation's log. |

An action that has no sentence yet reads "recorded", then its words in quotes. For example: "Sequential recorded “retention cap exempt changed” for a project." If no person did it, the entry starts with "Sequential support" for a support change, with the access token or agent connection that did it, or with "Sequential" for a job that Sequential runs by itself. For example: "The access token “CI” marked a release." The app finds the name in the token lists of the organisation's projects that you can open. If it cannot find the token, the entry starts with "An access token", or "An agent" for an agent connection. When a token starts an export or gets a download link, the entry names the person who created the token, then the token. For example: "Ana Novak started a data export of the project Checkout with the access token “CI”." Entries for a finished or failed export start with "Sequential". See [Export your data](/docs/export-your-data#use-the-api-with-an-access-token).

## Changes by Sequential support

Sequential staff can make support changes to your organisation. They can change the project settings, archive or restore a project, revoke an ingest key or an access token, turn the two-factor requirement on or off, and set the organisation's limits. Each of these changes makes an entry in your audit log.

- The entry starts with "Sequential support", for example "Sequential support archived the project Checkout." It never shows the name of the staff member. A change that Sequential makes by itself starts with "Sequential".
- The entry has no IP address, so no address shows.
- The entry is the same as for the same change by a member of your organisation. It does not hold the reason that the staff member gave.
- Sequential writes the entry together with the change. If it cannot write the entry, it does not make the change.
- After a support change to the recording settings, **Who changed what** under **Settings** › **Recording & data** names "Sequential support" in place of a person for that version.
- From 13 October 2026, a change to the organisation's limits keeps only its values. For example: "Sequential support set the organisation’s limits: 15,000 sessions a month, events kept 30 days, recordings kept 30 days." The sentence leaves out a value that Sequential does not set. With no values, it reads "Sequential support changed the organisation’s limits." Older entries name one retention, which the sentence does not show. A limit that ends on its end date makes the same entry.

## A project's recent changes

The **Recent changes** list is at **Settings** › **Recording & data**. It lists the last 10 entries about the open project, with how long ago each happened. Each entry is the same sentence as in the audit log. For example: "Ana Novak changed the settings of the project Checkout." If Sequential cannot read your member list, "Someone (the member list could not be read just now)" shows in place of the name. While the list loads, "Someone" shows. To see the whole log, click **Audit log** under the list. It opens the full organisation log, not filtered to the project.

Key changes do not show in the list, because Sequential files them under the key, not the project. Find them in the audit log.

## Find who changed the recording settings

1. Open **Settings** › **Recording & data**. In **Recent changes**, find a sentence such as "Ana Novak changed the settings of the project Checkout." It names the person who saved. Note how long ago it happened.
2. Click **Audit log**.
3. From **What**, choose **Project settings changed**. The name before each sentence is the person who saved, or "Sequential support".
4. Find the entry at the time that you noted. If it is not loaded, click **Show older entries** until you reach that time.
5. To see which settings changed, go back to **Settings** › **Recording & data** and open **Who changed what**. Each version opens to its changes, with the value before and after.

Recordings made while the looser settings were on keep what they captured. See [Recording settings](/docs/recording-settings) and [Masking and redaction](/docs/masking-and-redaction).

## Limits

- **Sign-ins rarely appear.** Do not use the log as a sign-in history. Other account actions reach the log only in a few cases.
- **A details save reads as a rename.** A save of the project's name, slug or environment reads "changed the name of the project …", also when only the slug or environment changed.
- **Removals and cancellations do not name the person.**
- **Case entries do not name the case or the project**, and they do not show in **Recent changes**. For example: "linked a fix to a case".
- **Key and token entries do not name the project.**
- **You can filter by action and by person**, not by project or date. **What** lists only some actions. To find another action, keep **Everything** and read the log.
- **The app does not show the browser**, although each entry stores the browser's user agent.
- **The app does not show the details of an entry.** An entry stores more than its sentence says. See the notes below.
- **Deleting the organisation deletes its log.** Sequential keeps its own record of the deletion outside the log. See [Retention and deletion](/docs/retention-and-deletion#delete-an-organisation). Deleting a project keeps its entries and records the deletion.
- **Entries expire after 400 days.** From 23 October 2026, a daily job deletes each entry 400 days after Sequential recorded it. Until then, Sequential keeps the entry with its IP address. When the organisation is deleted, its entries go with it. No setting in the app changes this. The exception is a `project.deleted` entry: after 90 days, Sequential removes the project name, the IP address and the browser from it. The entry then reads "deleted a project".

### Who sees what, and how long entries last

- For members and viewers, the **Audit log** part and the **Recent changes** list each show one line in place of the entries. For example: "Owners and admins read the audit log; you are a member." The app does not ask Sequential for the log. Sequential also refuses their requests for the log.
- **Settings** › **Organisation** shows the log of the organisation of the open project. If you belong to several organisations, open another one from **Settings** › **Your profile** › **Organisations**.
- Owners and admins can also click their name at the bottom of the rail, then **Audit log**. It opens the log of the organisation of the open project.
- No one can edit or delete an entry. Entries expire after 400 days. No setting in the app controls how long Sequential keeps them.
- Sequential also removes entries when the organisation is deleted.

### What makes no entry

Everyday use makes no entry. These actions make no entry: watch a replay, run an **Ask** search, apply a saved view, give feedback on a verdict, or set a verdict on a case.

Sequential records only changes that succeeded. A wrong password, a rejected save or a looser recording setting that you do not confirm makes no entry. Exports are the exception. If an export starts and then fails, Sequential records the failure. Each download link also makes an entry. A refused export request makes no entry. Sequential never writes passwords, tokens or one-time codes into an entry.

Sequential does not record these:

- creating an account
- regenerating backup codes
- changing your profile name
- declining an invitation
- failed sign-in attempts

### All action codes

| Action code | Recorded when | Reads as |
|---|---|---|
| `member.invited` | Someone sends or resends an invitation | "invited bo@example.com as an admin" |
| `invitation.cancelled` | Someone cancels a pending invitation | "cancelled an invitation" |
| `member.joined` | Someone accepts an invitation | "joined the organisation" |
| `member.role_changed` | Someone changes a member's role | "made Maya Chen a viewer" |
| `member.removed` | Someone removes a member | "removed a former member" |
| `member.left` | A member leaves | "left the organisation" |
| `organization.created` | Someone creates the organisation | "created the organisation" |
| `organization.updated` | Someone renames the organisation | "renamed the organisation to “Acme Ltd”" |
| `organization.policy_changed` | Someone, or Sequential support, turns the two-factor requirement on or off | "made two-factor required for every member" or "made two-factor optional again" |
| `organization.settings_changed` | An owner or admin changes **Who may invite**. Only a real change makes an entry | "let only owners and admins invite people" or "let every member invite people" |
| `organization.limits_changed` | From 13 October 2026, Sequential support sets the organisation's limits, or a limit ends on its end date. Only the values are kept | "set the organisation’s limits: 15,000 sessions a month, events kept 30 days, recordings kept 30 days" |
| `organization.two_factor_reminder_sent` | From 13 October 2026, an owner or admin sends two-factor reminders. Only the number of members is kept | "sent 2 two-factor reminders" |
| `organization.bootstrapped` | Sequential set up the organisation for you, not through sign-up. Each later run of that setup adds another entry, for example when it adds a project or key for you | "set up the organisation" |
| `project.created` | Someone creates a project | "created the project Checkout" |
| `project.updated` | Someone saves the name, slug or environment under **Settings** › **Recording & data** › **The project** | "changed the name of the project Checkout" |
| `project.archived`, `project.unarchived` | Someone archives or restores the project, or Sequential support archives or restores the project | "archived the project Checkout" or "restored the project Checkout" |
| `project.deleted` | Someone deletes a project | "deleted the project Checkout". From 27 October 2026, the entry also stores how the person confirmed the delete: an authenticator code, a backup code, a passkey or a recent sign-in |
| `project.export_requested` | An owner or admin clicks **Yes, export this personal data** under **Settings** › **Data out**, or a token with `exports:write` starts an export, and Sequential accepts it. A refused request makes no entry | "started a data export of the project Checkout" |
| `project.export_ready` | Sequential finishes the files of an export. No person is the actor | "finished a data export of the project Checkout" |
| `project.export_failed` | Sequential cannot finish an export. No person is the actor | "could not finish a data export of the project Checkout" |
| `project.export_downloaded` | An owner or admin clicks **Download** on a file, or a token gets a download link. Each link makes one entry | "downloaded a data export of the project Checkout" |
| `organization.retention_cap_exempt_changed` | From 13 October 2026, Sequential support exempts the events of the organisation's projects from the server-wide retention limit, or ends the exemption. The actor is "Sequential support" | "changed whether the organisation’s events may be kept longer than this server’s usual limit" |
| `project.retention_cap_exempt_changed` | Before 13 October 2026, Sequential support exempted the events of one project, or ended the exemption. The actor is "Sequential support" | "recorded “retention cap exempt changed” for a project" |
| `ingest_key.created` | Someone creates a key with **Create key** or **Rotate** under **Settings** › **Keys** | "created an ingest key" |
| `ingest_key.revoked` | Someone revokes a key with **Revoke key**, or with **Revoke old key…** after **Rotate**, or Sequential support revokes a key. **Keep both** leaves the old key live and records nothing | "revoked an ingest key" |
| `server_key.created` | Someone creates a server key for the backend SDK | "created a server key". The entry stores the last 4 characters of the key |
| `server_key.revoked` | Someone, or Sequential support, revokes a server key | "revoked a server key" |
| `access_token.created` | Someone creates a token, for example under **Settings** › **Agents & tokens** › **Make a token** | "created the agent access token “CI”". An older entry without the name reads "created an agent access token" |
| `access_token.revoked` | Someone revokes a token, or disconnects or cancels a claude.ai connection, in the app. Or a person ends a claude.ai connection of their own through the API. Or Sequential support revokes a token | "revoked the agent access token “CI”", or "disconnected the agent connection “…”" for a connection |
| `access_token.orphaned` | From 20 October 2026: Sequential sees that the person who created an access token lost access, and marks the token. It stops working 7 days later unless an owner or admin adopts it | "noted that an access token’s creator lost access", after "Sequential" |
| `access_token.unorphaned` | The token's creator got their access back before the 7 days ended, and the daily check removed the mark | "noted that an access token’s creator has access again", after "Sequential" |
| `access_token.adopted` | An owner or admin adopts a token whose creator lost access, with **Adopt…** under **Settings** › **Agents & tokens** or with the API, and becomes its creator | "took over the access token “CI”, whose creator lost access" |
| `oauth.consent_granted` | Someone presses **Allow** on the consent page to connect claude.ai, and Sequential creates the connection | "allowed an agent to connect" |
| `oauth.token_issued` | claude.ai finishes the connection. No person is the actor | "finished connecting", after the agent connection, for example "The agent connection “…” finished connecting." |
| `oauth.grant_revoked` | Sequential ends a connection: its person lost access, changed or reset their password, or a sign-in code of the connection was used twice | "ended an agent connection" |
| `oauth.refresh_reuse_detected` | An old renewal credential of a connection was used again, so Sequential ended the connection. No person is the actor | "ended an agent connection whose refresh token was used twice" |
| `oauth.revoked_by_client` | The connected app told Sequential that it disconnected. No person is the actor | "ended its own connection", after the agent connection |
| `release.created` | A CI job or agent records a release with an access token. No person is the actor | "marked a release", after the token, for example "The access token “CI” marked a release." |
| `finding.handed_off` | The first time a case is handed off: someone clicks **Copy brief** or **Open a GitHub issue** on the case, or a token reads the case or its fix brief. Later handoffs make no entry | "copied a case’s brief" (**Copy brief**), "opened a GitHub issue from a case" (**Open a GitHub issue**) or "fetched a case’s brief" (a token) |
| `finding.link_added` | Someone, or a token with `findings:link`, adds a fix link. Adding a link that is already there makes no entry | "linked a fix to a case" |
| `finding.link_removed` | Someone removes a fix link. A token cannot remove one | "removed a fix link from a case" |
| `finding.dispatched` | An owner or admin clicks **Hand to an agent** or **Copy brief for an agent** on a case | "sent a case to the webhook", "tried to send a case to the webhook, which did not accept it", "took a case’s brief to paste to an agent" or "took a case’s brief for a GitHub issue" |
| `finding.draft_requested` | An agent asks for a draft fix with the tool `request_fix_draft` (a token with `findings:draft`). No person is the actor | "asked for a fix draft" |
| `finding.draft_approved` | An owner or admin approves an agent's request on the case | "approved a fix draft", then what happened to the case, for example "approved a fix draft and sent the case to the webhook" |
| `finding.draft_declined` | An owner or admin declines an agent's request | "declined a fix draft" |
| `dispatch_target.updated` | An owner or admin clicks **Save address**, **Turn on** or **Turn off** under **Settings** › **Project** › **Where hand-offs go** | "changed where hand-offs go" |
| `dispatch_target.rotated` | An owner or admin clicks **New signing secret…** in that part | "replaced the webhook’s signing secret" |
| `project.config_changed` | Someone saves the settings under **Settings** › **Recording & data**, or Sequential support changes the project settings | "changed the settings of the project Checkout" |
| `project.rubric_changed` | Someone saves the questions on the **Questions** page | "edited the judge’s questions in the project Checkout" |
| `project.rubric_reset` | Someone resets the questions to the default on the **Questions** page | "reset the judge’s questions in the project Checkout" |
| `project.saved_view_created` | Someone saves a view | "saved the funnel “Sign-ups” as a view in the project Checkout" |
| `project.saved_view_updated` | Someone renames a saved view | "changed the saved funnel “Sign-ups” in the project Checkout" |
| `project.saved_view_deleted` | Someone deletes a saved view | "deleted the saved funnel “Sign-ups” from the project Checkout" |
| `project.saved_view_pinned_simple` | Someone pins a saved funnel to the Simple view with **Pin to the Simple view** on Workbench › **Funnels**, or through the API. See [Simple view](/docs/simple-view). | "put the saved funnel “Sign-ups” on the simple view of the project Checkout" |
| `project.saved_view_unpinned_simple` | Someone unpins a saved funnel with **Unpin from the Simple view** on Workbench › **Funnels**, or through the API. See [Simple view](/docs/simple-view). | "took the saved funnel “Sign-ups” off the simple view of the project Checkout" |
| `project.rubric_restored` | Someone brings back an earlier version of the questions on the **Questions** page | "brought back an earlier version of the judge’s questions in the project Checkout" |
| `project.rubric_proposed` | A member, or an agent with an access token, proposes an edit to the questions. The entry stores counts and ids, never the text | "proposed an edit to the judge’s questions in the project Checkout" |
| `project.rubric_proposal_refused` | Sequential refuses the text of a proposed edit at one of its checks. The entry stores the check, never the text | "had a proposed edit to the judge’s questions refused in the project Checkout" |
| `project.rubric_proposal_applied` | Someone applies a proposed edit to the questions | "applied a proposed edit to the judge’s questions in the project Checkout" |
| `project.rubric_proposal_rejected` | Someone turns down a proposed edit to the questions | "turned down a proposed edit to the judge’s questions in the project Checkout" |
| `change.created` | A member, or an agent with an access token, records one new change on the Changes timeline. From a token, no person is the actor | "added a change to the timeline of the project Checkout" |
| `change.batch_recorded` | A member or an agent records several changes in one call. The entry stores counts and the ids of the changes written | "added several changes at once to the timeline of the project Checkout" |
| `change.updated` | Someone edits a change on the timeline | "edited a change on the timeline of the project Checkout" |
| `change.proposed` | An agent with an access token proposes changes for a person to confirm. No person is the actor | "proposed 3 changes for the timeline of the project Checkout", or "proposed a change for …" |
| `change.confirmed` | A person confirms a proposed change | "confirmed a proposed change on the timeline of the project Checkout" |
| `change.rejected` | A person turns down a proposed change | "turned down a proposed change on the timeline of the project Checkout" |
| `change.retracted` | Someone takes a change off the timeline, or merges it into another change | "took a change off the timeline of the project Checkout", or "merged a change into another on the timeline of …" |
| `change.restored` | Someone puts a change back that was taken off or turned down | "put a change back on the timeline of the project Checkout" |
| `change.finding_linked` | A person or a token links a change to a case. A link that is already there makes no entry | "linked a change to a case" |
| `change.finding_unlinked` | A person or a token removes the link between a change and a case | "unlinked a change from a case" |
| `project.warehouse_created` | An owner or admin sets up the warehouse export under **Settings** › **Data out** › **Warehouse export** | "set up a warehouse export for the project Checkout" |
| `project.warehouse_changed` | An owner or admin changes the warehouse export | "changed the warehouse export of the project Checkout" |
| `project.warehouse_tested` | An owner or admin tests the connection, or resumes the export, which tests it first. The entry stores whether the test passed | "recorded “warehouse tested” for a project" |
| `project.warehouse_started` | An owner or admin starts the warehouse export | "started the warehouse export of the project Checkout" |
| `project.warehouse_paused` | An owner or admin pauses the export. Or Sequential pauses it after failures, at the read limit or when the organisation may no longer export. Then no person is the actor | "paused the warehouse export of the project Checkout" |
| `project.warehouse_resumed` | An owner or admin resumes a paused export, after a test that passes | "resumed the warehouse export of the project Checkout" |
| `project.warehouse_deleted` | An owner or admin removes the warehouse export. The files in your bucket stay | "removed the warehouse export of the project Checkout" |
| `organization.warehouse_export_changed` | Sequential support turns the warehouse export on or off for the organisation. The actor is "Sequential support" | "changed whether the organisation may export to a data warehouse" |
| `organization.share_offer_requested` | An owner or admin sends the link to a LinkedIn post with **Send the link**. The entry never holds the link | "asked for more sessions with a LinkedIn post (the share offer)" |
| `organization.share_offer_decided` | Sequential support decides on a share offer request. The actor is "Sequential support" | "decided on the organisation’s share offer request" |
| `trial.provisioned` | Sequential sets up an agent trial project for an agent. No person is the actor | "set up an agent trial" |
| `trial.claimed` | A person claims an agent trial project | "claimed an agent trial" |
| `trial.terms_accepted` | The person accepts the full terms and the data processing agreement for a trial that was claimed at sign-in | "accepted the terms for an agent trial" |
| `auth.sign_in` | A person signs in with a password, an emailed code, Google or GitHub, a passkey or the invitation mail. Sequential also signs in an account without a second factor after a password reset. That entry has no organisation | "signed in", "signed in with GitHub", "signed in from their invitation mail" or "signed in after resetting their password" |
| `auth.sign_in_pending_2fa` | The password is right, and Sequential asks for a two-factor code | "entered their password and was asked for a two-factor code" |
| `auth.two_factor_verified` | A person enters a code from the authenticator app or a backup code | "entered a two-factor code" |
| `auth.two_factor_enabled` | Two-factor turns on for the account | "turned on two-factor" |
| `auth.two_factor_disabled` | A person turns off two-factor | "turned off two-factor" |
| `auth.passkey_added` | A person adds a passkey | "added a passkey" |
| `auth.passkey_deleted` | A person removes a passkey | "removed a passkey" |
| `auth.account_link_started` | A person starts to link a Google or GitHub account | "started linking a GitHub account" |
| `auth.account_linked` | The provider completes the link. The entry has no organisation, so no organisation's log shows it | "linked a GitHub account for signing in" |
| `auth.account_unlinked` | A person unlinks an account that they sign in with | "unlinked an account they signed in with" |
| `auth.sign_out` | A person signs out | "signed out" |
| `auth.session_revoked` | A person signs out one of their sessions | "signed out one of their devices" |
| `auth.sessions_revoked` | Sequential signs out the person's other sessions, for example after a password change. The entry stores how many. After a password reset, the entry has no organisation | "signed out their other devices" |
| `auth.password_changed` | A person changes their password | "changed their password" |
| `auth.password_reset` | A person resets their password with the reset mail. The entry has no organisation, so no organisation's log shows it | "reset their password" |
| `auth.password_set` | A person who has no password sets one. The entry has no organisation, so no organisation's log shows it | "set a password" |
| `auth.tokens_revoked` | A password reset revokes the access tokens that the person created. The entry stores the reason and the count. The entry has no organisation, so no organisation's log shows it | "had their personal access tokens revoked" |
| `auth.passkeys_removed_all` | A person removes all passkeys of the account with the link in a reset mail. The entry has no organisation, so no organisation's log shows it | "removed all their passkeys" |
| `auth.reauthenticated` | A person confirms their sign-in again before a sensitive change. The entry stores the outcome. The entry has no organisation, so no organisation's log shows it | "confirmed it was them again before a sensitive change" |
| `auth.new_device_mail` | Sequential mails the person about a sign-in from a new device. The entry holds no device data. The entry has no organisation, so no organisation's log shows it | "was mailed about a sign-in from a new device" |
| `auth.unfinished_two_factor_mail` | Sequential mails a person who did not finish a two-factor challenge in time. No person is the actor. The entry has no organisation, so no organisation's log shows it | "recorded “unfinished two factor mail” for their account" |
| `user.two_factor_step_up` | A person enters a two-factor code before a sensitive change. The entry stores the outcome and the method. The entry has no organisation, so no organisation's log shows it | "entered a two-factor code before a sensitive change" |
| `user.passkey_counter_regression` | A passkey answers with a counter that did not go up, which can show a copied passkey. Sequential refuses that check. The entry has no organisation, so no organisation's log shows it | "recorded “passkey counter regression” for their account" |

Sequential files an account action in the log of the organisation that was active in the person's session at that time. If no organisation was active, for example at a new sign-in, the entry is in no organisation's log. Some account actions never have an organisation. The table says which.

### Account actions and sign-ins

Sequential also records account actions: sign-in, sign-out, password changes and resets, and two-factor codes. The two-factor codes include the code that turns on two-factor. Turning off two-factor and revoking sessions are account actions too.

Sequential files an account action under the organisation that the person's session had selected at that time. A new sign-in has no selected organisation yet, so sign-ins normally do not reach your log. An empty log shows "Nothing recorded yet."

Account actions other than sign-in, such as a password change or a sign-out, reach an organisation's log only in these cases. Earlier in that same sign-in, the person did one of these:

- created the organisation
- accepted an invitation to it
- opened a project in it after a project in another organisation

Do not use the log as a sign-in history.

### The Recent changes list

- Only owners and admins see the list.
- The list shows entries as sentences, as in the audit log. These include creation, detail saves, archive and restore, recording settings and changes to the questions.
- Changes to saved views do not show in the list. Find them in the audit log.
- Export entries do not show in the list either. Find them in the audit log.

### More about the limits

- **Project names:** an entry names its project while that project is in your list of projects. If it is not, the entry uses the name that it stores, or says "a project".
- **Details saves:** the entry stores the values after the save, not before.
- **Removals and cancellations:** a removal stores only the member's id or email address. With an id, it reads "removed a former member". "cancelled an invitation" stores only the invitation's id.

### How names show

- Names come from your current member list. A person who left the organisation shows as "Someone no longer in the organisation". If Sequential cannot read the member list, the entry shows "Someone (the member list could not be read just now)".
- If no person made the change, the entry starts with "Sequential support" for a support change, with the access token or agent connection for a change by a token, and with "Sequential" for the jobs that Sequential runs by itself. The app finds the name in the token lists of the organisation's projects that you can open. If it cannot find the token, the entry starts with "An access token", or "An agent" for an agent connection.
- **What** always lists the same actions. Other actions never show in it. It has no `oauth.consent_denied`: Sequential records a **Deny** without an organisation, so no organisation's log shows it.

### What access token, case and saved-view entries store

The app does not show these values. Each entry stores them.

- `access_token.created`: `project_id`, `name` and `scopes`. A token that can write organisation-wide changes also has `changes_org_wide` `true`. From 23 October 2026, it also has `step_up`, the proof that Sequential checked: `recent_sign_in` for a sign-in on this device in the last hour, or `totp` or `backup` for a code. `access_token.adopted` has `step_up` too.
- `access_token.revoked`: `project_id`, `name`, `scopes` and `kind`. `kind` is `pat` for the tokens that you create, and `oauth` for a claude.ai connection. A revocation by Sequential support also has `kind`. From 20 October 2026, a token that the daily check revokes 7 days after its mark also has `reason`: `access_lost:` and why, for example `access_lost:member`.
- `access_token.orphaned`: `project_id` and `reason` (`user_deleted`, `org`, `member` or `role`). `access_token.unorphaned`: `project_id`, `reason` `access_restored` and `was`, the old reason. `access_token.adopted`: `project_id`, `name`, `scopes` and `was`, and `changes_org_wide` `true` for such a token.
- `oauth.consent_granted`: `client_id`, `redirect_host`, `project_id`, `grant_id`, `scopes`, `preset`, `role`, `feedback_auto` and `step_up`. `role` is the person's role in the organisation when they pressed **Allow**. `feedback_auto` is `true` only when the person let the agent send feedback without asking. `step_up` is the second factor that the person entered before **Allow**: `totp` for a code from the authenticator app, or `backup` for a backup code. It is `unknown` when Sequential could not read the factor. From 23 October 2026, for a person without two-factor authentication, it is `recent_sign_in`: the person signed in on this device in the last hour. Entries from before that day have `not_enrolled` for such a person. Entries from before 19 October 2026 have `totp_or_backup` for both kinds of code.
- `oauth.grant_revoked`, `oauth.refresh_reuse_detected` and `oauth.revoked_by_client`: `project_id`, `kind`, `reason` and `client_id`. When the connected app ends only one of its access credentials, `oauth.revoked_by_client` also has `token_kind`.
- These entries never hold the token itself.
- `release.created` from a token: `token_id`, `project_id`, `version`, `environment` and `commit_sha`. The entry has no person as actor.
- `finding.link_added`: `number`, `kind` and `url`. From a token, also `token_id`, and the entry has no person as actor.
- `finding.link_removed`: `number` and `url`.
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
- A change that made recording less private also stores what the person confirmed. To save such a change, the person typed the project slug and clicked **Save and record more**.
- The entry also stores the settings version.
- The audit log shows none of these. To see the changes, open **Settings** › **Recording & data** › **Who changed what**. The page also shows the current version and who saved it.

### Find who invited whom

1. Open **Settings** › **Organisation** › **Audit log**.
2. From **What**, choose **Someone was invited**. Each entry reads like "Ana Novak invited bo@example.com as an admin." A resent invitation adds another entry.
3. To see when people accepted, choose **Someone joined**.
4. To see later role changes, choose **A role changed**. For example: "Ana Novak made Maya Chen a viewer."
5. To see cancelled invitations and removed members, choose **An invitation was cancelled** or **Someone was removed**. These entries do not name the person. See Limits.

### Find who changed the questions

1. Open **Settings** › **Recording & data**. In **Recent changes**, look for "edited the judge’s questions" or "reset the judge’s questions". The name before it is the person who saved.
2. For older changes, click **Audit log**, then click **Show older entries** until you reach that time. **What** has no choice for the questions.
3. To see which questions changed, open **Questions** and read **History**. Each line names the version, when, the questions added, removed or reworded, and who changed it.

A change to the questions applies to sessions judged after the change. Sequential does not re-judge old sessions in bulk. See [Questions: what the judge asks](/docs/rubric).

### What a new project records

A new project gets one default key per source. A staging or development project also gets its first recording-settings version, v1. None of these has its own entry. Sequential records only `project.created`.

So a staging project's **Settings** › **Recording & data** can show version 1 and who saved it, with no `project.config_changed` entry to match.

### More questions the log answers

- **Evidence** shows different sessions this week. Did someone edit the questions?
- PostHog events stopped. Did someone revoke the key, or archive the project?

## Related

- [Roles and permissions](/docs/roles-and-permissions)
- [Sign-up and invitations](/docs/sign-up-and-invitations)
- [Two-factor authentication and account security](/docs/two-factor-and-security)
- [Organisations, projects and keys](/docs/organisations-and-projects)
- [Recording settings](/docs/recording-settings)
- [Masking and redaction](/docs/masking-and-redaction)
- [Questions: what the judge asks](/docs/rubric)
