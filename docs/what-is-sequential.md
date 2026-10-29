# What is Sequential

> Sequential records and replays sessions. After each eligible session ends, an AI judge says what the person came to do and where they had trouble.

> **In short**
>
> - Sequential takes events from the analytics SDK you already use, or from its own SDK.
> - It replays sessions with your events on the timeline and **DevTools** tabs under the player.
> - After an eligible session ends, an AI judge answers your project's questions about it.
> - **Evidence** ranks the judged sessions that need a look. **Ask** finds sessions from a description.
> - Funnels, flows, retention and other product analytics use the same events.

## Who it is for

Sequential is for teams who need to know what people do in their web or mobile product. This includes product managers, founders and designers. It also includes the engineers and support staff who investigate reports that something did not work.

You do not have to watch recordings at random or guess which filter finds the problem sessions. Sequential reads each eligible session and asks the same questions every time. What did this person come to do? Did they get there? Where did they have trouble?

## What Sequential does

| Part | What it does |
|---|---|
| Records events | Takes the events from the analytics SDK you already use, in the browser or in mobile apps. |
| Replays sessions | Shows your events on the timeline at the moment they happened. The **DevTools** tabs under the player show console calls and network requests ([DevTools in replays](/docs/devtools)). |
| Judges sessions | When no new events arrive for a session, sends a reduced text summary of its events to a third-party AI model. The judge answers your project's questions, such as **Intent**, **Outcome** and **Friction** ([Customise the questions](/docs/rubric)). |
| **Evidence** | Ranks judged sessions by how much they need a look. Each card has a line that says why. |
| **Ask** | Answers a question in one line about sessions, funnels, retention or people. For example, "tried to change their billing address and gave up" finds those sessions. |
| Product analytics | The views of **Workbench** in the left rail use the same events: **Events**, **Funnels**, **Retention**, **Flows**, **Heatmaps**, **Accounts** and **Sessions**. **People** has its own page in the rail. |

### When to expect a verdict

Expect a verdict 30 to 35 minutes after the session ends, or later if there is a queue. Sequential does not judge every session:

- It judges only sessions from the past 7 days, not older history.
- It judges only sessions with at least three meaningful events. It does not judge a recording with no analytics events behind it.
- It pauses when the project's daily allowance for background judging runs out. **Ask** has its own allowance.
- It judges each session once. So a change to your questions does not re-judge older sessions.

> **Background judging is on by default**
>
> Sequential judges the sessions of each project in the background, unless an owner or admin turns it off. The switch is **Judge new sessions automatically** under **Settings** › **Recording & data** › **Judging**. Your Sequential server must also allow it. If judging is off, **Settings** › **Recording & data** › **What applies** says why.

## What it needs from you

1. A project and its keys: [Organisations, projects and keys](/docs/organisations-and-projects).
2. Your SDK sending events, each with a session id: [Install Sequential](/docs/install).
3. For website replays with PostHog, Mixpanel, Amplitude or Pendo, the recorder script: [Session replay (web)](/docs/session-replay).
4. One identifier for each person, passed the same way every time: [Identify your users](/docs/identify-users). Sequential does not merge two different values for one person.
5. Events the judge can read: page views with URLs, or named screens in apps, clicks with visible text, and clearly named [custom events](/docs/custom-events).

## Limits

- Sequential is in preview. Anyone can create an account ([Sign-up and invitations](/docs/sign-up-and-invitations)), or let a coding agent set up a trial first ([Let your agent set up a trial](/docs/agent-trial)).
- It accepts browser SDKs and PostHog's mobile SDKs ([What each SDK supports](/docs/support-matrix)), and its own [backend SDK for Node](/docs/backend-sdk) for events from your server. It rejects other server-side senders, such as posthog-node or curl.
- On the web, PostHog, Mixpanel, Amplitude and Pendo record no replay on their own. Add the recorder script, or use the Sequential SDK, which records both.
- The judge's summary keeps page paths and short labels, such as visible click text. So an id in a path, such as `/users/123`, or on a button reaches the AI model.
- **Ask** shows only likely matches. So an empty or short list does not mean that nothing like it happened.
- In **Workbench** › **Sessions**, **The recording measured an error** and **The recording measured a failed request** return only recorded sessions that Sequential checked.
- By default, Sequential does not keep the text of console calls. It keeps their level, how often they happened and where. Each project can opt in to keeping message text.
- Account-level views show data from Pendo and from the Sequential SDK's `sequential.account()`. Events from other SDKs arrive without an account id.

