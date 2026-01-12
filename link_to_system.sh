#!/bin/bash
set -e

# Link the local CLI to /usr/local/bin
# Requires sudo

BIN_NAME="spec-agents"
SOURCE_BIN="$(pwd)/bin/$BIN_NAME"
TARGET_LINK="/usr/local/bin/$BIN_NAME"

echo "🔗 Linking '$SOURCE_BIN' to '$TARGET_LINK'..."

if [ ! -f "$SOURCE_BIN" ]; then
    echo "❌ Error: Cannot find binary at $SOURCE_BIN"
    exit 1
fi

chmod +x "$SOURCE_BIN"

if [ -L "$TARGET_LINK" ] || [ -f "$TARGET_LINK" ]; then
    echo "⚠️  Existing command found at $TARGET_LINK. Replacing..."
    sudo rm "$TARGET_LINK"
fi

sudo ln -s "$SOURCE_BIN" "$TARGET_LINK"

echo "✅ Success! You can now use '$BIN_NAME' command anywhere."
echo "   Try running: $BIN_NAME --help"
