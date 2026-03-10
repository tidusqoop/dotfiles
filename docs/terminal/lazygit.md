# lazygit

Git TUI 클라이언트. VS Code Source Control 패널 대체.

## 왜 lazygit인가

| 방식 | 장점 | 단점 |
|---|---|---|
| `git` CLI | 정밀 제어 | 상태 파악 느림, diff 보기 번거로움 |
| VS Code Git | 시각적 | 무거움, 터미널 밖 |
| **lazygit** | 시각적 + 키보드 + 터미널 네이티브 | 학습 필요 (쉬움) |

## 화면 구성

```
┌─ Status ──────┬─ Staged Changes ─────────────────┐
│ M config.yaml │ @@ -10,3 +10,5 @@                │
│ A new_file.py │ +new_line_1                       │
│ ? untracked   │ +new_line_2                       │
├─ Branches ────┤                                   │
│ * main        │                                   │
│   feature/x   │                                   │
├─ Commits ─────┤                                   │
│ abc1234 fix.. │                                   │
│ def5678 add.. │                                   │
└───────────────┴───────────────────────────────────┘
```

5개 패널: Status, Files, Branches, Commits, Stash
Tab 또는 숫자 1-5로 패널 간 이동.

## 핵심 단축키

### 파일 관리

```
space       # stage/unstage 토글
a           # 전체 stage/unstage
enter       # diff 확인
```

### 커밋

```
c           # commit (메시지 입력)
A           # amend (마지막 커밋 수정)
s           # squash (이전 커밋에 합치기)
```

### 브랜치

```
n           # 새 브랜치
space       # 브랜치 checkout
M           # merge
r           # rebase
```

### Push/Pull

```
p           # pull
P           # push
```

### 기타

```
?           # 도움말 (모든 단축키)
q           # 종료
[ ]         # 커밋 간 이동 (diff 미리보기)
```

## 주요 기능

### Interactive Rebase

커밋 목록에서 시각적으로 조작:
- 커밋 순서 변경 (드래그)
- squash, fixup, edit, drop
- VS Code에서는 CLI로만 가능했던 작업을 직관적으로

### Conflict 해결

충돌 발생 시 양쪽 변경사항을 나란히 보여줌.
키보드로 어느 쪽을 택할지 선택.

### Cherry-pick

다른 브랜치의 커밋을 현재 브랜치에 적용.
커밋 목록에서 선택 → 붙여넣기 방식.

## 학습 곡선

lazygit은 도구들 중 가장 쉽게 익힐 수 있음:

```
30분:  기본 stage → commit → push 워크플로우
1시간: 브랜치 관리, diff 확인
2시간: interactive rebase, stash, conflict 해결
```

## 실행

```bash
# 설치
brew install lazygit

# 실행 (git 저장소 안에서)
lazygit

# alias 추천
alias lg='lazygit'
```
