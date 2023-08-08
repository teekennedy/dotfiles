return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  -- Gruvbox colorscheme
  -- https://github.com/AstroNvim/astrocommunity/tree/main/lua/astrocommunity/colorscheme/gruvbox-nvim
  { import = "astrocommunity.colorscheme.gruvbox-nvim", priority = 1000 },
  -- https://github.com/ellisonleao/gruvbox.nvim#configuration
  {"gruvbox.nvim",
  opts= {
      background="dark",
      contrast="hard",
    }
    }
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
}
