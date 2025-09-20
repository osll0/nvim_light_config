local map, opts = vim.keymap.set, { noremap = true, silent = true }
map("n", "<leader>q", "<cmd>q<cr>", opts)
map("n", "<leader>w", "<cmd>w<cr>", opts)
map("n", "<leader>e", "<cmd>edit %<cr>", opts)

map("n", "<leader>bd", "<cmd>bdelete<cr>", opts)
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", opts)
map("n", "<leader>bn", "<cmd>bnext<cr>", opts)
map("n", "<leader>bp", "<cmd>bprevious<cr>", opts)

-- LSP 공통
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "gr", vim.lsp.buf.references, opts)
-- Diagnostics
map("n", "gl", vim.diagnostic.open_float, opts) -- 현재 줄 에러 메시지 보기
map("n", "[d", vim.diagnostic.goto_prev, opts) -- 이전 에러로 이동
map("n", "]d", vim.diagnostic.goto_next, opts) -- 다음 에러로 이동
map("n", "<leader>Q", vim.diagnostic.setloclist, opts) -- 전체 에러 목록 열기

map("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true })

end, opts)
