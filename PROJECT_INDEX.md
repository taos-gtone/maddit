# Maddit 프로젝트 인덱스

## 프로젝트 정보
- **프레임워크**: Spring MVC 6 (JSP 기반)
- **빌드**: Maven (pom.xml)
- **DB**: MySQL (JNDI: jdbc/MadditDB) + MyBatis
- **패키지**: com.maddit
- **컨텍스트**: 소프트웨어 쇼케이스 커뮤니티

## 디렉토리 구조

### Java 소스 (src/main/java/com/maddit/)
| 파일 | 설명 |
|------|------|
| controller/HomeController.java | 메인 페이지 컨트롤러 |
| controller/MemberController.java | 회원 컨트롤러 (가입, 로그인, 로그아웃, 중복확인) |
| service/MemberService.java | 회원 서비스 인터페이스 |
| service/MemberServiceImpl.java | 회원 서비스 구현 (BCrypt, 로그인, 이력저장) |
| service/LoginFailException.java | 로그인 실패 예외 (실패사유코드 포함) |
| mapper/MemberMapper.java | 회원 MyBatis Mapper 인터페이스 |
| vo/ProgramVO.java | 프로그램 VO |
| vo/MemberVO.java | 회원 VO (MEM_JOIN_INFO 매핑) |
| vo/LoginHistVO.java | 로그인 이력 VO (MEM_LOGIN_HIST 매핑) |

### 설정 (src/main/resources/)
| 파일 | 설명 |
|------|------|
| logback.xml | 로깅 설정 |
| mybatis-config.xml | MyBatis 설정 (camelCase 매핑) |
| mapper/MemberMapper.xml | 회원 SQL (가입, 로그인, 이력, 중복/금지어 체크) |

### Spring 설정 (WEB-INF/spring/)
| 파일 | 설명 |
|------|------|
| dispatcher-servlet.xml | MVC 설정, 컴포넌트 스캔(com.maddit.controller) |
| root-context.xml | JNDI DataSource, MyBatis, 트랜잭션, 서비스 스캔 |

### JSP 뷰 (WEB-INF/views/)
| 파일 | 설명 |
|------|------|
| index.jsp | 메인 페이지 |
| common/head.jsp | HTML head (CSS 로딩) |
| common/header.jsp | 헤더 + 사이드바 + 모바일 네비 |
| common/footer.jsp | 푸터 |
| common/scripts.jsp | 공통 JS |
| home/popular.jsp | 인기 프로그램 그리드 |
| home/latest.jsp | 최신 프로그램 그리드 |
| home/boards.jsp | 게시판 섹션 |
| member/register.jsp | 회원가입 (이메일/닉네임 중복확인, 비밀번호 강도) |
| member/login.jsp | 로그인 (이메일/비밀번호, 에러표시, 비번보기토글) |
| error/404.jsp | 404 에러 |
| error/500.jsp | 500 에러 |

### CSS (webapp/css/)
| 파일 | 설명 |
|------|------|
| base.css | 전역 변수, 리셋, 공통 스타일 |
| layout/header.css | 헤더, 사이드바, 칩바, 모바일 네비 |
| layout/footer.css | 푸터 |
| home/programs.css | 프로그램 카드 그리드 |
| home/boards.css | 게시판 섹션 |
| member/register.css | 회원가입 (중복확인 버튼 포함) |
| member/login.css | 로그인 (비밀번호 토글, 에러 메시지) |
| responsive.css | 반응형 미디어 쿼리 |

### 정적 자원
| 파일 | 설명 |
|------|------|
| images/maddit_logo.png | 로고 이미지 |

## DB 테이블
| 테이블 | 설명 |
|--------|------|
| MEM_JOIN_INFO | 회원정보 (member_no, email, user_pw, nickname, last_login_at 등) |
| MEM_BANNED_NICKNAME | 닉네임 금지어 (banned_word, match_type_cd: E=정확일치, C=포함) |
| MEM_LOGIN_HIST | 로그인이력 (member_no, email, login_rslt_cd, fail_rsn_cd, login_ip 등) |

## API 엔드포인트
| Method | URL | 설명 |
|--------|-----|------|
| GET | /member/register | 회원가입 폼 |
| POST | /member/register | 회원가입 처리 (JSON) |
| GET | /member/check-email?email= | 이메일 중복확인 (JSON) |
| GET | /member/check-nickname?nickname= | 닉네임 금지어+중복확인 (JSON) |
| GET | /member/login | 로그인 폼 |
| POST | /member/login | 로그인 처리 (JSON) |
| GET | /member/logout | 로그아웃 → 메인 리다이렉트 |

## 디자인 시스템 (CSS 변수 - base.css)
| 변수 | 값 | 용도 |
|------|-----|------|
| --accent | #e94560 | 포인트 색상 (레드) |
| --blue | #065fd4 | 파란색 (버튼/링크) |
| --text-1 | #0f0f0f | 주요 텍스트 |
| --text-2 | #606060 | 보조 텍스트 |
| --text-3 | #909090 | 비활성 텍스트 |
| --bg | #f9f9f9 | 배경색 |
| --surface | #ffffff | 카드/헤더 배경 |
| --border | #e5e5e5 | 테두리 |
| --radius | 12px | 둥근 모서리 |
| --header-h | 56px | 헤더 높이 |
| --sidebar-w | 240px | 사이드바 너비 |
