# Platform-specific settings
{config, ...}: {
  # Nix settings are managed by Determinate Nix
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.trusted-users = [config.system.primaryUser];

  determinateNix.customSettings = {
    # use all cores in parallel evaluation
    # NB: this is a determinate-nix specific option
    eval-cores = 0;

    extra-trusted-users = config.nix.settings.trusted-users;
    lazy-trees = true;
  };

  # Determinate Nixd runs automatic, disk-pressure-based garbage
  # collection by default. Set here explicitly for reproducibility.
  determinateNix.determinateNixd.garbageCollector.strategy = "automatic";

  # Keep only the last 3 system generations.
  # Pruning post-activation ensures that old generations get cleaned up as soon
  # as new ones are created.
  system.activationScripts.postActivation.text = ''
    echo "pruning old system generations (keeping the last 3)..." >&2
    /nix/var/nix/profiles/default/bin/nix-env \
      -p /nix/var/nix/profiles/system \
      --delete-generations +3
  '';

  # I already have completion init in my dotfiles
  programs.zsh = {
    enableCompletion = false;
    enableBashCompletion = false;
    promptInit = "";
  };
}
