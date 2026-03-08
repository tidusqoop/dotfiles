# fzf 사용법

> 범용 퍼지 검색(fuzzy finder) 도구. 파일, 히스토리, 프로세스, git 브랜치 등 거의 모든 목록을 인터랙티브하게 검색할 수 있다.

## 쉘 통합 (Shell Integration)

`.zshrc`에 아래 라인을 추가하면 키바인딩과 자동완성이 활성화된다:

```bash
source <(fzf --zsh)
```

활성화되는 기능:
- `Ctrl+R` — 히스토리 퍼지 검색
- `Ctrl+T` — 현재 디렉토리 하위 파일 검색 후 커맨드라인에 붙여넣기
- `Alt+C` (macOS: `Esc+C`) — 디렉토리 검색 후 cd
- `**<Tab>` — 경로 자동완성 트리거 (예: `vim **<Tab>`, `cd **<Tab>`)

## 기본 사용법

```bash
# 현재 디렉토리 하위 파일 퍼지 검색
fzf

# 검색 결과를 vim으로 열기
vim $(fzf)

# 특정 명령어 출력을 fzf로 필터링 (파이프)
cat ~/.zshrc | fzf

# 여러 항목 선택 (Tab으로 토글, Enter로 확정)
fzf -m
```

## 검색 문법

| 패턴 | 의미 | 예시 |
|------|------|------|
| `abc` | 퍼지 매칭 (순서만 맞으면 됨) | `abc` → **a**x**b**y**c** |
| `'abc` | 정확한 매칭 (exact) | `'main` → "main"만 매칭 |
| `^abc` | 접두사 매칭 | `^src` → "src/"로 시작하는 항목 |
| `abc$` | 접미사 매칭 | `.go$` → ".go"로 끝나는 항목 |
| `!abc` | 제외 | `!test` → "test" 포함하지 않는 항목 |
| `a \| b` | OR 조건 | `main \| dev` |

여러 패턴을 공백으로 구분하면 AND 조건이 된다:
```
src .ts !test    → src 포함 AND .ts 포함 AND test 미포함
```

## 실전 활용 예시

### 히스토리 검색 (Ctrl+R)

```bash
# 쉘 통합 활성화 후 Ctrl+R을 누르면
# 이전에 실행한 명령어를 퍼지 검색할 수 있다
```

### git 브랜치 전환

```bash
git branch | fzf | xargs git checkout
```

### 프로세스 종료

```bash
ps aux | fzf | awk '{print $2}' | xargs kill
```

### 파일 미리보기와 함께 검색

```bash
# bat이 설치되어 있으면 구문 강조된 미리보기 제공
fzf --preview 'bat --color=always {}'
```

### docker 컨테이너 로그 보기

```bash
docker ps --format '{{.Names}}' | fzf | xargs docker logs -f
```

### kubectl pod 선택

```bash
kubectl get pods | fzf --header-lines=1 | awk '{print $1}' | xargs kubectl logs -f
```

## 환경변수로 기본값 설정

`.zshrc`에 추가:

```bash
# fzf 기본 옵션
export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border'

# Ctrl+T: fd 사용 (더 빠르고 .gitignore 반영)
export FZF_CTRL_T_COMMAND='fd --type f'

# Alt+C: fd 사용
export FZF_ALT_C_COMMAND='fd --type d'

# 기본 검색 명령어 (fd 사용)
export FZF_DEFAULT_COMMAND='fd --type f'
```

> `fd`가 설치되어 있으면 `FZF_DEFAULT_COMMAND`를 fd로 바꾸는 것을 권장한다. find보다 빠르고 `.gitignore`를 자동 반영한다.

## 키 조작

| 키 | 동작 |
|----|------|
| `↑` / `↓` | 항목 이동 |
| `Enter` | 선택 확정 |
| `Tab` | 다중 선택 모드에서 항목 토글 (`-m` 옵션 필요) |
| `Ctrl+C` / `Esc` | 취소 |
| `Ctrl+J` / `Ctrl+K` | 위/아래 이동 (화살표 대신) |
