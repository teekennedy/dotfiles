-- Customize Treesitter
-- In AstroNvim v6, treesitter is configured through AstroCore
-- nvim-treesitter is now only used for parser downloads

---@type LazySpec
return {
	"AstroNvim/astrocore",
	opts = {
		treesitter = {
			ensure_installed = {
				"jsonnet",
				-- add more arguments for adding more treesitter parsers
			},
			textobjects = {
				select = {
					select_textobject = {
						["af"] = { query = "@function.outer", desc = "around function" },
						["if"] = { query = "@function.inner", desc = "around function" },
					},
				},
				move = {
					goto_next_start = {
						["]f"] = { query = "@function.outer", desc = "Next function start" },
					},
					goto_next_end = {
						["]F"] = { query = "@function.outer", desc = "Next function end" },
					},
					goto_previous_start = {
						["[f"] = {
							query = "@function.outer",
							desc = "Previous function start",
						},
					},
					goto_previous_end = {
						["[F"] = {
							query = "@function.outer",
							desc = "Previous function end",
						},
					},
				},
				swap = {
					swap_next = {
						[">F"] = { query = "@function.outer", desc = "Swap next function" },
					},
					swap_previous = {
						["<F"] = {
							query = "@function.outer",
							desc = "Swap previous function",
						},
					},
				},
			},
		},
	},
}
