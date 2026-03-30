<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.maddit.vo.BoardPostVO" %>
<%@ page import="com.maddit.vo.BoardPostFileVO" %>
<%@ page import="com.maddit.vo.BoardPostFileThumbVO" %>
<%@ page import="com.maddit.vo.BoardCommentVO" %>
<%
  response.setHeader("Cache-Control", "no-store");
  response.setHeader("Pragma", "no-cache");
  response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/common/head.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board/free.css">
<style>
/* 썸네일 갤러리 */
.prog-thumbs {
  display:flex;gap:12px;flex-wrap:wrap;
  padding:20px 28px;border-bottom:1px solid var(--mid-gray);
}
.prog-thumb-item {
  overflow:hidden;border:1px solid var(--mid-gray);cursor:pointer;
  transition:transform var(--dur),box-shadow var(--dur);
}
.prog-thumb-item:hover { transform:translateY(-2px);box-shadow:var(--shadow-md); }
.prog-thumb-item img { display:block;height:120px;width:auto;object-fit:cover; }

/* 첨부파일 섹션 */
.prog-dl-trigger-section {
  background:var(--white);border:1px solid var(--black);
  overflow:hidden;margin-top:20px;
}
.prog-dl-trigger-header {
  padding:14px 24px;border-bottom:1px solid var(--mid-gray);
  font-size:15px;font-weight:800;color:var(--black);background:var(--light-gray);
}
.prog-dl-trigger-row {
  display:flex;align-items:center;gap:12px;
  padding:12px 24px;border-bottom:1px solid var(--light-gray);
  font-size:13px;font-weight:500;color:var(--black);transition:background var(--dur);
}
.prog-dl-trigger-row:last-child { border-bottom:none; }
.prog-dl-trigger-row:hover { background:var(--light-gray); }
.prog-dl-name { font-weight:600;overflow:hidden;text-overflow:ellipsis;white-space:nowrap; }
.prog-dl-size { color:var(--dim);font-size:12px;font-weight:600;white-space:nowrap; }
.prog-dl-cnt { color:var(--dim);font-size:12px;font-weight:600;white-space:nowrap; }
.prog-dl-btn {
  padding:6px 16px;font-size:13px;font-weight:800;
  background:var(--red);color:var(--white);border:none;
  cursor:pointer;transition:background var(--dur);white-space:nowrap;
}
.prog-dl-btn:hover { background:var(--black); }
.prog-dl-btn:disabled { background:var(--dim);cursor:default; }

/* 이미지 모달 */
.img-modal-overlay {
  display:none;position:fixed;inset:0;z-index:9999;
  background:rgba(0,0,0,.85);align-items:center;justify-content:center;cursor:zoom-out;
}
.img-modal-overlay.active { display:flex; }
.img-modal-inner { position:relative;max-width:90vw;max-height:90vh; }
.img-modal-inner img { display:block;max-width:90vw;max-height:85vh;object-fit:contain;box-shadow:0 8px 32px rgba(0,0,0,.4); }
.img-modal-close {
  position:absolute;top:-14px;right:-14px;width:32px;height:32px;
  background:var(--red);color:var(--white);border:none;font-size:18px;cursor:pointer;
  display:flex;align-items:center;justify-content:center;
}
.img-modal-close:hover { background:var(--black); }

/* 다운로드 팝업 — editorial */
.dl-popup-overlay { display:none;position:fixed;inset:0;z-index:10000;background:rgba(0,0,0,.6);align-items:center;justify-content:center; }
.dl-popup-overlay.active { display:flex; }
.dl-popup {
  background:var(--white);width:480px;max-width:92vw;
  border:1px solid var(--black);overflow:hidden;
  animation:dlPopupIn .2s var(--ease);
}
@keyframes dlPopupIn { from{opacity:0;transform:translateY(16px)} to{opacity:1;transform:translateY(0)} }

