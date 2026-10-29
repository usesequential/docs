# Two-factor authentication and account security

> Use an authenticator app, require two-factor authentication in your organisation, sign out devices and reset your password for your Sequential account.

> **In short**
>
> - Two-factor authentication (2FA) asks for a 6-digit code from an authenticator app after your password.
> - Owners and admins can require 2FA for every member of the organisation.
> - When Google sign-in is available, signing in with **Continue with Google** asks for the code too, the same as signing in with a password. A trusted device skips it.
> - If you lose your authenticator app and your backup codes, there is no self-service way to recover your account. Write to support@usesequential.com.
> - From 20 October 2026, Sequential sends you an email when you turn 2FA on or off.
> - Turning off 2FA or regenerating backup codes can ask for a current code from your app or a backup code. When your 2FA is on, starting a data export, creating an access token with `exports:write`, `changes:read_sensitive` or organisation-wide changes, and creating a server key can ask for this code too. From 23 October 2026, every access token that you create or adopt needs a sign-in on this device, or a code, from the last hour. With 2FA off, a token with `changes:read_sensitive` or organisation-wide changes needs only that recent sign-in. If your organisation requires 2FA, that rule still applies first.
> - Sign out old devices in **Settings** › **Security** › **Where you are signed in**.

## What it is for

Every member of your organisation can open replays and analytics about your customers. 2FA stops a sign-in with a leaked password. The organisation requirement makes sure that every member has 2FA.

## Set up two-factor authentication

Each person turns on 2FA for their own account. You need an authenticator app on a device that you keep with you, such as 1Password, Google Authenticator or Authy.

1. Open **Settings** › **Security**.
2. Under **Two-factor**, enter **Your password**. Click **Turn on two-factor**.
3. At **Scan this with your authenticator app**, scan the QR code with your authenticator app.
4. At **Save your backup codes**, click **Copy codes** or **Save as a file**. Keep the ten codes somewhere safe, such as a password manager.
5. At **Enter the first code from the app**, type the current code into **6-digit code**. Click **Turn on**. Two-factor authentication is now on.

Sequential shows the backup codes only once. Each code works one time.

From 20 October 2026, Sequential then sends the email "Two-factor authentication was turned on" to the email address of your account.

## Two-factor authentication without a password

From 20 October 2026, an account that you create with an emailed code has no password. You set up 2FA in the same way, but Sequential does not ask for a password:

1. Open **Settings** › **Security**.
2. Under **Two-factor**, click **Turn on two-factor**. The **Your password** field does not show.
3. Scan the QR code, save your backup codes, and enter the code from your app, as above.

In place of the password, Sequential checks that you signed in on this device in the last 15 minutes. If your sign-in is older, the section says "Sign in again, then try again: this needs a sign-in from the last 15 minutes." Click **Sign in again**. Sequential signs you out on this device only. Sign in again, for example with a new emailed code, and Sequential takes you back to **Security**.

When 2FA is on, **New backup codes**, **Add to another app** and **Turn off…** have no password field. Like for every account, they ask for a code from your app or a backup code if this sign-in has not passed one in the last 15 minutes. **Turn off…** moves this device to a new session. So after you turn 2FA off, turning it back on asks you to sign in again first.

### Add a password

On **Security**, the **Password** section says "You sign in with emailed codes, so this account has no password. Add one to sign in without waiting for a mail."

1. Enter a **New password** of at least 10 characters.
2. Click **Set password**. If 2FA is on, Sequential first asks for a code from your app or a backup code. Enter it and click **Continue**.

If 2FA is off and you signed in on this device more than 15 minutes ago, the section says "Sign in again, then try again: this needs a sign-in from the last 15 minutes." When the password is set, the page says "Password set.", and Sequential sends the email "A password was added to your Sequential account". After that, the section is the usual **Password** section.

## Sign in with a code

After a correct password or emailed sign-in code, Sequential shows **Two-factor code**.

1. Type the 6-digit code from your authenticator app.
2. Click **Verify**.

You have 10 minutes to enter the code. After that, the page shows **Sign in again**. Click it and enter your password again.

If you do not have your phone, click **Use a backup code** and enter one of your saved codes. To skip the code on this device on later sign-ins, turn on **Trust this device for 30 days**. Do not do this on a shared or public device.

