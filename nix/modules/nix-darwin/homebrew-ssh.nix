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
          NEW_SOCK=/Users/${config.system.primaryUser}/.ssh/ssh-agent-auth-sock
          /bin/ln -sf "$NEW_SOCK" "$SSH_AUTH_SOCK"
          exec ${config.homebrew.brewPrefix}/bin/ssh-agent -D -a "$NEW_SOCK"
        ''
      ];
      RunAtLoad = true;
    };
  };
}
