<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  response.setHeader("Cache-Control", "no-store");
  response.setHeader("Pragma", "no-cache");
  response.setDateHeader("Expires", 0);

  if (session.getAttribute("loginUser") != null) {
    response.sendRedirect(request.getContextPath() + "/");
    return;
  }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="theme-color" content="#ffffff">
  <title>로그인 - Maddit</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/footer.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/member/login.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- ===== 로그인 폼 ===== -->
<div class="login-wrap">
  <div class="login-card">

    <!-- 헤더 -->
    <div class="login-card-header">
      <h1 class="login-title">로그인</h1>
      <p class="login-subtitle">Maddit에 오신 것을 환영합니다</p>
    </div>

    <!-- 폼 -->
    <div class="login-card-body">

      <!-- 에러 메시지 -->
      <div class="login-error" id="loginError"></div>

      <form id="loginForm" autocomplete="off" novalidate onsubmit="return handleLogin(event)">

        <!-- 이메일 -->
        <div class="login-form-group">
          <label class="login-form-label" for="loginEmail">이메일</label>
          <input type="email" class="login-form-input" id="loginEmail"
                 placeholder="이메일을 입력하세요"
                 maxlength="100" autocomplete="email" autofocus>
        </div>

        <!-- 비밀번호 -->
        <div class="login-form-group">
          <label class="login-form-label" for="loginPw">비밀번호</label>
          <div class="pw-input-wrap">
            <input type="password" class="login-form-input" id="loginPw"
                   placeholder="비밀번호를 입력하세요"
                   maxlength="50" autocomplete="current-password">
            <button type="button" class="btn-pw-toggle" id="btnPwToggle"
                    aria-label="비밀번호 표시/숨기기">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
            </button>
          </div>
        </div>

        <button type="submit" class="btn-login" id="btnLogin">로그인</button>

      </form>
    </div>

    <!-- 하단 회원가입 링크 -->
    <div class="login-footer">
      아직 회원이 아니신가요? <a href="${pageContext.request.contextPath}/member/register">회원가입</a>
    </div>

  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>
var CTX = '${pageContext.request.contextPath}';

/* ── 비밀번호 보기/숨기기 ── */
(function() {
  var btn = document.getElementById('btnPwToggle');
  var pw  = document.getElementById('loginPw');
  if (btn && pw) {
    btn.addEventListener('click', function() {
      var isPassword = pw.type === 'password';
      pw.type = isPassword ? 'text' : 'password';
      btn.style.opacity = isPassword ? '1' : '0.5';
    });
  }
})();

/* ── Enter 키 로그인 ── */
document.getElementById('loginEmail').addEventListener('keydown', function(e) {
  if (e.key === 'Enter') { e.preventDefault(); document.getElementById('loginPw').focus(); }
});
document.getElementById('loginPw').addEventListener('keydown', function(e) {
  if (e.key === 'Enter') { e.preventDefault(); handleLogin(e); }
});

/* ── 로그인 처리 ── */
function handleLogin(e) {
  if (e && e.preventDefault) e.preventDefault();

  var email = document.getElementById('loginEmail').value.trim();
  var pw    = document.getElementById('loginPw').value;
  var error = document.getElementById('loginError');
  var btn   = document.getElementById('btnLogin');

  // 입력 체크
  if (!email) {
    showError('이메일을 입력하세요.');
    document.getElementById('loginEmail').focus();
    return false;
  }
  if (!pw) {
    showError('비밀번호를 입력하세요.');
    document.getElementById('loginPw').focus();
    return false;
  }

  // 에러 숨기기
  error.classList.remove('show');
  btn.disabled = true;
  btn.textContent = '로그인 중...';

  var formData = new FormData();
  formData.append('email', email);
  formData.append('userPw', pw);

  fetch(CTX + '/member/login', {
    method: 'POST',
    body: formData
  })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.success) {
      // 로그인 성공 → 메인으로 이동
      location.href = CTX + '/';
    } else {
      showError(data.message || '로그인에 실패했습니다.');
      btn.disabled = false;
      btn.textContent = '로그인';
    }
  })
  .catch(function() {
    showError('서버와 통신 중 오류가 발생했습니다.');
    btn.disabled = false;
    btn.textContent = '로그인';
  });

  return false;
}

function showError(msg) {
  var error = document.getElementById('loginError');
  error.textContent = msg;
  error.classList.add('show');
}
</script>

<%@ include file="/WEB-INF/views/common/scripts.jsp" %>
</body>
</html>
