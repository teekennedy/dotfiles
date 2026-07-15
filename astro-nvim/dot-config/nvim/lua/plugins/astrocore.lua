-- AstroCore provides a central place to modify mappings, vim options, autocommands, etc.
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
	"AstroNvim/astrocore",
	---@type AstroCoreOpts
	opts = {
		-- Configure core features of AstroNvim
		features = {
			-- files over this size will have features like treesitter disabled
			large_buf = { size = 1024 * 256, lines = 10000 },
			autopairs = true,
			-- completion
			cmp = true,
			diagnostics = {
				virtual_text = true,
				virtual_lines = true,
			},
			highlighturl = true,
			notifications = true,
		},
		-- Diagnostics configuration (vim.diagnostics.config({...}))
		diagnostics = {
			virtual_text = true,
			underline = true,
		},
		-- passed to `vim.filetype.add`
		filetypes = {
			-- see `:h vim.filetype.add` for usage
			-- extension = {
			--   foo = "fooscript",
			-- },
			-- filename = {
			--   [".foorc"] = "fooscript",
			-- },
			-- pattern = {
			--   [".*/etc/foo/.*"] = "fooscript",
			-- },
		},
		-- vim options can be configured here
		options = {
			opt = { -- vim.opt.<key>
				-- Enable project-local config
				-- https://neovim.io/doc/user/options/#'exrc'
				exrc = true,
				relativenumber = true,
				number = true,
				spell = false,
				signcolumn = "yes",
				wrap = false,
			},
			g = {
				-- configure global vim variables (vim.g)
				-- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
				-- This can be found in the `lua/lazy_setup.lua` file
			},
		},
		-- Mappings can be configured through AstroCore as well.
		-- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
		mappings = {
			-- normal mode mappings
			n = {
				-- navigate buffer tabs
				["]b"] = {
					function()
						require("astrocore.buffer").nav(vim.v.count1)
					end,
					desc = "Next buffer",
				},
				["[b"] = {
					function()
						require("astrocore.buffer").nav(-vim.v.count1)
					end,
					desc = "Previous buffer",
				},

				-- mappings seen under group name "Buffer"
				["<Leader>bd"] = {
					function()
						require("astroui.status.heirline").buffer_picker(function(bufnr)
							require("astrocore.buffer").close(bufnr)
						end)
					end,
					desc = "Close buffer from tabline",
				},
				["<Leader>fd"] = {
					function()
						require("snacks").picker.diagnostics()
					end,
					desc = "Find diagnostics",
				},
				["<Leader>fD"] = {
					function()
						require("snacks").picker.diagnostics_buffer()
					end,
					desc = "Find diagnostics (buffer)",
				},

				-- tables with just a `desc` key will be registered with which-key if it's installed
				-- this is useful for naming menus
				-- ["<Leader>b"] = { desc = "Buffers" },

				-- setting a mapping to false will disable it
				-- ["<C-S>"] = false,
			},
		},
	},
}
