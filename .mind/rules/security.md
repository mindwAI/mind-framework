---
name: security
description: "Security rules applied globally to all code"
---

# Security Standards

These rules apply globally — no scope restriction. Security concerns override convenience.

## Secrets

- Never hardcode secrets, API keys, tokens, or passwords in source code.
- Use environment variables or a secrets manager.
- If you find a secret in code, rotate it immediately — assume it's compromised.
- `.env` files must be in `.gitignore`. Never commit them.

## Input Validation

- Validate all input at system boundaries (API endpoints, CLI arguments, file uploads).
- Use allowlists, not blocklists. Reject by default, accept explicitly.
- Sanitize user input before rendering in HTML (prevent XSS).
- Limit input sizes: max string length, max file size, max array length.

## Database

- Use parameterized queries. Never concatenate user input into SQL strings.
- Apply least-privilege: database users should have minimum required permissions.
- Log failed queries but never log query parameters that contain user data.

## Authentication & Authorization

- Verify auth on every request. Never rely on client-side checks alone.
- Use constant-time comparison for tokens and hashes.
- Set secure defaults: HTTPS only, secure cookies, short token expiry.

## Dependencies

- Review new dependencies before adding. Check: maintenance status, known CVEs, license.
- Pin dependency versions. Use lock files.
- Run dependency audit regularly (`npm audit`, `go mod verify`, `pip-audit`).

## Logging

- Never log passwords, tokens, credit card numbers, or PII.
- Log security events: failed auth, permission denied, rate limit hit.
- Include request ID in security logs for traceability.
