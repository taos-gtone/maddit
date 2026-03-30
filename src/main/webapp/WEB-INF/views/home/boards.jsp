<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.maddit.vo.BoardPostVO" %>
<%
  @SuppressWarnings("unchecked")
  List<BoardPostVO> requestPosts = (List<BoardPostVO>) request.getAttribute("requestPosts");
  @SuppressWarnings("unchecked")
  List<BoardPostVO> freePosts = (List<BoardPostVO>) request.getAttribute("freePosts");
  @SuppressWarnings("unchecked")
  List<BoardPostVO> programBoardPosts = (List<BoardPostVO>) request.getAttribute("programBoardPosts");
  @SuppressWarnings("unchecked")
  List<BoardPostVO> noticePosts = (List<BoardPostVO>) request.getAttribute("noticePosts");
  String ctx = request.getContextPath();
%>

<!-- ===== 게시판 섹션 ===== -->
<section class="boards-wrap">

  <!-- 만들어 주세요 -->
  <div class="board-panel">
    <div class="board-panel-header">
      <h2 class="board-panel-title"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg> 만들어 주세요</h2>
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
      <h2 class="board-panel-title"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg> 자유게시판</h2>
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

  <!-- 프로그램 게시판 -->
  <div class="board-panel">
    <div class="board-panel-header">
      <h2 class="board-panel-title"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg> 프로그램 게시판</h2>
      <div class="board-panel-actions">
        <a href="<%= ctx %>/program/list" class="view-all">전체보기 ›</a>
      </div>
    </div>
    <ul class="board-list">
      <% if (programBoardPosts != null && !programBoardPosts.isEmpty()) {
           for (BoardPostVO p : programBoardPosts) { %>
      <li class="board-item">
        <a href="<%= ctx %>/program/<%= p.getPostNo() %>" class="board-item-body">
          <div class="board-item-title"><%= org.springframework.web.util.HtmlUtils.htmlEscape(p.getTitle()) %></div>
          <div class="board-item-meta">
            <%= org.springframework.web.util.HtmlUtils.htmlEscape(p.getNickname()) %>
            &middot; <%= p.getTimeAgo() %>
            <% if (p.getCommentCnt() > 0) { %>
            &middot; <span class="reply-cnt">💬 <%= p.getCommentCnt() %></span>
            <% } %>
            <% if (p.getTotalDownloadCnt() > 0) { %>
            &middot; <span class="reply-cnt"><svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="vertical-align:-1px"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg> <%= p.getTotalDownloadCnt() %></span>
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

  <!-- 공지사항 -->
  <div class="board-panel">
    <div class="board-panel-header">
      <h2 class="board-panel-title"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg> 공지사항</h2>
      <div class="board-panel-actions">
        <a href="<%= ctx %>/board/notice" class="view-all">전체보기 ›</a>
      </div>
    </div>
    <ul class="board-list">
      <% if (noticePosts != null && !noticePosts.isEmpty()) {
           for (BoardPostVO p : noticePosts) { %>
      <li class="board-item">
        <a href="<%= ctx %>/board/notice/view/<%= p.getPostNo() %>" class="board-item-body">
          <div class="board-item-title"><%= org.springframework.web.util.HtmlUtils.htmlEscape(p.getTitle()) %></div>
          <div class="board-item-meta">
            <%= p.getTimeAgo() %>
            <% if (p.getCommentCnt() > 0) { %>
            &middot; <span class="reply-cnt">💬 <%= p.getCommentCnt() %></span>
            <% } %>
          </div>
        </a>
      </li>
      <% } } else { %>
      <li class="board-item">
        <div class="board-item-body">
          <div class="board-item-meta" style="padding:20px 0;text-align:center;color:var(--text-3);">아직 공지사항이 없습니다.</div>
        </div>
      </li>
      <% } %>
    </ul>
  </div>

</section>
