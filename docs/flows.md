# Flows: the paths users take

> Flows shows, as a path diagram, the order in which people move between events you choose: what they do after a step, before it, and where they stop.

> **In short**
>
> - Flows shows the routes people take between the events that you add as steps, in any order.
> - Each user has one path for the whole date range.
> - An event counts toward every step that it matches.
> - Flows needs one user id for each person and events with exact values.

## What it is for

A funnel checks one route that you already expect. Flows shows the routes people actually take between a few events that you choose, with loops and detours. Flows sees only the events that you add as steps.

### Example questions

Flows answers "which of these came next", not "what did they do next" across all the events your product records.

- **What happens after pricing?** Of the users who view your pricing page, how many start checkout, how many book a demo and how many do neither?
- **Do users follow onboarding as designed?** Do new users go Create project → Invite teammate → Connect data? Or do they invite first, or go back and forth?
- **What comes before an upgrade?** Did users who upgraded hit a plan limit first, open billing settings first or both?
- **Where do users stop?** After which of these steps does nothing more happen?

## How it works

Each step is a filter. Sequential builds one **path** for each user from the events that match your steps, for example Pricing → Checkout → Pricing → Upgraded. Sequential then counts how many users share each path.

### How a path is built

For each user with a matching event in the date range, Sequential does this:

1. It takes the user's matching events, oldest first.
2. It labels each event with every step that the event matches, in step order. An event that matches steps 1 and 2 gives 1, then 2.
3. If the same step comes two times in a row, it keeps only one.

Each step uses the same filter bar as the other Workbench views. See [Filters, date ranges and saved views](/docs/filters-and-saved-views).

- **Each user has one path for the whole date range.** Flows does not keep visits apart. Pricing on Monday and checkout on Friday is the path Pricing → Checkout.
- **A path starts at the first of your steps that the user did.** This is not always Step 1.
- **A user is a person.** It is the user id, exactly as stored. With the Sequential SDK, PostHog or Mixpanel, an anonymous id that identify links to a value counts as that value. See [Users and identity](/docs/users-and-identity).
- **Flows does not limit how long the next step can take.**

## Build a flow

1. In the left rail, click **Workbench**, then click **Flows**.
2. At **Window**, click **7 days**, **14 days**, **30 days** or **90 days**. For two days of your own, click **Custom**.
3. At **Steps**, click **Add a step**. To use a saved filter as a step, click **Step from saved filter**. It copies the conditions of the filter into a new step. To swap the conditions of a step for a saved filter, click **Replace with saved filter** in the editor of the open step. The menu lists the saved filters of the project, newest first. Type to narrow it. A filter that cannot be a step is grey, with the reason: "Only saved filters can be steps", "No conditions yet", "Too large to use as a step" or "Uses a filter the Workbench cannot read yet". A later change to the saved filter does not change the step. Under a step that came from a saved filter, a line says "From saved filter:" and the name of the filter. It adds **edited** when you changed the conditions of the step after the copy, and "view changed" when someone changed the conditions of the saved filter. **Update from view** reads the saved filter again and gives the step its current conditions. It is off, with the reason when you hold the pointer on it, while the saved filters load, when the saved filter no longer exists, or when the filter can no longer be a step. If you edited the step, Sequential asks first: "This step was edited after it was copied. Replace it with the saved filter’s current conditions?" Click **Replace**, or **Keep my edits**. **Replace with saved filter** on a step that already has conditions asks too, with **Replace** or **Cancel**.
4. Type a page, such as `/pricing`, or an event name. Pick it under **Pages** or **Events**.
5. To use the text exactly as you typed it, pick it under **As typed**. Text that starts with `/` is a page.
6. To build a step from conditions, pick **Conditions of your own…**. The step's filter bar opens.
7. Add the other steps in the same way.
8. The flow runs a short time after each change. The results appear under the steps.

The default window is the last 14 days, in whole UTC days, today included. A flow has at most 12 steps.

When you open **Flows** and its address has no steps, Sequential picks up to 6 pages as steps. These are the pages that the most people viewed in the last 30 days. Sequential looks only at the 1,000 pages with the most views, and picks among them. With fewer than two pages, it picks the custom events that the most people sent. While it picks them, the page says "Choosing as steps the pages that the most people viewed, from up to 1,000 pages with the most views…". When you switch to another project, the flow runs again at once for that project, and the answer of the other project does not show. If the steps are still the ones that Sequential picked, it picks them again for the new project. Steps that you chose, or that came with a link, stay.

