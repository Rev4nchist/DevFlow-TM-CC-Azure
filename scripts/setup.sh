#!/bin/bash

# Dev Workflow Framework Setup Script (Mac/Linux)
# Run with: chmod +x setup.sh && ./setup.sh

echo -e "\n🚀 Dev Workflow Framework Setup"
echo -e "================================\n"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check Node.js
echo -e "${YELLOW}✓ Checking Node.js...${NC}"
if command_exists node; then
    NODE_VERSION=$(node --version)
    echo -e "  ${GREEN}Node.js $NODE_VERSION found${NC}"
else
    echo -e "  ${RED}❌ Node.js not found. Please install from https://nodejs.org${NC}"
    exit 1
fi

# Check/Install TaskMaster
echo -e "\n${YELLOW}✓ Checking TaskMaster...${NC}"
if command_exists task-master; then
    TM_VERSION=$(task-master --version 2>/dev/null || echo "unknown")
    echo -e "  ${GREEN}TaskMaster found (version: $TM_VERSION)${NC}"
else
    echo -e "  Installing TaskMaster globally..."
    npm install -g @fourth/task-master
    
    # Add aliases to shell config
    SHELL_CONFIG=""
    if [ -f "$HOME/.zshrc" ]; then
        SHELL_CONFIG="$HOME/.zshrc"
    elif [ -f "$HOME/.bashrc" ]; then
        SHELL_CONFIG="$HOME/.bashrc"
    fi
    
    if [ -n "$SHELL_CONFIG" ]; then
        echo -e "\n# TaskMaster aliases" >> "$SHELL_CONFIG"
        echo "alias tm='task-master'" >> "$SHELL_CONFIG"
        echo "alias taskmaster='task-master'" >> "$SHELL_CONFIG"
        echo -e "  ${GREEN}Added TaskMaster aliases to $SHELL_CONFIG${NC}"
    fi
fi

# Check/Install Claude CLI
echo -e "\n${YELLOW}✓ Checking Claude CLI...${NC}"
if command_exists claude; then
    echo -e "  ${GREEN}Claude CLI found${NC}"
else
    echo -e "  ${YELLOW}Claude CLI not found${NC}"
    echo -e "  Please install from: https://github.com/anthropics/claude-cli"
    echo -e "  Run: npm install -g @anthropic-ai/claude-cli"
fi

# Check Azure CLI
echo -e "\n${YELLOW}✓ Checking Azure CLI...${NC}"
if command_exists az; then
    AZ_VERSION=$(az --version | head -n 1)
    echo -e "  ${GREEN}Azure CLI found${NC}"
else
    echo -e "  ${YELLOW}Azure CLI not found (optional)${NC}"
    echo -e "  Install instructions: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
fi

# Create necessary directories
echo -e "\n${YELLOW}✓ Creating project structure...${NC}"
mkdir -p .cursor/rules
mkdir -p .taskmaster/templates
mkdir -p .taskmaster/docs
mkdir -p documentation
mkdir -p scripts
mkdir -p mcp-configs

# Install npm dependencies
echo -e "\n${YELLOW}✓ Installing dependencies...${NC}"
npm install

# Copy MCP config example
echo -e "\n${YELLOW}✓ Setting up MCP configuration...${NC}"
if [ ! -f ".cursor/mcp.json" ] && [ -f "mcp-configs/mcp.json.example" ]; then
    cp mcp-configs/mcp.json.example .cursor/mcp.json
    echo -e "  ${GREEN}Created .cursor/mcp.json from example${NC}"
    echo -e "  ${YELLOW}⚠️  Remember to add your API keys to .cursor/mcp.json${NC}"
fi

# Create .env file if it doesn't exist
echo -e "\n${YELLOW}✓ Setting up environment...${NC}"
if [ ! -f ".env" ]; then
    cat > .env << EOF
# API Keys for TaskMaster
ANTHROPIC_API_KEY=your_anthropic_key_here
PERPLEXITY_API_KEY=your_perplexity_key_here
OPENAI_API_KEY=your_openai_key_here
GITHUB_TOKEN=your_github_token_here

# Azure Configuration (optional)
AZURE_SUBSCRIPTION_ID=your_subscription_id
AZURE_TENANT_ID=your_tenant_id
EOF
    echo -e "  ${GREEN}Created .env file${NC}"
    echo -e "  ${YELLOW}⚠️  Remember to add your API keys to .env${NC}"
fi

# Final verification
echo -e "\n${YELLOW}✓ Running verification...${NC}"
node scripts/verify-setup.js

echo -e "\n${GREEN}✨ Setup complete!${NC}"
echo -e "\nNext steps:"
echo -e "1. Add your API keys to .env and .cursor/mcp.json"
echo -e "2. Restart your IDE to load the Cursor rules"
echo -e "3. Run 'task-master init' to initialize TaskMaster for your project"
echo -e "4. Check out documentation/QUICKSTART.md for usage guide"

# Reload shell for aliases
if [ -n "$SHELL_CONFIG" ]; then
    echo -e "\n${YELLOW}Run 'source $SHELL_CONFIG' or restart your terminal for aliases${NC}"
fi 