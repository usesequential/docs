# Single sign-on (SAML and OIDC)

> Let the people of your organisation sign in to Sequential through your identity provider, such as Okta, Microsoft Entra ID or Google Workspace, with SAML 2.0 or OIDC. With provisioning (SCIM), your identity provider also adds and removes people.

> **At a glance**
>
> - **Who can:** Owners and admins set up single sign-on. After that, every person with an address at a verified domain can sign in with it.
> - **Before you start:** Admin access to your identity provider. Access to the DNS of each domain of your work addresses. Two-factor on your Sequential account, if your organisation requires it.
> - **Key:** Single sign-on and provisioning (SCIM) are included in every plan, including Free. They are not add-ons.
> - **Know this:** The password stays. A person can still sign in with a password, also when single sign-on is set up.
> - **Know this:** Single sign-on works only for the domains that you verify with a DNS TXT record.

> **Key facts**
>
> - One single sign-on connection for each organisation: SAML 2.0 or OIDC.
> - A person at a verified domain who is not a member yet joins at their first sign-in, as Member or Viewer. Never as an admin or an owner.
> - If your organisation requires two-factor, a sign-in through your single sign-on counts for it.
> - Removing single sign-on signs out everyone who signed in with it.
> - With provisioning (SCIM), Okta or Microsoft Entra ID adds, changes and removes the people of your organisation.

## Set up single sign-on

You do the set-up in Sequential and in your identity provider at the same time. Each change asks you to confirm that it is you: enter your two-factor code, or sign in again.

1. Go to **Settings › Single sign-on**.

   Result: The page says: "People with an address at your verified domains sign in through your identity provider, with SAML or OIDC. Single sign-on is included in every plan."

2. Under **1. Choose the type**, choose **SAML 2.0** or **OIDC**. Under **Identity provider**, choose Okta, Microsoft Entra ID, Google Workspace or Other.

   Result: A hint tells you what to make in your identity provider. For Google Workspace, it is a custom SAML app.

3. Under **2. Copy our values**, click **Get our values**.

   Result: For SAML, you get the ACS URL, the SP entity ID and the SP metadata URL. For OIDC, you get the Redirect URI. Both get a Start URL. Sequential keeps these values for 24 hours.

4. In your identity provider, make the app for Sequential with these values.

   **If you use Microsoft Entra ID with SAML**

   In the Microsoft Entra admin center, go to **Enterprise apps** and click **New application**, then **Create your own application**. Enter a name, keep **Integrate any other application you don't find in the gallery (Non-gallery)**, and click **Create**. In the app, go to **Single sign-on** and choose **SAML**. Under **Basic SAML Configuration**, click **Edit**. Put the SP entity ID in **Identifier (Entity ID)** and the ACS URL in **Reply URL (Assertion Consumer Service URL)**. Leave **Sign on URL** empty, then click **Save**. Under **SAML Certificates**, download the **Federation Metadata XML**: it is the IdP metadata (XML) for the next step. Under **Users and groups**, assign the people or groups that can sign in. To let everyone in your tenant sign in, set **Assignment required?** to **No** under **Properties**. You do not need to change the claims.

5. Under **3. Paste the values of your identity provider**, paste the IdP metadata (XML) for SAML, or choose the metadata file. For OIDC, enter the Issuer, the Client ID and the Client secret.

   Result: For OIDC, the page says: "The client secret is stored encrypted and is never shown again."

6. Under **4. Your domains**, enter the domains of your work addresses, for example `acme.com, eu.acme.com`. You can enter up to 20.

7. Click **Set up single sign-on**.

   Result: The page shows the connection and a Domains table with a TXT record for each domain.

Done when: You verified each domain (see the next section) and the test sign-in works.

## Verify your domains

Single sign-on works only for verified domains. You prove each domain with a DNS TXT record.

1. Under Domains, copy the TXT record of each domain: its Name and its Value. If the value is empty, the page says "Press Check DNS to get a value."
2. Add one TXT record for each domain at your DNS provider.
3. Click Check DNS. DNS changes can take some time.

When every domain passes, the page says: "Every domain is verified. Single sign-on works for these domains."

If Sequential does not find the record, it says: "Sequential did not find the TXT record yet. Check its name and value, wait a few minutes, then press Check DNS again." If the value changed, it says: "The value changed: put the new value in the TXT record, then press Check DNS again."

You cannot use a public mail domain, such as gmail.com, or a domain that another organisation already verified for single sign-on.

## Test the sign-in

After the domains are verified, the page shows Test sign-in. Use an account at your identity provider with your own address, or a private window.

The Start URL opens a Sequential page with the heading "Continue to <your organisation> single sign-on" and one button, Continue. Sequential does not start a sign-in from your identity provider by itself. To give people an icon for Sequential in your identity provider, use the Start URL. In Okta, for SAML, hide the icon of the SAML app from users, and add a bookmark app with the Start URL. In Okta, for OIDC, put the Start URL in the Initiate login URI of the app.

