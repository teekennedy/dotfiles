return {
	-- AstroCommunity language packs
	-- https://github.com/AstroNvim/astrocommunity/tree/main/lua/astrocommunity/pack
	{ import = "astrocommunity.pack.bash" },
	{ import = "astrocommunity.pack.go" },
	{ import = "astrocommunity.pack.helm" },
	{ import = "astrocommunity.pack.json" },
	{ import = "astrocommunity.pack.markdown" },
	{ import = "astrocommunity.pack.nix" },
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
	-- OpenTofu. Replaces `astrocommunity.pack.terraform`, which hardcodes terraform-ls;
	-- terraform-ls is not OpenTofu-aware and flags `encryption` blocks as "Unexpected block".
	{
		"AstroNvim/astrocore",
		opts = {
			-- there is no `opentofu` grammar; tree-sitter-hcl's `terraform` parser covers both
			treesitter = { ensure_installed = { "terraform" } },
			-- neovim has no ftdetect for OpenTofu's `.tofu` / `.tofuvars` extensions
			filetypes = {
				extension = {
					tofu = "terraform",
					tofuvars = "terraform-vars",
				},
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed =
				require("astrocore").list_insert_unique(opts.ensure_installed, { "tofu-ls", "tflint", "tfsec" })
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		optional = true,
		opts = function(_, opts)
			-- `tofu fmt`. mason-null-ls only auto-registers sources backed by a mason
			-- package, and mason has no package for the tofu CLI (only tofu-ls), so
			-- register it by hand. The tofu CLI comes from nix-darwin
			-- (nix/modules/dev/opentofu.nix), not from any per-project devenv shell.
			opts.sources = require("astrocore").list_insert_unique(opts.sources, {
				require("null-ls").builtins.formatting.opentofu_fmt,
			})
		end,
	},
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
