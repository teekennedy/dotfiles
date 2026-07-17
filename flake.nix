{
  description = "teekennedy's dotfiles flake";

  inputs = {
    determinate.url = "github:DeterminateSystems/determinate";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    determinate,
    nix-darwin,
    home-manager,
    self,
    ...
  }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#$(scutil --get HostName)
    darwinConfigurations.oxygen = nix-darwin.lib.darwinSystem {
      modules = [
        determinate.darwinModules.default
        home-manager.darwinModules.home-manager
        ./nix/modules/nix-darwin/default.nix
        ./nix/modules/dev/default.nix
        ({lib, ...}: {
          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.primaryUser = lib.mkDefault "tkennedy";

          # Configuration state version at time of initial install.
          # Used to maintain backwards compatibility.
          system.stateVersion = 5;
          home-manager.users.primary = {...}: {home.stateVersion = "25.05";};
        })
      ];
    };
  };
}
