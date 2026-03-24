<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String admCtx = "/maddit";
  String admUser = (String) session.getAttribute("adminUser");
%>

<!-- 헤더 -->
<header class="adm-header">
  <div class="adm-header-logo">🛡️ Maddit <span>ADMIN</span></div>
  <div class="adm-header-right">
    <span class="adm-header-user"><%= admUser != null ? admUser : "" %></span>
    <a href="<%= admCtx %>/admin/logout" class="adm-btn-logout" onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a>
  </div>
</header>

<!-- 사이드바 -->
<aside class="adm-sidebar">
  <div class="adm-nav-title">메인</div>
  <a href="<%= admCtx %>/admin/dashboard" class="adm-nav-item">
    <span class="adm-nav-icon">📊</span> 대시보드
  </a>

  <div class="adm-nav-divider"></div>

  <div class="adm-nav-title">게시판 관리</div>
  <a href="<%= admCtx %>/admin/board/list" class="adm-nav-item">
    <span class="adm-nav-icon">📋</span> 전체 게시글
  </a>
  <a href="<%= admCtx %>/admin/board/list?boardGbnCd=03" class="adm-nav-item">
    <span class="adm-nav-icon">✏️</span> 만들어 주세요
  </a>
  <a href="<%= admCtx %>/admin/board/list?boardGbnCd=01" class="adm-nav-item">
    <span class="adm-nav-icon">💬</span> 자유게시판
  </a>

  <div class="adm-nav-divider"></div>

  <div class="adm-nav-title">회원 관리</div>
  <a href="<%= admCtx %>/admin/member/list" class="adm-nav-item">
    <span class="adm-nav-icon">👥</span> 회원 목록
  </a>

  <div class="adm-nav-divider"></div>

  <div class="adm-nav-title">바로가기</div>
  <a href="/" class="adm-nav-item" target="_blank">
    <span class="adm-nav-icon">🌐</span> 사이트 열기
  </a>
</aside>
