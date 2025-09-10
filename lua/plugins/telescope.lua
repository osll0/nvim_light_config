return {
  {
    "nvim-telescope/telescope.nvim",
    version = false, -- 최신 main
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>",  desc = "Find Git Files" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>",  desc = "Search by Grep" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        layout_strategy = "vertical",
        layout_config = { height = 0.9, width = 0.9 },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
    },
  },
}

