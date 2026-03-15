# direnv 사용법

> 디렉토리에 진입하면 `.envrc` 파일의 환경변수를
> 자동으로 로드하고, 빠져나오면 자동으로 언로드하는
> 도구. 프로젝트별 환경 분리에 필수.

## 설치

```bash
brew install direnv
```

## 쉘 통합

`.zshrc`에 아래 라인을 추가한다
(다른 설정보다 **맨 마지막에** 두는 것을 권장):

```bash
eval "$(direnv hook zsh)"
```

## 기본 워크플로우

### 1. 프로젝트 디렉토리에 `.envrc` 파일 생성

```bash
cd ~/dev/my-project
echo 'export DB_HOST=localhost' > .envrc
echo 'export DB_PORT=5432' >> .envrc
```

### 2. direnv가 차단 메시지를 표시

```text
direnv: error /Users/mshyeon/dev/my-project/.envrc is blocked.
Run `direnv allow` to approve its content.
```

### 3. 허용하면 환경변수가 로드됨

```bash
direnv allow
# direnv: loading ~/dev/my-project/.envrc
# direnv: export +DB_HOST +DB_PORT
```

### 4. 디렉토리를 벗어나면 자동 언로드

```bash
cd ~
# direnv: unloading
```

## 주요 명령어

| 명령어 | 설명 |
| --- | --- |
| `direnv allow` | 현재 디렉토리의 `.envrc` 허용 |
| `direnv deny` | 현재 디렉토리의 `.envrc` 차단 |
| `direnv reload` | `.envrc` 변경 후 수동 리로드 |
| `direnv status` | 현재 상태 확인 |
| `direnv edit .` | `$EDITOR`로 `.envrc` 편집 |

## .envrc 작성 예시

### 기본: 환경변수 설정

```bash
# .envrc
export DB_HOST=localhost
export DB_PORT=5432
export DB_NAME=myapp_dev
export API_KEY=dev-key-12345
```

### PATH에 로컬 bin 추가

```bash
# .envrc
PATH_add bin
# 또는
export PATH="$PWD/bin:$PATH"
```

### 다른 .env 파일 로드

```bash
# .envrc
dotenv .env
```

기존 `.env` 파일이 있는 프로젝트
(Docker Compose 등)에서 유용하다.

### 특정 버전 도구 사용 (asdf/mise 연동)

```bash
# .envrc
use asdf       # asdf 사용 시
# 또는
use mise       # mise 사용 시
```

### AWS 프로필 전환

```bash
# .envrc
export AWS_PROFILE=staging
export AWS_REGION=ap-northeast-2
```

### Terraform workspace 분리

```bash
# .envrc
export TF_WORKSPACE=dev
export TF_VAR_environment=dev
export TF_VAR_region=ap-northeast-2
```

### K8s context 전환

```bash
# .envrc
export KUBECONFIG="$PWD/kubeconfig.yaml"
# 또는
export KUBECONFIG="$HOME/.kube/config-staging"
```

## 실전 활용 패턴

### 프로젝트별 환경 분리

```text
~/dev/
├── project-a/
│   └── .envrc    # DB_HOST=db-a, AWS_PROFILE=team-a
├── project-b/
│   └── .envrc    # DB_HOST=db-b, AWS_PROFILE=team-b
└── infra/
    └── .envrc    # AWS_PROFILE=admin, TF_WORKSPACE=prod
```

디렉토리를 이동하면 환경변수가 자동으로 전환된다.

### 공통 설정 상속

```bash
# ~/dev/.envrc (상위 디렉토리)
export COMPANY_NAME=mycompany

# ~/dev/project-a/.envrc (하위 디렉토리)
source_up    # 상위 .envrc도 로드
export PROJECT=a
```

### dotenv 파일과 함께 사용

```bash
# .envrc
dotenv .env           # 기본 환경변수
dotenv_if_exists .env.local  # 로컬 오버라이드
```

## 보안 주의사항

- `.envrc`를 **수정할 때마다** `direnv allow`를
  다시 해야 한다 (보안을 위한 설계)
- `.envrc`에 실제 시크릿을 넣을 경우
  **반드시 `.gitignore`에 추가**:

```bash
echo ".envrc" >> .gitignore
```

- 또는 `.envrc`는 커밋하고,
  시크릿만 `.env.local`에 분리:

```bash
# .envrc (커밋 가능)
dotenv_if_exists .env.local
export APP_ENV=development

# .env.local (.gitignore에 추가)
DB_PASSWORD=supersecret
API_SECRET=abc123
```

## direnv 표준 라이브러리 (stdlib)

`.envrc`에서 사용할 수 있는 내장 함수들:

| 함수 | 설명 |
| --- | --- |
| `PATH_add <dir>` | PATH 앞에 디렉토리 추가 |
| `path_add <var> <dir>` | 임의 변수에 경로 추가 |
| `source_up` | 상위 디렉토리의 `.envrc` 로드 |
| `dotenv <file>` | `.env` 형식 파일 로드 |
| `dotenv_if_exists <file>` | 파일이 있을 때만 로드 |
| `layout python` | Python venv 자동 생성/활성화 |
| `layout go` | GOPATH 설정 |
| `use node` | `.node-version` 기반 노드 버전 |
| `log_status <msg>` | 상태 메시지 출력 |

전체 목록: `direnv stdlib`
