-- ~/.config/nvim/lua/plugins/42header.lua
return {
  {
    "42Paris/42header",
    ft = { "c", "h", "cpp", "hpp", "make", "python", "lua" },
    init = function()
      -- 사용자 정보(필수)
      vim.g.user42 = "seokson"           -- 42 Intra ID
      vim.g.mail42 = "seokson@student.42gyeongsan.kr"

      -- 키맵 (헤더 삽입/업데이트)
      vim.keymap.set("n", "<leader>hh", "<cmd>Stdheader<cr>", { desc = "42 Header Insert/Update" })
    end,
  },
}

