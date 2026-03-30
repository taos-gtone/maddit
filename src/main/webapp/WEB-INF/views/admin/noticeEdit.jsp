<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.maddit.vo.BoardPostVO" %>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/admin/layout/head.jsp" %>
<style>
.adm-write-card {
  background: var(--adm-card);
  border: 1px solid var(--adm-border);
  border-radius: 10px;
  padding: 28px;
}
.adm-write-card .adm-form-group { margin-bottom: 20px; }
.adm-write-card .adm-form-label { font-size: 13px; font-weight: 700; color: var(--adm-txt); margin-bottom: 8px; }
.adm-write-card .adm-form-input { font-size: 14px; }
.adm-write-textarea {
  width: 100%;
  min-height: 320px;
  padding: 14px;
  background: var(--adm-bg);
  border: 1.5px solid var(--adm-border);
  border-radius: 8px;
  color: var(--adm-txt);
  font-size: 14px;
  font-family: inherit;
  line-height: 1.7;
  resize: vertical;
  transition: border-color .18s;
}
.adm-write-textarea:focus { outline: none; border-color: var(--adm-primary); }
.adm-write-textarea::placeholder { color: var(--adm-txt3); }
.adm-write-actions {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 10px;
  margin-top: 20px;
}
.adm-btn-cancel {
  padding: 10px 20px;
  font-size: 13px;
  font-weight: 600;
  color: var(--adm-txt2);
  background: transparent;
  border: 1px solid var(--adm-border);
  border-radius: 8px;
  cursor: pointer;
  text-decoration: none;
  transition: all .18s;
}
.adm-btn-cancel:hover { border-color: var(--adm-txt2); color: var(--adm-txt); }
.adm-btn-submit {
  padding: 10px 24px;
  font-size: 13px;
  font-weight: 700;
  color: #fff;
  background: var(--adm-primary);
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background .18s;
}
.adm-btn-submit:hover { background: #3d78e8; }
</style>
<body class="admin-body">
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<%
  BoardPostVO post = (BoardPostVO) request.getAttribute("post");
%>

<div class="adm-content">
  <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;">
    <h1 class="adm-page-title" style="margin-bottom:0;">📝 공지사항 수정</h1>
    <a href="/maddit/admin/board/view/<%= post.getPostNo() %>?boardGbnCd=02" class="adm-btn-cancel">← 돌아가기</a>
  </div>

  <form class="adm-write-card" action="/maddit/admin/notice/edit/<%= post.getPostNo() %>" method="post">
    <div class="adm-form-group">
      <label class="adm-form-label">제목</label>
      <input type="text" name="title" class="adm-form-input"
             value="<%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getTitle()) %>"
             required maxlength="200" autofocus>
    </div>
    <div class="adm-form-group">
      <label class="adm-form-label">내용</label>
      <textarea name="content" class="adm-write-textarea" required><%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getContent() != null ? post.getContent() : "") %></textarea>
    </div>
    <div class="adm-write-actions">
      <a href="/maddit/admin/board/view/<%= post.getPostNo() %>?boardGbnCd=02" class="adm-btn-cancel">취소</a>
      <button type="submit" class="adm-btn-submit">수정 완료</button>
    </div>
  </form>
</div>

</body>
</html>
