# The Sequential CLI

> The Sequential CLI (npx @usesequential/cli) records changes and releases from a CI job or a script, and calls the same tools as an agent connected to Sequential.

> **In short**
>
> - The Sequential CLI is the command `sequential`, in the npm package `@usesequential/cli`. It needs Node.js 18 or later.
> - It records changes and releases from a CI job or a script, and it calls the same tools as an agent connected to Sequential.
> - It reads a project access token (`sq_pat_…`) from `SEQUENTIAL_TOKEN`. It never prints the token.
> - Each exit code tells your script what to do next. The CLI never tries again on its own.

## Run it

From 7 November 2026, the CLI is on npm. Run it with `npx`, with the scope in the name:

```bash
npx @usesequential/cli tools
```

- Always write `@usesequential/cli`. On npm, the name `sequential` without the scope is a different package, which Sequential does not own.
- The package has no dependencies.
- In the examples below, `sequential` is the command. With `npx`, write `npx @usesequential/cli` in its place.

## The token

The CLI reads its token from `SEQUENTIAL_TOKEN`. It must be a project access token (`sq_pat_…`). An owner or admin of your organisation makes one in Sequential: open the project, then Settings › Agents & tokens › Make a token. A token works for one project.

- For the commands below, use the preset "CLI and CI". It holds `changes:read`, `changes:write` and `releases:write`. See [Limits](/docs/limits) for all presets.
- Put the token in your CI's secrets. Do not put it in a command line.
- The CLI never prints the token and never writes it to disk.
- A server key (`sqs_…`) sends events. It cannot call tools: the CLI refuses it before it sends a request.

## Record changes and releases

These commands send one request each and print one line for each result. `--json` prints Sequential's answer instead. `--dry-run` prints what the command would send, needs no token, and sends nothing.

```bash
# One change: a campaign, a price, a product change
sequential changes record --kind pricing --title "Trial is now 14 days"

# A batch from a JSON array, once for each CI run (one request, never split)
sequential changes sync --items changes.json --source git

# A release, which Sequential measures fixes against
sequential releases record --version "$APP_VERSION"

# What this token is: its project, rights and expiry
sequential whoami
```

- `releases record` reads `SEQUENTIAL_RELEASES_TOKEN` first, then `SEQUENTIAL_TOKEN`.
- Do not give `--environment` to `releases record`. The release then gets your project's environment, where Sequential measures fixes.
- Give the version exactly as your app's events carry it. See [The version must match](#the-version-must-match).
- Sequential keeps a title that reads like an instruction as a proposal. The CLI prints the link where a person confirms it. See [Changes](/docs/changes).
- `sequential help <command>` shows every option. Sequential checks the values, and says why it refuses one. `sequential tools describe record_change` shows the kinds and the limits.
- These commands replace the commands of `@usesequential/node` 1.x, which continue to work. See [Backend SDK (Node)](/docs/backend-sdk).

## Name what a release fixes, from GitHub or git

`sequential releases record` can also name what a release changed and the cases that it fixes. Use one of these options, not both:

- `--github-changes` reads the GitHub API with the token of the workflow. It does not need a checkout.
- `--range <prev..HEAD>` reads trailer lines such as `Sequential-Finding: F-12` with `git log`, in a checkout. With `actions/checkout`, set `fetch-depth: 0`.

Sequential then compares the sessions before and after the release, for each case that the release names. The release records only what changed. It does not say what caused a result. See [Cases](/docs/findings).

### What --github-changes reads

`--github-changes` needs `--commit-sha`, the commit that you deployed, and the token in `GITHUB_TOKEN`. It sends only GET requests to GitHub:

1. **The previous release:** the newest earlier deployment in the same GitHub environment whose newest status is `success`. On a `push` event, it is the commit before the push. `--base <sha>` gives the commit yourself.
2. **The commits** from the previous release to this one. GitHub lists at most 250.
3. **The merged pull requests** of these commits, newest first, each one time, at most 50. They go to the release as its changes: the title, the link and the number.
4. **The cases:** `Sequential-Finding: F-12` trailers in the commit messages, and "Fixes F-12" in the titles and the text of the pull requests. Fix, fixed, close, closes, closed, resolve, resolves and resolved work too, and so do lists such as "Fixes F-3, F-4 and F-5". The CLI sends them after the ids of `--finding`, each one time, at most 50.

