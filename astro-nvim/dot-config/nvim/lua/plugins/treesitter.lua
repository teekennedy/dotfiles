-- Treesitter config
-- https://github.com/nvim-treesitter/nvim-treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Disable broken treesitter indent rules for yaml
    -- https://github.com/nvim-treesitter/nvim-treesitter/issues/5653
    opts.indent.disable = { "yaml" }
  end,
}
