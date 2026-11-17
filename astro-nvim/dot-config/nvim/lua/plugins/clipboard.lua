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
    },
  },
}
