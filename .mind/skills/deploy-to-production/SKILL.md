---
name: Deploy to Production
triggers:
  keywords: [deploy, production, release, rollout]
  paths: [Dockerfile, .github/workflows/**, deploy/**, docker-compose*.yml]
---

# Deploy to Production

This skill activates when the task involves deploying to production.
Load `playbook.md` for the full pre-deploy checklist, deployment steps,
verification procedure, and rollback plan.
