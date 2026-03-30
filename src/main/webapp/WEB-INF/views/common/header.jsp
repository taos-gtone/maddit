<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  String loginUser     = (String) session.getAttribute("loginUser");
  String loginNickname = (String) session.getAttribute("loginNickname");
  boolean loggedIn     = (loginUser != null);
%>
<div id="pg-bar"></div>

<!-- ===== HEADER — BLACK BAR ===== -->
<header class="main-header">
  <div class="hdr-inner">

    <div class="hdr-left">
      <button class="hamburger" id="menuBtn" aria-label="메뉴">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><line x1="3" y1="7" x2="21" y2="7"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="17" x2="21" y2="17"/></svg>
      </button>
      <a href="${pageContext.request.contextPath}/" class="logo">
        <img src="${pageContext.request.contextPath}/images/maddit_logo3.png" alt="MADDIT" class="logo-img" />
      </a>
    </div>

    <div class="hdr-center">
      <form class="search-form" action="${pageContext.request.contextPath}/program/search" method="get">
        <input type="text" name="q" placeholder="프로그램 검색 ..." autocomplete="off" />
        <button type="submit" aria-label="검색">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="10" cy="10" r="8"/><line x1="16" y1="16" x2="22" y2="22"/></svg>
        </button>
      </form>
    </div>

    <div class="hdr-right">
      <% if (loggedIn) { %>
      <a href="${pageContext.request.contextPath}/member/mypage" class="signup-btn">
        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
        <span><%= loginNickname != null ? loginNickname : "MY" %></span>
      </a>
      <a href="${pageContext.request.contextPath}/member/logout" class="logout-btn">
        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
        로그아웃
      </a>
      <% } else { %>
      <a href="${pageContext.request.contextPath}/member/login" class="login-btn">
        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"/><polyline points="10 17 15 12 10 7"/><line x1="15" y1="12" x2="3" y2="12"/></svg>
        로그인
      </a>
      <a href="${pageContext.request.contextPath}/member/register" class="signup-btn">
        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><line x1="19" y1="8" x2="19" y2="14"/><line x1="22" y1="11" x2="16" y2="11"/></svg>
        <span>회원가입</span>
      </a>
      <% } %>
    </div>

  </div>
</header>

<!-- ===== SIDEBAR — WHITE, SHARP ===== -->
<aside class="sidebar" id="sidebar">
  <nav class="sidebar-nav">

    <div class="snav-section">
      <a href="${pageContext.request.contextPath}/" class="snav-item active">
        <span class="snav-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
        </span>
        <span class="snav-label">홈</span>
      </a>

      <div class="snav-tree-parent snav-item" id="treeProgram" onclick="toggleTree(this)">
        <span class="snav-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/></svg>
        </span>
        <span class="snav-label">프로그램</span>
        <span class="tree-toggle-icon" id="treeProgramIcon">−</span>
      </div>
      <div class="snav-tree-children open" id="treeProgramChildren">
        <c:forEach var="cat" items="${progCategories}">
          <a href="${pageContext.request.contextPath}/program/list?boardCatGbnCd=${cat.codeId}" class="snav-item snav-child">
            <span class="snav-icon">
              <c:choose>
                <c:when test="${cat.codeId == '10'}"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="3" width="20" height="14" rx="2"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/></svg></c:when>
                <c:when test="${cat.codeId == '20'}"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"/></svg></c:when>
                <c:when test="${cat.codeId == '30'}"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/></svg></c:when>
                <c:when test="${cat.codeId == '40'}"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="16 18 22 12 16 6"/><polyline points="8 6 2 12 8 18"/></svg></c:when>
                <c:when test="${cat.codeId == '50'}"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg></c:when>
                <c:when test="${cat.codeId == '60'}"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 1 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 1 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 1 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/></svg></c:when>
                <c:when test="${cat.codeId == '99'}"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="1"/><circle cx="19" cy="12" r="1"/><circle cx="5" cy="12" r="1"/></svg></c:when>
                <c:otherwise><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"/></svg></c:otherwise>
              </c:choose>
            </span>
            <span class="snav-label">${cat.codeNm}</span>
          </a>
        </c:forEach>
      </div>
    </div>

    <div class="snav-divider"></div>

    <div class="snav-section">
      <div class="snav-section-title">커뮤니티</div>
      <a href="${pageContext.request.contextPath}/board/request" class="snav-item">
        <span class="snav-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
        </span>
        <span class="snav-label">만들어 주세요</span>
      </a>
      <a href="${pageContext.request.contextPath}/board/free" class="snav-item">
        <span class="snav-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
        </span>
        <span class="snav-label">자유게시판</span>
      </a>
      <a href="${pageContext.request.contextPath}/program/list" class="snav-item">
        <span class="snav-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
        </span>
        <span class="snav-label">프로그램 게시판</span>
      </a>
      <a href="${pageContext.request.contextPath}/board/notice" class="snav-item">
        <span class="snav-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>
        </span>
        <span class="snav-label">공지사항</span>
      </a>
    </div>

  </nav>
</aside>

<div class="mobile-overlay" id="overlay"></div>

<nav class="mobile-bottom-nav">
  <a href="${pageContext.request.contextPath}/" class="mbn-item active">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
    <span>HOME</span>
  </a>
  <a href="${pageContext.request.contextPath}/program/list" class="mbn-item">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
    <span>APP</span>
  </a>
  <a href="${pageContext.request.contextPath}/board/request" class="mbn-item">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
    <span>REQ</span>
  </a>
  <a href="${pageContext.request.contextPath}/board/free" class="mbn-item">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
    <span>TALK</span>
  </a>
  <a href="${pageContext.request.contextPath}/member/<%= loggedIn ? "mypage" : "login" %>" class="mbn-item">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
    <span><%= loggedIn ? "MY" : "LOGIN" %></span>
  </a>
</nav>