.dl-popup-header {
  display:flex;align-items:center;justify-content:space-between;
  padding:16px 24px;border-bottom:2px solid var(--black);
}
.dl-popup-title { font-size:16px;font-weight:900;color:var(--black); }
.dl-popup-close {
  width:28px;height:28px;border:1px solid var(--mid-gray);
  background:var(--white);color:var(--dark-gray);font-size:16px;cursor:pointer;
  display:flex;align-items:center;justify-content:center;
  transition:all var(--dur);
}
.dl-popup-close:hover { background:var(--black);color:var(--white);border-color:var(--black); }

.dl-popup-thumb {
  display:flex;gap:8px;padding:14px 24px;overflow-x:auto;
  border-bottom:1px solid var(--mid-gray);background:var(--light-gray);justify-content:center;
}
.dl-popup-thumb img { height:80px;width:auto;object-fit:cover;border:1px solid var(--mid-gray);flex-shrink:0; }

.dl-popup-ad {
  padding:14px 24px;border-bottom:1px solid var(--mid-gray);
  background:var(--off-white);text-align:center;min-height:90px;
  display:flex;align-items:center;justify-content:center;
}
.dl-popup-ad-placeholder {
  color:var(--dim);font-size:11px;font-weight:700;
  border:2px dashed var(--mid-gray);padding:16px 40px;width:100%;
  text-transform:uppercase;letter-spacing:1px;
}

.dl-popup-files { padding:4px 0;max-height:240px;overflow-y:auto; }
.dl-popup-file-row {
  display:flex;align-items:center;gap:10px;
  padding:10px 24px;border-bottom:1px solid var(--light-gray);
  font-size:13px;font-weight:500;color:var(--black);transition:background var(--dur);
}
.dl-popup-file-row:last-child { border-bottom:none; }
.dl-popup-file-row:hover { background:var(--light-gray); }
.dl-popup-file-name { flex:1;font-weight:600;overflow:hidden;text-overflow:ellipsis;white-space:nowrap; }
.dl-popup-file-size { color:var(--dim);font-size:12px;font-weight:600;white-space:nowrap; }
.dl-popup-file-btn {
  padding:6px 16px;font-size:13px;font-weight:800;
  background:var(--red);color:var(--white);border:none;
  cursor:pointer;white-space:nowrap;transition:background var(--dur);
}
.dl-popup-file-btn:hover { background:var(--black); }
.dl-popup-file-btn:disabled { background:var(--dim);cursor:default; }

/* 프로그레스 */
.dl-progress-area { display:none;padding:14px 24px;border-top:1px solid var(--mid-gray);background:var(--light-gray); }
.dl-progress-area.active { display:block; }
.dl-progress-bar-bg { width:100%;height:6px;background:var(--mid-gray);overflow:hidden; }
.dl-progress-bar-fill { height:100%;width:0%;background:var(--red);transition:width .15s ease; }
.dl-progress-info { display:flex;align-items:center;justify-content:space-between;margin-top:6px;font-size:12px;color:var(--dim); }
.dl-progress-status { font-weight:700; }
.dl-progress-status.done { color:var(--green); }
.dl-progress-status.error { color:var(--red); }

.dl-popup-footer { padding:12px 24px;border-top:1px solid var(--mid-gray);text-align:right;background:var(--light-gray); }
.dl-popup-footer-btn {
  padding:8px 20px;font-size:13px;font-weight:700;
  background:var(--white);color:var(--dark-gray);
  border:1px solid var(--mid-gray);cursor:pointer;
  transition:all var(--dur);
}
.dl-popup-footer-btn:hover { background:var(--black);color:var(--white);border-color:var(--black); }
</style>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
  String contextPath = request.getContextPath();

  BoardPostVO post = (BoardPostVO) request.getAttribute("post");
  @SuppressWarnings("unchecked")
  List<BoardPostFileVO> fileList = (List<BoardPostFileVO>) request.getAttribute("fileList");
  @SuppressWarnings("unchecked")
  List<BoardPostFileThumbVO> thumbList = (List<BoardPostFileThumbVO>) request.getAttribute("thumbList");
  @SuppressWarnings("unchecked")
  List<BoardCommentVO> commentList = (List<BoardCommentVO>) request.getAttribute("commentList");
  Long loginMemberNoObj = (Long) request.getAttribute("loginMemberNo");
  long loginMemberNo = (loginMemberNoObj != null) ? loginMemberNoObj : 0L;

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

