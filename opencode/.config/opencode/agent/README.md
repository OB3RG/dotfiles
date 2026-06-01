# OpenCode Agent Collaboration Ecosystem

This directory contains specialized agents that work together to provide comprehensive software development assistance. All agents are wired together for seamless collaboration and task delegation.

## Overview

The agent ecosystem is organized into layers:

- **Primary Agents**: Main agents you interact with directly (Orchestrator, Meta-Agent)
- **Specialist Agents (L2)**: Domain experts that handle specific technical areas
- **Implementation Agents (L3)**: Agents that execute tasks based on plans from L2

## Tesseract MCP Integration

All agents have been updated to take full advantage of the **Tesseract MCP** server, which provides powerful project intelligence capabilities. The Tesseract MCP tools enable agents to:

### Code Intelligence
- **Search code** by name or semantic meaning across the entire codebase
- **Analyze call graphs** (callers/callees) to understand code dependencies
- **Assess impact** of changes through dependency blast radius analysis
- **Discover code organization** via module and community detection

### Context & Knowledge
- **Assemble context** from multiple knowledge sources (code, docs, sessions, infra, plans)
- **Search documents** and perform RAG queries over project knowledge
- **Discover domain entities** (people, technologies, concepts, processes)

### Infrastructure
- **Search infrastructure-as-code** resources (Kubernetes, Terraform, CI/CD, Docker)

### Planning & Execution
- **Create and manage execution plans** with trackable steps
- **Discover and save reusable patterns** for common tasks

### Session Memory
- **Recall past sessions** to build on previous work
- **Pin important sessions** for permanent retention

### Agent-Specific Tesseract Tool Mapping

| Agent | Key Tesseract Tools |
|-------|-------------------|
| **Orchestrator** | `project_list`, `project_summary`, `set_project_context`, `plan_*`, `context_assemble`, `pattern_*`, `session_*` |
| **Planner** | `context_assemble`, `document_search`, `domain_query`, `domain_entities`, `plan_*`, `pattern_*`, `session_recall` |
| **Architect** | `context_assemble`, `code_search`, `semantic_code_search`, `code_communities`, `dependency_impact`, `infra_search`, `pattern_*` |
| **Coder** | `context_assemble`, `code_search`, `semantic_code_search`, `code_callers`, `code_callees`, `dependency_impact`, `pattern_*` |
| **Test** | `context_assemble`, `code_search`, `semantic_code_search`, `code_callers`, `code_callees`, `document_search` |
| **Debugger** | `context_assemble`, `code_search`, `semantic_code_search`, `code_callers`, `code_callees`, `dependency_impact`, `session_recall` |
| **Backend-API** | `context_assemble`, `code_search`, `semantic_code_search`, `code_callers`, `code_callees`, `dependency_impact` |
| **Database** | `context_assemble`, `code_search`, `semantic_code_search`, `code_callers`, `code_callees`, `dependency_impact` |
| **Frontend** | `context_assemble`, `code_search`, `semantic_code_search`, `code_callers`, `code_callees`, `dependency_impact` |
| **Security** | `context_assemble`, `code_search`, `semantic_code_search`, `code_callers`, `code_callees`, `dependency_impact` |
| **DevOps** | `context_assemble`, `infra_search`, `code_search`, `semantic_code_search`, `document_search` |
| **Code-Review** | `context_assemble`, `code_search`, `semantic_code_search`, `code_callers`, `code_callees`, `dependency_impact`, `code_communities` |
| **Refactor** | `context_assemble`, `code_search`, `semantic_code_search`, `code_callers`, `code_callees`, `dependency_impact`, `code_communities` |
| **Performance** | `context_assemble`, `code_search`, `semantic_code_search`, `code_callers`, `code_callees`, `dependency_impact` |
| **Documentation** | `context_assemble`, `document_search`, `domain_query`, `domain_entities`, `code_search`, `semantic_code_search` |
| **Advanced-Testing** | `context_assemble`, `code_search`, `semantic_code_search`, `code_callers`, `code_callees` |
| **Localization** | `context_assemble`, `code_search`, `semantic_code_search`, `code_callers`, `code_callees`, `domain_query` |
| **Design-Prototype** | `context_assemble`, `document_search`, `domain_query`, `domain_entities`, `code_search`, `pattern_*` |
| **Committer** | `session_recall`, `session_pin`, `session_set_project` |

