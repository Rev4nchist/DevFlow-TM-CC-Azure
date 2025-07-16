# Setup Verification Task

Import this as your first TaskMaster task to verify your One Stop Shop development environment is properly configured.

## How to Use

1. Save this content to `.taskmaster/docs/setup-verification.txt`
2. Run: `task-master parse-prd .taskmaster/docs/setup-verification.txt`
3. Start with: `task-master next`

## PRD Content for TaskMaster

```
Project Name: Dev Workflow Framework Setup Verification
Date: December 2024
Version: 1.0

## Executive Summary
Verify that the complete development workflow framework is properly installed and configured for productive use.

## Goals & Objectives
- Primary Goal: Confirm all components of the One Stop Shop workflow are functional
- Secondary Goals:
  - Test TaskMaster integration
  - Validate Claude Code setup  
  - Verify Azure CLI configuration
  - Confirm MCP integrations work

## Core Features
1. **Environment Verification**
   - Description: Run comprehensive setup checks
   - Priority: High
   - Success Criteria: All verification scripts pass without errors

2. **TaskMaster Integration Test**
   - Description: Test basic TaskMaster commands and workflow
   - Priority: High  
   - Success Criteria: Can create, update, and complete tasks

3. **Claude Code Integration**
   - Description: Verify Claude Code extension works in IDE
   - Priority: High
   - Success Criteria: Can generate code using Claude Code commands

4. **Azure CLI Validation**
   - Description: Test Azure CLI authentication and basic commands
   - Priority: Medium
   - Success Criteria: Can authenticate and list Azure resources

5. **MCP Configuration Check**
   - Description: Verify MCP integrations are properly configured
   - Priority: Medium
   - Success Criteria: MCP tools respond correctly in IDE

## Technical Requirements
- Platform: Your development IDE (Cursor, VS Code, or JetBrains)
- Tools: TaskMaster, Claude Code, Azure CLI, Node.js
- Configuration: API keys configured in .env file
- Network: Internet access for API calls and Azure authentication

## User Stories
- As a developer, I want to verify my setup so that I can be confident in my development environment
- As a team member, I want to confirm all integrations work so that I can collaborate effectively
- As a project contributor, I want to test the complete workflow so that I understand how to use all tools

## Success Metrics
- Environment verification: 100% pass rate on npm run verify
- TaskMaster functionality: Successfully create and complete tasks
- Code generation: Claude Code produces working code samples
- Azure integration: Can authenticate and access Azure resources
- Team readiness: Complete workflow test without errors

## Timeline
- Phase 1: Basic environment checks (5 minutes)
- Phase 2: Tool integration testing (10 minutes)
- Phase 3: End-to-end workflow test (15 minutes)
- Complete: Ready for productive development

## Constraints & Assumptions
- Internet connection available for API calls
- Valid API keys obtained and configured
- IDE properly configured with extensions
- Azure subscription available (for Azure features)

## Future Considerations
- Regular verification runs to catch configuration drift
- Team-wide verification reports
- Automated setup monitoring
- Integration with CI/CD pipelines
```

## Expected TaskMaster Output

After parsing this PRD, TaskMaster will create tasks like:

### Task 1: Environment Verification
**Subtasks:**
- 1.1: Run `npm run verify` script
- 1.2: Check Node.js version compatibility  
- 1.3: Verify all required tools installed
- 1.4: Validate API key configuration

### Task 2: TaskMaster Integration Test  
**Subtasks:**
- 2.1: Test basic TaskMaster commands
- 2.2: Create a sample task
- 2.3: Update task status
- 2.4: Test task expansion functionality

### Task 3: Claude Code Integration
**Subtasks:**  
- 3.1: Launch Claude Code in IDE
- 3.2: Generate sample TypeScript function
- 3.3: Test code completion and suggestions
- 3.4: Verify integration with project context

### Task 4: Azure CLI Validation
**Subtasks:**
- 4.1: Run `az login` to authenticate
- 4.2: Test `az account list` command
- 4.3: Create test resource group
- 4.4: Clean up test resources

### Task 5: MCP Configuration Check
**Subtasks:**
- 5.1: Test GitHub MCP integration
- 5.2: Verify TaskMaster MCP functionality
- 5.3: Check web search MCP
- 5.4: Validate all MCP responses

## Verification Commands

### Environment Check
```bash
# Run comprehensive setup verification
npm run verify

# Expected output: All checks pass, no errors
```

### TaskMaster Test
```bash
# Test basic TaskMaster functionality
task-master --version
task-master list
task-master next

# Create test task
task-master add-task --prompt "Test task for verification"

# Update and complete
task-master set-status --id [new-task-id] --status done
```

### Claude Code Test  
```bash
# Test Claude Code (in IDE terminal)
claude code "Create a simple TypeScript function that adds two numbers with proper type annotations"

# Expected: Working TypeScript function generated
```

### Azure CLI Test
```bash
# Test Azure authentication
az login
az account show

# Test basic command (safe, read-only)
az group list --output table

# Expected: Successful authentication and resource listing
```

## Troubleshooting Common Issues

### Verification Script Fails
- Check Node.js version (must be 18+)
- Ensure all dependencies installed: `npm install`
- Verify API keys in .env file

### TaskMaster Commands Not Found
- Install globally: `npm install -g @fourth/task-master`
- Restart terminal after installation
- Check PATH environment variable

### Claude Code Not Working
- Ensure Claude Code extension installed in IDE
- Check Anthropic API key in .env
- Restart IDE after configuration changes

### Azure CLI Issues
- Install Azure CLI from Microsoft docs
- Run `az login` to authenticate
- Set default subscription if multiple available

### MCP Integration Problems
- Check .cursor/mcp.json configuration
- Verify API keys for required MCPs
- Restart IDE to reload MCP configurations

## Success Confirmation

When verification is complete, you should be able to:

✅ **Run verification script without errors**
✅ **Create and manage TaskMaster tasks**  
✅ **Generate code using Claude Code**
✅ **Execute Azure CLI commands**
✅ **Use MCP integrations in IDE**

Your One Stop Shop development environment is ready for productive work!

---

This verification task ensures your complete development workflow is configured correctly and ready for team collaboration. 