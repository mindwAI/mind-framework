# Incident Response Runbook

## Severity Classification

| Severity | Criteria | Response Time | Escalation |
|----------|----------|---------------|------------|
| **SEV-1** | Service completely down, all users affected | Immediate | Page on-call + notify leadership |
| **SEV-2** | Major feature broken, many users affected | < 30 minutes | Notify on-call + team channel |
| **SEV-3** | Minor feature broken, workaround exists | < 2 hours | Team channel |
| **SEV-4** | Cosmetic issue, no user impact | Next business day | Create ticket |

## First 5 Minutes

1. **Acknowledge** the alert/report in the team channel
2. **Classify severity** using the table above
3. **Check dashboards**: error rates, latency, uptime
4. **Check recent changes**: was anything deployed in the last hour?
5. **Decide**: mitigate now (rollback, feature flag, scale) or investigate

## Investigation Steps

1. **Timeline**: when did it start? Correlate with deployments, config changes, external events
2. **Scope**: which users/endpoints/services are affected?
3. **Logs**: check application logs for ERROR/FATAL in the affected window
4. **Metrics**: compare current metrics to baseline (error rate, latency, throughput)
5. **Dependencies**: check if external services (DB, cache, third-party APIs) are healthy
6. **Reproduce**: can you trigger the issue with a specific request?

## Mitigation Actions

| Cause | First Action |
|-------|-------------|
| Bad deployment | Rollback to previous version |
| Database issue | Check connections, locks, slow queries |
| External service down | Enable fallback/circuit breaker |
| Traffic spike | Scale up, enable rate limiting |
| Configuration error | Revert config change |
| Data corruption | Stop writes, assess scope, restore from backup |

## Communication Template

```
**[SEV-{N}] {Service} — {Brief description}**

**Status**: Investigating / Mitigating / Resolved
**Impact**: {Who is affected and how}
**Started**: {timestamp}
**Last update**: {timestamp}
**Next update**: in {N} minutes

**What we know**: {1-2 sentences}
**What we're doing**: {Current action}
```

Post updates every 15 minutes for SEV-1, every 30 minutes for SEV-2.

## After Resolution

1. **Verify**: confirm the issue is resolved, monitor for 30 minutes
2. **Communicate**: post resolution message in team channel
3. **Create postmortem** (required for SEV-1 and SEV-2)

## Postmortem Format

```markdown
# Postmortem — {Date} — {Brief title}

## Summary
{1-2 sentences: what happened, impact, duration}

## Timeline
{Chronological list of events with timestamps}

## Root Cause
{What actually caused the issue — not symptoms}

## Impact
- Users affected: {number or percentage}
- Duration: {start to resolution}
- Data loss: {yes/no, details}

## What Went Well
- {things that helped resolve faster}

## What Went Wrong
- {things that caused the issue or slowed resolution}

## Action Items
| Action | Owner | Due Date |
|--------|-------|----------|
| {preventive measure} | {person} | {date} |
```
