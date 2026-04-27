# dotfiles

[chezmoi](https://www.chezmoi.io/) 기반 macOS 개발 환경 설정 관리

## 구조

```text
~/.local/share/chezmoi/
├── dot_zshrc                            # ~/.zshrc (alias, 플러그인, 프롬프트)
├── dot_gitconfig                        # ~/.gitconfig
├── dot_config/
│   ├── aerospace/aerospace.toml         # Aerospace 타일링 WM 설정
│   ├── bat/config                       # bat 설정
│   ├── borders/bordersrc                # JankyBorders 활성 창 테두리 설정
│   ├── ghostty/config                   # Ghostty 터미널 설정
│   ├── karabiner/karabiner.json         # Karabiner-Elements 키 리매핑 설정
│   ├── nvim/                            # Neovim + LazyVim 설정
│   ├── sheldon/plugins.toml             # zsh 플러그인 관리
│   ├── starship.toml                    # Starship 프롬프트
│   ├── tmux/tmux.conf                   # tmux 설정
│   └── yazi/                            # yazi 파일 매니저 설정
├── run_once_before_install-packages.sh  # brew 패키지 자동 설치
├── run_once_after_install-tmux-plugins.sh # tmux 플러그인 자동 설치
├── docs/                                # 도구별 사용 가이드
└── readme.md
```

## 포함된 도구

| 분류 | 도구 |
| ------ | ------ |
| 터미널 | Ghostty, tmux, tmuxinator, Starship |
| 에디터 | Neovim (LazyVim) |
| 쉘 | zsh, sheldon (플러그인 관리) |
| 파일/검색 | eza, fd, fzf, ripgrep, yazi, tree |
| Git | lazygit, delta |
| 유틸리티 | bat, direnv, htop, jq, yq, zoxide |
| 윈도우 관리 | Aerospace (타일링), JankyBorders (활성 창 테두리) |
| 키보드 | Karabiner-Elements (키 리매핑) |

## 주요 alias

| alias | 명령 |
| ------- | ------ |
| `ll` / `la` / `lt` | eza 기반 ls |
| `lg` | lazygit |
| `y` | yazi (종료 시 디렉토리 이동) |
| `ta` / `tn` / `tl` | tmux attach/new/list |
| `mux` | tmuxinator |
| `cl` / `cy` | claude / claude (skip permissions) |

## 새 머신에서 설정

### 1. chezmoi 로컬 설정 파일 생성

chezmoi는 머신별 분기를 위해 `~/.config/chezmoi/chezmoi.toml`을 사용합니다.
이 파일은 소스 레포에 포함되지 않으므로 **초기화 전에 직접 생성**해야 합니다.

```bash
mkdir -p ~/.config/chezmoi
cat > ~/.config/chezmoi/chezmoi.toml << 'EOF'
[diff]
  command = "delta"

[data]
  machine = "toss-income"  # 개인 장비는 "personal"
EOF
```

현재 지원하는 `machine` 값:

- `toss-income` — 회사 장비 전용 설정 활성화
- 그 외 — 기본 설정만 적용

### 2. 수동 설치 필요 항목

PKG 설치 방식으로 인해 `chezmoi apply` 스크립트에서 자동 설치가 불가능합니다.
**초기화 전에 직접 설치**해야 합니다.

```bash
brew install --cask karabiner-elements
```

설치 후 아래 권한 허용 및 설정이 필요합니다:

- `시스템 설정 → 개인 정보 보호 및 보안 → 입력 모니터링 → Karabiner-Elements 허용`
- `시스템 설정 → 키보드 → 키보드 단축키 → 입력 소스 → "입력 메뉴에서 다음 소스 선택" → F18 지정`

### 4. 초기화 및 적용

```bash
# chezmoi 설치
brew install chezmoi

# 초기화 및 적용 (한 번에)
chezmoi init --apply git@github.com:tidusqoop/dotfiles.git
```

`chezmoi apply` 시 자동으로 brew 패키지 설치 및
tmux 플러그인 설정이 실행됩니다.

## 사용법

```bash
# 소스 수정 후 로컬에 적용
chezmoi apply

# 변경사항 확인 (소스 vs 로컬)
chezmoi diff

# 로컬 파일 수정 후 소스에 반영
chezmoi re-add

# 새 설정 파일 추가
chezmoi add ~/.config/some/config
```