<div class="page-wrapper">
  <main class="main-content">

    <div class="board-breadcrumb">
      <a href="<%= contextPath %>/">홈</a>
      <span class="bc-sep">›</span>
      <a href="<%= contextPath %>/program/list">프로그램 게시판</a>
      <span class="bc-sep">›</span>
      <span>상세보기</span>
    </div>

    <div class="content-inner">

      <% if (post != null) { %>

      <!-- ══ 게시글 본문 ══ -->
      <div class="view-card">
        <div class="view-header">
          <div class="view-title"><%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getTitle()) %></div>
          <div class="view-meta">
            <% if (post.getCatNm() != null) { %>
            <span class="view-meta-author cat-badge"><%= post.getCatNm() %></span>
            <span class="meta-dot">·</span>
            <% } %>
            <span style="font-weight:700;color:var(--black);"><%= post.getTimeAgo() %></span>
            <span class="meta-dot">·</span>
            <span style="font-weight:700;color:var(--black);">조회 <%= post.getViewCnt() %></span>
          </div>
        </div>

        <% if (thumbList != null && !thumbList.isEmpty()) { %>
        <div class="prog-thumbs">
          <% for (BoardPostFileThumbVO t : thumbList) { %>
          <div class="prog-thumb-item" onclick="openImgModal('<%= contextPath %>/upload<%= t.getFilePath() %>')">
            <img src="<%= contextPath %>/upload<%= t.getFilePath() %>" alt="썸네일">
          </div>
          <% } %>
        </div>
        <% } %>

        <div class="view-body"><%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getContent() != null ? post.getContent() : "").replace("\n", "<br>") %></div>

        <div class="view-footer">
          <a href="<%= contextPath %>/program/list?page=<%= currentPage %><%= filterParams %>" class="btn-back-list">← 목록으로</a>
        </div>
      </div>

      <!-- ══ 첨부파일 (다운로드 팝업 트리거) ══ -->
      <% if (fileList != null && !fileList.isEmpty()) { %>
      <div class="prog-dl-trigger-section">
        <div class="prog-dl-trigger-header">📎 첨부파일 (<%= fileList.size() %>)</div>
        <% for (BoardPostFileVO f : fileList) { %>
        <div class="prog-dl-trigger-row">
          <span class="prog-dl-name">📄 <%= org.springframework.web.util.HtmlUtils.htmlEscape(f.getOrgFileNm()) %></span>
          <span class="prog-dl-size"><%= f.getFileSizeFmt() %></span>
          <span class="prog-dl-cnt"><svg style="width:13px;height:13px;vertical-align:-2px;margin-right:2px;" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg> <%= f.getDownloadCnt() %></span>
          <button class="prog-dl-btn" onclick="openDlPopup(<%= f.getFileNo() %>)">다운로드</button>
        </div>
        <% } %>
      </div>
      <% } %>

      <!-- ══ 댓글 섹션 ══ -->
      <div class="comment-section">
        <div class="comment-header">
          💬 댓글 <span class="comment-count"><%= commentList != null ? commentList.size() : 0 %></span>
        </div>

        <% if (loginMemberNo > 0) { %>
        <div class="comment-write">
          <textarea id="commentInput" class="comment-textarea" placeholder="댓글을 입력하세요" rows="3"></textarea>
          <div class="comment-write-actions">
            <button type="button" class="btn-comment-submit" onclick="submitComment()">댓글 등록</button>
          </div>
        </div>
        <% } else { %>
        <div class="comment-login-notice">
          🔐 <a href="<%= contextPath %>/member/login?redirect=/program/<%= viewPostNo %>">로그인</a> 후 댓글을 작성할 수 있습니다.
        </div>
        <% } %>

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
        <div class="empty-icon">😶</div>
        <p>존재하지 않는 프로그램입니다.</p>
      </div>
      <% } %>

      <!-- ══ 하단 글목록 ══ -->
      <% if (postList != null && !postList.isEmpty()) { %>
      <div class="write-bottom-list">
        <div class="board-table-panel">
          <div class="write-list-header">
            <span class="write-list-title"><svg class="board-title-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg> 프로그램 게시판</span>
            <span class="board-count"><%= currentPage %> / <%= totalPages %> 페이지</span>
          </div>
          <table class="board-table">
            <thead>
              <tr>
                <th class="col-no">번호</th>
                <th style="width:80px;">카테고리</th>
                <th class="col-title">제목</th>
                <th class="col-date">작성일</th>
                <th class="col-views">조회</th>
                <th style="width:70px;">다운로드</th>
              </tr>
            </thead>
            <tbody>
              <% int rowNum = totalCount - (currentPage - 1) * 12;
                 for (BoardPostVO lp : postList) {
                   boolean isCurrent = (lp.getPostNo() == viewPostNo);
              %>
              <tr class="<%= isCurrent ? "current-row" : "" %>">
                <td class="col-no"><%= rowNum-- %></td>
                <td style="font-size:12px;color:var(--text-2);"><%= lp.getCatNm() != null ? lp.getCatNm() : "-" %></td>
                <td class="col-title">
                  <a class="post-title-link" href="<%= contextPath %>/program/<%= lp.getPostNo() %>?page=<%= currentPage %><%= filterParams %>">
                    <% if (isCurrent) { %><span class="current-marker">▸</span><% } %>
                    <span class="title-text"><%= org.springframework.web.util.HtmlUtils.htmlEscape(lp.getTitle()) %></span>
                  </a>
                </td>
                <td class="col-date"><%= lp.getTimeAgo() %></td>
                <td class="col-views"><%= lp.getViewCnt() %></td>
                <td style="font-size:12px;color:var(--text-3);"><% if (lp.getTotalDownloadCnt() > 0) { %><svg style="width:13px;height:13px;vertical-align:-2px;margin-right:2px;" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg><%= lp.getTotalDownloadCnt() %><% } else { %>-<% } %></td>
              </tr>
              <% } %>
            </tbody>
          </table>
        </div>

        <nav class="board-pagination">
          <% if (currentPage <= 1) { %>
            <span class="pg-btn disabled">‹</span>
          <% } else { %>
            <a href="<%= contextPath %>/program/<%= viewPostNo %>?page=<%= currentPage - 1 %><%= filterParams %>" class="pg-btn">‹</a>
          <% } %>
          <% if (startPage > 1) { %>
            <a href="<%= contextPath %>/program/<%= viewPostNo %>?page=1<%= filterParams %>" class="pg-btn">1</a>
            <% if (startPage > 2) { %><span class="pg-ellipsis">···</span><% } %>
          <% } %>
          <% for (int i = startPage; i <= endPage; i++) { %>
            <% if (i == currentPage) { %>
              <span class="pg-btn active"><%= i %></span>
            <% } else { %>
              <a href="<%= contextPath %>/program/<%= viewPostNo %>?page=<%= i %><%= filterParams %>" class="pg-btn"><%= i %></a>
            <% } %>
          <% } %>
          <% if (endPage < totalPages) { %>
            <% if (endPage < totalPages - 1) { %><span class="pg-ellipsis">···</span><% } %>
            <a href="<%= contextPath %>/program/<%= viewPostNo %>?page=<%= totalPages %><%= filterParams %>" class="pg-btn"><%= totalPages %></a>
          <% } %>
          <% if (currentPage >= totalPages) { %>
            <span class="pg-btn disabled">›</span>
          <% } else { %>
            <a href="<%= contextPath %>/program/<%= viewPostNo %>?page=<%= currentPage + 1 %><%= filterParams %>" class="pg-btn">›</a>
          <% } %>
        </nav>
      </div>
      <% } %>

    </div>
  </main>
