# Tailscale 연결 상태 확인

VM에 접속하기 전에 학생 PC의 Tailscale 연결 상태를 확인합니다.

## 기본 확인

1. 작업 표시줄의 Tailscale 아이콘을 우클릭합니다.
![Windows 작업 표시줄의 Tailscale 아이콘](/img/image.png)
2. 상태가 `Connected`인지 확인합니다.
![Tailscale connected](/img/connected.png)

## 명령어 확인

터미널에서 다음 명령으로도 상태를 확인할 수 있습니다.

```bash
tailscale status
```

::: info
명령어를 찾을 수 없다는 메시지가 나오더라도 Tailscale 프로그램에서 연결 상태를 확인할 수 있습니다.
:::

## 연결되지 않을 때

- Tailscale을 종료한 뒤 다시 실행합니다.
- 올바른 계정으로 로그인했는지 확인합니다.
- 초대 링크 수락이 완료되었는지 확인합니다.
- 학교 또는 공용 네트워크에서 차단되는지 다른 네트워크로 확인합니다.
- 해결되지 않으면 [문제 해결 및 FAQ](/troubleshooting)를 확인한 뒤 DevWorks 운영진에게 문의합니다.
