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

  String boardGbnCd   = (String) request.getAttribute("boardGbnCd");
  String searchType   = (String) request.getAttribute("searchType");
  String searchKeyword = (String) request.getAttribute("searchKeyword");
  if (boardGbnCd == null) boardGbnCd = "";
  if (searchType == null) searchType = "all";
  if (searchKeyword == null) searchKeyword = "";

  @SuppressWarnings("unchecked")
  List<ComCodeDtlVO> boardCodeList = (List<ComCodeDtlVO>) request.getAttribute("boardCodeList");

  String baseUrl = "/maddit/admin/board/list";
  String params = "boardGbnCd=" + boardGbnCd
      + (!"all".equals(searchType) ? "&searchType=" + searchType : "")
      + (!searchKeyword.isEmpty() ? "&searchKeyword=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8") : "");

  String boardTitle;
  switch (boardGbnCd) {
    case "01": boardTitle = "💬 자유게시판";      break;
    case "02": boardTitle = "🔔 공지사항";        break;
    case "03": boardTitle = "✏️ 만들어 주세요";   break;
    case "04": boardTitle = "💻 프로그램 게시판"; break;
    default:   boardTitle = "📋 게시판 관리";     break;
  }
%>

<div class="adm-content">
  <h1 class="adm-page-title"><%= boardTitle %></h1>

  <!-- 필터 -->
  <form class="adm-search-bar" action="<%= baseUrl %>" method="get">
    <select name="searchType" class="adm-search-select">
      <option value="all"    <%= "all".equals(searchType)    ? "selected" : "" %>>제목+작성자</option>
      <option value="title"  <%= "title".equals(searchType)  ? "selected" : "" %>>제목</option>
      <option value="author" <%= "author".equals(searchType) ? "selected" : "" %>>작성자</option>
    </select>
    <input type="text" name="searchKeyword" class="adm-search-input" placeholder="검색어" value="<%= searchKeyword %>">
    <button type="submit" class="adm-search-btn">검색</button>
  </form>

  <div class="adm-card">
    <div class="adm-card-header">
      <div class="adm-card-title">게시글 목록 · 총 <%= totalCount %>건</div>
      <% if ("02".equals(boardGbnCd)) { %>
        <a href="/maddit/admin/notice/write" class="adm-btn-sm" style="background:var(--adm-primary);color:#fff;border-color:var(--adm-primary);padding:5px 14px;">+ 공지 작성</a>
      <% } %>
    </div>
    <table class="adm-table">
      <thead>
        <tr>
          <th style="width:60px">번호</th>
          <th style="width:70px">구분</th>
          <th>제목</th>
          <th style="width:80px">작성자</th>
          <th style="width:70px">승인</th>
          <th style="width:50px">조회</th>
          <th style="width:50px">댓글</th>
          <th style="width:130px">작성일</th>
          <th style="width:100px">관리</th>
        </tr>
      </thead>
      <tbody>
        <% if (postList != null && !postList.isEmpty()) {
             for (BoardPostVO p : postList) {
               String gbnLabel = "01".equals(p.getBoardGbnCd()) ? "자유" : "02".equals(p.getBoardGbnCd()) ? "공지" : "03".equals(p.getBoardGbnCd()) ? "요청" : "04".equals(p.getBoardGbnCd()) ? "프로그램" : p.getBoardGbnCd();
        %>
        <tr>
          <td><%= p.getPostNo() %></td>
          <td><%= gbnLabel %></td>
          <td class="left">
            <a href="/maddit/admin/board/view/<%= p.getPostNo() %>?boardGbnCd=<%= boardGbnCd %>&page=<%= currentPage %><%= (!"all".equals(searchType) ? "&searchType=" + searchType : "") + (!searchKeyword.isEmpty() ? "&searchKeyword=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8") : "") %>">
              <%= org.springframework.web.util.HtmlUtils.htmlEscape(p.getTitle()) %>
              <% if (p.getCommentCnt() > 0) { %><span style="color:var(--adm-primary);font-size:11px;margin-left:4px;">[<%= p.getCommentCnt() %>]</span><% } %>
            </a>
          </td>
          <td><%= org.springframework.web.util.HtmlUtils.htmlEscape(p.getNickname()) %></td>
          <td>
            <span class="adm-badge <%= "Y".equals(p.getApprovalYn()) ? "adm-badge-y" : "adm-badge-n" %>"
                  id="approval-<%= p.getPostNo() %>">
              <%= "Y".equals(p.getApprovalYn()) ? "승인" : "미승인" %>
            </span>
          </td>
          <td><%= p.getViewCnt() %></td>
          <td><%= p.getCommentCnt() %></td>
          <td><%= p.getTimeAgo() %></td>
          <td>
            <button class="adm-btn-sm" onclick="toggleApproval(<%= p.getPostNo() %>)">승인토글</button>
            <button class="adm-btn-sm danger" onclick="deletePost(<%= p.getPostNo() %>)">삭제</button>
          </td>
        </tr>
        <% } } else { %>
        <tr><td colspan="9" style="padding:40px;color:var(--adm-txt3);">게시글이 없습니다.</td></tr>
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
function toggleApproval(postNo) {
  fetch(ctx + '/admin/board/approval', {
    method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'},
    body:'postNo=' + postNo
  }).then(function(r){return r.json()}).then(function(d){
    if (d.success) location.reload();
  });
}
function deletePost(postNo) {
  if (!confirm('정말 삭제하시겠습니까?')) return;
  fetch(ctx + '/admin/board/delete', {
    method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'},
    body:'postNo=' + postNo
  }).then(function(r){return r.json()}).then(function(d){
    if (d.success) location.reload();
  });
}
</script>
</body>
</html>
