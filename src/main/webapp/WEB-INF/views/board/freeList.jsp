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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board/free.css">
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
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

  String contextPath = request.getContextPath();

  String filterParams = (!"all".equals(searchType) ? "&searchType=" + searchType : "")
      + (!searchKeyword.isEmpty() ? "&searchKeyword=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8") : "");

  @SuppressWarnings("unchecked")
  List<BoardPostVO> postList = (List<BoardPostVO>) request.getAttribute("postList");

  boolean isLoggedIn = (loginUser != null);
%>

<!-- ===== MAIN WRAPPER ===== -->
<div class="page-wrapper">
  <main class="main-content">

    <!-- 브레드크럼 -->
    <div class="board-breadcrumb">
      <a href="<%= contextPath %>/">홈</a>
      <span class="bc-sep">›</span>
      <span>자유게시판</span>
    </div>

    <div class="content-inner">

      <!-- 게시판 헤더 -->
      <div class="board-header">
        <div class="board-header-left">
          <h1 class="board-title">💬 자유게시판</h1>
          <span class="board-count">총 <%= totalCount %>개</span>
        </div>
        <div class="board-header-right">
          <% if (isLoggedIn) { %>
          <a href="<%= contextPath %>/board/free/write" class="btn-write">
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
            글쓰기
          </a>
          <% } else { %>
          <a href="<%= contextPath %>/member/login?redirect=/board/free/write" class="btn-write">
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
            글쓰기
          </a>
          <% } %>
        </div>
      </div>

      <!-- 검색 바 -->
      <form class="board-search" action="<%= contextPath %>/board/free" method="get">
        <select name="searchType" class="search-select">
          <option value="all"     <%= "all".equals(searchType)     ? "selected" : "" %>>제목+내용</option>
          <option value="title"   <%= "title".equals(searchType)   ? "selected" : "" %>>제목</option>
          <option value="content" <%= "content".equals(searchType) ? "selected" : "" %>>내용</option>
        </select>
        <div class="search-input-wrap">
          <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요" value="<%= searchKeyword %>">
          <button type="submit" aria-label="검색">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="10" cy="10" r="8"/><line x1="16" y1="16" x2="22" y2="22"/></svg>
          </button>
        </div>
      </form>

      <!-- 게시글 목록 테이블 -->
      <div class="board-table-panel">
        <table class="board-table">
          <thead>
            <tr>
              <th class="col-no">번호</th>
              <th class="col-title">제목</th>
              <th class="col-author">작성자</th>
              <th class="col-date">작성일</th>
              <th class="col-views">조회</th>
              <th class="col-likes">추천/비추천</th>
            </tr>
          </thead>
          <tbody>
            <% if (postList != null && !postList.isEmpty()) {
                 int rowNum = totalCount - (currentPage - 1) * 15;
                 for (BoardPostVO post : postList) { %>
            <tr>
              <td class="col-no"><%= rowNum-- %></td>
              <td class="col-title">
                <a class="post-title-link" href="<%= contextPath %>/board/free/view/<%= post.getPostNo() %>?page=<%= currentPage %><%= filterParams %>">
                  <span class="title-text"><%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getTitle()) %></span>
                  <% if (post.getCommentCnt() > 0) { %>
                  <span class="comment-cnt">[<%= post.getCommentCnt() %>]</span>
                  <% } %>
                </a>
              </td>
              <td class="col-author"><%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getNickname()) %></td>
              <td class="col-date"><%= post.getTimeAgo() %></td>
              <td class="col-views"><%= post.getViewCnt() %></td>
              <td class="col-likes">
                <% if (post.getLikeCnt() > 0) { %>
                <span class="like-badge">❤️ <%= post.getLikeCnt() %></span>
                <% } %>
                <% if (post.getDislikeCnt() > 0) { %>
                <span class="dislike-badge">👎 <%= post.getDislikeCnt() %></span>
                <% } %>
                <% if (post.getLikeCnt() == 0 && post.getDislikeCnt() == 0) { %>
                <span class="no-reaction">-</span>
                <% } %>
              </td>
            </tr>
            <% } } else { %>
            <tr>
              <td colspan="6">
                <div class="board-empty">
                  <div class="empty-icon">📭</div>
                  <% if (!searchKeyword.isEmpty()) { %>
                  <p>검색 결과가 없습니다.</p>
                  <% } else { %>
                  <p>아직 게시글이 없습니다.<br>첫 번째 글을 작성해보세요!</p>
                  <% } %>
                </div>
              </td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>

      <!-- 페이지네이션 -->
      <nav class="board-pagination">
        <% if (currentPage <= 1) { %>
          <span class="pg-btn disabled">‹</span>
        <% } else { %>
          <a href="<%= contextPath %>/board/free?page=<%= currentPage - 1 %><%= filterParams %>" class="pg-btn">‹</a>
        <% } %>

        <% if (startPage > 1) { %>
          <a href="<%= contextPath %>/board/free?page=1<%= filterParams %>" class="pg-btn">1</a>
          <% if (startPage > 2) { %><span class="pg-ellipsis">···</span><% } %>
        <% } %>

        <% for (int i = startPage; i <= endPage; i++) { %>
          <% if (i == currentPage) { %>
            <span class="pg-btn active"><%= i %></span>
          <% } else { %>
            <a href="<%= contextPath %>/board/free?page=<%= i %><%= filterParams %>" class="pg-btn"><%= i %></a>
          <% } %>
        <% } %>

        <% if (endPage < totalPages) { %>
          <% if (endPage < totalPages - 1) { %><span class="pg-ellipsis">···</span><% } %>
          <a href="<%= contextPath %>/board/free?page=<%= totalPages %><%= filterParams %>" class="pg-btn"><%= totalPages %></a>
        <% } %>

        <% if (currentPage >= totalPages) { %>
          <span class="pg-btn disabled">›</span>
        <% } else { %>
          <a href="<%= contextPath %>/board/free?page=<%= currentPage + 1 %><%= filterParams %>" class="pg-btn">›</a>
        <% } %>
      </nav>

    </div><!-- /content-inner -->
  </main>
</div><!-- /page-wrapper -->

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/scripts.jsp" %>
</body>
</html>
