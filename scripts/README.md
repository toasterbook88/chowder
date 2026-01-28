# Clawdbot Scripts

This directory contains enhanced scripts for managing Clawdbot + Ollama on NixOS.

## 🚀 Quick Start

```bash
# One-time setup (builds project, ensures Ollama is ready)
bash scripts/setup

# Start everything
bash scripts/start

# Check health status
bash scripts/health

# Stop everything
bash scripts/kill-all
```

## 📋 Available Scripts

### Core Scripts

- **`setup`** - Auto-setup: builds project, starts Ollama, pulls models
- **`start`** - Start Clawdbot gateway with full error handling
- **`start-tui`** - Start Clawdbot TUI interface
- **`kill-all`** - Stop all Clawdbot processes (preserves Ollama models)

### Diagnostic Scripts

- **`diagnose`** - Comprehensive system diagnostic
- **`check-ollama`** - Ollama-specific health check
- **`health`** - Quick health status check
- **`debug`** - Detailed environment debugging

### Utility Scripts

- **`cmd`** - Run any command in the Clawdbot nix environment
- **`ollama-backup`** - Backup and restore Ollama models safely

### Configuration

- **`config.env`** - Environment configuration file
- **`clawdbot-gateway.service`** - Systemd service template

## 🔧 Key Improvements

### ✅ Automatic Setup

- Auto-builds project if needed
- Auto-starts Ollama if not running
- Auto-pulls required models
- Validates all prerequisites

### ✅ Robust Error Handling

- Pre-flight checks before starting
- Graceful failure recovery
- Clear error messages
- Automatic cleanup on failure

### ✅ Model Preservation

- Never deletes downloaded Ollama models
- Uses system Ollama (not nix-isolated)
- Preserves models across restarts

### ✅ Health Monitoring

- Real-time health checks
- Port availability monitoring
- Process status validation
- Automatic recovery suggestions

### ✅ Environment Management

- nixos-unstable for latest packages
- Node.js 22+ compatibility
- Isolated development environment
- Configurable settings

## 🎯 Usage Examples

```bash
# Development workflow
bash scripts/setup    # Initial setup
bash scripts/start    # Start gateway
bash scripts/health   # Monitor health

# Run commands in environment
bash scripts/cmd pnpm build
bash scripts/cmd pnpm test

# Backup Ollama models before risky operations
bash scripts/ollama-backup backup

# TUI development
bash scripts/start-tui

# Production deployment
CLAWDBOT_ENV=production bash scripts/start
```

## 🔒 Safety Features

- **Model Preservation**: Ollama models in `~/.ollama/` are NEVER deleted
- **Isolated Environments**: Nix provides clean, isolated development environments
- **Lock File Management**: Automatic cleanup prevents conflicts
- **Backup Protection**: `ollama-backup` script for model safety
- **Process Isolation**: Only Clawdbot processes are managed, Ollama is preserved

## 🛡️ Ollama Model Safety

**IMPORTANT**: Ollama models are stored in `~/.ollama/` and can be accidentally deleted by scripts. Always backup before risky operations.

### Backup Script Usage

```bash
# Check current models and their sizes
bash scripts/ollama-backup status

# Create backup of all models
bash scripts/ollama-backup backup

# Restore models from backup
bash scripts/ollama-backup restore

# List available backups
bash scripts/ollama-backup list
```

**Safety Features:**

- Never deletes `~/.ollama/` directory
- Shows model sizes before operations
- Requires explicit confirmation for destructive actions
- Creates timestamped backups
- Validates backup integrity

### Model Storage

- Models: `~/.ollama/models/`
- Manifests: `~/.ollama/models/manifests/`
- Blobs: `~/.ollama/models/blobs/`

**Total size**: ~42GB for llama3.3:70b model

## 📊 Monitoring

The `health` script provides real-time status:

- ✅ Ollama API connectivity
- ✅ Model availability
- ✅ Gateway process status
- ✅ Port availability
- ✅ Web interface responsiveness

## 🛠️ Troubleshooting

If issues occur:

1. Run `bash scripts/diagnose` for full diagnostic
2. Check `bash scripts/health` for quick status
3. Use `bash scripts/kill-all` to clean restart
4. Run `bash scripts/setup` to auto-fix common issues

## 🔄 Systemd Integration

For production use, copy `clawdbot-gateway.service` to `~/.config/systemd/user/`:

```bash
cp scripts/clawdbot-gateway.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable clawdbot-gateway
systemctl --user start clawdbot-gateway
```
