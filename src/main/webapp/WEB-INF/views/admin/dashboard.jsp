<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/admin/layout/head.jsp" %>
<body class="admin-body">
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<%
  Integer totalMembers    = (Integer) request.getAttribute("totalMembers");
  Integer todayPosts      = (Integer) request.getAttribute("todayPosts");
  Integer totalPosts      = (Integer) request.getAttribute("totalPosts");
  Integer unapprovedPosts = (Integer) request.getAttribute("unapprovedPosts");
%>

<div class="adm-content">
  <h1 class="adm-page-title">📊 대시보드</h1>

  <div class="adm-stats-grid">
    <div class="adm-stat-card">
      <div class="adm-stat-label">전체 회원수</div>
      <div class="adm-stat-value primary"><%= totalMembers != null ? totalMembers : 0 %></div>
    </div>
    <div class="adm-stat-card">
      <div class="adm-stat-label">오늘 게시글</div>
      <div class="adm-stat-value success"><%= todayPosts != null ? todayPosts : 0 %></div>
    </div>
    <div class="adm-stat-card">
      <div class="adm-stat-label">전체 게시글</div>
      <div class="adm-stat-value warning"><%= totalPosts != null ? totalPosts : 0 %></div>
    </div>
    <div class="adm-stat-card">
      <div class="adm-stat-label">미승인 게시글</div>
      <div class="adm-stat-value danger"><%= unapprovedPosts != null ? unapprovedPosts : 0 %></div>
    </div>
  </div>

  <div class="adm-card">
    <div class="adm-card-header">
      <div class="adm-card-title">빠른 메뉴</div>
    </div>
    <div style="padding:20px; display:flex; gap:12px; flex-wrap:wrap;">
      <a href="/maddit/admin/board/list" class="adm-btn-sm" style="padding:8px 16px; font-size:13px;">📋 게시글 관리</a>
      <a href="/maddit/admin/member/list" class="adm-btn-sm" style="padding:8px 16px; font-size:13px;">👥 회원 관리</a>
      <a href="/" target="_blank" class="adm-btn-sm" style="padding:8px 16px; font-size:13px;">🌐 사이트 열기</a>
    </div>
  </div>
</div>

</body>
</html>
