# What is Sequential

> Sequential records and replays sessions. After each eligible session ends, an AI judge says what the person came to do and where they had trouble.

> **Key facts**
>
> - Sequential takes events from your analytics SDK or its own SDK. Funnels, flows and retention use the same events.
> - It replays sessions with your events on the timeline and DevTools tabs under the player.
> - Expect a judgment 30 to 35 minutes after the session ends, or later if there is a queue.
> - Evidence ranks the judged sessions that need a look. Ask finds sessions from a description.
> - Background judging reads a reduced text summary of your stored events, not the screen recording.

## What it needs from you

1. A project and its keys: [Organisations, projects and keys](/docs/organisations-and-projects).
2. Your SDK sending events, each with a session id: [Install Sequential](/docs/install). Evidence, Workbench › Sessions and Ask group events by session id. [Sessions](/docs/sessions) explains where it comes from.
3. For website replays with PostHog, Mixpanel, Amplitude or Pendo, the recorder script: [Session replay (web)](/docs/session-replay).
4. One identifier for each person, passed the same way every time: [Identify your users](/docs/identify-users). Pick one, such as a user id, an email or an account key. Sequential uses the value exactly as you send it. It does not merge two different values for one person.
5. Events the judge can read: page views with URLs, or named screens in apps, clicks with visible text, and clearly named [custom events](/docs/custom-events). The judge also reads a few session facts and error counts.

Sequential is in preview. Anyone can create an account ([Sign-up and invitations](/docs/sign-up-and-invitations)), or let a coding agent set up a trial first ([Let your agent set up a trial](/docs/agent-trial)). Then follow [Your first hour](/docs/quickstart).

### How events and recordings arrive

- In the browser, Sequential takes events from PostHog, Mixpanel, Amplitude, Pendo or Smartlook. In mobile apps, it takes events from PostHog's SDKs.
- A website with no analytics SDK can use the [Sequential SDK](/docs/sequential): one tag for analytics and replay.
- You point your SDK at Sequential with your project's key. For Pendo, you register your own Pendo API key with the project instead.
- You do not fork your SDK or add a second analytics SDK.
- Sequential sorts each event on arrival into one of ten classes, such as page view, click, error or custom. It does this for every SDK.
- On the web, the [Sequential SDK](/docs/sequential) and Sequential's Smartlook script ([Moving from Smartlook](/docs/smartlook)) start the recorder themselves.
- On the web, PostHog, Mixpanel, Amplitude and Pendo record no replay on their own. Add the recorder script, or use the Sequential SDK, which records both.
- With PostHog, Mixpanel, Amplitude or Pendo, you add Sequential's recorder script next to the SDK. The recorder picks up your SDK's session id. This is how your events appear on the replay timeline at the moment they happened.
- In mobile apps, Sequential plays back the PostHog SDK's own recording.
- On the web, the DevTools tabs also show JavaScript errors (Errors) and page performance (Performance).
- By default, Sequential keeps each console call's level, how often it happened and where. It does not keep the logged text. Each project can opt in to keeping message text.
- Mobile apps report less in DevTools.
- Account-level views show data from Pendo and from the Sequential SDK's `sequential.account()`. Events from other SDKs arrive without an account id.

## Who it is for

Sequential is for teams who need to know what people do in their web or mobile product. This includes product managers, founders and designers. It also includes the engineers and support staff who investigate reports that something did not work.

You do not have to watch recordings at random or guess which filter finds the problem sessions. Sequential reads each eligible session and asks the same questions every time: What did this person come to do? Did they get there? Where did they have trouble?

## Example questions and where to look

| You want to know (examples from a SaaS product) | Where you look |
|---|---|
| Which of yesterday's sessions need a look, such as a trial user stuck setting up a first project? | [Evidence](/docs/watch): ranks judged sessions by how much they need a look |
| Who tried to change their billing address and gave up? | [Ask](/docs/ask): finds sessions from a description |
| A customer says export did nothing. What did they see, and did a request fail? | [People](/docs/users-and-accounts) (who used the product) → the customer → their session's replay and its DevTools tabs |
| Of the people who started checkout this week, how many paid, and who dropped out at the card step? | [Workbench › Funnels](/docs/funnels) (Workbench holds the analytics views) |
| Of the people who signed up this month, what share came back to create an invoice 1, 7 and 30 days later? | [Workbench › Retention](/docs/retention) |
| Which recorded sessions hit a JavaScript error or a failed request? | [Workbench › Sessions](/docs/devtools) → “The recording measured an error” or “The recording measured a failed request” |

