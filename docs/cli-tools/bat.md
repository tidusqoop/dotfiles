# bat 사용법

> `cat`의 상위 호환. 구문 강조(syntax highlighting), 줄번호, Git 변경 표시를 지원하는 파일 출력 도구.

## 기본 사용법

```bash
# 파일 출력 (구문 강조 + 줄번호)
bat README.md

# 여러 파일 출력
bat src/main.go src/util.go

# stdin 파이프 (언어 지정)
curl -s https://example.com/api | bat -l json
kubectl get pod -o yaml | bat -l yaml

# 줄번호 없이 출력 (스크립트에서 활용할 때)
bat -p file.txt

# 특정 줄 범위만 출력
bat --line-range 10:20 main.go
bat -r :50 main.go       # 처음~50번째 줄
bat -r 100: main.go      # 100번째 줄~끝
```

## 주요 옵션

| 옵션 | 설명 |
|------|------|
| `-n` | 줄번호만 표시 (헤더/테두리 없음) |
| `-p` | plain 모드 (줄번호, 헤더, 테두리 모두 없음) |
| `-pp` | `-p`보다 더 plain (cat과 동일하게 동작) |
| `-l <lang>` | 언어 지정 (예: `-l json`, `-l yaml`, `-l py`) |
| `-r <범위>` | 줄 범위 지정 (예: `-r 10:20`) |
| `--diff` | Git 변경 사항 표시 (추가/삭제된 줄 마킹) |
| `--show-all` | 공백, 탭, 줄바꿈 등 비인쇄 문자 표시 |

## 테마

```bash
# 사용 가능한 테마 목록
bat --list-themes

# 특정 테마로 출력
bat --theme="Dracula" main.go

# 기본 테마 설정 (~/.zshrc에 추가)
export BAT_THEME="Catppuccin Mocha"
```

## 다른 도구와 연동

### fzf 미리보기

```bash
fzf --preview 'bat --color=always --style=numbers {}'
```

### git diff에서 bat 사용 (delta 대안)

```bash
git diff | bat -l diff
```

### man 페이지 색상 적용

`.zshrc`에 추가:

```bash
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -l man -p'"
```

### tail -f 대용

```bash
tail -f /var/log/system.log | bat --paging=never -l log
```

## cat 별칭 설정

`cat`을 `bat`으로 대체하고 싶다면 `.zshrc`에 추가:

```bash
alias cat='bat -pp'
```

> `-pp` 옵션을 쓰면 기존 `cat`과 동일한 출력 형태에 구문 강조만 추가된다.

## 설정 파일

`~/.config/bat/config`에 기본 옵션을 저장할 수 있다:

```bash
# ~/.config/bat/config
--theme="Catppuccin Mocha"
--style="numbers,changes"
--map-syntax "*.conf:INI"
```
