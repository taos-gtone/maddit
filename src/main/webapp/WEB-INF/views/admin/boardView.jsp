<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.maddit.vo.BoardPostVO" %>
<%@ page import="com.maddit.vo.BoardCommentVO" %>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/admin/layout/head.jsp" %>
<style>
/* ── 게시글 보기 ── */
.adm-view-card {
  background: var(--adm-card);
  border: 1px solid var(--adm-border);
  border-radius: 10px;
  margin-bottom: 20px;
  overflow: hidden;
}
.adm-view-head {
  padding: 20px 24px 16px;
  border-bottom: 1px solid var(--adm-border);
}
.adm-view-title {
  font-size: 20px;
  font-weight: 700;
  color: var(--adm-txt);
  margin-bottom: 10px;
  line-height: 1.4;
}
.adm-view-meta {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  color: var(--adm-txt3);
  flex-wrap: wrap;
}
.adm-view-meta .meta-author { color: var(--adm-txt2); font-weight: 600; }
.adm-view-meta .meta-dot { color: var(--adm-border); }
.adm-view-body {
  padding: 24px;
  font-size: 14px;
  color: var(--adm-txt2);
  line-height: 1.8;
  min-height: 120px;
  white-space: pre-wrap;
  word-break: break-word;
}
.adm-view-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 14px 24px;
  border-top: 1px solid var(--adm-border);
  flex-wrap: wrap;
  gap: 8px;
}
.adm-view-actions { display: flex; gap: 8px; }
.adm-btn-back {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 6px 14px;
  font-size: 12px;
  font-weight: 600;
  color: var(--adm-txt2);
  background: transparent;
  border: 1px solid var(--adm-border);
  border-radius: 6px;
  cursor: pointer;
  text-decoration: none;
  transition: all .18s;
}
.adm-btn-back:hover { border-color: var(--adm-primary); color: var(--adm-primary); }
.adm-btn-action {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 6px 14px;
  font-size: 12px;
  font-weight: 600;
  border-radius: 6px;
  border: 1px solid var(--adm-border);
  background: transparent;
  color: var(--adm-txt2);
  cursor: pointer;
  transition: all .18s;
}
.adm-btn-action:hover { border-color: var(--adm-primary); color: var(--adm-primary); }
.adm-btn-action.danger:hover { border-color: var(--adm-danger); color: var(--adm-danger); }

/* 반응 */
.adm-reaction-bar {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 12px 24px;
  border-top: 1px solid var(--adm-border);
}
.adm-reaction-item {
  display: flex;
  align-items: center;
  gap: 5px;
  font-size: 13px;
  color: var(--adm-txt3);
  padding: 5px 12px;
  border-radius: 6px;
  background: rgba(255,255,255,.03);
  border: 1px solid var(--adm-border);
}

/* ── 댓글 섹션 ── */
.adm-comment-section {
  background: var(--adm-card);
  border: 1px solid var(--adm-border);
  border-radius: 10px;
  overflow: hidden;
}
.adm-comment-header {
  padding: 14px 20px;
  border-bottom: 1px solid var(--adm-border);
  font-size: 14px;
  font-weight: 700;
  color: var(--adm-txt);
}
.adm-comment-header .cnt { color: var(--adm-primary); margin-left: 4px; }
.adm-comment-list { padding: 8px 0; }
.adm-comment-item {
  padding: 12px 20px;
  border-bottom: 1px solid rgba(255,255,255,.04);
  transition: background .15s;
}
.adm-comment-item:last-child { border-bottom: none; }
.adm-comment-item:hover { background: rgba(255,255,255,.02); }
.adm-comment-item.reply {
  padding-left: 44px;
  background: rgba(255,255,255,.01);
  border-left: 2px solid var(--adm-border);
  margin-left: 20px;
}
.adm-comment-item-head {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 6px;
}
.reply-arrow { color: var(--adm-primary); font-size: 13px; }
.adm-comment-author { font-size: 13px; font-weight: 600; color: var(--adm-txt); }
.adm-comment-date  { font-size: 11px; color: var(--adm-txt3); }
.adm-comment-text  { font-size: 13px; color: var(--adm-txt2); line-height: 1.6; white-space: pre-wrap; word-break: break-word; }
.adm-comment-del {
  margin-left: auto;
  padding: 2px 8px;
  font-size: 11px;
  border-radius: 4px;
  border: 1px solid var(--adm-border);
  background: transparent;
  color: var(--adm-txt3);
  cursor: pointer;
  transition: all .18s;
}
.adm-comment-del:hover { border-color: var(--adm-danger); color: var(--adm-danger); }
.adm-comment-empty {
  padding: 32px;
  text-align: center;
  color: var(--adm-txt3);
  font-size: 13px;
}

/* 승인 배지 */
.adm-view-badge {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 2px 8px;
  border-radius: 4px;
  font-size: 11px;
  font-weight: 700;
}
</style>
<body class="admin-body">
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<%
  BoardPostVO post = (BoardPostVO) request.getAttribute("post");
  @SuppressWarnings("unchecked")
  List<BoardCommentVO> commentList = (List<BoardCommentVO>) request.getAttribute("commentList");

  String boardGbnCd    = (String) request.getAttribute("boardGbnCd");
  String searchType    = (String) request.getAttribute("searchType");
  String searchKeyword = (String) request.getAttribute("searchKeyword");
  Integer pageObj      = (Integer) request.getAttribute("currentPage");
  if (boardGbnCd    == null) boardGbnCd = "";
  if (searchType    == null) searchType = "all";
  if (searchKeyword == null) searchKeyword = "";
  int currentPage = (pageObj != null) ? pageObj : 1;

  String listUrl = "/maddit/admin/board/list?boardGbnCd=" + boardGbnCd
      + "&page=" + currentPage
      + (!"all".equals(searchType)    ? "&searchType=" + searchType : "")
      + (!searchKeyword.isEmpty()     ? "&searchKeyword=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8") : "");
