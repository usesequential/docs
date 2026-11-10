# How the judge works

> Sequential asks every eligible session your project's questions and stores the answers as probabilities. A stored judgment does not change.

> **Key facts**
>
> - The judge answers your project's questions about each session. [Evidence](/docs/watch) uses the answers to put the sessions that need a look first.
> - The judge reads a text digest, never the recording or user id ([What the judge reads](#what-the-judge-reads)).
> - Background judging is on by default for each project. Owners and admins turn it off or on under Settings › Recording & data › Judging.
> - It judges an eligible session once, after 30 minutes with no new event. That judgment never changes.
> - Unclear is an answer, not a "no". A missing signal does not prove that something did not happen.

## What it is for

Judging asks each session the same questions, so you can compare and rank the answers. Nobody watches every recording, and filters find only what you already know to look for.

The questions are on the [Questions](/docs/rubric) page of your project.

Rewording, adding or removing a question applies only to sessions judged afterwards. A weight change applies at once ([A judgment does not change](#a-judgment-does-not-change)).

Right and Wrong on the session page record whether a reading was right. They never re-judge ([Check the judge](#check-the-judge)).

### Example questions

For example, judging can answer:

- Did the trial user who opened billing add a card, or give up?
- Did an error stop someone finishing checkout, or were they unsure what to do?
- Which of yesterday's sessions does a product manager need to watch first?

What Sequential asks by default: ["The default questions"](#the-default-questions).

### The default questions

The default questions ask:

- Intent: what did the person most likely come to do?
- Outcome: how did the session end?
- Friction: how much friction did the person hit? The levels are Smooth, Minor hesitation, Noticeable struggle and Severe struggle.
- Six signals: Rage clicks, Hit an error, Product bug, Form left unfinished, Went in circles and Worth watching.
- Three moments: Where they struggled, What they came to do and Where they gave up.

For questions of your own, open ["Example questions"](#example-questions).

## How a session is judged

1. If background judging is on, Sequential looks every 5 minutes for sessions that are not judged. A session needs a session id, at least 3 events and no new event for 30 minutes.
2. Sequential writes a digest: a short text with one line per event, long pauses and a few session facts.
3. The judge answers every question in one request. Sequential sends it the digest and your project's questions, and does not keep the digest ([AI and third parties](/docs/ai-and-third-parties)).
4. Sequential stores a probability for each answer ([What Sequential stores](#what-sequential-stores)).

### What Sequential stores

The table shows what Sequential stores for each kind of question.

| Kind | Example | What Sequential stores |
|---|---|---|
| Choice | Intent | A probability for each answer, such as 0.81 for Buy or subscribe |
| Scale | Friction | A probability for each level |
| Signal | Hit an error | The probability of yes. A signal is a yes-or-no question. |
| Moment | Where they struggled | The probability that it happened, and the event where it most likely happened. There is no moment if the judge rates it unlikely (under 40 %), or if no event gets at least 25 %. |

The judge writes no prose. Sequential builds the sentences on Evidence and on the session page from these numbers and from the wording of your questions. For example: "Came to use a feature and moved through 6 pages. 2 requests failed, went in circles." See [Reading an AI verdict](/docs/reading-verdicts).

## What the judge reads

The judge reads the digest, never the recording. Sequential never sends the user id to the judge. The judge reads only whether the person was identified or anonymous.

For each event, the judge reads:

- the path of a page, or a mobile screen name
- the text of a clicked element, else its label, else its id
- the name of a submitted form
- the message and type of an error
- the name of a custom event, and its properties as `key=value`, cut to 80 characters in total

The digest also has long pauses and session facts, such as the country, browser, operating system and device type.

Sequential reduces every web address in the digest to its path: it removes the host and the query string. A property filter drops some custom-event properties by their name. The list of names is in [Digest lines and session facts](#digest-lines-and-session-facts).

> **The property filter reads names, not values**
>
> If a property has an ordinary name, Sequential sends its value. Before it sends a value, Sequential scans it and replaces emails, card numbers, credentials, tokens and phone numbers in international format. The scan finds only these kinds. It does not find a name, a postal address or a phone number in national format. In full: [AI and third parties](/docs/ai-and-third-parties).

### Digest lines and session facts

Each event becomes one numbered line, except System events. The digest also has a line for each pause of 10 seconds or more, up to the 50 longest pauses. The last line says when the recording ends.

Each line has the time of the event. For anything but a page, it also has the page the event happened on.

| Event | What the judge reads |
|---|---|
| Page view | The path, such as `/settings/billing`, or a mobile screen name. A screen with neither reads as "(unnamed screen)". |
| Page that the person reached with their own Back | "went back (u-turn)" and the page. A Back right after a click is the page's own Back button, so it reads as a plain page. The first page of a session is never a u-turn. |
| Click, rage click, dead click | The text of the element, else its label, else its id, such as "Add card". Else "element". |
| Form submit | The name of the form |
| Error | The error message and type |
| Custom event | Its name, such as `trial_started`, and its properties as `key=value`, cut to 80 characters in total |
| Identify | Only that the person was identified |
| An event from your server ([Backend SDK](/docs/backend-sdk)) | Its name only. An error from your server reads as an error. |

Sequential cuts each name, path, element text or error message to 60 characters.

Sequential reduces every web address in the digest to its path. It removes the host, the query string and the fragment. Sequential also scans every text for emails, credentials, card numbers, tokens and phone numbers in international format.

Sequential drops a custom-event property if its name starts with `$`. It also drops a property if its name has one of these words: `email`, `mail`, `phone`, `tel`, `password`, `pass`, `token`, `secret`, `address`, `addr`, `name`, `ip`, `user`, `username`, `account`, `ssn`, `iban` or `card`. Sequential compares whole words. So `first_name` and `userId` are dropped, but `description` and `zip` stay.

Session facts are:

- duration
- device type
- identified or anonymous
- entry page
- browser
- operating system
- country
- pages visited

The entry page, browser, operating system and country come from the first event that is not from your server.

If the DevTools capture of the recording measured them, the facts also include counts of JavaScript errors, failed requests and console errors. Sequential leaves out what it did not measure. It never replaces it with zero.

A session recorded without DevTools capture ([DevTools in session replays](/docs/devtools)) has no error counts. The default questions tell the judge that a missing count means "not measured". A zero would say "nothing went wrong" and pull the answer the wrong way.

When the recording counted only part of the session, or the recorder dropped entries, the count reads "at least N". A count of zero never reads "at least 0".

Which events a long session keeps: "How long sessions are trimmed".

### How long sessions are trimmed

The judge reads at most 255 events. Sequential keeps the events in this order of priority:

1. errors and failed requests
2. rage clicks
3. dead clicks
4. pages reached with Back (u-turns)
5. form submits
6. page views
7. identify
8. custom events
9. plain clicks
10. mobile gestures (from 6 November 2026)

So if Sequential must drop events, it drops mobile gestures first, then plain clicks, then custom events. The events it keeps stay in time order.

If the text is still too large for the judge, Sequential retries once with the higher-priority half of the events. That judgment ranks like any other. The session page then says "Read … from N of M events".

What each kept event becomes: "Digest lines and session facts".

## A judgment does not change

Sequential judges each session once in the background. So each answer stays tied to the questions that produced it, and a wording edit does not start a paid re-judge of older sessions.

| Change | When it applies |
|---|---|
| Reword, add, remove or turn off a question | Only to sessions judged afterwards. On the session page, an earlier judgment says "The questions changed since; this reading is from the earlier version." |
| Sequential moves to a newer version of the judge | Only to sessions judged afterwards. Earlier judgments keep their answers. From 9 November 2026, their session page shows no line about it. |
| Change a weight | At once. The sessions in each lane of Evidence re-order. |
| New events arrive after judging | Never. The judgment does not include them. |

Nothing in the app changes a stored judgment. Some renames apply at once, because the judge does not read those names.

### Which label edits count as rewording?

The judge does not read weights, question names, or the name of an answer that has criteria. So these changes apply at once, and earlier judgments stay current.

| Change | When it applies |
|---|---|
| Change the name of a question, or the name of an answer that has criteria | At once. |
| Change the Attention weight | At once. |
| Rename a level of a scale, or an answer whose criteria are blank | Only to sessions judged afterwards, like a rewording. The judge reads these names. |

### The attention score

Evidence puts judged sessions into lanes. In each lane, the session with the highest attention score comes first. [Evidence](/docs/watch) tells what each lane holds.

To calculate the attention score:

- Each weighted signal adds its weight times the probability of yes.
- Each weighted scale adds its weight times the position of the session on the scale.

The default questions weight Worth watching 0.45, Friction 0.25, Hit an error 0.15 and Product bug 0.15. Your weights are in the "Attention weight" field of each signal and scale, on the Questions page. Owners and admins change them.

Sequential calculates the score from the stored answers ("What Sequential stores") and your current questions each time Evidence loads. So a weight change never needs a new judgment.

The order follows your current questions at once. A removed or turned-off question stops counting for every session. An older judgment scores nothing on a question added after it, so it can come lower in its lane on Evidence.

## When the judge cannot tell

An unclear answer is a result, not a failure. Not knowing if an error stopped the person is a different answer from knowing that no error stopped them.

Sequential gives each signal one of three states:

| Likelihood of yes | State | What you see |
|---|---|---|
| 70 % or more | On | A reading on the session page, and the signal in the verdict sentence. |
| 40 % to 70 % | Unclear | From 9 November 2026, a reading on the session page, with Right and Wrong. From 60 %, also a "Maybe:" pill on the card. |
| Under 40 % | Off | Nothing. |

If the judge cannot tell what the person came to do, or how the session ended, Evidence puts the session in the lane "The judge was unsure". A session with a signal that is on never goes in that lane.

## Get better judgments

The judge knows only what your events tell it.

- Name your milestones. Custom events such as `trial_started` or `invite_sent` show whether someone got what they came for. Put the meaning in the event name, because the judge reads only the first 80 characters of the properties ([Send custom events](/docs/custom-events)).
- Make events readable. An error needs its message. A click with no text, label or id reads as "element". A screen with no path or name reads as "(unnamed screen)".
- Record with DevTools capture. A session can break without sending an error event. Then the DevTools counts of errors and failed requests can be the only sign ([DevTools in session replays](/docs/devtools)).
- Ask answerable questions: ask whether they opened the docs, not whether they read them carefully. The judge always gives an answer, and a guess looks the same as a measurement.
- Check the readings. Right and Wrong show how often people agree with the judge on each question ([Check the judge and read Calibration](/docs/feedback-and-calibration)).

## Check the judge

1. Open a session from [Evidence](/docs/watch).

2. Open its full page.

3. Click **Right** or **Wrong** next to a reading.

Result: The line under the readings says, for example, "Saved: “Abandoned” was right." From 6 November 2026, it then says how often people agree with the judge on that question.

From 6 November 2026, the readings have the heading "Was the judge right?", and the page says "Your answer measures the judge. It never changes this reading." A check does not judge the session again.

Where else you can check a reading, the keys and each message: [Check the judge on a session](/docs/feedback-and-calibration#check-the-judge-on-a-session).

### What the session page shows

The session page shows each reading of the judge under "The judge's reading":

| Reading | What it says |
|---|---|
| Came to | What the person came to do, for example Use a feature |
| Outcome | How the session ended, for example Abandoned |
| Friction | The level, for example Noticeable struggle |
| Signal | Each signal that is on, for example Went in circles. From 9 November 2026, also each signal that is unclear |
| Moment | From 9 November 2026, each moment that the judge found: "Struggled", "Gave up" or "Clear what they came to do". A moment of a question without a role shows the name of the question |
| Watching | Worth watching or Not worth watching |

Next to each reading is a word for how sure the judge was. Hover over it to see the percent.

| Word | The judge gave the answer |
|---|---|
| almost certain | 95 % or more |
| sure | 85 % to 95 % |
| fairly sure | 70 % to 85 % |
| leaning that way | 55 % to 70 % |
| unsure | under 55 % |

## Limits

- Background judging runs only if your Sequential server allows it. The server can keep it off for every project. Ask and Try on a session (on the Questions page) do not need the judging switch.
- Background judging picks up only sessions whose last event is within the past 7 days. Turning it on does not judge older history.
- Background judging has its own daily allowance per project. Ask and Try on a session each have their own allowance.
- The judge reads at most 255 events ([How long sessions are trimmed](#how-long-sessions-are-trimmed)).
- Sequential cuts the properties of each custom event to 80 characters in total.
- Ask hides the sessions that the judge rated a weak match ([Ask](/docs/ask)).

## FAQ

### Why was a session not judged?

Sequential never judges a session with fewer than 3 events. System events do not count.

Sequential retries temporary errors, such as a rate limit, a server error or a network error. Any other error from the judge leaves the session not judged, for good. Evidence shows failed and too-short sessions in "Not judged".

### What happens when the daily allowance runs out?

When the background allowance runs out, background judging stops until the allowance resets at midnight UTC. Then it judges the newest sessions first, until the allowance runs out again.

From 5 November 2026, Sequential does not try the waiting sessions again every hour. A waiting session whose last event becomes more than 7 days old is not judged.

## Related pages

- [Reading a verdict](/docs/reading-verdicts): read one verdict.
- [Questions: what the judge asks](/docs/rubric): change the questions and weights.
- [Evidence: the sessions worth a look](/docs/watch): the judged sessions in lanes.
- [Check the judge and read Calibration](/docs/feedback-and-calibration): checks and Calibration in full.
- [AI and third parties](/docs/ai-and-third-parties): what the judge receives.
