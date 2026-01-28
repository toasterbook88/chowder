#!/usr/bin/env bash
# Run any command with automatic Node 23 + Ollama setup
# Usage: ./scripts/dev.sh clawdbot models list
#        ./scripts/dev.sh pnpm build
#        ./scripts/dev.sh clawdbot config get agents.defaults.model.primary

set -e

if [ -z "$IN_NIX_SHELL" ]; then
  exec nix-shell --pure \
    -I nixpkgs=https://channels.nixos.org/nixos-24.05/nixexprs.tar.xz \
    -p nodejs_22 pnpm ollama \
    --run "IN_NIX_SHELL=1 OLLAMA_API_KEY='ollama-local' bash $0 $@"
fi

cd "$(dirname "$0")/.."

if [ $# -eq 0 ]; then
  echo "Usage: $0 <command>"
  echo ""
  echo "Examples:"
  echo "  $0 clawdbot models list"
  echo "  $0 clawdbot config set agents.defaults.model.primary ollama/llama3.3"
  echo "  $0 pnpm build"
  echo "  $0 pnpm test"
  echo ""
  echo "Or enter a dev shell:"
  echo "  bash scripts/dev-shell.sh"
  exit 1
fi

export OLLAMA_API_KEY="ollama-local"

if [ "$1" = "pnpm" ]; then
  shift
  corepack pnpm "$@"
else
  "$@"
fi
