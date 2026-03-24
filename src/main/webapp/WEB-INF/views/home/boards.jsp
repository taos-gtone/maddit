<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.maddit.vo.BoardPostVO" %>
<%
  @SuppressWarnings("unchecked")
  List<BoardPostVO> requestPosts = (List<BoardPostVO>) request.getAttribute("requestPosts");
  @SuppressWarnings("unchecked")
  List<BoardPostVO> freePosts = (List<BoardPostVO>) request.getAttribute("freePosts");
  String ctx = request.getContextPath();
%>

<!-- ===== 게시판 섹션 ===== -->
<section class="boards-wrap">

  <!-- 만들어 주세요 -->
  <div class="board-panel">
    <div class="board-panel-header">
      <h2 class="board-panel-title">✏️ 만들어 주세요</h2>
      <div class="board-panel-actions">
        <a href="<%= ctx %>/board/request" class="view-all">전체보기 ›</a>
        <a href="<%= ctx %>/board/request/write" class="btn-write">
          <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
          글쓰기
        </a>
      </div>
    </div>
    <ul class="board-list">
      <% if (requestPosts != null && !requestPosts.isEmpty()) {
           for (BoardPostVO p : requestPosts) { %>
      <li class="board-item">
        <a href="<%= ctx %>/board/request/view/<%= p.getPostNo() %>" class="board-item-body">
          <div class="board-item-title"><%= org.springframework.web.util.HtmlUtils.htmlEscape(p.getTitle()) %></div>
          <div class="board-item-meta">
            <%= org.springframework.web.util.HtmlUtils.htmlEscape(p.getNickname()) %>
            &middot; <%= p.getTimeAgo() %>
            <% if (p.getCommentCnt() > 0) { %>
            &middot; <span class="reply-cnt">💬 <%= p.getCommentCnt() %></span>
            <% } %>
          </div>
        </a>
      </li>
      <% } } else { %>
      <li class="board-item">
        <div class="board-item-body">
          <div class="board-item-meta" style="padding:20px 0;text-align:center;color:var(--text-3);">아직 게시글이 없습니다.</div>
        </div>
      </li>
      <% } %>
    </ul>
  </div>

  <!-- 자유게시판 -->
  <div class="board-panel">
    <div class="board-panel-header">
      <h2 class="board-panel-title">💬 자유게시판</h2>
      <div class="board-panel-actions">
        <a href="<%= ctx %>/board/free" class="view-all">전체보기 ›</a>
        <a href="<%= ctx %>/board/free/write" class="btn-write">
          <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
          글쓰기
        </a>
      </div>
    </div>
    <ul class="board-list">
      <% if (freePosts != null && !freePosts.isEmpty()) {
           for (BoardPostVO p : freePosts) { %>
      <li class="board-item">
        <a href="<%= ctx %>/board/free/view/<%= p.getPostNo() %>" class="board-item-body">
          <div class="board-item-title"><%= org.springframework.web.util.HtmlUtils.htmlEscape(p.getTitle()) %></div>
          <div class="board-item-meta">
            <%= org.springframework.web.util.HtmlUtils.htmlEscape(p.getNickname()) %>
            &middot; <%= p.getTimeAgo() %>
            <% if (p.getCommentCnt() > 0) { %>
            &middot; <span class="reply-cnt">💬 <%= p.getCommentCnt() %></span>
            <% } %>
          </div>
        </a>
      </li>
      <% } } else { %>
      <li class="board-item">
        <div class="board-item-body">
          <div class="board-item-meta" style="padding:20px 0;text-align:center;color:var(--text-3);">아직 게시글이 없습니다.</div>
        </div>
      </li>
      <% } %>
    </ul>
  </div>

</section>