### Example questions and where to look

Examples from a SaaS product:

| You want to know | Where you look |
|---|---|
| Which of yesterday's sessions need a look, such as a trial user stuck setting up a first project? | **Evidence** |
| Who tried to change their billing address and gave up? | **Ask** |
| A customer says export did nothing. What did they see, and did a request fail? | **People** → the customer → their session's replay and its **DevTools** tabs |
| Of the people who started checkout this week, how many paid, and who dropped out at the card step? | **Workbench** › **Funnels** |
| Of the people who signed up this month, what share came back to create an invoice 1, 7 and 30 days later? | **Workbench** › **Retention** |
| Which recorded sessions hit a JavaScript error or a failed request? | **Workbench** › **Sessions** → **The recording measured an error** or **The recording measured a failed request** |

**The recording measured an error** and **The recording measured a failed request** read counts taken from the recording. So they return only recorded sessions that Sequential checked.

### When a session is judged

- Sequential picks up a session no sooner than 30 minutes after its last event. It checks every 5 minutes.
- A session needs at least three meaningful events. Its last event must be within the past 7 days.
- When judging is turned on, it covers sessions from the past 7 days, not older history.
- Each project has a daily judging allowance. If the allowance runs out, judging pauses. It starts again after the allowance resets at midnight UTC.
- Sequential judges each session once. Changes to your questions apply to sessions judged afterwards. On the page of a session, an older reading says "The questions changed since; this reading is from the earlier version."
- Background judging reads your stored events, not the screen recording. Sequential judges sessions without a recording too. It does not judge a recording with no analytics events behind it.

### What the judge receives and returns

The default questions cover:

- **Intent**: what they came to do.
- **Outcome**: did they get there.
- **Friction**: how much it hurt.
- Signals such as **Hit an error**, **Product bug** and **Worth watching**.
- Moments such as **Where they struggled** and **Where they gave up**. Each moment points at one event.

Sequential keeps each answer as a probability. The model writes no prose. Sequential assembles the sentences you read from those numbers.

The summary leaves out the user id. Page addresses lose their host and query string. Page paths and short labels, such as visible click text, stay in the summary. So an id inside a path (`/users/123`) or on a button still reaches the model. See [AI and third parties](/docs/ai-and-third-parties).

Owners and admins can change the questions. To change them, select **Questions** in the left rail.

### Evidence and Ask in detail

### Evidence

- Where it can, **Evidence** links to the key moment in the replay.
- **Watch ↵** opens the session beside the list, at the key moment, such as where they struggled or gave up.
- **Right** and **Wrong** on each reading, on the page of the session, record whether the reading was right. They never re-judge. See [Evidence](/docs/watch).

### Ask

- Each search judges up to 200 of the newest 2,000 sessions of the last 7 days. The sessions that **Evidence** ranks highest go first.
- Each matching session opens at the moment that matched.
- Ask leaves out weaker matches.
- A sessions answer finds sessions. It does not count them.
- **Ask** in the app has its own daily allowance. It does not use the allowance of background judging.

### The Brief and your dashboard

The **Brief** is the first page of a project. At the top, **Sessions recorded, 7 days** counts the sessions of today and the 6 days before. Next to it, a line shows the sessions per day over the last 30 days. **People, 30 days** counts the people, with the pageviews in 30 days.

