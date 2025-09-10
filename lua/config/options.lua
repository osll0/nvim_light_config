-- 공통 옵션
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 200
vim.opt.signcolumn = "yes"

-- 탭/인덴트 설정
vim.opt.tabstop = 4 -- 실제 탭 문자 간격
vim.opt.shiftwidth = 4 -- 자동 들여쓰기 너비
vim.opt.softtabstop = 4 -- 스페이스 입력 시 탭 간격
vim.opt.autoindent = true -- 이전 줄과 동일한 들여쓰기
vim.opt.smartindent = true -- C-like 언어에서 스마트 인덴트
vim.opt.expandtab = false -- 스페이스 대신 탭 문자 사용

-- 공백 문자 표시
vim.opt.list = true
vim.opt.listchars = {
	tab = "▸ ", -- 탭을 ▸␣ 로 표시
	trail = "·", -- 줄 끝 공백
	extends = "❯", -- 화면 밖으로 넘어간 부분
	precedes = "❮", -- 왼쪽으로 넘어간 부분
	nbsp = "␣", -- 특수 공백(non-break space)
}

-- 클립보드
vim.opt.clipboard = "unnamedplus" -- 시스템 클립보드 연동
