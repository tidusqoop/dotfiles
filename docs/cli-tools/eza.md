# eza 사용법

> `ls`의 상위 호환. 색상, 아이콘, Git 상태 표시,
> 트리뷰를 지원하는 파일 목록 도구.

## 기본 사용법

```bash
# 기본 파일 목록
eza

# 상세 목록 (ls -l 대체)
eza -l

# 숨김 파일 포함 (ls -la 대체)
eza -la

# 트리뷰
eza --tree

# 트리뷰 깊이 제한
eza --tree --level=2

# 아이콘 표시 (Nerd Font 필요)
eza --icons
```

## 주요 옵션

| 옵션 | 설명 |
| --- | --- |
| `-l` | 상세 목록 (퍼미션, 크기, 날짜 등) |
| `-a` | 숨김 파일 포함 |
| `-h` | 헤더 표시 (컬럼명) |
| `--tree` | 트리 형태로 출력 |
| `--level=N` | 트리 깊이 제한 |
| `--icons` | 파일 타입별 아이콘 (Nerd Font 필요) |
| `--git` | Git 상태 표시 (staged/modified 등) |
| `--git-ignore` | `.gitignore`에 등록된 파일 숨김 |
| `-s <field>` | 정렬 (name, size, date, type 등) |
| `-r` | 역순 정렬 |
| `--group-directories-first` | 디렉토리를 먼저 표시 |
| `--no-permissions` | 퍼미션 컬럼 숨김 |
| `--no-user` | 소유자 컬럼 숨김 |
| `--time-style=relative` | "2 hours ago" 형태로 표시 |

## 실전 활용 예시

### 디렉토리 구조 파악

```bash
# 프로젝트 구조를 트리로 보기 (gitignore 반영)
eza --tree --level=3 --git-ignore

# 디렉토리만 보기
eza --tree -D
```

### Git 상태와 함께 보기

```bash
# 파일별 git 상태 확인
eza -l --git

# 출력 예시:
# .rw-r--r--  1.2k mshyeon  -- README.md
# .rw-r--r--   850 mshyeon  M- src/main.go
# .rw-r--r--   320 mshyeon  -M src/util.go
```

### 파일 크기 기준 정렬

```bash
# 큰 파일부터 정렬
eza -l -s size -r
```

### 최근 수정된 파일 확인

```bash
# 최근 수정순 정렬
eza -l -s modified -r
```

## 추천 alias 설정

`.zshrc`에 추가:

```bash
alias ls='eza'
alias ll='eza -l --git -h --group-directories-first'
alias la='eza -la --git -h --group-directories-first'
alias lt='eza --tree --level=2 --git-ignore'
```

## Nerd Font 아이콘

`--icons` 옵션을 사용하려면
Nerd Font가 설치되어 있어야 한다.

```bash
# Nerd Font 설치 (예: JetBrains Mono)
brew install --cask font-jetbrains-mono-nerd-font
```

설치 후 터미널 앱에서 해당 폰트로 변경하면
아이콘이 정상 표시된다.
