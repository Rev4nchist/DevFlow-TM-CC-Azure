#!/usr/bin/env node

/**
 * Dev Workflow Framework - Setup Verification Script
 * Checks that all components are properly installed and configured
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Colors for console output
const colors = {
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  red: '\x1b[31m',
  reset: '\x1b[0m'
};

// Helper functions
const log = {
  success: (msg) => console.log(`${colors.green}✓ ${msg}${colors.reset}`),
  warning: (msg) => console.log(`${colors.yellow}⚠️  ${msg}${colors.reset}`),
  error: (msg) => console.log(`${colors.red}❌ ${msg}${colors.reset}`),
  info: (msg) => console.log(`  ${msg}`)
};

const checkCommand = (command) => {
  try {
    execSync(`${command} --version`, { stdio: 'ignore' });
    return true;
  } catch {
    return false;
  }
};

const checkFile = (filePath) => {
  return fs.existsSync(filePath);
};

const checkDirectory = (dirPath) => {
  return fs.existsSync(dirPath) && fs.statSync(dirPath).isDirectory();
};

// Main verification
console.log('\n🔍 Verifying Dev Workflow Framework Setup\n');

let hasErrors = false;
let hasWarnings = false;

// 1. Check Node.js version
console.log('Checking runtime environment...');
try {
  const nodeVersion = process.version;
  const majorVersion = parseInt(nodeVersion.split('.')[0].substring(1));
  
  if (majorVersion >= 18) {
    log.success(`Node.js ${nodeVersion} (meets requirement >=18)`);
  } else {
    log.error(`Node.js ${nodeVersion} (requires >=18)`);
    hasErrors = true;
  }
} catch (e) {
  log.error('Could not determine Node.js version');
  hasErrors = true;
}

// 2. Check required tools
console.log('\nChecking required tools...');

// TaskMaster
if (checkCommand('task-master')) {
  log.success('TaskMaster CLI installed');
  
  // Check aliases work
  if (checkCommand('tm')) {
    log.info('  Alias "tm" is working');
  }
} else {
  log.error('TaskMaster CLI not found');
  log.info('  Install with: npm install -g @fourth/task-master');
  hasErrors = true;
}

// Claude CLI
if (checkCommand('claude')) {
  log.success('Claude CLI installed');
} else {
  log.warning('Claude CLI not found (recommended)');
  log.info('  Install with: npm install -g @anthropic-ai/claude-cli');
  hasWarnings = true;
}

// Azure CLI
if (checkCommand('az')) {
  log.success('Azure CLI installed');
} else {
  log.warning('Azure CLI not found (optional for Azure features)');
  log.info('  Install from: https://docs.microsoft.com/cli/azure/install-azure-cli');
  hasWarnings = true;
}

// 3. Check project structure
console.log('\nChecking project structure...');

const requiredDirs = [
  '.cursor/rules',
  '.taskmaster/templates',
  '.taskmaster/docs',
  'documentation',
  'scripts',
  'mcp-configs'
];

requiredDirs.forEach(dir => {
  if (checkDirectory(dir)) {
    log.success(`Directory ${dir} exists`);
  } else {
    log.error(`Directory ${dir} missing`);
    hasErrors = true;
  }
});

// 4. Check configuration files
console.log('\nChecking configuration files...');

// Cursor rules
const cursorRules = [
  '.cursor/rules/01_project_workflow.mdc',
  '.cursor/rules/02_taskmaster_workflow.mdc',
  '.cursor/rules/azure_cli_integration.mdc'
];

cursorRules.forEach(rule => {
  if (checkFile(rule)) {
    log.success(`Rule file ${path.basename(rule)} exists`);
  } else {
    log.error(`Rule file ${path.basename(rule)} missing`);
    hasErrors = true;
  }
});

// MCP configuration
if (checkFile('.cursor/mcp.json')) {
  log.success('MCP configuration exists');
  
  // Check if it has actual API keys
  try {
    const mcpConfig = JSON.parse(fs.readFileSync('.cursor/mcp.json', 'utf8'));
    const hasPlaceholders = JSON.stringify(mcpConfig).includes('${');
    
    if (hasPlaceholders) {
      log.warning('MCP config has placeholder API keys - remember to update them');
      hasWarnings = true;
    }
  } catch {
    log.warning('Could not parse MCP config');
    hasWarnings = true;
  }
} else {
  log.warning('MCP configuration not found');
  log.info('  Copy from: mcp-configs/mcp.json.example');
  hasWarnings = true;
}

// Environment file
if (checkFile('.env')) {
  log.success('Environment file exists');
  
  // Check for placeholder values
  try {
    const envContent = fs.readFileSync('.env', 'utf8');
    if (envContent.includes('your_') && envContent.includes('_here')) {
      log.warning('Environment file has placeholder values - remember to update them');
      hasWarnings = true;
    }
  } catch {
    log.warning('Could not read environment file');
    hasWarnings = true;
  }
} else {
  log.warning('Environment file not found');
  log.info('  Will be created on first run');
  hasWarnings = true;
}

// 5. Check npm dependencies
console.log('\nChecking npm dependencies...');
if (checkFile('node_modules')) {
  log.success('npm dependencies installed');
} else {
  log.warning('npm dependencies not installed');
  log.info('  Run: npm install');
  hasWarnings = true;
}

// 6. Summary
console.log('\n' + '='.repeat(50));
if (!hasErrors && !hasWarnings) {
  console.log(`${colors.green}✨ All checks passed! Your dev workflow is ready.${colors.reset}`);
  console.log('\nNext steps:');
  console.log('1. Add your API keys to .env and .cursor/mcp.json');
  console.log('2. Run "task-master init" to start a new project');
  console.log('3. Create a PRD and run "task-master parse-prd"');
  process.exit(0);
} else if (!hasErrors) {
  console.log(`${colors.yellow}⚠️  Setup complete with warnings${colors.reset}`);
  console.log('\nPlease address the warnings above for full functionality.');
  process.exit(0);
} else {
  console.log(`${colors.red}❌ Setup incomplete - errors found${colors.reset}`);
  console.log('\nPlease fix the errors above before proceeding.');
  process.exit(1);
} 