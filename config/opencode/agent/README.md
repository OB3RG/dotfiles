# OpenCode Agent Collaboration Ecosystem

This directory contains specialized agents that work together to provide comprehensive software development assistance. All agents are wired together for seamless collaboration and task delegation.

## Overview

The agent ecosystem is organized into layers:

- **Primary Agents**: Main agents you interact with directly (Orchestrator, Meta-Agent)
- **Specialist Agents (L2)**: Domain experts that handle specific technical areas
- **Implementation Agents (L3)**: Agents that execute tasks based on plans from L2

## Agent Collaboration Model

### How Agents Work Together

1. **Orchestrator** acts as the primary project manager, delegating to specialist agents based on task requirements
2. **Specialist agents** coordinate with each other to ensure comprehensive solutions
3. Each agent has a "Collaboration with Other Agents" section specifying when and how to work with other agents

### Key Collaboration Patterns

- **Architect ↔ Specialist Agents**: Architect coordinates with backend-api, database, frontend, security, and documentation agents to define technical specifications
- **Backend-API ↔ Database, Security, Documentation**: API design requires database schema alignment, security review, and documentation
- **Frontend ↔ Backend-API, Security, Documentation**: UI components need API integration, security measures, and user guides
- **Test ↔ All Specialists**: Test agent coordinates with all specialists to design appropriate test strategies
- **Code-Review ↔ All Implementation Agents**: Provides quality feedback throughout development
- **Documentation ↔ All Agents**: Ensures all work is properly documented

## Agent Directory

### Primary Agents

#### [Orchestrator](./orchestrator.md) (Primary)
- **Role**: AI Project Manager
- **Purpose**: Manages the entire software development workflow from user request to completion
- **Delegates to**: Planner, Architect, all specialist agents, Coder, Test, Debugger, Security, Committer
- **Key Responsibility**: Plan, delegate, and manage a virtual team of specialist agents

#### [Meta-Agent](./meta-agent.md) (Primary)
- **Role**: Agent Architect
- **Purpose**: Creates new sub-agent configuration files based on user descriptions
- **Use when**: Need to create a new specialized agent

### Planning & Architecture Layer (L2)

#### [Architect](./architect.md)
- **Role**: Knowledge Architect
- **Purpose**: Defines technical constraints, selects technology, designs system architecture
- **Collaborates with**: All specialist agents to ensure domain expertise is applied
- **Output**: Technical specifications, constraints, and architectural guidelines

#### [Planner](./planner.mnd)
- **Role**: Product Manager
- **Purpose**: Decomposes user goals into detailed specifications, user stories, acceptance criteria
- **Output**: Feature specifications and acceptance criteria

### Specialist Layer (L2 - Domain Experts)

#### [Backend-API Specialist](./backend-api.md)
- **Focus**: HTTP REST and GRPC APIs (NOT GraphQL)
- **Responsibilities**: API design, authentication/authorization, rate limiting, error handling, API versioning
- **Collaborates with**: Architect, Database, Security, Documentation, Test
- **Key**: Uses OpenAPI/Swagger for REST, Protocol Buffers for GRPC

#### [Database Specialist](./database.md)
- **Focus**: Database schema design, migrations, query optimization, ORM configuration
- **Responsibilities**: Schema design, migrations, query optimization, data seeding
- **Collaborates with**: Architect, Backend-API, Security, Documentation, Test
- **Key**: Ensures data integrity and performance

#### [Frontend Specialist](./frontend.md)
- **Focus**: Web application frontend development
- **Responsibilities**: Responsive design, accessibility, component library, state management, performance
- **Collaborates with**: Architect, Backend-API, Security, Documentation, Test
- **Key**: WCAG 2.1 AA compliance and performance optimization

#### [Security Specialist](./security.md)
- **Focus**: Security audits, vulnerability assessments, best practices
- **Responsibilities**: OWASP Top 10, SQL injection prevention, secret detection, compliance
- **Collaborates with**: All agents for security requirements
- **Key**: Follows OWASP, CIS benchmarks, and industry standards