### What Sequential does

| Part | What it does |
|---|---|
| Records events | Takes the events from the analytics SDK you already use, in the browser or in mobile apps. |
| Replays sessions | Shows your events on the timeline at the moment they happened. The DevTools tabs under the player show console calls and network requests ([DevTools in replays](/docs/devtools)). |
| Judges sessions | The judge answers your project's questions, such as Intent, Outcome and Friction ([Customise the questions](/docs/rubric)). What the judge gets is in What the judge receives and returns. |
| Evidence | Ranks judged sessions by how much they need a look. Each card has a line that says why. |
| Ask | Answers a question in one line about sessions, funnels, retention or people. For example, "tried to change their billing address and gave up" finds those sessions. |
| Product analytics | The views of Workbench in the left rail use the same events: Events, Funnels, Retention, Flows, Heatmaps, Accounts and Sessions. People has its own page in the rail. |

The analytics pages:

- Events: count events and people over time, filtered and broken down by any field or property.
- Funnels: see how many people go through each step in order, and who dropped out where.
- Retention: see how many people come back after their first visit, day by day or week by week.
- Flows: follow the paths people take before and after an event or a page.
- Heatmaps: see where people click and how far they scroll on one page.
- Accounts: every account's health, people and activity. The accounts come from Pendo data and from `sequential.account()`.
- Sessions: find the sessions where something happened, by page, place, problems or what the judge read, and watch them. “The recording measured an error” and “The recording measured a failed request” read counts taken from the recording. So they return only recorded sessions that Sequential checked.
- People, in the rail: who used the product, with their sessions.

### Evidence and Ask in detail

Evidence:

- Where it can, Evidence links to the key moment in the replay.
- Watch ↵ opens the session in the peek, at the key moment, such as where they struggled or gave up.
- Right and Wrong on each reading, on the page of the session, record whether the reading was right. They never re-judge. See [Evidence](/docs/watch).

Ask:

- Each search judges up to 200 of the newest 2,000 sessions of the last 7 days. The sessions that Evidence ranks highest go first.
- Each matching session opens at the moment that matched.
- Ask leaves out weaker matches.
- A sessions answer finds sessions. It does not count them.
- Ask in the app has its own daily allowance. It does not use the allowance of background judging.

## When to expect a judgment

Sequential picks up a session no sooner than 30 minutes after its last event. It checks every 5 minutes.

Sequential does not judge every session. A session is eligible only if:

- it is from the past 7 days.
- it has at least three meaningful events.

Sequential judges each eligible session once. It pauses when the project's daily allowance for background judging runs out.

Background judging is on by default for each project. An owner or admin turns it off with the switch “Judge new sessions automatically” under Settings › Recording & data › Judging.

### When a session is judged

- A session counts as from the past 7 days when its last event is within the past 7 days.
- When judging is turned on, it covers sessions from the past 7 days, not older history.
- Judging starts again after the daily allowance resets at midnight UTC.
- Changes to your questions apply to sessions judged afterwards. So a change to your questions does not re-judge older sessions. On the page of a session, an older reading says "The questions changed since; this reading is from the earlier version."
- Sequential judges sessions without a recording too. It does not judge a recording with no analytics events behind it.
- The Sequential server must also allow background judging. If judging is off, Settings › Recording & data › What applies says why.

## What the judge receives and returns

When no new events arrive for a session, Sequential sends a reduced text summary of its events to a third-party AI model. Background judging reads your stored events, not the screen recording.

The summary leaves out the user id. Page addresses lose their host and query string. Page paths and short labels, such as visible click text, stay in the summary. So an id inside a path (`/users/123`) or on a button still reaches the model. See [AI and third parties](/docs/ai-and-third-parties).

