<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.maddit.vo.BoardPostVO" %>
<%@ page import="com.maddit.vo.BoardPostFileVO" %>
<%@ page import="com.maddit.vo.BoardPostFileThumbVO" %>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/admin/layout/head.jsp" %>
<style>
.prog-view-card {
  background: var(--adm-card); border: 1px solid var(--adm-border);
  border-radius: 10px; margin-bottom: 20px; overflow: hidden;
}
.prog-view-head { padding: 20px 24px 16px; border-bottom: 1px solid var(--adm-border); }
.prog-view-title { font-size: 20px; font-weight: 700; color: var(--adm-txt); margin-bottom: 10px; line-height: 1.4; }
.prog-view-meta {
  display: flex; align-items: center; gap: 6px;
  font-size: 12px; color: var(--adm-txt3); flex-wrap: wrap;
}
.prog-view-meta .meta-cat {
  background: rgba(79,140,255,.15); color: var(--adm-primary);
  padding: 2px 8px; border-radius: 4px; font-weight: 600;
}
.prog-view-body {
  padding: 24px; font-size: 14px; color: var(--adm-txt2);
  line-height: 1.8; min-height: 120px; white-space: pre-wrap; word-break: break-word;
}
/* 썸네일 표시 (본문 위) */
.prog-view-thumbs {
  padding: 20px 24px; border-bottom: 1px solid var(--adm-border);
  display: flex; gap: 16px; flex-wrap: wrap;
}
.prog-view-thumb-item {
  position: relative; border-radius: 8px; overflow: hidden;
  border: 1px solid var(--adm-border); flex: none; cursor: pointer;
  transition: transform .18s, box-shadow .18s;
}
.prog-view-thumb-item:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,.3); }
.prog-view-thumb-item img { display: block; height: 120px; width: auto; object-fit: cover; }
/* 이미지 모달 */
.thumb-modal-overlay {
  display: none; position: fixed; inset: 0; z-index: 9999;
  background: rgba(0,0,0,.85); align-items: center; justify-content: center;
  cursor: zoom-out;
}
.thumb-modal-overlay.active { display: flex; }
.thumb-modal-inner { position: relative; max-width: 90vw; max-height: 90vh; }
.thumb-modal-inner img {
  display: block; max-width: 90vw; max-height: 85vh;
  object-fit: contain; border-radius: 8px;
  box-shadow: 0 8px 32px rgba(0,0,0,.5);
}
.thumb-modal-caption {
  text-align: center; color: #ccc; font-size: 13px;
  margin-top: 10px;
}
.thumb-modal-close {
  position: absolute; top: -12px; right: -12px;
  width: 32px; height: 32px; border-radius: 50%;
  background: var(--adm-danger); color: #fff; border: none;
  font-size: 16px; cursor: pointer; display: flex;
  align-items: center; justify-content: center;
  transition: transform .15s;
}
.thumb-modal-close:hover { transform: scale(1.1); }
.prog-view-thumb-label {
  position: absolute; bottom: 0; left: 0; right: 0; padding: 4px 8px;
  background: rgba(0,0,0,.6); color: #fff; font-size: 11px; text-align: center;
}
/* 파일 목록 */
.prog-file-section {
  background: var(--adm-card); border: 1px solid var(--adm-border);
  border-radius: 10px; margin-bottom: 20px; overflow: hidden;
}
.prog-file-header { padding: 14px 20px; border-bottom: 1px solid var(--adm-border); font-size: 14px; font-weight: 700; }
.prog-file-list-view { padding: 8px 0; }
.prog-file-row {
  display: flex; align-items: center; gap: 12px; padding: 10px 20px;
  border-bottom: 1px solid rgba(255,255,255,.04); font-size: 13px; color: var(--adm-txt2);
}
.prog-file-row:last-child { border-bottom: none; }
.prog-file-row:hover { background: rgba(255,255,255,.02); }
.prog-file-name { flex: 1; }
.prog-file-size { color: var(--adm-txt3); font-size: 12px; }
.prog-file-dl { color: var(--adm-txt3); font-size: 12px; }
.prog-file-btn {
  padding: 4px 12px; border-radius: 6px; font-size: 12px; font-weight: 600;
  background: var(--adm-primary); color: #fff; border: none; cursor: pointer;
  text-decoration: none; transition: background .18s;
}
.prog-file-btn:hover { background: #3d78e8; }
.prog-view-footer {
  display: flex; align-items: center; justify-content: space-between;
  padding: 14px 24px; border-top: 1px solid var(--adm-border); flex-wrap: wrap; gap: 8px;
}
.prog-view-actions { display: flex; gap: 8px; }
/* 버튼 통일 */
.prog-view-footer .adm-btn-back,
.prog-view-actions .adm-btn-action {
  display: inline-flex; align-items: center; gap: 4px;
  padding: 7px 16px; font-size: 13px; font-weight: 600;
  border-radius: 6px; border: 1px solid var(--adm-border);
  background: transparent; color: var(--adm-txt2);
  cursor: pointer; text-decoration: none; transition: all .18s;
}
.prog-view-footer .adm-btn-back:hover,
.prog-view-actions .adm-btn-action:hover { border-color: var(--adm-primary); color: var(--adm-primary); }
.prog-view-actions .adm-btn-action.danger:hover { border-color: var(--adm-danger); color: var(--adm-danger); }
</style>
<body class="admin-body">
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<%
  BoardPostVO post = (BoardPostVO) request.getAttribute("post");
  @SuppressWarnings("unchecked")
  List<BoardPostFileVO> fileList = (List<BoardPostFileVO>) request.getAttribute("fileList");
  @SuppressWarnings("unchecked")
  List<BoardPostFileThumbVO> thumbList = (List<BoardPostFileThumbVO>) request.getAttribute("thumbList");

  String boardCatGbnCd = (String) request.getAttribute("boardCatGbnCd");
  String searchType    = (String) request.getAttribute("searchType");
  String searchKeyword = (String) request.getAttribute("searchKeyword");
  Integer pageObj      = (Integer) request.getAttribute("currentPage");
  if (boardCatGbnCd == null) boardCatGbnCd = "";
  if (searchType == null)    searchType = "all";
  if (searchKeyword == null) searchKeyword = "";
  int currentPage = (pageObj != null) ? pageObj : 1;

  String listUrl = "/maddit/admin/program/list?boardCatGbnCd=" + boardCatGbnCd
      + "&page=" + currentPage
      + (!"all".equals(searchType) ? "&searchType=" + searchType : "")
      + (!searchKeyword.isEmpty() ? "&searchKeyword=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8") : "");
