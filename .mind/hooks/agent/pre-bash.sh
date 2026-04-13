#!/bin/sh
# MIND Framework — agent pre-bash hook
# Blocks dangerous shell commands. Agent calls: sh .mind/hooks/agent/pre-bash.sh "$CMD"
# Exit 0 = safe, Exit 1 = blocked.

CMD="$1"

if [ -z "$CMD" ]; then
  echo "Usage: sh pre-bash.sh \"command to validate\""
  exit 0
fi

# --- Critical system paths (word-boundary safe) ---
# Extract the target path from rm commands for precise matching
RM_TARGET=""
case "$CMD" in
  *"rm -rf "*|*"rm -Rf "*|*"rm -r -f "*)
    RM_TARGET="$(echo "$CMD" | sed 's/.*rm -[rR][fF] *//' | sed 's/ .*//')"
    ;;
esac

if [ -n "$RM_TARGET" ]; then
  case "$RM_TARGET" in
    /|/bin|/bin/*|/etc|/etc/*|/usr|/usr/*|/var|/var/*|/lib|/lib/*|/sbin|/sbin/*|/boot|/boot/*|/root|/root/*|/home|/home/*|/opt|/opt/*|/srv|/srv/*)
      # Allow /tmp explicitly
      case "$RM_TARGET" in /tmp|/tmp/*) ;; *)
        echo "BLOCKED: Recursive delete at critical system path: $RM_TARGET"; exit 1
      ;; esac
      ;;
  esac
fi

# --- Home directory deletes (multiple representations) ---
case "$CMD" in
  *"rm -rf ~"*|*"rm -Rf ~"*|*"rm -rf ~/")
    echo "BLOCKED: Recursive delete at home directory (~)"; exit 1 ;;
  *'rm -rf $HOME'*|*'rm -Rf $HOME'*|*'rm -rf ${HOME}'*|*'rm -Rf ${HOME}'*)
    echo "BLOCKED: Recursive delete at home directory (\$HOME)"; exit 1 ;;
esac

# --- Raw device writes ---
case "$CMD" in
  *"> /dev/sd"*|*"> /dev/nvme"*|*"dd if="*"of=/dev/"*)
    echo "BLOCKED: Writing to raw device"; exit 1 ;;
  *"mkfs."*)
    echo "BLOCKED: Formatting filesystem"; exit 1 ;;
esac

# --- World-writable permissions ---
case "$CMD" in
  *"chmod 777"*|*"chmod -R 777"*)
    echo "BLOCKED: World-writable permissions"; exit 1 ;;
esac

# --- Piping untrusted content to shell ---
case "$CMD" in
  *"curl"*"|"*"bash"*|*"curl"*"|"*"sh"*|*"wget"*"|"*"bash"*|*"wget"*"|"*"sh"*)
    echo "BLOCKED: Piping remote content to shell without review"; exit 1 ;;
esac

# --- Credential exposure ---
case "$CMD" in
  *"--password"*|*"PASSWORD="*)
    echo "WARNING: Command may expose credentials in process list"; exit 1 ;;
esac

exit 0
