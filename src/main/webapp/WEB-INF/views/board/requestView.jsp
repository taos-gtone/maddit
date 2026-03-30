<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.maddit.vo.BoardPostVO" %>
<%@ page import="com.maddit.vo.BoardCommentVO" %>
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
  List<BoardCommentVO> commentList = (List<BoardCommentVO>) request.getAttribute("commentList");
  Long loginMemberNoObj = (Long) request.getAttribute("loginMemberNo");
  long loginMemberNo = (loginMemberNoObj != null) ? loginMemberNoObj : 0L;
  String myReaction = (String) request.getAttribute("myReaction");
  if (myReaction == null) myReaction = "";

  @SuppressWarnings("unchecked")
  List<BoardPostVO> postList = (List<BoardPostVO>) request.getAttribute("postList");
  Integer currentPageObj = (Integer) request.getAttribute("currentPage");
  Integer totalPagesObj  = (Integer) request.getAttribute("totalPages");
  Integer startPageObj   = (Integer) request.getAttribute("startPage");
  Integer endPageObj     = (Integer) request.getAttribute("endPage");

  int currentPage = (currentPageObj != null) ? currentPageObj : 1;
  int totalPages  = (totalPagesObj  != null) ? totalPagesObj  : 1;
  int startPage   = (startPageObj   != null) ? startPageObj   : 1;
  int endPage     = (endPageObj     != null) ? endPageObj     : totalPages;
  Integer totalCountObj  = (Integer) request.getAttribute("totalCount");
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
      <a href="<%= contextPath %>/board/request">만들어 주세요</a>
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
            <span class="view-meta-author"><%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getNickname()) %></span>
            <span class="meta-dot">&middot;</span>
            <span><%= post.getTimeAgo() %></span>
            <span class="meta-dot">&middot;</span>
            <span>조회 <%= post.getViewCnt() %></span>
          </div>
        </div>

        <div class="view-body">
          <%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getContent() != null ? post.getContent() : "").replace("\n", "<br>") %>
        </div>

        <!-- 추천/비추천 -->
        <div class="reaction-bar">
          <button type="button" class="btn-reaction like<%= "1".equals(myReaction) ? " active" : "" %>"
                  id="btnLike" onclick="doReaction('1')">
            ❤️ <span id="likeCount"><%= post.getLikeCnt() %></span>
          </button>
          <button type="button" class="btn-reaction dislike<%= "2".equals(myReaction) ? " active" : "" %>"
                  id="btnDislike" onclick="doReaction('2')">
            👎 <span id="dislikeCount"><%= post.getDislikeCnt() %></span>
          </button>
        </div>

        <div class="view-footer">
          <a href="<%= contextPath %>/board/request?page=<%= currentPage %><%= filterParams %>" class="btn-back-list">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"/></svg>
            목록으로
          </a>
          <% if (post.getMemberNo() == loginMemberNo && loginMemberNo > 0) { %>
          <a href="<%= contextPath %>/board/request/edit/<%= post.getPostNo() %>" class="btn-edit-post">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
            수정
          </a>
          <% } %>
        </div>
      </div>

      <!-- ════════ 댓글 섹션 ════════ -->
      <div class="comment-section">
        <div class="comment-header">
          💬 댓글 <span class="comment-count"><%= commentList != null ? commentList.size() : 0 %></span>
        </div>

        <!-- 댓글 작성 -->
        <% if (loginMemberNo > 0) { %>
        <div class="comment-write">
          <textarea id="commentInput" class="comment-textarea" placeholder="댓글을 입력하세요" rows="3"></textarea>
          <div class="comment-write-actions">
            <button type="button" class="btn-comment-submit" onclick="submitComment()">댓글 등록</button>
          </div>
        </div>
        <% } else { %>
        <div class="comment-login-notice">
          🔐 <a href="<%= contextPath %>/member/login?redirect=/board/request/view/<%= viewPostNo %>">로그인</a> 후 댓글을 작성할 수 있습니다.
        </div>
        <% } %>

        <!-- 댓글 목록 -->
        <div class="comment-list">
          <% if (commentList != null) {
               for (BoardCommentVO c : commentList) {
                 boolean isReply = c.getDepth() > 0;
                 boolean isMyComment = (c.getMemberNo() == loginMemberNo && loginMemberNo > 0);
          %>
          <div class="comment-item<%= isReply ? " reply" : "" %>" id="comment-<%= c.getCommentNo() %>">
            <div class="comment-item-header">
              <% if (isReply) { %><span class="reply-arrow">↳</span><% } %>
              <span class="comment-author"><%= org.springframework.web.util.HtmlUtils.htmlEscape(c.getNickname()) %></span>
              <span class="comment-date"><%= c.getTimeAgo() %></span>
              <% if (isMyComment) { %>
              <button type="button" class="comment-del-btn" onclick="deleteComment(<%= c.getCommentNo() %>)">삭제</button>
              <% } %>
            </div>
            <div class="comment-text"><%= org.springframework.web.util.HtmlUtils.htmlEscape(c.getContent()).replace("\n", "<br>") %></div>
            <% if (!isReply && loginMemberNo > 0) { %>
            <button type="button" class="reply-toggle-btn" onclick="toggleReply(<%= c.getCommentNo() %>)">↩ 답글</button>
            <div class="reply-write-wrap" id="replyWrap-<%= c.getCommentNo() %>">
              <textarea class="reply-textarea" id="replyInput-<%= c.getCommentNo() %>" placeholder="답글을 입력하세요" rows="2"></textarea>
              <button type="button" class="btn-reply-submit" onclick="submitReply(<%= c.getCommentNo() %>)">답글 등록</button>
            </div>
            <% } %>
          </div>
          <% } } %>
        </div>
      </div>

      <% } else { %>
      <div class="board-empty">
        <div class="empty-icon">📭</div>
        <p>존재하지 않는 게시글입니다.</p>
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
                   boolean isCurrent = (lp.getPostNo() == viewPostNo);
              %>
              <tr class="<%= isCurrent ? "current-row" : "" %>">
                <td class="col-no"><%= rowNum-- %></td>
                <td class="col-title">
                  <a class="post-title-link" href="<%= contextPath %>/board/request/view/<%= lp.getPostNo() %>?page=<%= currentPage %><%= filterParams %>">
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
            <a href="<%= contextPath %>/board/request/view/<%= viewPostNo %>?page=<%= currentPage - 1 %><%= filterParams %>" class="pg-btn">‹</a>
          <% } %>
          <% if (startPage > 1) { %>
            <a href="<%= contextPath %>/board/request/view/<%= viewPostNo %>?page=1<%= filterParams %>" class="pg-btn">1</a>
            <% if (startPage > 2) { %><span class="pg-ellipsis">···</span><% } %>
          <% } %>
          <% for (int i = startPage; i <= endPage; i++) { %>
            <% if (i == currentPage) { %>
              <span class="pg-btn active"><%= i %></span>
            <% } else { %>
              <a href="<%= contextPath %>/board/request/view/<%= viewPostNo %>?page=<%= i %><%= filterParams %>" class="pg-btn"><%= i %></a>
            <% } %>
          <% } %>
          <% if (endPage < totalPages) { %>
            <% if (endPage < totalPages - 1) { %><span class="pg-ellipsis">···</span><% } %>
            <a href="<%= contextPath %>/board/request/view/<%= viewPostNo %>?page=<%= totalPages %><%= filterParams %>" class="pg-btn"><%= totalPages %></a>
          <% } %>
          <% if (currentPage >= totalPages) { %>
            <span class="pg-btn disabled">›</span>
          <% } else { %>
            <a href="<%= contextPath %>/board/request/view/<%= viewPostNo %>?page=<%= currentPage + 1 %><%= filterParams %>" class="pg-btn">›</a>
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
var ctx = '<%= contextPath %>';
var postNo = <%= viewPostNo %>;

/* ── 추천/비추천 ── */
function doReaction(typCd) {
  fetch(ctx + '/board/request/react', {
    method: 'POST',
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'postNo=' + postNo + '&reactionTypCd=' + typCd
  }).then(function(r){ return r.json(); }).then(function(data) {
    if (!data.success) { alert(data.msg || '오류'); return; }
    document.getElementById('likeCount').textContent = data.likeCount;
    document.getElementById('dislikeCount').textContent = data.dislikeCount;
    document.getElementById('btnLike').classList.toggle('active', data.myReaction === '1');
    document.getElementById('btnDislike').classList.toggle('active', data.myReaction === '2');
  });
}

/* ── 댓글 등록 ── */
function submitComment() {
  var content = document.getElementById('commentInput').value.trim();
  if (!content) { alert('댓글을 입력해주세요.'); return; }
  fetch(ctx + '/board/request/comment/write', {
    method: 'POST',
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'postNo=' + postNo + '&content=' + encodeURIComponent(content)
  }).then(function(r){ return r.json(); }).then(function(data) {
    if (!data.success) { alert(data.msg || '오류'); return; }
    location.reload();
  });
}

/* ── 답글 토글 ── */
function toggleReply(commentNo) {
  var wrap = document.getElementById('replyWrap-' + commentNo);
  wrap.classList.toggle('open');
  if (wrap.classList.contains('open')) {
    document.getElementById('replyInput-' + commentNo).focus();
  }
}

/* ── 답글 등록 ── */
function submitReply(parentNo) {
  var content = document.getElementById('replyInput-' + parentNo).value.trim();
  if (!content) { alert('답글을 입력해주세요.'); return; }
  fetch(ctx + '/board/request/comment/write', {
    method: 'POST',
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'postNo=' + postNo + '&content=' + encodeURIComponent(content) + '&parentCommentNo=' + parentNo
  }).then(function(r){ return r.json(); }).then(function(data) {
    if (!data.success) { alert(data.msg || '오류'); return; }
    location.reload();
  });
}

/* ── 댓글 삭제 ── */
function deleteComment(commentNo) {
  if (!confirm('댓글을 삭제하시겠습니까?')) return;
  fetch(ctx + '/board/request/comment/delete', {
    method: 'POST',
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'commentNo=' + commentNo + '&postNo=' + postNo
  }).then(function(r){ return r.json(); }).then(function(data) {
    if (!data.success) { alert(data.msg || '오류'); return; }
    location.reload();
  });
}
</script>
</body>
</html>
