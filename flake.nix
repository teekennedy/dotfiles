{
  description = "Teekennedy's dotfiles nix-flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.url = "git+file:///Users/tkennedy/projects/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    alejandra.url = "github:kamadorueda/alejandra/3.1.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    determinate.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    devenv.url = "github:cachix/devenv";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} ({
    withSystem,
    flake-parts-lib,
    ...
  }: let
    inherit (flake-parts-lib) importApply;
    nixModules.default = importApply ./modules/nix {inherit withSystem;};
  in {
    systems = ["aarch64-darwin" "x86_64-linux"];
    imports = [nixModules.default];
    flake = {inherit nixModules;};
  });
  # outputs = inputs@{ self, devenv, determinate, home-manager, nix-darwin, nixpkgs, nixpkgs-darwin, systems }:
  # let
  #   forEachSystem = nixpkgs.lib.genAttrs (import systems);
  #   inherit (nixpkgs) lib;
  #   configuration = { pkgs, ... }: {
  #     # List packages installed in system profile. To search by name, run:
  #     # $ nix-env -qaP | grep wget
  #     environment.systemPackages =
  #       [ pkgs.devenv
  #       ];
  #
  #     # Necessary for using flakes on this system.
  #     nix.settings.experimental-features = "nix-command flakes";
  #     nix.settings.trusted-users = ["tkennedy"];
  #
  #     # Enable alternative shell support in nix-darwin.
  #     # programs.fish.enable = true;
  #
  #     # Set Git commit hash for darwin-version.
  #     system.configurationRevision = self.rev or self.dirtyRev or null;
  #
  #     # Used for backwards compatibility, please read the changelog before changing.
  #     # $ darwin-rebuild changelog
  #     system.stateVersion = 5;
  #
  #     # The platform the configuration will be used on.
  #     nixpkgs.hostPlatform = "aarch64-darwin";
  #
  #   #     programs = {
  #   # direnv = {
  #   #   enable = true;
  #   #   enableZshIntegration = true;
  #   #   nix-direnv.enable = true;
  #   # };
  #   #
  #   # zsh.enable = true;
  #   #   };
  #     # home-manager config
  #     # See https://home-manager-options.extranix.com/ for options
  #       home-manager = {
  #       # If a user package is defined that exists at the system level, install to the user's profile.
  #       useUserPackages = true;
  #       # Use global nixpkgs instead of user-specific configuration under home-manager.users.<name>.nixpkgs
  #       useGlobalPkgs = true;
  #       };
  #
  #   };
  #   devenv-configuration = {
  #   nix.settings.extra-trusted-public-keys = ["devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="];
  #   nix.settings.extra-substituters = ["https://devenv.cachix.org"];
  #
  #   };
  # in
  # {
  #   packages = forEachSystem (system: {
  #     devenv-up = self.devShells.${system}.default.config.procfileScript;
  #   });
  #
  #   devShells =
  #     forEachSystem
  #     (system: let
  #       pkgs = nixpkgs.legacyPackages.${system};
  #     in {
  #       default = devenv.lib.mkShell {
  #         inherit inputs pkgs;
  #         modules = [(import ./devenv.nix {pkgs = pkgs;})];
  #       };
  #     });
  #   # Build darwin flake using:
  #   # $ darwin-rebuild build --flake .#oxygen
  #   darwinConfigurations."oxygen" = nix-darwin.lib.darwinSystem {
  #     modules = [
  #       configuration
  #       determinate.darwinModules.default
  #       home-manager.darwinModules.home-manager
  #       devenv-configuration
  #     ];
  #   };
  #
  #   # Expose the package set, including overlays, for convenience.
  #   darwinPackages = self.darwinConfigurations."oxygen".pkgs;
  # };
}
