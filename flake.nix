{
  description = "teekennedy's dotfiles flake";

  inputs = {
    nixpkgs.url = "github:numtide/nixpkgs-unfree/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    nix-darwin,
    home-manager,
    self,
    ...
  }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#oxygen
    darwinConfigurations."oxygen" = inputs.nix-darwin.lib.darwinSystem {
      modules = [
        home-manager.darwinModules.home-manager
        ./nix/modules/nix-darwin/default.nix
        ./nix/modules/dev/default.nix
        {
          system.configurationRevision = self.rev or self.dirtyRev or null;
          myUsername = "tkennedy";
        }
      ];
    };
    darwinConfigurations."MJLYCVF4YQ" = inputs.nix-darwin.lib.darwinSystem {
      modules = [
        home-manager.darwinModules.home-manager
        ./nix/modules/nix-darwin/default.nix
        ./nix/modules/dev/default.nix
        {
          system.configurationRevision = self.rev or self.dirtyRev or null;
          myUsername = "terrance.kennedy";
        }
      ];
    };
  };
}
