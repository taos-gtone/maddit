<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.maddit.vo.MemberVO" %>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/admin/layout/head.jsp" %>
<body class="admin-body">
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<%
  @SuppressWarnings("unchecked")
  List<MemberVO> memberList = (List<MemberVO>) request.getAttribute("memberList");
  Integer currentPageObj = (Integer) request.getAttribute("currentPage");
  Integer totalPagesObj  = (Integer) request.getAttribute("totalPages");
  Integer startPageObj   = (Integer) request.getAttribute("startPage");
  Integer endPageObj     = (Integer) request.getAttribute("endPage");
  Integer totalCountObj  = (Integer) request.getAttribute("totalCount");

  int currentPage = (currentPageObj != null) ? currentPageObj : 1;
  int totalPages  = (totalPagesObj  != null) ? totalPagesObj  : 1;
  int startPage   = (startPageObj   != null) ? startPageObj   : 1;
  int endPage     = (endPageObj     != null) ? endPageObj     : totalPages;
  int totalCount  = (totalCountObj  != null) ? totalCountObj  : 0;

  String searchKeyword = (String) request.getAttribute("searchKeyword");
  if (searchKeyword == null) searchKeyword = "";

  String baseUrl = "/maddit/admin/member/list";
  String params = !searchKeyword.isEmpty() ? "searchKeyword=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8") : "";
%>

<div class="adm-content">
  <h1 class="adm-page-title">👥 회원 관리</h1>

  <form class="adm-search-bar" action="<%= baseUrl %>" method="get">
    <input type="text" name="searchKeyword" class="adm-search-input" placeholder="이메일 또는 닉네임 검색" value="<%= searchKeyword %>">
    <button type="submit" class="adm-search-btn">검색</button>
  </form>

  <div class="adm-card">
    <div class="adm-card-header">
      <div class="adm-card-title">회원 목록 · 총 <%= totalCount %>명</div>
    </div>
    <table class="adm-table">
      <thead>
        <tr>
          <th style="width:70px">번호</th>
          <th>이메일</th>
          <th style="width:100px">닉네임</th>
          <th style="width:80px">상태</th>
          <th style="width:140px">최근 로그인</th>
          <th style="width:140px">가입일</th>
        </tr>
      </thead>
      <tbody>
        <% if (memberList != null && !memberList.isEmpty()) {
             for (MemberVO m : memberList) {
               String stsLabel = "10".equals(m.getAcctStsCd()) ? "정상" : "20".equals(m.getAcctStsCd()) ? "정지" : (m.getAcctStsCd() != null ? m.getAcctStsCd() : "-");
               String stsCls   = "10".equals(m.getAcctStsCd()) ? "adm-badge-y" : "adm-badge-n";
        %>
        <tr>
          <td><%= m.getMemberNo() %></td>
          <td class="left"><%= org.springframework.web.util.HtmlUtils.htmlEscape(m.getEmail()) %></td>
          <td><%= org.springframework.web.util.HtmlUtils.htmlEscape(m.getNickname() != null ? m.getNickname() : "-") %></td>
          <td><span class="adm-badge <%= stsCls %>"><%= stsLabel %></span></td>
          <td><%= m.getLastLoginAt() != null ? new java.text.SimpleDateFormat("yyyy.MM.dd HH:mm").format(m.getLastLoginAt()) : "-" %></td>
          <td><%= m.getCreateTs() != null ? new java.text.SimpleDateFormat("yyyy.MM.dd HH:mm").format(m.getCreateTs()) : "-" %></td>
        </tr>
        <% } } else { %>
        <tr><td colspan="6" style="padding:40px;color:var(--adm-txt3);">회원이 없습니다.</td></tr>
        <% } %>
      </tbody>
    </table>

    <nav class="adm-pagination">
      <% if (currentPage <= 1) { %>
        <span class="adm-pg-btn disabled">‹</span>
      <% } else { %>
        <a href="<%= baseUrl %>?<%= params %><%= !params.isEmpty() ? "&" : "" %>page=<%= currentPage - 1 %>" class="adm-pg-btn">‹</a>
      <% } %>
      <% if (startPage > 1) { %>
        <a href="<%= baseUrl %>?<%= params %><%= !params.isEmpty() ? "&" : "" %>page=1" class="adm-pg-btn">1</a>
        <% if (startPage > 2) { %><span class="adm-pg-ellipsis">···</span><% } %>
      <% } %>
      <% for (int i = startPage; i <= endPage; i++) { %>
        <% if (i == currentPage) { %>
          <span class="adm-pg-btn active"><%= i %></span>
        <% } else { %>
          <a href="<%= baseUrl %>?<%= params %><%= !params.isEmpty() ? "&" : "" %>page=<%= i %>" class="adm-pg-btn"><%= i %></a>
        <% } %>
      <% } %>
      <% if (endPage < totalPages) { %>
        <% if (endPage < totalPages - 1) { %><span class="adm-pg-ellipsis">···</span><% } %>
        <a href="<%= baseUrl %>?<%= params %><%= !params.isEmpty() ? "&" : "" %>page=<%= totalPages %>" class="adm-pg-btn"><%= totalPages %></a>
      <% } %>
      <% if (currentPage >= totalPages) { %>
        <span class="adm-pg-btn disabled">›</span>
      <% } else { %>
        <a href="<%= baseUrl %>?<%= params %><%= !params.isEmpty() ? "&" : "" %>page=<%= currentPage + 1 %>" class="adm-pg-btn">›</a>
      <% } %>
    </nav>
  </div>
</div>

</body>
</html>
