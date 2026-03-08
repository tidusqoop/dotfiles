# zoxide 사용법

> `cd`의 상위 호환. 방문한 디렉토리를 학습하여 키워드만으로 빠르게 이동할 수 있는 도구.

## 쉘 통합

`.zshrc`에 추가:

```bash
eval "$(zoxide init zsh)"
```

이렇게 하면 `z` 명령어와 `zi` 명령어가 활성화된다.

## 기본 사용법

```bash
# 키워드로 이동 (가장 자주/최근 방문한 매칭 디렉토리로 이동)
z dotfiles        # ~/dev/mshyeon/dotfiles 로 이동
z dev             # ~/dev 로 이동

# 여러 키워드로 좁히기
z dev dot         # ~/dev/mshyeon/dotfiles 로 이동

# 인터랙티브 선택 (fzf 연동)
zi dotfiles       # 매칭되는 디렉토리 목록에서 선택

# 일반 cd처럼 사용 (절대/상대 경로)
z ~/projects
z ..
z ../other-dir
```

## 핵심 명령어

| 명령어 | 설명 |
|--------|------|
| `z <키워드>` | 가장 높은 점수의 매칭 디렉토리로 이동 |
| `z <키워드1> <키워드2>` | 여러 키워드로 좁혀서 이동 |
| `zi <키워드>` | fzf로 인터랙티브 선택 후 이동 |
| `z -` | 이전 디렉토리로 이동 (`cd -`와 동일) |

## 점수 시스템 (Frecency)

zoxide는 **frecency** (frequency + recency) 알고리즘을 사용한다:
- 자주 방문할수록 점수가 높아짐
- 최근 방문할수록 점수가 높아짐
- 오래 방문하지 않으면 점수가 자연 감소

```bash
# 현재 학습된 디렉토리와 점수 확인
zoxide query -ls

# 특정 키워드 매칭 결과 확인
zoxide query -ls dotfiles
```

## 데이터 관리

```bash
# 디렉토리 수동 추가
zoxide add ~/projects/my-app

# 디렉토리 제거 (삭제된 경로 정리 등)
zoxide remove ~/old/path

# 존재하지 않는 경로 일괄 정리
zoxide remove --invalid
```

## 사용 팁

- **처음에는 `cd`로 평소처럼 이동**하면 된다. zoxide가 백그라운드에서 자동 학습한다.
- 며칠 쓰면 자주 가는 디렉토리는 `z` + 키워드 2~3글자만으로 이동 가능해진다.
- 매칭이 애매할 때는 `zi`로 인터랙티브 선택을 사용한다.

## cd를 zoxide로 대체

완전히 대체하고 싶다면 init 시 `--cmd cd` 옵션을 사용:

```bash
eval "$(zoxide init zsh --cmd cd)"
```

이렇게 하면 `cd` 명령어 자체가 zoxide로 대체된다. 단, 처음에는 `z`로 시작해서 익숙해진 후 전환하는 것을 권장한다.