### The questions the judge answers

The default questions cover:

- Intent: what they came to do.
- Outcome: did they get there.
- Friction: how much it hurt.
- Signals such as Hit an error, Product bug and Worth watching.
- Moments such as Where they struggled and Where they gave up. Each moment points at one event.

Sequential keeps each answer as a probability. The model writes no prose. Sequential assembles the sentences you read from those numbers.

Owners and admins can change the questions. To change them, click Questions in the left rail.

The judge's summary keeps page paths and short labels, such as visible click text. So an id in a path, such as `/users/123`, or on a button reaches the AI model. For what the summary keeps and leaves out, see [AI and third parties](/docs/ai-and-third-parties).

## Limits

- Sequential accepts browser SDKs and PostHog's mobile SDKs ([What each SDK supports](/docs/support-matrix)), and its own [backend SDK for Node](/docs/backend-sdk) for events from your server. It rejects other server-side senders, such as posthog-node or curl.
- Ask shows only likely matches. So an empty or short list does not mean that nothing like it happened.

## Find your way around the app

The Brief is the first page of a project. The left rail shows, from the top: the project switcher, Ask or jump, Brief, Cases, Ask, Evidence, People, Changes, Agents, Questions, Workbench, Board and Settings. [Cases and fixes](/docs/findings) explains Cases.

### The Brief and your dashboard

At the top of the Brief, Sessions recorded, 7 days counts the sessions of today and the 6 days before. Next to it, a line shows the sessions per day over the last 30 days. People, 30 days counts the people, with the pageviews in 30 days.

The line has a name such as "Sessions per day, last 30 days", with its first and last day. The days are UTC days. To read one day, put the pointer on the line. With the keyboard, focus the line and use the left and right arrow keys, Home and End.

Under Needs you, Your dashboard shows your own tiles for the last 30 days. Each person has their own tiles in each project. Sequential keeps them on its server, not in your browser.

- On your first visit, Sequential sets up the tiles from the data of the project. A tile shows only when the data has something for it.
- The tiles are Traffic, Worth watching, Key actions, Most frequent events, Errors, Rage & dead clicks, Failed or abandoned and Top pages.
- Traffic shows Sessions, People and Pageviews, and the same line of sessions per day. When the first event is 14 days old or older, and the week before had sessions, Sessions also compares the last 7 days with the week before, for example "+12% in the last 7 days vs the week before".
- Worth watching reads the last 7 days of Evidence. It shows the first three judged sessions, each in the words of the judge. Each one opens its session. With none, it says how many sessions were too close to call, or "No sessions judged in the last 7 days".
- Errors and Rage & dead clicks start with one sentence that gives the share of sessions. Then they show a short list. An error that is a case opens the case. A page opens the sessions with a rage or dead click there.
- At the bottom, each tile has a link, such as Open Evidence, See sessions with errors or Open in Workbench. It opens the same days.

The Brief can also show a Calibration tile: how often people agree with the judge. From 20 checks it shows a rate. The rate counts only people's checks. Agents' checks show apart. The tile has Check 5 sessions, Ask your agent and See it by question. Its messages are under Messages on the Calibration tile, below.

Add tile opens a list of the tiles that your dashboard does not have. A tile that you cannot add says why. Click a tile to add it. It goes at the end. When you add Key actions or Failed or abandoned, Sequential can send your custom event names to the AI provider. See [AI and third parties](/docs/ai-and-third-parties).

To remove a tile, click its remove button ("Remove from dashboard"). Apart from Calibration, Sequential never adds a tile by itself.

Sequential added the Calibration tile once to every Brief that existed, as its first tile. If you remove it, it does not come back. A new Brief gets it while people have made fewer than 20 checks and the judge read sessions in the last 7 days.

On the first run of a project, the setup checklist is at the top of the Brief. See [The first run on the Brief](/docs/quickstart).

#### Messages on the Brief

