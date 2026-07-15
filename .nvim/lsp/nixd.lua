return {
	-- https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md#configuration-overview
	settings = {
		nixd = {
			formatting = {
				command = { "alejandra" },
			},
			nixpkgs = {
				expr = "import (builtins.getFlake (toString ./.)).inputs.nixpkgs { }",
			},
			options = {
				nix_darwin = {
					expr = "(builtins.getFlake (toString ./.)).darwinConfigurations.oxygen.options",
				},
			},
		},
	},
}
