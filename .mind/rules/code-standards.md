# Code Standards

Code standards applicable to the entire project. Agents must consult this document before implementing or reviewing code.

## Code Language

All code in **English**: variables, functions, classes, comments, inline documentation.

## Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Methods / Functions | camelCase | `processPayment`, `getUserById` |
| Variables | camelCase | `totalAmount`, `isActive` |
| Classes / Interfaces | PascalCase | `PaymentService`, `UserRepository` |
| Constants | UPPER_SNAKE_CASE | `MAX_RETRIES`, `DEFAULT_TIMEOUT` |
| Files / Directories | kebab-case | `payment-service.ts`, `user-repository/` |

> **Note:** Adapt naming conventions to the project's language (e.g., snake_case for Python/Go, camelCase for JS/TS). Consistency is what matters.

## Clear Names

- Names should express intent without ambiguity.
- Avoid abbreviations (`usr` → `user`, `proc` → `process`).
- Names up to 30 characters — if you need more, the concept should be simplified.

## Constants and Magic Numbers

- **Never** use literal numbers in the middle of code.
- Define constants with meaningful names:
  ```
  // Bad
  if (retries > 3) { ... }
  
  // Good
  const MAX_RETRIES = 3;
  if (retries > MAX_RETRIES) { ... }
  ```

## Methods and Functions

- Names must **start with a verb** (never a noun): `calculate`, `validate`, `send`.
- One function, one purpose. If the name needs "and", break it in two.
- **Maximum 3 parameters.** If you need more, use a configuration object.

## Side Effects

- Functions should **either mutate state OR query** — never both.
- No hidden side-effects in functions that appear pure.

## Conditionals

- **Maximum 2 levels of nesting.** If you need more, use early returns or extract functions.
- Prefer early returns to reduce nesting:
  ```
  // Bad
  function process(data) {
    if (data) {
      if (data.isValid) {
        // logic
      }
    }
  }
  
  // Good
  function process(data) {
    if (!data) return;
    if (!data.isValid) return;
    // logic
  }
  ```

## Flag Parameters

- **Never** use booleans as behavior control parameters.
- Extract separate functions instead of using flags:
  ```
  // Bad
  function getUsers(includeInactive: boolean) { ... }
  
  // Good
  function getActiveUsers() { ... }
  function getAllUsers() { ... }
  ```

## Size

- Methods: **< 50 lines.** If longer, break into smaller functions.
- Classes/Modules: **< 300 lines.** If longer, there are too many responsibilities.

## Formatting

- Avoid blank lines within methods — if you need to separate blocks, extract into functions.

## Comments

- **Avoid comments** — code should be self-explanatory.
- If a section needs a comment to be understood, simplify the code.
- Comments are acceptable for: non-obvious decisions, trade-offs, and external references.

## Variable Declarations

- One variable per line.
- Declare variables as close as possible to first use.

## Business Logic

- **No business logic in controllers/handlers** — controllers orchestrate, services execute.
- Presentation layer must not contain business rules.
