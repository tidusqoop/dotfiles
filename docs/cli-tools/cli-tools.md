# 1단계: 핵심 CLI 도구

DevOps / 백엔드 개발자를 위한 필수 CLI 도구 목록

## 설치 명령어

```bash
brew install ripgrep fzf bat eza tree zoxide fd jq yq delta htop tldr direnv
```

## 도구별 요약

| 도구 | 대체 대상 | 설명 |
|------|----------|------|
| **fzf** | Ctrl+R (히스토리) | 퍼지 검색 도구. 히스토리 검색, 파일 찾기, 브랜치 선택 등 다양하게 활용 |
| **bat** | `cat` | 구문 강조(syntax highlighting) 지원하는 cat. 줄번호, 테마 지원 |
| **eza** | `ls` | 아이콘, 색상, git 상태 표시, 트리뷰 지원하는 ls |
| **tree** | - | 디렉토리 구조를 트리 형태로 시각화. 프로젝트 구조 파악에 유용 |
| **zoxide** | `cd` | 자주 방문한 디렉토리를 학습해서 `z 키워드`만으로 이동 |
| **fd** | `find` | 더 빠르고 직관적인 파일 검색. `.gitignore` 자동 반영 |
| **jq** | - | JSON 파싱/필터링 도구. API 응답, K8s 출력, Terraform state 처리에 필수 |
| **yq** | - | YAML 파싱/필터링 도구. K8s manifest, docker-compose 등 다룰 때 유용 |
| **delta** | `git diff` | 구문 강조 + side-by-side diff. git과 연동하여 diff/log 출력 개선 |
| **lazygit** | VS Code Git | Git TUI 클라이언트. 시각적 stage/commit/rebase/conflict 해결 |
| **htop** | `top` | 인터랙티브 프로세스 모니터링. CPU/메모리 사용량을 시각적으로 확인 |
| **tldr** | `man` | 명령어의 핵심 사용 예시만 보여주는 축약 매뉴얼 |
| **direnv** | - | 디렉토리 진입 시 `.envrc` 파일의 환경변수를 자동 로드/언로드 |

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
