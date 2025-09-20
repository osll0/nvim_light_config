return {
  {
    "neovim/nvim-lspconfig", -- 유틸/타입 정의용. (여기서 require('lspconfig')는 사용하지 않음)
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- nvim-cmp capabilities 연동(있으면)
      local caps = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_caps = pcall(require, "cmp_nvim_lsp")
      if ok then caps = cmp_caps.default_capabilities(caps) end

      local function root(buf, patterns)
        return vim.fs.root(buf or 0, patterns or { ".git" }) or vim.loop.cwd()
      end

      -- === 서버별 설정 등록 (vim.lsp.config) ===
      local clangd_cfg = vim.lsp.config("clangd", {
        name = "clangd",
        cmd = { "clangd" },
        capabilities = caps,
        filetypes = { "c", "cpp", "objc", "objcpp" },
        -- 필요 시 settings/on_attach 추가
      })

      local pyright_cfg = vim.lsp.config("pyright", {
        name = "pyright",
        cmd = { "pyright-langserver", "--stdio" },
        capabilities = caps,
        filetypes = { "python" },
        settings = {
          python = { analysis = { typeCheckingMode = "basic" } },
        },
      })

      local lua_ls_cfg = vim.lsp.config("lua_ls", {
        name = "lua_ls",
        cmd = { "lua-language-server" },
        capabilities = caps,
        filetypes = { "lua" },
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      -- === 자동 시작: 파일타입별로 루트 재계산 후 실행 ===
      local aug = vim.api.nvim_create_augroup("LspAutostart_v11", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = aug,
        pattern = { "c", "cpp", "objc", "objcpp" },
        callback = function(args)
          if #vim.lsp.get_clients({ bufnr = args.buf, name = "clangd" }) > 0 then return end
          clangd_cfg.root_dir = root(args.buf, { "compile_commands.json", "compile_flags.txt", ".git" })
          vim.lsp.start(clangd_cfg)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = aug,
        pattern = { "python" },
        callback = function(args)
          if #vim.lsp.get_clients({ bufnr = args.buf, name = "pyright" }) > 0 then return end
          pyright_cfg.root_dir = root(args.buf, { "pyproject.toml", "requirements.txt", ".git" })
          vim.lsp.start(pyright_cfg)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = aug,
        pattern = { "lua" },
        callback = function(args)
          if #vim.lsp.get_clients({ bufnr = args.buf, name = "lua_ls" }) > 0 then return end
          lua_ls_cfg.root_dir = root(args.buf, { ".luarc.json", ".git" })
          vim.lsp.start(lua_ls_cfg)
        end,
      })
    end,
  },
}