## Who joins, and with which role

A person signs in with single sign-on for the first time. Then:

- If they are already a member, their role does not change.
- If an invitation to your organisation waits for their address, the invitation decides the role. They accept it as usual.
- Else they join your organisation with the Default role. You choose it under Default role: "People who join through single sign-on join as" Member or Viewer. Single sign-on never makes an admin or an owner.

While provisioning (SCIM) is on, single sign-on adds nobody. Your identity provider adds people through provisioning. A person that it did not add can sign in, but does not join.

The address must be at a verified domain of your connection. If your identity provider sends another address, the sign-in stops.

In Settings › Members, owners and admins see an SSO chip on each person who signs in with single sign-on, and a SCIM chip on each person that provisioning manages.

## Sign in with single sign-on

On the sign-in page, click **More sign-in options**, then **Continue with SSO**. If you did not enter an address, type your Work email, then click Continue. Your browser opens your identity provider, and then comes back to Sequential.

When you type an address at a verified domain, Continue with SSO shows above the form as the main button. You do not need More sign-in options then. The password button then says Sign in with password.

On the Create an account page, Continue with SSO is also under More sign-in options.

## Two-factor and single sign-on

- If your organisation requires two-factor, a sign-in through your organisation's single sign-on counts for it. Your identity provider asks for the second factor. A single sign-on of another organisation does not count.
- If you turned on two-factor in Sequential for your own account, Sequential still asks for your code after single sign-on.

See [Two-factor authentication and account security](/docs/two-factor-and-security).

## Change single sign-on

- Default role: choose Member or Viewer. It applies to the next person who joins. It does not change the role of a member.
- Signing certificate (SAML): paste the New IdP metadata (XML), then click Change the certificate. To keep the old certificate while you change it at your identity provider, keep "Keep the current certificate until the new one works" selected.
- Client secret (OIDC): enter the New client secret, then click Change the client secret.
- Domains: click Change the domains…. The page says: "Changing the domains stops single sign-on for every domain until Check DNS passes again."

To use another identity provider, remove single sign-on and set it up again.

## Remove single sign-on

Removing single sign-on signs out everyone who signed in with it. They can sign in again in another way, for example with a password.

If provisioning (SCIM) is on, removing single sign-on also turns it off. Every member stays with their role. People that provisioning added are signed out one time.

1. Under Remove single sign-on, click Remove single sign-on….
2. Type the name of your organisation.
3. Click Remove single sign-on.

Also remove the app for Sequential in your identity provider.

## Provisioning (SCIM)

With provisioning, your identity provider adds people to this organisation. It also changes and removes them. Provisioning works with Okta and Microsoft Entra ID. Google Workspace has no SCIM push for custom apps.

Provisioning needs single sign-on with verified domains. Until then, the panel says: "To use provisioning, set up single sign-on and verify its domains first."

> **Important**
>
> Sequential shows the token only once. Copy it before you leave the panel.

1. Go to **Settings › Single sign-on**. Under **Provisioning (SCIM)**, click **Turn on provisioning**.

   Result: The panel shows the Tenant URL and a token: "Copy the token now. Sequential does not show it again."

2. Click **Copy token**, keep the token in a safe place, then click **I copied the token**.

3. In the SCIM settings of your identity provider, put the Tenant URL and the token.

   **If you use Microsoft Entra ID**

   Add `?aadOptscim062020` to the end of the Tenant URL. Put the token in Secret Token. Provisioning in Entra ID needs a Microsoft Entra ID P1 or P2 licence. Sequential has not yet checked these steps with a live Entra ID tenant. If a step is different for you, write to support@usesequential.com.

   **If you use Okta**

   In the app for Sequential, go to **General › App Settings** and click **Edit**. Set **Provisioning** to **SCIM**, then click **Save**. A **Provisioning** tab shows. On the **Provisioning** tab, under **Integration**, click **Edit**. Put the Tenant URL in **SCIM connector base URL**. Set **Unique identifier field for users** to `userName`. Tick **Push New Users**, **Push Profile Updates** and **Push Groups**. Set **Authentication Mode** to **HTTP Header**, and put the token in **Token**, without "Bearer ". Click **Save**: Okta checks the connection. Under **To App**, click **Edit**, turn on **Create Users**, **Update User Attributes** and **Deactivate Users**, then click **Save**. On the **Push Groups** tab, push the groups that you map to roles in Sequential.

4. Under **Groups and roles**, choose **Member**, **Viewer** or **Not mapped** for each group, then click **Save the roles**.

   Result: The groups show after your identity provider sends them. Until then, the panel says: "Your identity provider has not sent groups yet."