## Require two-factor authentication for your organisation

Owners and admins can require 2FA from every member of the organisation.

1. Set up 2FA on your own account. Until you do, **Require two-factor…** is disabled, and the section says "Turn on two-factor for your own account first."
2. Open **Settings** › **Organisation**. The rule is in the **Two-factor for everyone** section.
3. Click **Require two-factor…**. Sequential first checks who this affects ("Checking who it affects…"). It does not turn on the requirement yet.
4. Read the check. Each line shows only when it applies:
   - "… have no two-factor, so they cannot open <organisation> until each turns it on."
   - "… must sign in again with a code before <organisation> opens for them."
   - "N agent connections made by … stop working and must be connected again."

   Each line shows up to 3 names, then "and N more". If nobody is affected, it says "Nobody else is shut out: everyone already uses two-factor, on this session too."
5. Click **Require two-factor**, or click **Not now**. If this sign-in has not passed a code, Sequential first asks for a code from your app or a backup code. Enter it and click **Continue**.

If the check fails, Sequential says "Sequential could not work out who the rule would shut out, so it cannot be turned on just now. Try again in a minute." The requirement stays off.

After this, a member without 2FA cannot use anything in the organisation: no analytics, replays, AI or settings. Sequential sends them from every page to **Settings** › **Security**.

A sign-in from before Sequential checked each sign-in has no record of a code. Sequential signs that member out once. The sign-in page then says "Sign in again with your authenticator code: your organisation requires two-factor, and your last session had not passed it."

### Send a reminder

On **Settings** › **Members**, owners and admins see the members with no two-factor. **Send a reminder by mail** (or **Send each a reminder by mail**, for two or more members) sends each of them an email. The subject is "<organisation> asks you to turn on two-factor authentication". The email names the organisation and links to **Settings** › **Security**. It names no person.

- A member gets at most one reminder from an organisation in 24 hours. The confirmation says, for example, "Sent 2 reminders to set up two-factor.", or "No reminder went out. 2 people had a reminder in the last 24 hours, so they were left out."
- An organisation can send reminders at most 3 times an hour. Then it says "Reminders go out at most three times an hour. Try again in N minutes."
- The [Audit log](/docs/audit-log) shows, for example, "sent 2 two-factor reminders". It records only the number.

## See and sign out your devices

**Settings** › **Security** › **Where you are signed in** lists each device where you are signed in. **This device** marks the device you are using. At first the list shows 10 devices: this device, then the other devices in the order of their last use, newest first. If there are more, click **Show more**.

- **Sign out** signs out one other device. If that session has already ended, the row goes and Sequential says "That session has already ended."
- **Sign out every other device** signs out every device except this one. First it asks you to confirm, for example "Sign out 2 other devices? They’ll need to sign in again." Click **Sign out** to continue, or **Cancel**.

If you revoke a device that you trusted, its next sign-in still skips the 2FA code. If someone there could know your password, change the password too.

## Change or reset your password

1. Open **Settings** › **Security** › **Password**. The **Password** section is between **Two-factor** and **Where you are signed in**.
2. Enter your **Current password**.
3. Enter a **New password** of at least 10 characters.
4. Click **Change password**. Sequential signs out every other device.

If you forgot your password, click **Forgot your password?** on the sign-in page. Sequential sends you a link that is valid for one hour. From 23 October 2026, the link keeps the page that you were going to, for example the consent page of an agent connection. After the reset, and the sign-in if 2FA is on, Sequential opens that page. A reset signs out every device where you were signed in.

A password change or reset also ends every claude.ai connection that you made, in every project. If Sequential cannot end them, it does not change your password. Try again. See [Connect claude.ai](/docs/connect-claude-ai).

From 23 October 2026, a change or reset also stops a sign-in that waits for its two-factor code. If someone entered your old password before the change, Sequential refuses the code or backup code that they enter after it. Sign in again with the new password. If Sequential cannot check this, it also refuses the code.

From 23 October 2026, a password reset also revokes every access token that you created, in every project. The email after the reset says how many. Its button, **Open Agents**, opens **Agents**, where you make new tokens for each project. A token that a teammate created stays. If Sequential cannot revoke them, it does not reset your password. Try again. A password change keeps your access tokens: after the change, the **Password** section lists the tokens that still work, with **Revoke…**, and an email tells you how many you have.