#### [DevOps Specialist](./devops.md)
- **Focus**: CI/CD pipelines, Docker, infrastructure automation
- **Responsibilities**: CI/CD configuration, containerization, environment management, deployment
- **Collaborates with**: All agents for infrastructure needs
- **Key**: GitHub Actions, Docker, IaC tools

#### [Documentation Specialist](./documentation.md)
- **Focus**: Technical writing following Red Hat writing guidelines
- **Responsibilities**: Project docs, API documentation, code comments, changelogs
- **Collaborates with**: All agents for documentation needs
- **Key**: Follows Red Hat writing guidelines for clarity, consistency, and minimalism

#### [Performance Optimizer](./performance-optimizer.md)
- **Focus**: Performance profiling, bottleneck identification, optimization
- **Responsibilities**: Performance analysis, memory management, bundle optimization, caching
- **Collaborates with**: All agents for performance considerations
- **Key**: Always measure before and after optimizing

#### [Refactor Specialist](./refactor.md)
- **Focus**: Technical debt management, code quality improvement
- **Responsibilities**: Code smell detection, legacy code modernization, architecture evolution
- **Collaborates with**: Code-Review, Test, Documentation, and domain specialists
- **Key**: Preserves behavior while improving code

#### [Localization Specialist](./localization.md)
- **Focus**: Internationalization (i18n) and localization (l10n)
- **Responsibilities**: i18n setup, translation management, RTL support, locale-aware formatting
- **Collaborates with**: Frontend, Backend-API, Documentation, Test
- **Key**: Cultural appropriateness and professional translation

#### [Code Review Specialist](./code-review.md)
- **Focus**: Code quality, design patterns, maintainability
- **Responsibilities**: Quality assessment, best practices enforcement, consistency review
- **Collaborates with**: All agents for continuous improvement
- **Key**: Does NOT fix code, only reviews and reports

#### [Advanced Testing Specialist](./advanced-testing.md)
- **Focus**: E2E testing, performance testing, contract testing, visual regression
- **Responsibilities**: Complex testing beyond unit/integration tests
- **Collaborates with**: Test agent and all specialists
- **Key**: Handles specialized testing scenarios

### Research & Exploration

#### [Research](.) (not yet implemented)
- **Role**: Technical Researcher
- **Purpose**: Investigates new libraries and answers complex technical questions
- **Use when**: Need to vet new technologies or do deep research

#### [Explore](.) (built-in)
- **Role**: Codebase Explorer
- **Purpose**: Fast read-only exploration of codebase
- **Use when**: Need to find files, search code, or answer quick questions

### Implementation & Verification Layer (L3)

#### [Coder](./coder.md)
- **Role**: Developer
- **Purpose**: Implements code based on plans from Planner and Architect
- **Key Constraint**: Does NOT make architectural decisions, only implementation

#### [Test](./test.md)
- **Role**: QA Engineer
- **Purpose**: Generates unit and integration tests, runs test suite, self-heals broken tests
- **Collaborates with**: All agents for test coverage
- **Key**: Generates tests based on acceptance criteria

#### [Debugger](./debugger.md)
- **Role**: Root Cause Analyst
- **Purpose**: Performs RCA when tests fail, correlates logs and code changes
- **Collaborates with**: Test, all specialists for investigation
- **Key**: Invoked ONLY after test failure

#### [Committer](./committer.md)
- **Role**: Git Operations Specialist
- **Purpose**: Creates atomic conventional commits
- **Key Constraint**: Always ASK user before invoking

## Using the Agent Ecosystem

### Automatic Delegation

Agents are automatically invoked based on their descriptions:

```
User: "Create a REST API for user management"
→ Orchestrator delegates to:
  → Planner (for specs)
  → Architect (for technical constraints)
  → Backend-API (for API design)
  → Database (for schema design)
  → Coder (for implementation)
  → Test (for testing)
  → Security (for audit)
  → Documentation (for API docs)
```

### Manual Invocation

