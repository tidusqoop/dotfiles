# tree 사용법

> 디렉토리 구조를 트리 형태로 시각화하는 도구.
> 프로젝트 구조 파악, 문서화, 디버깅에 유용하다.

## 설치

```bash
brew install tree
```

## 기본 사용법

```bash
# 현재 디렉토리 트리 출력
tree

# 특정 디렉토리 트리 출력
tree src/

# 깊이 제한 (2단계까지만)
tree -L 2

# 디렉토리만 표시
tree -d

# 디렉토리만 + 깊이 제한
tree -d -L 3
```

## 주요 옵션

| 옵션 | 설명 |
| --- | --- |
| `-L <n>` | 깊이를 n단계로 제한 |
| `-d` | 디렉토리만 표시 |
| `-a` | 숨김 파일/디렉토리 포함 |
| `-f` | 각 파일의 전체 경로 표시 |
| `-I <패턴>` | 특정 패턴 제외 |
| `-P <패턴>` | 특정 패턴만 표시 |
| `--prune` | 빈 디렉토리 숨김 (`-P`와 함께) |
| `-s` | 파일 크기 표시 |
| `-h` | 사람이 읽기 쉬운 크기 (KB, MB) |
| `--du` | 디렉토리별 누적 크기 표시 |
| `-p` | 파일 퍼미션 표시 |
| `--dirsfirst` | 디렉토리를 파일보다 먼저 표시 |
| `-C` | 색상 출력 (기본 활성화) |
| `--noreport` | 하단 요약 숨김 |

## 필터링

```bash
# node_modules, .git 제외
tree -I "node_modules|.git|__pycache__"

# Go 파일만 표시
tree -P "*.go" --prune

# YAML 파일만 표시
tree -P "*.yaml|*.yml" --prune

# 숨김 파일 포함하되 .git 제외
tree -a -I ".git"
```

## 출력 형식

```bash
# 파일 크기와 함께 출력
tree -sh

# 퍼미션과 함께 출력
tree -p

# 디렉토리별 용량 확인
tree --du -h -d -L 2

# 전체 경로 표시
tree -f -L 2

# JSON 형식 출력
tree -J

# 디렉토리 우선 정렬
tree --dirsfirst
```

## 실전 활용 예시

### 프로젝트 구조 파악

```bash
# 프로젝트 최상위 구조만 빠르게 확인
tree -L 1

# 소스 코드 구조 확인 (불필요한 디렉토리 제외)
tree -L 3 -I "node_modules|vendor|.git|dist|build"
```

### K8s manifest 구조 확인

```bash
tree -P "*.yaml|*.yml" --prune k8s/
```

### Terraform 모듈 구조 확인

```bash
tree -P "*.tf" --prune -L 3
```

### 디렉토리 크기 분석

```bash
# 어떤 디렉토리가 큰지 확인
tree --du -h -d -L 2 | tail -20
```

### 결과를 파일로 저장 (문서화용)

```bash
tree -L 3 -I "node_modules|.git" \
  > project-structure.txt
```

### bat과 조합 (색상 유지)

```bash
tree -C -L 3 | bat -p
```
