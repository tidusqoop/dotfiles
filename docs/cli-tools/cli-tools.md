# 1단계: 핵심 CLI 도구

DevOps / 백엔드 개발자를 위한 필수 CLI 도구 목록

## 설치 명령어

```bash
brew install ripgrep fzf bat eza tree zoxide \
  fd jq yq delta htop tldr direnv
```

## 도구별 요약

| 도구 | 대체 대상 | 설명 |
| --- | --- | --- |
| **fzf** | Ctrl+R | 퍼지 검색 도구. 히스토리, 파일, 브랜치 등 |
| **bat** | `cat` | 구문 강조 지원 cat. 줄번호, 테마 지원 |
| **eza** | `ls` | 아이콘, 색상, git 상태, 트리뷰 지원 ls |
| **tree** | - | 디렉토리 구조를 트리 형태로 시각화 |
| **zoxide** | `cd` | 자주 방문한 디렉토리를 학습하여 빠른 이동 |
| **fd** | `find` | 빠르고 직관적인 파일 검색. gitignore 반영 |
| **jq** | - | JSON 파싱/필터링. API, K8s, Terraform용 |
| **yq** | - | YAML 파싱/필터링. K8s, docker-compose용 |
| **delta** | `git diff` | 구문 강조 + side-by-side diff |
| **lazygit** | VS Code Git | Git TUI. stage/commit/rebase/conflict |
| **htop** | `top` | 인터랙티브 프로세스 모니터링 |
| **tldr** | `man` | 명령어 핵심 사용 예시만 보여주는 매뉴얼 |
| **direnv** | - | 디렉토리별 환경변수 자동 로드/언로드 |

## 설치 상태

- [x] ripgrep (rg)
- [x] fzf
- [x] bat
- [x] eza
- [x] tree
- [x] zoxide
- [x] fd
- [x] jq
- [x] yq
- [x] delta
- [x] htop
- [ ] tldr - 필요성 아직 와닿지 않아 보류
- [x] direnv
- [x] lazygit
