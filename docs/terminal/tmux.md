# tmux

터미널 멀티플렉서. 세션 관리와 화면 분할을 담당.

## 핵심 개념

```
Session (프로젝트 단위)
 └── Window (탭)
      └── Pane (분할 화면)
```

- **Session**: 프로젝트별 독립 작업 공간. `my-app`, `infra` 등
- **Window**: 세션 안의 탭. 에디터, 빌드, 모니터링 등 용도별 구분
- **Pane**: 하나의 윈도우를 분할한 영역

## 핵심 가치

**세션 영속성**: 터미널을 닫아도, SSH가 끊겨도 세션이 살아있음.

- 금요일 퇴근 → 월요일 `tmux attach` → 그대로 이어서 작업
- 서버에서 배포 중 SSH 끊김 → 재접속 → 여전히 실행 중

## Ghostty와의 역할 구분

| 기능 | Ghostty 네이티브 | tmux 필요 |
|------|:-:|:-:|
| 탭/분할 | O | X |
| 세션 유지 (SSH 끊김 복구) | X | O |
| 원격 서버 작업 | X | O |
| 프로젝트 워크스페이스 전환 | 제한적 | O |
| AI agent 다중 실행 감시 | 제한적 | O |
| 스크립트로 레이아웃 자동 구성 | X | O |

## 기본 명령어

### 세션 관리

```bash
tmux new -s my-app       # 세션 생성
tmux attach -t my-app    # 세션 복귀
tmux ls                  # 세션 목록
tmux kill-session -t old # 세션 삭제
```

### 기본 단축키 (prefix: Ctrl-b)

```
Ctrl-b d      # detach (세션 분리, 백그라운드 유지)
Ctrl-b c      # 새 window
Ctrl-b w      # window 목록 (선택 전환)
Ctrl-b 0-9    # window 번호로 전환
Ctrl-b |      # 좌우 pane 분할 (커스텀)
Ctrl-b -      # 상하 pane 분할 (커스텀)
Ctrl-b 방향키  # pane 이동
Ctrl-b x      # 현재 pane 종료
Ctrl-b z      # pane 줌 토글 (전체화면)
```

## DevOps 활용 예시

### 프로젝트별 워크스페이스

```bash
# 세션 생성 + 레이아웃
tmux new -s infra -d
tmux send-keys -t infra 'kubectl get pods -w' Enter
tmux split-window -t infra -h
tmux send-keys -t infra 'stern -n prod app' Enter
tmux split-window -t infra -v
tmux send-keys -t infra 'htop' Enter
tmux attach -t infra
```

### AI agent 다중 모니터링

```
┌─────────────────────┬──────────────────────┐
│ claude (기능 구현)   │ claude (테스트 작성)   │
├─────────────────────┼──────────────────────┤
│ 빌드/로그 감시       │ lazygit              │
└─────────────────────┴──────────────────────┘
```

## 설정 시 주의사항

- **True Color**: `set -g default-terminal "tmux-256color"` 필요
- **클립보드**: macOS에서 tmux ↔ 시스템 클립보드 연동 설정 (tmux 3.2+ 네이티브 지원)
- **키바인딩 충돌**: Ghostty 단축키와 tmux prefix 키 겹침 주의
- **Nerd Font**: JetBrainsMono Nerd Font 사용 중이므로 상태바 아이콘 바로 사용 가능

## 추천 플러그인

- **tpm**: tmux plugin manager
- **tmux-resurrect**: 세션 레이아웃 저장/복원 (재부팅 후에도)
- **tmux-continuum**: resurrect 자동 저장
- **tmuxinator**: YAML로 복잡한 레이아웃 정의 및 자동 구성