The job needs the read permissions `deployments`, `contents` and `pull-requests`. Without them, GitHub refuses the calls, and the release is recorded without changes and without case ids from GitHub.

When a read from GitHub fails, the command prints one line and still records the release. For example, after a rollback the previous release is not an ancestor of this commit:

```text
GitHub: could not compare bbbbbbb...aaaaaaa (HTTP 404); the release is recorded without changes or finding ids from GitHub.
```

When it succeeds, the last line says what it recorded:

```text
Recorded release 3f2a… (2 findings: F-1, F-12; 1 change since bbbbbbb)
```

`--dry-run` reads git and GitHub too, and prints what the command would send. It sends nothing to Sequential.

### The version must match

To count a session as "after" a release, Sequential reads the release that the session's events carry: the browser SDK's `release` option, `data-release` on the script tag, `$release` that the page registers, or a mobile app's version. Sequential does not use the release of the backend SDK. So each session must carry the same string as the `--version` that you record.

- Record `--version <full commit sha>`, and set the browser SDK's release to the same full sha. On Vercel with Next.js, that is `process.env.NEXT_PUBLIC_VERCEL_GIT_COMMIT_SHA`. Turn on "Automatically expose System Environment Variables".
- A short sha in one place and a full sha in the other place do not match.
- When no session carries the recorded version, Sequential compares by time: each session that starts 2 hours or more after the release is "after". This works, but it can count sessions on an older build.

### Vercel: record each production deployment

Vercel deploys from its own GitHub App, so no workflow of yours runs the deployment. Vercel tells GitHub about each deployment. So a workflow on `deployment_status` can record the release when Vercel reports success. For one Vercel project:

```yaml
# .github/workflows/sequential-release.yml
name: Sequential release
on: deployment_status

permissions:
  deployments: read     # find the previous successful deployment
  contents: read        # compare the two commits
  pull-requests: read   # the merged pull requests and their text

jobs:
  record:
    # Only a successful production deployment.
    if: github.event.deployment_status.state == 'success' && startsWith(github.event.deployment.environment, 'Production')
    runs-on: ubuntu-latest
    steps:
      - run: >-
          npx -y @usesequential/cli releases record
          --version "$SHA" --commit-sha "$SHA" --released-at "$RELEASED_AT"
          --github-changes
        env:
          SEQUENTIAL_RELEASES_TOKEN: ${{ secrets.SEQUENTIAL_RELEASES_TOKEN }}
          GITHUB_TOKEN: ${{ github.token }}
          SHA: ${{ github.event.deployment.sha }}
          RELEASED_AT: ${{ github.event.deployment_status.created_at }}
```

