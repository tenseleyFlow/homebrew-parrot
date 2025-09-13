# Homebrew Tap for Parrot

This is the official Homebrew tap for [Parrot](https://repos.musicsian.com/parrot.html), an AI-powered CLI roast machine that mocks your command failures with style.

## Installation

```bash
# Add the tap
brew tap tenseleyFlow/parrot

# Install parrot
brew install parrot

# Complete setup
parrot install
```

## What is Parrot?

Parrot is a sassy CLI companion that listens for your command failures and delivers AI-powered roasts with three levels of brutality. Features include:

- 🤖 **Transparent AI Management**: Automatic AI model downloads and smart configuration
- 🎭 **Three Personalities**: From gentle guidance to savage roasts (mild, sarcastic, savage)
- 🔗 **Shell Integration**: Seamless bash and zsh integration with automatic failure detection
- 🎨 **Terminal Theming**: Color-coded responses with personality-based themes
- 🏗️ **Multi-Backend**: API (OpenAI-compatible), Local (Ollama), or Built-in fallback responses

## Usage

After installation, run `parrot install` to enable shell integration. Then failed commands will automatically trigger delightfully savage roasts!

Example roast personalities:
```bash
$ git onit
git: 'onit' is not a git command
🦜 Close, but no cigar. Try 'git init' next time. # mild

🦜 Git good? More like git rekt! # sarcastic

🦜 Another git genius strikes again! # savage

$ docker run hello-world
docker: command not found
🦜 Docker isn't installed, genius. What's next, asking why your imaginary friends aren't responding either? # savage
```

## Configuration

- Homepage: https://repos.musicsian.com/parrot.html
- Source: https://github.com/tenseleyFlow/parrot
- License: MIT

For detailed configuration and backend setup, see the [full documentation](https://repos.musicsian.com/parrot.html).