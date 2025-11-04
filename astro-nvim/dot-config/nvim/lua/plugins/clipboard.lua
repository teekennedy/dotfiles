---@type LazySpec
return {
  -- your other imports...
  {
    "AstroNvim/astrocore",
    opts = {
      options = {
        opt = { -- vim.opt.<key>
          -- Keep clipboard register ('+') separate from unnamed register.
          -- AstroNvim defaults to "unnamedplus" for this option.
          clipboard = "",
        },
      },
      mappings = {
        n = {
          ["<leader>y"] = { '"+y', desc = "Yank to clipboard" },
          ["<leader>yy"] = { '"+yy', desc = "Yank line to clipboard" },
          ["<leader>p"] = { '"+p', desc = "Paste from clipboard" },
        },
        v = {
          ["<leader>y"] = { '"+y', desc = "Yank to clipboard" },
          ["<leader>yy"] = { '"+yy', desc = "Yank line to clipboard" },
          ["<leader>p"] = { '"+p', desc = "Paste from clipboard" },
          ["<leader>P"] = { '"_dP', desc = "Paste over selection without erasing unnamed register" },
        },
        x = {
          ["<leader>y"] = { '"+y', desc = "Yank to clipboard" },
          ["<leader>yy"] = { '"+yy', desc = "Yank line to clipboard" },
          ["<leader>p"] = { '"+p', desc = "Paste from clipboard" },
          ["<leader>P"] = { '"_dP', desc = "Paste over selection without erasing unnamed register" },
        },
      },
    },
  },
}