If your project has not sent an event or a recording yet, the page shows "No events yet" in place of the steps. It says, for example, "Acme hasn’t sent any events yet. Once it does, you can map the paths people take between the steps you choose." The button, such as **Set up Acme**, opens Settings › **Setup**. The keys **r** (run again) and **t** (diagram or table) then do nothing. **Copy link** still works. If Sequential cannot read the status of the project, the page shows the steps as usual.

To change the conditions of a step, click the step. Its filter bar opens. To remove a step, click the **×** next to it.

To move a step one place, click its arrow **Move earlier** or **Move later**. The first step has no **Move earlier**. The last step has no **Move later**. The flow then runs again with the new order.

To let one step catch any of several events, switch its selector from **All of** to **Any of**.

An event that matches two steps is in both. From 9 October 2026, a flow whose steps can match the same event can show longer paths than before. Before that date, an event went only to the first step that it matched. The agent tool `user_flows` uses the same rule, and its count for each step is the number of people with an event that matches that step.

## Read a flow in words

Under the definition, open **Explain in words**. It says the whole flow in sentences: how a path follows the events of a person over the dates (a step that repeats right after itself counts once), each step, after how many columns a path is cut, and how many paths the diagram draws. The table adds up the other paths in one row, “Other paths”.

> **When the flow runs again**
>
> There is no **Run** button. A short time after you change the steps or the window, the flow runs again. **Columns**, **Paths** and a followed step change only the drawing. They do not run the flow again. While the flow runs again, the old result stays dimmed, with "Following them again for the new steps…". To run the flow again with no change, press `r`.

### Step conditions

- The diagram shows the page or event name of a step. For a step with other conditions, it shows the conditions in words.
- To pick a value from the stored values, click the value box.
- By default, a step matches only if **all** its conditions match. With two or more conditions, the selector at the start of the bar reads **All of**. Two **Event** conditions with **is** and different values then match nothing.
- Sequential ignores a condition with no value.
- A step with no conditions, or only unfinished ones, shows **Any event**. It matches every event.
- The sentence under the bar says the step in words. It also names each condition that it leaves out until you finish it.

### Keep a flow