</div>

<!-- 이미지 모달 -->
<div class="img-modal-overlay" id="imgModal" onclick="closeImgModal()">
  <div class="img-modal-inner" onclick="event.stopPropagation()">
    <button class="img-modal-close" onclick="closeImgModal()">&times;</button>
    <img id="imgModalImg" src="" alt="">
  </div>
</div>

<!-- 다운로드 팝업 -->
<div class="dl-popup-overlay" id="dlPopup" onclick="closeDlPopup()">
  <div class="dl-popup" onclick="event.stopPropagation()">
    <div class="dl-popup-header">
      <span class="dl-popup-title">📥 다운로드</span>
      <button class="dl-popup-close" onclick="closeDlPopup()">&times;</button>
    </div>
    <% if (thumbList != null && !thumbList.isEmpty()) { %>
    <div class="dl-popup-thumb">
      <% for (BoardPostFileThumbVO t : thumbList) { %>
      <img src="<%= contextPath %>/upload<%= t.getFilePath() %>" alt="썸네일">
      <% } %>
    </div>
    <% } %>
    <div class="dl-popup-ad">
      <div class="dl-popup-ad-placeholder">AD — 광고 영역</div>
    </div>
    <div class="dl-popup-files">
      <% if (fileList != null) { for (BoardPostFileVO f : fileList) { %>
      <div class="dl-popup-file-row" id="dlRow-<%= f.getFileNo() %>">
        <span class="dl-popup-file-name">📄 <%= org.springframework.web.util.HtmlUtils.htmlEscape(f.getOrgFileNm()) %></span>
        <span class="dl-popup-file-size"><%= f.getFileSizeFmt() %></span>
        <button class="dl-popup-file-btn" id="dlBtn-<%= f.getFileNo() %>"
                onclick="startDownload(<%= f.getFileNo() %>, '<%= contextPath %>/program/download/<%= f.getFileNo() %>', '<%= f.getOrgFileNm().replace("'", "\\'") %>')">다운로드</button>
      </div>
      <% } } %>
    </div>
    <div class="dl-progress-area" id="dlProgressArea">
      <div class="dl-progress-bar-bg"><div class="dl-progress-bar-fill" id="dlFill"></div></div>
      <div class="dl-progress-info">
        <span class="dl-progress-status" id="dlStatus"></span>
        <span id="dlPercent"></span>
      </div>
    </div>
    <div class="dl-popup-footer">
      <button class="dl-popup-footer-btn" onclick="closeDlPopup()">닫기</button>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/scripts.jsp" %>

