-- ~/.config/nvim/lua/plugins/theme.lua
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",       -- storm, night, moon, day
      transparent = false,
      styles = { comments = { italic = true }, keywords = { italic = false } },
    },
  },
}

