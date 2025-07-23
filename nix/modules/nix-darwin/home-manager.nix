# This file sets home-manager options that are specific to nix-darwin installations
{config, ...}: {
  # Use the global pkgs that is configured via the system level nixpkgs options.
  # This saves an extra Nixpkgs evaluation, adds consistency, and removes the dependency on NIX_PATH.
  home-manager.useGlobalPkgs = true;
  # Install user packages under /etc/profiles/per-user/$USER instead of ~/.nix-profile
  home-manager.useUserPackages = true;

  users.users.primary = {
    name = config.system.primaryUser;
    home = "/Users/${config.system.primaryUser}";
  };
  home-manager.users.primary = ../home-manager;
}
