-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")

      -- (선택) nvim-cmp 연동: 있으면 cap 확장, 없으면 무시
      local caps = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then caps = cmp_nvim_lsp.default_capabilities(caps) end

      lspconfig.clangd.setup({
        capabilities = caps,
        cmd = { "clangd" }, -- 시스템 clangd 사용
      })
    end,
  },
}