%>

<div class="adm-content">

  <!-- 상단 타이틀 + 목록 버튼 -->
  <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;">
    <h1 class="adm-page-title" style="margin-bottom:0;">📄 게시글 상세</h1>
    <a href="<%= listUrl %>" class="adm-btn-back">← 목록으로</a>
  </div>

  <% if (post != null) { %>

  <!-- ── 게시글 본문 ── -->
  <div class="adm-view-card">
    <div class="adm-view-head">
      <div class="adm-view-title"><%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getTitle()) %></div>
      <div class="adm-view-meta">
        <span class="meta-author"><%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getNickname()) %></span>
        <span class="meta-dot">·</span>
        <span><%= post.getTimeAgo() %></span>
        <span class="meta-dot">·</span>
        <span>조회 <%= post.getViewCnt() %></span>
        <span class="meta-dot">·</span>
        <span>게시판 <%= post.getBoardGbnCd() %></span>
        <span class="meta-dot">·</span>
        <span class="adm-view-badge <%= "Y".equals(post.getApprovalYn()) ? "adm-badge-y" : "adm-badge-n" %>"
              id="viewApprovalBadge">
          <%= "Y".equals(post.getApprovalYn()) ? "✔ 승인" : "✖ 미승인" %>
        </span>
      </div>
    </div>

    <div class="adm-view-body"><%=
      org.springframework.web.util.HtmlUtils.htmlEscape(post.getContent() != null ? post.getContent() : "")
    %></div>

    <!-- 반응 수치 -->
    <div class="adm-reaction-bar">
      <div class="adm-reaction-item">❤️ 추천 <strong><%= post.getLikeCnt() %></strong></div>
      <div class="adm-reaction-item">👎 비추천 <strong><%= post.getDislikeCnt() %></strong></div>
      <div class="adm-reaction-item">💬 댓글 <strong><%= post.getCommentCnt() %></strong></div>
    </div>

    <!-- 하단 관리 버튼 -->
    <div class="adm-view-footer">
      <a href="<%= listUrl %>" class="adm-btn-back">← 목록으로</a>
      <div class="adm-view-actions">
        <% if ("02".equals(post.getBoardGbnCd())) { %>
          <a href="/maddit/admin/notice/edit/<%= post.getPostNo() %>" class="adm-btn-action">✏ 수정</a>
        <% } %>
        <button class="adm-btn-action" onclick="toggleApproval(<%= post.getPostNo() %>)">⚙ 승인 토글</button>
        <button class="adm-btn-action danger" onclick="deletePost(<%= post.getPostNo() %>)">🗑 게시글 삭제</button>
      </div>
    </div>
  </div>

  <!-- ── 댓글 / 대댓글 섹션 ── -->
  <div class="adm-comment-section">
    <div class="adm-comment-header">
      💬 댓글
      <span class="cnt"><%= commentList != null ? commentList.size() : 0 %></span>
    </div>
    <div class="adm-comment-list">
      <% if (commentList != null && !commentList.isEmpty()) {
           for (BoardCommentVO c : commentList) {
             boolean isReply = c.getDepth() > 0;
      %>
      <div class="adm-comment-item<%= isReply ? " reply" : "" %>" id="comment-<%= c.getCommentNo() %>">
        <div class="adm-comment-item-head">
          <% if (isReply) { %><span class="reply-arrow">↳</span><% } %>
          <span class="adm-comment-author"><%= org.springframework.web.util.HtmlUtils.htmlEscape(c.getNickname() != null ? c.getNickname() : "알수없음") %></span>
          <span class="adm-comment-date"><%= c.getTimeAgo() %></span>
          <button class="adm-comment-del" onclick="deleteComment(<%= c.getCommentNo() %>, <%= post.getPostNo() %>)">삭제</button>
        </div>
        <div class="adm-comment-text"><%= org.springframework.web.util.HtmlUtils.htmlEscape(c.getContent() != null ? c.getContent() : "") %></div>
      </div>
      <% } } else { %>
      <div class="adm-comment-empty">댓글이 없습니다.</div>
      <% } %>
    </div>
  </div>

  <% } else { %>
  <div class="adm-card" style="padding:40px;text-align:center;color:var(--adm-txt3);">
    존재하지 않는 게시글입니다.
  </div>
  <% } %>

</div>

<script>
var ctx = '/maddit';

function toggleApproval(postNo) {
  fetch(ctx + '/admin/board/approval', {
    method: 'POST',
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'postNo=' + postNo
  }).then(function(r){ return r.json(); }).then(function(d) {
    if (d.success) location.reload();
  });
}

function deletePost(postNo) {
  if (!confirm('게시글을 삭제하시겠습니까?')) return;
  fetch(ctx + '/admin/board/delete', {
    method: 'POST',
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'postNo=' + postNo
  }).then(function(r){ return r.json(); }).then(function(d) {
    if (d.success) location.href = '<%= listUrl %>';
  });
}

function deleteComment(commentNo, postNo) {
  if (!confirm('댓글을 삭제하시겠습니까?')) return;
  fetch(ctx + '/admin/board/comment/delete', {
    method: 'POST',
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'commentNo=' + commentNo + '&postNo=' + postNo
  }).then(function(r){ return r.json(); }).then(function(d) {
    if (d.success) {
      var el = document.getElementById('comment-' + commentNo);
      if (el) el.remove();
    }
  });
}
</script>
</body>
</html>
