<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.maddit.vo.BoardPostVO" %>
<%@ page import="com.maddit.vo.BoardPostFileVO" %>
<%@ page import="com.maddit.vo.BoardPostFileThumbVO" %>
<%@ page import="com.maddit.vo.ComCodeDtlVO" %>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/admin/layout/head.jsp" %>
<style>
.prog-write-card {
  background: var(--adm-card); border: 1px solid var(--adm-border);
  border-radius: 10px; padding: 28px; margin-bottom: 20px;
}
.prog-form-group { margin-bottom: 18px; }
.prog-form-label { display: block; font-size: 13px; font-weight: 600; color: var(--adm-txt2); margin-bottom: 6px; }
.prog-form-label .req { color: var(--adm-danger); }
.prog-form-input {
  width: 100%; padding: 10px 14px;
  background: var(--adm-bg); border: 1.5px solid var(--adm-border); border-radius: 8px;
  color: var(--adm-txt); font-size: 14px; font-family: inherit;
}
.prog-form-input:focus { outline: none; border-color: var(--adm-primary); }
.prog-form-textarea {
  width: 100%; padding: 12px 14px; min-height: 240px; resize: vertical;
  background: var(--adm-bg); border: 1.5px solid var(--adm-border); border-radius: 8px;
  color: var(--adm-txt); font-size: 14px; font-family: inherit; line-height: 1.7;
}
.prog-form-textarea:focus { outline: none; border-color: var(--adm-primary); }
.prog-form-select {
  padding: 10px 14px; background: var(--adm-bg); border: 1.5px solid var(--adm-border);
  border-radius: 8px; color: var(--adm-txt); font-size: 14px; font-family: inherit;
}
.prog-form-row { display: flex; gap: 16px; }
.prog-form-row > * { flex: 1; }
.prog-file-zone {
  border: 2px dashed var(--adm-border); border-radius: 8px; padding: 20px;
  text-align: center; color: var(--adm-txt3); font-size: 13px; cursor: pointer;
}
.prog-file-zone:hover { border-color: var(--adm-primary); }
.prog-file-zone input[type="file"] { display: none; }
.existing-item {
  display: flex; align-items: center; gap: 8px; padding: 8px 12px;
  background: rgba(255,255,255,.03); border-radius: 6px; margin-top: 6px;
  font-size: 12px; color: var(--adm-txt2);
}
.existing-item .remove-btn {
  margin-left: auto; color: var(--adm-danger); cursor: pointer; font-size: 13px;
}
.existing-thumb-img { width: 60px; height: 60px; border-radius: 6px; object-fit: cover; }
.thumb-row {
  display: flex; align-items: center; gap: 10px; padding: 8px 0;
  border-bottom: 1px solid rgba(255,255,255,.04);
}
.thumb-preview { width: 60px; height: 60px; border-radius: 6px; object-fit: cover; background: var(--adm-bg); }
.prog-actions { display: flex; justify-content: flex-end; gap: 10px; margin-top: 24px; }
.prog-btn-cancel {
  padding: 10px 20px; border-radius: 8px; font-size: 14px; font-weight: 600;
  background: transparent; border: 1px solid var(--adm-border); color: var(--adm-txt2);
  cursor: pointer; text-decoration: none;
}
.prog-btn-cancel:hover { border-color: var(--adm-primary); color: var(--adm-primary); }
.prog-btn-submit {
  padding: 10px 24px; border-radius: 8px; font-size: 14px; font-weight: 700;
  background: var(--adm-primary); border: none; color: #fff; cursor: pointer;
}
.prog-btn-submit:hover { background: #3d78e8; }
.add-thumb-btn {
  display: inline-flex; align-items: center; gap: 4px; padding: 5px 12px;
  border-radius: 6px; font-size: 12px; font-weight: 600;
  background: transparent; border: 1px solid var(--adm-border); color: var(--adm-txt2);
  cursor: pointer;
}
.add-thumb-btn:hover { border-color: var(--adm-primary); color: var(--adm-primary); }
</style>
<body class="admin-body">
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<%
  BoardPostVO post = (BoardPostVO) request.getAttribute("post");
  @SuppressWarnings("unchecked")
  List<BoardPostFileVO> fileList = (List<BoardPostFileVO>) request.getAttribute("fileList");
  @SuppressWarnings("unchecked")
  List<BoardPostFileThumbVO> thumbList = (List<BoardPostFileThumbVO>) request.getAttribute("thumbList");
  @SuppressWarnings("unchecked")
  List<ComCodeDtlVO> catCodeList = (List<ComCodeDtlVO>) request.getAttribute("catCodeList");
  @SuppressWarnings("unchecked")
  List<ComCodeDtlVO> thumbTypeList = (List<ComCodeDtlVO>) request.getAttribute("thumbTypeList");
%>

<div class="adm-content">
  <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;">
    <h1 class="adm-page-title" style="margin-bottom:0;">✏️ 프로그램 글 수정</h1>
    <a href="/maddit/admin/program/view/<%= post.getPostNo() %>" class="adm-btn-back">← 돌아가기</a>
  </div>

  <form action="/maddit/admin/program/edit/<%= post.getPostNo() %>" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
    <div class="prog-write-card">

      <!-- 카테고리 + 버전 -->
      <div class="prog-form-row">
        <div class="prog-form-group">
          <label class="prog-form-label">카테고리 <span class="req">*</span></label>
          <select name="boardCatGbnCd" class="prog-form-select" style="width:100%;" required>
            <option value="">선택하세요</option>
            <% if (catCodeList != null) { for (ComCodeDtlVO c : catCodeList) { %>
            <option value="<%= c.getCodeId() %>" <%= c.getCodeId().equals(post.getBoardCatGbnCd()) ? "selected" : "" %>><%= c.getCodeNm() %></option>
            <% } } %>
          </select>
        </div>
        <div class="prog-form-group">
          <label class="prog-form-label">버전</label>
          <input type="text" name="versionNm" class="prog-form-input" placeholder="예: v1.0.0">
        </div>
      </div>

      <!-- 제목 -->
      <div class="prog-form-group">
        <label class="prog-form-label">제목 <span class="req">*</span></label>
        <input type="text" name="title" class="prog-form-input" value="<%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getTitle()) %>" maxlength="200" required>
      </div>

      <!-- 내용 -->
      <div class="prog-form-group">
        <label class="prog-form-label">내용 <span class="req">*</span></label>
        <textarea name="content" class="prog-form-textarea" required><%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getContent() != null ? post.getContent() : "") %></textarea>
      </div>

      <!-- 기존 첨부파일 -->
      <div class="prog-form-group">
        <label class="prog-form-label">📎 기존 첨부파일</label>
        <% if (fileList != null && !fileList.isEmpty()) {
             for (BoardPostFileVO f : fileList) { %>
        <div class="existing-item" id="file-<%= f.getFileNo() %>">
          📄 <%= org.springframework.web.util.HtmlUtils.htmlEscape(f.getOrgFileNm()) %>
          <span style="color:var(--adm-txt3);">(<%= f.getFileSizeFmt() %>)</span>
          <span class="remove-btn" onclick="markDeleteFile(<%= f.getFileNo() %>)">✕ 삭제</span>
        </div>
        <% } } else { %>
        <div style="font-size:12px;color:var(--adm-txt3);padding:8px 0;">첨부파일 없음</div>
        <% } %>
      </div>

      <!-- 새 파일 추가 -->
      <div class="prog-form-group">
        <label class="prog-form-label">📎 새 파일 추가</label>
        <div class="prog-file-zone" onclick="document.getElementById('newFileInput').click()">
          <input type="file" id="newFileInput" name="newFiles" multiple>
          클릭하여 파일을 선택하세요
        </div>
      </div>

      <!-- 기존 썸네일 -->
      <div class="prog-form-group">
        <label class="prog-form-label">🖼️ 기존 썸네일</label>
        <% if (thumbList != null && !thumbList.isEmpty()) {
             for (BoardPostFileThumbVO t : thumbList) { %>
        <div class="existing-item" id="thumb-<%= t.getThumbNo() %>">
          <img class="existing-thumb-img" src="/upload<%= t.getFilePath() %>" alt="썸네일">
          <span><%= t.getThumbTypNm() != null ? t.getThumbTypNm() : t.getThumbTypCd() %></span>
          <span class="remove-btn" onclick="markDeleteThumb(<%= t.getThumbNo() %>)">✕ 삭제</span>
        </div>
        <% } } else { %>
        <div style="font-size:12px;color:var(--adm-txt3);padding:8px 0;">썸네일 없음</div>
        <% } %>
      </div>

      <!-- 새 썸네일 추가 -->
      <div class="prog-form-group">
        <label class="prog-form-label">🖼️ 새 썸네일 추가</label>
        <div id="newThumbSection">
          <div class="thumb-row">
            <select name="newThumbTypCds" class="prog-form-select" style="width:140px;">
              <% if (thumbTypeList != null) { for (ComCodeDtlVO t : thumbTypeList) { %>
              <option value="<%= t.getCodeId() %>"><%= t.getCodeNm() %></option>
              <% } } %>
            </select>
            <input type="file" name="newThumbFiles" accept="image/*" onchange="previewThumb(this)">
            <img class="thumb-preview" style="display:none;" alt="미리보기">
          </div>
        </div>
        <button type="button" class="add-thumb-btn" onclick="addNewThumbRow()" style="margin-top:8px;">+ 썸네일 추가</button>
      </div>

    </div>

    <!-- 삭제 대상 hidden -->
    <div id="deleteFileInputs"></div>
    <div id="deleteThumbInputs"></div>

    <div class="prog-actions">
      <a href="/maddit/admin/program/view/<%= post.getPostNo() %>" class="prog-btn-cancel">취소</a>
      <button type="submit" class="prog-btn-submit">수정 완료</button>
    </div>
  </form>