The line has a name such as "Sessions per day, last 30 days", with its first and last day. The days are UTC days. To read one day, put the pointer on the line. With the keyboard, focus the line and use the left and right arrow keys, **Home** and **End**. A day before the first event says "not measured". The last day says "so far" while it runs.

Under **Needs you**, **Your dashboard** shows your own tiles for the last 30 days. Each person has their own tiles in each project. Sequential keeps them on its server, not in your browser.

- On your first visit, Sequential sets up the tiles from the data of the project. A tile shows only when the data has something for it.
- The tiles are **Traffic**, **Worth watching**, **Key actions**, **Most frequent events**, **Errors**, **Rage & dead clicks**, **Failed or abandoned** and **Top pages**.
- **Traffic** shows **Sessions**, **People** and **Pageviews**, and the same line of sessions per day. When the first event is 14 days old or older, and the week before had sessions, **Sessions** also compares the last 7 days with the week before, for example "+12% in the last 7 days vs the week before".
- **Worth watching** reads the last 7 days of **Evidence**. It shows the first three judged sessions, each in the words of the judge. Each one opens its session. With none, it says how many sessions were too close to call, or "No sessions judged in the last 7 days".
- **Errors** and **Rage & dead clicks** start with one sentence that gives the share of sessions. Then they show a short list. An error that is a case opens the case. A page opens the sessions with a rage or dead click there.
- At the bottom, each tile has a link, such as **Open Evidence**, **See sessions with errors** or **Open in Workbench**. It opens the same days.
- A tile with nothing in its days says "None seen in the last 30 days".

**Add tile** opens a list of the tiles that your dashboard does not have. A tile that you cannot add says why, for example "No data yet". Click a tile to add it. It goes at the end. When you add **Key actions** or **Failed or abandoned**, Sequential can send your custom event names to the AI provider. See [AI and third parties](/docs/ai-and-third-parties).

To remove a tile, press its remove button ("Remove from dashboard"). The line above the tiles then says, for example, "Removed Traffic.", with **Undo**. **Undo** adds a new tile of that kind at the end. Sequential never adds a tile by itself. If you remove every tile, the dashboard says "You removed every tile. Add one back from Add tile."

If no event in the last 30 days makes a tile, the dashboard says "Nothing in the last 30 days", with **Set up <project>**. If events arrive but none makes a tile, it says "No tiles yet". On the first run of a project, the setup checklist is at the top of the **Brief**. See [The first run on the Brief](/docs/quickstart).

### How events and recordings arrive

- In the browser, Sequential takes events from PostHog, Mixpanel, Amplitude, Pendo or Smartlook. In mobile apps, it takes events from PostHog's SDKs.
- A website with no analytics SDK can use the [Sequential SDK](/docs/sequential): one tag for analytics and replay.
- You point your SDK at Sequential with your project's key. For Pendo, you register your own Pendo API key with the project instead.
- You do not fork your SDK or add a second analytics SDK.
- Sequential sorts each event on arrival into one of nine classes, such as page view, click, error or custom. It does this for every SDK.
- On the web, the [Sequential SDK](/docs/sequential) and Sequential's Smartlook script ([Moving from Smartlook](/docs/smartlook)) start the recorder themselves.
- With PostHog, Mixpanel, Amplitude or Pendo, you add Sequential's recorder script next to the SDK. The recorder picks up your SDK's session id. This is how your events appear on the replay timeline at the moment they happened.
- In mobile apps, Sequential plays back the PostHog SDK's own recording.
- On the web, the **DevTools** tabs also show JavaScript errors (**Errors**) and page performance (**Performance**).
- By default, Sequential keeps each console call's level, how often it happened and where. It does not keep the logged text. Each project can opt in to keeping message text.
- Mobile apps report less in **DevTools**.

### Analytics pages