You can manually invoke any agent using the `@` mention:

```
User: "@backend-api help me design endpoints for user CRUD operations"
```

### Collaboration Flow Example

When implementing a new feature:

1. **Orchestrator** receives user request
2. **Planner** creates detailed specifications
3. **Architect** defines technical constraints, consulting specialists as needed
4. **Specialist agents** (backend-api, database, frontend, etc.) provide domain expertise
5. **Coder** implements the feature following the plan
6. **Test** generates and runs tests
7. **Security** audits for vulnerabilities
8. **Debugger** investigates any failures (if needed)
9. **Documentation** creates/update docs
10. **Committer** creates git commit (with user approval)

## Agent Configuration

All agents are configured as subagents with:

- **mode**: subagent (except Orchestrator and Meta-Agent which are primary)
- **description**: Clear, action-oriented text for automatic delegation
- **tools**: Minimal set of tools required for the agent's role
- **model**: zai-coding-plan/glm-4.7
- **temperature**: Low values (0.0-0.15) for consistent, deterministic outputs

## Creating New Agents

To create a new agent:

1. Use `@meta-agent` and describe the agent's purpose
2. The meta-agent will generate a complete agent configuration file
3. Ensure the new agent includes a "Collaboration with Other Agents" section
4. Update the Orchestrator's specialist team list if appropriate

## Agent Collaboration Guidelines

When creating or modifying agents:

1. **Clear Description**: Use action-oriented language ("Use proactively for...")
2. **Collaboration Section**: Specify which agents to work with and when
3. **Tool Access**: Configure appropriate tools while limiting unnecessary access
4. **Consistent Output**: Follow structured output format used by other agents
5. **Delegation Paths**: Ensure Orchestrator can delegate appropriately

## Key Changes Made

### Backend-API Specialist
- **Updated to focus on HTTP REST and GRPC APIs** (removed GraphQL focus)
- Added GRPC-specific sections for service definitions, proto files, and streaming
- Enhanced collaboration section to work with database, security, and documentation
- Added separate sections for REST and GRPC API design

### Documentation Specialist
- **Updated to follow Red Hat writing guidelines**
- Added comprehensive Red Hat writing guidelines section including:
  - Grammar and language (no contractions, conscious language, minimalism)
  - Formatting (bold commands, separate output, single-step procedures)
  - Structure (admonitions, lead-in sentences, prerequisites, short descriptions)
  - Technical examples, accessibility, links
- Enhanced collaboration section with all specialist agents
- Added accessibility and style compliance notes

### All Specialist Agents
- Added "Collaboration with Other Agents" sections to 14 specialist agents
- Enhanced descriptions for automatic delegation
- Ensured consistent output formats across agents

## Agent Relationships

```
Orchestrator (Primary)
├── Planner (L2)
├── Architect (L2)
│   ├── Backend-API
│   ├── Database
│   ├── Frontend
│   ├── Security
│   ├── DevOps
│   ├── Documentation
│   ├── Performance-Optimizer
│   ├── Refactor
│   ├── Localization
│   ├── Code-Review
│   └── Advanced-Testing
├── Specialist Agents (L2)
├── Research (L2)
├── Coder (L3)
├── Test (L3)
├── Debugger (L3)
├── Security (L2/L3)
└── Committer (L3)
```

## Best Practices

1. **Let Orchestrator manage**: Start with Orchestrator for complex tasks involving multiple domains
2. **Use specific agents**: Directly invoke specialist agents for focused tasks in their domain
3. **Follow collaboration patterns**: Agents will coordinate with each other automatically
4. **Review agent suggestions**: Agents provide recommendations for further improvements
5. **Keep documentation updated**: Documentation agent ensures all work is properly documented

## Additional Resources

- [OpenCode Agents Documentation](https://opencode.ai/docs/agents/)
- [OpenCode Tools Documentation](https://opencode.ai/docs/tools/)
- [Red Hat Writing Guidelines](https://redhat-documentation.github.io/supplementary-style-guide/)
