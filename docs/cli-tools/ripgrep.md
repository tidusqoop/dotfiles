# ripgrep (rg) 사용법

> `grep`의 상위 호환. 재귀 검색이 기본이고,
> `.gitignore`를 자동 반영하며, 구문 강조된 출력을
> 제공하는 초고속 텍스트 검색 도구.

## 설치

```bash
brew install ripgrep
```

## 기본 사용법

```bash
# 현재 디렉토리에서 재귀 검색
rg "TODO"

# 특정 디렉토리에서 검색
rg "error" src/

# 특정 파일에서 검색
rg "function" main.go

# 대소문자 무시
rg -i "error"

# 정규식 검색
rg "log\.(info|error|warn)"

# 정확한 문자열 검색 (정규식 해석 안 함)
rg -F "fmt.Println("
```

## 주요 옵션

| 옵션 | 설명 |
| --- | --- |
| `-i` | 대소문자 무시 |
| `-S` | 스마트 케이스 (대문자 있으면 구분) |
| `-w` | 단어 단위 매칭 |
| `-F` | 고정 문자열 검색 (정규식 비활성화) |
| `-n` | 줄번호 표시 (기본 활성화) |
| `-l` | 매칭된 파일 이름만 출력 |
| `-c` | 파일별 매칭 수만 출력 |
| `-v` | 매칭되지 않는 줄 출력 (invert) |
| `--hidden` | 숨김 파일/디렉토리도 검색 |
| `-u` | `.gitignore` 무시 (`-uu` 숨김 포함) |

## 컨텍스트 출력

```bash
# 매칭 줄 위아래 2줄씩 함께 출력
rg -C 2 "error"

# 매칭 줄 위 3줄
rg -B 3 "error"

# 매칭 줄 아래 3줄
rg -A 3 "error"
```

## 파일 타입 필터링

```bash
# 특정 파일 타입만 검색
rg -t go "func"
rg -t py "import"
rg -t js "require"

# 특정 파일 타입 제외
rg -T test "TODO"

# 지원하는 파일 타입 목록
rg --type-list

# glob 패턴으로 필터링
rg -g "*.yaml" "apiVersion"
rg -g "!*.test.js" "function"       # 특정 패턴 제외
rg -g "src/**/*.ts" "interface"
```

## 출력 형식

```bash
# 파일 이름만 출력
rg -l "TODO"

# 파일별 매칭 수
rg -c "TODO"

# 매칭 부분만 출력 (줄 전체가 아닌)
rg -o "v[0-9]+\.[0-9]+\.[0-9]+"

# JSON 형식 출력
rg --json "error"

# 색상 강제 활성화 (파이프할 때)
rg --color=always "error" | less -R
```

## 치환 (replace)

```bash
# 매칭된 부분을 치환하여 출력 (파일 변경 안 함)
rg "foo" -r "bar"

# 캡처 그룹 활용
rg "Hello (\w+)" -r "Hi $1"

# 실제 파일 수정은 sed와 조합
rg -l "old_name" \
  | xargs sed -i '' 's/old_name/new_name/g'
```

## 실전 활용 예시

### 코드베이스에서 함수 정의 찾기

```bash
# Go 함수 정의
rg "^func " -t go

# Python 클래스 정의
rg "^class \w+" -t py
```

### TODO/FIXME 모아보기

```bash
rg "TODO|FIXME|HACK|XXX"
```

### 로그 파일에서 에러 찾기

```bash
# 숨김 파일 + gitignore 무시
rg -uu "ERROR|FATAL" /var/log/
```

### API 엔드포인트 찾기

```bash
rg "(GET|POST|PUT|DELETE)\s+/" -t go
```

### 특정 설정값이 어디서 사용되는지 찾기

```bash
rg "DB_HOST" --hidden -g "!.git"
```

### fzf와 조합하여 인터랙티브 검색

```bash
rg --color=always --line-number "" \
  | fzf --ansi \
    --preview 'bat --color=always {1}' \
    --delimiter ':'
```

### 특정 패턴의 파일만 찾기 (fd 대안)

```bash
rg --files | rg "\.go$"
rg --files -g "*.yaml"
```

## grep과 비교

| 기능 | `grep -r` | `rg` |
| --- | --- | --- |
| 재귀 검색 | `-r` 플래그 필요 | 기본 동작 |
| `.gitignore` 반영 | 미지원 | 자동 반영 |
| 바이너리 파일 | 검색함 | 자동 스킵 |
| 속도 | 느림 | 2~5배 빠름 |
| 유니코드 | 제한적 | 완전 지원 |
| 출력 색상 | `--color` 필요 | 기본 활성화 |

## 설정 파일

`~/.ripgreprc`에 기본 옵션을 저장할 수 있다:

```bash
# ~/.ripgreprc
--smart-case
--hidden
--glob=!.git
```

`.zshrc`에 환경변수 추가:

```bash
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
```

## grep 별칭 설정

`.zshrc`에 추가:

```bash
alias grep='rg'
```
