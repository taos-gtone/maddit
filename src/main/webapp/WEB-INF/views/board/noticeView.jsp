<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.maddit.vo.BoardPostVO" %>
<%
  response.setHeader("Cache-Control", "no-store");
  response.setHeader("Pragma", "no-cache");
  response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/common/head.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board/notice.css">
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
  String contextPath = request.getContextPath();

  BoardPostVO post = (BoardPostVO) request.getAttribute("post");

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

  String searchType    = (String) request.getAttribute("searchType");
  String searchKeyword = (String) request.getAttribute("searchKeyword");
  if (searchType    == null) searchType    = "all";
  if (searchKeyword == null) searchKeyword = "";
  String filterParams = (!"all".equals(searchType) ? "&searchType=" + searchType : "")
      + (!searchKeyword.isEmpty() ? "&searchKeyword=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8") : "");

  long viewPostNo = (post != null) ? post.getPostNo() : 0;
%>

<!-- ===== MAIN WRAPPER ===== -->
<div class="page-wrapper">
  <main class="main-content">

    <div class="board-breadcrumb">
      <a href="<%= contextPath %>/">홈</a>
      <span class="bc-sep">›</span>
      <a href="<%= contextPath %>/board/notice">공지사항</a>
      <span class="bc-sep">›</span>
      <span>글 보기</span>
    </div>

    <div class="content-inner">

      <% if (post != null) { %>

      <!-- 게시글 본문 -->
      <div class="view-card">
        <div class="view-header">
          <h1 class="view-title"><%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getTitle()) %></h1>
          <div class="view-meta">
            <span><%= post.getTimeAgo() %></span>
            <span class="meta-dot">&middot;</span>
            <span>조회 <%= post.getViewCnt() %></span>
          </div>
        </div>

        <div class="view-body">
          <%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getContent() != null ? post.getContent() : "").replace("\n", "<br>") %>
        </div>

        <div class="view-footer">
          <a href="<%= contextPath %>/board/notice?page=<%= currentPage %><%= filterParams %>" class="btn-back-list">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"/></svg>
            목록으로
          </a>
        </div>
      </div>

      <% } else { %>
      <div class="board-empty">
        <div class="empty-icon">📢</div>
        <p>존재하지 않는 공지사항입니다.</p>
      </div>
      <% } %>

      <!-- 하단 글목록 -->
      <% if (postList != null && !postList.isEmpty()) { %>
      <div class="write-bottom-list">
        <div class="board-table-panel">
          <div class="write-list-header">
            <span class="write-list-title"><svg class="board-title-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg> 공지사항</span>
            <span class="board-count"><%= currentPage %> / <%= totalPages %> 페이지</span>
          </div>
          <table class="board-table">
            <thead>
              <tr>
                <th class="col-no">번호</th>
                <th class="col-title">제목</th>
                <th class="col-date">작성일</th>
                <th class="col-views">조회</th>
              </tr>
            </thead>
            <tbody>
              <% int rowNum = totalCount - (currentPage - 1) * 15;
                 for (BoardPostVO lp : postList) {
                   boolean isCurrent = (lp.getPostNo() == viewPostNo);
              %>
              <tr class="<%= isCurrent ? "current-row" : "" %>">
                <td class="col-no"><%= rowNum-- %></td>
                <td class="col-title">
                  <a class="post-title-link" href="<%= contextPath %>/board/notice/view/<%= lp.getPostNo() %>?page=<%= currentPage %><%= filterParams %>">
                    <% if (isCurrent) { %><span class="current-marker">▸</span><% } %>
                    <span class="title-text"><%= org.springframework.web.util.HtmlUtils.htmlEscape(lp.getTitle()) %></span>
                  </a>
                </td>
                <td class="col-date"><%= lp.getTimeAgo() %></td>
                <td class="col-views"><%= lp.getViewCnt() %></td>
              </tr>
              <% } %>
            </tbody>
          </table>
        </div>

        <nav class="board-pagination">
          <% if (currentPage <= 1) { %>
            <span class="pg-btn disabled">‹</span>
          <% } else { %>
            <a href="<%= contextPath %>/board/notice/view/<%= viewPostNo %>?page=<%= currentPage - 1 %><%= filterParams %>" class="pg-btn">‹</a>
          <% } %>
          <% if (startPage > 1) { %>
            <a href="<%= contextPath %>/board/notice/view/<%= viewPostNo %>?page=1<%= filterParams %>" class="pg-btn">1</a>
            <% if (startPage > 2) { %><span class="pg-ellipsis">···</span><% } %>
          <% } %>
          <% for (int i = startPage; i <= endPage; i++) { %>
            <% if (i == currentPage) { %>
              <span class="pg-btn active"><%= i %></span>
            <% } else { %>
              <a href="<%= contextPath %>/board/notice/view/<%= viewPostNo %>?page=<%= i %><%= filterParams %>" class="pg-btn"><%= i %></a>
            <% } %>
          <% } %>
          <% if (endPage < totalPages) { %>
            <% if (endPage < totalPages - 1) { %><span class="pg-ellipsis">···</span><% } %>
            <a href="<%= contextPath %>/board/notice/view/<%= viewPostNo %>?page=<%= totalPages %><%= filterParams %>" class="pg-btn"><%= totalPages %></a>
          <% } %>
          <% if (currentPage >= totalPages) { %>
            <span class="pg-btn disabled">›</span>
          <% } else { %>
            <a href="<%= contextPath %>/board/notice/view/<%= viewPostNo %>?page=<%= currentPage + 1 %><%= filterParams %>" class="pg-btn">›</a>
          <% } %>
        </nav>
      </div>
      <% } %>

    </div>
  </main>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/scripts.jsp" %>
</body>
</html>
