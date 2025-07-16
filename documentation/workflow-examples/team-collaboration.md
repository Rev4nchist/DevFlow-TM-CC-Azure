# Team Collaboration Workflow

This example demonstrates how multiple developers can collaborate seamlessly using our One Stop Shop framework - coordinating tasks, code reviews, and deployments without leaving their IDEs.

## Scenario
A 3-developer team building a customer portal:
- **Dev A**: Frontend (React components)  
- **Dev B**: Backend API (Node.js/Express)
- **Dev C**: Infrastructure & DevOps (Azure resources)

All working in parallel using shared TaskMaster coordination.

## Team Setup: Shared Task Management

### Initialize Shared TaskMaster
```bash
# Team lead creates the project
task-master init --project customer-portal

# Parse the main PRD
task-master parse-prd .taskmaster/docs/customer-portal-prd.txt
```

### Create Team Tags for Parallel Work
```bash
# Create specialized tags for different workstreams
task-master add-tag frontend --description "React frontend development"
task-master add-tag backend --description "API backend development"  
task-master add-tag infrastructure --description "Azure resources and DevOps"

# Copy relevant tasks to each tag
task-master copy-tag master frontend
task-master copy-tag master backend
task-master copy-tag master infrastructure
```

## Developer A: Frontend Development

### Switch to Frontend Context
```bash
# Dev A focuses on frontend tasks
task-master use-tag frontend

# Get next frontend task
task-master next
# Shows: Task 3 - Build customer dashboard components
```

### Develop with Claude Code
```bash
# Generate React components
claude code "Create customer dashboard with TypeScript, Material-UI components, and API integration. Include responsive design and loading states."
```

### Create Feature Branch
```bash
# Create branch for feature work
git checkout -b feature/customer-dashboard

# Claude generates complete component structure
# - CustomerDashboard.tsx
# - CustomerCard.tsx  
# - CustomerList.tsx
# - API integration hooks
# - TypeScript interfaces
```

### Update Team Progress
```bash
# Update task with progress
task-master update-subtask --id 3.1 --prompt "Dashboard components created, responsive design implemented, API hooks ready for backend integration"

# Mark subtask complete
task-master set-status --id 3.1 --status done
```

## Developer B: Backend Development

### Switch to Backend Context
```bash
# Dev B works on API tasks
task-master use-tag backend

# Get next backend priority
task-master next  
# Shows: Task 2 - Implement customer API endpoints
```

### Parallel Development
```bash
# Create backend branch
git checkout -b feature/customer-api

# Generate API code
claude code "Create Express.js API with customer CRUD operations, validation middleware, error handling, and Cosmos DB integration. Include OpenAPI documentation."
```

### API Development in IDE
Claude generates:
- RESTful API endpoints (`/api/customers`)
- Input validation schemas
- Database models and queries
- Error handling middleware
- API documentation
- Unit tests

### Coordinate with Frontend Team
```bash
# Update shared task with API contract
task-master update-subtask --id 2.2 --prompt "Customer API endpoints complete. Available at /api/customers - GET, POST, PUT, DELETE. Frontend team can integrate."

# Share API documentation link
task-master update-task --id 2 --prompt "API documentation: http://localhost:3000/api-docs"
```

## Developer C: Infrastructure & DevOps

### Infrastructure Focus
```bash
# Dev C handles deployment and infrastructure
task-master use-tag infrastructure

task-master next
# Shows: Task 1 - Set up Azure infrastructure and CI/CD
```

### Azure Resource Creation
```bash
# Create production environment
az group create --name customer-portal-prod-rg --location eastus

# Database for backend
az cosmosdb create \
  --name customer-portal-db \
  --resource-group customer-portal-prod-rg

# Frontend hosting  
az staticwebapp create \
  --name customer-portal-frontend \
  --resource-group customer-portal-prod-rg \
  --source https://github.com/yourorg/customer-portal \
  --branch main \
  --app-location "/frontend" \
  --api-location "/backend"

# Backend API hosting
az webapp create \
  --name customer-portal-api \
  --resource-group customer-portal-prod-rg \
  --plan customer-portal-plan
```

