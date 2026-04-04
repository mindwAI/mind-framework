# Hello World — MIND Framework Example

A minimal example showing how a project uses the MIND Framework.

## Structure

```
hello-world/
├── .mind/
│   └── config.yaml    ← Project config (inherits framework defaults)
└── README.md
```

## How It Works

This example project uses the MIND Framework with default configuration. The `.mind/config.yaml` points to the framework's standard personas, commands, rules, and templates.

## Try It

### 1. Create a PRD

Tell your AI agent:

```
Read .mind/commands/create-prd.md from the MIND Framework and follow the
instructions to create a PRD for a simple TODO API.

Adopt the persona in .mind/personas/product-owner.md.
Use the template in .mind/templates/prd-template.md.
```

The agent will:
1. Ask clarification questions (not jump to writing)
2. Plan the PRD structure
3. Write a PRD following the template
4. Present it for your approval

### 2. Create a TechSpec

```
Read .mind/commands/create-techspec.md and create a TechSpec for the
TODO API based on the PRD we just created.

Adopt the persona in .mind/personas/senior-developer.md.
Use the template in .mind/templates/techspec-template.md.
```

### 3. Create Tasks

```
Read .mind/commands/create-tasks.md and decompose the TODO API feature
into tasks based on the PRD and TechSpec.
```

### 4. Implement and Review

```
Read .mind/commands/execute-task.md and implement the first task.
Then read .mind/commands/execute-review.md to review the code.
```

## Customization

To add project-specific rules, create new `.md` files in `.mind/rules/` and reference them in `config.yaml`.
