# Cheatsheet

빠른 참조용. 개념 설명은 [terminal/](terminal/) 하위 문서 참고.

---

## Shell Aliases

### 파일 / 탐색

| 명령 | 원본 | 설명 |
| --- | --- | --- |
| `ls` | `eza` | 파일 목록 |
| `ll` | `eza -l --git -h --group-directories-first` | 상세 목록 (git 상태 포함) |
| `la` | `eza -la ...` | 숨김 파일 포함 상세 |
| `lt` | `eza --tree --level=2 --git-ignore` | 트리 뷰 |
| `cat` | `bat -pp` | 구문 강조 출력 |
| `grep` | `rg` (ripgrep) | 빠른 검색 |

### 에디터 / Git

| 명령 | 설명 |
| --- | --- |
| `vim` | nvim 실행 |
| `lg` | lazygit |

### tmux Alias

| 명령 | 설명 |
| --- | --- |
| `tn <name>` | 새 세션 생성 |
| `ta <name>` | 세션 복귀 |
| `tl` | 세션 목록 |
| `mux` | tmuxinator |

### Claude CLI

| 명령 | 설명 |
| --- | --- |
| `cl` | claude |
| `cy` | claude --dangerously-skip-permissions |
| `clr` | claude --resume |
| `cyr` | claude --dangerously-skip-permissions --resume |

### Kubernetes

| 명령 | 설명 |
| --- | --- |
| `k` | kubectl |

---

## Shell Tools

### FZF (퍼지 검색)

| 단축키 | 설명 |
| --- | --- |
| `Ctrl-T` | 파일 검색 → 커맨드라인에 삽입 |
| `Ctrl-R` | 히스토리 검색 |
| `Alt-C` | 디렉토리 검색 → 이동 |

### Zoxide (스마트 cd)

```text
z <keyword>    # 히스토리 기반 디렉토리 이동
zi             # 대화형 선택 (fzf)
z -            # 이전 디렉토리
```

### Yazi (파일 매니저)

```text
y              # 실행 (종료 시 해당 디렉토리로 이동)
h / l          # 상위 / 하위 디렉토리
j / k          # 아래 / 위
Enter          # 열기
q              # 종료
Ctrl-h         # 숨김 파일 토글  ⭐ 커스텀
```

---

## Aerospace (Window Tiling)

modifier: `CapsLock` = Ctrl+Option (Karabiner 리매핑)
- CapsLock 단독 탭 → `Escape`

### 창 포커스 / 이동

```text
CapsLock + ←↑↓→        # 포커스 이동
CapsLock + ⇧ + ←↑↓→    # 창 위치 이동
```

### 워크스페이스

```text
CapsLock + 1~5         # 왼쪽 모니터 워크스페이스 전환
CapsLock + 6~9         # 오른쪽 모니터 워크스페이스 전환
CapsLock + ⇧ + 1~9     # 현재 창을 워크스페이스로 이동
```

### 모니터

```text
CapsLock + ,           # 포커스를 이전 모니터로
CapsLock + .           # 포커스를 다음 모니터로
CapsLock + ⇧ + ,       # 창을 이전 모니터로 이동
CapsLock + ⇧ + .       # 창을 다음 모니터로 이동
```

### 기타

```text
CapsLock + /           # 레이아웃 전환 (수평 ↔ 수직)
CapsLock + f           # 풀스크린 토글
CapsLock + ⇧ + r       # 설정 리로드
```

### Karabiner 키 리매핑

```text
CapsLock (탭)          # Escape
오른쪽 Command         # 한/영 전환
```

---

## tmux

prefix: `Ctrl-b`

### 세션

```text
Ctrl-b d       # detach (세션 유지, 터미널만 닫기)
Ctrl-b $       # 세션 이름 변경
Ctrl-b s       # 세션 목록 (선택 전환)
Ctrl-b (       # 이전 세션
Ctrl-b )       # 다음 세션
```

### Window (탭)

```text
Ctrl-b c       # 새 window (현재 경로 유지)  ⭐ 커스텀
Ctrl-b n / p   # 다음 / 이전 window
Ctrl-b 1~9     # window 번호로 전환
Ctrl-b w       # window 목록 (선택 전환)
Ctrl-b ,       # window 이름 변경
Ctrl-b &       # window 닫기
```

### Pane (분할 화면)

