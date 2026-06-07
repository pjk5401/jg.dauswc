import { defineConfig } from 'vitepress'

export default defineConfig({
  lang: 'ko-KR',
  title: 'DAU Cloud Hub',
  description: 'VM 신청부터 Tailscale 연결, 서비스 배포까지의 학생용 안내서',
  cleanUrls: true,
  srcExclude: ['public/**'],
  ignoreDeadLinks: [/^\/forms\/.*\.hwp$/],
  lastUpdated: true,
  head: [
    ['meta', { name: 'theme-color', content: '#155eef' }],
    ['meta', { name: 'robots', content: 'index,follow' }]
  ],
  themeConfig: {
    logo: '/logo.svg',
    siteTitle: 'DAU Cloud Hub',
    nav: [
      { text: '처음 이용하기', link: '/getting-started' },
      { text: '신청 양식', link: '/application' },
      { text: '문제 해결', link: '/troubleshooting' }
    ],
    sidebar: [
      {
        text: '시작하기',
        items: [
          { text: '전체 이용 절차', link: '/getting-started' },
          { text: '신청 전 확인', link: '/before-you-apply' }
        ]
      },
      {
        text: 'VM 신청',
        items: [
          { text: '신청서 작성', link: '/application' },
          { text: '이메일 제출', link: '/submit-by-email' }
        ]
      },
      {
        text: 'Tailscale 연결',
        items: [
          { text: '설치 및 로그인', link: '/tailscale/install' },
          { text: '초대 링크 수락', link: '/tailscale/invitation' },
          { text: '연결 상태 확인', link: '/tailscale/check-connection' }
        ]
      },
      {
        text: 'VM 이용',
        items: [
          { text: 'VM 접속', link: '/vm/connect' },
          { text: '서비스 배포', link: '/vm/deploy' },
          { text: '도메인 확인', link: '/vm/domain' }
        ]
      },
      {
        text: '사용 종료',
        items: [
          { text: '결과 보고서 제출', link: '/usage-report' }
        ]
      },
      {
        text: '도움말',
        items: [
          { text: '문제 해결 및 FAQ', link: '/troubleshooting' },
        ]
      }
    ],
    outline: {
      level: [2, 3],
      label: '이 페이지의 내용'
    },
    docFooter: {
      prev: '이전 안내',
      next: '다음 안내'
    },
    lastUpdated: {
      text: '마지막 수정'
    },
    returnToTopLabel: '맨 위로',
    sidebarMenuLabel: '메뉴',
    darkModeSwitchLabel: '화면 모드',
    lightModeSwitchTitle: '밝은 화면으로 전환',
    darkModeSwitchTitle: '어두운 화면으로 전환',
    notFound: {
      title: '페이지를 찾을 수 없습니다',
      quote: '주소가 바뀌었거나 아직 작성되지 않은 안내입니다.',
      linkLabel: '첫 화면으로 이동',
      linkText: '첫 화면으로 이동'
    },
    socialLinks: []
  },
  markdown: {
    lineNumbers: true
  }
})
