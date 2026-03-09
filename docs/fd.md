# fd 사용법

> `find`의 상위 호환. 직관적인 문법, 빠른 속도, `.gitignore` 자동 반영을 제공하는 파일 검색 도구.

## 설치

```bash
brew install fd
```

## 기본 사용법

```bash
# 현재 디렉토리에서 패턴 검색 (재귀)
fd readme

# 확장자로 검색
fd -e go

# 정규식 검색
fd "^main\..*"

# 특정 디렉토리에서 검색
fd "config" src/

# 모든 파일 나열 (패턴 없이)
fd
```

## 주요 옵션

| 옵션 | 설명 |
|------|------|
| `-e <ext>` | 확장자 필터 (예: `-e go`, `-e yaml`) |
| `-t f` | 파일만 검색 |
| `-t d` | 디렉토리만 검색 |
| `-t l` | 심볼릭 링크만 검색 |
| `-H` | 숨김 파일/디렉토리 포함 |
| `-I` | `.gitignore` 무시 |
| `-u` | 숨김 파일 포함 (`-H`와 동일), `-uu`는 gitignore도 무시 |
| `-d <n>` | 검색 깊이 제한 |
| `-E <패턴>` | 특정 패턴 제외 |
| `-g` | glob 패턴 사용 (기본은 정규식) |
| `-F` | 고정 문자열 검색 (정규식 비활성화) |
| `-i` | 대소문자 무시 |
| `-s` | 대소문자 구분 강제 |
| `-p` | 전체 경로에 대해 매칭 |
| `-l` | 심볼릭 링크 따라가기 |
| `-a` | 절대 경로로 출력 |
| `--changed-within <기간>` | 최근 n일/시간 이내 수정된 파일 |
| `--changed-before <기간>` | n일/시간 이전에 수정된 파일 |
| `-S <크기>` | 파일 크기 필터 |

## find와 비교

```bash
# find                                    # fd
find . -type f -name "*.go"               fd -e go
find . -iname "readme*"                   fd -i readme
find . -type d -name "config"             fd -t d config
find . -name "*.js" ! -path "*/node_*"    fd -e js    # gitignore 자동 반영
find . -mtime -7 -type f                  fd --changed-within 7d
find . -size +100M                        fd -S +100M
```

## 필터링

```bash
# 확장자로 필터 (여러 개 가능)
fd -e yaml -e yml

# 특정 디렉토리 제외
fd -E node_modules -E vendor "config"

# 숨김 파일 포함하되 .git 제외
fd -H -E .git

# 깊이 제한
fd -d 2

# glob 패턴
fd -g "*.test.ts"
fd -g "Dockerfile*"
```

## 시간/크기 필터

```bash
# 최근 1일 이내 수정된 파일
fd --changed-within 1d

# 최근 2시간 이내
fd --changed-within 2h

# 7일 이전에 수정된 파일
fd --changed-before 7d

# 100MB 이상 파일
fd -S +100M

# 1KB 미만 파일
fd -S -1k
```

## 명령어 실행 (-x, -X)

```bash
# 찾은 각 파일에 명령어 실행 (-x: 하나씩)
fd -e log -x rm {}

# 찾은 파일을 한 번에 전달 (-X: 한꺼번에)
fd -e go -X wc -l

# 플레이스홀더 활용
# {} : 전체 경로
# {/} : 파일명만
# {//} : 디렉토리만
# {.} : 확장자 제외 경로
# {/.} : 확장자 제외 파일명
fd -e jpg -x convert {} {.}.png
```

## 실전 활용 예시

### 프로젝트에서 특정 파일 빠르게 찾기

```bash
fd Dockerfile
fd -g "docker-compose*"
fd -e tf -e tfvars
```

### 최근 수정된 Go 파일 확인

```bash
fd -e go --changed-within 1d
```

### 빈 파일/디렉토리 정리

```bash
fd -t f -S 0 -x rm {}
fd -t d --empty -x rmdir {}
```

### 대용량 파일 찾기

```bash
fd -S +50M -t f
```

### K8s manifest 검색

```bash
fd -e yaml -e yml -x grep -l "kind: Deployment" {}
```

### fzf와 조합

```bash
# fd 결과를 fzf로 선택 후 vim으로 열기
fd -e go | fzf | xargs vim

# fzf 기본 검색 명령어를 fd로 변경 (.zshrc에 추가)
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND='fd --type f'
export FZF_ALT_C_COMMAND='fd --type d'
```

### rg와 역할 분담

```bash
# fd: 파일 이름으로 찾기
fd "config"

# rg: 파일 내용으로 찾기
rg "DB_HOST"

# 조합: 특정 파일을 찾은 뒤 내용 검색
fd -e yaml -x rg "replicas" {}
```
