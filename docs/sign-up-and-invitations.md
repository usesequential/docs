# Sign-up and invitations

> Create your Sequential account, invite teammates to your organisation, and join an organisation from an invitation.

> **At a glance**
>
> - **Before you start:** An inbox at the address you sign up or are invited with. Nothing in your app.
> - **Know this:** On the hosted service, anyone can [create an account](#create-your-account) with a password or, when available, an emailed code or Google.
> - **Know this:** To add a colleague, use [Invite people](#invite-teammates). Each invitation goes to one email address; its link works for 48 hours.
> - **Who can:** Owners and admins. Members and viewers only while Who may invite is Every member, up to their own role.
> - **Default:** Who may invite: Every member, up to their own role. Only owners and admins can change it, in Settings › Organisation.

> **In short**
>
> - To join, click [Accept invitation](#accept-an-invitation), sign in with the invited address, then Join. Link expired? Ask for a new invitation.
> - Open the Verify email link within 24 hours. Invitation, trial claim and waitlist approval links can prove your address.
> - [Leaving](#manage-organisations) removes your access at once. Deleting an organisation deletes the data of all its projects.

## Create your account

| Way | Password | Verify email |
|---|---|---|
| [Emailed code](#emailed-code), when Sequential sends sign-in codes | None | Not needed: the first code creates the account already verified |
| Password | At least 10 characters | Needed |
| [Google](#sign-in-with-google), when available | None | — |

Variants (tabs on the page; each is written out below): Emailed code · Password

### Emailed code

> **A code sign-in to an account that was never verified**
>
> If an account exists for your address but its email was never verified, your first code sign-in proves that the address is yours. Sequential then removes the password of the account and every other sign-in method that is linked to it, and signs out all its sessions. Then it marks the address as verified. To use a password again, open Settings › Security and click Set password. Or click Forgot your password? on the Sign in page.

1. Enter your **Work email** on Sign in or on Create an account.

2. Click **Email me a code**.

3. Type the code from the email "Your Sequential code".

   Result: When all 6 digits are in, Sequential checks the code. You can also click **Continue**.

4. If you have turned on two-factor authentication, enter your two-factor code, as after a password.

   Result: A trusted device skips it.

Result: Sequential opens the page of the link that you came from, such as an invitation. Otherwise it opens the Brief. If your account belongs to no organisation, onboarding opens, and you set up your organisation.

Code rules and limits: [Sign in or sign up with an emailed code](#sign-in-or-sign-up-with-an-emailed-code).

### Password

1. On **Create an account**, enter your **Work email**.

2. Click **Use a password instead**.

3. Enter a **Password** of at least 10 characters.

4. Click **Create account**.

   Result: Sequential sends "Verify your email for Sequential".

5. Open the **Verify email** link within 24 hours.

   Result: The link verifies your address and signs you in.

Result: You set up your organisation. If you came from an invitation, you go back to the invitation.

You cannot sign in with your password until you verify your address. If you cannot find the verify email, click Forgot your password? on the Sign in page and reset your password.

Under Create account and under Email me a code, the page says: "By creating an account, you confirm that you act for a business or organisation and accept the Terms. See the Privacy Policy." The [Terms of Service](/terms) and the [Privacy Policy](/privacy) are linked there.

### How email verification works in detail

- Verification, waitlist approval and invitations arrive by email, each tied to the exact address that you sign up or are invited with. Access does not depend on how you instrument your product.
- When Sequential sends no sign-in codes, the Password field shows at once.
- If you try to sign in with your password before you verify your address, Sequential opens the Verify your email page. It says that the address has an account that is not verified yet. It has Send the link again and Sign in instead. Without your address in its link, it asks for The address you signed up with, with Send the link.
- After a password sign-up, the page says "We sent a link to {your address}. Open it on this device to finish; it works for 24 hours." It has Send the link again and Sign in instead. It also has Wrong address? Start again and a link to reset your password. The link signs you in only in the browser where you open it.
- After each send, wait 30 seconds before you send the link again.
- If the link expired, or you copied only part of it, the page has the title This link did not work and explains what went wrong. It lets you send a new link.
- After you verify your address, the link does not sign you in again. Sign in with your password. If you open the link again, the page has the title Sign in to carry on and says "If you just opened the link in the mail, {your address} is verified. Sign in with it." It has Sign in.
- From 11 October 2026, a completed password reset also verifies your address. See [Two-factor authentication and account security](/docs/two-factor-and-security).

Some emails prove your address, so the account needs no verify email. From 11 October 2026, the link in three emails also proves your address: the claim link in an agent trial's email, Accept invitation in an invitation, and the link in the waitlist email "You're in: create your Sequential account". Create your account from that link, in the same browser tab, with the address that the email went to. Sequential then creates the account already verified and sends no verify email. You go straight on: to the claim, to the invitation, or to set up your organisation.

- The proof works once. It works only while the trial is not claimed or expired, while the invitation is pending, or while the waitlist approval is not used.
- A trial proof lasts 24 hours after the email. An invitation proof lasts until the invitation expires. A waitlist proof lasts 7 days.
- A reload, a new tab, a forwarded link without its `#m=` part, or another address gets the usual verify email.
- The proof is the `#m=` part at the end of the link. Your browser does not send it to any server, and the page removes it from the address bar at once. Sequential stores only a hash of it. Sequential does not record its own app on a page that opens with it.

See [Agent trial](/docs/agent-trial).

From 23 October 2026, if the address already has an account, the page answers the same as for a new address. Sequential then sends the email "You already have a Sequential account", with Sign in and a link to reset your password. It sends at most one such email an hour.

## Sign in or sign up with an emailed code

From 20 October 2026, you can sign in with a 6-digit code that Sequential sends to your email. The steps are in [Emailed code](#emailed-code).

### How emailed codes work in detail

- When Sequential sends sign-in codes, Create an account starts with an emailed code.
- You do not need a password.
- Create an account does not ask for your name. If you use Create an account with an address that already has an account, the code signs you in.
- If the address has no account yet, the first code creates it, with your address already verified. Sequential sends no verify email and no second code.
- The code step of the Sign in page says: "If this email has no account yet, Continue creates one: you confirm that you act for a business or organisation and accept the Terms. See the Privacy Policy." It says this for every address. The code step of Create an account has no such line, because the line is under Email me a code.
- There is no checkbox for the Terms line.
- A new account has no name yet. Sequential asks for your name once, later: on the first step of onboarding, or on the invitation page before you join. You can also add it on Settings › Your profile. Until you add it, other members see your email address in place of a name.
- On the code step, Send a new code sends another code, and Use another address takes you back.
- The page gives the same answer for every address. Sequential sends the code only when the address has an account, or when the sign-up mode lets the address create one. Code emails to an address with no verified account also have a daily limit. Past it, Sequential sends no email, but the page still says that it sent the code. See [Limits and defaults](/docs/limits). The sign-up mode and the daily limits for new accounts apply to a sign-up with a code.
- The code has 6 digits. It expires 5 minutes after Sequential sends it.
- Three wrong tries end the code. Ask for a new code.
- Each new code replaces the code before it. Only the newest code works.
- A code works once.
- The email has no link. If you did not ask for a code, ignore the email.
- Sequential stores the code only as a keyed hash.
- An account that you create with a code has no password. It can still set up two-factor authentication. To add a password, open Settings › Security. The Password card says "You sign in with emailed codes, so this account has no password. Add one to sign in without waiting for a mail." Click Set password. See [Two-factor authentication and account security](/docs/two-factor-and-security#two-factor-authentication-without-a-password).
- A link to Create an account can name the page to open after sign-up, such as an invitation. Sequential opens only a page of its own app. For an agent connection, it opens only the exact page where you allow the connection. With any other `/oauth/` address, a new account goes to onboarding.
- For the limits on codes, see [Limits and defaults](/docs/limits).

### What our own pages record

Sequential records its own app, `app.usesequential.com`, and its website, `www.usesequential.com`, with its own SDK, into Sequential's own project. It records page views, clicks with the text of the element, form submits and session replays. A replay masks every input. Page text is not masked, so the replay shows the text that you saw, except what you type: the text in a search, filter or email field, and every place that shows those words again, such as search results or a line that repeats your search, are not recorded. When you are signed in to the app, the SDK knows you by your Sequential user id, with your email and name. Nobody signs in on the website, so there the SDK does not know who you are.

The sign-up, sign-in, waitlist and invitation pages, the two-factor setup and **Send feedback** also send Sequential's own product events:

- `signup_viewed`: where you came from, the sign-up mode, and whether the page showed the form, the waitlist, or that it could not check whether sign-up is open
- `signup_field_started`: the name of a field, `email` or `password`, once per field. Never what you type
- `signup_submitted`: that the form was sent, with a password or for an emailed code
- `signup_refused`: the error code of a refused sign-up only. A server error sends nothing
- `account_created`: how the account was made: with a password, with an emailed code, or from an invitation
- `waitlist_joined`: where you came from only. It comes from the waitlist form, and from a sign-up that Sequential puts on the waitlist
- `signed_in`: that you signed in with a password or an emailed code, and whether Sequential asked for a two-factor code
- `sign_in_refused`: the error code of a refused sign-in only. A server error sends nothing
- `two_factor_enabled`: that your first two-factor code was confirmed
- `invite_accepted`: the role of an accepted invitation only. Never the organisation, the person who invited you, or your email
- `feedback_sent`: the number of a feedback item after Sequential accepted it. Never its text. See [Send feedback to the Sequential team](/docs/send-feedback)

These events hold no name, no email and no typed text. An event with any other value is not sent. Sequential records nothing on a claim link, a reset link, an OAuth page or a staff page, or on a page on the way to one of them. It records nothing in a page opened with an email's proof link (`#m=`). Nothing is recorded in the demo, or while Sequential staff view the app as a customer. An email verification, a password reset and, when Google sign-in is available, a Google sign-in send no event from these pages. Sequential's own backend sends them: see **What our own backend records**.

### What our own backend records

From 18 October 2026, Sequential's own backend also sends product events to Sequential's own project, with the [backend SDK](/docs/backend-sdk). Each event has a fixed list of properties. An event never holds a name, an email, a web address, a version or text that someone typed. Its person is a Sequential user id, and its account is an organisation id.

- `email_verified`: that you verified your email, and how long after sign-up: less than 1 hour, 1 to 24 hours, or more
- `password_reset_completed`: that you reset your password
- `signed_in`: that you signed in with Google, when Google sign-in is available
- `agent_tool_called`: the name of the agent tool, the kind of client (Claude Code, Cursor, ChatGPT, claude.ai or other), and MCP or REST. Its person is the person of the token
- `fix_linked`: the kind of a fix link: pull request, commit or issue. Never its address
- `release_recorded`: that a release was recorded. Never its version, commit or environment
- `finding_opened_by_detector`: the kind of a new finding. Its person is the owner of the organisation
- `verification_changed`: the new state of a fix's verification. Its person is the owner of the organisation

The backend also sends its own errors. For a 5xx answer, it sends the method, the route pattern (such as `/api/projects/:id`) and the status. For a background job that failed, it sends the name of the job, an error code and the lines of the stack. It never sends the message of an error.

An event that your own request in the app caused can carry the session of that browser. An event from a token, a detector or a background job has no session.

## Sign in with Google

When Google sign-in is available, the Sign in page shows Continue with Google. Your first Google sign-in creates your account, so the sign-up mode applies.

If two-factor authentication is on, a Google sign-in asks for a two-factor code, the same as a password sign-in. Continue with Google does not sign you in to an account that has two-factor authentication on if you have not used Google with that account before.

### How Google sign-in works in detail

- When Google sign-in is available, Continue with Google sits above the email form.
- Create an account shows the same button. There, the line under the form covers it.
- On the Sign in page, under Continue with Google, the page says "By creating an account, you confirm that you act for a business or organisation and accept the Terms. See the Privacy Policy." A new account then goes to onboarding, or to the page of the link that you came from. An existing account goes to that page, or to the Brief.
- When Google sign-in is available and you have turned on two-factor authentication, a Google sign-in asks for your code on the same page as a password sign-in. A trusted device skips it.
- An account created with Google has no password. It can set up two-factor authentication without one, and it can add a password with Set password on Settings › Security. See [Two-factor authentication without a password](/docs/two-factor-and-security#two-factor-authentication-without-a-password).
- If Sequential refuses a Google sign-in, you return to the Sign in page, which says why. The page keeps the link that you came from, such as an invitation. So after a second try, you still land on that page.

#### Messages after Continue with Google

| Message | Where | What it means | What to do |
|---|---|---|---|
| "This address has not been let in yet. Join the waitlist and we will mail you." | Sign in | The page also shows a Join the waitlist link. | — |
| "Sign-up here is by invitation only. Ask a teammate to invite you." | Sign in | Sign-up is invite-only. | — |
| "This account uses two-factor. Sign in with your code first, then connect the provider." | Sign in | The account has two-factor authentication on, and you have not used Google with it before. | Sign in with your email, your password and your code. |
| "Sign-in did not complete. Try again." | Sign in | A refusal that Sequential does not know. | — |

## Invite teammates

Invite from the rail or from Settings › Members.

Variants (tabs on the page; each is written out below): From the rail · From Settings

### From the rail

1. Near the bottom of the left rail, click **Invite people**.

   Result: The Invite people dialog opens.

2. If you belong to more than one organisation, choose one in **Invite to**.

3. In **Email addresses**, enter one or more addresses. Put commas, spaces or new lines between them. You can paste a list.

4. Choose a **Role**.

   Result: The list shows only the roles that you can give. Each role has a sentence that says what it can do. See [Roles and permissions](/docs/roles-and-permissions).

5. Click **Send invitation**. For more addresses, the button says how many, for example **Send 3 invitations**.

   Result: Sequential sends one invitation to each address.

Result: Each address then gets a line, for example "Invited as a member. The mail is on its way; its link works for 48 hours."

### From Settings

1. Open **Settings › Members**.

2. Under **Invite people**, enter one or more **Email addresses**.

3. Choose a role in the **as** list.

   Result: It shows only the roles that you can give. See [Roles and permissions](/docs/roles-and-permissions).

4. Click **Send invitation**.

   Result: The invitee gets an email with an **Accept invitation** button.

The invitation expires after 48 hours. It also stops working if the sender leaves or is removed from the organisation. Then send a new invitation to the same address. Send again keeps the original sender, so it does not help.

### Who may invite, daily limits, resend and cancel

- Every role can invite people, with their own role or a lower one. Members and viewers can invite only while Who may invite is set to Every member, up to their own role. This is the default.
- Who may invite is on Settings › Organisation. It has two choices: Every member, up to their own role and Only owners and admins. Only owners and admins can change it. Members and viewers see the choice, but they cannot change it.
- When only owners and admins invite, a member or viewer sees a line about it in the dialog and on Settings › Members. The dialog also names who can invite for them. They cannot send an invitation.
- The default Role is Member. For a viewer, it is Viewer.
- Only an owner can invite another owner. An admin does not see Owner in the Role list.
- Each person can send at most 20 invitations a day. Each organisation can send at most 100. The day is a UTC day. A resend counts too. Over a limit, the dialog says so, and when to try again.
- When a member or viewer sends an invitation, each owner and admin with a verified email address gets an email about it. The email says "This address is outside your domain." when the domain of the invited address is not the domain of the person who sent the invitation.
- Next to a sent address, Copy invitation copies a text with the invitation link for that address. The invitation email cannot carry your own note, so send the text with your own words.
- An example of the invitation email: "Ana invited you to join Acme on Sequential". The email says in one line what Sequential is. It ends with why you got it: "You got this mail because Ana entered this address. If you did not expect it, ignore it."
- From 13 October 2026, every email from the hosted Sequential ends with "Sequential · Help: support@usesequential.com". On a self-hosted server, the help address is `MAIL_REPLY_TO`. Without it, the email ends with "Sequential" only.
- In the invitation, Sequential removes links, email addresses, web addresses and IP addresses from the inviter's name and the organisation name. It cuts a name that is longer than 60 characters and ends it with "…". If nothing is left, the email says "A teammate" or "an organisation". The waitlist emails do the same with your name. They start with "Hi" and your name, or with "Hi there," if nothing is left. The verification and password reset emails start with "Hi," and contain no name.
- [Roles and permissions](/docs/roles-and-permissions) shows what each role can do.
- The [Audit log](/docs/audit-log) records invitations, joins and cancellations.

#### Messages in the Invite people dialog

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Already in Acme, so nothing was sent." | Invite people | The address is already in the organisation (here, Acme). | — |
| "In Acme, only owners and admins invite people." | Invite people, Settings › Members | Who may invite is Only owners and admins. | — |
| "You sent 20 invitations today, the most one person can in a day." | Invite people | You reached the daily limit for one person. | — |
| "The organisation sent 100 invitations today, the most it can in a day." | Invite people | The organisation reached its daily limit. | — |
| "Sequential could not count today’s invitations, so it sent none. Try again in a minute." | Invite people | Sequential cannot count the invitations, so it sends none. | — |
| "Owners and admins get a mail about each invitation you send." | Invite people, for a member or viewer | Only those with a verified email address get it. | — |
| "Acme requires two-factor. Turn yours on in Settings › Security first." | Invite people | Your organisation requires two-factor authentication and your account does not have it. | — |

To resend or cancel an invitation, use Invitations waiting.

Invitations waiting lists the open invitations, with their number. It is on Settings › Members and at the bottom of the Invite people dialog. Each row shows the email, the role and when the link expires, for example "Invited as a member; the link expires in 2 days."

- Owners and admins also see who sent it, for example "sent by Ana". If that person left the organisation, the row says "sent by someone who has left".
- To send the email again, click Send again.
- To withdraw an invitation, click Cancel invitation…. The row asks, for example, "Cancel the invitation to ana@example.com? The link in the mail stops working; you can invite them again later." Click Cancel invitation, or click Keep it. The link stops working, and "The invitation to ana@example.com is cancelled." confirms it.
- Members and viewers see the list without the sender. Send again and Cancel invitation… work only on the invitations that they sent. A line above the list says "You can cancel only the invitations you sent."
- When there are no open invitations, the list says "No invitation is waiting."
- If you invite an address that already has a pending invitation, the new invitation replaces it. The earlier link stops working. Before you send, the dialog says how many of the addresses have an invitation waiting.
- If an invitation has not expired, Send again keeps the same link and gives it a new 48 hours.
- If an invitation has expired, Send again sends a new invitation with a new link. The expired row stays in the list until you cancel it.
- The row of an expired invitation says, for example, "the link expired 3 hours ago".
- From 8 November 2026, the headline at the top of Settings › Members counts an expired invitation as waiting too, for example "4 people, 2 invitations waiting". The last line of that block then says, for example, "1 invitation link expired". See [Roles and permissions](/docs/roles-and-permissions).

## Accept an invitation

1. In the invitation email, click **Accept invitation**.

2. Sign in, or [create an account](#create-your-account), with the invited address.

3. Click **Join <organisation>**, for example **Join Acme**.

   Result: You join, and the Brief opens on a project of the organisation.

| If the page says | Do this |
|---|---|
| This invitation has expired | Ask the person who invited you to send a new invitation. |
| This invitation link cannot be used | Ask the person who invited you to send a new invitation. |
| This invitation is no longer valid | Ask the person who invited you, or another owner or admin, to send a new one. It is also no longer valid if the sender has left the organisation. |
| This invitation is for another address | Click Sign out. Then sign in with the address the invitation was sent to. |
| Verify your email first | Click Verify my address and verify your email. Then come back. |

Every invitation page is in [What each invitation page shows](#what-each-invitation-page-shows).

If the organisation requires two-factor authentication, you cannot use its projects until you set it up.

### What each invitation page shows

| You are | You see | Do this |
|---|---|---|
| Signed out | You are invited to Sequential | The page says "The invitation is for {your address}. Create an account with that address, or sign in with it, and you can accept." Click Sign in. Or click Create account to sign up with the invited address, which is already filled in. You can change it. The sign-up page says "You will join the organisation that invited you." With an emailed code, you come back to the invitation at once. With a password, you come back after you verify your email. |
| Signed out, with a new address, from the email's link | Your name and Create my account | Enter Your name and click Create my account. Sequential creates your account, already verified, and shows the invitation. Then click Join <organisation>. I have an account: sign in and Use an emailed code instead are on the same page. If the address already has an account, the page says "This address already has an account. Sign in to accept the invitation." |
| Signed out, with an expired link | This invitation has expired | The page says "An invitation can be accepted for 48 hours." Ask the person who invited you to send a new invitation. |
| Signed out, with a link that cannot be used | This invitation link cannot be used | The page says "The invitation may have been withdrawn or used already, or the link is incomplete." Ask the person who invited you to send a new invitation. |
| Signed in as the invited address | Join and the organisation's name, with who invited you, the role and when the invitation expires | Click Join <organisation>. You join, and the Brief opens on a project of the organisation. If your account has no name yet, enter Your name first. To decline, click Decline. The page asks "Decline the invitation to <organisation>? To join later, you need a new invitation." Click Decline, or click Keep the invitation. |
| Signed in as someone else | This invitation is for another address | Click Sign out. Then sign in with the address the invitation was sent to. |
| Signed in but not yet verified | Verify your email first | Click Verify my address. Open your verification link. Then come back. |
| Signed in, with a link that is no longer valid | This invitation is no longer valid | Ask the person who invited you, or another owner or admin, to send a new one. The page has Go to your brief, or Set up your organisation if you have no organisation. |

A link is no longer valid if it expired, was cancelled or was already used. It is also no longer valid if the sender has left the organisation. When you are signed out, the page checks the link first and says "Checking the link…". If Sequential cannot check the link, the page shows You are invited to Sequential.

Under Create my account, the page says "By creating an account, you confirm that you act for a business or organisation and accept the Terms. See the Privacy Policy." This button only creates the account. You join when you click Join.

When you are signed out, the page checks only whether the link expired or cannot be used. It does not check the sender. So a link whose sender left the organisation shows You are invited to Sequential. After you sign in, the page reads the invitation. Then it says if the invitation is no longer valid.

If sign-up is not open, Sequential refuses Create account from a link that is no longer valid.

The [audit log](/docs/audit-log) does not record account creation or a declined invitation.

## Manage organisations

You can belong to several organisations, with one role in each. Leave, rename or delete an organisation:

- To leave, open Settings › Members › Leave the organisation, at the end of the page. This takes effect at once.
- The only owner cannot leave. Make someone else an owner first: see [Hand over ownership](/docs/roles-and-permissions#hand-over-ownership).
- To rename (owners and admins), open Settings › Organisation and click Rename beside the name.

> **Before you delete an organisation**
>
> Deleting an organisation deletes each of its projects' data, as a project delete does. The recordings become unreadable at once, because Sequential deletes their encryption keys. The storage deletes the recording files later. See [Retention and deletion](/docs/retention-and-deletion).
>
> You do not need to delete the projects first.

To delete (owners only), open Settings › Organisation › Delete the organisation. Type the name of the organisation, then click Delete <organisation> for good.

### Who can create, switch, rename, leave or delete

| Action | Who can do it | Where |
|---|---|---|
| Create | You, if you belong to no organisation, or if you are a member or viewer in every organisation | Name your organisation, the first step of onboarding. Sequential opens it after your first sign-in. Otherwise go to `/onboarding`. |
| Switch | Everyone | The project switcher at the top of the left rail |
| Rename | Owners and admins | Settings › Organisation: click Rename beside the name, type the new name, then click Save. |
| Leave | Everyone except the only owner | Settings › Members › Leave the organisation |
| Delete | Owners only | Settings › Organisation › Delete the organisation: type the name of the organisation, then click Delete <organisation> for good |

Switch organisations, and which organisation Settings shows:

- To switch to another organisation, select one of its projects in the switcher.
- An organisation with no projects, or only archived ones, shows No project yet. Owners and admins can click it to add a project. Other roles see "An owner or admin adds one".
- When you belong to more than one organisation, the switcher lists the projects under the name of each organisation.
- The top row of the rail shows the current project and its organisation.
- Settings › Organisation and Settings › Members show the organisation of the open project.
- In the Invite people dialog, Invite to can also pick an organisation with no project. The dialog links to Settings › Members of that organisation.

Leave and delete:

- If you leave, you lose access to all the organisation's projects at once. To come back, you need a new invitation.
- To leave, click Leave <organisation> at the end of Settings › Members. Then click Leave <organisation> again, or click Stay. This takes effect at once.
- Every role sees Settings › Members and Settings › Organisation.
- Deleting an organisation removes the organisation, its members, invitations, projects and ingest keys, and its audit log. See [Retention and deletion](/docs/retention-and-deletion).

### Create an organisation

- After your first sign-in, if you belong to no organisation, Sequential opens onboarding.
- Name your organisation asks for an Organisation name. If your account has no name yet, it also asks for Your name.
- The Slug field holds a short handle made from the name. Its hint says "A short handle in links and the API. It follows the name until you change it."
- A slug uses lowercase letters, digits and single dashes, up to 60 characters. Otherwise the page says "Use lowercase letters, digits and single dashes for the slug, at most 60 characters."
- The slug must not belong to another organisation. If it does, you see "That slug is taken. Try another one."
- You cannot change the slug later. On Settings › Organisation, Slug says "You cannot change the slug after you create the organisation."
- You become the organisation's owner.
- Onboarding then moves on to your first project, the install step and the agent step. The agent step is optional. [Your first hour](/docs/quickstart) walks through them.
- You can set up another organisation only if you are a member or viewer in every organisation you belong to. To do it, go to `/onboarding`. It says, for example, "You are a member of Acme. Only its owners and admins add projects there. You can set up an organisation of your own here, or go to the Brief."
- If you are an owner or admin anywhere, onboarding opens on the project step. It gives you no way to create a second organisation.

## Sign-up modes

Sequential's hosted service has open sign-up, so the waitlist and invite modes do not apply to it.

An invitation that has not expired or been cancelled works in every mode, so invitations are the reliable way to add a colleague.

### What each mode shows

Sequential runs sign-up in one of three modes: open, waitlist or invite. The sign-up mode applies to the whole service. Your organisation has no setting for it.

| Mode | Who can create an account |
|---|---|
| Open | Anyone |
| Waitlist | People the Sequential team approved from the waitlist, and anyone with a pending invitation |
| Invite | Only people with a pending invitation |

On Create an account, a person sees:

| Mode | What a person sees on Create an account |
|---|---|
| Open | The sign-up form, with "You will set up your organisation next." |
| Waitlist | The title Join the waitlist, with "Sequential is in preview. We're letting teams in a few at a time." Then Work email, Name and a Join the waitlist button. The account form is under Already let in? Create your account |
| Invite | The title Sign-up is by invitation, with "Accounts here are made from an invitation. Ask a teammate to invite you, then open the link in the mail." There is no form. A link from an invitation shows the form. |

- In waitlist mode, a link with your address opens the account form at once: the approval email's link and an invitation link.
- In waitlist mode, the link at the bottom of the Sign in page reads Join the waitlist, not Create an account. It opens the same page. After a failed sign-in, the page also shows "No account yet? Join the waitlist".
- In waitlist mode, if you create an account with a password and an address that the Sequential team has not approved, Sequential puts you on the waitlist instead, with your address. It never keeps the password. The page says "You have not been let in yet, so we added you to the waitlist. We will mail {your address} when you are in."
- If Sequential cannot add you, the page says "You have not been let in yet, and the waitlist could not take you just now." and the reason, with a Join the waitlist link. After too many tries from one network, the reason is "Too many tries from here. Wait a few minutes, then try again."
- In invite mode, the waitlist page has the title Sign-up is by invitation and no form.
- In open mode, the waitlist page opens Create an account instead. If the link had your address in it, the form keeps it.
- If Sequential cannot check the sign-up mode, the page has the title Sign up, the line "Sequential could not tell which way to sign up is open right now." and Try again, and no form. It never shows the waitlist version by guess.
- In every mode, Sequential limits how many accounts are created each day: per network address, per email domain and in total. An invited address skips the first two. Over a limit, the page says which one. See [Limits](/docs/limits).

#### Messages on the sign-up page

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Sequential could not tell which way to sign up is open right now." | — | Sequential cannot check the sign-up mode. | — |
| "Too many accounts were created from this network today. Try again tomorrow." | — | Over the daily limit of new accounts per network address. | — |
| "Too many accounts were created for this email domain today. Try again tomorrow, or ask a teammate to invite you." | — | Over the daily limit of new accounts per email domain. | — |
| "Sign-up is busy right now. Try again later today." | — | Over the daily limit of new accounts in total. | — |
| "Sign-up is not available for a moment. Try again in a minute." | — | Sequential cannot check the limits. | — |

When Google sign-in is available, a refused Continue with Google, over a limit or when Sequential cannot check the limits, shows the same message on the Sign in page.

Join the waitlist:

This is only for a Sequential server that runs in waitlist mode. Sequential's hosted service has open sign-up: use Create an account.

1. On the Sequential website, click **Join the waitlist**.

   Result: In waitlist mode, **Create an account** also starts with the waitlist form.

2. Enter your **Work email**.

   Result: The other fields are optional. **Create an account** asks only for your **Name**; the waitlist page also asks the other optional fields.

3. Click **Join the waitlist**.

   Result: The page says "You are on the list. When you are let in, a mail to {your address} brings you back here to create your account."

The waitlist page has the same line as Create an account in waitlist mode: "Sequential is in preview. We're letting teams in a few at a time." It adds "Leave your address and we will mail you when you are in."

Under the form, Already let in? Create your account opens the account form. Have an account? Sign in opens the Sign in page.

The Sequential team approves waitlist entries by hand. The approval email has a Create your account button. It opens the sign-up page with your address filled in.

- After you join, a confirmation email, "You're on the Sequential waitlist", follows.
- When the team approves you, you get the email "You're in: create your Sequential account". From 11 October 2026, an account that you create from its link, with that address, needs no verify email. The link proves the address for 7 days.
- The optional fields are Name, Company, Your role, What you use today and Anything we should know.
- From 23 October 2026, Sequential deletes a waitlist entry once the person has an account, and at the latest 12 months after its last email to the person: the confirmation, or the email that lets the person in.
- If you join again with the same address, you keep your place. Sequential fills in only the details you left blank. It sends no second email.
- The form gives the same answer for every address. So it never shows whether an address is already on the list or already has an account.
- After approval, the sign-up page shows the subtitle "You're in. Create your account."
- Approval is not an invitation to someone else's organisation. After you create your account, you set up your own.
- Sequential lets you in because your address is approved. The `#m=` part of the Create your account link only proves the address, so that the account needs no verify email.
- If you lose the email, go to the sign-up page. Open Already let in? Create your account and fill in the form with the same address.
- Approval has no time limit.
- Sequential sends no email if the team declines a request.
- If one network sends too many waitlist submissions in a short time, it gets "Too many tries from here. Wait a few minutes, then try again."

## Limits

- There is no shareable invite link, and no joining by email domain, SSO or SCIM. You can invite at most 20 people at a time.
- You cannot change the 48-hour invitation expiry.
- An organisation can have at most 100 pending invitations and at most 100 members.
- You cannot change the email address on an account.
- There is no ownership-transfer step. You cannot change your own role.

## Next steps

- [Your first hour](/docs/quickstart): your first project after sign-up.
- [Roles and permissions](/docs/roles-and-permissions): what each role can do.
- [Organisations, projects and keys](/docs/organisations-and-projects): organisations and their projects.
- [Two-factor authentication and account security](/docs/two-factor-and-security): passwords, resets and two-factor codes.
- [Troubleshooting](/docs/troubleshooting): when something does not work.
