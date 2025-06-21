# Platform-specific settings
{
  inputs,
  pkgs,
  ...
}: {
  # Nix settings are managed by Determinate Nix
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
