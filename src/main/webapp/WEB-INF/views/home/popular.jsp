<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.maddit.vo.ProgramVO, java.util.List" %>
<%
  List<ProgramVO> popularList = (List<ProgramVO>) request.getAttribute("popularList");
  String[] rankClass = {"rank-1","rank-2","rank-3","rank-4","rank-5"};
%>

<!-- ===== 인기 프로그램 ===== -->
<section class="prog-section">
  <div class="prog-section-header">
    <h2 class="prog-section-title"><span class="section-icon">🔥</span> 인기 프로그램</h2>
    <a href="${pageContext.request.contextPath}/program/list?sort=popular" class="view-all">전체보기 ›</a>
  </div>

  <div class="prog-grid">
    <% if (popularList != null) {
         for (int i = 0; i < popularList.size(); i++) {
           ProgramVO p = popularList.get(i);
           String dlFmt  = String.format("%,d", p.getDownloadCnt());
           String rClass = (i < rankClass.length) ? rankClass[i] : "rank-5";
    %>
    <div class="prog-card" onclick="location.href='${pageContext.request.contextPath}/program/<%= p.getProgNo() %>'">
      <div class="prog-thumb" style="background:<%= p.getProgColor() %>">
        <span class="thumb-icon"><%= p.getProgIcon() %></span>
        <span class="thumb-rank <%= rClass %>">#<%= i + 1 %></span>
        <% if (i == 0) { %>
        <span class="thumb-badge badge-hot">HOT</span>
        <% } %>
      </div>
      <div class="prog-meta">
        <div class="prog-avatar" style="background:<%= p.getProgColor() %>"><%= p.getProgIcon() %></div>
        <div class="prog-info">
          <div class="prog-title"><%= p.getProgName() %></div>
          <div class="prog-desc"><%= p.getProgDesc() %></div>
          <div class="prog-stats">
            <span class="prog-cat"><%= p.getProgCategory() %></span>
            <span class="prog-dl">⬇ <%= dlFmt %></span>
          </div>
        </div>
      </div>
    </div>
    <% } } %>
  </div>
</section>
