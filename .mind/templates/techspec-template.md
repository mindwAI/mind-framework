# TechSpec — [Feature Name]

**PRD:** [PRD path]

## Executive Summary

[Technical approach in 2-3 paragraphs. Main architectural decisions and justifications.]

## Constraints and Assumptions

### Constraints
- [business, architecture, or stack constraint]

### Prior Decisions
- [technical decisions already made that affect this feature]

### Open Assumptions
- [assumptions not yet validated]

## Technical Context

| Dimension | Choice | Justification |
|-----------|--------|---------------|
| Language/Runtime | [e.g., Node.js 20, Go 1.22] | [why] |
| Dependencies | [main libs] | [why these] |
| Storage | [e.g., PostgreSQL, Redis] | [why] |
| Tests | [framework and strategy] | [why] |
| Deploy/Infra | [environment and tools] | [why] |
| Security | [authentication, authorization] | [why] |

## System Architecture

[Overview of components, their responsibilities, and how they relate.]

### Components

| Component | Responsibility | Dependencies |
|-----------|---------------|--------------|
| [name] | [what it does] | [what it depends on] |

### Diagram (optional)

```
[ASCII diagram or reference to external diagram]
```

## Implementation Design

### Main Interfaces

[Service abstractions and use cases. Max ~20 lines each.]

```
[interface or function signature]
```

### Data Models

[Domain entities, request/response types, database schemas.]

```
[model or schema]
```

### API Contracts

[Endpoints, methods, input/output payloads.]

| Method | Path | Description | Request | Response |
|--------|------|-------------|---------|----------|
| [GET/POST/...] | [/path] | [what it does] | [payload] | [response] |

## Integration Points

[External services, third-party APIs, authentication, error handling.]

| Integration | Type | Auth | Error Handling |
|------------|------|------|----------------|
| [name] | [REST/gRPC/SDK] | [type] | [strategy] |

## Test Approach

### Unit Tests
- [what to test per unit]

### Integration Tests
- [what to test end-to-end between components]

### Coverage Strategy
- [threshold, priorities]

## Development Sequencing

[Build order with justification and technical dependencies.]

| Order | Component | Depends on | Justification |
|-------|-----------|------------|---------------|
| 1 | [component] | — | [why first] |
| 2 | [component] | 1 | [why after] |

## Observability

- **Logging:** [strategy and log points]
- **Metrics:** [metrics to expose]
- **Alerts:** [alert conditions]

## Technical Considerations

- **Key decisions:** [decisions and trade-offs]
- **Reuse vs build:** [what to reuse, what to build]
- **Known risks:** [technical risks and mitigations]

## Task Creation Readiness Criteria

- [ ] Components and interfaces defined
- [ ] Build order clear
- [ ] Test strategy outlined
- [ ] Observability and risks mapped
- [ ] Open assumptions don't block task creation
