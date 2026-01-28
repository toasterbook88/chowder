#!/usr/bin/env bash
# Start the Clawdbot gateway with Ollama support (no shell entry needed)
set -e

cd "$(dirname "$0")/.."

export OLLAMA_API_KEY="ollama-local"

echo "Starting Clawdbot gateway with Ollama support..."
echo ""

nix-shell --pure \
  -I nixpkgs=https://channels.nixos.org/nixos-24.05/nixexprs.tar.xz \
  -p nodejs_22 pnpm ollama \
  --run 'export OLLAMA_API_KEY="ollama-local"; pnpm clawdbot gateway run --bind loopback --port 18789 --force'
