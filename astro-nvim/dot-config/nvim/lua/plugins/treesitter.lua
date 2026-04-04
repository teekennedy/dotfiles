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
    },
  },
}
