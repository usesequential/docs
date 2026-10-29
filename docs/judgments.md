# AI judgments of sessions

> Sequential asks every eligible session your project's questions and stores the answers as probabilities. A stored judgment does not change.

> **In short**
>
> - Background judging is on by default for each project. Owners and admins turn it off or on under **Settings** › **Recording & data** › **Judging**. Your Sequential server must also allow it.
> - Sequential judges an eligible session after it has had no new event for 30 minutes.
> - The judge reads a short text digest of the events. It never watches the recording.
> - Sequential stores the answers as probabilities. The judge writes no prose.
> - A stored judgment never changes. If you reword, add or remove a question, the change applies only to sessions judged afterwards.

## What it is for

Nobody watches every recording. Filters find only what you already know to look for. Judging asks each session the same questions, so you can compare and rank the answers. [Evidence](/docs/watch) uses them to put the sessions that need a look first.

The questions are on the **Questions** page of your project. See "Example questions" and "The default questions" below, and [Questions](/docs/rubric).

## How a session is judged

1. **Sequential finds sessions with no new events.** If background judging is on, Sequential looks every 5 minutes for sessions that are not judged. A session needs a session id, at least 3 events and no new event for 30 minutes.
2. **Sequential writes a digest.** It turns the stored events into a short text: one line per event, long pauses and a few session facts. The judge reads this text, never the recording.
3. **The judge answers every question in one request.** Sequential sends the digest and your project's questions to the judge. Sequential does not keep the digest. See [AI and third parties](/docs/ai-and-third-parties).
4. **Sequential stores the answers as numbers.** It stores a probability for each answer. See "What Sequential stores" below.

Sequential never sends the user id to the judge. The judge only reads if the person was identified or anonymous. Sequential reduces every web address in the digest to its path: it removes the host and the query string. It drops some custom-event properties by their name. It also scans every text for emails, credentials, card numbers, tokens and phone numbers in international format. See "Digest lines and session facts" below.

> **The property filter reads names, not values**
>
> The filter reads the name of a property, not its value. If a property has an ordinary name, Sequential sends its value. Before it sends a value, Sequential scans it and replaces emails, card numbers, credentials, tokens and phone numbers in international format. The scan finds only these kinds. It does not find a name, a postal address or a phone number in national format.

## A judgment does not change

Sequential judges each session once in the background. So each answer stays tied to the questions that produced it. Also, a wording edit does not start a paid re-judge of your older sessions.

| Change | When it applies |
|---|---|
| Reword, add, remove or turn off a question | Only to sessions judged afterwards. On the session page, an earlier judgment says "The questions changed since; this reading is from the earlier version." |
| Sequential moves to a newer version of the judge | Only to sessions judged afterwards. Earlier judgments show the same line. |
| Change a weight | At once. The sessions in each lane of Evidence re-order. |
| New events arrive after judging | Never. The judgment does not include them. |

Nothing in the app changes a stored judgment. **Right** and **Wrong** on the session page record whether a reading was right. They never re-judge. See "Right and Wrong" below, and [Feedback and calibration](/docs/feedback-and-calibration).

## When the judge cannot tell

An unclear answer is a result, not a failure. It is not a "no". Not knowing if an error stopped the person is a different answer from knowing that no error stopped them.

Sequential gives each signal one of three states:

| Probability of yes | State | What you see |
|---|---|---|
| 70 % or more | On | A reading on the session page, and the signal in the verdict sentence. |
| 40 % to 70 % | Unclear | "The judge leans toward, but is not sure of: …" on the session page. From 60 %, also a "Maybe:" pill on the card. |
| Under 40 % | Off | Nothing. |

So a missing signal does not prove that something did not happen. **Ask** also hides the sessions that the judge rated a weak match.

Sometimes the judge cannot tell what the person came to do, or how the session ended. Evidence then puts the session in the lane **The judge was unsure**. A session with a signal that is on never goes in that lane.

