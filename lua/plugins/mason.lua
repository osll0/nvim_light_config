return {
  -- 1) Mason 본체: LSP/Formatter 등 외부 바이너리 설치 관리
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- 2) mason-lspconfig: LSP 서버 이름으로 설치를 보장 (설정/시작은 우리가 직접 함)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "pyright", "lua_ls" },
        automatic_installation = true,
      })
    end,
  },
}

