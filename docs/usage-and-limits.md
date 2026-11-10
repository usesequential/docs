# Usage and session limits

> Each organisation has a monthly session limit. See how many sessions it used this month, what happens at the limit, and how to get more.

> **Key facts**
>
> - On the hosted preview, the monthly session limit of each organisation is 5,000. All its projects share it.
> - At 80 % and at the limit, owners and admins can get an email ([who and when](#at-80-and-at-the-limit)).
> - At the limit, recording stops. New pages record again from 00:00 UTC on the first day of the next month.
> - The data that you sent before the limit stays, and your reports work as before.
> - To get more, write to support@usesequential.com, or [share your experience](#share-your-experience) on LinkedIn: 15,000 sessions a month for 90 days.

## Monthly and daily limits

| Limit | Value | Applies to | Who can change it | What happens at the limit |
|---|---|---|---|---|
| Monthly limit | 5,000 sessions on the hosted preview | Each organisation, per calendar month in UTC | Sequential support ([Need more sessions?](#need-more-sessions)) | Recording stops ([At 80 % and at the limit](#at-80-and-at-the-limit)) |
| Daily limit | 500 sessions per UTC day, for all its projects together | From 15 October 2026, a new organisation in its first 30 days, on the free tier | Sequential support: when it set the organisation's limits, the daily limit does not apply | Sequential handles new sessions as at the monthly limit, until the next UTC day. |

The preview takes no payments.

## Read your usage

Owners, admins and members see the usage bar in two places:

- In Settings › Organisation › Usage this period. Its By project part splits the count by project.
- In Get more sessions › This period. Open Get more sessions in the rail.

The count can be higher than the session counts on other pages. [How Sequential counts sessions](#how-sequential-counts-sessions) says why.

### How Sequential counts sessions

- Sequential counts the different sessions of each project for each UTC day on which their data arrives. Then it adds up all the projects of the organisation.
- A session that goes on past midnight UTC counts on both days. So this count can be higher than the session counts on other pages.
- Events that your server sends with the [backend SDK](/docs/backend-sdk) never make a session. So they do not add to the count. An event without a session id does not add to the count either.
- Projects that you deleted still count for the days they had sessions. Deleting a project does not lower the count.
- The month starts at 00:00 UTC on the first day.

### How exact the count is

- The count is approximate. The usage can be about a minute behind.
- An organisation can go a little over. Sequential can accept data for up to about 3 minutes after the limit. How much more it accepts depends on your traffic in that time.
- If Sequential cannot read the count, it keeps its last decision for up to 30 minutes. After that, it accepts data until it can read the count again.

### How By project splits the count

By project, on the Organisation page, lists:

- each project that recorded sessions this month, the largest first, with a bar and its sessions;
- Deleted projects: the sessions of all deleted projects together, with no name;
- Not split by project: sessions that Sequential counted for the organisation on a day whose counts per project are no longer complete.

The parts add up to the total. If only one project recorded sessions, the section says "All of it came from" and the project name.

### Messages on the usage bar

What the usage bar says in Settings › Organisation and in Get more sessions, and what a viewer sees in its place. The dates in the lines are an example month. The last row is the Ask Sequential line on Get more sessions.

| Message | Where | What it means | What to do |
|---|---|---|---|
| "<organisation> recorded about N of 5,000 sessions this period (N %)." | Both places, with a bar | The sessions used this period. | — |
| "4,200 left" | Get more sessions | A label such as this one, under 80 %. | — |
| "Close to the limit" | Get more sessions | From 80 %. | — |
| "Limit reached" | Get more sessions | At the limit. | — |
| "This period runs from 1 Oct to 31 Oct; the count starts again on 1 Nov." | Both places | The period line. | — |
| "Counts are approximate." | Both places | The usage bar shows this line, and how Sequential counts sessions. | — |
| "Sequential could not count this period’s sessions just now: at least N of the 5,000 included were recorded." | — | Sequential cannot count the sessions. | — |
| "Owners, admins and members see usage; viewers do not." | Settings › Organisation, for viewers only | What viewers see in place of the usage bar. | — |
| "Need more than these give? Write to support@usesequential.com with what you record and how much; a person answers." | Get more sessions › Ask Sequential | How to ask Sequential support for more sessions. The address opens an email with the subject "More sessions". | — |

## At 80 % and at the limit

| Point | The usage bar says (example date) | Email | Who gets the email |
|---|---|---|---|
| From 80 % | "Close to the limit: at 5,000 sessions, recording stops until 1 Nov." | "<organisation>: 80 % of this month's sessions are used" | The owners and admins with a verified email address |
| At the limit | "The limit is reached: new sessions are not recorded until 1 Nov." | "<organisation>: this month's sessions are used" | The owners and admins |

Sequential sends each email once a month. If the organisation goes from under 80 % to the limit within an hour, only the second email goes out.

> **What stops at the limit**
>
> At the limit, Sequential refuses all the data that the organisation's projects send. This includes the sessions that are recording at that time.

### For developers: what the recorder and the SDK do

- Sequential refuses the data with 402 `billing_limit_reached`.
- The recorder and the Sequential SDK stop for the rest of the page. On the next page, the recorder does not start. The SDK tries once, and stops again.
- Recording starts again at 00:00 UTC on the first day of the next month. A page that is open stays stopped until it loads again.

Other refusals and their fixes: [Troubleshooting](/docs/troubleshooting).

## Need more sessions?

Reply to the email, or write to support@usesequential.com. Sequential support can set a larger limit for your organisation, also for a limited time. Get more sessions › Ask Sequential gives the same address.

## Share your experience

When Sequential finds your LinkedIn post, your organisation gets 15,000 sessions a month for 90 days, in place of 5,000. These are the server defaults.

1. Write a LinkedIn post about your experience with Sequential. Any honest post counts, good or bad.

2. Copy the link of the post.

3. Click **Get more sessions** in the rail.

4. In **Ways to get more › Share your experience on LinkedIn**, send the link. A member asks an owner or admin to send it.

Result: A person at Sequential opens the post within a few working days, and checks it before your organisation gets the sessions. You hear back by mail.

Sequential never declines a post because of its opinion.

### How the share offer works in detail

- Each organisation can get the reward one time, and can send at most 3 links in total.
- The offer closes for everyone after 100 organisations get the reward.
- The reward ends at the end of the UTC day, 90 days after Sequential gives it. Then your organisation goes back to the normal monthly limit.
- If your organisation already has at least as many sessions for at least as long, nothing changes.
- If Sequential cannot accept the post, you can send a new link, while you have links left.
- The offer is also on Settings › Organisation, in the section Share your experience. Every role sees Get more sessions in the rail.
- Get more sessions has a template to start from, with Copy the text, but you can use your own words. Sequential does not read your text before you post it, and does not ask you to change it.

### Links Sequential accepts

- The link must be a LinkedIn post that starts with `https://www.linkedin.com/posts/` or `https://www.linkedin.com/feed/update/`.
- From 13 October 2026, LinkedIn's short link from Copy link works too: `https://lnkd.in/` and a code, or `https://lnkd.in/p/` and a code.
- Sequential's servers do not open the link.

### Messages of the share offer

Owners and admins send the link. Other members see the offer and its status.

| Message | Where | What it means | What to do |
|---|---|---|---|
| "The share offer is switched off on this server." | Both places | The offer is off on the server. | — |
| "Owners and admins send the link; you are a member. Ask one of them to send it." | — | What other members see with the offer and its status. | — |
| "Viewers do not see the offers or the billing of <organisation>. An owner or admin decides how it gets more sessions." | Get more sessions | What a viewer sees. | — |
| "The share offer is not open to <organisation> now." | — | The offer is not open to your organisation for another reason. | — |
| "A person at Sequential opens the post within a few working days; you hear back by mail." | — | A person at Sequential opens the post and checks it. | — |
| "The share offer is closed: every reward has been given." | — | 100 organisations got the reward. The offer is closed for everyone. | — |
| "Thank you. Your organisation already has this many sessions or more, so nothing changed." | — | Your organisation already has at least as many sessions for at least as long. | — |
| "We could not accept the post:" | — | Sequential cannot accept the post. One of the reasons in the next table follows. | You can then send a new link, while you have links left. |

| The offer says | What it means |
|---|---|
| we could not find the post at this link. | The link does not open a post. |
| the post is not visible to everyone. | The post is not public. |
| the post is not about Sequential. | The post does not talk about Sequential. |

## Related pages

- [Limits and defaults](/docs/limits): the other limits of Sequential.
- [Roles and permissions](/docs/roles-and-permissions): what each role can do.
