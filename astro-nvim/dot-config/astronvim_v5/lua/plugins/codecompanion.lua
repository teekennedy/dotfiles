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
      -- Integrate copilot with blink
      {
        "saghen/blink.cmp",
        dependencies = {
          {
            "giuxtaposition/blink-cmp-copilot",
          },
        },
        opts = {
          sources = {
            default = { "lsp", "path", "snippets", "buffer", "copilot" },
            providers = {
              copilot = {
                name = "copilot",
                module = "blink-cmp-copilot",
                score_offset = 100,
                async = true,
              },
            },
          },
        },
      },
      {
        "ravitemer/mcphub.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        config = function()
          require("mcphub").setup(
            --   {
            --   -- Use local mcp-hub during development
            --   cmd = "node",
            --   cmdArgs = {
            --     "/Users/tkennedy/projects/mcp-hub/src/utils/cli.js", -- Point to local mcp-hub
            --   },
            --   shutdown_delay = 0, -- During development, stop immediately when neovim exits
            --   log = {
            --     to_file = true,
            --     file_path = vim.fn.expand("~/mcphub.log"),
            --     level = vim.log.levels.DEBUG,
            --   },
            -- }
          )
        end,
      },
    },
    opts = {
      strategies = {
        -- Change the default chat adapter
        chat = {
          adapter = "copilot",
          model = "claude-sonnet-4",
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
      prompt_library = {
        ["Edit<->Test workflow (make test)"] = {
          strategy = "workflow",
          description = "Use a workflow to repeatedly edit then test code",
          opts = {
            index = 5,
            is_default = true,
            short_name = "et",
          },
          prompts = {
            {
              {
                name = "Setup Test",
                role = "user",
                opts = { auto_submit = false },
                content = function()
                  -- Enable turbo mode!!!
                  vim.g.codecompanion_auto_tool_mode = true

                  return [[### Instructions

Your instructions here

### Process

1. ALWAYS use ONLY Environments for ANY and ALL file, code, or shell operations—NO EXCEPTIONS—even for simple or generic requests.

DO NOT install or use the git cli with the environment_run_cmd tool. All environment tools will handle git operations for you. Changing ".git" yourself will compromise the integrity of your environment.

You MUST inform the user how to view your work using `cu log <env_id>` AND `cu checkout <env_id>`. Failure to do this will make your work inaccessible to others.
1. Update the code in #{buffer}{watch} using the @editor tool
2. Then use the @cmd_runner tool to run the test suite with `<test_cmd>` (do this after you have updated the code)
3. Make sure you trigger both tools in the same response

We'll repeat this cycle until the tests pass. Ensure no deviations from these steps.]]
                end,
              },
            },
            {
              {
                name = "Repeat On Failure",
                role = "user",
                opts = { auto_submit = true },
                -- Scope this prompt to the cmd_runner tool
                condition = function() return _G.codecompanion_current_tool == "cmd_runner" end,
                -- Repeat until the tests pass, as indicated by the testing flag
                -- which the cmd_runner tool sets on the chat buffer
                repeat_until = function(chat) return chat.tool_flags.testing == true end,
                content = "The tests have failed. Can you edit the buffer and run the test suite again?",
              },
            },
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
