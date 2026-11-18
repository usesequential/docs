# Connect GitHub to Sequential

> Connect a GitHub repository to a project. A pull request that names a case then links itself to the case, and Sequential can open a GitHub issue with the fix brief for your coding agent.

Connect a GitHub repository to a Sequential project. Then:

- A pull request that names a case links itself to the case. You do not paste the link.
- If you turn it on, Sequential can open a GitHub issue with the [fix brief](/docs/findings#hand-off-a-case) of a case, for your coding agent. Your agent, for example the Claude Code action, then writes the fix and opens the pull request. Sequential writes no code and opens no pull request.

Sequential connects to GitHub.com only. It does not connect to GitHub Enterprise Server, ghe.com, GitLab or Bitbucket.

## Connect a repository

Only an owner or an admin of the Sequential organisation can connect a repository. You must also be an admin of the repository on GitHub. Other roles see "Your role cannot change the GitHub connection. Ask an owner or admin."

1. Go to **Settings › Project › GitHub**.

   Result: It says "GitHub is not connected. Connect it, and a pull request that names a case links itself to the case. You can also let Sequential open an issue for your agent."

2. Click **Connect GitHub**.

   Result: GitHub asks you to install the Sequential GitHub app (usesequential). Its name on GitHub is usesequential.

3. On GitHub, install the app on the account or organisation of the repository.

4. Back in Sequential, under "Pick the repositories for this project", select the repositories. "The list shows only the repositories that you administer on GitHub."

5. Click **Connect 1 repository** (or the number that you picked).

   Result: For example: "1 repository is connected to this project."

What the app can do, as the page says: "The app can read pull request data, which on GitHub includes diffs. Sequential reads the title, the description, the author’s role and the merge state, and asks GitHub whether the author can push to the repository. It makes no call for diffs or files. The app can open issues. It has no permission to change your code."

If you are not an owner of the GitHub organisation, GitHub asks an owner to approve the app first. The page then says: "Nothing is connected yet. An owner of the GitHub organisation must approve the Sequential GitHub app (usesequential). After the approval, start again on this page. The app is then already installed on GitHub."

## Pull requests link themselves

In the title or the description of a pull request, name the case:

- A closing word and the case id, for example "Fixes F-12" or "Closes F-3, F-4 and F-5".
- Or a line of its own: `Sequential-Finding: F-12`.

When one repository is connected to more than one project, write the project key before the number, for example "Fixes web#F-12". The key is the slug of the project. On such a repository, an id with no key links nothing.

The pull request then shows on the case, and its state follows GitHub: the case timeline says, for example, "GitHub linked a pull request" and "GitHub saw the pull request merged". **Check now** on the link reads GitHub again: "Read from GitHub just now."

To measure the fix, Sequential still needs a release that names the case. See [Mark a release](/docs/findings#mark-a-release).

### Which pull requests Sequential trusts

A pull request links itself when one of these holds, in this order:

1. GitHub shows its author as an owner, a member or a collaborator of the repository.
2. The pull request answers an issue that Sequential opened for the case in that repository, while the repository is private.
3. The author is a person, not a bot, and GitHub confirms that the author can push to the repository: admin or write permission.

Any other pull request is a suggestion. It changes nothing until a person accepts it. The case shows "A pull request names this case" and "Sequential could not confirm that its author can push to the repository, so it is not linked. Accept it to link it." Click **Accept** or **Remove**. A viewer reads "An owner, admin or member can accept it."

Rule 3 matters for members whose membership of the GitHub organisation is private, which is GitHub's default: GitHub then does not show them to the app as members, so rule 1 does not hold for them.

A pull request that was opened before the repository was connected to the project makes no new link.

A pull request that is closed without a merge no longer counts as the fix of the case. A suggestion that is closed has no **Accept**. In the audit log, GitHub's entry then says, for example, "GitHub linked a pull request to a case, but the pull request was closed without a merge."

A link that is not a suggestion does not say that the change is merged. An agent that reads such a link with no merge gets this note (`trust_note`): ""trusted" says that this link is not a suggestion. It does not say that the change is merged or released. merged_at is null: Sequential has no record of a merge for this link." For a link to a commit or an issue, the note ends: "merged_at is always null on a link that is not a pull request."

## Let Sequential open issues for your agent

For each connected repository, the switch **Sequential may open issues here** is "Off until you turn it on. An issue opens only when a person clicks on a case." Any owner or admin of your Sequential organisation can change it.

- Sequential opens issues only in private repositories: "This repository is public. Sequential opens issues only in private repositories, because a brief can hold text seen in your visitors’ sessions."
- In an archived repository: "This repository is archived. GitHub accepts no new issues in it."
- If the app is suspended on GitHub: "The Sequential GitHub app (usesequential) is suspended on GitHub. Sequential opens no issue here until it is unsuspended."
- If a repository becomes public later, Sequential turns the switch off and replaces the text of the issues it opened there. "GitHub keeps the edit history of an issue": an earlier text can stay readable there, and a repository admin can delete it.

### The agent line

Under **Agent line**, choose what ends each issue:

- **None**: "The issue opens. A person starts the agent." No agent starts by itself.
- **Claude Code action**: Sequential adds the line `@claude fix this issue. Follow the brief exactly.` at the end of the issue.

For the Claude Code action, the page gives two lines to add to your workflow. They go under `with:` of the Claude Code action step:

```
allowed_bots: "usesequential"
claude_args: '--allowedTools "Bash(gh pr create:*)"'
```

- The first line lets issues from Sequential start your agent. "Name only this bot. Never use "*". With "*" on a public repository, any GitHub App can start your agent."
- The second line lets the Claude Code action open the pull request. "Without the second line, the Claude Code action pushes a branch and gives a “Create PR” link, and a person opens the pull request."
- Your workflow must also start when an issue opens: under `on:`, `issues` with `types: [opened]`. Check that your workflow file has it. A workflow that starts only on comments does not start for an issue that Sequential opened. To set up the Claude Code action, see [Claude Code GitHub Actions](https://code.claude.com/docs/en/github-actions).

## Open an issue from a case

On an open case at the stage New, or Handed off with no link and no hand-off in the last 7 days, an owner or an admin gets **Open an issue for your agent**. It shows only when a connected repository allows issues, is private, is not archived, and the app is not suspended on it. When two or more repositories allow issues, you choose one.

- The issue holds the screened fix brief of the case. A longer issue than 60,000 characters is refused: "No issue was opened. The brief is longer than 60,000 characters, and Sequential never cuts a brief."
- The case then says "Issue opened:" with the link, and "When a pull request names this case, it links itself here."
- When an agent asks to take a case, an owner or an admin can also answer with **Approve: open an issue**.
- Each project has 20 hand-offs to an agent a day. Issues that Sequential opens, webhook hand-offs and the test ping on Settings use one counter. Copy brief and Write a GitHub issue yourself do not count. At the limit: "This project has reached today's limit of hand-offs to an agent. Try again tomorrow."

The button that opens a new issue in your browser, with the brief in the link, is **Write a GitHub issue yourself**. It works without a connection. See [Hand off a case](/docs/findings#hand-off-a-case).

## Disconnect

On Settings › Project › GitHub, click **Disconnect** on the repository. Sequential asks, for example, "Disconnect acme/web? Pull requests there stop linking to cases, and Sequential opens no issues there." Click **Disconnect**, or **Keep**.

To remove the app from GitHub, use **Open the app on GitHub**.

### Messages when you connect GitHub

| Message | Where | What it means | What to do |
|---|---|---|---|
| "Nothing was connected. You are not an admin of a repository in this installation. Ask a GitHub admin of the repository to connect it." | Settings › Project › GitHub | You picked an installation where you administer no repository. | — |
| "Nothing was connected. GitHub shows no repository that you administer and that has the Sequential GitHub app (usesequential). Install the app on the GitHub account of the repository, or ask a GitHub admin of the repository to connect it." | Settings › Project › GitHub | The app is not on the GitHub account of a repository that you administer. | — |
| "Nothing is connected yet. An owner of the GitHub organisation must approve the Sequential GitHub app (usesequential). After the approval, start again on this page. The app is then already installed on GitHub." | Settings › Project › GitHub | The organisation on GitHub must approve the app. | — |
| "GitHub was not connected. The start was more than 10 minutes ago, or it was cancelled on GitHub. Start again." | Settings › Project › GitHub | Start again. | — |
| "GitHub was not connected. The GitHub connection is not available right now. Try again later." | Settings › Project › GitHub | Try again later. | — |
| "The pull request is in a repository that is not connected to this project. An owner or admin connects it in Settings › Project › GitHub." | Check now, on a case | Connect the repository of the pull request. | — |
| "GitHub refused the read. Check that the Sequential GitHub app still has access to the repository." | Check now, on a case | Check the app's access on GitHub. | — |
