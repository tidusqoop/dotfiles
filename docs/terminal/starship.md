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
~/projects/dotfiles | main +1 ~2 ?3 | 󱃾 prod |  staging
❯                                                     2.3s
```

### 좌측 (format)

| 모듈 | 표시 | 설명 |
|------|------|------|
| `directory` | `~/projects/dotfiles` | repo root 기준 truncate, Nerd Font 없이 표시 |
| `git_branch` | `\| main` | `\|` 구분자 + 브랜치명 |
| `git_status` | `+1 ~2 ?3` | staged/modified/untracked/deleted/renamed/conflicted/ahead/behind |
| `kubernetes` | `\| 󱃾 context` | 컨텍스트명 (항상 표시, detect_folders 비움) |
| `aws` | `\|  profile` | AWS 프로필명 (force_display) |
| `character` | `❯` | 성공=초록, 실패=빨강, vim=`❮` |
| `sudo` | `#` | root일 때 빨간 `#` 표시 |

### 우측 (right_format)

| 모듈 | 표시 | 설명 |
|------|------|------|
| `cmd_duration` | `2.3s` | 2초 이상일 때 실행시간 표시 |

## Git Status 기호

| 기호 | 의미 | 색상 |
|------|------|------|
| `+N` | staged | `#9ece6a` (초록, bold) |
| `~N` | modified | `#e0af68` (노랑) |
| `?N` | untracked | `#7aa2f7` (파랑) |
| `-N` | deleted | `#f7768e` (빨강) |
| `»N` | renamed | `#bb9af7` (보라) |
| `!N` | conflicted | `#f7768e` (빨강, bold) |
| `↑N` / `↓N` | ahead / behind | `#565f89` (회색) |

## 색상 팔레트

| 요소 | 색상 코드 | 비고 |
|------|----------|------|
| 디렉토리 | `#e4e7f3` (밝은 회색, bold) | |
| Git 브랜치 | `#8edf96` (초록) | |
| K8s / AWS | `#636985` (어두운 회색) | 보조 정보 톤다운 |
| 성공 프롬프트 | `#9ece6a` (초록) | |
| 에러 프롬프트 | `#f7768e` (빨강) | |
| 실행시간 | `#565f89` (회색) | |

## 비활성화한 모듈

package, nodejs, python, rust, golang, java, docker_context

필요 시 `starship.toml`에서 `disabled = false`로 변경.

## 프리셋 변경

```bash
# 공식 프리셋 적용
starship preset <preset-name> > ~/.config/starship.toml

# 프리셋 목록 확인
# https://starship.rs/presets/
```

## Nerd Font

현재 Nerd Font 없이 유니코드 기본 문자만 사용.
아이콘이 필요하면:

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

설치 후 터미널 폰트를 변경하고 `starship.toml`에서 아이콘 추가.
