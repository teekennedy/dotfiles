{
  description = "Django application using uv2nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    mcp-server-git = {
      url = "github:modelcontextprotocol/servers?dir=src/git";
      flake = false;
    };

    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    uv2nix = {
      url = "github:pyproject-nix/uv2nix";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pyproject-build-systems = {
      url = "github:pyproject-nix/build-system-pkgs";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.uv2nix.follows = "uv2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    flake-parts,
    mcp-server-git,
    uv2nix,
    pyproject-nix,
    pyproject-build-systems,
    ...
  }:
    flake-parts.lib.mkFlake {
      inherit inputs;
    } {
      # TODO more systems
      systems = ["aarch64-darwin" "x86_64-linux"];
      perSystem = {
        pkgs,
        lib,
        ...
      }: let
        python = pkgs.python3;
        workspace = inputs.uv2nix.lib.workspace.loadWorkspace {workspaceRoot = "${mcp-server-git}/src/git";};

        overlay = workspace.mkPyprojectOverlay {
          sourcePreference = "wheel";
        };

        # Use base package set from pyproject.nix builders
        pythonSet =
          (pkgs.callPackage pyproject-nix.build.packages {
            inherit python;
          }).overrideScope
          (
            pkgs.lib.composeManyExtensions [
              pyproject-build-systems.overlays.default
              overlay
            ]
          );

        inherit (pkgs.callPackages pyproject-nix.build.util {}) mkApplication;
      in {
        # checks.pythonSet = pythonSet;

        packages = rec {
          mcp-server-git = mkApplication {
            venv = pythonSet.mkVirtualEnv "mcp-server-git-env" workspace.deps.default;
            package = pythonSet.mcp-server-git;
          };

          default = mcp-server-git;
        };
      };
    };
}