%>

<div class="adm-content">
  <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;">
    <h1 class="adm-page-title" style="margin-bottom:0;">📄 프로그램 상세</h1>
    <a href="<%= listUrl %>" class="adm-btn-back">← 목록으로</a>
  </div>

  <% if (post != null) { %>

  <div class="prog-view-card">
    <div class="prog-view-head">
      <div class="prog-view-title"><%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getTitle()) %></div>
      <div class="prog-view-meta">
        <% if (post.getCatNm() != null) { %>
        <span class="meta-cat"><%= post.getCatNm() %></span>
        <% } %>
        <span><%= post.getNickname() %></span>
        <span style="color:var(--adm-border);">·</span>
        <span><%= post.getTimeAgo() %></span>
        <span style="color:var(--adm-border);">·</span>
        <span>조회 <%= post.getViewCnt() %></span>
      </div>
    </div>

    <!-- 썸네일 이미지 (본문 위에 표시) -->
    <% if (thumbList != null && !thumbList.isEmpty()) { %>
    <div class="prog-view-thumbs">
      <% for (BoardPostFileThumbVO t : thumbList) { %>
      <div class="prog-view-thumb-item" onclick="openThumbModal('/upload<%= t.getFilePath() %>', '<%= t.getThumbTypNm() != null ? t.getThumbTypNm() : "썸네일" %>')">
        <img src="/upload<%= t.getFilePath() %>" alt="<%= t.getThumbTypNm() != null ? t.getThumbTypNm() : "썸네일" %>">
        <div class="prog-view-thumb-label"><%= t.getThumbTypNm() != null ? t.getThumbTypNm() : t.getThumbTypCd() %></div>
      </div>
      <% } %>
    </div>
    <% } %>

    <div class="prog-view-body"><%=
      org.springframework.web.util.HtmlUtils.htmlEscape(post.getContent() != null ? post.getContent() : "")
    %></div>

    <div class="prog-view-footer">
      <a href="<%= listUrl %>" class="adm-btn-back">← 목록으로</a>
      <div class="prog-view-actions">
        <a href="/maddit/admin/program/edit/<%= post.getPostNo() %>" class="adm-btn-action">✏️ 수정</a>
        <button class="adm-btn-action danger" onclick="deletePost(<%= post.getPostNo() %>)">🗑 삭제</button>
      </div>
    </div>
  </div>

  <!-- 첨부파일 섹션 -->
  <% if (fileList != null && !fileList.isEmpty()) { %>
  <div class="prog-file-section">
    <div class="prog-file-header">📎 첨부파일 (<%= fileList.size() %>)</div>
    <div class="prog-file-list-view">
      <% for (BoardPostFileVO f : fileList) { %>
      <div class="prog-file-row">
        <span class="prog-file-name">📄 <%= org.springframework.web.util.HtmlUtils.htmlEscape(f.getOrgFileNm()) %></span>
        <span class="prog-file-size"><%= f.getFileSizeFmt() %></span>
        <span class="prog-file-dl">⬇ <%= f.getDownloadCnt() %></span>
        <a href="/maddit/admin/program/download/<%= f.getFileNo() %>" class="prog-file-btn">다운로드</a>
      </div>
      <% } %>
    </div>
  </div>
  <% } %>

  <% } else { %>
  <div class="adm-card" style="padding:40px;text-align:center;color:var(--adm-txt3);">
    존재하지 않는 게시글입니다.
  </div>
  <% } %>
</div>

<!-- 이미지 모달 -->
<div class="thumb-modal-overlay" id="thumbModal" onclick="closeThumbModal()">
  <div class="thumb-modal-inner" onclick="event.stopPropagation()">
    <button class="thumb-modal-close" onclick="closeThumbModal()">&times;</button>
    <img id="thumbModalImg" src="" alt="">
    <div class="thumb-modal-caption" id="thumbModalCaption"></div>
  </div>
</div>

<script>
function openThumbModal(src, caption) {
  document.getElementById('thumbModalImg').src = src;
  document.getElementById('thumbModalCaption').textContent = caption || '';
  document.getElementById('thumbModal').classList.add('active');
  document.body.style.overflow = 'hidden';
}
function closeThumbModal() {
  document.getElementById('thumbModal').classList.remove('active');
  document.body.style.overflow = '';
}
document.addEventListener('keydown', function(e) {
  if (e.key === 'Escape') closeThumbModal();
});

var ctx = '/maddit';
function deletePost(postNo) {
  if (!confirm('정말 삭제하시겠습니까?')) return;
  fetch(ctx + '/admin/program/delete', {
    method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'},
    body:'postNo=' + postNo
  }).then(function(r){return r.json()}).then(function(d){
    if (d.success) location.href = '<%= listUrl %>';
  });
}
</script>
</body>
</html>
