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
          { "zbirenbaum/copilot-cmp", config = true },
        },
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts) table.insert(opts.sources, { name = "copilot" }) end,
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
    },
  },
}
