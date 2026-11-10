# Live: who is on your site now

> Live shows on a world map how many visitors are on your site now, and from which countries. It is for a screen in your office.

> **At a glance**
>
> - **Who can:** Only signed-in owners, admins, members and viewers of the project.
> - **Default:** On for each project. An owner or an admin can [turn it off](#turn-live-off).
> - **Know this:** No public link. An access token (for example a project access token, `sq_pat_…`) or an agent cannot read Live.
> - **Works with:** Only accepted events from the Sequential browser SDK. Not PostHog, Mixpanel, your server or a mobile app.

## Open Live

From 4 November 2026, Live shows how many visitors were active on your site in the last 3 minutes, and from which countries. For a screen in your office, use [TV mode](#tv-mode).

1. In the rail, click **Live**.

   Result: Live shows the project that is open.

Or press G, then L, or click the Live card on Workbench.

## What you see

| On the page | What it is |
|---|---|
| On the site now | The number of visitors on the site now. |
| "3 new in the last minute" | An example: how many of them are new in the last minute. |
| "Active in the last 3 min" | A label on the page. |
| The world map | A bubble for each country. |
| The list of countries | The 6 countries with the most visitors. |
| A country in the list | A link to Sessions from that country in the last 2 days: today and yesterday, as whole UTC days, not the last 3 minutes. |

### Messages Live can show

| Message | Where | What it means | What to do |
|---|---|---|---|
| "No one on the site right now" | — | No visitor was active. | — |
| "Paused" | — | When Sequential has too much work, the page can show Paused and keep the last picture. | — |
| "Live is off for this project." | — | Live map is cleared in Settings › Project, so Live is off for the project. | An owner or an admin then sees "Turn it on". |
| "You cannot open Live in this project." | — | It is a project that you cannot open. | — |
| "Your session ended. Sign in again" | TV mode | The sign-in ended after the usual time without activity. | Sign in again. |

## TV mode

1. In Live, click **TV mode**.

   Result: It shows the map without the rail, at `/live/tv`.

2. To open one project, bookmark `/live/tv?project=<project id>`.

   Result: It opens that project, not the project that the browser had open.

3. Click **Full screen**, or use the full screen of the browser (F11).

   Result: It fills the screen. Esc leaves full screen only.

4. To go back to Live, click **Exit TV mode**.

The TV stays signed in like any browser. After the [usual time without activity](/docs/two-factor-and-security#how-long-a-sign-in-lasts), the page says "Your session ended. Sign in again".

### What TV mode does on a screen that stays on

TV mode is for a screen that stays on, for example in your office.

- It shows the name Sequential, the Live mark with the project, and a clock.
- It keeps the screen on while the page shows, where the browser allows it.
- It loads itself again once a day. Its own daily load is not activity of a person, so the sign-in still ends after the usual time without activity.
- Every 10 minutes it moves the picture by 2 pixels, so that the screen does not burn in.

## Turn Live off

Only owners and admins can change the Live map setting.

From 8 November 2026, under the heading Live map, the box "Show who is on the site now" has a line: "A world map of the visitors now, by country, for a screen in your office." Then rows follow. Shows: "Counts only, by country, of the visitors of the last 3 minutes". Who can open it: "Every member of the project, from Live. There is no public link." Kept: "A keyed hash of each visitor, with the country and when the session started, for a few minutes". The old help is under Read the full text ▾.

1. Go to **Settings › Recording & data**.

2. Under **Live map**, clear **Show who is on the site now**.

Result: While it is off, Sequential records nothing new for Live in the project. The data that it already holds expires in at most 5 minutes. The page says "Live is off for this project." An owner or an admin then sees "Turn it on".

## Who can open it

Owners, admins, members and viewers of the project. For a project that you cannot open, the page says "You cannot open Live in this project."

## What Live counts

| Term or case | What it means |
|---|---|
| Active | A visitor is active when the Sequential SDK sent an event from their browser in the last 3 minutes. Live counts each visitor once, also with two tabs open. |
| New | A visitor is new when their session started less than 1 minute ago. |
| Counted | Only events that Sequential accepted from the Sequential browser SDK. |
| Not counted | Events from PostHog, Mixpanel, your server or a mobile app. Requests that Sequential refused, for example from bots. A replay upload does not add a visitor. |
| No known country | A visitor with no known country counts in the total, but not in a country. |
| "5,000+" | Live counts at most 5,000 visitors in a project. Then the number shows as "5,000+". |

## What Live keeps

- For each active visitor, Sequential keeps a short keyed hash of the visitor id, the country code and when the session started. It keeps them in memory for at most 5 minutes.
- The page gets only the counts and the country codes: no ids, no page addresses and no names.

## Next steps

- [Sequential SDK (sequential.js)](/docs/sequential): the browser SDK that Live counts.
- [Roles and permissions](/docs/roles-and-permissions): what each role can do.