### Update Team with Deployment Info
```bash
task-master update-subtask --id 1.3 --prompt "Production environment ready. Frontend: https://customer-portal-frontend.azurestaticapps.net, API: https://customer-portal-api.azurewebsites.net"
```

## Team Coordination & Code Review

### Pull Request Workflow (Using GitHub MCP)
```bash
# Dev A creates PR for frontend work
git push origin feature/customer-dashboard

# Use GitHub integration from IDE
github create-pr --title "Add customer dashboard components" --body "Implements responsive dashboard with Material-UI components. Ready for backend API integration."
```

### Cross-Team Review Process
```bash
# Team members review using Claude Code
claude code "Review this React component for performance, accessibility, and code quality. Suggest improvements for the customer dashboard implementation."

# Add review comments via GitHub MCP
github add-review-comment --pr 123 --body "Consider memoizing the customer list component for better performance"
```

### Merge and Update Tasks
```bash
# After PR approval and merge
task-master set-status --id 3 --status done
task-master add-task --prompt "Integrate frontend with live backend API endpoints"
```

## Integration Testing (Whole Team)

### Shared Testing Environment
```bash
# All developers switch to integration tag
task-master add-tag integration --description "Integration testing and deployment"
task-master use-tag integration

# Create integration tasks
task-master add-task --prompt "Test frontend-backend integration in staging environment"
task-master add-task --prompt "Validate Azure deployment pipeline"
task-master add-task --prompt "Perform end-to-end user testing"
```

### Collaborative Debugging
```bash
# When issues arise, update shared context
task-master update-task --id 15 --prompt "Frontend dashboard not loading customer data. Backend API returns 500 error on /api/customers endpoint. Investigating CORS configuration."

# Team members can see real-time updates
task-master get-task --id 15
# Shows latest debugging progress from all team members
```

## Production Deployment

### Coordinated Release
```bash
# Final deployment task
task-master add-task --prompt "Deploy v1.0 to production with all team features"

# Each team member contributes to deployment
# Dev A: Frontend build and static web app deployment
# Dev B: API deployment and database migrations  
# Dev C: Infrastructure monitoring and health checks
```

### Post-Deployment Tracking
```bash
# Track production deployment success
task-master update-task --id 20 --prompt "Production deployment successful. Frontend and API healthy. Customer dashboard live at production URL."

task-master set-status --id 20 --status done
```

## One Stop Shop Team Benefits

### Unified Context
- **Shared Tasks**: Everyone sees project progress in real-time
- **No Tool Switching**: Git, Claude, Azure CLI, GitHub all in IDE
- **Integrated Communication**: Task updates serve as team standup
- **Version Control**: All changes tracked with automatic commit messages

### Efficient Coordination  
- **Tag-Based Work**: Parallel development without conflicts
- **Real-Time Updates**: TaskMaster provides live project status
- **Code Review Integration**: GitHub MCP enables PR workflow in IDE
- **Deployment Coordination**: Azure CLI commands shared and documented

### Knowledge Sharing
- **Task History**: Complete development story preserved
- **Code Generation**: Claude Code solutions shared across team
- **Documentation**: All docs live with code in workspace
- **Best Practices**: Cursor rules ensure consistent patterns

## Team Communication Examples

### Daily Standup via TaskMaster
```bash
# Each team member reports progress
task-master update-task --id 8 --prompt "[Dev A] Dashboard components 80% complete, need API endpoints for customer search"

task-master update-task --id 12 --prompt "[Dev B] Customer API ready, adding search functionality based on frontend requirements"

task-master update-task --id 5 --prompt "[Dev C] Staging environment deployed, ready for integration testing"
```

### Handoff Documentation
```bash
# Clear handoffs between team members
task-master update-subtask --id 3.2 --prompt "[Dev A → Dev B] Frontend customer search component ready. Expects GET /api/customers?search={term} endpoint with pagination."

task-master update-subtask --id 12.1 --prompt "[Dev B → Dev C] Customer search API deployed to staging. Database queries optimized. Ready for production deployment."
```

---

This team collaboration approach transforms development from siloed work into a coordinated, efficient process where everyone stays in sync through their shared One Stop Shop workspace. 