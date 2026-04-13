#!/bin/sh
# MIND Framework — agent pre-bash hook
# Blocks dangerous shell commands. Agent calls: sh .mind/hooks/agent/pre-bash.sh "$CMD"
# Exit 0 = safe, Exit 1 = blocked.

CMD="$1"

if [ -z "$CMD" ]; then
  echo "Usage: sh pre-bash.sh \"command to validate\""
  exit 0
fi

# Destructive filesystem operations
case "$CMD" in
  *"rm -rf /"*|*"rm -rf /*"*|*"rm -rf ~"*)
    echo "BLOCKED: Recursive delete at root or home directory"; exit 1 ;;
  *"rm -rf ."*)
    echo "BLOCKED: Recursive delete of current directory"; exit 1 ;;
  *"chmod 777"*|*"chmod -R 777"*)
    echo "BLOCKED: World-writable permissions"; exit 1 ;;
  *"> /dev/sd"*|*"> /dev/nvme"*|*"dd if="*"of=/dev/"*)
    echo "BLOCKED: Writing to raw device"; exit 1 ;;
  *"mkfs."*)
    echo "BLOCKED: Formatting filesystem"; exit 1 ;;
esac

# Piping untrusted content to shell
case "$CMD" in
  *"curl"*"|"*"bash"*|*"curl"*"|"*"sh"*|*"wget"*"|"*"bash"*|*"wget"*"|"*"sh"*)
    echo "BLOCKED: Piping remote content to shell without review"; exit 1 ;;
esac

# Credential exposure
case "$CMD" in
  *"--password"*|*"PASSWORD="*)
    echo "WARNING: Command may expose credentials in process list"; exit 1 ;;
esac

exit 0
