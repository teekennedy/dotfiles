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
			-- options = {
			-- 	nixos = {
			-- 		expr = "(builtins.getFlake (toString ./.)).nixosConfigurations.<hostname>.options",
			-- 	},
			-- 	home_manager = {
			-- 		expr = '(builtins.getFlake (toString ./.)).homeConfigurations."<username>@<hostname>".options',
			-- 	},
			-- },
		},
	},
}
