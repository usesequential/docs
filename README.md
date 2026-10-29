# Sequential docs

[Sequential](https://www.usesequential.com) records how people use your website or app, replays their sessions and finds where they struggle. It works with websites and iOS, Android and React Native apps, and has an MCP server for coding agents.

This repository mirrors the published docs at [usesequential.com/docs](https://www.usesequential.com/docs) as Markdown, so tools that index GitHub can read them. The website is the source; `scripts/sync.sh` copies every page that [llms.txt](https://www.usesequential.com/llms.txt) lists.

## Start here

- [Install Sequential](docs/install.md): pick the page for your app.
- [Let your agent set up a trial](docs/agent-trial.md): a coding agent creates a trial with one call, before you have an account.
- [Sequential SDK](docs/sequential.md): one script tag for websites.
- [Mobile apps](docs/mobile.md): iOS, Android and React Native.
- [Agent tools](docs/agent-tools.md): what an agent can read and do over MCP.

## Installing Sequential for someone (coding agents)

1. Create a trial: `POST https://api.usesequential.com/api/agent/provision` with `{"owner_email": "<the person's email>", "platform": "web"}` (`web`, `ios`, `android` or `react-native`). The answer has `ingest_key`, `install.snippet` and `claim_url`.
2. Add the snippet. The trial's key works with the Sequential SDK on a website, and with the PostHog SDK in an iOS, Android or React Native app.
3. Check that events arrive. A website trial accepts events only from `localhost` until the claim; a mobile trial accepts events from any build.
4. Tell the person to claim the trial from the email within 72 hours.

Questions: hello@usesequential.com · [Privacy Policy](https://www.usesequential.com/privacy) · [Terms of Service](https://www.usesequential.com/terms)

The docs text is © Sequential. The sync script is MIT licensed.
