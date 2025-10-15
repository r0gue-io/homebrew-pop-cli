#!/bin/bash

# Usage: ./update.sh <version>
#
# This script publishes a new version of pop-cli to Homebrew by:
# - Downloading the release binaries for both ARM64 and x86_64
# - Calculating SHA256 checksums
# - Creating/updating the Homebrew formula
# - Committing and pushing changes to the tap repository
#
# Arguments:
#   version: The version number to publish (e.g. "1.0.0")
#
# Example:
#   ./update.sh 1.0.0
#
# Requirements:
#   - Git command line tools
#   - wget
#   - shasum
#   - Write access to the homebrew-pop-cli repository

set -e

# Check if version argument is provided
if [ -z "$1" ]; then
    echo "❌ Error: Version argument is required"
    echo "Usage: $0 <version>"
    exit 1
fi

VERSION="$1"
TAG="v${VERSION}"
GITHUB_USER="r0gue-io"
REPO_NAME="pop-cli"

# Validate semantic version format (x.y.z)
if ! [[ $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "❌ Error: Invalid version format. Must be in format x.y.z (e.g. 1.0.0)"
    exit 1
fi

echo "Publishing pop-cli ${VERSION} to Homebrew..."

# Create Formula directory
mkdir -p Formula

# Check if release exists
echo "Checking if release ${TAG} exists..."
if ! curl -s -f -I "https://github.com/${GITHUB_USER}/${REPO_NAME}/releases/download/${TAG}/pop-aarch64-apple-darwin.tar.gz" > /dev/null; then
  echo "❌ Error: Release ${TAG} not found. Please create a release first."
  exit 1
fi

# Check if Linux binaries exist
if ! curl -s -f -I "https://github.com/${GITHUB_USER}/${REPO_NAME}/releases/download/${TAG}/pop-x86_64-unknown-linux-gnu.tar.gz" > /dev/null; then
  echo "❌ Error: Linux binaries for release ${TAG} not found."
  exit 1
fi

# Download and calculate checksums
echo "Downloading binaries and calculating checksums..."
wget -q "https://github.com/${GITHUB_USER}/${REPO_NAME}/releases/download/${TAG}/pop-aarch64-apple-darwin.tar.gz"
wget -q "https://github.com/${GITHUB_USER}/${REPO_NAME}/releases/download/${TAG}/pop-x86_64-apple-darwin.tar.gz"
wget -q "https://github.com/${GITHUB_USER}/${REPO_NAME}/releases/download/${TAG}/pop-aarch64-unknown-linux-gnu.tar.gz"
wget -q "https://github.com/${GITHUB_USER}/${REPO_NAME}/releases/download/${TAG}/pop-x86_64-unknown-linux-gnu.tar.gz"

MACOS_ARM64_SHA=$(shasum -a 256 pop-aarch64-apple-darwin.tar.gz | awk '{print $1}')
MACOS_X86_64_SHA=$(shasum -a 256 pop-x86_64-apple-darwin.tar.gz | awk '{print $1}')
LINUX_ARM64_SHA=$(shasum -a 256 pop-aarch64-unknown-linux-gnu.tar.gz | awk '{print $1}')
LINUX_X86_64_SHA=$(shasum -a 256 pop-x86_64-unknown-linux-gnu.tar.gz | awk '{print $1}')

echo "✅ macOS ARM64 SHA256: $MACOS_ARM64_SHA"
echo "✅ macOS x86_64 SHA256: $MACOS_X86_64_SHA"
echo "✅ Linux ARM64 SHA256: $LINUX_ARM64_SHA"
echo "✅ Linux x86_64 SHA256: $LINUX_X86_64_SHA"

# Clean up
rm pop-*.tar.gz

# Create formula
echo "Creating formula..."
cat > Formula/pop.rb << EOF
class Pop < Formula
  desc "Swiss-army knife for Polkadot development"
  homepage "https://github.com/${GITHUB_USER}/${REPO_NAME}"
  version "${VERSION}"
  license "GPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/${GITHUB_USER}/${REPO_NAME}/releases/download/${TAG}/pop-aarch64-apple-darwin.tar.gz"
      sha256 "${MACOS_ARM64_SHA}"
    else
      url "https://github.com/${GITHUB_USER}/${REPO_NAME}/releases/download/${TAG}/pop-x86_64-apple-darwin.tar.gz"
      sha256 "${MACOS_X86_64_SHA}"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/${GITHUB_USER}/${REPO_NAME}/releases/download/${TAG}/pop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "${LINUX_ARM64_SHA}"
    else
      url "https://github.com/${GITHUB_USER}/${REPO_NAME}/releases/download/${TAG}/pop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "${LINUX_X86_64_SHA}"
    end
  end

  def install
    bin.install "pop"
  end

  test do
    system "#{bin}/pop", "--version"
  end
end
EOF

# Commit and push
echo "Committing and pushing..."
git add Formula/pop.rb
git commit -m "Add pop-cli formula v${VERSION}"
git push

echo ""
echo "✅ Successfully published pop-cli ${VERSION} to Homebrew!"
echo ""
echo "Users can now install with:"
echo "  brew tap ${GITHUB_USER}/pop-cli"
echo "  brew install pop"
echo ""
echo "Or directly:"
echo "  brew install ${GITHUB_USER}/pop-cli/pop"