<script>
var ctx = '<%= contextPath %>';
var postNo = <%= viewPostNo %>;

/* 이미지 모달 */
function openImgModal(src) {
  document.getElementById('imgModalImg').src = src;
  document.getElementById('imgModal').classList.add('active');
  document.body.style.overflow = 'hidden';
}
function closeImgModal() {
  document.getElementById('imgModal').classList.remove('active');
  document.body.style.overflow = '';
}

/* 다운로드 팝업 */
function openDlPopup(fileNo) {
  document.getElementById('dlPopup').classList.add('active');
  document.body.style.overflow = 'hidden';
  document.querySelectorAll('.dl-popup-file-row').forEach(function(r) { r.style.background = ''; });
  var target = document.getElementById('dlRow-' + fileNo);
  if (target) { target.style.background = '#eef4ff'; target.scrollIntoView({ block: 'nearest' }); }
}
function closeDlPopup() {
  document.getElementById('dlPopup').classList.remove('active');
  document.body.style.overflow = '';
}

/* 프로그레스 다운로드 */
function startDownload(fileNo, url, fileName) {
  var btn = document.getElementById('dlBtn-' + fileNo);
  var area = document.getElementById('dlProgressArea');
  var fill = document.getElementById('dlFill');
  var status = document.getElementById('dlStatus');
  var percent = document.getElementById('dlPercent');
  if (btn.disabled) return;
  document.querySelectorAll('.dl-popup-file-btn').forEach(function(b) { b.disabled = true; });
  btn.textContent = '다운로드 중...';
  area.classList.add('active');
  fill.style.width = '0%'; fill.style.background = '';
  status.textContent = '📄 ' + fileName + ' 준비 중...';
  status.className = 'dl-progress-status'; percent.textContent = '0%';

  fetch(url).then(function(response) {
    if (!response.ok) throw new Error(response.status === 403 ? '로그인이 필요합니다.' : '다운로드 실패');
    var total = parseInt(response.headers.get('Content-Length') || '0', 10);
    var loaded = 0, reader = response.body.getReader(), chunks = [];
    function read() {
      return reader.read().then(function(r) {
        if (r.done) return new Blob(chunks);
        chunks.push(r.value); loaded += r.value.length;
        if (total > 0) {
          var pct = Math.min(Math.round((loaded/total)*100), 100);
          fill.style.width = pct+'%'; percent.textContent = pct+'%';
          status.textContent = fmtSize(loaded)+' / '+fmtSize(total);
        } else { status.textContent = fmtSize(loaded)+' 수신 중...'; fill.style.width = '60%'; }
        return read();
      });
    }
    return read();
  }).then(function(blob) {
    fill.style.width='100%'; status.textContent='✅ 다운로드 완료 — '+fileName;
    status.className='dl-progress-status done'; percent.textContent='100%'; btn.textContent='완료';
    var a=document.createElement('a'); a.href=URL.createObjectURL(blob); a.download=fileName;
    document.body.appendChild(a); a.click(); document.body.removeChild(a); URL.revokeObjectURL(a.href);
    setTimeout(function(){ document.querySelectorAll('.dl-popup-file-btn').forEach(function(b){ b.disabled=false; if(b.textContent==='완료')b.textContent='다운로드'; }); }, 3000);
  }).catch(function(err) {
    fill.style.width='100%'; fill.style.background='#e94560';
    status.textContent='❌ '+(err.message||'다운로드 실패'); status.className='dl-progress-status error'; percent.textContent='';
    document.querySelectorAll('.dl-popup-file-btn').forEach(function(b){ b.disabled=false; }); btn.textContent='재시도';
    setTimeout(function(){ fill.style.background=''; }, 3000);
  });
}
function fmtSize(b) { if(b<1024) return b+' B'; if(b<1024*1024) return (b/1024).toFixed(1)+' KB'; return (b/(1024*1024)).toFixed(1)+' MB'; }