```text
Ctrl-b |       # 좌우 분할 (현재 경로 유지)  ⭐ 커스텀
Ctrl-b -       # 상하 분할 (현재 경로 유지)  ⭐ 커스텀
Ctrl-b ←↑↓→    # pane 이동
Ctrl-b z       # pane 줌 토글 (전체화면 ↔ 복귀)
Ctrl-b x       # 현재 pane 닫기
Ctrl-b !       # pane → 새 window로 분리
Ctrl-b q       # pane 번호 표시
```

### Pane 크기 조절

```text
Ctrl-b H / J / K / L   # 좌 / 하 / 상 / 우로 5칸 조절 (반복 가능)  ⭐ 커스텀
```

### Copy Mode (스크롤 / 복사)

```text
Ctrl-b [       # copy mode 진입
q 또는 Esc     # 종료
↑↓ / hjkl     # 이동
PgUp / PgDn   # 페이지 스크롤
/              # 앞으로 검색
?              # 뒤로 검색
Space          # 선택 시작
Enter          # 복사 후 종료
```

### 커맨드 모드 (`Ctrl-b :`)

```text
세션
  new -s <name>              새 세션 생성
  kill-session -t <name>     세션 삭제
  rename-session <name>      현재 세션 이름 변경

Window
  new-window -n <name>       이름 지정해서 새 window 생성
  kill-window                현재 window 닫기
  rename-window <name>       현재 window 이름 변경

Pane
  split-window -h            좌우 분할
  split-window -v            상하 분할
  kill-pane                  현재 pane 닫기

기타
  source ~/.config/tmux/tmux.conf   설정 파일 리로드
  setw synchronize-panes on         모든 pane에 동시 입력
  setw synchronize-panes off        동시 입력 해제
  set -g mouse on / off             마우스 토글
```

### 플러그인 단축키

```text
Ctrl-b Ctrl-s  # 세션 저장 (tmux-resurrect)
Ctrl-b Ctrl-r  # 세션 복원 (tmux-resurrect)
```

---

## Neovim (LazyVim)

leader: `Space`

### 모드 전환

```text
Esc / Ctrl-c   # → Normal
i              # 커서 앞 → Insert
a              # 커서 뒤 → Insert
I / A          # 줄 맨 앞 / 맨 뒤 → Insert
o / O          # 아래 / 위 새 줄 추가 → Insert
v / V          # 문자 / 줄 → Visual
Ctrl-v         # 블록 선택 → Visual Block
:              # → Command
```

### 이동 — 기본

```text
h j k l        # 좌 하 상 우
w / b          # 다음 / 이전 단어 시작
e              # 단어 끝
0 / $          # 줄 처음 / 끝 (공백 포함)
^              # 줄 첫 글자 (공백 제외)
gg / G         # 파일 처음 / 끝
:<n>           # n번 줄로 이동  (예: :42)
```

### 이동 — 응용

```text
Ctrl-d / u     # 반 페이지 아래 / 위
Ctrl-f / b     # 한 페이지 아래 / 위
f<c> / F<c>    # 같은 줄에서 문자 c로 점프
t<c> / T<c>    # 문자 c 직전 / 직후로 점프
;              # f/t 반복
%              # 매칭 괄호로 이동  ({[
{ / }          # 문단 단위 이동
H / M / L      # 화면 위 / 중간 / 아래로 커서 이동
zz / zt / zb   # 현재 줄을 화면 중앙 / 상단 / 하단으로
```

### 편집

```text
x              # 문자 하나 삭제
r<c>           # 문자 하나 교체
dd / D         # 줄 삭제 / 줄 끝까지 삭제
yy             # 줄 복사
p / P          # 커서 아래 / 위에 붙여넣기
u / Ctrl-r     # undo / redo
.              # 마지막 편집 반복  ← 매우 유용
J              # 아래 줄을 현재 줄에 합치기
~              # 대소문자 전환
```

### Operator + Motion 조합

operator는 모션과 결합해서 범위를 지정한다.

```text
d<motion>      # 삭제    dw, d$, d3j, dG
c<motion>      # 변경    cw, c$  (삭제 후 Insert 모드)
y<motion>      # 복사    yw, y$
><motion>      # 들여쓰기    >> (현재 줄)
<<motion>      # 내어쓰기
=<motion>      # 자동 정렬
```

