-- ~/.config/nvim/lua/plugins/comment.lua
return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("Comment").setup()         -- 기본 gc / gb 키맵 활성화
      local api = require("Comment.api")
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

      -- 노멀 모드: 현재 줄 토글
      vim.keymap.set("n", "<C-_>", api.toggle.linewise.current, { desc = "Toggle comment (line)" })
      vim.keymap.set("n", "<C-/>", api.toggle.linewise.current, { desc = "Toggle comment (line)" })

      -- 비주얼 모드: 선택 영역 토글
      vim.keymap.set("x", "<C-_>", function()
        vim.api.nvim_feedkeys(esc, "nx", false)
        api.toggle.linewise(vim.fn.visualmode())
      end, { desc = "Toggle comment (visual)" })
      vim.keymap.set("x", "<C-/>", function()
        vim.api.nvim_feedkeys(esc, "nx", false)
        api.toggle.linewise(vim.fn.visualmode())
      end, { desc = "Toggle comment (visual)" })
      vim.keymap.set("n", "<A-/>", api.toggle.blockwise.current, { desc = "Toggle block comment" })
      vim.keymap.set("x", "<A-/>", function()
        vim.api.nvim_feedkeys(esc, "nx", false)
        api.toggle.blockwise(vim.fn.visualmode())
      end, { desc = "Toggle block comment (visual)" })
    end,
	
  },
}

