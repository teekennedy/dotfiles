return {
	-- AstroCommunity language packs
	-- https://github.com/AstroNvim/astrocommunity/tree/main/lua/astrocommunity/pack
	{ import = "astrocommunity.pack.bash" },
	{ import = "astrocommunity.pack.go" },
	{ import = "astrocommunity.pack.helm" },
	{ import = "astrocommunity.pack.json" },
	{ import = "astrocommunity.pack.markdown" },
	{
		-- Make sure to set this up properly if you have lazy=true
		"MeanderingProgrammer/render-markdown.nvim",
		-- Default options: https://github.com/MeanderingProgrammer/render-markdown.nvim#setup
		opts = {
			-- defaults to trying to render markdown blocks in any filetype
			file_types = { "markdown" },
			completions = { lsp = { enabled = true } },
		},
		-- lazy load on markdown
		ft = { "markdown" },
		dependencies = {
			{ "nvim-mini/mini.icons", version = "*" },
			{
				-- Ensure treesitter parsers required by render-markdown are installed
				"AstroNvim/astrocore",
				opts = {
					treesitter = {
						ensure_installed = {
							"markdown",
							"markdown_inline",
							-- Parsers below are optional
							"html",
							"latex",
							"yaml", -- to render YAML frontmatter metadata
						},
					},
				},
			},
		},
	},
	{ import = "astrocommunity.pack.python" },
	{ import = "astrocommunity.pack.terraform" },
	{
		"mfussenegger/nvim-dap",
		setup = {
			-- Additional dap configurations can be added.
			-- dap_configurations accepts a list of tables where each entry
			-- represents a dap configuration. For more details do:
			-- :help dap-configuration
			dap_configurations = {
				{
					-- Must be "go" or it will be ignored by the plugin
					type = "go",
					name = "Attach remote",
					mode = "remote",
					request = "attach",
				},
			},
		},
	},
}
