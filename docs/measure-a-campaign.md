# Measure a campaign

> Find the campaign that brought the people who sign up, buy or activate. Break a funnel down by the first campaign of each person.

> **At a glance**
>
> - **You get:** The campaign that brought each person: Workbench › Funnels › Break down by › Their first … › campaign name.
> - **Know this:** A sign-up page usually has no `utm_` parameters, so sign-ups by `$utm_campaign` show ["(not set)"](#why-utmcampaign-shows-not-set-for-sign-ups).
> - **Know this:** A first touch comes from all kept data, also before your dates, but never from a visit after the conversion.
> - **Before you start:** Tag your links with lower-case `utm_source`, `utm_medium` and `utm_campaign`, before any `#`. See [Tag your links](#tag-your-links).
> - **Default:** A breakdown in a new funnel, and a first touch in Workbench › Events, [leave out your team](#your-team-in-the-counts).

## Credit each person to a first touch

To find the campaign that brought each person who signed up, use a funnel with your sign-up event as step 1. A new funnel has two steps.

1. In the rail, go to **Workbench › Funnels**.

2. In step 1, choose your sign-up event, or another conversion event.

3. In step 2, choose an event that comes after it, for example your activation event.

4. Set **Dates**.

   Result: The step-1 events in these dates count.

5. In **Break down by**, choose **Their first …**.

6. In the next menu, choose a field, for example **campaign name**.

7. Optional: in **Conversion window**, type a whole number from 1 to 90.

   Result: A later step counts only when the person does it within this number of days after step 1. A new funnel has a conversion window of 7 days.

Result: The funnel counts again after each change. There is no Run button. Under the funnel, each group has a card: the 20 largest groups by the people at step 1, then Everyone else for the rest. So the groups add up to the funnel. Each card shows the name of the group, the percent of its step-1 people who did the last step, a bar for each step, and the people at the last step of the people at step 1. Each count is people.

In Workbench › Events, Break down by › First touch (person) › First campaign name credits each person to their first campaign. For accounts, choose a field under First touch (account). See [Credit a first touch in Workbench › Events](#credit-a-first-touch-in-workbench-events).

A person can be in another group when old data is deleted, or for a few minutes after `identify()`. See [Limits](#limits).

### Why `$utm_campaign` shows (not set) for sign-ups

Sequential reads the campaign of an event from the `utm_` parameters of the event's own page address. A sign-up page usually has no such parameters, so sign-ups broken down by `$utm_campaign` show "(not set)". For example:

1. A person opens `https://example.com/?utm_campaign=spring`. The page view has the campaign name `spring`.
2. The person goes to `/signup` and creates an account. The sign-up event has the page address `/signup`, with no `utm_campaign`.

In Workbench › Events, with the filter Event is your sign-up event, and Break down by Event property… `$utm_campaign`, the sign-up is in "(not set)". An event that your server sends has no page address, so its campaign fields are always "(not set)". Break down by Event property… with `$utm_campaign` counts the events by their own campaign.

To credit the sign-up to the campaign of the first visit, use the person's first touch, in Workbench › Events or in a funnel. See [Credit each person to a first touch](#credit-each-person-to-a-first-touch).

### How Sequential credits a person

1. Step 1 and the dates select the conversions. Each person is in one group, from the touch at or before the person's step-1 event.
2. When a person did step 1 more than once in the dates, Sequential uses the first of these events.
3. Then Sequential reads the person's visits before that event, in all the data that it keeps for the project. This includes the days before the dates that you set. A visit after the conversion never gets the credit.
4. An event that your server sends with the user id counts as a conversion. It is never a touch, because it has no page address.
5. The visits that a person made before `identify()` count, because Sequential links them to the person. See [Identify users](/docs/identify-users) and [Limits](#limits).

Tip: set Break down by to Their last … before step 1 and the same field. If the groups are different, some people came from more than one campaign.

Special groups:

| The card reads | It counts |
|---|---|
| (not set) | People who have visits before step 1, but no value for this field. App events have no page address, so a person with only app events before step 1 is here, except for traffic source. |
| No website visit before step 1 | People whose only events before step 1 come from your server. |
| Direct or internal | traffic source only: a visit with no referrer, or from a page of the same site. Another domain of your project counts as a different site. An app event with no referrer is here too. |
| (withheld) | Campaign values that Sequential removed when it stored the event. See [What Sequential keeps from page URLs](/docs/url-policy). |
| Everyone else | The people of all the groups after the 20 largest. |

### The cards, the lines above the groups and the conversion window

The steps can be, for example, a page view, your sign-up event and your activation event. Click Add a step for more. In a new funnel, the breakdown also turns on Leave out people marked as your team when someone is marked as your team. See [Your team in the counts](#your-team-in-the-counts).

The cards:

- A card shows — when no person did step 1.
- Each person is in one group: the touch at or before the person's step-1 event.
- The cards show counts only. They have no list of people.

The lines above the groups:

- A sentence names the group that went on to the last step most often. When two or more groups compare, it also names the group that went on least. For example: "By their first campaign name, “spring” went on most often: …". It compares only the groups with at least 5 people at step 1.
- "Events before … are no longer kept, so a “first” value may be a later one for people who came earlier." This line shows when Sequential cannot confirm that it still keeps every day of the project's data. The date and time are the start of the data that Sequential still keeps for the project. They show in the medium date and short time format of your browser's language. A touch before that day is not in the data. See [Data retention and deletion](/docs/retention-and-deletion).
- "Each group is drawn against its own step 1."

The conversion window:

- All steps must also be in the dates. There is always a window.
- Who left here uses the same window, so its people match the funnel.
- A value that is not a whole number from 1 to 90 shows "The window is a whole number of days from 1 to 90." The funnel keeps the window that it had.

## Break a funnel down by campaign

The Break down by menu has six choices: Nothing, and the five in this table.

| Break down by | Each count is | What it reads |
|---|---|---|
| Their first … (to credit a sign-up) | people | the earliest value in the person's visits up to step 1 that is not empty and not (withheld) |
| Their last … before step 1 | people | the latest value before step 1, with the same rules |
| Their first visit’s … | people | the value on the first visit of the person |
| The step-1 visit’s first … | people | the first value in the session of the person's step-1 event only |
| The step-1 event’s … | people | the page address of the person's step-1 event |

The step-1 visit’s first … counts the campaign of the session itself. If a person clicks an ad, leaves, and signs up on a later visit, the sign-up session does not have the campaign. Use Their first … for that.

With Before / after a change, the funnel shows no groups: "The breakdown is left out while comparing."

### What each choice reads

Their first …, Their first visit’s … and Their last … before step 1 read each person's visits up to step 1. The line under the menu reads "Read from each person’s visits up to their step 1." See [Credit each person to a first touch](#credit-each-person-to-a-first-touch).

- In Their first … and Their last … before step 1, (withheld) shows only when the person has no other value.
- The step-1 visit’s first … reads the first value in the session of the person's step-1 event. Type `$page`, a campaign key such as `$utm_campaign`, or the name of an event property. `$page` gives the entry page.
- The step-1 event’s … reads the page address of the step-1 event: campaign source, campaign medium, campaign name, campaign term or campaign content.
- If Sequential refuses the breakdown field, the reason shows under Break down by.

Their first …, Their last … before step 1 and Their first visit’s … each take one of these fields: campaign source, campaign medium, campaign name, campaign term, campaign content, page and traffic source.

- page is a route template, for example `/blog/:id`. With Their first visit’s …, it is the first page that the person viewed.
- traffic source is the site that the visit came from, for example `google.com`.

## Choose what to count

Two Workbench views can split a count by campaign. For Workbench › Funnels, see [Break a funnel down by campaign](#break-a-funnel-down-by-campaign). In Workbench › Events, Break down by has three kinds of campaign choice:

| Break down by | Each count is | What it reads |
|---|---|---|
| Event property… with `$utm_source`, `$utm_medium`, `$utm_campaign`, `$utm_term` or `$utm_content` | events, or people when Count is People | the page address of each event |
| A field under First touch (person) | people | the person's visits before the conversion |
| A field under First touch (account) | accounts | the visits of all the people of the account, before the account's conversion |

## Credit a first touch in Workbench › Events

1. In the rail, go to **Workbench › Events**.

2. Set **Window**.

   Result: The conversions in this window count.

3. Click **Add a filter**.

4. Choose **Event**, then your sign-up event or another conversion event.

5. In **Break down by**, choose a field under First touch (person), for example **First campaign name**.

Result: The page counts again after each change. The table shows one row for each value. The count column is headed People.

### How the Events table compares with a funnel

- The filter and the window select the conversions. Each person counts one time, at the first matching event in the window.
- Then Sequential reads the person's visits before that event, as for a funnel. See [How Sequential credits a person](#how-sequential-credits-a-person).
- The six fields read the same values as these funnel choices:

| Field | The same as |
|---|---|
| First campaign source, First campaign medium, First campaign name | Their first … with campaign source, campaign medium or campaign name |
| Last campaign before converting | Their last … before step 1 with campaign name |
| First visit source | Their first visit’s … with traffic source |
| Landing page | Their first … with page |

The rows read as the cards of a funnel, with two differences. A person with no website visit before the conversion is in (no website visit). There is no Everyone else: the table lists up to 1,000 values.

Under the table:

- "Credited to each person's first touch since" and a date. The date is the first day of the data that Sequential still keeps for the project.
- "Earlier visits may be missing from the data, so some first touches can be later visits." This line shows when Sequential cannot confirm that it still keeps every day of the project's data. It does not show for Last campaign before converting alone.

A first-touch table has no Only this and no Sessions. For your team, see [Your team in the counts](#your-team-in-the-counts).

- In a funnel, Break down by has one level. In Workbench › Events, Then by adds a second level.
- A first touch pairs only with a first touch of the same kind: a person with a person, an account with an account.

Tip: in Then by, choose Last campaign before converting. If a value splits into different campaigns, some people came from more than one campaign.

### Credit each account

Choose a field under First touch (account), for example Account first campaign name. The count column is headed Accounts.

- Only events that carry an account id count as conversions. Each account counts one time, at its first matching event in the window. An event that your server sends with the account id counts.
- The people of an account are the people whose browser events carry the account id. Sequential reads all of their visits before the account's conversion. The earliest touch of any of them gets the credit.
- An account that only your server sends has no people. It is in "(no website visit)".
- In Then by, an account field pairs only with another account field.

See [People and accounts](/docs/users-and-accounts) for how to send an account id.

## Tag your links

An example link: `https://example.com/pricing?utm_source=reddit&utm_medium=cpc&utm_campaign=spring_launch`

One pattern that works:

| Parameter | What it holds | For example |
|---|---|---|
| `utm_source` | where the click came from | `reddit`, `google` or `newsletter` |
| `utm_medium` | the type of traffic | `cpc`, `email` or `social` |
| `utm_campaign` | a short name for the campaign | `spring_launch` |

Rules:

- Use the parameter names in lower case: `utm_source`, `utm_medium`, `utm_campaign`, `utm_term`, `utm_content`. Sequential does not read `UTM_SOURCE`.
- Values keep their case: `Reddit` and `reddit` are two rows. Use one rule for all your links, for example lower case only.
- Put the parameters before a `#`. A `utm_` parameter after `#` is not read.
- Sequential keeps the first 128 characters of a value.

See [Workbench › Events](/docs/events-explorer) for how Sequential reads them, and [What Sequential keeps from page URLs](/docs/url-policy).

## Your team in the counts

Workbench › Funnels › Your team has a switch: Leave out people marked as your team. It is off in a new funnel. In a new funnel, a breakdown turns it on, and choosing Nothing in Break down by turns it off again.

Workbench › Events › Your team has a box: Leave out your team. With a first touch in Break down by, the box is selected by default. With another breakdown, or none, it is not.

### Messages and rules for the team switch

- After you set the switch yourself, a breakdown does not change it. While nobody is marked as your team, it stays off.
- The address of the funnel keeps the switch. A saved funnel keeps it too. In a funnel that you open from a link or from Saved funnels, a breakdown does not change the switch.
- The help of Settings › Recording & data › Your team says "Marking changes no data: Ask, Evidence, People, the Board’s sessions searches, Workbench › Events, Workbench › Sessions, Workbench › Where people struggle and Workbench › Funnels can leave these people out of their answers, and say how many they left out."
- In Workbench › Events, with the box selected, the events of your team count neither as conversions nor as touches. So an account that only your team converted is not in the table. See [Workbench › Events](/docs/events-explorer).

#### Messages about your team

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Leaves out 3 people marked as your team who did step 1." | Funnels, under the switch, switch on | The counts leave out the people that your project marks as its team. The line says how many. | — |
| "Nobody marked as your team did step 1." | Funnels, under the switch, switch on | The counts leave out the people that your project marks as its team. | — |
| "Includes 3 people marked as your team who did step 1." | Funnels, under the switch, switch off | The counts include them. | — |
| "Your team is larger than Sequential checks at once, so some of its visits may still be counted." | Funnels, added to the line under the switch | Your team is larger than Sequential checks at once. | — |
| "Nobody is marked as your team yet, so there is no one to leave out. Mark them in Settings." | Funnels, under the switch | No team is marked. You cannot turn on the switch. | In the line, Mark them in Settings opens Settings › Recording & data › Your team. There an owner or admin marks your team. |
| "Sequential could not read who is marked as your team right now. Try again shortly, or include your team." | Funnels, switch on | Sequential cannot read who your team is. | Click Include your team. Or turn off Leave out people marked as your team, or try again shortly. |
| "Who is on your team could not be read for this answer." | Funnels, under the switch, switch off | Sequential cannot read who your team is. With the switch off, the answer includes your team. | — |

## Limits

| Limit | What happens |
|---|---|
| The data that Sequential keeps | A first touch comes only from the data that Sequential still keeps. When old data is deleted, a later visit can look like the first. The line "Events before … are no longer kept…" warns about this. See [Data retention and deletion](/docs/retention-and-deletion). |
| Mobile apps | App events have no page address, so they have no campaign values. Install attribution is not available. |

### If the earlier visits are not linked to the person

| Limit | What happens |
|---|---|
| A new sign-up | Sequential links the earlier anonymous visits to a person a few minutes after `identify()`. Until then, a new person can be in another group, for example (not set) or No website visit before step 1. |
| A shared device | When two people sign in on the same browser, the visits before the first sign-in stay with the first person. |
| `reset()` | It starts a new anonymous id. The visits after `reset()` are not linked to the person from before. |
| Your server's user id | A server event never links a visitor to a person. Only `identify()` in the browser does. So use the same user id on your server as in `identify()`. See [Backend SDK](/docs/backend-sdk). |
| Another origin | The browser SDK keeps one anonymous id for each origin. For example, `example.com` and `app.example.com` are two origins. A visit on one origin links to the person only if `identify()` also runs on that origin. |

### Agents

An agent with the scope `analytics:read` can ask the same questions:

- `get_breakdown` takes `user:first:<key>`, `user:first_visit:<key>` and `user:last_before:<key>`, with the key `$utm_source`, `$utm_medium`, `$utm_campaign` or `$page`. Each count is people.
- `get_breakdown` also takes `session:first:<key>` and `session:last:<key>` with the same four keys. Each count is sessions. `session:first:$page` is the entry page.
- `funnel_analysis` takes `breakdown` with the `user:` fields, and `conversion_window_days` from 1 to 90.
- The conversions are in the agent's window: at most the last 30 days, ending now. The first touch comes from all the data that Sequential keeps.
- In the filters of these tools, an agent can also test a person's first touch: the first or the first-visit value of `$utm_source`, `$utm_medium`, `$utm_campaign` or `$page`, with text operators only. The filters in the app cannot.
- `exclude_internal: true` leaves out the people that the project marks as internal, as [Leave out people marked as your team](#your-team-in-the-counts) does in a funnel in the app.
- Agents cannot use the account fields, the traffic source, `$utm_term` or `$utm_content`. They cannot filter by a session value.

See [Analytics from an agent](/docs/limits#analytics-from-an-agent).

## Next steps

- [Workbench › Events](/docs/events-explorer): how Sequential reads the `utm_` parameters.
- [Funnels](/docs/funnels)
- [Identify users](/docs/identify-users): how Sequential links the visits before `identify()` to the person.
- [People and accounts](/docs/users-and-accounts): how to send an account id.
- [Data retention and deletion](/docs/retention-and-deletion)
