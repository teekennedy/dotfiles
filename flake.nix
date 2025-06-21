{
  description = "teekennedy's dotfiles flake";

  inputs = {
    nixpkgs.url = "github:numtide/nixpkgs-unfree/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    nix-darwin,
    self,
    ...
  }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#oxygen
    darwinConfigurations."oxygen" = inputs.nix-darwin.lib.darwinSystem {
      modules = [
        ./nix/modules/nix-darwin/default.nix
        ./nix/modules/dev/default.nix

        {system.configurationRevision = self.rev or self.dirtyRev or null;}
      ];
    };
  };
}
