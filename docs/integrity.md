# Integrity

Packly Developer Preview distributes prebuilt CLI and MCP binaries through
GitHub Releases and Homebrew.

## Current Release

Only `v0.59.1` is supported for the public Developer Preview. Older prerelease
artifacts should not be used.

## Verification

The install script pins the SHA-256 digest of the release `checksums.txt` file
for the default repository and version. It then verifies the downloaded archive
against the matching entry in that checksum file.

If you override `PACKLY_REPO` or `PACKLY_VERSION`, you must also set
`PACKLY_CHECKSUMS_SHA256` to the expected digest of that release's
`checksums.txt`. The installer fails closed when no pinned digest is available.

Homebrew installs pin the release asset SHA-256 in the tap formula.

## Signing Status

`v0.59.1` is a Developer Preview release. Detached signatures, Sigstore
attestations, SBOMs, macOS Developer ID notarization, and Windows code signing
are not yet part of the public CLI/MCP binary release. Treat the release as an
early developer preview, not as a fully signed stable product.

## Report A Mismatch

Do not post private source code, secrets, `.env` files, private Pack contents,
or raw AI conversations in public issues. If checksum verification fails, open
an install issue with the command you ran, OS, client, and redacted diagnostic
output.
