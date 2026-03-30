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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board/request.css">
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

  long editPostNo = (post != null) ? post.getPostNo() : 0;
%>

<!-- ===== MAIN WRAPPER ===== -->
<div class="page-wrapper">
  <main class="main-content">

    <div class="board-breadcrumb">
      <a href="<%= contextPath %>/">홈</a>
      <span class="bc-sep">›</span>
      <a href="<%= contextPath %>/board/request">만들어 주세요</a>
      <span class="bc-sep">›</span>
      <span>글수정</span>
    </div>

    <div class="content-inner">

      <div class="board-header">
        <div class="board-header-left">
          <h1 class="board-title"><svg class="board-title-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg> 글수정</h1>
        </div>
      </div>

      <% if (post != null) { %>
      <div class="write-card">
        <form class="write-form" action="<%= contextPath %>/board/request/edit/<%= post.getPostNo() %>" method="post"
              onsubmit="return validateEditForm()">

          <div class="write-form-group">
            <label class="write-label" for="title">제목 <span class="req">*</span></label>
            <input type="text" id="title" name="title"
                   class="write-input"
                   maxlength="200"
                   value="<%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getTitle()) %>"
                   required>
          </div>

          <div class="write-form-group">
            <label class="write-label" for="content">내용 <span class="req">*</span></label>
            <textarea id="content" name="content"
                      class="write-textarea"
                      rows="14"
                      required><%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getContent() != null ? post.getContent() : "") %></textarea>
          </div>

          <div class="write-actions">
            <a href="<%= contextPath %>/board/request/view/<%= post.getPostNo() %>" class="btn-cancel">취소</a>
            <button type="submit" class="btn-submit">수정완료</button>
          </div>
        </form>
      </div>
      <% } %>

      <!-- 하단 글목록 -->
      <% if (postList != null && !postList.isEmpty()) { %>
      <div class="write-bottom-list">
        <div class="board-table-panel">
          <div class="write-list-header">
            <span class="write-list-title"><svg class="board-title-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg> 만들어 주세요</span>
            <span class="board-count"><%= currentPage %> / <%= totalPages %> 페이지</span>
          </div>
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
              <% int rowNum = totalCount - (currentPage - 1) * 15;
                 for (BoardPostVO lp : postList) {
                   boolean isCurrent = (lp.getPostNo() == editPostNo);
              %>
              <tr class="<%= isCurrent ? "current-row" : "" %>">
                <td class="col-no"><%= rowNum-- %></td>
                <td class="col-title">
                  <a class="post-title-link" href="<%= contextPath %>/board/request/view/<%= lp.getPostNo() %>">
                    <% if (isCurrent) { %><span class="current-marker">▸</span><% } %>
                    <span class="title-text"><%= org.springframework.web.util.HtmlUtils.htmlEscape(lp.getTitle()) %></span>
                    <% if (lp.getCommentCnt() > 0) { %>
                    <span class="comment-cnt">[<%= lp.getCommentCnt() %>]</span>
                    <% } %>
                  </a>
                </td>
                <td class="col-author"><%= org.springframework.web.util.HtmlUtils.htmlEscape(lp.getNickname()) %></td>
                <td class="col-date"><%= lp.getTimeAgo() %></td>
                <td class="col-views"><%= lp.getViewCnt() %></td>
                <td class="col-likes">
                  <% if (lp.getLikeCnt() > 0) { %>
                  <span class="like-badge">❤️ <%= lp.getLikeCnt() %></span>
                  <% } %>
                  <% if (lp.getDislikeCnt() > 0) { %>
                  <span class="dislike-badge">👎 <%= lp.getDislikeCnt() %></span>
                  <% } %>
                  <% if (lp.getLikeCnt() == 0 && lp.getDislikeCnt() == 0) { %>
                  <span class="no-reaction">-</span>
                  <% } %>
                </td>
              </tr>
              <% } %>
            </tbody>
          </table>
        </div>

        <nav class="board-pagination">
          <% if (currentPage <= 1) { %>
            <span class="pg-btn disabled">‹</span>
          <% } else { %>
            <a href="<%= contextPath %>/board/request/edit/<%= editPostNo %>?page=<%= currentPage - 1 %>" class="pg-btn">‹</a>
          <% } %>
          <% if (startPage > 1) { %>
            <a href="<%= contextPath %>/board/request/edit/<%= editPostNo %>?page=1" class="pg-btn">1</a>
            <% if (startPage > 2) { %><span class="pg-ellipsis">···</span><% } %>
          <% } %>
          <% for (int i = startPage; i <= endPage; i++) { %>
            <% if (i == currentPage) { %>
              <span class="pg-btn active"><%= i %></span>
            <% } else { %>
              <a href="<%= contextPath %>/board/request/edit/<%= editPostNo %>?page=<%= i %>" class="pg-btn"><%= i %></a>
            <% } %>
          <% } %>
          <% if (endPage < totalPages) { %>
            <% if (endPage < totalPages - 1) { %><span class="pg-ellipsis">···</span><% } %>
            <a href="<%= contextPath %>/board/request/edit/<%= editPostNo %>?page=<%= totalPages %>" class="pg-btn"><%= totalPages %></a>
          <% } %>
          <% if (currentPage >= totalPages) { %>
            <span class="pg-btn disabled">›</span>
          <% } else { %>
            <a href="<%= contextPath %>/board/request/edit/<%= editPostNo %>?page=<%= currentPage + 1 %>" class="pg-btn">›</a>
          <% } %>
        </nav>
      </div>
      <% } %>

    </div>
  </main>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/scripts.jsp" %>

<script>
function validateEditForm() {
  var title   = document.getElementById('title').value.trim();
  var content = document.getElementById('content').value.trim();
  if (!title) { alert('제목을 입력해주세요.'); document.getElementById('title').focus(); return false; }
  if (!content) { alert('내용을 입력해주세요.'); document.getElementById('content').focus(); return false; }
  return true;
}
</script>
</body>
</html>
