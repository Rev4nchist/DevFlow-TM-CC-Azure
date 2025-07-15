# Dev Workflow Framework Setup Script (Windows)
# Run as Administrator for best results

Write-Host "`n🚀 Dev Workflow Framework Setup" -ForegroundColor Cyan
Write-Host "================================`n" -ForegroundColor Cyan

# Function to check if a command exists
function Test-CommandExists {
    param($Command)
    $null = Get-Command $Command -ErrorAction SilentlyContinue
    return $?
}

# Check Node.js
Write-Host "✓ Checking Node.js..." -ForegroundColor Yellow
if (Test-CommandExists node) {
    $nodeVersion = node --version
    Write-Host "  Node.js $nodeVersion found" -ForegroundColor Green
} else {
    Write-Host "  ❌ Node.js not found. Please install from https://nodejs.org" -ForegroundColor Red
    exit 1
}

# Check/Install TaskMaster
Write-Host "`n✓ Checking TaskMaster..." -ForegroundColor Yellow
if (Test-CommandExists task-master) {
    Write-Host "  TaskMaster already installed" -ForegroundColor Green
} else {
    Write-Host "  Installing TaskMaster globally..." -ForegroundColor Yellow
    npm install -g task-master-ai
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✅ TaskMaster installed successfully" -ForegroundColor Green
    } else {
        Write-Host "  ❌ Failed to install TaskMaster" -ForegroundColor Red
        exit 1
    }
}

# Check Azure CLI (optional)
Write-Host "`n✓ Checking Azure CLI..." -ForegroundColor Yellow
if (Test-CommandExists az) {
    $azVersion = az --version | Select-String "azure-cli" | Select-Object -First 1
    Write-Host "  $azVersion" -ForegroundColor Green
} else {
    Write-Host "  ⚠️  Azure CLI not found (optional)" -ForegroundColor Yellow
    Write-Host "  Install from: https://aka.ms/installazurecliwindows" -ForegroundColor Gray
}

# Create directory structure
Write-Host "`n✓ Creating directory structure..." -ForegroundColor Yellow
$directories = @(
    ".cursor",
    ".taskmaster\docs",
    ".taskmaster\templates",
    ".taskmaster\tasks"
)

foreach ($dir in $directories) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "  Created $dir" -ForegroundColor Green
    }
}

# Copy configuration files
Write-Host "`n✓ Setting up configuration files..." -ForegroundColor Yellow

# Copy MCP config if it doesn't exist
if (!(Test-Path ".cursor\mcp.json")) {
    if (Test-Path "mcp-configs\mcp.json.example") {
        Copy-Item "mcp-configs\mcp.json.example" ".cursor\mcp.json"
        Write-Host "  Created .cursor\mcp.json" -ForegroundColor Green
    }
}

# Create .env template if it doesn't exist
if (!(Test-Path ".env")) {
    @"
# Required for AI features
ANTHROPIC_API_KEY=your_api_key_here

# Optional: For research features
PERPLEXITY_API_KEY=your_api_key_here

# Optional: For Azure features
AZURE_SUBSCRIPTION_ID=your_subscription_id_here
"@ | Out-File -FilePath ".env" -Encoding UTF8
    Write-Host "  Created .env template" -ForegroundColor Green
    Write-Host "  ⚠️  Remember to add your API keys to .env" -ForegroundColor Yellow
}

# Install npm dependencies
Write-Host "`n✓ Installing npm dependencies..." -ForegroundColor Yellow
npm install --silent
if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✅ Dependencies installed" -ForegroundColor Green
} else {
    Write-Host "  ❌ Failed to install dependencies" -ForegroundColor Red
}

# Final instructions
Write-Host "`n🎉 Setup Complete!" -ForegroundColor Green
Write-Host "=================" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "1. Add your API keys to .env file" -ForegroundColor White
Write-Host "2. Run 'claude' in your terminal to install Claude Code" -ForegroundColor White
Write-Host "3. Try 'task-master init' to start your first project" -ForegroundColor White
Write-Host "`nFor Azure features:" -ForegroundColor Cyan
Write-Host "- Run 'az login' to authenticate with Azure" -ForegroundColor White
Write-Host "`nHappy coding! 🚀`n" -ForegroundColor Green 