### What provisioning does

- A person gets the role of their group. A person in two or more groups gets the higher role. A person in no mapped group joins with the default role of single sign-on.
- Provisioning gives only Member or Viewer. It never changes the role of an owner or an admin.
- The address must be at a verified domain of your single sign-on. If a Sequential account with that address exists and its address is verified, provisioning uses that account. If its address is not verified, provisioning refuses the person.
- When your identity provider removes or turns off a person, Sequential removes them from this organisation. Their Sequential account stays: if your identity provider adds them again, they come back with the same account. It also revokes their project access tokens of this organisation, ends their agent connections to it, cancels the open invitations to their address. If no other organisation provisions them, Sequential also signs them out.
- An owner stays an owner. Sequential sends an email to the other owners. An admin is removed like a member.
- Under Recent changes, the panel shows the last 20 changes.

In Settings › Members, a SCIM chip shows a person that provisioning manages: "Your identity provider manages this person". If you remove such a person in Sequential, remove them in your identity provider too. If it still lists them, it adds them again.

### Tokens

A token works for one year. Sequential sends an email to the owners and admins 30 days and 7 days before a token ends.

To change the token, click **Rotate token**. "Rotate token makes a new token. The old token works until you revoke it." Put the new token in your identity provider. Then click **Revoke the token ending in …** for the old token. There can be two tokens at a time.

### Turn off provisioning

"When you turn off provisioning, every member stays with their role. Your identity provider cannot change people here after that. People that provisioning added are signed out one time. They sign in again to continue."

1. Under **Turn off provisioning**, click **Turn off provisioning…**.
2. Click **Turn off provisioning**.
3. Remove the SCIM settings in your identity provider too.

## Require single sign-on

The page says: "Requiring single sign-on for everyone is not available yet." People can still sign in with a password too.

## Messages

| Message | What it means | What to do |
|---|---|---|
| "Single sign-on did not work for this address. Sign in another way, or ask your admin." | The domain of the address has no verified single sign-on, or the sign-in could not start. | Check the address. Sign in with a password. |
| "Your identity provider sent an address outside your organisation's verified domains. Ask your admin to check the connection." | The identity provider sent an address that is not at a verified domain. | An admin checks the address that the identity provider sends. |
| "An account with this address already exists. Write to support@usesequential.com to connect it to single sign-on." | A Sequential account with this address exists, and its address is not verified. | Write to support. |
| "You are signed in as someone else. Sign out first, then sign in with single sign-on." | The browser has a Sequential session of another person. | Sign out, then try again. |
| "Single sign-on did not complete. Try again, or ask your admin." | The identity provider's answer was not accepted. | Try again. If it happens again, an admin checks the connection. |
| "Only owners and admins can set up single sign-on." | You are a member or a viewer. | Ask an owner or an admin. |
| "You asked for new values too often. Try again in N minutes." | You clicked Get our values more than 10 times in an hour. | Wait, then try again. |
| "The values expired. Get new values, then change them at your identity provider too." | You did not finish the set-up within 24 hours. | Get new values. Change them in your identity provider too. |
| "Your identity provider asks for signed requests. Turn that off in the app: Sequential does not sign them." | The SAML app asks for signed requests. | Turn off signed requests in the app. |
| "This metadata is for a different identity provider. To change the provider, remove single sign-on and set it up again." | The new metadata is for another identity provider. | Remove single sign-on, then set it up again. |
| "There are already two tokens. Revoke the old token. Then rotate the token again." | You rotated the token twice without a revoke. | Revoke the old token, then rotate again. |
| "This is the only token. To stop provisioning, turn it off." | You tried to revoke the last token. | Turn off provisioning instead. |
| "This organisation requires two-factor. Turn yours on in Settings › Security first." | Your organisation requires two-factor, and your account has none. | Turn on two-factor, then try again. |

## Limits

- One single sign-on connection for each organisation.
- Up to 20 domains.
- Up to 5 signing certificates at a time (SAML).
- Get our values: up to 10 times an hour for each organisation. The values are kept for 24 hours.
- Sequential does not sign SAML requests, and does not support single logout.
- Provisioning: 600 requests a minute and 20,000 a day for each connection. Over the limit, Sequential answers 429, and Okta and Entra ID try again later. Up to 500 groups in one save of the group map. Two tokens at a time; each works for one year.
- The audit log shows each change to single sign-on and each person who joined through it. Filter it by Single sign-on. See [Audit log](/docs/audit-log).

## Next steps

- [Roles and permissions](/docs/roles-and-permissions): what Member and Viewer can do.
- [Sign-up and invitations](/docs/sign-up-and-invitations): invite people who are not at a verified domain.
- [Two-factor authentication and account security](/docs/two-factor-and-security).