/* ═══ 댓글 ═══ */
function submitComment() {
  var content = document.getElementById('commentInput').value.trim();
  if (!content) { alert('댓글을 입력해주세요.'); return; }
  fetch(ctx + '/program/comment/write', {
    method: 'POST', headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'postNo=' + postNo + '&content=' + encodeURIComponent(content)
  }).then(function(r){ return r.json(); }).then(function(d) {
    if (!d.success) { alert(d.msg || '오류'); return; }
    location.reload();
  });
}

function toggleReply(commentNo) {
  var wrap = document.getElementById('replyWrap-' + commentNo);
  wrap.classList.toggle('open');
  if (wrap.classList.contains('open')) document.getElementById('replyInput-' + commentNo).focus();
}

function submitReply(parentNo) {
  var content = document.getElementById('replyInput-' + parentNo).value.trim();
  if (!content) { alert('답글을 입력해주세요.'); return; }
  fetch(ctx + '/program/comment/write', {
    method: 'POST', headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'postNo=' + postNo + '&content=' + encodeURIComponent(content) + '&parentCommentNo=' + parentNo
  }).then(function(r){ return r.json(); }).then(function(d) {
    if (!d.success) { alert(d.msg || '오류'); return; }
    location.reload();
  });
}

function deleteComment(commentNo) {
  if (!confirm('댓글을 삭제하시겠습니까?')) return;
  fetch(ctx + '/program/comment/delete', {
    method: 'POST', headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'commentNo=' + commentNo + '&postNo=' + postNo
  }).then(function(r){ return r.json(); }).then(function(d) {
    if (!d.success) { alert(d.msg || '오류'); return; }
    location.reload();
  });
}

document.addEventListener('keydown', function(e) {
  if (e.key === 'Escape') { closeImgModal(); closeDlPopup(); }
});
</script>
</body>
</html>
