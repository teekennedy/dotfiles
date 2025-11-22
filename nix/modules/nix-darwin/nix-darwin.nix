# Platform-specific settings
{config, ...}: {
  # Nix settings are managed by Determinate Nix
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.trusted-users = [config.system.primaryUser];

  determinate-nix.customSettings = {
    # use all cores in parallel evaluation
    # NB: this is a determinate-nix specific option
    eval-cores = 0;

    extra-trusted-users = config.nix.settings.trusted-users;
    lazy-trees = true;
  };

  # I already have completion init in my dotfiles
  programs.zsh = {
    enableCompletion = false;
    enableBashCompletion = false;
    promptInit = "";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
