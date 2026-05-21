# Safety Model

Packly Developer Preview is built around a local-first boundary.

## Local MCP Process

`packly-mcp` is launched by your MCP client as a local command. It communicates over stdio and does not expose an HTTP server.

## File Mutation Boundary

Packly MCP tools are for routing, reading Pack context, planning installs, and creating approval requests.

MCP tools do not directly apply Pack files to your workspace. Workspace writes are handled by explicit CLI commands such as `packly install`, `packly update`, `packly disable`, `packly enable`, and `packly rollback`.

## Workspace Safety

Packly CLI tracks managed files, snapshots previous content, checks drift, and supports rollback.

Pack validation rejects unsafe Pack paths such as absolute paths, parent traversal, non-portable components, duplicate targets, and symlink-based source paths.

## Client Config Safety

`packly mcp config` is read-only.

`packly mcp install-client` can write Codex or Cursor MCP config only after explicit invocation. Use `--dry-run` first. Existing config files are backed up before mutation.

Claude Code remains command-based through `claude mcp add`; Packly does not write Claude config files directly.

## Data To Avoid Sharing

Do not post these in public issues:

- source code
- private Pack content
- `.env` files
- API keys, tokens, certificates, or signing material
- raw AI conversations
- complete personal paths