## Agent Collaboration Model

### How Agents Work Together

1. **Orchestrator** acts as the primary project manager, delegating to specialist agents based on task requirements
2. **Specialist agents** coordinate with each other to ensure comprehensive solutions
3. Each agent has a "Collaboration with Other Agents" section specifying when and how to work with other agents

### Key Collaboration Patterns

- **Architect <-> Specialist Agents**: Architect coordinates with backend-api, database, frontend, security, and documentation agents to define technical specifications
- **Backend-API <-> Database, Security, Documentation**: API design requires database schema alignment, security review, and documentation
- **Frontend <-> Backend-API, Security, Documentation**: UI components need API integration, security measures, and user guides
- **Test <-> All Specialists**: Test agent coordinates with all specialists to design appropriate test strategies
- **Code-Review <-> All Implementation Agents**: Provides quality feedback throughout development
- **Documentation <-> All Agents**: Ensures all work is properly documented

## Agent Directory

### Primary Agents

#### [Orchestrator](./orchestrator.md) (Primary)
- **Role**: AI Project Manager
- **Purpose**: Manages the entire software development workflow from user request to completion
- **Delegates to**: Planner, Architect, all specialist agents, Coder, Test, Debugger, Security, Committer
- **Key Responsibility**: Plan, delegate, and manage a virtual team of specialist agents
- **Tesseract Tools**: Project management, planning, context assembly, pattern discovery, session management

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
- **Tesseract Tools**: Code search, semantic search, communities, dependency impact, infra search

#### [Planner](./planner.md)
- **Role**: Product Manager
- **Purpose**: Decomposes user goals into detailed specifications, user stories, acceptance criteria
- **Output**: Feature specifications and acceptance criteria
- **Tesseract Tools**: Context assembly, document search, domain queries, planning tools, patterns

### Specialist Layer (L2 - Domain Experts)

#### [Backend-API Specialist](./backend-api.md)
- **Focus**: HTTP REST and GRPC APIs (NOT GraphQL)
- **Responsibilities**: API design, Authentication/authorization, rate limiting, error handling, API versioning
- **Collaborates with**: Architect, Database, Security, Documentation, Test
- **Key**: Uses OpenAPI/Swagger for REST, Protocol Buffers for GRPC
- **Tesseract Tools**: Code search, call graph analysis, dependency impact

#### [Database Specialist](./database.md)
- **Focus**: Database schema design, migrations, query optimization, ORM configuration
- **Responsibilities**: Schema design, migrations, query optimization, data seeding
- **Collaborates with**: Architect, Backend-API, Security, Documentation, Test
- **Key**: Ensures data integrity and performance
- **Tesseract Tools**: Code search, call graph analysis, dependency impact

#### [Frontend Specialist](./frontend.md)
- **Focus**: Web application frontend development
- **Responsibilities**: Responsive design, accessibility, component library, state management, performance
- **Collaborates with**: Architect, Backend-API, Security, Documentation, Test
- **Key**: WCAG 2.1 AA compliance and performance optimization
- **Tesseract Tools**: Code search, call graph analysis, dependency impact

#### [Security Specialist](./security.md)
- **Focus**: Security audits, vulnerability assessments, best practices
- **Responsibilities**: OWASP Top 10, SQL injection prevention, secret detection, compliance
- **Collaborates with**: All agents for security requirements
- **Key**: Follows OWASP, CIS benchmarks, and industry standards
- **Tesseract Tools**: Code search, call graph analysis, dependency impact

