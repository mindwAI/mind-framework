---
name: frontend
description: "Frontend conventions for web application code"
scope: "apps/web/**"
---

# Frontend Standards

These rules apply only to files matching `apps/web/**`.

## Components

- One component per file. File name matches component name.
- Props defined as interface, exported for reuse.
- No business logic in components — extract to hooks or services.

## Styling

- Use the project's CSS approach consistently (CSS modules, Tailwind, styled-components).
- No inline styles except for truly dynamic values.
- Responsive design: mobile-first, test at 320px and 1440px.

## Accessibility

- All interactive elements must be keyboard-accessible.
- Images have alt text. Decorative images use `alt=""`.
- Form inputs have associated labels.
