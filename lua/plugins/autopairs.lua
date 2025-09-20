return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,  -- treesitter 연동 (있으면 문자열/주석 안에서 자동괄호 안 넣음)
      fast_wrap = {},   -- <M-e> 같은 빠른 감싸기 기능 (선택)
    },
  },
}

