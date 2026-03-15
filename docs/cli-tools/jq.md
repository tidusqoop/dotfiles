# jq 사용법

> JSON 데이터를 파싱, 필터링, 변환하는 CLI 도구.
> API 응답, K8s 출력, Terraform state 처리에 필수.

## 기본 사용법

```bash
# JSON 예쁘게 출력 (pretty print)
echo '{"name":"kim","age":30}' | jq '.'

# 파일에서 읽기
jq '.' data.json

# curl 응답 파싱
curl -s https://api.example.com/users | jq '.'
```

## 필드 접근

```bash
# 단일 필드
echo '{"name":"kim","age":30}' | jq '.name'
# → "kim"

# 중첩 필드
echo '{"user":{"name":"kim"}}' | jq '.user.name'
# → "kim"

# 따옴표 없이 출력 (-r: raw output)
echo '{"name":"kim"}' | jq -r '.name'
# → kim
```

## 배열 다루기

```bash
# 전체 배열 요소 순회
echo '[{"name":"kim"},{"name":"lee"}]' | jq '.[].name'
# → "kim"
# → "lee"

# 특정 인덱스
echo '[1,2,3]' | jq '.[0]'
# → 1

# 배열 슬라이싱
echo '[1,2,3,4,5]' | jq '.[2:4]'
# → [3,4]

# 배열 길이
echo '[1,2,3]' | jq 'length'
# → 3
```

## 필터링

```bash
# select: 조건에 맞는 항목만
echo '[{"name":"kim","age":30},{"name":"lee","age":25}]' \
  | jq '.[] | select(.age > 27)'
# → {"name":"kim","age":30}

# 문자열 포함 여부
echo '[{"name":"backend"},{"name":"frontend"}]' \
  | jq '.[] | select(.name | contains("back"))'

# null이 아닌 항목만
jq '.[] | select(.value != null)' data.json
```

## 변환

```bash
# 새로운 객체 만들기
echo '{"first":"kim","last":"minsoo"}' \
  | jq '{fullName: (.first + " " + .last)}'
# → {"fullName":"kim minsoo"}

# 배열에서 특정 필드만 추출
echo '[{"name":"kim","age":30},{"name":"lee","age":25}]' \
  | jq '[.[] | .name]'
# → ["kim","lee"]

# map으로 변환
echo '[1,2,3]' | jq 'map(. * 2)'
# → [2,4,6]

# 키-값 뒤집기
echo '{"a":1,"b":2}' | jq 'to_entries'
# → [{"key":"a","value":1},{"key":"b","value":2}]
```

## 실전 활용

### kubectl 출력 파싱

```bash
# Pod 이름만 추출
kubectl get pods -o json \
  | jq -r '.items[].metadata.name'

# Running 상태인 Pod만
kubectl get pods -o json \
  | jq -r '.items[]
    | select(.status.phase == "Running")
    | .metadata.name'

# 특정 라벨의 Pod
kubectl get pods -o json \
  | jq -r '.items[]
    | select(.metadata.labels.app == "nginx")
    | .metadata.name'
```

### Terraform state 파싱

```bash
# 리소스 목록
terraform show -json \
  | jq '.values.root_module.resources[].address'

# 특정 리소스 타입만
terraform show -json \
  | jq '.values.root_module.resources[]
    | select(.type == "aws_instance")'
```

### API 응답 처리

```bash
# GitHub API에서 repo 이름과 star 수
curl -s https://api.github.com/users/octocat/repos \
  | jq '.[] | {name, stars: .stargazers_count}'

# 정렬
curl -s https://api.github.com/users/octocat/repos \
  | jq 'sort_by(.stargazers_count)
    | reverse | .[:5] | .[].name'
```

### docker 출력 파싱

```bash
# 컨테이너 IP 주소
docker inspect <container> \
  | jq -r '.[0].NetworkSettings.IPAddress'

# 환경변수 확인
docker inspect <container> \
  | jq '.[0].Config.Env'
```

## 유용한 옵션

| 옵션 | 설명 |
| --- | --- |
| `-r` | 따옴표 없이 문자열 출력 (raw) |
| `-c` | 한 줄로 압축 출력 (compact) |
| `-e` | 결과가 false/null이면 exit code 1 |
| `-s` | 여러 JSON 입력을 배열로 합침 (slurp) |
| `--arg key val` | 외부 변수를 jq 필터에 전달 |

### 변수 전달 예시

```bash
NAME="kim"
echo '{"name":"kim","age":30}' \
  | jq --arg n "$NAME" 'select(.name == $n)'
```
