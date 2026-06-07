# 서비스 배포

할당받은 Ubuntu VM에는 Python이 기본 설치되어 있습니다. 별도 패키지를 설치하지 않고도 간단한 웹페이지를 만들어 `http://학번.dauswc.org`에서 확인할 수 있습니다.

::: info 반드시 8080 포트를 사용하세요
운영진은 각 학생의 서브도메인을 해당 VM의 `8080` 포트에 연결해두었습니다. 다른 포트에서 실행한 서비스는 학번 도메인으로 접속할 수 없습니다.
:::

## 1. 작업 폴더 만들기

VM에 SSH로 접속한 뒤 다음 명령을 실행합니다.

```bash
mkdir -p ~/my-service
cd ~/my-service
```

## 2. 첫 웹페이지 만들기

다음 명령을 그대로 실행하면 `index.html` 파일이 생성됩니다.

```bash
cat > index.html <<'EOF'
<!doctype html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>나의 첫 VM 서비스</title>
  </head>
  <body>
    <h1>클라우드 VM 연결 성공!</h1>
    <p>이 페이지는 Ubuntu VM의 Python 서버에서 제공하고 있습니다.</p>
  </body>
</html>
EOF
```

파일이 만들어졌는지 확인합니다.

```bash
ls -l
```

목록에 `index.html`이 표시되면 정상입니다.

## 3. 먼저 화면에서 실행해보기

Python의 기본 웹서버를 `8080` 포트로 실행합니다.

```bash
python3 -m http.server 8080 --bind 0.0.0.0
```

다음과 비슷한 메시지가 표시되면 서버가 실행 중입니다.

```text
Serving HTTP on 0.0.0.0 port 8080 ...
```

이 상태에서는 터미널이 서버 실행에 사용됩니다. 학생 PC의 브라우저에서 다음 주소를 열어 작성한 메시지가 보이는지 확인하세요.

```text
http://학번.dauswc.org
```

확인을 마쳤다면 터미널에서 `Ctrl+C`를 눌러 서버를 종료합니다.

## 4. 백그라운드에서 실행하기

SSH 연결을 종료해도 서버가 계속 실행되도록 `nohup`을 사용합니다.

```bash
cd ~/my-service
nohup python3 -m http.server 8080 --bind 0.0.0.0 > server.log 2>&1 &
echo $! > server.pid
```

각 명령의 역할은 다음과 같습니다.

| 항목 | 역할 |
| --- | --- |
| `nohup` | SSH 연결이 끊어져도 프로세스를 계속 실행 |
| `> server.log 2>&1` | 실행 메시지와 오류를 `server.log`에 저장 |
| `&` | 프로세스를 백그라운드에서 실행 |
| `echo $! > server.pid` | 종료할 때 사용할 프로세스 번호를 저장 |

## 5. 실행 상태 확인하기

VM 내부에서 응답하는지 확인합니다.

```bash
curl http://localhost:8080
```

앞에서 작성한 HTML 내용이 출력되면 정상입니다.

프로세스 상태는 다음 명령으로 확인할 수 있습니다.

```bash
ps -p "$(cat server.pid)" -f
```

최근 접속 기록이나 오류는 로그에서 확인합니다.

```bash
tail -n 20 server.log
```

마지막으로 학생 PC의 브라우저에서 자신의 주소를 확인합니다.

```text
http://학번.dauswc.org
```

::: tip 예시
학번이 `20260000`이라면 `http://20260000.dauswc.org`로 접속합니다.
:::

## 6. 서버 종료하기

확인을 마쳤거나 다른 서비스를 배포하려면 예제 서버를 종료합니다.

```bash
cd ~/my-service
kill "$(cat server.pid)"
rm server.pid
```

정상적으로 종료되었는지 확인합니다.

```bash
curl http://localhost:8080
```

연결할 수 없다는 메시지가 나오면 서버가 종료된 것입니다.

::: warning
새로운 서비스를 `8080` 포트에서 실행하기 전 기존 예제 서버를 반드시 종료하세요. 하나의 포트에는 동시에 하나의 서비스만 실행할 수 있습니다.
:::

## 문제가 생겼을 때

### `Address already in use`가 표시됩니다

이미 `8080` 포트를 사용하는 프로세스가 있다는 뜻입니다. 앞에서 실행한 서버가 남아 있다면 다음 명령으로 종료하세요.

```bash
kill "$(cat ~/my-service/server.pid)"
rm ~/my-service/server.pid
```

### VM에서는 보이지만 학번 도메인에서는 보이지 않습니다

다음을 확인하세요.

- 서버를 `8080` 포트로 실행했는지
- `--bind 0.0.0.0` 옵션을 사용했는지
- `curl http://localhost:8080`이 정상 응답하는지
- 주소에 자신의 학번을 정확히 입력했는지

위 항목이 모두 정상이라면 [문제 해결 및 FAQ](/troubleshooting)를 확인한 뒤 DevWorks 운영진에게 문의하세요.

::: danger HTTP 서비스 주의
현재 학생 도메인은 HTTP로 제공됩니다. 로그인 정보, 개인정보, 비밀번호, 비밀키 등 민감한 데이터를 이 예제 서비스에서 처리하지 마세요.
:::
