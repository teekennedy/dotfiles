{config, ...}: let
  serviceName = "net.missingtoken.homebrew_ssh_agent";
in {
  homebrew.brews = ["openssh"];
  launchd.user.agents.homebrew-ssh = {
    serviceConfig = {
      Label = serviceName;
      ProgramArguments = [
        "/bin/sh"
        "-c"
        ''
          if [ -z "$SSH_AUTH_SOCK" ]; then
            exit 1
          fi
          SOCK_DIR=/Users/${config.system.primaryUser}/.ssh/agents
          NEW_SOCK="$SOCK_DIR/s.user"
          mkdir -p "$SOCK_DIR"
          rm -f "$NEW_SOCK"
          /bin/ln -sf "$NEW_SOCK" "$SSH_AUTH_SOCK"
          exec ${config.homebrew.prefix}/bin/ssh-agent -D -a "$NEW_SOCK"
        ''
      ];
      KeepAlive = true;
      RunAtLoad = true;
    };
  };
}
