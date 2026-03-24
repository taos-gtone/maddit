# Maddit 프로젝트 소스 인덱스

## 프로젝트 구조
Spring MVC (JSP) 기반 웹 애플리케이션. YouTube 스타일 레이아웃(헤더+사이드바+메인).

## Views (JSP)

| 파일 | 역할 |
|------|------|
| `src/main/webapp/WEB-INF/views/index.jsp` | 메인 페이지 (레이아웃 조합) |
| `src/main/webapp/WEB-INF/views/common/head.jsp` | HTML head (CSS/meta) |
| `src/main/webapp/WEB-INF/views/common/header.jsp` | 헤더 + 사이드바 + 모바일 네비 |
| `src/main/webapp/WEB-INF/views/common/footer.jsp` | 푸터 |
| `src/main/webapp/WEB-INF/views/common/scripts.jsp` | JS 스크립트 |
| `src/main/webapp/WEB-INF/views/home/popular.jsp` | 인기순 프로그램 그리드 |
| `src/main/webapp/WEB-INF/views/home/latest.jsp` | 최신순 프로그램 그리드 |
| `src/main/webapp/WEB-INF/views/home/boards.jsp` | 게시판 섹션 (만들어주세요 + 자유게시판) |
| `src/main/webapp/WEB-INF/views/board/requestList.jsp` | 만들어주세요 글목록 페이지 |
| `src/main/webapp/WEB-INF/views/board/requestWrite.jsp` | 만들어주세요 글쓰기 페이지 |
| `src/main/webapp/WEB-INF/views/board/requestView.jsp` | 만들어주세요 글 조회 페이지 |
| `src/main/webapp/WEB-INF/views/board/requestEdit.jsp` | 만들어주세요 글 수정 페이지 |
| `src/main/webapp/WEB-INF/views/board/freeList.jsp` | 자유게시판 글 목록 페이지 |
| `src/main/webapp/WEB-INF/views/board/freeWrite.jsp` | 자유게시판 글쓰기 페이지 |
| `src/main/webapp/WEB-INF/views/board/freeView.jsp` | 자유게시판 글 조회 페이지 |
| `src/main/webapp/WEB-INF/views/board/freeEdit.jsp` | 자유게시판 글 수정 페이지 |
| `src/main/webapp/WEB-INF/views/member/login.jsp` | 로그인 페이지 |
| `src/main/webapp/WEB-INF/views/member/register.jsp` | 회원가입 페이지 |
| `src/main/webapp/WEB-INF/views/error/404.jsp` | 404 에러 |
| `src/main/webapp/WEB-INF/views/error/500.jsp` | 500 에러 |

## CSS

| 파일 | 역할 |
|------|------|
| `src/main/webapp/css/base.css` | 전역 변수, 리셋, 공통 유틸리티 |
| `src/main/webapp/css/layout/header.css` | 헤더, 사이드바, 칩바, 모바일 네비 |
| `src/main/webapp/css/layout/footer.css` | 푸터 |
| `src/main/webapp/css/home/programs.css` | 프로그램 그리드/카드 |
| `src/main/webapp/css/home/boards.css` | 게시판 패널 |
| `src/main/webapp/css/board/request.css` | 만들어주세요 게시판 스타일 |
| `src/main/webapp/css/board/free.css` | 자유게시판 스타일 |
| `src/main/webapp/css/member/login.css` | 로그인 폼 |
| `src/main/webapp/css/member/register.css` | 회원가입 폼 |
| `src/main/webapp/css/responsive.css` | 반응형 미디어 쿼리 |
| `src/main/webapp/css/admin/admin.css` | 관리자 다크 테마 CSS |

## Admin Views (JSP)

| 파일 | 역할 |
|------|------|
| `src/main/webapp/WEB-INF/views/admin/login.jsp` | 관리자 로그인 |
| `src/main/webapp/WEB-INF/views/admin/dashboard.jsp` | 대시보드 (통계) |
| `src/main/webapp/WEB-INF/views/admin/boardList.jsp` | 게시판 관리 |
| `src/main/webapp/WEB-INF/views/admin/memberList.jsp` | 회원 관리 |
| `src/main/webapp/WEB-INF/views/admin/layout/head.jsp` | 관리자 head |
| `src/main/webapp/WEB-INF/views/admin/layout/header.jsp` | 관리자 헤더+사이드바 |

## Java (Controller / Service / VO / Mapper)

