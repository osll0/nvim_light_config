-- ~/.config/nvim/lua/plugins/ui.lua
return {
  -- 파일 탐색기
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree Toggle" },
    },
    opts = {
      hijack_netrw = true,
      sync_root_with_cwd = true,
      view = { width = 36 },
      renderer = {
        highlight_git = true,
        icons = { glyphs = { folder = { arrow_closed = "", arrow_open = "" } } },
      },
      filters = { dotfiles = false, custom = { "^.git$" } },
      git = { enable = true, ignore = false },
    },
  },

  -- 버퍼라인
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        offsets = { { filetype = "NvimTree", text = "File Explorer", separator = true } },
        separator_style = "slant",
        show_buffer_close_icons = false,
        always_show_bufferline = true,
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
      vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
    end,
  },

--[=[
  -- 터미널
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    },
    opts = {
      size = 12,
      open_mapping = [[<c-\>]],
      shade_terminals = true,
      direction = "float", -- 'horizontal' | 'vertical' | 'tab' | 'float'
      float_opts = { border = "rounded" },
    },
  },
	]=]

	-- 8) 터미널
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 14,
				open_mapping = [[<C-\>]],
				shade_terminals = true,
				direction = "float",
				float_opts = { border = "rounded" },
			})
			local Terminal = require("toggleterm.terminal").Terminal
			local runner = Terminal:new({ hidden = true, direction = "float" })
			local last_cmd = nil
			local function TermRun(cmd)
				if not cmd or cmd == "" then return end
				last_cmd = cmd
				runner:open()
				runner:send(cmd .. "\r")
			end
			vim.api.nvim_create_user_command("TermRun", function()
				vim.ui.input({ prompt = "Shell command: " }, function(input) TermRun(input) end)
			end, {})
			vim.api.nvim_create_user_command("TermHere", function()
				local file = vim.fn.expand("%:p")
				local dir  = vim.fn.fnamemodify(file, ":h")
				TermRun("cd " .. vim.fn.shellescape(dir))
			end, {})
			vim.keymap.set("n", "<leader>to", "<cmd>ToggleTerm direction=float<cr>", { desc = "Terminal (float)" })
			vim.keymap.set("n", "<leader>ts", "<cmd>ToggleTerm size=12 direction=horizontal<cr>", { desc = "Terminal (split)" })
			vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=60 direction=vertical<cr>", { desc = "Terminal (vsplit)" })
			vim.keymap.set("n", "<leader>tr", function()
				if last_cmd then TermRun(last_cmd) else vim.cmd("TermRun") end
			end, { desc = "Run last terminal command" })
		end,
	},
}

