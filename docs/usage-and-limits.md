# Usage and session limits

> See how many sessions your organisation used this month, what happens when it reaches its session limit, and how to get more sessions.

## What it is for

Each organisation has a number of sessions for each calendar month, in UTC. On the hosted preview, the number is 5,000. All the projects of the organisation share it. The preview takes no payments.

From 15 October 2026, a new organisation also has a daily number in its first 30 days: 500 sessions per UTC day, for all its projects together. This applies on the free tier, unless Sequential support set the organisation's limits. When the organisation reaches it, Sequential handles new sessions as at the monthly number, until the next UTC day.

## Read your usage

Owners, admins and members see the usage in two places:

- **Settings** › **Organisation**, in the section **Usage this period**, with **By project**;
- the page **Get more sessions**, under **This period**. To open it, click **Get more sessions** in the rail.

The usage shows:

- the line "<organisation> recorded about N of 5,000 sessions this period (N %)." and a bar;
- on **Get more sessions**, a label such as "4,200 left". From 80 % it says "Close to the limit". At the limit it says "Limit reached";
- the line "This period runs from 1 Oct to 31 Oct; the count starts again on 1 Nov.";
- the line "Counts are approximate." and how Sequential counts sessions.

On **Organisation**, viewers see "Owners, admins and members see usage; viewers do not." If Sequential cannot count the sessions, the usage says "Sequential could not count this period’s sessions just now: at least N of the 5,000 included were recorded."

**By project**, on the **Organisation** page, lists:

- each project that recorded sessions this month, the largest first, with a bar and its sessions;
- **Deleted projects**: the sessions of all deleted projects together, with no name;
- **Not split by project**: sessions that Sequential counted for the organisation on a day whose counts per project are no longer complete.

The parts add up to the total. If only one project recorded sessions, the section says "All of it came from" and the project name.

### How Sequential counts sessions

- Sequential counts the different sessions of each project for each UTC day on which their data arrives. Then it adds up all the projects of the organisation.
- A session that goes on past midnight UTC counts on both days. So this count can be higher than the session counts on other pages.
- Events that your server sends with the [backend SDK](/docs/backend-sdk) never make a session. So they do not add to the count. An event without a session id does not add to the count either.
- Projects that you deleted still count for the days they had sessions. Deleting a project does not lower the count.
- The month starts at 00:00 UTC on the first day.

## At 80 % and at the limit

- **From 80 %**, the usage says "Close to the limit: at 5,000 sessions, recording stops until 1 Nov." The owners and admins with a verified email address get the email "<organisation>: 80 % of this month's sessions are used".
- **At the limit**, the usage says "The limit is reached: new sessions are not recorded until 1 Nov." The owners and admins get the email "<organisation>: this month's sessions are used".
- Sequential sends each email once a month. If the organisation goes from under 80 % to the limit within an hour, only the second email goes out.

At the limit, Sequential refuses all the data that the organisation's projects send, with 402 `billing_limit_reached`. This includes the sessions that are recording at that time.

- The recorder and the Sequential SDK stop for the rest of the page. On the next page, the recorder does not start. The SDK tries once, and stops again.
- The data that you sent before the limit stays, and your reports work as before.
- Recording starts again at 00:00 UTC on the first day of the next month. A page that is open stays stopped until it loads again.

## Need more sessions?

Reply to the email, or write to support@usesequential.com. Sequential support can set a larger number for your organisation, also for a limited time. You can also [share your experience](#share-your-experience).

## Limits

- **The count is approximate.** The usage can be about a minute behind.
- **An organisation can go a little over.** Sequential can accept data for up to about 3 minutes after the limit. How much more it accepts depends on your traffic in that time.
- **If Sequential cannot read the count**, it keeps its last decision for up to 30 minutes. After that, it accepts data until it can read the count again.

## Share your experience

Write a LinkedIn post about your experience with Sequential, and send us the link. When we find the post, your organisation gets 15,000 sessions a month for 90 days, in place of 5,000. These are the server defaults.

- Any honest post counts, good or bad. We do not read your text before you post it, and we do not ask you to change it. **Get more sessions** has a template to start from, with **Copy the text**, but you can use your own words.
- The offer **Share your experience on LinkedIn** is on the page **Get more sessions**, under **Ways to get more**. To open it, click **Get more sessions** in the rail. Every role sees this item. The offer is also on **Settings** › **Organisation**, in the section **Share your experience**. When the offer is off on the server, both places say "The share offer is switched off on this server." Owners and admins send the link. Other members see the offer and its status, with "Owners and admins send the link; you are a member. Ask one of them to send it." On **Get more sessions**, a viewer sees "Viewers do not see the offers or the billing of <organisation>. An owner or admin decides how it gets more sessions." When the offer is not open to your organisation for another reason, the page says "The share offer is not open to <organisation> now."
- The link must be a LinkedIn post that starts with `https://www.linkedin.com/posts/` or `https://www.linkedin.com/feed/update/`. From 13 October 2026, LinkedIn's short link from **Copy link** works too: `https://lnkd.in/` and a code, or `https://lnkd.in/p/` and a code.
- A person at Sequential opens the post and checks it before your organisation gets the sessions: "A person at Sequential opens the post within a few working days; you hear back by mail." Sequential's servers do not open the link.
- Each organisation can get the reward one time, and can send at most 3 links in total.
- The offer closes for everyone after 100 organisations get the reward. Then the offer says "The share offer is closed: every reward has been given."
- If your organisation already has at least as many sessions for at least as long, nothing changes: "Thank you. Your organisation already has this many sessions or more, so nothing changed."
- The reward ends at the end of the UTC day, 90 days after we give it. Then your organisation goes back to the normal monthly limit.
- **Get more sessions** also has **Ask Sequential**: "Need more than these give? Write to support@usesequential.com with what you record and how much; a person answers." The address opens an email with the subject "More sessions".

If we cannot accept the post, the offer says "We could not accept the post:" and one of these reasons. You can then send a new link, while you have links left.

| The offer says | What it means |
|---|---|
| we could not find the post at this link. | The link does not open a post. |
| the post is not visible to everyone. | The post is not public. |
| the post is not about Sequential. | The post does not talk about Sequential. |

We never decline a post because of its opinion.
