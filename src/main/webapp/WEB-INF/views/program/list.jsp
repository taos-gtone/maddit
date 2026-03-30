<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.maddit.vo.BoardPostVO" %>
<%
  response.setHeader("Cache-Control", "no-store");
  response.setHeader("Pragma", "no-cache");
  response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/common/head.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board/free.css">
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
  String contextPath = request.getContextPath();

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

  String boardCatGbnCd = (String) request.getAttribute("boardCatGbnCd");
  String searchType    = (String) request.getAttribute("searchType");
  String searchKeyword = (String) request.getAttribute("searchKeyword");
  if (boardCatGbnCd == null) boardCatGbnCd = "";
  if (searchType == null) searchType = "all";
  if (searchKeyword == null) searchKeyword = "";

  String baseUrl = contextPath + "/program/list";
  String catParam = !boardCatGbnCd.isEmpty() ? "boardCatGbnCd=" + boardCatGbnCd : "";
  String filterParams = (!boardCatGbnCd.isEmpty() ? "&boardCatGbnCd=" + boardCatGbnCd : "")
      + (!"all".equals(searchType) ? "&searchType=" + searchType : "")
      + (!searchKeyword.isEmpty() ? "&searchKeyword=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8") : "");
%>

<!-- 사이드바 카테고리 active 표시 -->
<script>
document.addEventListener('DOMContentLoaded', function() {
  var catCd = '<%= boardCatGbnCd %>';
  // 모든 snav-item에서 active 제거 (홈 포함)
  document.querySelectorAll('.snav-item').forEach(function(el) {
    el.classList.remove('active');
  });
  // 카테고리가 있으면 해당 카테고리 메뉴에 active
  if (catCd) {
    document.querySelectorAll('.snav-tree-children .snav-child').forEach(function(el) {
      if (el.href && el.href.indexOf('boardCatGbnCd=' + catCd) > -1) {
        el.classList.add('active');
      }
    });
  } else {
    // 카테고리 없으면 프로그램 게시판 메뉴에 active
    document.querySelectorAll('.snav-item').forEach(function(el) {
      if (el.href && el.href.indexOf('/program/list') > -1 && !el.classList.contains('snav-child')) {
        el.classList.add('active');
      }
    });
  }
});
</script>

