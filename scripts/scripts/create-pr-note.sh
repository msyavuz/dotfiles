#!/usr/bin/env bash
set -euo pipefail

# Config
NOTES_DIR="$HOME/Notes/Work/Preset"
PR_DIR="$NOTES_DIR/PRs"
TRACKER_FILE="$NOTES_DIR/Reviews.md"
DEFAULT_REPO="apache/superset"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"
DATE="$(date +%Y-%m-%d)"

# Colors
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
RESET="\033[0m"

fetch_pr_title() {
  local repo="$1"
  local pr="$2"
  local api_url="https://api.github.com/repos/${repo}/pulls/${pr}"
  local auth_header=()
  if [ -n "$GITHUB_TOKEN" ]; then
    auth_header=(-H "Authorization: token ${GITHUB_TOKEN}")
  fi

  local tmpfile
  tmpfile="$(mktemp)"
  local http_status

  http_status="$(curl -sS "${auth_header[@]}" \
    -H "Accept: application/vnd.github+json" \
    -H "User-Agent: PR-Note-Script" \
    -o "$tmpfile" \
    -w "%{http_code}" \
    "$api_url")"

  local title message
  case "$http_status" in
    200)
      title="$(jq -r '.title // empty' "$tmpfile")"
      echo "$title"
      ;;
    404)
      echo "ERROR_NOT_FOUND"
      ;;
    401|403)
      message="$(jq -r '.message // empty' "$tmpfile")"
      echo "ERROR_AUTH_OR_RATE: $message"
      ;;
    *)
      message="$(jq -r '.message // empty' "$tmpfile")"
      echo "ERROR_HTTP_${http_status}: ${message}"
      ;;
  esac

  rm -f "$tmpfile"
}

# Main
pr_input="$1"
repo="${2:-$DEFAULT_REPO}"

# Determine if input is a link
if [[ "$pr_input" =~ ^https?://github.com/([^/]+)/([^/]+)/pull/([0-9]+) ]]; then
  owner="${BASH_REMATCH[1]}"
  project="${BASH_REMATCH[2]}"
  pr_number="${BASH_REMATCH[3]}"
  repo="$owner/$project"
  pr_link="$pr_input"
else
  pr_number="$pr_input"
  pr_link="https://github.com/$repo/pull/$pr_number"
fi

mkdir -p "$PR_DIR"

# Fetch PR title
pr_title=$(fetch_pr_title "$repo" "$pr_number" || echo "PR #$pr_number")

# Create PR note file
pr_file="$PR_DIR/$pr_number.md"

if [ -f "$pr_file" ]; then
  echo "❗ File already exists: $pr_file — skipping creation."
else
  # Create PR note
  cat > "$pr_file" <<EOF
# PR ${pr_number}${pr_title:+: $pr_title}

**GitHub:** [$pr_link]($pr_link)

---

## Review Steps
- [ ] Check code for repo standards and potential improvements
- [ ] Verify functionality
- [ ] Confirm tests and coverage
- [ ] Review docs and comments
- [ ] Ensure no regressions

---

## Notes
- 

---

_Created on ${DATE}_
EOF

  echo "✅ Created: $pr_file"

  # Update tracker only if entry does not already exist
  mkdir -p "$(dirname "$TRACKER_FILE")"
  if ! grep -q "\[\[$pr_number\]\]" "$TRACKER_FILE" 2>/dev/null; then
    echo "- [ ] [[${pr_number}]] - [GitHub]($pr_link)${pr_title:+ - $pr_title}" >> "$TRACKER_FILE"
    echo "🪶 Added entry to $TRACKER_FILE"
  fi
fi
