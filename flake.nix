{
  description = "teekennedy's dotfiles flake";

  inputs = {
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mcp-hub.url = "github:ravitemer/mcp-hub";
    mcp-server-git.url = "./nix/packages/mcp-server-git";
    mcp-server-git.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:numtide/nixpkgs-unfree/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nix-darwin,
    home-manager,
    mcp-hub,
    mcp-server-git,
    self,
    ...
  }: let
    commonDarwinModules = [
      home-manager.darwinModules.home-manager
      ./nix/modules/nix-darwin/default.nix
      ./nix/modules/dev/default.nix
      ./nix/modules/components/mcp-hub.nix
      {
        system.configurationRevision = self.rev or self.dirtyRev or null;
        home-manager.extraSpecialArgs = {
          inherit mcp-hub mcp-server-git;
        };
      }
    ];
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#$(scutil --get HostName)
    darwinConfigurations."oxygen" = nix-darwin.lib.darwinSystem {
      modules =
        commonDarwinModules
        ++ [
          {
            system.configurationRevision = self.rev or self.dirtyRev or null;
            myUsername = "tkennedy";
          }
        ];
    };
    darwinConfigurations."MJLYCVF4YQ" = nix-darwin.lib.darwinSystem {
      modules =
        commonDarwinModules
        ++ [
          {
            myUsername = "terrance.kennedy";
          }
        ];
    };
  };
}
