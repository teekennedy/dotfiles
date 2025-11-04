-- Customize Treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter

---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		-- Disable broken treesitter indent rules for yaml
		-- https://github.com/nvim-treesitter/nvim-treesitter/issues/5653
		indent = {
			disable = { "yaml" },
		},
		ensure_installed = {
			"jsonnet",
			"lua",
			"vim",
			-- add more arguments for adding more treesitter parsers
		},
	},
}
