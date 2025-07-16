-- NeoTest (integrates with go, python, rust)
-- https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/test/neotest/init.lua
local astrocore = require("astrocore")
return {
  -- Disable toggleterm.nvim so I can use <leader>t prefix for tests instead
  { "akinsho/toggleterm.nvim", enabled = false },
  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "Coverage",
      "CoverageSummary",
      "CoverageLoad",
      "CoverageShow",
      "CoverageHide",
      "CoverageToggle",
      "CoverageClear",
    },
    opts = {
      auto_reload = true,
      highlights = {
        -- customize highlight groups created by the plugin
        covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
        uncovered = { fg = "#F07178" },
      },
    },
  },
  -- overriding the default git signs so they don't conflict with nvim-coverage
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "±" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    },
  },

  -- Disable Neodev in favor of LazyDev
  { "folke/neodev.nvim",       enabled = false },
  {
    "nvim-neotest/neotest",
    ft = { "go", "rust", "python", "lua" },
    dependencies = {
      {
        "fredrikaverpil/neotest-golang",
        dependencies = {
          "mfussenegger/nvim-dap",
          "rcarriga/nvim-dap-ui",
        },
      },
      "nvim-neotest/neotest-python",
      "rouge8/neotest-rust",
      -- Add Neotest as a Lazydev plugin (lua specific)
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = function(_, opts)
          opts.library = require("astrocore").list_insert_unique(opts.library, { "neotest" })
        end,
      },
    },
    opts = function()
      return {
        adapters = {
          -- Neotest-golang config
          -- https://fredrikaverpil.github.io/neotest-golang/config/
          -- Tip: Open neotest-golang logs with `:exe 'edit' stdpath('log').'/neotest-golang.log'`
          require("neotest-golang")({
            experimental = {
              test_table = true,
            },
            testify_enabled = true,
            go_test_args = {
              "-v",
              "-race",
              "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
            },
          }),
          require("neotest-rust"),
          require("neotest-python"),
        },
        -- Allow INFO-level diagnostic messages
        diagnostic = {
          severity = vim.diagnostic.severity.INFO,
        },
      }
    end,
    config = function(_, opts)
      local neotest = require("neotest")
      local prefix = "<leader>t"
      local icon = vim.g.icons_enabled and "󰙨 " or ""
      local mappings = {
        n = {
          [prefix] = { desc = icon .. "Test" },
          [prefix .. "f"] = {
            function()
              neotest.run.run(vim.fn.expand("%"))
            end,
            desc = "Test current file",
          },
          [prefix .. "a"] = {
            function()
              neotest.run.run(vim.fn.expand("%"))
            end,
            desc = "Run all tests in current directory",
          },
          [prefix .. "w"] = {
            function()
              neotest.watch.toggle(vim.fn.expand("%"))
            end,
            desc = "Toggle watching current file",
          },
          [prefix .. "W"] = {
            function()
              neotest.watch.toggle(vim.fn.getcwd())
            end,
            desc = "Toggle watching current directory",
          },
          [prefix .. "c"] = {
            "<cmd>Coverage<CR>",
            desc = "Show test coverage",
          },
          [prefix .. "C"] = {
            function()
              neotest.run.run()
            end,
            desc = "Run closest test",
          },
          [prefix .. "S"] = {
            function()
              neotest.run.stop()
            end,
            desc = "Stop current test run",
          },
          [prefix .. "s"] = {
            function()
              neotest.summary.toggle()
            end,
            desc = "Toggle summary panel",
          },
          [prefix .. "o"] = {
            function()
              neotest.output_panel.toggle()
            end,
            desc = "Toggle output panel",
          },
        },
      }
      if astrocore.is_available("nvim-dap") then
        mappings.n[prefix .. "d"] = {
          function()
            neotest.run.run({ suite = false, strategy = "dap" })
          end,
          desc = "Debug closest test",
        }
      end
      astrocore.set_mappings(mappings)
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message =
                diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      neotest.setup(opts)
    end,
  },
}
