# Two-factor authentication and account security

> Use an authenticator app, require two-factor authentication in your organisation, sign out devices and reset your password for your Sequential account.

> **At a glance**
>
> - **Who can:** Each teammate turns on two-factor authentication (2FA) for their own account. Owners and admins can require it for every teammate.
> - **Before you start:** An authenticator app on a device that you keep with you, such as 1Password, Google Authenticator or Authy.
> - **Know this:** Lost your app and your backup codes? An admin cannot turn 2FA off. Write to support@usesequential.com from your account's address.
> - **Know this:** Sensitive actions can ask for a code: 2FA settings and, with 2FA on, exports, server keys, some project access tokens (`sq_pat_…`).

> **Key facts**
>
> - If your organisation requires 2FA, a teammate without it cannot open its projects or settings until they turn it on.
> - A password reset signs out every device and ends your claude.ai connections. From 23 October 2026, a password reset also revokes every project access token that you created, in every project. A password change keeps the tokens.
> - From 21 October 2026, a sign-in ends 7 days after you last used Sequential, or 30 days after you signed in, whichever comes first.

## Set up two-factor authentication

2FA asks for a 6-digit code from an authenticator app after your password. Sequential does not send two-factor codes by email or text message. No password on your account? See [Two-factor authentication without a password](#two-factor-authentication-without-a-password).

> **Important**
>
> Sequential shows the backup codes only once. Each code works one time.

1. Go to **Settings › Security**.

2. Under Two-factor, which shows Off before set-up, enter **Your password**.

3. Click **Turn on two-factor**.

4. At "Scan this with your authenticator app", scan the QR code, or type the setup key under it into the app.

5. At "Save your backup codes", click **Copy codes** or **Save as a file**. Keep the 10 codes somewhere safe, such as a password manager.

6. At "Enter the first code from the app", enter the current code in **6-digit code**.

7. Click **Turn on**.

Result: Two-factor authentication is now on.

New phone or new backup codes? See [New phone, new backup codes or turning 2FA off](#backup-codes-turning-2fa-off-and-refused-codes).

### New phone, new backup codes or turning 2FA off

When 2FA is on, the section shows three actions: New backup codes, Add to another app and Turn off…. If your account has a password, each asks for your current password. On an account with no password, they have no password field. They can also ask for a code: see [Enter a code for a sensitive action](#enter-a-code-for-a-sensitive-action).

- Add to another app, then Show the setup code, shows the QR code and the setup key again. A second app then shows the same codes as the first.
- New backup codes, then Make new codes, gives you a new set. The old codes stop working.
- Turn off…, then Turn it off, turns off 2FA. Sign-in then asks for your password only, and your backup codes stop working. From 20 October 2026, Sequential then sends the email "Two-factor authentication was turned off" to the email address of your account.

You can try 5 codes in 15 minutes. After 20 wrong codes in one day (UTC), the section says "Too many failed attempts today. Try again tomorrow, or write to support@usesequential.com."

Sequential can refuse a code with "That code is not right. Check the time on your phone, then try the next code." If this happens, make sure that your phone sets its clock automatically. Codes change every 30 seconds, so a wrong phone clock makes codes that do not match.

## Two-factor authentication without a password

From 20 October 2026, an account that you create with an emailed code has no password. An account that you create with Google, GitHub or Microsoft, when it is available, has no password too.

You set up 2FA in the same way, but Sequential does not ask for a password. In place of the password, Sequential checks that you signed in on this device in the last 15 minutes.

1. Go to **Settings › Security**.

2. Under Two-factor, click **Turn on two-factor**.

   Result: The Your password field does not show.

   **If you signed in on this device more than 15 minutes ago**

   The section says "Sign in again, then try again: this needs a sign-in from the last 15 minutes." Click **Sign in again**. Sequential signs you out on this device only. Sign in again, for example with a new emailed code, and Sequential takes you back to Security. From 11 November 2026, an account with no password reads instead: "Sign in again with an email code, then try again. A sign-in through a provider or single sign-on does not count here." Its button is **Sign in with an email code**. It signs you out and opens the sign-in page with your address filled in. The sign-in page then says: "To make this change, sign in with an email code: use "Email me a code". A sign-in through a provider or single sign-on does not count."

3. Scan the QR code, save your backup codes, and enter the code from your app, as in [Set up two-factor authentication](#set-up-two-factor-authentication).

### Add a password

On Security, the Password section says "You sign in with emailed codes, so this account has no password. Add one to sign in without waiting for a mail."

From 8 November 2026, the section says "This account has no password: add one to sign in without waiting for a mail." A row "Needs" says "Without two-factor: a sign-in on this device in the last 15 minutes. With two-factor on: a code from your authenticator, a backup code or a passkey in the last 15 minutes." The old text is behind "Read the full text ▾".

1. Enter a **New password** of at least 10 characters.

2. Click **Set password**.

   **If Sequential asks for a code or a recent sign-in**

   If 2FA is on, Sequential first asks for a code from your app or a backup code. Enter it and click **Continue**.

   If 2FA is off and you signed in on this device more than 15 minutes ago, the section says "Sign in again, then try again: this needs a sign-in from the last 15 minutes." From 11 November 2026, an account with no password reads "Sign in again with an email code, then try again. A sign-in through a provider or single sign-on does not count here.", with the button **Sign in with an email code**.

Result: The page says "Password set.", and Sequential sends the email "A password was added to your Sequential account". After that, the section is the usual Password section.

## Sign in with a code

After a correct password or emailed sign-in code, Sequential shows the "Two-factor code" page.

1. Enter the 6-digit code from your authenticator app.

   **If you do not have your phone**

   Click **Use a backup code** and enter one of your saved codes. Each code works one time. To switch back, click **Use the authenticator app**. If you lost your app and your backup codes too, see [I lost my phone and my backup codes. Can an admin help?](#i-lost-my-phone-and-my-backup-codes-can-an-admin-help)

2. Optional: turn on **Trust this device for 30 days** to skip the code here on later sign-ins. Do not do this on a shared or public device.

3. Click **Verify**.

   **If you do not enter the code within 10 minutes**

   You have 10 minutes to enter the code. After that, the page shows **Sign in again**. Click it and enter your password again. A code that you enter after the 10 minutes gets the answer "A sign-in waits 10 minutes for its code. This one has run out, or it began in another browser."

## Require two-factor authentication for your organisation

Every teammate can open replays and analytics about your customers. 2FA stops a sign-in with a leaked password. Owners and admins can require 2FA from every teammate.

Before you start, set up 2FA on your own account. Until you do, Require two-factor… is disabled.

1. In **Settings › Organisation**, find the Two-factor for everyone section.

2. Click **Require two-factor…**.

   Result: Sequential first checks who this affects. It does not turn on the requirement yet.

3. Read the check.

   Result: It lists teammates without 2FA, teammates who must sign in again with a code, and agent connections that stop. Each line shows only when it applies.

4. Click **Require two-factor**, or click **Not now** to stop.

5. If you have not entered a code in this sign-in, Sequential first asks for one from your app or a backup code. Enter it and click **Continue**.

Result: The confirmation says "<organisation> now requires two-factor."

After this, a teammate without 2FA cannot open the projects or settings of the organisation until they turn it on: no analytics, replays, AI or settings. They can still accept or decline an invitation, or leave the organisation. Sequential sends them from every page to Settings › Security.

From 8 November 2026, the Two-factor for everyone section shows the rule as rows, for every role. In these examples, the organisation is Acme. While the rule is off, "Now" says "Not required: each member chooses". "If it is required" says "Every member of Acme needs two-factor, and each session must have passed it." "Without two-factor" says "Kept out of Acme’s projects and settings until they set it up. They can still accept or decline an invitation, or leave, and an owner or admin can still make two-factor optional." "Agent connections" says "Requiring it ends those made by a member without two-factor, or approved without a two-factor code. They must be connected again; making two-factor optional later does not bring them back." "Project access tokens" says "Keep working: the rule does not apply to them". Under the rows, the line "Requiring it keeps anyone without two-factor out until they set it up." always shows.

From 8 November 2026, while the rule is on, "Now" says "Required" and "Who" says "Every member of Acme". "Each session" says "Must have passed two-factor. A session that has not is kept out until it does, for example by signing in again." "Without two-factor" says "Acme’s projects and settings stay closed until they turn it on. They can still accept or decline an invitation, or leave, and an owner or admin can still make two-factor optional." "Agent connections" says "One made by a member without two-factor, or approved without a two-factor code, stops working and must be connected again. Making two-factor optional does not bring it back." "Project access tokens" says the same as while the rule is off. In both states, the old sentence is behind "Read the full text ▾".

### Send a reminder

On Settings › Members, owners and admins see the teammates with no two-factor.

1. Click **Send a reminder by mail**, or **Send each a reminder by mail** for two or more teammates.

   Result: Sequential sends each of them an email.

### How the requirement works

Teammates without 2FA:

- A teammate without 2FA sees the notice "Two-factor is required" on Settings › Security. When they turn on 2FA, Sequential takes them back to the page that they came from.
- From 8 November 2026, the notice has a headline, one line and the next step. For one organisation, the line says, for example, "Acme’s projects and settings stay closed to you until it is on." For two or more, it names them all, for example "The projects and settings of Acme and Beta stay closed to you until it is on." The next step says, for example, "Turn it on below. Once it is on, you go back to where you were." The old text of the notice is behind "Read the full text ▾".
- From 8 November 2026, when a purchase needs 2FA, the notice "Two-factor is needed to buy" says "Nothing was charged: a purchase charges the card on file, so it needs two-factor on your account." The next step says "Turn it on below. You then go back to start the purchase again, and confirm it with a code from your app."
- The organisation requirement makes sure that every teammate has 2FA. The requirement checks each sign-in. A teammate must have 2FA set up, and this sign-in must have used a code or a trusted device.
- A sign-in from before Sequential checked each sign-in has no record of a code. Sequential signs that teammate out once. The sign-in page then says "Sign in again with your authenticator code: your organisation requires two-factor, and your last session had not passed it."
- If you turn off your own 2FA while the requirement is on, Sequential also sends you to Security. You must set up 2FA again before you can reach the rule.
- A claude.ai connection needs the same rule. A connection that its teammate made while they had no 2FA stops when the requirement is on. If a teammate turns off 2FA while the requirement is on, their connections stop too. See [Connect claude.ai](/docs/connect-claude-ai).

Who sees and changes it:

- The requirement applies to this organisation only. Other organisations keep their own setting.
- Make two-factor optional turns the requirement off, at once and with no check.
- On Settings › Members, owners and admins see "Two-factor on" or "No two-factor" for each teammate. See [Roles and permissions](/docs/roles-and-permissions).
- Members and viewers see whether the requirement is on, on Settings › Organisation, but they cannot change it.
- From 8 November 2026, members and viewers also see the rows of the rule under Two-factor for everyone.
- Sequential records each change to the requirement in the [Audit log](/docs/audit-log).
- Sequential support can also turn the requirement on or off. See [Changes by Sequential support](/docs/audit-log#changes-by-sequential-support).

In the check, each line shows up to 3 names, then "and N more".

#### Messages when you require two-factor

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Checking who it affects…" | After Require two-factor… | Sequential first checks who this affects. It does not turn on the requirement yet. | — |
| "… have no two-factor, so they cannot open <organisation> until each turns it on." | The check | These teammates have no 2FA. | — |
| "… must sign in again with a code before <organisation> opens for them." | The check | These teammates must sign in again with a code. | — |
| "N agent connections made by … stop working and must be connected again." | The check | These agent connections stop when the requirement is on. | — |
| "Nobody else is shut out: everyone already uses two-factor, on this session too." | The check | Nobody is affected. | — |
| "Sequential could not work out who the rule would shut out, so it cannot be turned on just now. Try again in a minute." | The check | The check failed. The requirement stays off. | — |
| "Turn on two-factor for your own account first." | Settings › Organisation | Your own account has no 2FA, so Require two-factor… is disabled. | Set up 2FA on your own account. |
| "<organisation> now requires two-factor." | Confirmation | The requirement is on. | — |
| "Two-factor is optional in <organisation> again." | Confirmation | Make two-factor optional turned the requirement off. | — |
| "Required for every member." | Settings › Organisation, for members and viewers | The requirement is on. | — |
| "Not required. Each member chooses." | Settings › Organisation, for members and viewers | The requirement is off. | — |
| "Sequential support made two-factor required for every member" | Audit log | Sequential support turned the requirement on. | — |
| "Sequential support made two-factor optional again" | Audit log | Sequential support turned the requirement off. | — |

#### Messages about reminders

| Message | Where | What it means | What to do |
|---|---|---|---|
| "<organisation> asks you to turn on two-factor authentication" | Email subject | The reminder email. It names the organisation and links to Settings › Security. It names no teammate. | — |
| "Sent 2 reminders to set up two-factor." | Confirmation (example) | Sequential sent the reminders. | — |
| "No reminder went out. 2 people had a reminder in the last 24 hours, so they were left out." | Confirmation (example) | A teammate gets at most one reminder from an organisation in 24 hours. | — |
| "Reminders go out at most three times an hour. Try again in N minutes." | Confirmation | An organisation can send reminders at most 3 times an hour. | — |
| "sent 2 two-factor reminders" | Audit log (example) | The [Audit log](/docs/audit-log) records only the number. | — |

## Enter a code for a sensitive action

These actions ask for a current code from your app or a backup code, unless you entered one in this sign-in in the last 15 minutes:

- With 2FA on: start a data export, create a server key, or create a project access token (`sq_pat_…`) with `exports:write`, `changes:read_sensitive` or organisation-wide changes.
- In your 2FA settings: New backup codes, Add to another app and Turn off….

A sign-in on a trusted device does not count. See [What each action asks for](#what-2fa-needs).

1. Enter the current 6-digit code from your app, or one of your backup codes, in **Code**.

2. Click **Continue**.

Result: Sequential then makes the change.

### What each action asks for

| Action | What Sequential asks for |
|---|---|
| Turn on 2FA | An authenticator app on a device that you keep with you. Your password, if your account has one. With no password: a sign-in on this device in the last 15 minutes (see [Two-factor authentication without a password](#two-factor-authentication-without-a-password)). |
| Your 2FA settings: New backup codes, Add to another app, Turn off… | A code, unless you entered one in this sign-in in the last 15 minutes. Your current password too, if your account has one. |
| Start a data export ([Export your data](/docs/export-your-data#start-an-export)), or create a server key for the [backend SDK](/docs/backend-sdk) | A code, unless you entered one in this sign-in in the last 15 minutes. Sequential asks only when your 2FA is on. |
| Create or adopt any project access token (`sq_pat_…`) | From 23 October 2026, every access token that you create or adopt needs a sign-in on this device, or a code, from the last hour. With 2FA off, a token with `changes:read_sensitive` or organisation-wide changes needs only that recent sign-in. If your organisation requires 2FA, that rule still applies first. |
| Create a token with `exports:write`, `changes:read_sensitive` or organisation-wide changes | With 2FA on: a code, unless you entered one in this sign-in in the last 15 minutes. |
| Require 2FA for your organisation | The owner or admin role, 2FA on your own account, and a sign-in with your code. See [Roles and permissions](/docs/roles-and-permissions). |
| Set a password, on an account with no password | With 2FA off: a sign-in on this device in the last 15 minutes. With 2FA on: a code from your app or a backup code. |

## See and sign out your devices

Sign out old devices in Settings › Security › Where you are signed in. It lists each device where you are signed in. Your current device has the label "This device".

> **Important**
>
> If you sign out a device that you trusted, its next sign-in still skips the 2FA code. If someone there could know your password, change the password too.

- To sign out one other device, click "Sign out" on its row.
- To sign out every device except this one, click "Sign out every other device", then confirm.

### How the device list works in detail

- At first the list shows 10 devices: this device, then the other devices in the order of their last use, newest first. If there are more, click Show more. If the next devices do not load, Sequential shows the reason under the list. The devices already shown stay.
- Each row shows the device, the IP address and the day that it signed in. Each other row also shows Active and the time of its last use. The order is by last use, so it can be different from the order of the sign-in days.
- The line above the list counts all your devices, also the devices that the list does not show yet, for example "3 sessions are signed in to your account." Sign out every other device signs out all of them.
- If the sign-in on a row has already ended, Sign out removes the row and Sequential says "That session has already ended."
- Sign out every other device first asks you to confirm, for example "Sign out 2 other devices? They’ll need to sign in again." Click Sign out to continue, or Cancel.
- On the current row, the button is Sign out here. It signs you out on this device and opens the sign-in page.
- This list shows where you are signed in to Sequential. It does not show the sessions of the people who use your app. For those, see [Sessions](/docs/sessions).

### How long a sign-in and a trusted device last

- From 21 October 2026, a sign-in ends 7 days after you last used Sequential, or 30 days after you signed in, whichever comes first. Sequential records your last use at most once an hour. Viewing a page without using it does not count as use.
- A password change or a two-factor change does not restart the 30 days. A new sign-in starts them again.
- When a sign-in ends, the sign-in page says why: "You were signed out after 7 days without use. Sign in to carry on." or "You were signed out after 30 days. Sign in to carry on."
- Sequential keeps your sign-in in a cookie that scripts on a page cannot read. From 16 October 2026, Sequential also removes the sign-in token from its answers to sign-in and session requests.
- A trusted device skips the 2FA code. Each sign-in on a trusted device renews the 30 days. A trusted device stops being trusted 30 days after its last use. The trust lasts up to 30 days after you turned it on, or after its last sign-in.
- If you remove someone from the organisation, their access to it ends. See [Roles and permissions](/docs/roles-and-permissions).

## Change or reset your password

If you forgot your password, reset it from the sign-in page. To change a password that you know, use Settings › Security.

### Reset your password

1. On the sign-in page, click **Forgot your password?**.

2. Enter your email.

3. Click **Send the link**.

4. Open the link in the email "Reset your Sequential password".

   Result: The link is valid for one hour.

5. Under Choose a new password, enter the new password in **New password** and again in **The same again**.

6. Click **Save the new password**.

Result: From 23 October 2026, if 2FA is off, Sequential signs you in on that device and opens the app. If 2FA is on, the sign-in page says "Password updated. Sign in with your new password." Sign in with the new password and enter your code.

### Change your password

1. Go to **Settings › Security › Password**.

2. Enter your **Current password**.

3. Enter a **New password** of at least 10 characters.

4. Click **Change password**.

Result: Sequential signs out every other device.

### After a change or a reset

| | Change | Reset |
|---|---|---|
| Your devices | Every other device is signed out | Every device is signed out |
| claude.ai connections that you made, in every project | End | End |
| Project access tokens (`sq_pat_…`) that you created, in every project | Keep working | Revoked (from 23 October 2026) |
| A sign-in that has your old password and waits for its two-factor code | Stopped (from 23 October 2026) | Stopped (from 23 October 2026) |

From 8 November 2026, above Current password, three rows say what a change does. "Other devices" says "Signed out. This one stays signed in." "Agents" says "Those that signed in through a browser must connect again". "Project access tokens" says "Keep working". The old line, "Changing it signs out every other device. This one stays signed in.", is behind "Read the full text ▾".

### How a reset and a change work in detail

If the reset link has expired or was used, the page says "This reset link cannot be used". Click Ask for a new link. After Send the link, the page always says "If <address> has an account, a link to choose a new password is on its way." This way, the page does not show if an account exists. The page then offers Send the link again after 30 seconds.

A reset signs out every device where you were signed in. From 23 October 2026, the link keeps the page that you were going to, for example the consent page of an agent connection. After the reset, and the sign-in if 2FA is on, Sequential opens that page.

A password change or reset also ends every claude.ai connection that you made, in every project. If Sequential cannot end them, it does not change your password. Try again. See [Connect claude.ai](/docs/connect-claude-ai).

From 23 October 2026, a password reset also revokes every project access token (`sq_pat_…`) that you created, in every project. The email after the reset says how many. Its button, Open Agents, opens Agents, where you make new tokens for each project. A token that a teammate created stays.

If Sequential cannot revoke the tokens, it does not reset your password. Try again. A password change keeps your tokens: after the change, the Password section lists the tokens that still work, with Revoke…, and an email tells you how many you have. The Password section is between Two-factor and Where you are signed in.

From 23 October 2026, a change or reset also stops a sign-in that waits for its two-factor code. If someone entered your old password before the change, Sequential refuses the code or backup code that they enter after it. Sign in again with the new password. If Sequential cannot check this, it also refuses the code.

From 11 October 2026, a completed reset also verifies your email address, if it was not verified yet. The reset link goes only to your account's own address and works once, so a completed reset proves that you read that email. Sign-in then does not ask you to verify your address. A reset that fails, or a link that expired or was used, changes nothing.

The reset link carries a secret in its address. From 11 October 2026, Sequential's own website does not record the page that the link opens. It also does not record a sign-in page that leads back to it. The page sends no referrer, so the next page and other websites do not get the link. Your browser does not keep it in its cache.

## Sign-in methods

Connect Google, GitHub or Microsoft to your account to sign in with it. Go to **Settings › Security › Sign-in methods**. Sequential shows this section only when Google, GitHub or Microsoft sign-in is available. The page says: "Connect a provider to sign in with it. The provider account can have a different email address from your Sequential account. Sequential sends a mail to your address each time a provider is connected." This is so from 11 November 2026. The provider must say that its address is verified. The address of your Sequential account does not change. A sign-in with Google or Microsoft connects only an account with your own address. GitHub connects only from this page.

1. Click **Connect GitHub**, **Connect Google** or **Connect Microsoft**. If two-factor authentication is on, Sequential can ask for your code first. If it is off, you must have signed in on this browser with your password or an email code in the last 5 minutes. Else the page says, for example: "To connect GitHub, sign in again with your password or an email code. Then connect GitHub in the next 5 minutes." Click **Sign in again**. Sequential signs you out. After you sign in, it opens Sign-in methods again.
2. Sign in to the provider. It sends you back to Sequential.

The page then says, for example: "GitHub is connected. You can sign in with it." The row shows Connected and the date. A provider that is not connected shows Not connected.

From 11 November 2026, Sequential then sends an email to the address of your Sequential account, for example "A GitHub account was connected to your Sequential account". See [Security emails](#security-emails).

### Disconnect a provider

1. Click **Disconnect…**.
2. Sequential asks: "Disconnect GitHub? You cannot sign in with GitHub after that." Click **Disconnect GitHub**, or **Keep it**. If two-factor authentication is on, Sequential can ask for your code first.

The page then says, for example: "GitHub is disconnected. You cannot sign in with it now."

If a provider is your only way to sign in, the row has no Disconnect…. It says, for example: "GitHub is your only way to sign in. To disconnect it, set a password first." See [Add a password](#add-a-password).

### Messages

| Message | What to do |
|---|---|
| "GitHub was not connected. That GitHub account is already connected to another Sequential account, or you have another GitHub account connected." | Disconnect the other connection first. |
| "GitHub was not connected. GitHub did not confirm a verified email address for that account." | Verify the address at the provider, then try again. |
| "GitHub was not connected. You cancelled at GitHub." | Try again, and allow the access at the provider. |
| "GitHub was not connected. Enter your two-factor code, then connect it again." | Enter your code, then click Connect again. |
| "GitHub was not connected. Try again." | Try again. |
| "This is your last way to sign in. Set a password first, then disconnect it." | Set a password, then disconnect. |

The messages name the provider: GitHub, Google or Microsoft.

## Security emails

Sequential sends these emails about your account. Look up an email by its subject.

### Each security email and what to do

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Two-factor authentication was turned on" | Email | From 20 October 2026, Sequential sends it when you turn 2FA on. The email has no link. | If you did not make the change, reset your password, as the email tells you. |
| "Two-factor authentication was turned off" | Email | From 20 October 2026, Sequential sends it when you turn 2FA off. The email has no link. | If you did not make the change, reset your password, as the email tells you. |
| "New sign-in to your Sequential account" | Email | From 23 October 2026, a sign-in from a browser that has not signed in to your account before is complete. | If it was not you, reset your password, then on Security sign out of every other device. |
| "Your password was used on a new device" | Email | Someone entered your password in a browser that has not signed in to your account before, and did not finish two-factor authentication within 10 minutes. Your second factor stopped them. | If it was not you, change your password. |
| "A password was added to your Sequential account" | Email | A password was set on Security. See [Add a password](#add-a-password). | — |
| "A GitHub account was connected to your Sequential account" | Email | From 11 November 2026, Sequential sends it each time a provider is connected to your account: when someone clicks Connect, and when a Google or Microsoft sign-in connects an account with your own address. For GitHub, the email names the GitHub login. Single sign-on and a new sign-up send no such email. | If this was not you, remove it in Settings › Security › Sign-in methods and change your password. Then contact support. |
| "Reset your Sequential password" | Email | The link to choose a new password. The link is valid for one hour. | See [Reset your password](#reset-your-password). |
| "<organisation> asks you to turn on two-factor authentication" | Email | A reminder from an owner or admin of your organisation to turn on 2FA. It links to Settings › Security. | See [Set up two-factor authentication](#set-up-two-factor-authentication). |

### How security emails work in detail

From 20 October 2026, Sequential sends you an email when you turn 2FA on or off. Set-up ends with Turn on. From 20 October 2026, Sequential then sends the email "Two-factor authentication was turned on" to the email address of your account. Sequential sends the turned-on or turned-off email only when your 2FA really changes. A sign-in with a code, a wrong code, or a turn-off when 2FA is already off sends no email. If Sequential cannot send the email, the change to your 2FA still happens.

From 23 October 2026, when a sign-in from a browser that has not signed in to your account before is complete, Sequential emails your account's own address: "New sign-in to your Sequential account". It says when (UTC), the browser and the operating system, and an approximate country. If it was not you, reset your password, then on Security sign out of every other device.

If someone enters your password in such a browser and does not finish two-factor authentication within 10 minutes, Sequential emails "Your password was used on a new device". Your second factor stopped them. If it was not you, change your password.

- Sequential sends at most 3 of these emails an hour for an account: "New sign-in to your Sequential account" and "Your password was used on a new device".
- Until 23 November 2026, Sequential records an account's first browser without an email. It also records the first browser of an account that is less than 10 minutes old without an email.
- Sequential knows a browser by a random id in the cookie `__Host-sq_device`, and keeps only a hash of it with your account. See the [Privacy Policy](/privacy).

## When sign-in says "Too many tries"

Sequential limits how often a network address can try each action. If you go over a limit, the sign-in pages show "Too many tries from this network. Wait a minute, then try again." The limits count per network address, not per person, so teammates on one office network share them.

Other limits count per email address, per sign-in or per account. See [Each sign-in limit in detail](#each-limit).

### Each sign-in limit in detail

The limits are there to slow down guessing.

| Action | Allowed from one address |
|---|---|
| Sign in with email and password | 10 a minute |
| Enter a 2FA code, at sign-in or during set-up | 10 a minute |
| Enter a backup code | 5 a minute |
| Request a password reset | 5 a minute |
| Continue with Google, Continue with GitHub or Continue with Microsoft (when it is available), change your password, start 2FA set-up, turn off 2FA, make new backup codes | 3 every 10 seconds |

Two more limits apply to 2FA codes, per account:

- After five wrong codes in one sign-in, the next try ends the sign-in with "Too many wrong codes for this sign-in, so it was closed." Start again with your password.
- Ten wrong codes in a row on your account, across sign-ins, lock code entry for 15 minutes. The message says "Too many wrong codes. This account is locked for 15 minutes, then you can try again." A correct code resets the count.

Too many wrong passwords for one address: from 23 October 2026, after 10 wrong passwords for one email address within 15 minutes, Sequential pauses password sign-in for that address for 15 minutes, from every network address. The page says "Too many wrong passwords for this address. Try again in 15 minutes, or sign in with an emailed code."

You can still sign in with an emailed code. The pause ends by itself. Sequential counts wrong passwords for every address, also for an address with no account, so the answer does not show whether an account exists.

## FAQ

### I lost my phone and my backup codes. Can an admin help?

No. If you lose your authenticator app and your backup codes, there is no self-service way to recover your account. Security says "Lost your phone and your backup codes? Sequential cannot turn two-factor off for you from here, and an admin cannot either: write to support@usesequential.com from this address." A device that is still signed in keeps working. But on it, New backup codes asks for a code from your app or a backup code, unless you entered one in that sign-in in the last 15 minutes.

### Which sign-ins ask for the two-factor code?

A sign-in with a password or with an emailed sign-in code. When Google, GitHub or Microsoft sign-in is available, signing in with Continue with Google, Continue with GitHub or Continue with Microsoft asks for the code too, the same as signing in with a password. A trusted device skips it. Two-factor codes come from authenticator apps only: an emailed sign-in code takes the place of a password, not of a two-factor code.

### Why does Sequential ask me to sign in again?

- From 21 October 2026, a sign-in ends 7 days after you last used Sequential, or 30 days after you signed in, whichever comes first. See [How long a sign-in and a trusted device last](#how-long-a-sign-in-lasts).
- If your organisation requires 2FA, Sequential signs you out once if your sign-in is from before Sequential checked each sign-in. See [How the requirement works](#more-about-the-requirement).
- When the 10 minutes for a two-factor code are over, the page shows Sign in again. See [Sign in with a code](#sign-in-with-a-code).
- From 23 October 2026, every project access token (`sq_pat_…`) that you create or adopt needs a sign-in on this device, or a code, from the last hour. See [What each action asks for](#what-2fa-needs).
- On an account with no password, when 2FA is on, New backup codes, Add to another app and Turn off… have no password field. Like for every account, they ask for a code from your app or a backup code if you have not entered one in this sign-in in the last 15 minutes. Turn off… moves this device to a new sign-in. So after you turn 2FA off, turning it back on asks you to sign in again first.

### Does the audit log show changes to my account?

Not reliably. Sign-ins do not appear in an organisation's [Audit log](/docs/audit-log).

Changes to your own account that appear in the [Audit log](/docs/audit-log) only some of the time include a new password, turning 2FA on or off, and signing out devices. Do not use the log to track them.

### How do I change my name, email or theme?

Settings › Your profile shows your Name and your Email. Edit the name and click Save name. You can also open Security from Settings › Your profile › Signing out. The email has a Verified or Not verified badge. You cannot change the email: the line under it says "Your email cannot be changed here: Sequential does not support moving an account to another address."

Under Theme and language, choose Follow the system, Light or Dark. Follow the system follows the appearance setting of your device. It is the default. Sequential remembers the choice on this browser only, so set it again in another browser.

From 8 November 2026, the Name field says "Your name, as your team sees it". The line under it says "At most 100 characters." The longer old text is behind "Read the full text ▾".

From 8 November 2026, under Theme and language, one line says, for example, "Numbers and dates follow your browser’s language, British English (en-GB)." Rows under it show an example of each format. With British English, "A date" shows, for example, 8 Nov 2026, 14:05. "A number" shows 1,203,400, and "A share" shows 3.4%. "To change them" says "Change the language in your browser’s settings, then reload". "Sequential’s own words" says "English". The old paragraph is behind "Read the full text ▾".

## Limits

- You can change only your name and password. You cannot change your email, delete your account or upload a picture.
- An admin cannot reset another teammate's 2FA or password, and cannot see or sign out another teammate's devices. Only the teammate can see and sign out their own devices.
- You cannot list or remove trusted devices.

## Next steps

- [Roles and permissions](/docs/roles-and-permissions): what each role can do.
- [Audit log](/docs/audit-log): what the log records.
- [Sign-up and invitations](/docs/sign-up-and-invitations): invite your team.
- [Organisations, projects and keys](/docs/organisations-and-projects): how they fit together.
- [Troubleshooting](/docs/troubleshooting): fix common problems.
