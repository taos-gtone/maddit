<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.maddit.vo.ComCodeDtlVO" %>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/admin/layout/head.jsp" %>
<style>
.prog-write-card {
  background: var(--adm-card);
  border: 1px solid var(--adm-border);
  border-radius: 10px;
  padding: 28px;
  margin-bottom: 20px;
}
.prog-form-group { margin-bottom: 18px; }
.prog-form-label { display: block; font-size: 13px; font-weight: 600; color: var(--adm-txt2); margin-bottom: 6px; }
.prog-form-label .req { color: var(--adm-danger); }
.prog-form-input {
  width: 100%; padding: 10px 14px;
  background: var(--adm-bg); border: 1.5px solid var(--adm-border); border-radius: 8px;
  color: var(--adm-txt); font-size: 14px; font-family: inherit; transition: border-color .18s;
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
  transition: border-color .18s;
}
.prog-file-zone:hover { border-color: var(--adm-primary); }
.prog-file-zone input[type="file"] { display: none; }
.prog-file-list { margin-top: 10px; }
.prog-file-item {
  display: flex; align-items: center; gap: 8px; padding: 6px 10px;
  background: rgba(255,255,255,.03); border-radius: 6px; margin-top: 6px; font-size: 12px; color: var(--adm-txt2);
}
.prog-file-item .file-remove { color: var(--adm-danger); cursor: pointer; margin-left: auto; }
.thumb-section { margin-top: 10px; }
.thumb-row {
  display: flex; align-items: center; gap: 10px; padding: 8px 0;
  border-bottom: 1px solid rgba(255,255,255,.04);
}
.thumb-preview { width: 60px; height: 60px; border-radius: 6px; object-fit: cover; background: var(--adm-bg); }
.prog-actions {
  display: flex; justify-content: flex-end; gap: 10px; margin-top: 24px;
}
.prog-btn-cancel {
  padding: 10px 20px; border-radius: 8px; font-size: 14px; font-weight: 600;
  background: transparent; border: 1px solid var(--adm-border); color: var(--adm-txt2);
  cursor: pointer; text-decoration: none; transition: all .18s;
}
.prog-btn-cancel:hover { border-color: var(--adm-primary); color: var(--adm-primary); }
.prog-btn-submit {
  padding: 10px 24px; border-radius: 8px; font-size: 14px; font-weight: 700;
  background: var(--adm-primary); border: none; color: #fff; cursor: pointer; transition: background .18s;
}
.prog-btn-submit:hover { background: #3d78e8; }
.add-thumb-btn {
  display: inline-flex; align-items: center; gap: 4px; padding: 5px 12px;
  border-radius: 6px; font-size: 12px; font-weight: 600;
  background: transparent; border: 1px solid var(--adm-border); color: var(--adm-txt2);
  cursor: pointer; transition: all .18s;
}
.add-thumb-btn:hover { border-color: var(--adm-primary); color: var(--adm-primary); }
</style>
<body class="admin-body">
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<%
  @SuppressWarnings("unchecked")
  List<ComCodeDtlVO> catCodeList = (List<ComCodeDtlVO>) request.getAttribute("catCodeList");
  @SuppressWarnings("unchecked")
  List<ComCodeDtlVO> thumbTypeList = (List<ComCodeDtlVO>) request.getAttribute("thumbTypeList");
%>

<div class="adm-content">
  <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;">
    <h1 class="adm-page-title" style="margin-bottom:0;">✏️ 프로그램 글 작성</h1>
    <a href="/maddit/admin/program/list" class="adm-btn-back">← 목록으로</a>
  </div>

  <form action="/maddit/admin/program/write" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
    <div class="prog-write-card">

      <!-- 카테고리 + 버전 -->
      <div class="prog-form-row">
        <div class="prog-form-group">
          <label class="prog-form-label">카테고리 <span class="req">*</span></label>
          <select name="boardCatGbnCd" class="prog-form-select" style="width:100%;" required>
            <option value="">선택하세요</option>
            <% if (catCodeList != null) { for (ComCodeDtlVO c : catCodeList) { %>
            <option value="<%= c.getCodeId() %>"><%= c.getCodeNm() %></option>
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
        <input type="text" name="title" class="prog-form-input" placeholder="프로그램 이름을 입력하세요" maxlength="200" required>
      </div>

      <!-- 내용 -->
      <div class="prog-form-group">
        <label class="prog-form-label">내용 <span class="req">*</span></label>
        <textarea name="content" class="prog-form-textarea" placeholder="프로그램 설명을 입력하세요" required></textarea>
      </div>

      <!-- 첨부파일 -->
      <div class="prog-form-group">
        <label class="prog-form-label">📎 첨부파일 (프로그램 파일)</label>
        <div class="prog-file-zone" onclick="document.getElementById('fileInput').click()">
          <input type="file" id="fileInput" name="files" multiple onchange="showFileList(this)">
          클릭하여 파일을 선택하세요 (zip, exe, msi 등)
        </div>
        <div class="prog-file-list" id="fileList"></div>
      </div>

      <!-- 썸네일 -->
      <div class="prog-form-group">
        <label class="prog-form-label">🖼️ 썸네일 이미지</label>
        <div class="thumb-section" id="thumbSection">
          <div class="thumb-row" data-idx="0">
            <select name="thumbTypCds" class="prog-form-select" style="width:140px;">
              <% if (thumbTypeList != null) { for (ComCodeDtlVO t : thumbTypeList) { %>
              <option value="<%= t.getCodeId() %>"><%= t.getCodeNm() %></option>
              <% } } %>
            </select>
            <input type="file" name="thumbFiles" accept="image/*" onchange="previewThumb(this)">
            <img class="thumb-preview" style="display:none;" alt="미리보기">
          </div>
        </div>
        <button type="button" class="add-thumb-btn" onclick="addThumbRow()" style="margin-top:8px;">+ 썸네일 추가</button>
      </div>
    </div>

    <div class="prog-actions">
      <a href="/maddit/admin/program/list" class="prog-btn-cancel">취소</a>
      <button type="submit" class="prog-btn-submit">등록하기</button>
    </div>
  </form>
</div>

<script>
var thumbTypeOptions = '';
<% if (thumbTypeList != null) { for (ComCodeDtlVO t : thumbTypeList) { %>
thumbTypeOptions += '<option value="<%= t.getCodeId() %>"><%= t.getCodeNm() %></option>';
<% } } %>

function showFileList(input) {
  var list = document.getElementById('fileList');
  list.innerHTML = '';
  for (var i = 0; i < input.files.length; i++) {
    var f = input.files[i];
    var size = f.size < 1024*1024 ? (f.size/1024).toFixed(1)+' KB' : (f.size/(1024*1024)).toFixed(1)+' MB';
    list.innerHTML += '<div class="prog-file-item">📄 ' + f.name + ' <span style="color:var(--adm-txt3);">(' + size + ')</span></div>';
  }
}

function previewThumb(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    var img = input.parentNode.querySelector('.thumb-preview');
    reader.onload = function(e) {
      img.src = e.target.result;
      img.style.display = 'block';
    };
    reader.readAsDataURL(input.files[0]);
  }
}

var thumbIdx = 1;
function addThumbRow() {
  var section = document.getElementById('thumbSection');
  var row = document.createElement('div');
  row.className = 'thumb-row';
  row.setAttribute('data-idx', thumbIdx);
  row.innerHTML =
    '<select name="thumbTypCds" class="prog-form-select" style="width:140px;">' + thumbTypeOptions + '</select>' +
    '<input type="file" name="thumbFiles" accept="image/*" onchange="previewThumb(this)">' +
    '<img class="thumb-preview" style="display:none;" alt="미리보기">' +
    '<span style="color:var(--adm-danger);cursor:pointer;font-size:14px;" onclick="this.parentNode.remove()">✕</span>';
  section.appendChild(row);
  thumbIdx++;
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
