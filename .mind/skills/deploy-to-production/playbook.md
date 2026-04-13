# Production Deployment Playbook

## Pre-Deploy Checklist

Before deploying, verify ALL of the following:

- [ ] All tests pass on the branch being deployed
- [ ] Code review approved (no open "Changes Requested")
- [ ] No migrations pending that haven't been tested in staging
- [ ] Environment variables updated in production config (if any new ones)
- [ ] Monitoring dashboards open and showing baseline metrics
- [ ] Rollback plan documented (see below)
- [ ] Team notified in the deployment channel

## Deployment Steps

1. **Tag the release**: `git tag v{version}` following semver
2. **Build the artifact**: run CI pipeline or `docker build`
3. **Deploy to staging first**: verify in staging for at least 10 minutes
4. **Check staging health**: hit health endpoint, run smoke tests
5. **Deploy to production**: trigger production pipeline or push to prod registry
6. **Verify production health** (see Verification below)
7. **Monitor for 15 minutes**: watch error rates, latency, logs

## Verification After Deploy

Run these checks within 5 minutes of deployment:

- [ ] Health endpoint returns 200: `curl -s https://{domain}/health`
- [ ] No new errors in logs: check last 50 log lines for ERROR/FATAL
- [ ] Response time within baseline: p95 latency < {threshold}ms
- [ ] Key user flows work: test 1-2 critical paths manually
- [ ] No spike in error rate on monitoring dashboard

## Rollback Plan

If any verification check fails:

1. **Immediately**: revert to previous version
   - Container: `docker service update --rollback {service}`
   - Git: `git revert {commit}` and redeploy
2. **Notify team**: post in deployment channel with what failed
3. **Investigate**: check logs from the failed deployment window
4. **Document**: create incident report if users were affected

## Decision Points

| Situation | Action |
|-----------|--------|
| Tests pass but staging looks off | Delay deploy, investigate staging |
| Deploy succeeds but error rate rises 2x | Rollback immediately |
| Deploy succeeds, minor non-critical issue | Keep deployed, create follow-up ticket |
| Database migration included | Run migration BEFORE deploying new code |
| Breaking API change | Coordinate with dependent services first |

## Do NOT Deploy When

- It's Friday after 3pm (unless critical hotfix)
- Team member who owns the service is unreachable
- Monitoring system is down or degraded
- Another deployment is in progress
