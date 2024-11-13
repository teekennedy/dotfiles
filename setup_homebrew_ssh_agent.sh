#!/usr/bin/env zsh
# Script to replace macOS's ssh-agent with Homebrew's every time the current
# user logs in. See README.md for more info.

set -euo pipefail

# Install homebrew's ssh-agent
brew install openssh

HOMEBREW_SSH_AGENT_SERVICE_NAME=net.missingtoken.homebrew_ssh_agent
HOMEBREW_SSH_AGENT_PLIST_PATH="$HOME/Library/LaunchAgents/$HOMEBREW_SSH_AGENT_SERVICE_NAME.plist"

mkdir -p "$(dirname "$HOMEBREW_SSH_AGENT_PLIST_PATH")"

cat <<EOF | sudo tee $HOMEBREW_SSH_AGENT_PLIST_PATH >/dev/null
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>$HOMEBREW_SSH_AGENT_SERVICE_NAME</string>
    <key>ProgramArguments</key>
    <array>
      <string>sh</string>
      <string>-c</string>
      <string>
        NEW_SOCK=\$(mktemp -dt ssh-agent)/auth-sock
        $(which ln) -sf \$NEW_SOCK \$SSH_AUTH_SOCK
        $(brew --prefix)/bin/ssh-agent -D -a \$NEW_SOCK
      </string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <!-- Uncomment this if you need to debug
    <key>StandardOutPath</key>
    <string>/tmp/ssh-agent.out</string>
    <key>StandardErrorPath</key>
    <string>/tmp/ssh-agent.out</string>
    -->
  </dict>
</plist>
EOF

sudo launchctl bootstrap gui/$UID "$HOMEBREW_SSH_AGENT_PLIST_PATH"
