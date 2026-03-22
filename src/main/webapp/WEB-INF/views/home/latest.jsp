<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.maddit.vo.ProgramVO, java.util.List" %>
<%
  List<ProgramVO> latestList = (List<ProgramVO>) request.getAttribute("latestList");
  String ctx = request.getContextPath();
%>

<!-- ===== 최신 프로그램 ===== -->
<section class="prog-section">
  <div class="prog-section-header">
    <h2 class="prog-section-title"><span class="section-icon">🆕</span> 최신 프로그램</h2>
    <a href="<%= ctx %>/program/list?sort=new" class="view-all">전체보기 ›</a>
  </div>

  <div class="prog-grid">
    <% if (latestList != null) {
         for (int i = 0; i < latestList.size(); i++) {
           ProgramVO p = latestList.get(i);
           String dlFmt = String.format("%,d", p.getDownloadCnt());
    %>
    <div class="prog-card" onclick="location.href='<%= ctx %>/program/<%= p.getProgNo() %>'">
      <div class="prog-thumb" style="background:<%= p.getProgColor() %>">
        <span class="thumb-icon"><%= p.getProgIcon() %></span>
        <% if ("Y".equals(p.getIsNew())) { %>
        <span class="thumb-badge badge-new">NEW</span>
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
            <span class="prog-date"><%= p.getRegDate() %></span>
          </div>
        </div>
      </div>
    </div>
    <% } } %>
  </div>
</section>
