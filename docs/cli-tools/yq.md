# yq 사용법

> YAML 데이터를 파싱, 필터링, 변환하는 CLI 도구.
> K8s manifest, docker-compose, Helm values 등을
> 다룰 때 유용.
> 문법은 jq와 유사하지만 YAML 입출력을 지원한다.

## 기본 사용법

```bash
# YAML 파일 읽기 (예쁘게 출력)
yq '.' config.yaml

# 특정 필드 읽기
yq '.metadata.name' deployment.yaml

# 따옴표 없이 출력
yq -r '.metadata.name' deployment.yaml
```

## 필드 접근

```bash
# 단일 필드
yq '.name' config.yaml

# 중첩 필드
yq '.spec.containers[0].image' pod.yaml

# 배열 전체 순회
yq '.spec.containers[].name' pod.yaml
```

## 값 수정 (in-place)

```bash
# 필드 값 변경
yq -i '.spec.replicas = 3' deployment.yaml

# 필드 추가
yq -i '.metadata.labels.env = "production"' \
  deployment.yaml

# 필드 삭제
yq -i 'del(.metadata.annotations)' deployment.yaml

# 배열에 항목 추가
yq -i '.spec.containers[0].ports
  += [{"containerPort": 8080}]' pod.yaml
```

## 필터링

```bash
# 조건 필터
yq '.items[] | select(.kind == "Deployment")' \
  resources.yaml

# 문자열 포함 여부
yq '.items[]
  | select(.metadata.name | contains("nginx"))' \
  resources.yaml
```

## 형식 변환

```bash
# YAML → JSON
yq -o json '.' config.yaml

# JSON → YAML
yq -P '.' config.json

# YAML → Properties
yq -o props '.' config.yaml
```

## 멀티 도큐먼트 (--- 구분자)

K8s manifest는 `---`로 여러 리소스를 구분하는
경우가 많다.

```bash
# 모든 도큐먼트에서 kind 확인
yq eval-all '.kind' manifest.yaml

# 특정 kind만 추출
yq eval-all \
  'select(.kind == "Service")' manifest.yaml

# 도큐먼트 수 세기
yq eval-all '[.] | length' manifest.yaml
```

## 실전 활용

### K8s manifest 편집

```bash
# 이미지 태그 변경
yq -i '.spec.template.spec.containers[0].image
  = "nginx:1.25"' deployment.yaml

# 리소스 제한 추가
yq -i '.spec.template.spec.containers[0]
  .resources.limits.memory = "256Mi"' \
  deployment.yaml

# 환경변수 추가
yq -i '.spec.template.spec.containers[0].env
  += [{"name": "LOG_LEVEL", "value": "info"}]' \
  deployment.yaml
```

### docker-compose 편집

```bash
# 서비스 목록 확인
yq '.services | keys' docker-compose.yaml

# 특정 서비스의 이미지 변경
yq -i '.services.web.image = "node:20-alpine"' \
  docker-compose.yaml

# 포트 추가
yq -i '.services.web.ports += ["9090:9090"]' \
  docker-compose.yaml
```

### Helm values 관리

```bash
# 현재 values 확인
yq '.replicaCount' values.yaml

# 환경별 values 머지
yq eval-load-all \
  'select(fi == 0) * select(fi == 1)' \
  values.yaml values-prod.yaml
```

### CI/CD 파이프라인에서 활용

```bash
# GitHub Actions에서 특정 job 확인
yq '.jobs.build.steps[].name' \
  .github/workflows/ci.yaml

# 버전 범프
VERSION="1.2.3"
yq -i ".version = \"$VERSION\"" Chart.yaml
```

## jq와의 비교

| 기능 | jq | yq |
| --- | --- | --- |
| 입력 형식 | JSON | YAML, JSON, XML, CSV |
| 출력 형식 | JSON | YAML, JSON, Props 등 |
| in-place 수정 | 불가 | `-i` 옵션 |
| 멀티 도큐먼트 | 불가 | `eval-all` |
| 문법 | jq 문법 | jq 유사 문법 |