#### [DevOps Specialist](./devops.md)
- **Focus**: CI/CD pipelines, Docker, infrastructure automation
- **Responsibilities**: CI/CD configuration, containerization, environment management, deployment
- **Collaborates with**: All agents for infrastructure needs
- **Key**: GitHub Actions, Docker, IaC tools
- **Tesseract Tools**: Infra search, code search, context assembly

#### [Documentation Specialist](./documentation.md)
- **Focus**: Technical writing following Red Hat writing guidelines
- **Responsibilities**: Project docs, API documentation, code comments, changelogs
- **Collaborates with**: All agents for documentation needs
- **Key**: Follows Red Hat writing guidelines for clarity, consistency, and minimalism
- **Tesseract Tools**: Document search, domain queries, domain entities, code search

#### [Performance Optimizer](./performance-optimizer.md)
- **Focus**: Performance profiling, bottleneck identification, optimization
- **Responsibilities**: Performance analysis, memory management, bundle optimization, caching
- **Collaborates with**: All agents for performance considerations
- **Key**: Always measure before and after optimizing
- **Tesseract Tools**: Code search, call graph analysis, dependency impact

#### [Refactor Specialist](./refactor.md)
- **Focus**: Technical debt management, code quality improvement
- **Responsibilities**: Code smell detection, legacy code modernization, architecture evolution
- **Collaborates with**: Code-Review, Test, Documentation, and domain specialists
- **Key**: Preserves behavior while improving code
- **Tesseract Tools**: Code search, call graph analysis, dependency impact, code communities

#### [Localization Specialist](./localization.md)
- **Focus**: Internationalization (i18n) and localization (l10n)
- **Responsibilities**: i18n setup, translation management, RTL support, locale-aware formatting
- **Collaborates with**: Frontend, Backend-API, Documentation, Test
- **Key**: Cultural appropriateness and professional translation
- **Tesseract Tools**: Code search, call graph analysis, domain queries

#### [Code Review Specialist](./code-review.md)
- **Focus**: Code quality, design patterns, maintainability
- **Responsibilities**: Quality assessment, best practices enforcement, consistency review
- **Collaborates with**: All agents for continuous improvement
- **Key**: Does NOT fix code, only reviews and reports
- **Tesseract Tools**: Code search, call graph analysis, dependency impact, code communities

#### [Advanced Testing Specialist](./advanced-testing.md)
- **Focus**: E2E testing, performance testing, contract testing, visual regression
- **Responsibilities**: Complex testing beyond unit/integration tests
- **Collaborates with**: Test agent and all specialists
- **Key**: Handles specialized testing scenarios
- **Tesseract Tools**: Code search, call graph analysis, context assembly

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
- **Tesseract Tools**: Code search, semantic search, call graph analysis, dependency impact, patterns

#### [Test](./test.md)
- **Role**: QA Engineer
- **Purpose**: Generates unit and integration tests, runs test suite, self-heals broken tests
- **Collaborates with**: All agents for test coverage
- **Key**: Generates tests based on acceptance criteria
- **Tesseract Tools**: Code search, semantic search, call graph analysis, context assembly

#### [Debugger](./debugger.md)
- **Role**: Root Cause Analyst
- **Purpose**: Performs RCA when tests fail, correlates logs and code changes
- **Collaborates with**: Test, all specialists for investigation
- **Key**: Invoked ONLY after test failure
- **Tesseract Tools**: Code search, semantic search, call graph analysis, dependency impact, session recall

#### [Committer](./committer.md)
- **Role**: Git Operations Specialist
- **Purpose**: Creates atomic conventional commits
- **Key Constraint**: Always ASK user before invoking
- **Tesseract Tools**: Session management

## Using the Agent Ecosystem

### Automatic Delegation

Agents are automatically invoked based on their descriptions:

