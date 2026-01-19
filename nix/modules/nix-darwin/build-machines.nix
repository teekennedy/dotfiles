{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nix;
in {
  # These settings do nothing when nix.enable is false.
  # The build machines config is created manually
  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "borg-3";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      maxJobs = 2;
      speedFactor = 2;
    }
    {
      hostName = "borg-2";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      maxJobs = 4;
      speedFactor = 4;
    }
    {
      hostName = "borg-0";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      maxJobs = 1;
      speedFactor = 1;
    }
  ];

  programs.ssh = {
    extraConfig = ''
      Host borg-*
        User tkennedy
        HostName %h.msng.to
        IdentitiesOnly yes
        # This public key is synced from dotfiles
        # The corresponding private key is managed via KeePassXC database
        IdentityFile /Users/${config.system.primaryUser}/.ssh/homelab_ed25519.pub
        IdentityAgent /Users/${config.system.primaryUser}/.ssh/ssh-agent-auth-sock
    '';
    knownHosts = {
      borg-0 = {
        extraHostNames = ["borg-0.msng.to" "10.69.80.10"];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICJQRqBGMXLfQoZqBCHZHC5HBRE+yO9/mimTwiQ5NIcH";
      };
      borg-2 = {
        extraHostNames = ["borg-2.msng.to" "10.69.80.12"];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIILgmviYKe+aSetP4R/UR9OjvaU2mHtT9cXyu8qF4u5q";
      };
      borg-3 = {
        extraHostNames = ["borg-3.msng.to" "10.69.80.13"];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP5lrKIDPYLNaxDpeI/4gN6iOt7Fmx/Ky+Nt53Ogl0c1";
      };
    };
  };

  # This expression "borrowed" from https://github.com/nix-darwin/nix-darwin/blob/0d71cbf88d63e938b37b85b3bf8b238bcf7b39b9/modules/nix/default.nix#L247
  environment.etc."nix/machines" = mkIf (cfg.buildMachines != []) {
    text =
      concatMapStrings
      (
        machine:
          (concatStringsSep " " [
            "${optionalString (machine.protocol != null) "${machine.protocol}://"}${optionalString (machine.sshUser != null) "${machine.sshUser}@"}${machine.hostName}"
            (
              if machine.system != null
              then machine.system
              else if machine.systems != []
              then concatStringsSep "," machine.systems
              else "-"
            )
            (
              if machine.sshKey != null
              then machine.sshKey
              else "-"
            )
            (toString machine.maxJobs)
            (toString machine.speedFactor)
            (let
              res = machine.supportedFeatures ++ machine.mandatoryFeatures;
            in
              if (res == [])
              then "-"
              else (concatStringsSep "," res))
            (let
              res = machine.mandatoryFeatures;
            in
              if (res == [])
              then "-"
              else (concatStringsSep "," machine.mandatoryFeatures))
            (
              if machine.publicHostKey != null
              then machine.publicHostKey
              else "-"
            )
          ])
          + "\n"
      )
      cfg.buildMachines;
  };
}
