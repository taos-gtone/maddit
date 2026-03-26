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
      <c:forEach var="cat" items="${progCategories}">
        <button class="chip">${cat.codeNm}</button>
      </c:forEach>
    </div>

    <div class="content-inner">

      <!-- 정렬 버튼 -->
      <div class="sort-bar">
        <button class="sort-btn" id="btn-popular" onclick="setSort('popular')">인기순</button>
        <button class="sort-btn" id="btn-latest"  onclick="setSort('latest')">최신순</button>
        <a href="${pageContext.request.contextPath}/program/list" class="sort-view-all">전체보기 ›</a>
      </div>

      <!-- 프로그램 그리드 (인기순/최신순 공통) -->
      <div id="prog-wrap">
        <%@ include file="/WEB-INF/views/home/popular.jsp" %>
      </div>

      <div class="section-divider"></div>

      <%@ include file="/WEB-INF/views/home/boards.jsp" %>

    </div>
  </main>

</div><!-- /page-wrapper -->

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/scripts.jsp" %>
</body>
</html>
