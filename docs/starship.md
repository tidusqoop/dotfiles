# starship

크로스 셸 프롬프트. Rust 기반으로 빠르고, 설정 파일 하나로 관리.

## 설치

```bash
brew install starship
```

## 설정 파일

- 경로: `~/.config/starship.toml`
- chezmoi: `dot_config/starship.toml`

## zshrc 설정

```bash
eval "$(starship init zsh)"
```

direnv hook 바로 위에 위치시킨다 (direnv는 항상 맨 마지막).

## 현재 프롬프트 구성

```
…/projects/dotfiles main [+2 ~1] (k8s:prod/default) (aws:staging)
❯                                                        2.3s
```

| 요소 | 설명 |
|------|------|
| 디렉토리 | `~` 축약 + 3단계 truncation |
| Git | 브랜치 + 변경사항 요약 |
| K8s | 컨텍스트/네임스페이스 (감지 시만) |
| AWS | 프로필명 (감지 시만) |
| `❯` | 성공=초록, 실패=빨강 |
| 실행시간 | 2초 이상일 때 우측 표시 |
| sudo | root일 때 `#` 표시 |

## 색상 팔레트 (Tokyo Night 기반)

| 요소 | 색상 코드 |
|------|----------|
| 디렉토리 | `#7aa2f7` (파랑) |
| Git 브랜치 | `#9ece6a` (초록) |
| Git 상태 | `#e0af68` (노랑) |
| K8s | `#bb9af7` (보라) |
| AWS | `#ff9e64` (주황) |
| 실행시간 | `#565f89` (회색) |
| 에러 | `#f7768e` (빨강) |

## 프리셋 변경

```bash
# 공식 프리셋 적용
starship preset <preset-name> > ~/.config/starship.toml

# 프리셋 목록 확인
# https://starship.rs/presets/
```

## 비활성화한 모듈

package, nodejs, python, rust, golang, java, docker_context

필요 시 `starship.toml`에서 `disabled = false`로 변경.

## Nerd Font

현재 Nerd Font 없이 유니코드 기본 문자만 사용.
아이콘이 필요하면:

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

설치 후 터미널 폰트를 변경하고 `starship.toml`에서 아이콘 추가.
