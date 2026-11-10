# Ask or jump (⌘K)

> Press ⌘K to ask a question, to open a case, a person or a page, and to run a command, from the keyboard.

> **At a glance**
>
> - **Know this:** ⌘K (Ctrl K on other computers) or / opens it. Esc or a click outside closes it.
> - **Know this:** People search finds only people seen in the last 7 days. It ignores upper and lower case, but not accents.

A click on the search button at the top of the rail also opens it. Then type. You do not need the rail:

| To | Type |
|---|---|
| Ask the judge a question | 3 or more characters, then press Enter. Ask opens with your question. |
| Open a case | Text from its title or page, or its number. |
| Open a person | A name, an email, an id or the name of the person's newest account. Press Enter to open the person's page. See [Find a person](#find-a-person) for what matches. |
| Go to a page, a Settings section or a saved view | Words of its name or other words for it. |
| Open an id | Paste the id. |
| Switch the project, or run a command | Words of its name or other words for it. Some commands are for the page that is open. |

## Keyboard

| Key | What it does |
|---|---|
| ⌘K on a Mac, Ctrl K on other computers | Open or close Ask or jump |
| ↑ and ↓ | Move through the results. The arrows skip the lines that are only notes, such as "Searching people…". |
| Enter | Open the result that is highlighted |
| Tab | Stays in the search field while Ask or jump is open |

## What it shows

A page, a section, a saved view, a project or a command matches when each typed word is in its name or in other words for it. Upper and lower case are ignored. For example, "findings" finds Cases, and "theme" finds the theme commands.

### The order of the groups

The list shows at most 40 rows.

With nothing typed, the list shows these groups, in this order:

1. Recent: your last picks in this project. See [Recent picks](#recent-picks).
2. On this page: the date range commands of the open page, if it has a date range. See [Commands for this page](#commands-for-this-page).
3. Cases: the open cases.
4. Go to: the pages of the rail.
5. Switch organisation: your other organisations, if you have more than one.
6. Commands.

When you type, the list shows these groups, in this order:

1. Ask: from 3 characters, the first row asks the judge your text. Press Enter, and Ask opens with your question.
2. Open by id: when your text looks like an id. See [Open by id](#open-by-id).
3. On this page: the commands of the open page that match your text.
4. Cases: see [Find a case](#find-a-case).
5. People: from 2 characters. See [Find a person](#find-a-person).
6. Go to: the pages of the rail, and the pages of Workbench, for example Workbench › Funnels.
7. Settings: the Settings sections, at most 8 rows.
8. Saved: the saved filters, funnels, flows and retention views of the project, at most 8 rows.
9. Switch project: your other projects that are not archived.
10. Switch organisation: your other organisations.
11. Commands.
12. Help: from 2 characters, Search help for “…” searches the help.

### How each group shows its rows

- Cases: each row shows the case number, its title and its stage.
- People: the search starts a short time after you stop typing. Each row shows the person's name, else the email, else the id. An id longer than 14 characters shows its last 6 characters: "Visitor 5b2f8a" for an anonymous person, and "…9c41e7" for an identified person. Next to it is the account, else the email.
- Go to: each page of the rail shows its key, for example "g c" for Cases.
- Settings: a section of the open project starts with the project's name, for example "<project> › Keys". The other sections start with "Settings ›", for example "Settings › Members". "<project> › Calibration" opens the calibration on Questions. The sections of your other projects are also here. Such a row opens that project first.
- Saved: next to each is its kind and size, for example "Funnel · 3 steps". A view opens on its Workbench page. If Workbench cannot show the view, a message says why, and nothing opens.
- Switch project: each row says "Switch to <project> · <organisation>". The project opens on Brief.
- Switch organisation: next to each is its project, its number of projects, or "No project yet".

### All commands

Commands: New funnel, Invite people, Get more sessions, Help for this page, Send feedback to Sequential, two theme commands, Open the Tallyfox demo or Leave the demo, and Sign out. The two theme commands are the ones not in use now: Switch to light theme, Switch to dark theme or Use the system theme. New funnel opens an empty funnel in Workbench › Funnels.

## Find a case

When you type, the Cases group shows:

| Cases | What matches |
|---|---|
| Open cases | Your text in the title or the page, or the number: `F-12`, `f12` or `#12` |
| Cases of every status, dismissed cases too | From 2 characters, your text in the title only. The search ignores upper and lower case. At most 5. |

For the messages of Cases and People, see [Messages on this page](#messages-on-this-page).

## Find a person

Type at least 2 characters. The People group shows at most 8 people. It finds a person by:

- the name or the email from `identify()`;
- the start of the id, for a person who is identified;
- the full id, for any person;
- the name of the person's newest account.

### Messages on this page

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Nothing matches “…”." | The list | Nothing matches your text. | — |
| "Searching cases…" | Cases | A slow search runs. | — |
| "No cases match “…”." | Cases | No case matches your text. | — |
| "Detection is paused for this project, so no case opens." | Cases | Detection is paused for the project. | — |
| "Case search failed." | Cases | The search failed. The row has Retry. | — |
| "Searching people…" | People | A slow search runs. | — |
| "No people match “…”." | People | No person matches your text. | — |
| "People search failed." | People | The search failed. The row has Retry. | — |
| "Too many searches. Wait a moment." | Cases and People | There were too many searches. | Wait a moment. |

## Open by id

Paste an id with no spaces, of at most 200 characters. The Open by id group then shows:

| You paste | Open by id shows |
|---|---|
| `F-12`, `f12` or `#12` | "Open case F-12" |
| A session id such as `s-…` or `sess-…` | "Open session …" and "Events in session …", which opens Workbench › Events for that session. |
| A user id such as `u-…` or `user-…`, or an email address | "Open person …" |
| A UUID | The two session rows and the person row, because a UUID can be a session id or a user id |

## Commands for this page

On a page with a date range, the On this page group shows Last 7 days, Last 30 days and Last 90 days. Next to each command is the range now, for example "Now: last 30 days". The command keeps the rest of the page's view.

## Recent picks

With nothing typed, the Recent group shows your last 5 picks in this project, newest first. To empty the list of this project, click Clear recent.

### What counts as a pick

A pick is a page or Settings section of this project, New funnel, a case, a person, a session, its events, or a saved view. Ask questions, the switch rows, the other commands, help searches and the sections of other projects are not kept.

Each row gets its name again each time the list opens. A person shows the id until the name is read. A page that you no longer have, and a saved view that was deleted, are left out.

### What your browser keeps

- The list is in the `localStorage` of this browser.
- Each member has one list for each project. Another member, or another project, never reads it.
- Each pick is kept as its kind and its id only: a page, a case number, a user id, a session id or the id of a saved view. A user id is an email address when your app sends emails as user ids.
- Names, case titles and the names of saved views are never kept. The text that you type is not kept, except an id that you open from Open by id.
- No list is kept while a Sequential staff member views your project as a customer.

The lists go from this browser:

- when you click Sign out. Then the lists of every member and every project go;
- when an open tab finds that you are no longer signed in. For example, your sign-in ended while the tab was in the background. A lost connection or an outage does not remove them;
- when another member opens Ask or jump in this browser. Then the lists of all other members go.

A list stays when you close the browser without Sign out. It also stays when your sign-in ends while no Sequential tab is open.

The Tallyfox demo has its own list. In the demo, Ask or jump does not remove your own lists. Sign out in the demo only leaves the demo, and your lists stay.

## FAQ

### Why does a person not show up?

People search finds only the people seen in the last 7 days. A name or an email that was set more than 7 days ago also matches, if the person was seen in the last 7 days. The search ignores upper and lower case, but not accents. For example, "ada" does not find "Adámek".

### Why is a group missing from the list?

In a project that an agent trial added when you signed in, Ask or jump shows no recent picks, cases, people or saved views until you accept its terms. See [Let your agent set up a trial](/docs/agent-trial).

The list shows at most 40 rows. With many open cases and nothing typed, the 40 rows can end before Go to.

### What if my id has another shape?

Other text is a search, not an id. Open by id knows only the id shapes in [Open by id](#open-by-id). To find a person by another id, type the full id. To open a session by another id, use [Evidence](/docs/watch) or Workbench › Sessions.

### Why is a date range command missing?

These pages have the commands: People, and Workbench › Events, Funnels, Retention, Flows, Sessions, Heatmaps, Where people struggle and Accounts. Heatmaps and Where people struggle have no Last 90 days.

On this page does not show the range that the page shows now, or a range that the page does not have. The commands are not there while the page shows a view that is too long for its address. See [What each address can carry](/docs/filters-and-saved-views#what-each-address-can-carry).

## Next steps

- [Ask](/docs/ask): where your question opens.
- [Users and accounts](/docs/users-and-accounts)
- [Cases](/docs/findings): the cases that you find here.
