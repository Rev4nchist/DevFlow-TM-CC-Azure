# Full Feature Development Cycle

This example demonstrates the complete development lifecycle using our One Stop Shop workflow - from initial idea to deployed feature, all within your IDE.

## Scenario
Build a user authentication API with:
- User registration endpoint
- Login/JWT authentication
- Password reset functionality
- Deploy to Azure App Service

## Step 1: Capture the Idea

Create `.taskmaster/docs/auth-api-prd.txt`:

```
Project Name: User Authentication API
Date: December 2024
Version: 1.0

## Executive Summary
Build a secure authentication API for our web applications.

## Core Features
1. User Registration - Email/password signup
2. User Login - JWT token authentication  
3. Password Reset - Email-based reset flow
4. User Profile - View/update user data

## Technical Requirements
- Platform: Node.js + Express
- Database: Azure Cosmos DB
- Authentication: JWT tokens
- Deployment: Azure App Service
- Email: SendGrid integration
```

## Step 2: Generate Development Tasks

```bash
# Parse PRD into actionable tasks
task-master parse-prd .taskmaster/docs/auth-api-prd.txt
```

TaskMaster creates structured tasks:
- Task 1: Set up project structure and dependencies
- Task 2: Implement user registration endpoint
- Task 3: Build authentication middleware
- Task 4: Create password reset flow
- Task 5: Deploy to Azure

## Step 3: Start Development (One Stop Shop in Action)

### Get Your Next Task
```bash
task-master next
# Shows: Task 1 - Set up project structure and dependencies
```

### Generate Code with Claude
```bash
# Claude Code creates the foundation
claude code "Create Express.js project structure with TypeScript, JWT auth, and Cosmos DB integration. Include error handling, validation, and API documentation."
```

Claude generates:
- Complete project structure
- Package.json with dependencies
- TypeScript configuration
- Express server setup
- Cosmos DB connection
- JWT middleware
- Input validation schemas

### Set Up Azure Infrastructure
```bash
# Create Azure resources without leaving your IDE
az group create --name auth-api-rg --location eastus

az cosmosdb create \
  --name auth-api-db \
  --resource-group auth-api-rg \
  --kind GlobalDocumentDB

az appservice plan create \
  --name auth-api-plan \
  --resource-group auth-api-rg \
  --sku B1

az webapp create \
  --name auth-api-app \
  --resource-group auth-api-rg \
  --plan auth-api-plan
```

### Update Progress
```bash
task-master set-status --id 1 --status done
task-master update-subtask --id 1.1 --prompt "Created project structure, Azure resources configured"
```

## Step 4: Continue the Cycle

### Next Task
```bash
task-master next
# Shows: Task 2 - Implement user registration endpoint
```

### Implement Features
```bash
claude code "Implement user registration endpoint with email validation, password hashing, and Cosmos DB storage. Include comprehensive error handling and input validation."
```

### Test & Validate
```bash
# Run tests in integrated terminal
npm test

# Test API endpoints
npm run dev
```

### Deploy Changes
```bash
# Deploy to Azure
az webapp deployment source config-zip \
  --resource-group auth-api-rg \
  --name auth-api-app \
  --src dist.zip
```

## One Stop Shop Benefits Demonstrated

### No Context Switching
- **PRD Creation** → Text editor in IDE
- **Task Management** → TaskMaster commands in terminal
- **Code Generation** → Claude Code integration
- **Azure Deployment** → Azure CLI in terminal
- **Testing** → Integrated test runner
- **Documentation** → Markdown files in project

### Seamless Integration
- TaskMaster tracks progress automatically
- Claude Code understands project context
- Azure CLI commands run from same terminal
- Git integration for version control
- All documentation lives with code

### Team Collaboration
- Share TaskMaster tasks via tags
- Use GitHub MCP for PR management
- Everyone uses same workspace setup
- Consistent development experience

## Example Task Update Flow

```bash
# As you work, update progress
task-master update-subtask --id 2.1 --prompt "Registration endpoint complete, includes email validation and bcrypt hashing"

# Mark features complete
task-master set-status --id 2 --status done

# Get next priority
task-master next
```

## The Complete Cycle

1. **💡 Idea** → PRD in `.taskmaster/docs/`
2. **📋 Planning** → `task-master parse-prd`
3. **⚡ Development** → `claude code` + Azure CLI
4. **✅ Testing** → Integrated terminal
5. **🚀 Deployment** → Azure commands
6. **📊 Tracking** → TaskMaster updates

All in one workspace, no tool switching required!

## Next Steps

- Add monitoring with Application Insights
- Set up CI/CD pipeline
- Implement rate limiting
- Add comprehensive logging

---

This One Stop Shop approach transforms development from scattered tools and contexts into a unified, efficient workflow where everything happens in your IDE. 