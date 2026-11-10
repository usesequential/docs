# Flows: the paths people take

> Flows shows, as a path diagram, the order in which people move between events you choose: what they do after a step, before it, and where they stop.

> **At a glance**
>
> - **For:** Flows shows the routes people take between the events that you add as steps, in any order ([example questions](#what-questions-can-flows-answer)).
> - **Before you start:** One user id for each person, and [events with exact values](#what-it-needs). For `/pricing`, use Page, not URL is.
> - **Default:** Window: the last 14 days, in whole UTC days, today included.
> - **Know this:** Each person has one path for the whole window. Flows does not keep visits apart.
> - **Know this:** If a path ends before the last column, the person did none of your steps again before the end of the window. They can still have used your product in that time.

> **In short**
>
> - Flows sees only the events that you add as steps. Flows does not measure the time between steps.
> - An event counts toward every step that it matches. A step that repeats right after itself counts once.
> - A [funnel](/docs/funnels) checks one route that you already expect. It shows the average time between steps and who left.

## Build a flow

1. In the left rail, go to **Workbench › Flows**.

   Result: With no steps in the address, Sequential picks up to 6 pages as steps ([which pages](#which-steps-does-flows-pick-when-you-open-it)).

2. At **Window**, click 7 days, 14 days, 30 days or 90 days.

   Result: The default is 14 days.

3. At **Steps**, click **Add a step**.

4. Type a page, such as `/pricing`, or an event name.

5. Pick it under **Pages** or **Events**.

6. Add the other steps in the same way.

   Result: There is no Run button. The flow runs a short time after each change. The results appear under the steps.

| To | Do this |
|---|---|
| Use two days of your own | Click Custom. |
| Use the text exactly as you typed it | Pick it under As typed. Text that starts with `/` is a page. |
| Build a step from conditions | Pick Conditions of your own… to open the step's filter bar. |
| Use a saved filter as a step | Click Step from saved filter. It copies the conditions of the filter into a new step. |
| Change the conditions of a step | Click the step. Its filter bar opens. |
| Remove a step | Click the × next to it. |
| Move a step one place | Click its Move earlier or Move later arrow. The flow then runs again with the new order. |
| Let one step catch any of several events | Set its selector to Any of. The default is All of. |

### Use a saved filter as a step

- To swap the conditions of a step for a saved filter, click Replace with saved filter in the editor of the open step. On a step that already has conditions, it asks first, with Replace or Cancel.
- The menu lists the saved filters of the project, newest first. Type to narrow it.
- A filter that cannot be a step is grey, with the reason. The table lists the reasons.
- A later change to the saved filter does not change the step.
- Under a step that came from a saved filter, a line says "From saved filter:" and the name of the filter. It adds "edited" when you changed the conditions of the step after the copy, and "view changed" when someone changed the conditions of the saved filter.
- Update from view reads the saved filter again and gives the step its current conditions. It is off, with the reason when you hold the pointer on it, while the saved filters load, when the saved filter no longer exists, or when the filter can no longer be a step.
- If you edited the step, Sequential asks first. The table has the question.

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Only saved filters can be steps" | The saved-filter menu (Step from saved filter or Replace with saved filter) | A filter that cannot be a step is grey, with this reason. | — |
| "No conditions yet" | The saved-filter menu (Step from saved filter or Replace with saved filter) | A filter that cannot be a step is grey, with this reason. | — |
| "Too large to use as a step" | The saved-filter menu (Step from saved filter or Replace with saved filter) | A filter that cannot be a step is grey, with this reason. | — |
| "Uses a filter the Workbench cannot read yet" | The saved-filter menu (Step from saved filter or Replace with saved filter) | A filter that cannot be a step is grey, with this reason. | — |
| "This step was edited after it was copied. Replace it with the saved filter’s current conditions?" | Update from view, on a step that you edited | You edited the step, so Sequential asks first. | Click Replace, or Keep my edits. |

### Step conditions

- The diagram shows the page or event name of a step. For a step with other conditions, it shows the conditions in words.
- To pick a value from the stored values, click the value box.
- By default, a step matches only if all its conditions match. With two or more conditions, the selector at the start of the bar reads All of. Two Event conditions with is and different values then match nothing.
- Sequential ignores a condition with no value.
- A flow has at most 12 steps. The first step has no Move earlier. The last step has no Move later.
- A step with no conditions, or only unfinished ones, shows Any event. It matches every event.
- The sentence under the bar says the step in words. It also names each condition that it leaves out until you finish it.

## Read the results

The sentence at the top names the most common path. It says how many people took it, of all the people with a path.

Each column of the diagram is a position in people's paths: the first of your steps that each person did, then the next, and so on. Step 2 at the top of a column means the second position in the person's path, not the second step in your list.

Each step in a column is a thin bar. Its height is the number of people. The width of a band is the number of people who went that way.

- Paths (Top 5 / Top 10 / Top 20) sets how many of the most common paths the diagram draws.
- Columns sets how many columns the diagram draws: 3, 4, 5, 6 or 8. A longer path is cut after the last column.
- With fewer than 30 people, the page says "That is few people, so read these shares as a rough guide."
- For the exact figures of each path, click Table, or press `t`.
- To see what comes before a step, find it in the Path column of the table and read to its left.

If your flow looks wrong, see [Why does my flow look wrong?](#why-does-my-flow-look-wrong).

### Read a flow in words

Under the definition, open Explain in words. It says the whole flow in sentences: how a path follows the events of a person over the dates (a step that repeats right after itself counts once), each step, after how many columns a path is cut, and how many paths the diagram draws. The table adds up the other paths in one row, “Other paths”.

### Flow tables

| Column or table | What it shows |
|---|---|
| Path | One of the most common paths in full |
| People | The people who took that path |
| Share | Those people as a part of all the people with a path. When you follow one step, it is a part of the people at that step |
| Other paths | The paths that the diagram does not draw, with their people |
| People per step | For each step, the people with at least one event that matches it: People with a matching event |
| Sessions | Opens Workbench › Sessions with the sessions that had those steps |

### Diagram details

- The bands between columns show who went from which step to which.
- One column can hold several of your steps. One step can appear in several columns.
- Hover over a band to see how many people went that way.
- Sessions on a row looks at one session at a time, in any order. So its sessions are not exactly the people on that path.
- In Workbench › [Funnels](/docs/funnels), Who left lists the people who left at a drop. These people reached one of your steps, in your order, but not the next step.

## Follow the people at one step

1. Click a step in the diagram.

   Result: The page follows only the people at that step. The sentence then says how many people were there, and their most common path.

2. To show everyone again, click **Show everyone, not only those at …**.

## Save and share a flow

1. At the bottom of the page, under **Saved flows**, type a name. Type nothing to use the steps as the name.

2. Click **Save this flow**.

Result: A saved flow keeps the steps, the columns, the paths and the window, not the followed step. Everyone in the project sees it. Viewers can open saved flows but not save, rename or delete them.

To copy the address of the flow, click Copy link, or press `l`.

## How it works

Each step is a filter. Sequential builds one path for each person from the events that match your steps, for example Pricing → Checkout → Pricing → Upgraded. Sequential then counts how many people share each path.

### How a path is built

For each person with a matching event in the window, Sequential does this:

1. It takes the person's matching events, oldest first.
2. It labels each event with every step that the event matches, in step order. An event that matches steps 1 and 2 gives 1, then 2.
3. If the same step comes two times in a row, it keeps only one.

Each step uses the same filter bar as the other Workbench views. See [Filters, date ranges and saved views](/docs/filters-and-saved-views).

- Each person has one path for the whole window. Flows does not keep visits apart. Pricing on Monday and checkout on Friday is the path Pricing → Checkout. To focus on recent behaviour, shorten the window.
- A path starts at the first of your steps that the person did. This is not always Step 1.
- A person is one user id, exactly as stored. With the Sequential SDK, PostHog or Mixpanel, an anonymous id that identify links to a value counts as that value. See [User ids and identity](/docs/users-and-identity).
- Flows does not limit how long the next step can take.

An event that matches two steps is in both. From 9 October 2026, a flow whose steps can match the same event can show longer paths than before. Before that date, an event went only to the first step that it matched.

The agent tool `user_flows` uses the same rule, and its count for each step is the number of people with an event that matches that step.

## What it needs

- One user id for each person. Pass the same value to identify for the same person every time. See [Identify your users](/docs/identify-users).
- Events that you can tell apart by an exact value. Custom events with fixed names, such as `checkout_started`, make the clearest steps. See [Send custom events](/docs/custom-events).
- A URL condition with is must match the whole address, such as `https://app.example.com/pricing`. A path alone, such as `/pricing`, matches nothing there. For a path, use Page. See [What Sequential keeps from page URLs](/docs/url-policy).

### User ids and anonymous events

Without identify, each browser or device is a separate person. What happens to a person who signs up during the window depends on the source:

| Source | A person who signs up during the window |
|---|---|
| Sequential SDK, PostHog or Mixpanel | Flows joins the events sent before identify to the identified person. So the person has one path, and counts once at each step. |
| Amplitude, Pendo or Smartlook | That person shows as two paths. One path ends at signup and the other path starts there. |

- Call identify as soon as you know who the person is. Also call it on page load for users who are already signed in.
- Events sent before your app calls identify carry an anonymous id. With the Sequential SDK, PostHog or Mixpanel, Flows joins them to the identified person, also when the person identifies after the window. So the result for a past period can change. A new identity link can take up to 5 minutes to apply.
- Events with no user id are not a person. They are in no path and in no step count.

### Values that a step can match

- Event type takes the stored type, such as `pageview`. See [Events](/docs/events).
- Page matches the route, like `/invoices/:id`. A step that you type with `/` at the start is a Page step.
- A URL condition with is must match the whole stored address, with the scheme and host. For example: `https://app.example.com/projects/123`.
- `/projects/123` alone matches no URL with is. Each project's address is a separate value.
- Sequential drops anything after `#`, except a hash route that starts with `#/` or `#!/`, such as `#/orders`, from 9 October 2026. The route ends before its first `?`, `&` or a second `#`. It stores most query values as `[redacted]`. See [What Sequential keeps from page URLs](/docs/url-policy).
- A condition with is, such as URL is …, matches one whole value. Fields also take contains, starts with, ends with and matches pattern.
- Event property matches an event's own properties, with a type and an operator. So a step can be `upgraded` with `plan` is `pro`, or `checkout_completed` with `amount` is more than `100`.
- If "upgraded to Pro" and "upgraded to Team" must be separate steps, send separate event names.

## FAQ

### What questions can Flows answer?

Flows shows the routes people actually take between a few events that you choose, with loops and detours. Flows answers "which of these came next", not "what did they do next" across all the events your product records.

- What happens after pricing? Of the people who view your pricing page, how many start checkout, how many book a demo and how many do neither?
- Do people follow onboarding as designed? Do new people go Create project → Invite teammate → Connect data? Or do they invite first, or go back and forth?
- What comes before an upgrade? Did people who upgraded reach a plan limit first, open billing settings first or both?
- Where do people stop? After which of these steps does nothing more happen?

### Why does my flow look wrong?

| Symptom | Cause | Fix |
|---|---|---|
| A step with a URL condition and a path, such as /pricing, matches nothing | A URL condition with is must match the whole address. A path alone matches nothing there. | For a path, use Page. |
| A step with two Event conditions with is and different values matches nothing | By default, a step matches only if all its conditions match. Two Event conditions with is and different values then match nothing. | — |
| Each browser or device shows as its own path | Without identify, each browser or device is a separate person. | Call identify as soon as you know who the person is. |
| A person who signs up during the window shows as two paths | With Amplitude, Pendo or Smartlook, one path ends at signup and the other path starts there. | — |
| The flow stops with Internal Server Error and Try again | A flow that runs longer than the 30-second time limit stops this way. | Shorten the window or make the steps more specific. |

### Which steps does Flows pick when you open it?

When you open Flows and its address has no steps, Sequential picks up to 6 pages as steps. These are the pages that the most people viewed in the last 30 days. Sequential looks only at the 1,000 pages with the most views, and picks among them. With fewer than two pages, it picks the custom events that the most people sent. While it picks them, the page says "Choosing as steps the pages that the most people viewed, from up to 1,000 pages with the most views…".

When you switch to another project, the flow runs again at once for that project, and the answer of the other project does not show. If the steps are still the ones that Sequential picked, it picks them again for the new project. Steps that you chose, or that came with a link, stay.

### Why does Flows show "No events yet"?

Your project has not sent an event or a recording yet. The page shows "No events yet" in place of the steps. It says, for example, "Acme hasn’t sent any events yet. Once it does, you can map the paths people take between the steps you choose." The button, such as Set up Acme, opens Settings › Setup. The keys `r` (run again) and `t` (diagram or table) then do nothing. Copy link still works. If Sequential cannot read the status of the project, the page shows the steps as usual.

### What happens while the flow runs again?

A short time after you change the steps or the window, the flow runs again. Columns, Paths and a followed step change only the drawing. They do not run the flow again. While the flow runs again, the old result stays dimmed, with "Following them again for the new steps…". To run the flow again with no change, press `r`.

### What can viewers do, and what does a link keep?

Every role in your organisation can run flows. See [Roles and permissions](/docs/roles-and-permissions).

Viewers can open saved flows but not save, rename or delete them. See [Save and open views](/docs/filters-and-saved-views#save-and-open-views).

The address holds the steps, the columns, the paths, the followed step and the window. When you copy it, the page says "Link to these flows copied." See [Filters, date ranges and saved views](/docs/filters-and-saved-views).

## Limits

| Limit | What happens |
|---|---|
| At most 12 steps | The page says "At most 12 steps: more paths than that cannot be read." |
| At most 8 columns | The diagram draws no more than 8 columns. |
| 30-second time limit | A longer flow stops with "Internal Server Error" and Try again. Shorten the window or make the steps more specific. |
| No list of people | Flows does not list the people behind a path. |

## Next steps

- [Funnels](/docs/funnels): check one route, and see who left.
- [Identify your users](/docs/identify-users): give each person one user id.
- [User ids and identity](/docs/users-and-identity): how anonymous ids join a person.
- [Send custom events](/docs/custom-events): send events with fixed names.
- [Filters, date ranges and saved views](/docs/filters-and-saved-views): the filter bar of each step.
