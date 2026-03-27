<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.maddit.vo.BoardPostVO" %>
<%@ page import="com.maddit.vo.ComCodeDtlVO" %>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/admin/layout/head.jsp" %>
<body class="admin-body">
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<%
  @SuppressWarnings("unchecked")
  List<BoardPostVO> postList = (List<BoardPostVO>) request.getAttribute("postList");
  @SuppressWarnings("unchecked")
  List<ComCodeDtlVO> catCodeList = (List<ComCodeDtlVO>) request.getAttribute("catCodeList");

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

  String boardCatGbnCd = (String) request.getAttribute("boardCatGbnCd");
  String searchType    = (String) request.getAttribute("searchType");
  String searchKeyword = (String) request.getAttribute("searchKeyword");
  if (boardCatGbnCd == null) boardCatGbnCd = "";
  if (searchType == null) searchType = "all";
  if (searchKeyword == null) searchKeyword = "";

  String baseUrl = "/maddit/admin/program/list";
  String params = "boardCatGbnCd=" + boardCatGbnCd
      + (!"all".equals(searchType) ? "&searchType=" + searchType : "")
      + (!searchKeyword.isEmpty() ? "&searchKeyword=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8") : "");
%>

<div class="adm-content">
  <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;">
    <h1 class="adm-page-title" style="margin-bottom:0;">💻 프로그램 게시판 관리</h1>
    <a href="/maddit/admin/program/write" class="adm-btn-sm" style="padding:6px 16px;font-size:13px;background:var(--adm-primary);color:#fff;border:none;">+ 새 글 작성</a>
  </div>

  <!-- 필터 -->
  <form class="adm-search-bar" action="<%= baseUrl %>" method="get">
    <select name="boardCatGbnCd" class="adm-search-select">
      <option value="">전체 카테고리</option>
      <% if (catCodeList != null) { for (ComCodeDtlVO c : catCodeList) { %>
      <option value="<%= c.getCodeId() %>" <%= c.getCodeId().equals(boardCatGbnCd) ? "selected" : "" %>><%= c.getCodeNm() %></option>
      <% } } %>
    </select>
    <select name="searchType" class="adm-search-select">
      <option value="all"     <%= "all".equals(searchType)     ? "selected" : "" %>>제목+내용</option>
      <option value="title"   <%= "title".equals(searchType)   ? "selected" : "" %>>제목</option>
      <option value="content" <%= "content".equals(searchType) ? "selected" : "" %>>내용</option>
    </select>
    <input type="text" name="searchKeyword" class="adm-search-input" placeholder="검색어" value="<%= searchKeyword %>">
    <button type="submit" class="adm-search-btn">검색</button>
  </form>

  <div class="adm-card">
    <div class="adm-card-header">
      <div class="adm-card-title">게시글 목록 · 총 <%= totalCount %>건</div>
    </div>
    <table class="adm-table">
      <thead>
        <tr>
          <th style="width:60px">번호</th>
          <th style="width:120px">카테고리</th>
          <th>제목</th>
          <th style="width:60px">파일</th>
          <th style="width:60px">썸네일</th>
          <th style="width:50px">조회</th>
          <th style="width:130px">작성일</th>
          <th style="width:100px">관리</th>
        </tr>
      </thead>
      <tbody>
        <% if (postList != null && !postList.isEmpty()) {
             for (BoardPostVO p : postList) { %>
        <tr>
          <td><%= p.getPostNo() %></td>
          <td><%= p.getCatNm() != null ? p.getCatNm() : "-" %></td>
          <td class="left">
            <a href="/maddit/admin/program/view/<%= p.getPostNo() %>?page=<%= currentPage %>&boardCatGbnCd=<%= boardCatGbnCd %><%= (!"all".equals(searchType) ? "&searchType=" + searchType : "") + (!searchKeyword.isEmpty() ? "&searchKeyword=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8") : "") %>">
              <%= org.springframework.web.util.HtmlUtils.htmlEscape(p.getTitle()) %>
            </a>
          </td>
          <td><%= p.getFileCnt() > 0 ? "📎 " + p.getFileCnt() : "-" %></td>
          <td><%= (p.getThumbFilePath() != null && !p.getThumbFilePath().isEmpty()) ? "🖼️" : "-" %></td>
          <td><%= p.getViewCnt() %></td>
          <td><%= p.getTimeAgo() %></td>
          <td>
            <a href="/maddit/admin/program/edit/<%= p.getPostNo() %>" class="adm-btn-sm">수정</a>
            <button class="adm-btn-sm danger" onclick="deletePost(<%= p.getPostNo() %>)">삭제</button>
          </td>
        </tr>
        <% } } else { %>
        <tr><td colspan="8" style="padding:40px;color:var(--adm-txt3);">게시글이 없습니다.</td></tr>
        <% } %>
      </tbody>
    </table>

    <!-- 페이지네이션 -->
    <nav class="adm-pagination">
      <% if (currentPage <= 1) { %>
        <span class="adm-pg-btn disabled">‹</span>
      <% } else { %>
        <a href="<%= baseUrl %>?<%= params %>&page=<%= currentPage - 1 %>" class="adm-pg-btn">‹</a>
      <% } %>
      <% if (startPage > 1) { %>
        <a href="<%= baseUrl %>?<%= params %>&page=1" class="adm-pg-btn">1</a>
        <% if (startPage > 2) { %><span class="adm-pg-ellipsis">···</span><% } %>
      <% } %>
      <% for (int i = startPage; i <= endPage; i++) { %>
        <% if (i == currentPage) { %>
          <span class="adm-pg-btn active"><%= i %></span>
        <% } else { %>
          <a href="<%= baseUrl %>?<%= params %>&page=<%= i %>" class="adm-pg-btn"><%= i %></a>
        <% } %>
      <% } %>
      <% if (endPage < totalPages) { %>
        <% if (endPage < totalPages - 1) { %><span class="adm-pg-ellipsis">···</span><% } %>
        <a href="<%= baseUrl %>?<%= params %>&page=<%= totalPages %>" class="adm-pg-btn"><%= totalPages %></a>
      <% } %>
      <% if (currentPage >= totalPages) { %>
        <span class="adm-pg-btn disabled">›</span>
      <% } else { %>
        <a href="<%= baseUrl %>?<%= params %>&page=<%= currentPage + 1 %>" class="adm-pg-btn">›</a>
      <% } %>
    </nav>
  </div>
</div>

<script>
var ctx = '/maddit';
function deletePost(postNo) {
  if (!confirm('정말 삭제하시겠습니까?')) return;
  fetch(ctx + '/admin/program/delete', {
    method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'},
    body:'postNo=' + postNo
  }).then(function(r){return r.json()}).then(function(d){
    if (d.success) location.reload();
  });
}
</script>
</body>
</html>