### Emails about a new browser

From 23 October 2026, when a sign-in from a browser that has not signed in to your account before is complete, Sequential emails your account's own address: "New sign-in to your Sequential account". It says when (UTC), the browser and the operating system, and an approximate country. If it was not you, reset your password, then on **Security** sign out of every other device.

If someone enters your password in such a browser and does not finish two-factor authentication within 10 minutes, Sequential emails "Your password was used on a new device". Your second factor stopped them. If it was not you, change your password.

- Sequential sends at most 3 of these emails an hour for an account.
- Until 23 November 2026, Sequential records an account's first browser without an email. It also records the first browser of an account that is less than 10 minutes old without an email.
- Sequential knows a browser by a random id in the cookie `__Host-sq_device`, and keeps only a hash of it with your account. See the [Privacy Policy](/privacy).

## When sign-in says "Too many tries"

Sequential limits how often a network address can try each action. If you go over a limit, the sign-in pages show "Too many tries from this network. Wait a minute, then try again." The limits count per network address, not per person, so members on one office network share them.

**Too many wrong passwords for one address.** From 23 October 2026, after 10 wrong passwords for one email address within 15 minutes, Sequential pauses password sign-in for that address for 15 minutes, from every network address. The page says "Too many wrong passwords for this address. Try again in 15 minutes, or sign in with an emailed code." You can still sign in with an emailed code. The pause ends by itself. Sequential counts wrong passwords for every address, also for an address with no account, so the answer does not show whether an account exists.

## Limits