### Text Object (텍스트 오브젝트)

`d` / `c` / `y` + `i` (안쪽) / `a` (포함) + 범위

```text
iw / aw        # 단어 안 / 단어 + 공백
i" / a"        # "" 안 / "" 포함  (i' / a' 동일)
i( / a(        # () 안 / () 포함  (ib / ab 동일)
i{ / a{        # {} 안 / {} 포함  (iB / aB 동일)
i[ / a[        # [] 안 / [] 포함
it / at        # HTML 태그 안 / 태그 포함

예시
  ciw           단어 교체
  da"           따옴표 포함해서 삭제
  yi(           괄호 안 내용 복사
  >ib           블록 들여쓰기
```

### 검색 / 치환

```text
/<pattern>     # 앞으로 검색  (Enter로 확정)
?<pattern>     # 뒤로 검색
n / N          # 다음 / 이전 결과
*              # 커서 위 단어 검색
#              # 커서 위 단어 역방향 검색

:%s/old/new/g  # 전체 치환
:%s/old/new/gc # 전체 치환 (하나씩 확인)
:s/old/new/g   # 현재 줄만 치환
```

### 파일 / 버퍼

```text
:w             # 저장
:q             # 종료
:wq / :x       # 저장 후 종료
:q!            # 강제 종료 (저장 안 함)
:e <file>      # 파일 열기
:e!            # 현재 파일 다시 로드 (외부 변경 반영)

Shift-h / Shift-l   # 이전 / 다음 버퍼
[b / ]b             # 이전 / 다음 버퍼
```

### 창 분할

```text
Ctrl-w s       # 수평 분할
Ctrl-w v       # 수직 분할
Ctrl-w h/j/k/l # 분할 창 이동
Ctrl-w =       # 창 크기 균등 분배
Ctrl-w q       # 현재 창 닫기
```

### LazyVim — Space Leader

```text
파일 찾기
  <Space><Space>   최근 파일 목록
  <Space>ff        파일 이름 검색
  <Space>fg        텍스트 grep 검색
  <Space>fb        열린 버퍼 목록
  <Space>fr        최근 파일

탐색 / Git
  <Space>e         파일 탐색기 토글
  <Space>gg        lazygit

버퍼
  <Space>bd        현재 버퍼 닫기
  <Space>bD        다른 버퍼 모두 닫기

창
  <Space>|         수직 분할
  <Space>-         수평 분할
```

### LazyVim — LSP

```text
이동
  gd             정의로 이동
  gD             선언으로 이동
  gr             참조 목록
  gI             구현으로 이동
  gy             타입 정의로 이동
  K              hover 문서 표시

오류
  ]d / [d        다음 / 이전 diagnostic
  ]e / [e        다음 / 이전 오류
  ]w / [w        다음 / 이전 경고
  <Space>cd      현재 줄 오류 표시

편집
  <Space>ca      code action
  <Space>cr      이름 변경 (rename)
  <Space>cf      포맷
```

---

## Claude Code

### 입력 편집

```text
Ctrl-A / Ctrl-E    줄 처음 / 끝으로 커서 이동
Alt-B / Alt-F      단어 단위 커서 이동
Ctrl-W             이전 단어 삭제
Ctrl-U             커서 앞 전체 삭제
Ctrl-K             커서 뒤 전체 삭제
Ctrl-Y             삭제한 텍스트 붙여넣기
Ctrl-R             이전 명령 검색
```

### 멀티라인 입력

```text
Shift-Enter        새 줄 (Ghostty 네이티브 지원)
\ + Enter          새 줄 (모든 터미널)
Ctrl-J             새 줄 (모든 터미널)
Ctrl-G             외부 에디터($EDITOR)로 프롬프트 작성
```

### 응답 제어

```text
Ctrl-C             생성 중단 / 입력 취소
Esc Esc            이전 상태로 되감기 (rewind)
```

### 세션

```text
/clear             대화 기록 초기화
/compact           컨텍스트 요약 압축
Ctrl-L             화면 리드로우 (기록 유지)
Ctrl-D             세션 종료
```

### 기타

```text
!<cmd>             bash 명령 직접 실행 (예: !git status)
@                  파일 경로 자동완성
?                  현재 환경 단축키 목록 표시
Shift-Tab          권한 모드 순환 (default → plan → auto)
```
