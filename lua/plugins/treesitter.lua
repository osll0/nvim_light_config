-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "vim", "vimdoc", "query", "c", "bash", "python" }, -- 최소 세트
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true, -- 파일 여는 순간 미설치 파서 자동 설치(툴체인 필요)
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