- **No recovery without your codes.** If you lose your authenticator app and your backup codes, there is no self-service way to recover your account. A device that is still signed in keeps working. But on it, **New backup codes** asks for a code from your app or a backup code, unless that sign-in passed one in the last 15 minutes. **Security** says "Lost your phone and your backup codes? Sequential cannot turn two-factor off for you from here, and an admin cannot either: write to support@usesequential.com from this address." An admin cannot reset another member's 2FA or password.
- **The requirement checks each sign-in.** A member must have 2FA set up, and this sign-in must have passed a code or a trusted device.
- **Accounts with no password.** An account that you create with an emailed code, or with Google when Google sign-in is available, has no password. It sets up 2FA with a recent sign-in in place of the password, and it can add a password on **Security**. See [Two-factor authentication without a password](#two-factor-authentication-without-a-password).
- **Ten wrong 2FA codes in a row lock code entry for 15 minutes.**
- **You cannot list or remove trusted devices.**
- **Two-factor codes come from authenticator apps only.** Sequential does not send two-factor codes by email or text message. An emailed sign-in code takes the place of a password, not of a two-factor code.
- **You can change only your name and password.** You cannot change your email, delete your account or upload a picture.
- **The audit log does not reliably track your account.** Sign-ins do not appear in an organisation's [Audit log](/docs/audit-log). Other changes to your own account appear there only some of the time.
- **An admin cannot sign out a member's devices.** Only the member can see and sign out their own devices.

### What 2FA needs

- An authenticator app on a device that you keep with you.
- A password on your account. Setting up, regenerating and disabling 2FA all ask for it.
- To regenerate backup codes or disable 2FA: a current code from your app or a backup code, unless this sign-in passed one in the last 15 minutes.
- To start a data export, to create an access token with `exports:write`, `changes:read_sensitive` or organisation-wide changes, or to create a server key for the [backend SDK](/docs/backend-sdk): a current code from your app or a backup code, unless this sign-in passed one in the last 15 minutes. Sequential asks only when your 2FA is on. A sign-in on a trusted device does not count. The page then shows a **Code** field and **Continue**. See [Export your data](/docs/export-your-data#start-an-export).
- For the organisation requirement: the Owner or Admin role, 2FA on your own account, and a sign-in with your code. See [Roles and permissions](/docs/roles-and-permissions).

### More about set-up and sign-in

- You can also open **Security** from **Settings** › **Your profile** › **Signing out**. Before set-up, the **Two-factor** section shows **Off**.
- If you cannot scan the QR code, type the setup key under it into the app.
- After **Use a backup code**, **Use the authenticator app** switches back.
- When the 10 minutes are over, a code that you enter gets the answer "A sign-in waits 10 minutes for its code. This one has run out, or it began in another browser." The page then shows **Sign in again**.
- If you sign a trusted device out later, the trust stays.
- Sequential sends the email "Two-factor authentication was turned on" or "Two-factor authentication was turned off" only when your 2FA really changes. A sign-in with a code, a wrong code, or a turn-off when 2FA is already off sends no email. The email has no link. If you did not make the change, it tells you to reset your password. If Sequential cannot send the email, the change to your 2FA still happens.

### Backup codes, turning 2FA off and refused codes

When 2FA is on, the section shows three actions: **New backup codes**, **Add to another app** and **Turn off…**. Each asks for your current password.

- **New backup codes**, then **Make new codes**, gives you a new set. The old codes stop working.
- **Add to another app**, then **Show the setup code**, shows the QR code and the setup key again. A second app then shows the same codes as the first.
- **Turn off…**, then **Turn it off**, turns off 2FA. Sign-in then asks for your password only, and your backup codes stop working. From 20 October 2026, Sequential then sends the email "Two-factor authentication was turned off" to the email address of your account.

These actions also ask for a code if this sign-in has not passed a code from your app or a backup code in the last 15 minutes. A sign-in on a trusted device has not passed one.

1. Type the current 6-digit code from your app, or one of your backup codes, into **Code**.
2. Click **Continue**. Sequential then makes the change.

You can try 5 codes in 15 minutes. After 20 wrong codes in one day (UTC), the section says "Too many failed attempts today. Try again tomorrow, or write to support@usesequential.com."

Sequential can refuse a code with "That code is not right. Check the time on your phone, then try the next code." If this happens, make sure that your phone sets its clock automatically. Codes change every 30 seconds, so a wrong phone clock makes codes that do not match.

### How trusted devices work

Each sign-in on a trusted device renews the 30 days. Sequential cannot list or remove trusted devices. A trusted device stops being trusted 30 days after its last use.

### More about the requirement

- When you turn it on, the confirmation says "<organisation> now requires two-factor."
- A member without 2FA sees the notice **Two-factor is required** on **Settings** › **Security**. When they turn on 2FA, Sequential takes them back to the page that they came from.
- The requirement applies to this organisation only. Other organisations keep their own setting.
- A claude.ai connection needs the same rule. A connection that its person made while they had no 2FA stops when the requirement is on. If a person turns off 2FA while the requirement is on, their connections stop too. See [Connect claude.ai](/docs/connect-claude-ai).
- **Make two-factor optional** turns the requirement off, at once and with no check. The confirmation says "Two-factor is optional in <organisation> again."
- On **Settings** › **Members**, owners and admins see **Two-factor on** or **No two-factor** for each member. See [Roles and permissions](/docs/roles-and-permissions).
- Members and viewers see only whether the requirement is on. **Settings** › **Organisation** says "Required for every member." or "Not required. Each member chooses."
- If you disable your own 2FA while the requirement is on, Sequential also sends you to **Security**. You must set up 2FA again before you can reach the rule.
- Members with no password, from an emailed code or, when Google sign-in is available, from Google, set up 2FA without a password step. See [Two-factor authentication without a password](#two-factor-authentication-without-a-password).
- Sequential records each change to the requirement in the [Audit log](/docs/audit-log).
- Sequential support can also turn the requirement on or off. The audit log then shows "Sequential support made two-factor required for every member" or "Sequential support made two-factor optional again". See [Changes by Sequential support](/docs/audit-log#changes-by-sequential-support).

### The device list

- Each row shows the device, the IP address and the day that it signed in. Each other row also shows **Active** and the time of its last use. The order is by last use, so it can be different from the order of the sign-in days.
- The line above the list counts all your devices, also the devices that the list does not show yet, for example "3 sessions are signed in to your account." **Sign out every other device** signs out all of them.
- If the next devices do not load, Sequential shows the reason under the list. The devices already shown stay.
- This list shows where you are signed in to Sequential. It does not show the sessions of your own users. For those, see [Sessions](/docs/sessions).
- On the current row, the button is **Sign out here**. It signs you out on this device and opens the sign-in page.
- If you revoke a device, **Trust this device for 30 days** stays in effect there. If you turned it on, that device's next sign-in skips the 2FA code.
- To change the password, use **Settings** › **Security** › **Password**.

### How long a sign-in lasts

- From 21 October 2026, a sign-in ends 7 days after you last used Sequential, or 30 days after you signed in, whichever comes first. Sequential records your last use at most once an hour. Viewing a page without using it does not count as use.
- A password change or a two-factor change does not restart the 30 days. A new sign-in starts them again.
- When a sign-in ends, the sign-in page says why: "You were signed out after 7 days without use. Sign in to carry on." or "You were signed out after 30 days. Sign in to carry on."
- Sequential keeps your sign-in in a cookie that scripts on a page cannot read. From 16 October 2026, Sequential also removes the sign-in token from its answers to sign-in and session requests.
- If you revoke a device that you trusted, it still skips the code. The trust lasts up to 30 days after you turned it on, or after its last sign-in.
- You see only your own devices. An admin cannot see or sign out another member's devices.
- If you remove someone from the organisation, their access to it ends. See [Roles and permissions](/docs/roles-and-permissions).

### Reset steps and the reset message

1. On the sign-in page, click **Forgot your password?**.
2. Enter your email.
3. Click **Send the link**.
4. Open the email "Reset your Sequential password". The link is valid for one hour. If it has expired or was used, the page says "This reset link cannot be used". Click **Ask for a new link**.
5. Under **Choose a new password**, enter the new password in **New password** and again in **The same again**. Click **Save the new password**.
6. From 23 October 2026, if 2FA is off, Sequential signs you in on that device and opens the app. If 2FA is on, the sign-in page says "Password updated. Sign in with your new password." Sign in with the new password and enter your code.

From 11 October 2026, a completed reset also verifies your email address, if it was not verified yet. The reset link goes only to your account's own address and works once, so a completed reset proves that you read that email. Sign-in then does not ask you to verify your address. A reset that fails, or a link that expired or was used, changes nothing.

After **Send the link**, the page always says "If <address> has an account, a link to choose a new password is on its way." This way, the page does not show if an account exists. The page then offers **Send the link again** after 30 seconds.

The reset link carries a secret in its address. From 11 October 2026, Sequential's own website does not record the page that the link opens. It also does not record a sign-in page that leads back to it. The page sends no referrer, so the next page and other websites do not get the link. Your browser does not keep it in its cache.

### Each limit

The limits are there to slow down guessing.

| Action | Allowed from one address |
|---|---|
| Sign in with email and password | 10 a minute |
| Enter a 2FA code, at sign-in or during set-up | 10 a minute |
| Enter a backup code | 5 a minute |
| Request a password reset | 5 a minute |
| **Continue with Google** (when Google sign-in is available), change your password, start 2FA set-up, disable 2FA, regenerate backup codes | 3 every 10 seconds |

Two more limits apply to 2FA codes, per account:

- After five wrong codes in one sign-in, the next try ends the sign-in with "Too many wrong codes for this sign-in, so it was closed." Start again with your password.
- Ten wrong codes in a row on your account, across sign-ins, lock code entry for 15 minutes. The message says "Too many wrong codes. This account is locked for 15 minutes, then you can try again." A correct code resets the count.

### Profile and appearance

**Settings** › **Your profile** shows your **Name** and your **Email**. You can edit the name and click **Save name**. The email has a **Verified** or **Not verified** badge. You cannot change the email. The line under it says "Your email cannot be changed here: Sequential does not support moving an account to another address."

Under **Theme and language**, select **Follow the system**, **Light** or **Dark**. **Follow the system** follows the appearance setting of your device. It is the default. Sequential remembers the choice on this browser only, so set it again in another browser.

### Account events in the audit log

Changes to your own account that appear in the [Audit log](/docs/audit-log) only some of the time include a new password, turning 2FA on or off, and signing out devices. Do not use the log to track them.

## Related

- [Roles and permissions](/docs/roles-and-permissions)
- [Audit log](/docs/audit-log)
- [Sign-up and invitations](/docs/sign-up-and-invitations)
- [Organisations, projects and keys](/docs/organisations-and-projects)
- [Troubleshooting](/docs/troubleshooting)
