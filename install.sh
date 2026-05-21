#!/bin/sh
set -eu

DEFAULT_REPO="Orvek-dev/packly-developer-preview"
DEFAULT_VERSION="0.59.1"
DEFAULT_CHECKSUMS_SHA256="85b058b6b5c52d36d21018ad21a39d319a15dc0784296f7399622e66dfbbeb6c"

REPO="${PACKLY_REPO:-$DEFAULT_REPO}"
VERSION="${PACKLY_VERSION:-$DEFAULT_VERSION}"
CHECKSUMS_SHA256="${PACKLY_CHECKSUMS_SHA256:-}"
TAG="v${VERSION}"
INSTALL_DIR="${PACKLY_INSTALL_DIR:-$HOME/.packly/bin}"

if [ -z "$CHECKSUMS_SHA256" ] && [ "$REPO" = "$DEFAULT_REPO" ] && [ "$VERSION" = "$DEFAULT_VERSION" ]; then
  CHECKSUMS_SHA256="$DEFAULT_CHECKSUMS_SHA256"
fi

os="$(uname -s)"
arch="$(uname -m)"
archive_ext="tar.gz"
exe_suffix=""

case "$os:$arch" in
  Darwin:arm64)
    target="aarch64-apple-darwin"
    ;;
  Linux:x86_64|Linux:amd64)
    target="x86_64-unknown-linux-gnu"
    ;;
  MINGW*:x86_64|MSYS*:x86_64|CYGWIN*:x86_64)
    target="x86_64-pc-windows-msvc"
    archive_ext="zip"
    exe_suffix=".exe"
    ;;
  *)
    echo "Packly Developer Preview currently publishes macOS Apple Silicon, Linux x64, and Windows x64 binaries." >&2
    echo "Unsupported platform: $os $arch" >&2
    exit 1
    ;;
esac

sha256_file() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  elif command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  elif command -v openssl >/dev/null 2>&1; then
    openssl dgst -sha256 "$1" | awk '{print $NF}'
  else
    echo "No SHA-256 tool found. Install shasum, sha256sum, or openssl." >&2
    exit 1
  fi
}

asset="packly-developer-preview-${TAG}-${target}.${archive_ext}"
base_url="https://github.com/${REPO}/releases/download/${TAG}"
tmp_dir="$(mktemp -d)"

cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT INT TERM

echo "Downloading $asset"
curl -fL "${base_url}/${asset}" -o "${tmp_dir}/${asset}"
curl -fL "${base_url}/checksums.txt" -o "${tmp_dir}/checksums.txt"

if [ -z "$CHECKSUMS_SHA256" ]; then
  echo "No pinned checksums.txt digest is configured for ${REPO} ${TAG}." >&2
  echo "Set PACKLY_CHECKSUMS_SHA256 to the expected SHA-256 digest or use the default release." >&2
  exit 1
fi

actual_checksums="$(sha256_file "${tmp_dir}/checksums.txt")"
if [ "$actual_checksums" != "$CHECKSUMS_SHA256" ]; then
  echo "checksums.txt verification failed for ${TAG}" >&2
  echo "expected: $CHECKSUMS_SHA256" >&2
  echo "actual:   $actual_checksums" >&2
  exit 1
fi

expected="$(grep "  ${asset}$" "${tmp_dir}/checksums.txt" | awk '{print $1}')"
if [ -z "$expected" ]; then
  echo "Checksum entry not found for $asset" >&2
  exit 1
fi

actual="$(sha256_file "${tmp_dir}/${asset}")"
if [ "$actual" != "$expected" ]; then
  echo "Checksum verification failed for $asset" >&2
  echo "expected: $expected" >&2
  echo "actual:   $actual" >&2
  exit 1
fi

mkdir -p "$INSTALL_DIR"
case "$archive_ext" in
  tar.gz)
    tar -xzf "${tmp_dir}/${asset}" -C "$tmp_dir"
    ;;
  zip)
    if ! command -v unzip >/dev/null 2>&1; then
      echo "unzip is required for Windows zip assets." >&2
      exit 1
    fi
    unzip -q "${tmp_dir}/${asset}" -d "$tmp_dir"
    ;;
esac

cp "${tmp_dir}/packly-developer-preview-${TAG}-${target}/packly${exe_suffix}" "$INSTALL_DIR/packly${exe_suffix}"
cp "${tmp_dir}/packly-developer-preview-${TAG}-${target}/packly-mcp${exe_suffix}" "$INSTALL_DIR/packly-mcp${exe_suffix}"
chmod 0755 "$INSTALL_DIR/packly${exe_suffix}" "$INSTALL_DIR/packly-mcp${exe_suffix}"

echo "Installed Packly Developer Preview ${TAG} to $INSTALL_DIR"
echo ""
echo "Verify:"
echo "  $INSTALL_DIR/packly${exe_suffix} --version"
echo "  $INSTALL_DIR/packly${exe_suffix} mcp status --mcp-bin \"$INSTALL_DIR/packly-mcp${exe_suffix}\""
echo ""
case ":$PATH:" in
  *":$INSTALL_DIR:"*) ;;
  *)
    echo "Add Packly to PATH:"
    echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
    ;;
esac