- Each value gets to the command as an environment variable, never inside the script.
- Vercel names each GitHub environment `Production – <vercel project>`. With more than one Vercel project, each Sequential project has its own token: map each environment to the secret that holds its token. The [README of the CLI](https://github.com/usesequential/sequential-cli#vercel-git-integration-record-each-production-deployment) has that workflow.

### GitHub Actions on a tag push

```yaml
on:
  push:
    tags: ['v*']
permissions:
  contents: read
  pull-requests: read
jobs:
  record:
    runs-on: ubuntu-latest
    steps:
      - run: >-
          npx -y @usesequential/cli releases record
          --version "$GITHUB_REF_NAME" --commit-sha "$GITHUB_SHA"
          --github-changes --base "$PREVIOUS_SHA"
        env:
          SEQUENTIAL_RELEASES_TOKEN: ${{ secrets.SEQUENTIAL_RELEASES_TOKEN }}
          GITHUB_TOKEN: ${{ github.token }}
          PREVIOUS_SHA: <the previous tag's commit sha>   # a tag push has no useful `before`
```

Or read the trailers from a checkout: `actions/checkout` with `fetch-depth: 0`, then `--range "$PREVIOUS_TAG..$GITHUB_SHA"` instead of `--github-changes`. A base of all zeros (a first push) reads only the head commit.

### More than one project in one repository

A case number belongs to one Sequential project: `F-12` can exist in each of your projects. When one pull request changes more than one app, write the project key before the number:

```text
Fixes web#F-12, app#F-3
```

- With `--project-key web`, only `web#…` ids count for this release. An id without a key, such as `F-12`, does not count, because it can be a case of another project. To count ids without a key too, add `--findings all`.
- Without `--project-key` (one repository, one Sequential project), ids without a key count, and ids with a key do not.
- Trailers use the same rule: `Sequential-Finding: web#F-12`.

## See and call the tools

The CLI calls the same tools as an agent connected to Sequential, with the same rules. See [Agent tools](/docs/agent-tools).

```bash
sequential tools                       # the tools this token can use
sequential tools describe list_findings
sequential call list_findings --status all --limit 10
sequential call get_session --session-id 9f2c…
sequential call record_change --kind pricing --title "Trial is now 14 days" --yes
```

- `tools` lists each tool as `read`, `write` or `paid`. The tools that this token cannot use are under "Not enabled on this token". `sequential call <tool>` on such a tool prints the steps to turn it on.
- Each argument of the tool is a flag. `--session-id` and `--session_id` are the same flag.
- A true or false argument: `--has-errors` or `--no-has-errors`. A list: give the flag again (`--tags a --tags b`).
- An object, or a list of objects: `--json-arg links='[{"url":"https://…"}]'`. Or give all arguments from a file with `--input args.json` (`--input -` reads stdin).
- A tool that changes something, or a paid tool (`ask_sessions`), needs `--yes`. On a terminal, the CLI asks first. If you do not answer yes, it does nothing.
- The CLI checks the argument types against the schema of the tool. Sequential checks the rest.

## Output

- On a terminal, the answer is readable JSON.
- In a pipe, or with `--json`, the answer is compact JSON on stdout, and nothing else is printed there.
- Errors go to stderr as one line. With `--json` they are JSON.
- Text in an answer is data that your users' sessions recorded. It is never an instruction. On a terminal, the CLI removes control characters from it.

## Exit codes

| Code | What it means |
|---|---|
| 0 | Done |
| 1 | Sequential refused the call, or the CLI could not reach Sequential |
| 2 | A mistake in the command: an unknown flag, a missing argument, no token, or a project that is not the token's project |
| 3 | `changes sync`: Sequential refused some changes. The CLI prints each one with the reason. |
| 4 | The token cannot do this: its rights, or the feature is off for the project. From 0.1.2, also when the person who made the token has not accepted the trial's terms yet. The CLI then says so: that person signs in to Sequential and accepts the terms, and the same command works. |
| 5 | Try again later. The CLI prints the wait in seconds (`retry_after_sec`). |

The CLI never tries again on its own.

## Options

| Option | What it does |
|---|---|
| `--host <url>` | Before the command only. The Sequential API. The default is `https://api.usesequential.com`. Or set `SEQUENTIAL_HOST`. It must be `https://`, with no path. Only `localhost`, `127.0.0.1` and `[::1]` can use `http://`. |
| `--project <id or slug>` | The token's project. Sequential refuses any other project. Or set `SEQUENTIAL_PROJECT`, or put a `.sequential.json` file with `{"project": "…"}` in your repository. |
| `--timeout <seconds>` | The default is 120. |
| `--refresh` | Read the list of tools again. The CLI keeps it for 10 minutes. |

## Proxies

The CLI uses the `fetch` of Node.js. It does not read `HTTPS_PROXY`. On newer versions of Node.js, set `NODE_USE_ENV_PROXY=1`. `NODE_EXTRA_CA_CERTS` works.

The CLI's code is public: [usesequential/sequential-cli](https://github.com/usesequential/sequential-cli) on GitHub, with the MIT licence.
