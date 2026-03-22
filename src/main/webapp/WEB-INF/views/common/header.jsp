<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String loginUser     = (String) session.getAttribute("loginUser");
  String loginNickname = (String) session.getAttribute("loginNickname");
  boolean loggedIn     = (loginUser != null);
%>
<!-- 페이지 로딩 바 -->
<div id="pg-bar"></div>

<!-- ===== HEADER ===== -->
<header class="main-header">
  <div class="hdr-inner">

    <!-- 좌측: 햄버거 + 로고 -->
    <div class="hdr-left">
      <button class="hamburger" id="menuBtn" aria-label="메뉴">☰</button>
      <a href="${pageContext.request.contextPath}/" class="logo">
        <img src="${pageContext.request.contextPath}/images/maddit_logo.png" alt="maddit" class="logo-img" />
      </a>
    </div>

    <!-- 가운데: 검색창 -->
    <div class="hdr-center">
      <form class="search-form" action="${pageContext.request.contextPath}/program/search" method="get">
        <input type="text" name="q" placeholder="프로그램 검색" autocomplete="off" />
        <button type="submit" aria-label="검색">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#111" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="10" cy="10" r="8"/><line x1="16" y1="16" x2="22" y2="22"/></svg>
        </button>
      </form>
    </div>

    <!-- 우측: 버튼 -->
    <div class="hdr-right">
      <% if (loggedIn) { %>
      <a href="${pageContext.request.contextPath}/member/mypage" class="signup-btn">
        👤 <span><%= loginNickname != null ? loginNickname : "내정보" %></span>
      </a>
      <% } else { %>
      <a href="${pageContext.request.contextPath}/member/login"    class="login-btn">
        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
        로그인
      </a>
      <a href="${pageContext.request.contextPath}/member/register" class="signup-btn">
        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><line x1="19" y1="8" x2="19" y2="14"/><line x1="22" y1="11" x2="16" y2="11"/></svg>
        회원가입
      </a>
      <% } %>
    </div>

  </div>
</header>

<!-- ===== LEFT SIDEBAR ===== -->
<aside class="sidebar" id="sidebar">
  <nav class="sidebar-nav">

    <div class="snav-section">
      <a href="${pageContext.request.contextPath}/"              class="snav-item active">
        <span class="snav-icon">
          <svg viewBox="0 0 24 24" fill="currentColor"><path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/></svg>
        </span>
        <span class="snav-label">홈</span>
      </a>

      <!-- 프로그램 트리 메뉴 -->
      <div class="snav-tree-parent snav-item" id="treeProgram" onclick="toggleTree(this)">
        <span class="snav-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/></svg>
        </span>
        <span class="snav-label">프로그램</span>
        <span class="tree-toggle-icon" id="treeProgramIcon">−</span>
      </div>
      <div class="snav-tree-children open" id="treeProgramChildren">
        <a href="${pageContext.request.contextPath}/program/list?cat=생산성"  class="snav-item snav-child">
          <span class="snav-icon">⚡</span><span class="snav-label">생산성</span>
        </a>
        <a href="${pageContext.request.contextPath}/program/list?cat=유틸리티" class="snav-item snav-child">
          <span class="snav-icon">🛠️</span><span class="snav-label">유틸리티</span>
        </a>
        <a href="${pageContext.request.contextPath}/program/list?cat=보안"    class="snav-item snav-child">
          <span class="snav-icon">🔐</span><span class="snav-label">보안</span>
        </a>
        <a href="${pageContext.request.contextPath}/program/list?cat=이미지"  class="snav-item snav-child">
          <span class="snav-icon">🖼️</span><span class="snav-label">이미지 편집</span>
        </a>
        <a href="${pageContext.request.contextPath}/program/list?cat=개발도구" class="snav-item snav-child">
          <span class="snav-icon">💻</span><span class="snav-label">개발도구</span>
        </a>
        <a href="${pageContext.request.contextPath}/program/list?cat=파일관리" class="snav-item snav-child">
          <span class="snav-icon">🗂️</span><span class="snav-label">파일관리</span>
        </a>
      </div>
    </div>

    <div class="snav-divider"></div>

    <div class="snav-section">
      <div class="snav-section-title">게시판</div>
      <a href="${pageContext.request.contextPath}/board/request" class="snav-item">
        <span class="snav-icon">✏️</span>
        <span class="snav-label">만들어주세요</span>
      </a>
      <a href="${pageContext.request.contextPath}/board/free"    class="snav-item">
        <span class="snav-icon">💬</span>
        <span class="snav-label">자유게시판</span>
      </a>
      <a href="${pageContext.request.contextPath}/notice/list"   class="snav-item">
        <span class="snav-icon">📢</span>
        <span class="snav-label">공지사항</span>
      </a>
    </div>

  </nav>
</aside>

<!-- ===== MOBILE OVERLAY ===== -->
<div class="mobile-overlay" id="overlay"></div>

<!-- ===== MOBILE BOTTOM NAV ===== -->
<nav class="mobile-bottom-nav">
  <a href="${pageContext.request.contextPath}/"              class="mbn-item active">
    <svg viewBox="0 0 24 24" fill="currentColor"><path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/></svg>
    <span>홈</span>
  </a>
  <a href="${pageContext.request.contextPath}/program/list"  class="mbn-item">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/></svg>
    <span>프로그램</span>
  </a>
  <a href="${pageContext.request.contextPath}/board/request" class="mbn-item">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
    <span>요청</span>
  </a>
  <a href="${pageContext.request.contextPath}/board/free"    class="mbn-item">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
    <span>게시판</span>
  </a>
  <a href="${pageContext.request.contextPath}/member/<%= loggedIn ? "mypage" : "login" %>" class="mbn-item">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
    <span><%= loggedIn ? "내정보" : "로그인" %></span>
  </a>
</nav>
