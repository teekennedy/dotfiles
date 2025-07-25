# Platform-specific settings
{config, ...}: {
  # Nix settings are managed by Determinate Nix
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.trusted-users = [config.system.primaryUser];

  environment.etc."nix/nix.custom.conf" = {
    text = ''
      extra-trusted-users = ${builtins.concatStringsSep " " config.nix.settings.trusted-users}
      lazy-trees = true
    '';
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