To keep a flow for the project, save it under **Saved flows**, at the bottom of the page. Type a name, or type nothing to use the steps as the name. Then click **Save this flow**. A saved flow keeps the steps, the columns, the paths and the window, not the followed step. Everyone in the project sees it. Viewers can open saved flows but not save, rename or delete them. See [Save and open views](/docs/filters-and-saved-views#save-and-open-views).

The address holds the steps, the columns, the paths, the followed step and the window. To copy the address, click **Copy link**, or press `l`. The page says "Link to these flows copied." See [Filters, date ranges and saved views](/docs/filters-and-saved-views).

## Read the results

The sentence at the top names the most common path. It says how many people took it, of all the people with a path.

Each column of the diagram is a position in people's paths: the first of your steps that each person did, then the next, and so on. Each step in a column is a thin bar. Its height is the number of people. The width of a link is the number of people who went that way.

- The diagram draws the most common paths. **Paths** sets how many: **Top 5**, **Top 10** or **Top 20**. The table groups the other paths in one row, **Other paths**.
- **Columns** sets how many columns the diagram draws: 3, 4, 5, 6 or 8. A longer path is cut after the last column.
- A path that ends before the last column means that the person did none of your steps again before the end of the date range. The person can still have used your product in that time.
- With fewer than 30 people, the page says "That is few people, so read these shares as a rough guide."
- For the exact figures of each path, click **Table**, or press `t`.

To see what comes before a step, find it in the **Path** column of the table and read to its left.

To follow only the people at one step, click that step in the diagram. The sentence then says how many people were there, and their most common path. To show everyone again, click **Show everyone, not only those at …**.

### Flow tables

| Column or table | What it shows |
|---|---|
| **Path** | One of the most common paths in full |
| **People** | The people who took that path |
| **Share** | Those people as a part of all the people with a path. When you follow one step, it is a part of the people at that step |
| **Other paths** | The paths that the diagram does not draw, with their people |
| **People per step** | For each step, the people with at least one event that matches it: **People with a matching event** |
| **Sessions** | Opens Workbench › **Sessions** with the sessions that had those steps |

### Diagram details

- The links between columns show who went from which step to which.
- One column can hold several of your steps. One step can appear in several columns.
- **Step 2** at the top of a column means the second position in the person's path, not the second step in your list.
- Hover over a link to see how many people went that way.
- Flows does not list the people behind a path.
- **Sessions** on a row looks at one session at a time, in any order. So its sessions are not exactly the people on that path.
- In Workbench › [Funnels](/docs/funnels), **Who left** lists the people who left at a drop. These people reached one of your steps, in your order, but not the next step.

## What it needs

- **One user id for each person.** Pass the same value to identify for the same person every time. See [Identify your users](/docs/identify-users).
- **Events that you can tell apart by an exact value.** Custom events with fixed names, such as `checkout_started`, make the clearest steps. See [Send custom events](/docs/custom-events).

Without identify, each browser or device is a separate user. With the Sequential SDK, PostHog or Mixpanel, Flows joins the events sent before identify to the identified user. So a visitor who signs up during the date range has one path, and counts once at each step. With Amplitude, Pendo or Smartlook, that visitor shows as two paths.

### User ids and anonymous events

- Call identify as soon as you know who the user is. Also call it on page load for users who are already signed in.
- Events sent before your app calls identify carry an anonymous id. With the Sequential SDK, PostHog or Mixpanel, Flows joins them to the identified user, also when the visitor identifies after the date range. So the result for a past period can change. A new link can take up to 5 minutes to apply.
- With Amplitude, Pendo or Smartlook, for a visitor who signs up during the date range, one path ends at signup and the other path starts there.
- Events with no user id are not a user. They are in no path and in no step count.
- Every role in your organisation can run flows. See [Roles and permissions](/docs/roles-and-permissions).

### Values that a step can match

- **Event type** takes the stored type, such as `pageview`. See [Events](/docs/events).
- **Page** matches the route, like `/invoices/:id`. A step that you type with `/` at the start is a **Page** step.
- A **URL** condition with **is** must match the whole stored address, with the scheme and host. For example: `https://app.example.com/projects/123`.
- `/projects/123` alone matches no **URL** with **is**. Each project's address is a separate value.
- Sequential drops anything after `#`, except a hash route that starts with `#/` or `#!/`, such as `#/orders`, from 9 October 2026. The route ends before its first `?`, `&` or a second `#`. It stores most query values as `[redacted]`. See [What Sequential keeps from page URLs](/docs/url-policy).
- **Event property** matches an event's own properties, with a type and an operator. So a step can be `upgraded` with `plan` **is** `pro`, or `checkout_completed` with `amount` **is more than** `100`.
- If "upgraded to Pro" and "upgraded to Team" must be separate steps, send separate event names.

## Limits

| Limit | What happens |
|---|---|
| No per-visit view | Each user has one path across the whole range. To focus on recent behaviour, shorten the range. |
| No timing | Flows does not measure the time between steps. [Funnels](/docs/funnels) shows the average time between steps. |
| Exact matches with **is** | A condition with **is**, such as **URL** **is** …, matches one whole value. Fields also take **contains**, **starts with**, **ends with** and **matches pattern**. |
| 30-second time limit | A longer flow stops with "Internal Server Error" and **Try again**. Shorten the range or make the steps more specific. |
| Up to 12 steps | The page says "At most 12 steps: more paths than that cannot be read." |
| Up to 8 columns | The diagram draws no more than 8 columns. A longer path is cut after the last column. |
| No list of people | Flows does not list the people behind a path. |
- Events with no user id are in no path.
- A step with no finished condition matches every event.
- A **URL** condition with **is** must match the whole address, such as `https://app.example.com/pricing`. A path alone, such as `/pricing`, matches nothing there. For a path, use **Page**.

## Related

- [Funnels](/docs/funnels)
- [Identify your users](/docs/identify-users)
- [Users and identity](/docs/users-and-identity)
- [Send custom events](/docs/custom-events)
- [Filters, date ranges and saved views](/docs/filters-and-saved-views)
- [What Sequential keeps from page URLs](/docs/url-policy)
