---@type LazySpec
return {
  { import = "astrocommunity.pack.yaml" },
  {
    -- A lot of the functionality of this plugin is provided by yaml-language-server (included in the astrocommunity pack above)
    -- But there's a couple nice
    "cuducos/yaml.nvim",
    keys = {
      {
        "<leader>fy",
        function()
          require("yaml_nvim").snacks()
        end,
        desc = "Find YAML",
      },
      {
        "yY",
        function()
          require("yaml_nvim").yank_value()
        end,
        desc = "YAML value",
      },
    },
    dependencies = {
      {
        "folke/snacks.nvim",
        optional = true,
      },
    },
  },
}
