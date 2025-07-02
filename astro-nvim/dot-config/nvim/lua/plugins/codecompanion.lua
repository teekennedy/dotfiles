---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "zbirenbaum/copilot.lua",
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
        },
      },
      -- Integrate copilot with cmp
      {
        "hrsh7th/nvim-cmp",
        dependencies = {
          {
            "zbirenbaum/copilot-cmp",
            config = true,
          },
        },
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts) table.insert(opts.sources, { name = "copilot" }) end,
      },
      {
        "ravitemer/mcphub.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        config = function() require("mcphub").setup() end,
      },
    },
    opts = {
      strategies = {
        -- Change the default chat adapter
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true, -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          },
        },
      },
    },
    config = function(_, opts)
      local mappings = {
        n = {
          ["<leader>a"] = { desc = " AI" },
          ["<leader>ac"] = {
            "<cmd>CodeCompanionChat Toggle<CR>",
            desc = "Toggle AI chat",
          },
          ["<leader>aa"] = {
            "<cmd>CodeCompanionActions<CR>",
            desc = "AI actions",
          },
          ["<leader>am"] = {
            "<cmd>MCPHub<CR>",
            desc = "Open MCP Hub",
          },
        },
      }
      require("astrocore").set_mappings(mappings)
      -- Load the codecompanion plugin with the specified options
      require("codecompanion").setup(opts)
    end,
  },
}
