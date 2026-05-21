# Feedback

The Developer Preview is looking for workflow failures, not broad opinions.

Useful feedback answers:

- Did install complete?
- Did `packly mcp status` pass?
- Did your client see Packly MCP tools?
- How long did it take to activate or read the first Pack?
- What task were you trying to route?
- Where did the workflow stop?

## Install Failure

Run:

```sh
packly --version
packly doctor --no-workspace --mcp-bin "$HOME/.packly/bin/packly-mcp" --bundle
packly mcp status --mcp-bin "$HOME/.packly/bin/packly-mcp"
packly mcp readiness --no-workspace --mcp-bin "$HOME/.packly/bin/packly-mcp"
```

Review the generated doctor bundle before posting it publicly. It is designed to omit source code, Pack bodies, secret values, and raw conversations, and to redact common local paths. Remove any full personal path, project name, or workspace detail you do not want public.

Open an install failure issue and attach or paste only the redacted diagnostics that are relevant to the failure.

## Workflow Feedback

Open a workflow feedback issue with:

- client: Claude Code, Codex, Cursor, or other
- Pack used
- task attempted
- expected routing
- actual routing
- whether you had to paste `CLAUDE.md`, `AGENTS.md`, skills, or rules manually

## What Not To Send

Do not send:

- source code
- private Pack bodies
- secret values
- `.env` files
- complete personal paths
- raw AI conversation transcripts

If a maintainer asks for a debugging call, it should be optional and scoped to the install or MCP connection failure.
