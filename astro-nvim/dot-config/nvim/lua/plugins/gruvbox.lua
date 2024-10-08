return {
  -- Gruvbox colorscheme
  -- https://github.com/AstroNvim/astrocommunity/tree/main/lua/astrocommunity/colorscheme/gruvbox-nvim
  { import = "astrocommunity.colorscheme.gruvbox-nvim", priority = 1000 },
  -- https://github.com/ellisonleao/gruvbox.nvim#configuration
  {
    "gruvbox.nvim",
    opts = {
      background = "dark",
      contrast = "hard",
    },
  },
}
