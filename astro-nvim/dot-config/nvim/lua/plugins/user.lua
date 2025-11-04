---@type LazySpec
return {

	-- Discord Rich Presence for NeoVim
	{
		"andweeb/presence.nvim",
		config = function()
			require("presence").setup({
				blacklist = { "/?[^p][^r][^o][^j][^e][^c][^t][^s]/?" },
			})
		end,
	},

	-- Support for 'sandwiching' text.
	"machakann/vim-sandwich",

	-- Show function signature while you type
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
	},

	-- Disable better escape because I don't use jj or jk as mappings to exit insert mode
	{ "max397574/better-escape.nvim", enabled = false },
}