<div class="page-wrapper">
  <main class="main-content">

    <!-- 브레드크럼 -->
    <div class="board-breadcrumb">
      <a href="<%= contextPath %>/">홈</a>
      <span class="bc-sep">›</span>
      <a href="<%= contextPath %>/program/list">프로그램 게시판</a>
      <%
         String currentCatNm = null;
         if (!boardCatGbnCd.isEmpty()) {
           @SuppressWarnings("unchecked")
           java.util.List<com.maddit.vo.ComCodeDtlVO> cats =
               (java.util.List<com.maddit.vo.ComCodeDtlVO>) request.getAttribute("progCategories");
           if (cats != null) {
             for (com.maddit.vo.ComCodeDtlVO c : cats) {
               if (boardCatGbnCd.equals(c.getCodeId())) { currentCatNm = c.getCodeNm(); break; }
             }
           }
         }
         if (currentCatNm != null) { %>
      <span class="bc-sep">›</span>
      <span><%= currentCatNm %></span>
      <% } %>
    </div>

    <div class="content-inner">

      <%@ include file="/WEB-INF/views/common/hero.jsp" %>

      <!-- 게시판 헤더 -->
      <div class="board-header">
        <div class="board-header-left">
          <h1 class="board-title"><svg class="board-title-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg> 프로그램 게시판<% if (currentCatNm != null) { %><span class="board-cat-divider">/</span><span class="board-cat-tag"><%= currentCatNm %></span><% } %></h1>
          <span class="board-count">총 <%= totalCount %>개</span>
        </div>
      </div>

      <!-- 검색 바 -->
      <form class="board-search" action="<%= baseUrl %>" method="get">
        <input type="hidden" name="boardCatGbnCd" id="hiddenCat" value="<%= boardCatGbnCd %>">
        <input type="hidden" name="searchType" id="hiddenSearchType" value="<%= searchType %>">

        <div class="custom-select" id="catSelect">
          <button type="button" class="custom-select-btn">
            <span class="custom-select-label">전체 카테고리</span>
            <span class="custom-select-arrow">▾</span>
          </button>
          <ul class="custom-select-list">
            <li data-value="">전체 카테고리</li>
            <c:forEach var="cat" items="${progCategories}">
              <li data-value="${cat.codeId}">${cat.codeNm}</li>
            </c:forEach>
          </ul>
        </div>

        <div class="custom-select" id="searchTypeSelect">
          <button type="button" class="custom-select-btn">
            <span class="custom-select-label">제목+내용</span>
            <span class="custom-select-arrow">▾</span>
          </button>
          <ul class="custom-select-list">
            <li data-value="all">제목+내용</li>
            <li data-value="title">제목</li>
            <li data-value="content">내용</li>
          </ul>
        </div>

        <div class="search-input-wrap">
          <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요" value="<%= searchKeyword %>">
          <button type="submit" aria-label="검색">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="10" cy="10" r="8"/><line x1="16" y1="16" x2="22" y2="22"/></svg>
          </button>
        </div>
      </form>

      <script>
      (function() {
        function initCustomSelect(wrapId, hiddenId) {
          var wrap = document.getElementById(wrapId);
          var hidden = document.getElementById(hiddenId);
          var btn = wrap.querySelector('.custom-select-btn');
          var label = wrap.querySelector('.custom-select-label');
          var list = wrap.querySelector('.custom-select-list');
          var items = list.querySelectorAll('li');

          // 초기값 반영
          items.forEach(function(li) {
            if (li.getAttribute('data-value') === hidden.value) {
              label.textContent = li.textContent;
              li.classList.add('selected');
            }
          });

          btn.addEventListener('click', function(e) {
            e.preventDefault();
            // 다른 셀렉트 닫기
            document.querySelectorAll('.custom-select.open').forEach(function(el) {
              if (el !== wrap) el.classList.remove('open');
            });
            wrap.classList.toggle('open');
          });

          items.forEach(function(li) {
            li.addEventListener('click', function() {
              hidden.value = li.getAttribute('data-value');
              label.textContent = li.textContent;
              items.forEach(function(el) { el.classList.remove('selected'); });
              li.classList.add('selected');
              wrap.classList.remove('open');
            });
          });
        }

        // 바깥 클릭 시 닫기
        document.addEventListener('click', function(e) {
          document.querySelectorAll('.custom-select.open').forEach(function(el) {
            if (!el.contains(e.target)) el.classList.remove('open');
          });
        });

        initCustomSelect('catSelect', 'hiddenCat');
        initCustomSelect('searchTypeSelect', 'hiddenSearchType');
      })();
      </script>

      <!-- 게시글 목록 테이블 -->
      <div class="board-table-panel">
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
            <% if (postList != null && !postList.isEmpty()) {
                 int rowNum = totalCount - (currentPage - 1) * 12;
                 for (BoardPostVO post : postList) { %>
            <tr>
              <td class="col-no"><%= rowNum-- %></td>
              <td style="font-size:12px;color:var(--text-2);"><%= post.getCatNm() != null ? post.getCatNm() : "-" %></td>
              <td class="col-title">
                <a class="post-title-link" href="<%= contextPath %>/program/<%= post.getPostNo() %>?page=<%= currentPage %><%= filterParams %>">
                  <span class="title-text"><%= org.springframework.web.util.HtmlUtils.htmlEscape(post.getTitle()) %></span>
                  <% if (post.getCommentCnt() > 0) { %>
                  <span class="comment-cnt">[<%= post.getCommentCnt() %>]</span>
                  <% } %>
                </a>
              </td>
              <td class="col-date"><%= post.getTimeAgo() %></td>
              <td class="col-views"><%= post.getViewCnt() %></td>
              <td style="font-size:12px;color:var(--text-3);"><% if (post.getTotalDownloadCnt() > 0) { %><svg style="width:13px;height:13px;vertical-align:-2px;margin-right:2px;" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg><%= post.getTotalDownloadCnt() %><% } else { %>-<% } %></td>
            </tr>
            <% } } else { %>
            <tr>
              <td colspan="6">
                <div class="board-empty">
                  <div class="empty-icon">💻</div>
                  <% if (!searchKeyword.isEmpty()) { %>
                  <p>검색 결과가 없습니다.</p>
                  <% } else { %>
                  <p>등록된 프로그램이 없습니다.</p>
                  <% } %>
                </div>
              </td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>

      <!-- 페이지네이션 -->
      <nav class="board-pagination">
        <% if (currentPage <= 1) { %>
          <span class="pg-btn disabled">‹</span>
        <% } else { %>
          <a href="<%= baseUrl %>?page=<%= currentPage - 1 %><%= filterParams %>" class="pg-btn">‹</a>
        <% } %>
        <% if (startPage > 1) { %>
          <a href="<%= baseUrl %>?page=1<%= filterParams %>" class="pg-btn">1</a>
          <% if (startPage > 2) { %><span class="pg-ellipsis">···</span><% } %>
        <% } %>
        <% for (int i = startPage; i <= endPage; i++) { %>
          <% if (i == currentPage) { %>
            <span class="pg-btn active"><%= i %></span>
          <% } else { %>
            <a href="<%= baseUrl %>?page=<%= i %><%= filterParams %>" class="pg-btn"><%= i %></a>
          <% } %>
        <% } %>
        <% if (endPage < totalPages) { %>
          <% if (endPage < totalPages - 1) { %><span class="pg-ellipsis">···</span><% } %>
          <a href="<%= baseUrl %>?page=<%= totalPages %><%= filterParams %>" class="pg-btn"><%= totalPages %></a>
        <% } %>
        <% if (currentPage >= totalPages) { %>
          <span class="pg-btn disabled">›</span>
        <% } else { %>
          <a href="<%= baseUrl %>?page=<%= currentPage + 1 %><%= filterParams %>" class="pg-btn">›</a>
        <% } %>
      </nav>

    </div><!-- /content-inner -->
  </main>
</div><!-- /page-wrapper -->

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/scripts.jsp" %>
</body>
</html>