```
User: "Create a REST API for user management"
-> Orchestrator delegates to:
  -> Planner (for specs)
  -> Architect (for technical constraints)
  -> Backend-API (for API design)
  -> Database (for schema design)
  -> Coder (for implementation)
  -> Test (for testing)
  -> Security (for audit)
  -> Documentation (for API docs)
```

### Manual Invocation

You can manually invoke any agent using the `@` mention:

```
User: "@backend-api help me design endpoints for user CRUD operations"
```

### Collaboration Flow Example

When implementing a new feature:

1. **Orchestrator** receives user request and sets project context via Tesseract
2. **Orchestrator** assembles context using `tesseract_context_assemble`
3. **Planner** creates detailed specifications using Tesseract document and domain tools
4. **Architect** defines technical constraints using Tesseract code analysis tools
5. **Specialist agents** (backend-api, database, frontend, etc.) provide domain expertise with Tesseract code search
6. **Coder** implements the feature following the plan, using Tesseract code search and call graph tools
7. **Test** generates and runs tests using Tesseract context and code analysis
8. **Security** audits for vulnerabilities using Tesseract code search and call graph analysis
9. **Debugger** investigates any failures (if needed) using Tesseract call graph and session recall
10. **Documentation** creates/updates docs using Tesseract document and domain tools
11. **Committer** creates git commit (with user approval)

## Agent Configuration

All agents are configured as subagents with:

- **mode**: subagent (except Orchestrator and Meta-Agent which are primary)
- **description**: Clear, action-oriented text for automatic delegation
- **tools**: Minimal set of tools required for the agent's role, including relevant Tesseract MCP tools
- **temperature**: Low values (0.0-0.15) for consistent, deterministic outputs

## Creating New Agents

To create a new agent:

1. Use `@meta-agent` and describe the agent's purpose
2. The meta-agent will generate a complete agent configuration file
3. Ensure the new agent includes a "Collaboration with Other Agents" section
4. Ensure the new agent includes relevant Tesseract MCP tools in its tools section
5. Update the Orchestrator's specialist team list if appropriate

## Agent Collaboration Guidelines

When creating or modifying agents:

1. **Clear Description**: Use action-oriented language ("Use proactively for...")
2. **Collaboration Section**: Specify which agents to work with and when
3. **Tool Access**: Configure appropriate tools while limiting unnecessary access
4. **Tesseract Integration**: Include relevant Tesseract MCP tools for code analysis, context assembly, and knowledge retrieval
5. **Consistent Output**: Follow structured output format used by other agents
6. **Delegation Paths**: Ensure Orchestrator can delegate appropriately

## Agent Relationships

```
Orchestrator (Primary)
|-- Planner (L2)
|-- Architect (L2)
|   |-- Backend-API
|   |-- Database
|   |-- Frontend
|   |-- Security
|   |-- DevOps
|   |-- Documentation
|   |-- Performance-Optimizer
|   |-- Refactor
|   |-- Localization
|   |-- Code-Review
|   +-- Advanced-Testing
|-- Specialist Agents (L2)
|-- Research (L2)
|-- Coder (L3)
|-- Test (L3)
|-- Debugger (L3)
|-- Security (L2/L3)
+-- Committer (L3)
```

## Best Practices

1. **Let Orchestrator manage**: Start with Orchestrator for complex tasks involving multiple domains
2. **Use specific agents**: Directly invoke specialist agents for focused tasks in their domain
3. **Follow collaboration patterns**: Agents will coordinate with each other automatically
4. **Review agent suggestions**: Agents provide recommendations for further improvements
5. **Keep documentation updated**: Documentation agent ensures all work is properly documented
6. **Leverage Tesseract MCP**: Agents use Tesseract tools for code intelligence, context assembly, and knowledge retrieval

## Additional Resources

- [OpenCode Agents Documentation](https://opencode.ai/docs/agents/)
- [OpenCode Tools Documentation](https://opencode.ai/docs/tools/)
- [Red Hat Writing Guidelines](https://redhat-documentation.github.io/supplementary-style-guide/)
