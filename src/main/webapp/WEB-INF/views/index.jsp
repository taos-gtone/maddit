<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  response.setHeader("Cache-Control", "no-store");
  response.setHeader("Pragma", "no-cache");
  response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/common/head.jsp" %>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- ===== MAIN WRAPPER ===== -->
<div class="page-wrapper">

  <!-- ===== CONTENT ===== -->
  <main class="main-content" id="main">

    <!-- 카테고리 칩바 -->
    <div class="chips-bar">
      <button class="chip active">전체</button>
      <button class="chip">생산성</button>
      <button class="chip">유틸리티</button>
      <button class="chip">보안</button>
      <button class="chip">이미지 편집</button>
      <button class="chip">개발도구</button>
      <button class="chip">파일관리</button>
      <button class="chip">무료</button>
      <button class="chip">오픈소스</button>
      <button class="chip">Windows</button>
      <button class="chip">Mac</button>
    </div>

    <div class="content-inner">

      <%@ include file="/WEB-INF/views/home/latest.jsp" %>

      <div class="section-divider"></div>

      <%@ include file="/WEB-INF/views/home/popular.jsp" %>

      <div class="section-divider"></div>

      <%@ include file="/WEB-INF/views/home/boards.jsp" %>

    </div>
  </main>

</div><!-- /page-wrapper -->

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/scripts.jsp" %>
</body>
</html>