</div>

<script>
var thumbTypeOptions = '';
<% if (thumbTypeList != null) { for (ComCodeDtlVO t : thumbTypeList) { %>
thumbTypeOptions += '<option value="<%= t.getCodeId() %>"><%= t.getCodeNm() %></option>';
<% } } %>

function markDeleteFile(fileNo) {
  if (!confirm('이 파일을 삭제하시겠습니까?')) return;
  document.getElementById('file-' + fileNo).style.display = 'none';
  var inp = document.createElement('input');
  inp.type = 'hidden'; inp.name = 'deleteFileNos'; inp.value = fileNo;
  document.getElementById('deleteFileInputs').appendChild(inp);
}

function markDeleteThumb(thumbNo) {
  if (!confirm('이 썸네일을 삭제하시겠습니까?')) return;
  document.getElementById('thumb-' + thumbNo).style.display = 'none';
  var inp = document.createElement('input');
  inp.type = 'hidden'; inp.name = 'deleteThumbNos'; inp.value = thumbNo;
  document.getElementById('deleteThumbInputs').appendChild(inp);
}

function previewThumb(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    var img = input.parentNode.querySelector('.thumb-preview');
    reader.onload = function(e) { img.src = e.target.result; img.style.display = 'block'; };
    reader.readAsDataURL(input.files[0]);
  }
}

function addNewThumbRow() {
  var section = document.getElementById('newThumbSection');
  var row = document.createElement('div');
  row.className = 'thumb-row';
  row.innerHTML =
    '<select name="newThumbTypCds" class="prog-form-select" style="width:140px;">' + thumbTypeOptions + '</select>' +
    '<input type="file" name="newThumbFiles" accept="image/*" onchange="previewThumb(this)">' +
    '<img class="thumb-preview" style="display:none;" alt="미리보기">' +
    '<span style="color:var(--adm-danger);cursor:pointer;font-size:14px;" onclick="this.parentNode.remove()">✕</span>';
  section.appendChild(row);
}

function validateForm() {
  var title = document.querySelector('input[name="title"]').value.trim();
  var content = document.querySelector('textarea[name="content"]').value.trim();
  if (!title) { alert('제목을 입력해주세요.'); return false; }
  if (!content) { alert('내용을 입력해주세요.'); return false; }
  return true;
}
</script>
</body>
</html>
