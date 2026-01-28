#!/usr/bin/env bash
# Drop into a dev shell with Node 22, pnpm, and Ollama pre-configured
set -e

cd "$(dirname "$0")/.."

echo "Entering development shell (Node 22 + pnpm + Ollama)..."
echo "Set OLLAMA_API_KEY and all dependencies ready."
echo ""

nix-shell --pure \
  -I nixpkgs=https://channels.nixos.org/nixos-24.05/nixexprs.tar.xz \
  -p nodejs_22 pnpm ollama \
  --run 'export OLLAMA_API_KEY="ollama-local"; bash --login'