## Right and Wrong

The session page shows each reading of the judge under **The judge's reading**:

| Reading | What it says |
|---|---|
| Came to | What the person came to do, for example **Use a feature** |
| Outcome | How the session ended, for example **Abandoned** |
| Friction | The level, for example **Noticeable struggle** |
| Signal | Each signal that is on, for example **Went in circles** |
| Watching | **Worth watching** or **Not worth watching** |

Next to each reading is a word for how sure the judge was. Point to the word to see the percentage.

| Word | The judge gave the answer |
|---|---|
| almost certain | 95 % or more |
| sure | 85 % to 95 % |
| fairly sure | 70 % to 85 % |
| leaning that way | 55 % to 70 % |
| unsure | under 55 % |

To check a reading:

1. Open a session from [Evidence](/docs/watch), and open its full page.
2. Click **Right** or **Wrong** next to a reading. Or move the focus to the reading and press E (right) or X (wrong).
3. Read the line under the readings, for example "Saved: “Abandoned” was right."

The session beside a list also has **Right** and **Wrong**, on **Came to** and **Outcome** only. In **Workbench** › **Sessions**, the column **The judge’s reading** has them on **Came to**, else on **Outcome**.

A check tells everyone how far the judge can be trusted. It does not judge the session again. The line under the readings counts the readings that you checked in this project. **How often people agree with the judge** opens the part of the **Questions** page that counts the checks of everyone.

A check records the version of the questions that produced the reading. If Sequential no longer knows that version, you cannot check the reading. The page then says "The questions changed since this session was read, so this reading can no longer be checked."

## Limits

- **Background judging can be off.** An owner or admin can switch it off for the project. Your Sequential server can also keep it off for every project. **Ask** and **Try it** on the **Questions** page do not need this switch.
- **Sequential skips short and old sessions.** Sequential never judges a session with fewer than 3 events. System events do not count. Background judging picks up only sessions whose last event is within the past 7 days. Turning it on does not judge older history.
- **There is a daily allowance.** Background judging has its own daily allowance per project. **Ask** and **Try it** each have their own allowance. When the background allowance runs out, Sequential tries the waiting sessions again every hour. The allowance resets each UTC day.
- **Sequential trims long sessions.** The judge reads at most 255 events. See "How long sessions are trimmed" below.
- **Sequential does not retry a failed session.** Sequential retries temporary errors, such as a rate limit, a server error or a network error. Any other error from the judge leaves the session not judged, for good. Evidence shows failed and too-short sessions in **Not judged**.
- **A new question lowers older sessions.** An older judgment scores nothing on a question added after it. So it can come lower in its lane on Evidence.
- **The judge reads only 80 characters of properties.** Sequential cuts the properties of each custom event to 80 characters in total. Put the meaning in the event name.

### Example questions

For example, judging can answer:

- Did the trial user who opened billing add a card, or give up?
- Did an error stop someone finishing checkout, or were they unsure what to do?
- Which of yesterday's sessions does a product manager need to watch first?

### The default questions

The default questions ask:

- **Intent**: what did the person most likely come to do?
- **Outcome**: how did the session end?
- **Friction**: how much friction did the person hit? The levels are **Smooth**, **Minor hesitation**, **Noticeable struggle** and **Severe struggle**.
- Six signals: **Rage clicks**, **Hit an error**, **Product bug**, **Form left unfinished**, **Went in circles** and **Worth watching**.
- Three moments: **Where they struggled**, **What they came to do** and **Where they gave up**.

### What Sequential stores

The table shows what Sequential stores for each kind of question.

| Kind | Example | What Sequential stores |
|---|---|---|
| **Choice** | Intent | A probability for each answer, such as 0.81 for **Buy or subscribe** |
| **Scale** | Friction | A probability for each level |
| **Signal** | Hit an error | The probability of yes. A signal is a yes-or-no question. |
| **Moment** | Where they struggled | The probability that it happened, and the event where it most likely happened. There is no moment if the judge rates it unlikely (under 40 %), or if no event gets at least 25 %. |

