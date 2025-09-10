# Quick Start

## 1) 필수 툴
## Linux/WSL(Ubuntu):
```
sudo apt update
sudo apt install -y git curl ripgrep universal-ctags build-essential unzip
```

## macOS (Homebrew 필요):
## /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
brew install git curl ripgrep universal-ctags
```

## 2) 설정 clone
```
git clone https://github.com/<YOUR_GH>/nvim.git ~/.config/nvim
```
## (SSH) git clone git@github.com:<YOUR_GH>/nvim.git ~/.config/nvim

## 3) 42 헤더(선택, PC별 환경변수)
```
echo 'export USER42="seokson"' >> ~/.bashrc
echo 'export MAIL42="seokson@student.42seoul.kr"' >> ~/.bashrc
source ~/.bashrc
```

## 4) 플러그인/TS 파서 설치
```
nvim --headless "+Lazy! sync" "+TSUpdateSync lua vim vimdoc query c bash python" +qa
```

## 5) (권장) Nerd Font 설치 및 터미널 폰트 변경 → 아래 안내 참고

# Repo Layout
nvim/
├─ init.lua
├─ lazy-lock.json                  # 버전 고정! 커밋 유지 필요
├─ lua/
│  ├─ config/
│  │  ├─ options.lua              # tags 경로, tagfunc 비움(=ctags 우선)
│  │  ├─ keymaps.lua              # 기본 키맵
│  │  └─ autocmds.lua             # yank 하이라이트, ctags 자동 재생성 등
│  └─ plugins/                    # 필요한 플러그인만 최소 세팅
│     ├─ 42header.lua             # USER42/MAIL42 환경변수 지원
│     ├─ cmp.lua
│     ├─ comment.lua              # Ctrl-/ 포함
│     ├─ lsp.lua                  # (미니멀 attach 또는 비워둬도 OK)
│     ├─ telescope.lua            # <leader>sg (grep), <leader>st (tags)
│     ├─ theme.lua
│     ├─ treesitter.lua
│     └─ ui.lua                   # nvim-tree, bufferline, toggleterm
├─ scripts/
│  └─ install.sh                  # 원클릭 설치 스크립트
└─ README.md

# One-Command Installer
```
git clone https://github.com/<YOUR_GH>/nvim.git
cd nvim && chmod +x scripts/install.sh && ./scripts/install.sh
```
# Nerd Font
## Linux
```
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -L -o JetBrainsMono.zip "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
unzip -o JetBrainsMono.zip >/dev/null 2>&1
rm JetBrainsMono.zip
fc-cache -fv
echo "[fonts] Install done. 터미널 설정에서 'JetBrainsMono Nerd Font' 선택"
```
## macOS
```
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
# iTerm2/Terminal/WezTerm/Alacritty 등에서 폰트로 'JetBrainsMono Nerd Font' 선택
```
## WSL
- Windows 호스트에서 폰트 설치 후, Windows Terminal의 프로필 폰트를 Nerd Font로 지정

# 주요 keymaps
- 파일트리: <leader>e

- 터미널: <leader>tt (toggleterm, float)

- 버퍼 이동: Shift+h / Shift+l

- Grep 검색(루트 기준): <leader>sg

- Tags 검색: <leader>st → Enter로 정의 점프

- ctags 점프: Ctrl-], 뒤로 Ctrl-t

- 주석 토글:

- 기본: gc/gb (+ 모션/비주얼)

- 추가: Ctrl-/ (터미널에선 <C-_>로 인식) → 라인/비주얼 토글

- 42 Header: <leader>hh

# OS별 의존성
## Linux / WSL(Ubuntu)
```
sudo apt update
sudo apt install -y git curl ripgrep universal-ctags build-essential unzip
# (선택) LSP용 clangd:
# sudo apt install -y clangd
```
## macOS
```
brew install git curl ripgrep universal-ctags
# (선택) clangd:
# brew install llvm
```
# Troubleshooting
- 아이콘/기호 깨짐 → Nerd Font 설치 + 터미널(또는 Windows Terminal 프로필)에서 해당 폰트로 변경

- tags가 생성 안 됨

- - ctags --version 확인(미설치/PATH 문제)

- - .git 또는 Makefile 루트에서 저장/실행했는지 확인

- - :messages에 [ctags] 로그 확인

- Ctrl-] 해도 헤더 선언만 뜸

- - :verbose setlocal tagfunc? → tagfunc=(빈 값)인지 확인

- - ~/.ctags.d 설정에 --c-kinds=-p 적용됐는지 확인 → 루트에서 ctags -R -f tags . 다시 실행

- Telescope 검색 느림 → ripgrep 설치 확인

- Treesitter 파서 실패 → build-essential(Linux) 설치, :TSUpdate 재실행

# Uninstall / Rollback
```
mv ~/.config/nvim ~/.config/nvim.bak.$(date +%y%m%d_%H%M%S)
# 필요한 경우 lazy.nvim 데이터도 제거
rm -rf ~/.local/share/nvim
```

# Notes
- lazy-lock.json은 플러그인 버전을 고정하니 반드시 커밋 유지하세요.

- 42Header는 PC별 환경변수 USER42, MAIL42를 읽습니다(없으면 기본값 사용).

- LSP(clangd)는 옵션입니다. 정의 점프는 ctags만으로 충분하게 구성되어 있습니다.
