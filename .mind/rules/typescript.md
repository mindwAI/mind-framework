---
name: typescript
description: "TypeScript conventions for frontend code"
scope: "apps/web/**"
---

# TypeScript Standards

These rules apply only to files matching `apps/web/**`.

## Type Safety

- Enable `strict: true` in tsconfig.json. Never disable it per-file.
- Never use `any`. Use `unknown` when the type is genuinely unknowable, then narrow with type guards.
- Prefer `interface` over `type` for object shapes. Use `type` only for unions, intersections, and mapped types.

## Naming

- Components: PascalCase (`UserProfile.tsx`)
- Hooks: camelCase with `use` prefix (`useAuth.ts`)
- Utils: camelCase (`formatDate.ts`)
- Constants: UPPER_SNAKE_CASE (`MAX_RETRIES`)

## Imports

- Absolute imports for cross-module references (`@/components/Button`)
- Relative imports only within the same module (`./utils`)
- No circular imports. If module A imports B and B imports A, extract shared code to C.

## Components

- One component per file. File name matches component name.
- Props as interface, not inline type. Export the interface.
- No business logic in components. Extract to hooks or services.
- Avoid `useEffect` for data fetching — prefer the framework's data loading pattern.

## Error Handling

- API calls must have try/catch with user-visible error feedback.
- Never swallow errors silently (`catch (e) {}`).
- Use error boundaries for component-level failures.
