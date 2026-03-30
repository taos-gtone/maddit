<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

<%@ page import="java.util.List" %>
<%@ page import="com.maddit.vo.BoardPostVO" %>
<%
  String contextPath = request.getContextPath();

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
%>

<!-- ===== MAIN WRAPPER ===== -->
<div class="page-wrapper">
  <main class="main-content">

    <!-- 브레드크럼 -->
    <div class="board-breadcrumb">
      <a href="<%= contextPath %>/">홈</a>
      <span class="bc-sep">›</span>
      <a href="<%= contextPath %>/board/request">만들어 주세요</a>
      <span class="bc-sep">›</span>
      <span>글쓰기</span>
    </div>

    <div class="content-inner">

      <!-- 글쓰기 헤더 -->
      <div class="board-header">
        <div class="board-header-left">
          <h1 class="board-title"><svg class="board-title-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg> 글쓰기</h1>
        </div>
      </div>

      <!-- 글쓰기 폼 -->
      <div class="write-card">
        <form class="write-form" action="<%= contextPath %>/board/request/write" method="post"
              onsubmit="return validateWriteForm()">

          <div class="write-form-group">
            <label class="write-label" for="title">제목 <span class="req">*</span></label>
            <input type="text" id="title" name="title"
                   class="write-input"
                   placeholder="어떤 프로그램을 만들어 달라고 요청할까요?"
                   maxlength="200"
                   required>
          </div>

          <div class="write-form-group">
            <label class="write-label" for="content">내용 <span class="req">*</span></label>
            <textarea id="content" name="content"
                      class="write-textarea"
                      placeholder="원하는 프로그램의 기능, 사용 환경 등을 자세히 설명해주세요."
                      rows="14"
                      required></textarea>
          </div>

          <div class="write-actions">
            <a href="<%= contextPath %>/board/request" class="btn-cancel">취소</a>
            <button type="submit" class="btn-submit">등록하기</button>
          </div>
        </form>
      </div>

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
                 for (BoardPostVO post : postList) { %>
              <tr>
                <td class="col-no"><%= rowNum-- %></td>
                <td class="col-title">
                  <a class="post-title-link" href="<%= contextPath %>/board/request/view/<%= post.getPostNo() %>">
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
              <% } %>
            </tbody>
          </table>
        </div>

        <!-- 페이지네이션 -->
        <nav class="board-pagination">
          <% if (currentPage <= 1) { %>
            <span class="pg-btn disabled">‹</span>
          <% } else { %>
            <a href="<%= contextPath %>/board/request/write?page=<%= currentPage - 1 %>" class="pg-btn">‹</a>
          <% } %>

          <% if (startPage > 1) { %>
            <a href="<%= contextPath %>/board/request/write?page=1" class="pg-btn">1</a>
            <% if (startPage > 2) { %><span class="pg-ellipsis">···</span><% } %>
          <% } %>

          <% for (int i = startPage; i <= endPage; i++) { %>
            <% if (i == currentPage) { %>
              <span class="pg-btn active"><%= i %></span>
            <% } else { %>
              <a href="<%= contextPath %>/board/request/write?page=<%= i %>" class="pg-btn"><%= i %></a>
            <% } %>
          <% } %>

          <% if (endPage < totalPages) { %>
            <% if (endPage < totalPages - 1) { %><span class="pg-ellipsis">···</span><% } %>
            <a href="<%= contextPath %>/board/request/write?page=<%= totalPages %>" class="pg-btn"><%= totalPages %></a>
          <% } %>

          <% if (currentPage >= totalPages) { %>
            <span class="pg-btn disabled">›</span>
          <% } else { %>
            <a href="<%= contextPath %>/board/request/write?page=<%= currentPage + 1 %>" class="pg-btn">›</a>
          <% } %>
        </nav>
      </div>
      <% } %>

    </div><!-- /content-inner -->
  </main>
</div><!-- /page-wrapper -->

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/scripts.jsp" %>

<script>
function validateWriteForm() {
  var title   = document.getElementById('title').value.trim();
  var content = document.getElementById('content').value.trim();
  if (!title) { alert('제목을 입력해주세요.'); document.getElementById('title').focus(); return false; }
  if (!content) { alert('내용을 입력해주세요.'); document.getElementById('content').focus(); return false; }
  return true;
}
</script>
</body>
</html>
