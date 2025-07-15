# Azure Resource Creation Workflow Example

This example demonstrates creating a complete Azure application infrastructure using our workflow.

## Scenario
Create a web application with:
- App Service for hosting
- Cosmos DB for data storage
- Function App for background processing
- Application Insights for monitoring

## Step 1: Create the PRD

Create `.taskmaster/docs/azure-app-prd.txt`:

```
Project Name: Customer Portal
Date: December 2024
Version: 1.0

## Executive Summary
Build a customer portal with web frontend, API backend, and async processing.

## Core Features
1. Web Application - Host customer-facing portal
2. Database - Store customer data with global distribution
3. Background Jobs - Process customer uploads asynchronously
4. Monitoring - Track performance and errors

## Technical Requirements
- Platform: Azure PaaS services
- Region: East US primary, West US failover
- Performance: <200ms response time
- Scale: Support 10,000 concurrent users
```

## Step 2: Generate Tasks

```bash
task-master parse-prd .taskmaster/docs/azure-app-prd.txt
```

TaskMaster creates tasks like:
- Task 1: Set up Azure infrastructure
- Task 2: Configure database
- Task 3: Deploy web application
- Task 4: Set up monitoring

## Step 3: Implement Infrastructure

### Get Current Task
```bash
task-master next
# Shows: Task 1 - Set up Azure infrastructure
```

### Use Azure CLI in Cursor Terminal

```bash
# Create resource group
az group create --name customerportal-prod-rg --location eastus

# Create App Service Plan
az appservice plan create \
  --name customerportal-plan \
  --resource-group customerportal-prod-rg \
  --sku B2 \
  --is-linux

# Create Web App
az webapp create \
  --name customerportal-web \
  --resource-group customerportal-prod-rg \
  --plan customerportal-plan \
  --runtime "NODE|18-lts"

# Create Cosmos DB
az cosmosdb create \
  --name customerportal-db \
  --resource-group customerportal-prod-rg \
  --kind GlobalDocumentDB \
  --locations regionName=eastus failoverPriority=0 \
  --locations regionName=westus failoverPriority=1

# Create Storage Account (for Functions)
az storage account create \
  --name customerportalstorage \
  --resource-group customerportal-prod-rg \
  --sku Standard_LRS

# Create Function App
az functionapp create \
  --name customerportal-functions \
  --resource-group customerportal-prod-rg \
  --storage-account customerportalstorage \
  --consumption-plan-location eastus \
  --runtime node \
  --runtime-version 18

# Create Application Insights
az monitor app-insights component create \
  --app customerportal-insights \
  --location eastus \
  --resource-group customerportal-prod-rg
```

### Generate Implementation Code

```bash
claude code "Create TypeScript configuration module for all Azure resources with connection strings and endpoints"
```

Claude Code generates:

```typescript
// config/azure-config.ts
import { CosmosClient } from '@azure/cosmos';
import { SecretClient } from '@azure/keyvault-secrets';
import { DefaultAzureCredential } from '@azure/identity';

export interface AzureConfig {
  cosmosDb: {
    endpoint: string;
    key: string;
    databaseId: string;
  };
  appService: {
    url: string;
    name: string;
  };
  functions: {
    url: string;
    key: string;
  };
  insights: {
    instrumentationKey: string;
  };
}

export async function getAzureConfig(): Promise<AzureConfig> {
  // Use managed identity in production
  const credential = new DefaultAzureCredential();
  
  // Get from environment or Key Vault
  return {
    cosmosDb: {
      endpoint: process.env.COSMOS_ENDPOINT || '',
      key: process.env.COSMOS_KEY || '',
      databaseId: 'customerportal'
    },
    appService: {
      url: 'https://customerportal-web.azurewebsites.net',
      name: 'customerportal-web'
    },
    functions: {
      url: 'https://customerportal-functions.azurewebsites.net',
      key: process.env.FUNCTIONS_KEY || ''
    },
    insights: {
      instrumentationKey: process.env.APPINSIGHTS_INSTRUMENTATIONKEY || ''
    }
  };
}
```

## Step 4: Update Task Progress

```bash
# Mark infrastructure task complete
task-master set-status --id 1 --status done

# Add implementation notes
task-master update-subtask --id 1.1 --prompt "Created all Azure resources successfully. Connection details stored in azure-config.ts"
```

## Step 5: Continue Workflow

```bash
# Get next task
task-master next
# Shows: Task 2 - Configure database

# Use Claude Code for implementation
claude code "Create Cosmos DB containers with appropriate partition keys for customer data"
```

## Benefits Demonstrated

1. **Speed**: Created entire infrastructure in minutes
2. **Documentation**: Every command is tracked
3. **Repeatability**: Can recreate in any environment
4. **Integration**: Azure CLI + Claude Code + TaskMaster
5. **Best Practices**: Proper naming, regions, and security

## Tips for Your Team

- Use Azure resource tags for cost tracking
- Enable managed identities to avoid storing keys
- Set up resource locks on production resources
- Use Azure Policy for governance
- Monitor costs with budget alerts

## Next Steps

1. Set up CI/CD pipeline
2. Configure custom domains
3. Enable backup policies
4. Set up alerts and dashboards

---

This workflow scales to any Azure infrastructure need, from simple web apps to complex microservices architectures. 