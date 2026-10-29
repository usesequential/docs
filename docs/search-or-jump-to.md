# Ask or jump (⌘K)

> Press ⌘K to ask a question, to open a case, a person or a page, and to run a command, from the keyboard.

## What it is for

Use **Ask or jump** to ask the judge a question. You can also open a case, a person, a page, a Settings section or a saved view without the rail. You can also paste an id to open it. It also switches the project and runs commands. Some commands are for the page that is open.

## Open it

- Press ⌘K on a Mac or Ctrl K on other computers. Press it again to close it.
- Or press /.
- Or click the search button at the top of the rail.
- To close it, press Esc, or click outside it.

## What it shows

With nothing typed, the list shows these groups, in this order:

1. **Recent**: your last picks in this project. See [Recent picks](#recent-picks).
2. **On this page**: the date range commands of the open page, if it has a date range. See [Commands for this page](#commands-for-this-page).
3. **Cases**: the open cases.
4. **Go to**: the pages of the rail.
5. **Switch organisation**: your other organisations, if you have more than one.
6. **Commands**.

When you type, the list shows these groups, in this order:

1. **Ask**: from 3 characters, the first row asks the judge your text. Press Enter, and **Ask** opens with your question.
2. **Open by id**: when your text looks like an id. See [Open by id](#open-by-id).
3. **On this page**: the commands of the open page that match your text.
4. **Cases**: see [Find a case](#find-a-case).
5. **People**: from 2 characters. See [Find a person](#find-a-person).
6. **Go to**: the pages of the rail, and the pages of **Workbench**, for example **Workbench › Funnels**. Each page of the rail shows its key, for example "g c" for **Cases**.
7. **Settings**: the Settings sections, up to 8 rows. A section of the open project starts with the project's name, for example "<project> › Keys". The other sections start with "Settings ›", for example "Settings › Members". "<project> › Calibration" opens the calibration on **Questions**. The sections of your other projects are also here. Such a row opens that project first.
8. **Saved**: the saved filters, funnels, flows and retention views of the project, up to 8 rows. Next to each is its kind and size, for example "Funnel · 3 steps". A view opens on its **Workbench** page. If **Workbench** cannot show the view, a message says why, and nothing opens.
9. **Switch project**: your other projects that are not archived. Each row says "Switch to <project> · <organisation>". The project opens on **Brief**.
10. **Switch organisation**: your other organisations. Next to each is its project, its number of projects, or "No project yet".
11. **Commands**: **New funnel**, **Invite people**, **Get more sessions**, **Help for this page**, **Send feedback to Sequential**, two theme commands, **Open the Tallyfox demo** or **Leave the demo**, and **Sign out**. The two theme commands are the ones not in use now: **Switch to light theme**, **Switch to dark theme** or **Use the system theme**. **New funnel** opens an empty funnel in Workbench › **Funnels**.
12. **Help**: from 2 characters, **Search help for “…”** searches the help.

A page, a section, a saved view, a project or a command matches when each typed word is in its name or other words. Upper and lower case are ignored. For example, "findings" finds **Cases**, and "theme" finds the theme commands.

The list shows at most 40 rows. When nothing matches, it says "Nothing matches “…”."

## Find a case

When you type, **Cases** shows:

- the open cases whose title or page contains your text. Type `F-12`, `f12` or `#12` to find one case by its number;
- from 2 characters, the cases of every status whose title contains your text, up to 5. Dismissed cases are found too. The search ignores upper and lower case.

Each row shows the case number, its title and its stage. While a slow search runs, the group can say "Searching cases…". When nothing matches, it says "No cases match “…”." When detection is paused for the project, it says "Detection is paused for this project, so no case opens." When the search fails, the row "Case search failed." has **Retry**.

## Find a person

Type at least 2 characters. The search starts a short time after you stop typing. It shows up to 8 people.

It finds a person by:

- the name or the email from `identify()`;
- the start of the id, for a person who is identified;
- the full id, for any person;
- the name of the person's newest account.

The search ignores upper and lower case, but not accents. For example, "ada" does not find "Adámek". It finds only the people seen in the last 7 days. A name or an email that was set more than 7 days ago also matches, if the person was seen in the last 7 days.

Each row shows the person's name, else the email, else the id. An id longer than 14 characters shows its last 6 characters: "Visitor 5b2f8a" for an anonymous person, and "…9c41e7" for an identified person. Next to it is the account, else the email. Press Enter to open the person's page.

While a slow search runs, the group can say "Searching people…". When nothing matches, it says "No people match “…”." When the search fails, the row "People search failed." has **Retry**.

## Open by id

Paste an id with no spaces, of up to 200 characters. **Open by id** then shows:

- for `F-12`, `f12` or `#12`: **Open case F-12**;
- for a session id such as `s-…` or `sess-…`: **Open session …** and **Events in session …**;
- for a user id such as `u-…` or `user-…`, or an email address: **Open person …**;
- for a UUID: the three rows, because a UUID can be a session id or a user id.

**Events in session …** opens Workbench › **Events** for that session. Other text is a search, not an id.

## Commands for this page

On a page with a date range, **On this page** shows **Last 7 days**, **Last 30 days** and **Last 90 days**. They are not there while the page shows a view that is too long for its address. See [What each address can carry](/docs/filters-and-saved-views#what-each-address-can-carry). It does not show the range that the page shows now, or a range that the page does not have. Next to each command is the range now, for example "Now: last 30 days". The command keeps the rest of the page's view.

These pages have the commands: **People**, and Workbench › **Events**, **Funnels**, **Retention**, **Flows**, **Sessions**, **Heatmaps**, **Where people struggle** and **Accounts**. **Heatmaps** and **Where people struggle** have no **Last 90 days**.

## Recent picks

With nothing typed, **Recent** shows your last 5 picks in this project, newest first. A pick is a page or Settings section of this project, **New funnel**, a case, a person, a session, its events, or a saved view. **Ask** questions, the switch rows, the other commands, help searches and the sections of other projects are not kept. To empty the list of this project, click **Clear recent**.

Each row gets its name again each time the list opens. A person shows the id until the name is read. A page that you no longer have, and a saved view that was deleted, are left out.

### What your browser keeps

- The list is in the `localStorage` of this browser.
- Each member has one list for each project. Another member, or another project, never reads it.
- Each pick is kept as its kind and its id only: a page, a case number, a user id, a session id or the id of a saved view. A user id is an email address when your app sends emails as user ids.
- Names, case titles and the names of saved views are never kept. The text that you type is not kept, except an id that you open from **Open by id**.
- No list is kept while a Sequential staff member views your project as a customer.

The lists go from this browser:

- when you click **Sign out**. Then the lists of every member and every project go;
- when an open tab finds that you are no longer signed in. For example, your session ended while the tab was in the background. A lost connection or an outage does not remove them;
- when another member opens **Ask or jump** in this browser. Then the lists of all other members go.

A list stays when you close the browser without **Sign out**. It also stays when your session ends while no Sequential tab is open.

The Tallyfox demo has its own list. In the demo, **Ask or jump** does not remove your own lists. **Sign out** in the demo only leaves the demo, and your lists stay.

## Keyboard

| Key | What it does |
|---|---|
| ⌘K or Ctrl K | Open or close the palette |
| / | Open the palette |
| ↑ and ↓ | Move through the results |
| Enter | Open the result that is highlighted |
| Esc | Close the palette |

While the palette is open, Tab stays in the search field. The arrows skip the lines that are only notes, such as "Searching people…".

## Limits

- People that were last seen more than 7 days ago are not found.
- The search does not ignore accents.
- The case search reads only the titles. The page of a case finds only the open cases.
- The list shows at most 40 rows. With many open cases and nothing typed, the 40 rows can end before **Go to**.
- After too many searches, **Cases** and **People** say "Too many searches. Wait a moment."
- **Open by id** knows only the id shapes above. To find a person by another id, type the full id. To open a session by another id, use [Evidence](/docs/watch) or Workbench › **Sessions**.
- In a project that an agent trial added when you signed in, **Ask or jump** shows no recent picks, cases, people or saved views until you accept its terms. See [Let your agent set up a trial](/docs/agent-trial).

## Related

- [Ask](/docs/ask)
- [Users and accounts](/docs/users-and-accounts)
- [Cases](/docs/findings)
