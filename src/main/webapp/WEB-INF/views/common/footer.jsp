<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<footer class="footer">
  <div class="footer-inner">
    <div class="footer-grid">
      <div class="footer-brand">
        <div class="footer-logo-area">
          <img src="${pageContext.request.contextPath}/images/maddit_logo3.png" alt="MADDIT" class="footer-logo-img" />
        </div>
        <p>무료 소프트웨어를 공유하는 커뮤니티입니다. 유용한 프로그램을 무료로 다운로드하세요.</p>
      </div>
      <div class="footer-col">
        <h4>Programs</h4>
        <a href="${pageContext.request.contextPath}/program/list">전체 프로그램</a>
        <a href="${pageContext.request.contextPath}/program/list?sort=popular">인기 프로그램</a>
        <a href="${pageContext.request.contextPath}/program/list?sort=latest">최신 프로그램</a>
      </div>
      <div class="footer-col">
        <h4>Community</h4>
        <a href="${pageContext.request.contextPath}/board/request">만들어 주세요</a>
        <a href="${pageContext.request.contextPath}/board/free">자유게시판</a>
        <a href="${pageContext.request.contextPath}/board/notice">공지사항</a>
      </div>
      <div class="footer-col">
        <h4>Info</h4>
        <a href="${pageContext.request.contextPath}/terms">이용약관</a>
        <a href="${pageContext.request.contextPath}/privacy">개인정보처리방침</a>
        <a href="mailto:maddit@maddit.co.kr">문의하기</a>
      </div>
    </div>
  </div>
  <div class="footer-bottom">
    <span>&copy; 2026 MADDIT. All rights reserved.</span>
    <div class="footer-bottom-links">
      <a href="${pageContext.request.contextPath}/terms">TERMS</a>
      <a href="${pageContext.request.contextPath}/privacy">PRIVACY</a>
    </div>
  </div>
</footer>