- **Events**: count events and people over time, filtered and broken down by any field or property.
- **Funnels**: see how many people go through each step in order, and who dropped out where.
- **Retention**: see how many people come back after their first visit, day by day or week by week.
- **Flows**: follow the paths people take before and after an event or a page.
- **Heatmaps**: see where people click and how far they scroll on one page.
- **Accounts**: every account's health, people and activity. The accounts come from Pendo data and from `sequential.account()`.
- **Sessions**: find the sessions where something happened, by page, place, problems or what the judge read, and watch them.
- **People**, in the rail: who used the product, with their sessions.

These views are under **Workbench** in the left rail.

### Move around the app

The left rail shows, from the top: the project switcher, **Ask or jump**, **Brief**, **Cases**, **Ask**, **Evidence**, **People**, **Changes**, **Agents**, **Questions**, **Workbench**, **Board** and **Settings**. Every role sees every item when [Simple view](/docs/simple-view) is off. In Simple view, the rail shows only **Brief**, **Evidence**, **Funnels** and **Heatmaps**. A viewer starts in Simple view. Under them are **Invite people**, **Get more sessions** and **Help**. At the bottom are your name, **Send feedback to Sequential**, **Light or dark** and **Sign out**. Click your name to open a menu: **Profile**, **Security**, **Organisation** and **Audit log** for owners and admins, **Your feedback**, the **Simple view** switch and **Sign out**.

- **Brief** shows how many decisions wait for you, when there are any. In Simple view, it does not.
- **Cases**, **Evidence** and **Questions** can show a number. **Cases**: the open cases that are new. **Evidence**: the sessions that broke in the 7 calendar days to today, as in the **Broke** group of **Evidence**. **Questions**: the proposed changes to the questions that wait for review. Hold the pointer on the number to read it in words. No number shows when the count is 0 or Sequential cannot read it. Above 99, it shows 99+. A number with + is a minimum, because Sequential reads at most 100 open cases and 50 proposed changes. The counts are read again after 5 minutes, when you open the project or come back to the tab.
- **Invite people** opens the invite sheet in place. It shows how many invitations wait. See [Sign-up and invitations](/docs/sign-up-and-invitations).
- **Get more sessions** opens a panel over the page. See [Usage and session limits](/docs/usage-and-limits).
- **Send feedback to Sequential** opens the feedback panel. See [Send feedback to the Sequential team](/docs/send-feedback).
- **Questions** opens the questions that the judge asks about each session it judges. See [Customise the questions](/docs/rubric).
- **Workbench** holds the analytics views. See **Analytics pages** above.
- On a phone, the same items are in the menu. **Ask or jump** is at the top.

To go to a page fast, press G, then the key of the page. The rail shows each key, for example G then S for **Evidence**.

To ask a question or to open a case, a person or a page, press ⌘K on a Mac or Ctrl K on other computers. You can also click **Ask or jump** at the top of the rail. See [Ask or jump (⌘K)](/docs/search-or-jump-to).

Press Shift H, or click **Help**, to open **Help**. It searches these docs, lists the pages for the screen you are on, shows the keys that you can use on the page now, and has **Send feedback to Sequential**. Pages from **Help** open in a new tab. Press ? to show the keys.

### What each requirement means

- **Session id**: **Evidence**, **Workbench** › **Sessions** and **Ask** group events by session id, so events need one. [Sessions](/docs/sessions) explains where it comes from.
- **One identifier for each person**: pick one identifier, such as a user id, an email or an account key. Pass that same value every time you identify the person. Sequential uses the value exactly as you send it.
- **Events the judge can read**: the judge reads page views, named screens, clicks and custom events, plus a few session facts and error counts.

## Next steps

1. [Your first hour](/docs/quickstart): from a new project to your first sessions.
2. [How Sequential works](/docs/how-it-works): the path from your SDK to a verdict.
3. [Install Sequential](/docs/install): pick the SDK you already use.

## Related

- [Judgments](/docs/judgments)
- [Evidence: the sessions worth a look](/docs/watch)
- [Ask: one line about sessions, funnels, retention or people](/docs/ask)
- [AI and third parties](/docs/ai-and-third-parties)
- [Glossary](/docs/glossary)
