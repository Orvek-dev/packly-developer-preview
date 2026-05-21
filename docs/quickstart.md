# Quickstart

This quickstart connects Packly MCP to a local AI client in about five minutes.

## 1. Install

Homebrew on macOS Apple Silicon or Linux x64:

```sh
brew tap Orvek-dev/packly
brew install packly
```

Install script alternative:

```sh
curl -fsSL https://raw.githubusercontent.com/Orvek-dev/packly-developer-preview/main/install.sh | sh
export PATH="$HOME/.packly/bin:$PATH"
```

Windows x64: download the zip from the [v0.59.1 release](https://github.com/Orvek-dev/packly-developer-preview/releases/tag/v0.59.1), verify it with `checksums.txt`, extract it, and add the extracted directory to `PATH`. In Git Bash/MSYS/Cygwin, the shell installer can also install the Windows zip.

## 2. Verify The Binaries

```sh
packly --version
packly mcp status --mcp-bin "$HOME/.packly/bin/packly-mcp"
```

## 3. Connect A Client

Generate exact snippets for all supported clients:

```sh
packly mcp config --client all --mcp-bin "$HOME/.packly/bin/packly-mcp"
```

Claude Code:

```sh
claude mcp add --transport stdio --scope user packly -- "$HOME/.packly/bin/packly-mcp" --session default
```

Codex:

```sh
packly mcp install-client --client codex --mcp-bin "$HOME/.packly/bin/packly-mcp" --dry-run
packly mcp install-client --client codex --mcp-bin "$HOME/.packly/bin/packly-mcp"
```

Cursor:

```sh
packly mcp install-client --client cursor --mcp-bin "$HOME/.packly/bin/packly-mcp" --dry-run
packly mcp install-client --client cursor --mcp-bin "$HOME/.packly/bin/packly-mcp"
```

## 4. Import A Sample Pack

```sh
packly pack import-url https://github.com/Orvek-dev/packly-developer-preview/tree/main/packs/review-loop
packly pack list
```

## 5. Use Packly From Your AI Client

Ask:

```text
Use Packly to start a review-loop session for this workspace.
```

The MCP client should route through Packly tools instead of asking you to paste long project instructions.
