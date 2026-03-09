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

## 사용법

```bash
# 설정 적용
chezmoi apply

# 변경사항 확인
chezmoi diff

# 새 설정 파일 추가
chezmoi add ~/.config/some/config
```
