# Security Guardrails

Route this Pack for public release, signing, updater, secrets, auth, destructive file behavior, or dependency-risk work.

Required checks:

- Do not record secret values.
- Do not paste `.env`, tokens, private keys, certificates, or raw credentials into output.
- Treat updater manifests, release artifacts, install scripts, and checksum files as security-sensitive.
- Verify that public issues do not request source code, Pack bodies, raw conversations, or full personal paths.
- Prefer plan-only behavior for MCP tools and explicit approval for writes.
- Require independent review before public release approval.

If a command can destroy, overwrite, publish, revoke, rotate, sign, or expose data, call out the risk before execution.

