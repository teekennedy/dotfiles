---@type LazySpec
return {

	-- Discord Rich Presence for NeoVim
	{
		"vyfor/cord.nvim",
		build = ":Cord update fetch",
		opts = {
			editor = {
				tooltip = "Hyperextensible Vim-based text editor",
			},
			display = {
				theme = "minecraft",
				swap_fields = true,
			},
			idle = {
				enabled = true,
				-- Clear the presence after 5 minutes without activity (ms)
				timeout = 300000,
				show_status = false,
			},
			advanced = {
				workspace = {
					limit_to_cwd = true,
				},
			},
		},
	},

	-- Support for 'sandwiching' text.
	"machakann/vim-sandwich",

	-- Disable better escape because I don't use jj or jk as mappings to exit insert mode
	{ "max397574/better-escape.nvim", enabled = false },
}
