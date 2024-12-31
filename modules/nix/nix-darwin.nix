{
  self,
  config,
  withSystem,
  inputs,
  ...
}: {
  config.flake.darwinConfigurations.oxygen = withSystem "aarch64-darwin" (
    ctx @ {
      inputs',
      pkgs,
      system,
      ...
    }:
      inputs.nix-darwin.lib.darwinSystem {
        modules = [
          {
            nixpkgs.hostPlatform = system;
            nixpkgs.pkgs = pkgs;
            # List packages installed in system profile. To search by name, run:
            # $ nix-env -qaP | grep wget
            environment.systemPackages = [
              pkgs.devenv
            ];

            # Necessary for using flakes on this system.
            nix.settings.experimental-features = "nix-command flakes";
            nix.settings.trusted-users = ["tkennedy"];

            # Enable alternative shell support in nix-darwin.
            # programs.fish.enable = true;

            # Set Git commit hash for darwin-version.
            system.configurationRevision = self.rev or self.dirtyRev or null;

            # Used for backwards compatibility, please read the changelog before changing.
            # $ darwin-rebuild changelog
            system.stateVersion = 5;
          }
          inputs.determinate.darwinModules.default
          # home-manager.darwinModules.home-manager
          # devenv-configuration
        ];
      }
  );
}