The judge writes no prose. Sequential builds the sentences on Evidence and on the session page from these numbers and from the wording of your questions. For example: "Came to use a feature and moved through 6 pages. 2 requests failed, went in circles." See [Reading a verdict](/docs/reading-verdicts).

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
| Identify | Only that the visitor was identified |
| An event from your server ([Backend SDK](/docs/backend-sdk)) | Its name only. An error from your server reads as an error. |

Sequential cuts each name, path, element text or error message to 60 characters.

Sequential reduces every web address in the digest to its path. It removes the host, the query string and the fragment.

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

If the DevTools capture of the recording measured them, the facts also include counts of JavaScript errors, failed requests and console errors.

### Missing counts

Sequential leaves out what it did not measure. It never replaces it with zero.

A session recorded without DevTools capture has no error counts. The default questions tell the judge that a missing count means "not measured". A zero would say "nothing went wrong" and pull the answer the wrong way.

When the recording counted only part of the session, or the recorder dropped entries, the count reads "at least N". A count of zero never reads "at least 0".

### Which label edits count as rewording

The judge does not read weights, question names, or the name of an answer that has criteria. So these changes apply at once, and earlier judgments stay current.

| Change | When it applies |
|---|---|
| Change the name of a question, or the name of an answer that has criteria | At once. |
| Change the **Attention weight** | At once. |
| Rename a level of a scale, or an answer whose criteria are blank | Only to sessions judged afterwards, like a rewording. The judge reads these names. |

### The attention score

Evidence puts judged sessions into lanes. In each lane, the session with the highest attention score comes first. [Evidence](/docs/watch) tells what each lane holds.

To calculate the attention score:

- Each weighted signal adds its weight times the probability of yes.
- Each weighted scale adds its weight times the position of the session on the scale.

The default questions weight **Worth watching** 0.45, **Friction** 0.25, **Hit an error** 0.15 and **Product bug** 0.15. Your weights are in the **Attention weight** field of each signal and scale, on the **Questions** page. Owners and admins change them.

Sequential calculates the score from the stored answers and your current questions each time Evidence loads. So a weight change never needs a new judgment.

The order follows your current questions at once. A removed or turned-off question stops counting for every session. An older judgment scores nothing on a question added after it, so it can come lower.

### Get better judgments

The judge knows only what your events tell it.

- **Name your milestones.** Custom events such as `trial_started` or `invite_sent` show whether someone got what they came for. Put the meaning in the name, because the judge reads only the first 80 characters of the properties. See [Send custom events](/docs/custom-events).
- **Make events readable.** A click with no text, label or id reads as "element". A screen with no path or name reads as "(unnamed screen)". An error needs its message.
- **Record with DevTools capture.** A session can break without sending an error event. Then the DevTools counts of errors and failed requests can be the only sign. See [DevTools in replays](/docs/devtools).
- **Ask answerable questions.** The judge always gives an answer. A guess looks the same as a measurement. Ask whether they opened the docs, not whether they read them carefully.
- **Check the readings.** **Right** and **Wrong** show how often the judge is right for each question. See [Feedback and calibration](/docs/feedback-and-calibration).

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

So if Sequential must drop events, it drops plain clicks first, then custom events. The events it keeps stay in time order.

If the text is still too large for the judge, Sequential retries once with the higher-priority half of the events. That judgment ranks like any other. The session page then says "Read … from N of M events".

## Related

- [Reading a verdict](/docs/reading-verdicts)
- [Questions](/docs/rubric)
- [Evidence](/docs/watch)
- [Ask](/docs/ask)
- [Feedback and calibration](/docs/feedback-and-calibration)
- [AI and third parties](/docs/ai-and-third-parties)
- [DevTools in replays](/docs/devtools)
