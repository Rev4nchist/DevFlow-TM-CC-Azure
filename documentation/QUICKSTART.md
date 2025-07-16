# 🚀 5-Minute Setup Guide

Get your AI-powered development workflow running in 5 minutes or less!

## Prerequisites

- **OS**: Windows 10+, macOS, or Linux
- **Node.js**: Version 18+ ([Download](https://nodejs.org))
- **IDE**: Cursor, VS Code, or JetBrains IDE
- **Azure CLI**: Optional, for Azure features ([Install Guide](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli))

## Step 1: Clone & Install (1 minute)

```bash
# Clone the framework
git clone https://github.com/yourorg/dev-workflow-framework
cd dev-workflow-framework

# Install dependencies
npm install
```

## Step 2: Run Setup Script (2 minutes)

### Windows (PowerShell as Administrator)
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
./scripts/setup.ps1
```

### macOS/Linux
```bash
chmod +x scripts/setup.sh
./scripts/setup.sh
```

The setup script will:
- ✅ Install TaskMaster globally
- ✅ Configure MCP settings
- ✅ Set up example configurations
- ✅ Verify your environment

## Step 3: Configure API Keys (1 minute)

Create a `.env` file in your project root:

```env
# Required for TaskMaster AI features
ANTHROPIC_API_KEY=your_claude_api_key_here

# Optional: For research features
PERPLEXITY_API_KEY=your_perplexity_key_here

# Optional: For Azure features
AZURE_SUBSCRIPTION_ID=your_azure_subscription_id
```

## Step 4: Install Claude Code Extension (30 seconds)

In your IDE terminal:

```bash
# This auto-installs the extension
claude
```

**Note**: For JetBrains IDEs, install from the marketplace and restart.

## Step 5: Verify Setup (30 seconds)

```bash
# Check all tools are working
npm run verify

# Expected output:
# ✅ TaskMaster installed
# ✅ Claude Code available
# ✅ Azure CLI configured (if installed)
# ✅ MCP configurations valid
```

## 🎉 You're Ready!

### Try Your First Workflow

1. **Verify Your Setup** (Recommended):
   ```bash
   # Import the setup verification task
   task-master parse-prd documentation/setup-verification-task.md
   task-master next
   ```
   This creates a comprehensive verification workflow to test all components.

2. **Or Create Your Own Project**:
   ```bash
   echo "Build a todo app with user authentication" > .taskmaster/docs/todo-app.txt
   task-master parse-prd .taskmaster/docs/todo-app.txt
   task-master next
   claude code "Implement the current task"
   ```

## 🔥 Quick Commands Cheat Sheet

| What you want | Command |
|--------------|---------|
| See next task | `task-master next` |
| Start coding | `claude` or `Cmd+Esc` |
| Create Azure resource | `az [service] create ...` |
| Mark task done | `task-master set-status --id [id] --status done` |
| Update progress | `task-master update-subtask --id [id] --prompt "[notes]"` |

## 🆘 Troubleshooting

### "claude: command not found"
- Make sure you ran the setup script
- Try restarting your terminal
- For VS Code: Ensure you're in the integrated terminal

### "Azure CLI not found"
- Install from: https://aka.ms/installazurecliwindows
- Run `az login` after installation

### "API key errors"
- Check your `.env` file has valid keys
- Get Claude API key from: https://console.anthropic.com

## 📚 Next Steps

- 📖 Read the [Full Workflow Guide](workflow-examples/meeting-to-prd.md)
- 🎮 Try the [Azure Resource Example](workflow-examples/azure-resource-creation.md)
- 🤝 Share with your team using the [Team Adoption Guide](team-adoption.md)

---

**Need help?** Check our [documentation](../README.md) or open an issue on GitHub. 