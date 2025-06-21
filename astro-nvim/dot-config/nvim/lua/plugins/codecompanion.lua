local use_openai = vim.fn.hostname() == "oxygen"
local use_vectorcode = vim.fn.executable("vectorcode") == 1
---@type LazySpec
return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"Davidyz/VectorCode",
				tag = "0.6.13",
				cond = use_vectorcode,
			},
			{
				"zbirenbaum/copilot.lua",
				opts = {
					suggestion = { enabled = false },
					panel = { enabled = false },
				},
				cond = not use_openai,
			},
			-- Integrate copilot with cmp
			{
				"hrsh7th/nvim-cmp",
				dependencies = {
					{
						"zbirenbaum/copilot-cmp",
						config = true,
						cond = not use_openai,
					},
				},
				---@param opts cmp.ConfigSchema
				opts = function(_, opts)
					if not use_openai then
						table.insert(opts.sources, { name = "copilot" })
					end
				end,
			},
		},
		opts = function(_, opts)
			opts = {
				adapters = {
					openai = function()
						return require("codecompanion.adapters").extend("openai", {
							-- env = {
							--   api_key = "cmd:gpg --batch --quiet --decrypt ~/.llm/openai-api-key.asc",
							-- },
							model = "gpt-4.1-mini",
						})
					end,
				},
				strategies = {
					-- Change the default chat adapter
					chat = {
						adapter = (use_openai and "openai" or "copilot"),
					},
					inline = {
						adapter = (use_openai and "openai" or "copilot"),
					},
				},
			}
			if use_vectorcode then
				table.insert(opts, {
					extensions = {
						vectorcode = {
							opts = {
								add_tool = true,
							},
						},
					},
				})
			end
		end,
	},
}
