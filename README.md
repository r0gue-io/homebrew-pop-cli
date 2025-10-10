# Homebrew Pop CLI

A Homebrew tap for [pop-cli](https://onpop.io/), the Swiss-army knife for Polkadot development.

## Installation

```bash
brew install r0gue-io/pop-cli/pop
```

## Usage

After installation, you can use the `pop` command:

```bash
pop --version
pop --help
```

For detailed usage instructions, please refer to the [pop-cli documentation](https://github.com/r0gue-io/pop-cli).

## About pop-cli

Pop CLI is a comprehensive tool for Polkadot development that helps developers:

- Build and deploy smart contracts.
- Create and manage parachains and smart contracts.
- Interact with Polkadot networks.
- And much more!

Visit the [main pop-cli repository](https://github.com/r0gue-io/pop-cli) for more information.

## Maintainer Information

### Publishing New Versions

This repository includes an automated script for publishing new versions of pop-cli to Homebrew.

#### Usage

```bash
./update.sh <version>
```

**Example:**

```bash
./update.sh 1.0.0
```

The script will:

1. Download the release binaries for both ARM64 and x86_64 architectures.
2. Calculate SHA256 checksums.
3. Create/update the Homebrew formula.
4. Commit and push changes to the tap repository.

**Note:** The release must exist on the [pop-cli GitHub releases page](https://github.com/r0gue-io/pop-cli/releases)
before running the update script.

## License

GPL-3.0

## Links

- [pop-cli GitHub Repository](https://github.com/r0gue-io/pop-cli)
- [Homebrew Documentation](https://docs.brew.sh/)
- [Creating Homebrew Taps](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
