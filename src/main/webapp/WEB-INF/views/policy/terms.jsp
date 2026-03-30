<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/common/head.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/policy.css">
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
  String contextPath = request.getContextPath();
%>

<div class="page-wrapper">
  <main class="main-content">

    <div class="policy-breadcrumb">
      <a href="<%= contextPath %>/">홈</a>
      <span class="bc-sep">›</span>
      <span>이용약관</span>
    </div>

    <div class="content-inner">

      <%@ include file="/WEB-INF/views/common/hero.jsp" %>

    <div class="policy-card">
    <div class="policy-container">

      <div class="policy-header">
        <h1 class="policy-title">이용약관</h1>
        <div class="policy-meta">시행일: 2026년 1월 1일 | 최종 수정일: 2026년 3월 1일</div>
      </div>

      <div class="policy-nav">
        <span class="policy-nav-label">바로가기</span>
        <a href="#section1" class="policy-nav-link">제1조 목적</a>
        <a href="#section2" class="policy-nav-link">제2조 정의</a>
        <a href="#section3" class="policy-nav-link">제3조 약관의 효력</a>
        <a href="#section4" class="policy-nav-link">제4조 서비스 제공</a>
        <a href="#section5" class="policy-nav-link">제5조 회원가입</a>
        <a href="#section6" class="policy-nav-link">제6조 회원의 의무</a>
        <a href="#section7" class="policy-nav-link">제7조 서비스 이용 제한</a>
        <a href="#section8" class="policy-nav-link">제8조 저작권</a>
        <a href="#section9" class="policy-nav-link">제9조 면책조항</a>
        <a href="#section10" class="policy-nav-link">제10조 분쟁해결</a>
      </div>

      <div class="policy-body">

        <section class="policy-section" id="section1">
          <h2>제1조 (목적)</h2>
          <p>이 약관은 MADDIT(이하 "회사")이 운영하는 웹사이트(이하 "사이트")에서 제공하는 소프트웨어 공유 및 커뮤니티 서비스(이하 "서비스")의 이용에 관한 조건 및 절차, 회사와 회원 간의 권리와 의무, 기타 필요한 사항을 규정함을 목적으로 합니다.</p>
        </section>

        <section class="policy-section" id="section2">
          <h2>제2조 (정의)</h2>
          <ol>
            <li><strong>"서비스"</strong>라 함은 회사가 사이트를 통해 제공하는 소프트웨어 다운로드, 게시판, 커뮤니티 기능 등 일체의 서비스를 말합니다.</li>
            <li><strong>"회원"</strong>이라 함은 이 약관에 동의하고 회원가입을 완료하여 서비스를 이용하는 자를 말합니다.</li>
            <li><strong>"비회원"</strong>이라 함은 회원가입을 하지 않고 서비스를 이용하는 자를 말합니다.</li>
            <li><strong>"게시물"</strong>이라 함은 회원이 서비스를 이용하면서 게시한 글, 댓글, 파일 등의 정보를 말합니다.</li>
          </ol>
        </section>

        <section class="policy-section" id="section3">
          <h2>제3조 (약관의 효력 및 변경)</h2>
          <ol>
            <li>이 약관은 서비스 화면에 게시하거나 기타의 방법으로 회원에게 공지함으로써 효력이 발생합니다.</li>
            <li>회사는 관련 법령을 위배하지 않는 범위에서 이 약관을 개정할 수 있으며, 개정 시 적용일자 및 개정사유를 명시하여 사이트에 공지합니다.</li>
            <li>변경된 약관에 동의하지 않는 회원은 서비스 이용을 중단하고 탈퇴할 수 있습니다.</li>
          </ol>
        </section>

        <section class="policy-section" id="section4">
          <h2>제4조 (서비스의 제공)</h2>
          <p>회사는 다음의 서비스를 제공합니다.</p>
          <ul>
            <li>소프트웨어 정보 게시 및 다운로드 서비스</li>
            <li>커뮤니티 게시판 서비스 (자유게시판, 만들어 주세요, 공지사항)</li>
            <li>회원 간 정보 공유 서비스</li>
            <li>기타 회사가 추가 개발하거나 제휴를 통해 제공하는 서비스</li>
          </ul>
        </section>

        <section class="policy-section" id="section5">
          <h2>제5조 (회원가입)</h2>
          <ol>
            <li>회원가입은 이용자가 약관에 동의한 후 가입 신청을 하고, 회사가 이를 승인함으로써 성립합니다.</li>
            <li>회사는 다음 각 호에 해당하는 신청에 대하여 승인을 거부하거나 취소할 수 있습니다.
              <ul>
                <li>실명이 아닌 정보 또는 타인의 정보를 이용한 경우</li>
                <li>허위의 정보를 기재하거나 필수 항목을 누락한 경우</li>
                <li>기타 회원으로 등록하는 것이 회사의 기술상 현저히 지장이 있는 경우</li>
              </ul>
            </li>
          </ol>
        </section>

        <section class="policy-section" id="section6">
          <h2>제6조 (회원의 의무)</h2>
          <p>회원은 다음 행위를 하여서는 안 됩니다.</p>
          <ul>
            <li>타인의 정보를 도용하거나 허위 정보를 등록하는 행위</li>
            <li>서비스를 이용하여 불법적인 소프트웨어를 배포하는 행위</li>
            <li>다른 이용자의 개인정보를 수집, 저장, 공개하는 행위</li>
            <li>회사의 지적재산권, 제3자의 지적재산권을 침해하는 행위</li>
            <li>회사의 서비스 운영을 고의로 방해하는 행위</li>
            <li>공공질서 및 미풍양속에 반하는 내용의 게시물을 등록하는 행위</li>
            <li>기타 관계 법령에 위배되는 행위</li>
          </ul>
        </section>

        <section class="policy-section" id="section7">
          <h2>제7조 (서비스 이용 제한)</h2>
          <ol>
            <li>회사는 회원이 제6조의 의무를 위반하거나 서비스의 정상적인 운영을 방해한 경우, 사전 통보 없이 서비스 이용을 제한하거나 회원 자격을 상실시킬 수 있습니다.</li>
            <li>회원은 이용 제한 조치에 대하여 이의가 있는 경우 이의 신청을 할 수 있으며, 회사는 이를 검토하여 정당한 사유가 있다고 판단되면 서비스 이용을 재개합니다.</li>
          </ol>
        </section>

        <section class="policy-section" id="section8">
          <h2>제8조 (저작권 및 지적재산권)</h2>
          <ol>
            <li>서비스에서 제공하는 콘텐츠의 저작권은 해당 저작자에게 귀속됩니다.</li>
            <li>회원이 서비스 내에 게시한 게시물의 저작권은 해당 회원에게 귀속되며, 회사는 서비스 운영 목적 범위 내에서 이를 사용할 수 있습니다.</li>
            <li>회사가 제작한 사이트 디자인, 로고, 레이아웃 등의 저작권은 회사에 귀속됩니다.</li>
          </ol>
        </section>

        <section class="policy-section" id="section9">
          <h2>제9조 (면책조항)</h2>
          <ol>
            <li>회사는 천재지변, 전쟁, 기간통신사업자의 서비스 중지 등 불가항력적인 사유로 서비스를 제공할 수 없는 경우 책임을 지지 않습니다.</li>
            <li>회사는 이용자의 귀책사유로 인한 서비스 이용 장애에 대하여 책임을 지지 않습니다.</li>
            <li>회사는 서비스를 통해 다운로드하거나 취득한 소프트웨어 및 자료로 인한 손해에 대하여 책임을 지지 않습니다. 이용자는 자신의 판단과 책임하에 소프트웨어를 이용하여야 합니다.</li>
          </ol>
        </section>

        <section class="policy-section" id="section10">
          <h2>제10조 (분쟁해결)</h2>
          <ol>
            <li>회사와 회원 간에 발생한 분쟁에 관한 소송은 대한민국 법률을 준거법으로 합니다.</li>
            <li>서비스 이용과 관련하여 분쟁이 발생한 경우, 양 당사자는 분쟁의 해결을 위해 성실히 협의합니다.</li>
          </ol>
        </section>

      </div><!-- /policy-body -->

      <div class="policy-footer">
        <a href="<%= contextPath %>/privacy" class="policy-other-link">개인정보처리방침 보기 ›</a>
      </div>

    </div><!-- /policy-container -->
    </div><!-- /policy-card -->

    </div><!-- /content-inner -->
  </main>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/scripts.jsp" %>
</body>
</html>
