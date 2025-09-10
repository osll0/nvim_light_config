local aug = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

-- Yank 후 하이라이트
local yank_grp = aug("YankHighlight", { clear = true })
au("TextYankPost", {
  group = yank_grp,
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch", -- 하이라이트 색 (colorscheme에 따라 다름)
      timeout = 120,         -- 표시 시간 (ms)
    })
  end,
})

-- ========== ctags 자동 갱신 (Git/Makefile 루트에서만) ==========
local fn  = vim.fn
local api = vim.api

-- 프로젝트 루트 탐지: .git > Makefile > (fallback) 파일 위치
local function find_project_root(bufnr)
  bufnr = bufnr or 0
  local root = vim.fs.root(bufnr, { ".git", "Makefile" })
  if root then return root end
  return vim.fs.dirname(api.nvim_buf_get_name(bufnr))
end

-- 같은 루트에서 너무 자주 돌지 않도록 디바운스(초단위)
local last_run = {}
local MIN_INTERVAL = 5 -- 같은 루트에서 최소 5초 간격

local function regenerate_tags(root)
  if not root or root == "" then return end
  -- 동일 루트 최근 실행 시간 체크
  local now = os.time()
  if last_run[root] and (now - last_run[root] < MIN_INTERVAL) then
    return
  end
  last_run[root] = now

  -- 비동기로 ctags 실행 (루트에서)
  fn.jobstart({ "ctags", "-R", root }, {
    detach = true,
    on_stderr = function(_, data) if data and #data > 0 then vim.schedule(function() vim.notify(table.concat(data, "\n"), vim.log.levels.WARN) end) end end,
  })
end

-- C 헤더/소스 저장 시에만 갱신 (원하면 패턴 확대 가능)
au("BufWritePost", {
  pattern = { "*.c", "*.h" },
  callback = function(args)
    local root = find_project_root(args.buf)
    -- .git 또는 Makefile이 있는 곳에서만 실행
    if vim.loop.fs_stat(root .. "/.git") or vim.loop.fs_stat(root .. "/Makefile") then
      regenerate_tags(root)
    end
  end,
})

-- 수동 실행 커맨드도 제공
vim.api.nvim_create_user_command("TagsRegen", function()
  local root = find_project_root(0)
  if vim.loop.fs_stat(root .. "/.git") or vim.loop.fs_stat(root .. "/Makefile") then
    regenerate_tags(root)
    print("[ctags] regenerating at: " .. root)
  else
    print("[ctags] skipped (no .git/Makefile at/above current file)")
  end
end, {})

-- LSP가 붙어도 ctags만 쓰도록 tagfunc를 항상 비움
local aug = vim.api.nvim_create_augroup("ForceCtagsTagfunc", { clear = true })

vim.api.nvim_create_autocmd({ "LspAttach", "BufEnter" }, {
  group = aug,
  callback = function(args)
    -- 버퍼 로컬로 비워야 효과가 확실함
    if args and args.buf then
      vim.bo[args.buf].tagfunc = ""
    else
      vim.bo.tagfunc = ""
    end
  end,
})

