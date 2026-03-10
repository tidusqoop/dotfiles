# delta 사용법

> `git diff`의 상위 호환. 구문 강조, 줄번호, side-by-side 비교를 지원하는 diff 출력 도구. git과 연동하면 diff, log, show, blame 출력이 모두 개선된다.

## 설치

```bash
brew install git-delta
```

## git 연동 설정

`~/.gitconfig`에 아래 설정을 추가한다:

```ini
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    side-by-side = true
    line-numbers = true

[merge]
    conflictstyle = zdiff3
```

설정 후 `git diff`, `git log -p`, `git show`, `git blame` 등의 출력이 자동으로 delta를 통해 렌더링된다.

## 기본 사용법

```bash
# git 명령어는 평소대로 사용 — 출력만 delta로 변경됨
git diff
git diff --staged
git log -p
git show HEAD
git blame main.go
```

## 독립 실행 (git 없이)

```bash
# 두 파일 비교
delta file_a.go file_b.go

# diff 출력을 delta로 파이프
diff -u old.txt new.txt | delta

# stdin으로 diff 포맷 입력
kubectl diff -f deployment.yaml | delta
```

## 주요 옵션

| 옵션 | 설명 |
|------|------|
| `--side-by-side` / `-s` | 좌우 분할 비교 |
| `--line-numbers` / `-n` | 줄번호 표시 |
| `--navigate` | n/N 키로 파일 간 이동 |
| `--dark` / `--light` | 다크/라이트 테마 |
| `--syntax-theme <테마>` | 구문 강조 테마 지정 |
| `--width <n>` | 출력 너비 지정 (side-by-side에서 유용) |
| `--diff-so-fancy` | diff-so-fancy 스타일 레이아웃 |
| `--color-only` | 색상만 적용 (레이아웃 변경 없음) |

## 네비게이션 (navigate 모드)

`navigate = true` 설정 시 less에서 파일 간 이동이 가능하다:

| 키 | 동작 |
|----|------|
| `n` | 다음 파일로 이동 |
| `N` | 이전 파일로 이동 |
| `q` | 종료 |

## 테마

```bash
# 사용 가능한 테마 목록
delta --list-syntax-themes

# 특정 테마로 미리보기
delta --syntax-theme="Dracula" < <(git diff)
```

`~/.gitconfig`에서 기본 테마 설정:

```ini
[delta]
    syntax-theme = Catppuccin Mocha
```

## side-by-side 임시 토글

기본으로 side-by-side를 사용하되, 가끔 일반 모드로 보고 싶을 때:

```bash
# side-by-side 끄기
git -c delta.side-by-side=false diff

# alias로 등록 (.zshrc)
alias gdiff='git -c delta.side-by-side=false diff'
```

## 실전 활용 예시

### git log에서 변경 내용 확인

```bash
# 최근 커밋의 변경 내용 (구문 강조 + side-by-side)
git log -p -1

# 특정 파일의 변경 이력
git log -p -- src/main.go
```

### merge conflict 확인

```bash
# zdiff3 스타일로 충돌 표시
git diff
```

`merge.conflictstyle = zdiff3` 설정이 있으면 충돌 시 base/ours/theirs 세 가지를 모두 보여준다.

### git blame 가독성 향상

```bash
git blame src/main.go
```

### PR 리뷰 전 변경 확인

```bash
# main 브랜치와 비교
git diff main...HEAD
```
