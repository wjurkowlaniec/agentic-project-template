#!/usr/bin/env bash
set -euo pipefail

# -----------------------------------------------------------------------------
# init-project.sh — Initialize a new project from new-project-template
# -----------------------------------------------------------------------------

TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ $# -lt 1 ]; then
    echo "Usage: $0 <destination_directory> [project_name] [project_description]"
    echo ""
    echo "Example:"
    echo "  $0 ~/dev/my-tool \"My Tool\" \"Universal high-throughput stream processor.\""
    exit 1
fi

DEST_DIR="$1"
PROJECT_NAME="${2:-"New Project"}"
PROJECT_DESCRIPTION="${3:-"Technical project built with AI pair-programming best practices."}"
TODAY="$(date +%Y-%m-%d)"

echo "==> Creating target directory: $DEST_DIR"
mkdir -p "$DEST_DIR"

echo "==> Copying template files..."
# Copy all files and directories except .git and scripts/init-project.sh
rsync -av --exclude='.git' --exclude='scripts/init-project.sh' "$TEMPLATE_DIR/" "$DEST_DIR/"

echo "==> Substituting template variables in $DEST_DIR..."
# Find all text/markdown/json files and replace placeholders
find "$DEST_DIR" -type f \( -name "*.md" -o -name "*.json*" -o -name "*.sh" -o -name "*.txt" \) | while read -r file; do
    if [ -f "$file" ]; then
        sed -i '' "s|{{PROJECT_NAME}}|$PROJECT_NAME|g" "$file" 2>/dev/null || sed -i "s|{{PROJECT_NAME}}|$PROJECT_NAME|g" "$file"
        sed -i '' "s|{{PROJECT_DESCRIPTION}}|$PROJECT_DESCRIPTION|g" "$file" 2>/dev/null || sed -i "s|{{PROJECT_DESCRIPTION}}|$PROJECT_DESCRIPTION|g" "$file"
        sed -i '' "s|{{DATE}}|$TODAY|g" "$file" 2>/dev/null || sed -i "s|{{DATE}}|$TODAY|g" "$file"
    fi
done

echo "==> Making scripts executable..."
chmod +x "$DEST_DIR"/scripts/*.sh 2>/dev/null || true

# Check if destination is a git repository, if not initialize it
if [ ! -d "$DEST_DIR/.git" ]; then
    echo "==> Initializing git repository in $DEST_DIR..."
    git -C "$DEST_DIR" init
fi

echo ""
echo "========================================================================"
echo "🎉 Project '$PROJECT_NAME' successfully initialized at:"
echo "   $DEST_DIR"
echo ""
echo "Next steps:"
echo "  1. cd \"$DEST_DIR\""
echo "  2. Review and adjust AGENT.md (environment, canonical commands, key paths)"
echo "  3. Start your first AI session by pointing your AI agent to AGENT.md!"
echo "========================================================================"
