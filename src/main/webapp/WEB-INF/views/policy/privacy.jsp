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
      <span>개인정보처리방침</span>
    </div>

    <div class="content-inner">

      <%@ include file="/WEB-INF/views/common/hero.jsp" %>

    <div class="policy-card">
    <div class="policy-container">

      <div class="policy-header">
        <h1 class="policy-title">개인정보처리방침</h1>
        <div class="policy-meta">시행일: 2026년 1월 1일 | 최종 수정일: 2026년 3월 1일</div>
      </div>

      <div class="policy-nav">
        <span class="policy-nav-label">바로가기</span>
        <a href="#section1" class="policy-nav-link">제1조 총칙</a>
        <a href="#section2" class="policy-nav-link">제2조 수집 항목</a>
        <a href="#section3" class="policy-nav-link">제3조 수집 목적</a>
        <a href="#section4" class="policy-nav-link">제4조 보유 기간</a>
        <a href="#section5" class="policy-nav-link">제5조 제3자 제공</a>
        <a href="#section6" class="policy-nav-link">제6조 위탁</a>
        <a href="#section7" class="policy-nav-link">제7조 이용자 권리</a>
        <a href="#section8" class="policy-nav-link">제8조 쿠키</a>
        <a href="#section9" class="policy-nav-link">제9조 안전성 확보</a>
        <a href="#section10" class="policy-nav-link">제10조 책임자</a>
      </div>

      <div class="policy-body">

        <section class="policy-section" id="section1">
          <h2>제1조 (총칙)</h2>
          <p>MADDIT(이하 "회사")은 이용자의 개인정보를 중요시하며, 「개인정보 보호법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 등 관련 법령을 준수하고 있습니다. 회사는 개인정보처리방침을 통하여 이용자가 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.</p>
        </section>

        <section class="policy-section" id="section2">
          <h2>제2조 (수집하는 개인정보 항목)</h2>
          <p>회사는 서비스 제공을 위해 다음의 개인정보를 수집합니다.</p>
          <div class="policy-table-wrap">
            <table class="policy-table">
              <thead>
                <tr>
                  <th>구분</th>
                  <th>수집 항목</th>
                  <th>수집 방법</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>회원가입 (필수)</td>
                  <td>이메일, 비밀번호, 닉네임</td>
                  <td>회원가입 폼</td>
                </tr>
                <tr>
                  <td>서비스 이용 (자동)</td>
                  <td>IP 주소, 접속 일시, 브라우저 정보, 서비스 이용 기록</td>
                  <td>자동 수집</td>
                </tr>
                <tr>
                  <td>게시물 작성</td>
                  <td>게시글 내용, 댓글 내용, 작성 IP</td>
                  <td>게시판 이용</td>
                </tr>
              </tbody>
            </table>
          </div>
        </section>

        <section class="policy-section" id="section3">
          <h2>제3조 (개인정보의 수집 및 이용 목적)</h2>
          <p>수집한 개인정보는 다음의 목적을 위해 이용됩니다.</p>
          <ul>
            <li><strong>회원 관리:</strong> 회원제 서비스 이용에 따른 본인 확인, 개인 식별, 부정 이용 방지</li>
            <li><strong>서비스 제공:</strong> 소프트웨어 다운로드 서비스, 커뮤니티 기능 제공</li>
            <li><strong>서비스 개선:</strong> 신규 서비스 개발, 통계 분석, 서비스 품질 향상</li>
            <li><strong>고지 사항 전달:</strong> 약관 변경, 서비스 변경 등 필수 안내 사항 전달</li>
          </ul>
        </section>

        <section class="policy-section" id="section4">
          <h2>제4조 (개인정보의 보유 및 이용 기간)</h2>
          <p>회사는 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 관련 법령에 의하여 보존할 필요가 있는 경우에는 해당 법령에서 정한 기간 동안 보존합니다.</p>
          <div class="policy-table-wrap">
            <table class="policy-table">
              <thead>
                <tr>
                  <th>보존 항목</th>
                  <th>보존 근거</th>
                  <th>보존 기간</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>계약 또는 청약철회 기록</td>
                  <td>전자상거래법</td>
                  <td>5년</td>
                </tr>
                <tr>
                  <td>대금결제 및 재화 공급 기록</td>
                  <td>전자상거래법</td>
                  <td>5년</td>
                </tr>
                <tr>
                  <td>소비자 불만 또는 분쟁처리 기록</td>
                  <td>전자상거래법</td>
                  <td>3년</td>
                </tr>
                <tr>
                  <td>웹사이트 방문 기록</td>
                  <td>통신비밀보호법</td>
                  <td>3개월</td>
                </tr>
              </tbody>
            </table>
          </div>
        </section>

        <section class="policy-section" id="section5">
          <h2>제5조 (개인정보의 제3자 제공)</h2>
          <p>회사는 이용자의 개인정보를 제3자에게 제공하지 않습니다. 다만, 다음의 경우에는 예외로 합니다.</p>
          <ul>
            <li>이용자가 사전에 동의한 경우</li>
            <li>법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우</li>
          </ul>
        </section>

        <section class="policy-section" id="section6">
          <h2>제6조 (개인정보 처리 위탁)</h2>
          <p>회사는 현재 개인정보 처리를 외부에 위탁하고 있지 않습니다. 향후 위탁이 필요한 경우 위탁 대상자와 위탁 업무 내용을 이용자에게 사전 고지하고 필요한 동의를 받겠습니다.</p>
        </section>

        <section class="policy-section" id="section7">
          <h2>제7조 (이용자 및 법정대리인의 권리와 행사 방법)</h2>
          <p>이용자(또는 법정대리인)는 언제든지 다음의 권리를 행사할 수 있습니다.</p>
          <ul>
            <li>개인정보 열람 요구</li>
            <li>개인정보 오류 정정 요구</li>
            <li>개인정보 삭제 요구</li>
            <li>개인정보 처리 정지 요구</li>
          </ul>
          <p>위 권리 행사는 회사에 대해 이메일을 통해 하실 수 있으며, 회사는 지체 없이 조치하겠습니다.</p>
        </section>

        <section class="policy-section" id="section8">
          <h2>제8조 (쿠키의 운용 및 거부)</h2>
          <ol>
            <li>회사는 이용자에게 개별적인 맞춤 서비스를 제공하기 위해 쿠키(cookie)를 사용합니다.</li>
            <li>쿠키는 웹사이트 운영에 이용되는 서버가 이용자의 브라우저에 보내는 소량의 텍스트 파일로, 이용자의 컴퓨터에 저장됩니다.</li>
            <li>이용자는 쿠키 설치에 대한 선택권을 가지고 있습니다. 웹브라우저 설정에서 쿠키를 허용하거나 거부할 수 있습니다.</li>
            <li>쿠키 저장을 거부할 경우 일부 서비스 이용에 어려움이 있을 수 있습니다.</li>
          </ol>
        </section>

        <section class="policy-section" id="section9">
          <h2>제9조 (개인정보의 안전성 확보 조치)</h2>
          <p>회사는 이용자의 개인정보를 안전하게 관리하기 위하여 다음과 같은 조치를 취하고 있습니다.</p>
          <ul>
            <li><strong>비밀번호 암호화:</strong> 회원의 비밀번호는 BCrypt 알고리즘으로 일방향 암호화하여 저장합니다.</li>
            <li><strong>해킹 등에 대비한 기술적 대책:</strong> 보안 프로그램 설치 및 주기적 갱신, 외부로부터 접근이 통제된 구역에 시스템을 설치합니다.</li>
            <li><strong>접근 통제:</strong> 개인정보를 처리하는 시스템에 대한 접근 권한을 최소한의 인원으로 제한합니다.</li>
          </ul>
        </section>

        <section class="policy-section" id="section10">
          <h2>제10조 (개인정보 보호 책임자)</h2>
          <p>회사는 개인정보 처리에 관한 업무를 총괄하고, 이용자의 불만 처리 및 피해 구제를 위하여 아래와 같이 개인정보 보호 책임자를 지정하고 있습니다.</p>
          <div class="policy-info-box">
            <div class="policy-info-row">
              <span class="policy-info-label">담당부서</span>
              <span class="policy-info-value">서비스운영팀</span>
            </div>
            <div class="policy-info-row">
              <span class="policy-info-label">이메일</span>
              <span class="policy-info-value">maddit@maddit.co.kr</span>
            </div>
          </div>
          <p>기타 개인정보 침해에 대한 신고나 상담이 필요하신 경우 아래 기관에 문의하실 수 있습니다.</p>
          <ul>
            <li>개인정보침해신고센터 (privacy.kisa.or.kr / 국번없이 118)</li>
            <li>대검찰청 사이버수사과 (spo.go.kr / 국번없이 1301)</li>
            <li>경찰청 사이버안전국 (cyberbureau.police.go.kr / 국번없이 182)</li>
          </ul>
        </section>

      </div><!-- /policy-body -->

      <div class="policy-footer">
        <a href="<%= contextPath %>/terms" class="policy-other-link">이용약관 보기 ›</a>
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
