{
  config,
  inputs,
  pkgs,
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
      hostName = "borg-2";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      maxJobs = 4;
      speedFactor = 4;
    }
    {
      hostName = "borg-1";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      maxJobs = 2;
      speedFactor = 2;
    }
    {
      hostName = "borg-0";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      maxJobs = 1;
      speedFactor = 1;
    }
  ];

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
