# dotfiles

[chezmoi](https://www.chezmoi.io/) 기반 macOS 개발 환경 설정 관리

## 구조

```
~/.local/share/chezmoi/
├── dot_zshrc              # ~/.zshrc
├── dot_gitconfig          # ~/.gitconfig
├── dot_config/
│   └── bat/config         # ~/.config/bat/config
├── docs/                  # 도구별 사용 가이드
└── readme.md
```

## 새 머신에서 설정

```bash
# chezmoi 설치
brew install chezmoi

# 초기화 및 적용 (한 번에)
chezmoi init --apply git@github.com:tidusqoop/dotfiles.git
```

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
