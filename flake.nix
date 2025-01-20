{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
  };

  outputs = {
    determinate,
    nix-darwin,
    self,
    ...
  } @ inputs: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#oxygen
    darwinConfigurations."oxygen" = nix-darwin.lib.darwinSystem {
      modules = [
        ./modules/nix/nix-darwin.nix
        {system.configurationRevision = self.rev or self.dirtyRev or null;}
        determinate.darwinModules.default
      ];
    };
  };
}
