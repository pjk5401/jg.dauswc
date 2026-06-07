# 전체 이용 절차

이 문서는 처음 클라우드 서비스를 신청하는 학생을 위한 전체 흐름입니다. 신청부터 사용 종료 후 결과 보고까지 순서대로 진행하세요. 아래 (3), (4), (5)는 사용자 및 운영진의 수작업이 필요한 구간으로 시간(1~2일)이 소요될 수 있습니다.

## 준비물

- 클라우드 서비스 `Tailscale`에 연동할 본인 이메일 계정(`Gmail 권장`)
- `Tailscale`을 설치할 개인 PC
- 운영진의 안내 메일을 받을 수 있는 환경
- 원격 서버에 접속할 수 있는 `SSH` 사용 환경

## 진행 순서

<div class="sequence-flow">
  <div class="sequence-actors" aria-hidden="true">
    <strong>학생</strong>
    <strong>운영진</strong>
  </div>

  <div class="sequence-step self-student">
    <span class="sequence-number">1</span>
    <div class="sequence-message">
      <strong>신청 준비</strong>
      <span><a href="/before-you-apply">기본 사양과 이용 조건</a>을 확인하고 <a href="/application">클라우드 사용 신청서</a>를 작성합니다.</span>
    </div>
  </div>

  <div class="sequence-step from-student">
    <span class="sequence-number">2</span>
    <div class="sequence-message">
      <strong>신청서 제출</strong>
      <span>작성한 신청서를 <a href="/submit-by-email">운영진 이메일</a>로 보냅니다.</span>
    </div>
  </div>

  <div class="sequence-step from-operator">
    <span class="sequence-number">3</span>
    <div class="sequence-message">
      <strong>신청 확인 및 초대</strong>
      <span>운영진이 신청 내용을 확인하고 Tailscale 초대 링크를 발송합니다.</span>
    </div>
  </div>

  <div class="sequence-step from-student">
    <span class="sequence-number">4</span>
    <div class="sequence-message">
      <strong>Tailscale 연결 완료</strong>
      <span><a href="/tailscale/install">Tailscale을 설치</a>하고 <a href="/tailscale/invitation">초대 링크를 수락</a>한 뒤 <a href="/tailscale/check-connection">연결 상태</a>를 확인합니다.</span>
    </div>
  </div>

  <div class="sequence-step from-operator">
    <span class="sequence-number">5</span>
    <div class="sequence-message">
      <strong>VM 생성 완료 안내</strong>
      <span>운영진이 VM을 생성하고 접속에 필요한 정보를 이메일로 안내합니다.</span>
    </div>
  </div>

  <div class="sequence-step self-student">
    <span class="sequence-number">6</span>
    <div class="sequence-message">
      <strong>서비스 이용</strong>
      <span><a href="/vm/connect">클라우드에 접속</a>해 <a href="/vm/deploy">서비스를 배포</a>하고 <a href="/vm/domain"><code>학번.dauswc.org</code>에서 확인</a>합니다.</span>
    </div>
  </div>

  <div class="sequence-step from-student">
    <span class="sequence-number">7</span>
    <div class="sequence-message">
      <strong>결과 보고서 제출</strong>
      <span>사용 종료 후 <a href="/usage-report">결과 보고서</a>를 작성해 제출합니다.</span>
    </div>
  </div>
</div>

## 담당자 구분

| 문의 내용 | 담당자 |
| --- | --- |
| 신청, Tailscale, VM 및 서비스 운영 | DevWorks 운영진 `2344025@donga.ac.kr` |
| DevWorks 운영진의 응답 지연 또는 해결되지 않은 문제 | 교수 박종규 `pjk5401@dau.ac.kr` |
| 사용 결과 보고서 제출 | 교수 박종규 `pjk5401@dau.ac.kr` |

::: tip
문의할 때 학번, 이름, 어느 단계에서 문제가 발생했는지를 함께 적으면 확인이 빨라집니다. 단, 비밀번호와 받으신 초대 링크 등은 문의 이메일에도 적지 마세요.
:::
