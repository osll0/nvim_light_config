-- ~/.config/nvim/init.lua
-- 0) 리더/기본 옵션 가장 먼저
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 1) 내 옵션/키맵/오토커맨드 읽기 (플러그인보다 먼저)
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- 2) lazy.nvim 부트스트랩
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- 3) 플러그인 로드 (plugins 폴더 전체 import)
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  change_detection = { notify = false },
  ui = { border = "rounded" },
})

-- 4) 컬러스킴 (첫 부팅 보호용 pcall)
pcall(vim.cmd, "colorscheme tokyonight")

vim.o.tagfunc = ""

-- 5) window clipboard 연동
vim.opt.clipboard = "unnamedplus"