| 파일 | 역할 |
|------|------|
| `src/main/java/com/maddit/admin/controller/AdminController.java` | 관리자 컨트롤러 |
| `src/main/java/com/maddit/admin/service/AdminService.java` | 관리자 서비스 인터페이스 |
| `src/main/java/com/maddit/admin/service/AdminServiceImpl.java` | 관리자 서비스 구현체 |
| `src/main/java/com/maddit/admin/interceptor/AdminAuthInterceptor.java` | 관리자 인증 인터셉터 |
| `src/main/java/com/maddit/controller/HomeController.java` | 메인 페이지 컨트롤러 |
| `src/main/java/com/maddit/controller/MemberController.java` | 회원 컨트롤러 (로그인/가입) |
| `src/main/java/com/maddit/controller/BoardController.java` | 만들어주세요 컨트롤러 (/board/request, gbn=03) |
| `src/main/java/com/maddit/controller/FreeBoardController.java` | 자유게시판 컨트롤러 (/board/free, gbn=01) |
| `src/main/java/com/maddit/service/MemberService.java` | 회원 서비스 인터페이스 |
| `src/main/java/com/maddit/service/MemberServiceImpl.java` | 회원 서비스 구현체 |
| `src/main/java/com/maddit/service/BoardService.java` | 게시판 서비스 인터페이스 |
| `src/main/java/com/maddit/service/BoardServiceImpl.java` | 게시판 서비스 구현체 |
| `src/main/java/com/maddit/service/LoginFailException.java` | 로그인 실패 예외 |
| `src/main/java/com/maddit/mapper/MemberMapper.java` | 회원 MyBatis 매퍼 |
| `src/main/java/com/maddit/mapper/BoardMapper.java` | 게시판 MyBatis 매퍼 |
| `src/main/java/com/maddit/vo/MemberVO.java` | 회원 VO |
| `src/main/java/com/maddit/vo/ProgramVO.java` | 프로그램 VO |
| `src/main/java/com/maddit/vo/BoardPostVO.java` | 게시글 VO (상대시간 getTimeAgo 포함) |
| `src/main/java/com/maddit/vo/BoardCommentVO.java` | 댓글 VO |
| `src/main/java/com/maddit/vo/AdminLoginInfoVO.java` | 관리자 계정 VO |
| `src/main/java/com/maddit/vo/AdminLoginHistVO.java` | 관리자 로그인 이력 VO |
| `src/main/java/com/maddit/vo/LoginHistVO.java` | 로그인 이력 VO |

## Config

| 파일 | 역할 |
|------|------|
| `src/main/webapp/WEB-INF/web.xml` | 서블릿 설정 |
| `src/main/webapp/WEB-INF/spring/dispatcher-servlet.xml` | Spring MVC 설정 |
| `src/main/webapp/WEB-INF/spring/root-context.xml` | 루트 컨텍스트 |
| `src/main/resources/mybatis-config.xml` | MyBatis 설정 |
| `src/main/resources/mapper/MemberMapper.xml` | 회원 SQL 매퍼 |
| `src/main/resources/mapper/BoardMapper.xml` | 게시판 SQL 매퍼 |
| `src/main/java/com/maddit/mapper/AdminMapper.java` | 관리자 MyBatis 매퍼 |
| `src/main/resources/mapper/AdminMapper.xml` | 관리자 SQL 매퍼 |
| `src/main/resources/logback.xml` | 로깅 설정 |

## DB 테이블 (게시판)

| 테이블 | 역할 | 비고 |
|--------|------|------|
| `BRD_POST_MST` | 게시글 원글 | board_gbn_cd: '01'=자유게시판, '03'=만들어주세요 |
| `BRD_POST_COMMENT` | 댓글/대댓글 | depth: 0=댓글, 1=대댓글 |
| `BRD_POST_REACTION` | 좋아요/싫어요 | post_typ_cd: '1'=게시글, '2'=댓글 |

## 디자인 시스템 요약

- **Accent color**: `#e94560` (레드)
- **Blue**: `#065fd4`
- **Border radius**: `12px` (패널), `20px` (pill 버튼), `8px` (input/chip)
- **버튼 스타일**: outline pill (헤더/정렬), ghost (칩), outlined accent (글쓰기)
- **레이아웃**: 고정 헤더(56px) + 좌측 사이드바(240px) + 메인 콘텐츠
- **시간 표시**: 상대시간 (몇초 전, 몇분 전, ...) - BoardPostVO.getTimeAgo()
