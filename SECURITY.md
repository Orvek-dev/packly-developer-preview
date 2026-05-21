# Security Policy

## Supported Versions

Only the latest Developer Preview release is supported.

## Reporting A Vulnerability

Do not open a public issue for secrets, arbitrary file write, command execution, updater, signing, or credential exposure findings.

Use GitHub private vulnerability reporting if it is available for this repository:

```text
https://github.com/Orvek-dev/packly-developer-preview/security/advisories/new
```

If private reporting is unavailable, open a minimal public issue titled
`[security-contact]` without exploit details, secrets, source code, private Pack
contents, or full local paths. A maintainer will move the discussion to a
private channel.

## Public Issue Rules

Never include:

- API keys, tokens, certificates, or signing material
- `.env` files
- private source code
- private Pack contents
- raw AI conversations
- full personal filesystem paths

For install issues, prefer redacted `packly doctor --bundle`,
`packly mcp status`, and `packly mcp readiness` output. Review the generated
doctor bundle before posting it publicly.
