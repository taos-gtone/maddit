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

<div class="page-wrapper">
  <main class="main-content" id="main">

    <!-- Category chips -->
    <div class="chips-bar" id="chipsBar">
      <button class="chip active" data-cat="" onclick="filterByCategory(this)">전체</button>
      <c:forEach var="cat" items="${progCategories}">
        <button class="chip" data-cat="${cat.codeId}" onclick="filterByCategory(this)">${cat.codeNm}</button>
      </c:forEach>
    </div>

    <div class="content-inner">

      <%@ include file="/WEB-INF/views/common/hero.jsp" %>

      <!-- Sort -->
      <div class="sort-bar">
        <button class="sort-btn" id="btn-popular" onclick="setSort('popular')">인기순</button>
        <button class="sort-btn" id="btn-latest"  onclick="setSort('latest')">최신순</button>
        <a href="${pageContext.request.contextPath}/program/list" class="sort-view-all">전체보기 ›</a>
      </div>

      <!-- Programs grid -->
      <div id="prog-wrap">
        <%@ include file="/WEB-INF/views/home/popular.jsp" %>
      </div>

      <div class="section-divider"></div>

      <%@ include file="/WEB-INF/views/home/boards.jsp" %>

    </div>
  </main>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/scripts.jsp" %>

<script>
var ctxPath = '${pageContext.request.contextPath}';

function filterByCategory(el) {
  document.querySelectorAll('#chipsBar .chip').forEach(function(c) { c.classList.remove('active'); });
  el.classList.add('active');
  var cat = el.getAttribute('data-cat') || '';
  _fetchPrograms(cat, _currentSort);
}
</script>
</body>
</html>