| Message | Where | What it means | What to do |
|---|---|---|---|
| "not measured" | A day on the line of sessions per day | The day is before the first event. | — |
| "so far" | The last day on the line | The day still runs. | — |
| "None seen in the last 30 days" | A tile | The tile has nothing in its days. | — |
| "No data yet" | Add tile | An example of why you cannot add a tile. | — |
| "Removed Traffic." | The line above the tiles | An example, after you remove the Traffic tile. Undo shows with it. | Undo adds a new tile of that kind at the end. |
| "You removed every tile. Add one back from Add tile." | Your dashboard | You removed every tile. | — |
| "Nothing in the last 30 days" | Your dashboard, with Set up <project> | No event in the last 30 days makes a tile. | — |
| "No tiles yet" | Your dashboard | Events arrive, but none makes a tile. | — |

#### Messages on the Calibration tile

| Message | Where | What it means | What to do |
|---|---|---|---|
| "12 of 20 checks" | The Calibration tile, with fewer than 20 checks | An example of how many checks people made so far. | — |
| "At 20, Sequential can say how far to trust the judge." | The Calibration tile, with fewer than 20 checks | From 20 checks, the tile shows how often people agree with the judge. | — |
| "85.4% right" | The Calibration tile, from 20 checks | An example of the rate. It counts only people's checks. | — |
| "41 of 48 checks" | The Calibration tile, from 20 checks | An example, with the rate. | — |
| "Agents: 20 checks, counted apart." | The Calibration tile | An example. Agents' checks show apart from people's checks. | — |

### Move around the app

Every role sees every item when [Simple view](/docs/simple-view) is off. In Simple view, the rail shows only Brief, Evidence, Funnels and Heatmaps. A viewer starts in Simple view.

Under them are Invite people, Get more sessions and Help. At the bottom are your name, Send feedback to Sequential, Light or dark and Sign out. Click your name to open a menu: Profile, Security, Organisation and Audit log for owners and admins, Your feedback, the Simple view switch and Sign out.

- Brief shows how many decisions wait for you, for example "4 decisions wait for you." From 8 November 2026, it says "Nothing waits for you." when none does. In Simple view, it does not.
- Cases, Evidence and Questions can show a number. Cases: the open cases that are new. Evidence: the sessions that broke in the 7 calendar days to today, as in the Broke group of Evidence. Questions: the proposed changes to the questions that wait for review.
- Hold the pointer on the number to read it in words. No number shows when the count is 0 or Sequential cannot read it. Above 99, it shows 99+. A number with + is a minimum, because Sequential reads at most 100 open cases and 50 proposed changes. The counts are read again after 5 minutes, when you open the project or come back to the tab.
- Invite people opens the invite sheet in place. It shows how many invitations wait. See [Sign-up and invitations](/docs/sign-up-and-invitations).
- Get more sessions opens a panel over the page. See [Usage and session limits](/docs/usage-and-limits).
- Send feedback to Sequential opens the feedback panel. See [Send feedback to the Sequential team](/docs/send-feedback).
- Questions opens the questions that the judge asks about each session it judges. See [Customise the questions](/docs/rubric).
- Workbench holds the analytics views (the list is in What Sequential does).
- On a phone, the same items are in the menu. Ask or jump is at the top.

| Key | What it does |
|---|---|
| G, then the key of the page | Goes to the page fast. The rail shows each key, for example G then S for Evidence. |
| ⌘K on a Mac, Ctrl K on other computers | Asks a question, or opens a case, a person or a page. You can also click Ask or jump at the top of the rail ([Ask or jump (⌘K)](/docs/search-or-jump-to)). |
| Shift H, or click Help | Opens Help. It searches these docs, lists the pages for the screen you are on, shows the keys that you can use on the page now, and has Send feedback to Sequential. Pages from Help open in a new tab. |
| ? | Shows the keys. |

## Next steps

1. [Your first hour](/docs/quickstart): from a new project to your first sessions.
2. [How Sequential works](/docs/how-it-works): the path from your SDK to a judgment.
3. [Install Sequential](/docs/install): pick the SDK you already use.
4. [Judgments](/docs/judgments): what the judge stores.
5. [Glossary](/docs/glossary): the words these docs use.
