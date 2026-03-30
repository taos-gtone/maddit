<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  response.setHeader("Cache-Control", "no-store");
  response.setHeader("Pragma", "no-cache");
  response.setDateHeader("Expires", 0);

  // 이미 로그인된 경우 메인으로
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
  <title>회원가입 - Maddit</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable-dynamic-subset.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/footer.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home/programs.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/member/register.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- ===== 히어로 배너 ===== -->
<div class="member-hero-wrap">
  <%@ include file="/WEB-INF/views/common/hero.jsp" %>
</div>

<!-- ===== 회원가입 폼 ===== -->
<div class="register-wrap">
  <div class="register-card" id="registerCard">

    <!-- 로고 -->
    <div class="register-logo">
      <a href="${pageContext.request.contextPath}/">
        <img src="${pageContext.request.contextPath}/images/maddit_logo3.png" alt="MADDIT" />
      </a>
    </div>

    <!-- 헤더 -->
    <div class="register-card-header">
      <h1 class="register-title">회원가입</h1>
      <p class="register-subtitle"><span style="color:#dc2626;font-weight:800;">메딧</span>에 가입하고 다양한 소프트웨어를 만나보세요</p>
    </div>

    <!-- 폼 -->
    <div class="register-card-body">
      <form id="registerForm" onsubmit="return handleRegister(event)">

        <!-- 이메일 -->
        <div class="form-group">
          <label class="form-label" for="email">이메일 (아이디)<span class="req">*</span></label>
          <div class="input-btn-row">
            <input type="email" class="form-input" id="email" name="email"
                   placeholder="example@email.com" required autocomplete="email"
                   oninput="onEmailInput()">
            <button type="button" class="btn-check" id="btnCheckEmail" onclick="checkEmail()">중복확인</button>
          </div>
          <div class="form-hint" id="emailHint"></div>
        </div>

        <!-- 비밀번호 -->
        <div class="form-group">
          <label class="form-label" for="userPw">비밀번호<span class="req">*</span></label>
          <input type="password" class="form-input" id="userPw" name="userPw"
                 placeholder="영문, 숫자, 특수문자 포함 8자 이상" required autocomplete="new-password"
                 oninput="validatePw()">
          <div class="pw-strength">
            <div class="strength-bar" id="str1"></div>
            <div class="strength-bar" id="str2"></div>
            <div class="strength-bar" id="str3"></div>
            <div class="strength-bar" id="str4"></div>
          </div>
          <div class="form-hint" id="pwHint"></div>
        </div>

        <!-- 비밀번호 확인 -->
        <div class="form-group">
          <label class="form-label" for="userPwConfirm">비밀번호 확인<span class="req">*</span></label>
          <input type="password" class="form-input" id="userPwConfirm" name="userPwConfirm"
                 placeholder="비밀번호를 다시 입력하세요" required autocomplete="new-password"
                 oninput="validatePwConfirm()">
          <div class="form-hint" id="pwConfirmHint"></div>
        </div>

        <!-- 닉네임 -->
        <div class="form-group">
          <label class="form-label" for="nickname">닉네임<span class="req">*</span></label>
          <div class="input-btn-row">
            <input type="text" class="form-input" id="nickname" name="nickname"
                   placeholder="2~20자, 한글/영문/숫자" required autocomplete="nickname"
                   oninput="onNicknameInput()" maxlength="20">
            <button type="button" class="btn-check" id="btnCheckNickname" onclick="checkNickname()">중복확인</button>
          </div>
          <div class="form-hint" id="nicknameHint"></div>
        </div>

        <button type="submit" class="btn-register" id="btnRegister">가입하기</button>
      </form>
    </div>

    <!-- 하단 로그인 링크 -->
    <div class="register-footer">
      이미 계정이 있으신가요? <a href="${pageContext.request.contextPath}/member/login">로그인</a>
    </div>

  </div>
</div>

<!-- ===== 가입 완료 화면 (숨김) ===== -->
<div class="register-wrap" id="completeWrap" style="display:none;">
  <div class="register-card">
    <div class="register-complete">
      <div class="complete-check">
        <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="20 6 9 17 4 12"/>
        </svg>
      </div>
      <h2 class="complete-title">가입이 완료되었습니다!</h2>
      <p class="complete-desc">
        Maddit 회원이 되신 것을 환영합니다.<br>
        로그인 후 다양한 소프트웨어를 탐색해보세요.
      </p>
      <div class="complete-btns">
        <a href="${pageContext.request.contextPath}/member/login" class="btn-go-login">로그인하기</a>
        <a href="${pageContext.request.contextPath}/" class="btn-go-home">홈으로</a>
      </div>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>
var CTX = '${pageContext.request.contextPath}';

/* ── 유효성 검사 + 중복확인 상태 ── */
var valid = { email: false, pw: false, pwConfirm: false, nickname: false };
var checked = { email: false, nickname: false };
var lastChecked = { email: '', nickname: '' };

/* ═══════════════════════════════════════
   이메일
═══════════════════════════════════════ */

/** 이메일 입력 시 (형식 검증 + 중복확인 초기화) */
function onEmailInput() {
  var el = document.getElementById('email');
  var hint = document.getElementById('emailHint');
  var btn = document.getElementById('btnCheckEmail');
  var v = el.value.trim();
  var re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  // 값이 바뀌면 중복확인 초기화
  if (v !== lastChecked.email) {
    checked.email = false;
    btn.classList.remove('verified');
    btn.textContent = '중복확인';
  }

  if (!v) {
    el.classList.remove('is-ok', 'is-error');
    hint.textContent = '';
    hint.className = 'form-hint';
    valid.email = false;
    return;
  }

  if (!re.test(v)) {
    el.classList.remove('is-ok');
    el.classList.add('is-error');
    hint.textContent = '올바른 이메일 형식을 입력하세요.';
    hint.className = 'form-hint error';
    valid.email = false;
    return;
  }

  // 형식은 OK, 중복확인 미완료
  if (!checked.email) {
    el.classList.remove('is-ok', 'is-error');
    hint.textContent = '이메일 중복확인을 해주세요.';
    hint.className = 'form-hint';
    valid.email = false;
  }
}

/** 이메일 중복확인 AJAX */
function checkEmail() {
  var el = document.getElementById('email');
  var hint = document.getElementById('emailHint');
  var btn = document.getElementById('btnCheckEmail');
  var v = el.value.trim();
  var re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  if (!v) {
    hint.textContent = '이메일을 입력하세요.';
    hint.className = 'form-hint error';
    el.focus();
    return;
  }
  if (!re.test(v)) {
    hint.textContent = '올바른 이메일 형식을 입력하세요.';
    hint.className = 'form-hint error';
    el.focus();
    return;
  }

  btn.textContent = '확인 중...';
  btn.disabled = true;

  fetch(CTX + '/member/check-email?email=' + encodeURIComponent(v))
    .then(function(res) { return res.json(); })
    .then(function(data) {
      if (data.available) {
        el.classList.remove('is-error');
        el.classList.add('is-ok');
        hint.textContent = data.message;
        hint.className = 'form-hint ok';
        valid.email = true;
        checked.email = true;
        lastChecked.email = v;
        btn.classList.add('verified');
        btn.textContent = '확인완료';
      } else {
        el.classList.remove('is-ok');
        el.classList.add('is-error');
        hint.textContent = data.message;
        hint.className = 'form-hint error';
        valid.email = false;
        checked.email = false;
        btn.classList.remove('verified');
        btn.textContent = '중복확인';
      }
      btn.disabled = false;
    })
    .catch(function() {
      hint.textContent = '서버 오류가 발생했습니다.';
      hint.className = 'form-hint error';
      btn.textContent = '중복확인';
      btn.disabled = false;
    });
}

/* ═══════════════════════════════════════
   비밀번호
═══════════════════════════════════════ */

function validatePw() {
  var el = document.getElementById('userPw');
  var hint = document.getElementById('pwHint');
  var v = el.value;

  var score = 0;
  if (v.length >= 8) score++;
  if (/[a-zA-Z]/.test(v)) score++;
  if (/[0-9]/.test(v)) score++;
  if (/[^a-zA-Z0-9]/.test(v)) score++;

  for (var i = 1; i <= 4; i++) {
    var bar = document.getElementById('str' + i);
    bar.className = 'strength-bar';
    if (i <= score) {
      if (score <= 1) bar.classList.add('weak');
      else if (score <= 2) bar.classList.add('mid');
      else bar.classList.add('strong');
    }
  }

  if (!v) {
    el.classList.remove('is-ok', 'is-error');
    hint.textContent = '';
    hint.className = 'form-hint';
    valid.pw = false;
    return;
  }

  if (v.length < 8) {
    el.classList.remove('is-ok');
    el.classList.add('is-error');
    hint.textContent = '8자 이상 입력하세요.';
    hint.className = 'form-hint error';
    valid.pw = false;
  } else if (score < 3) {
    el.classList.remove('is-ok');
    el.classList.add('is-error');
    hint.textContent = '영문, 숫자, 특수문자를 포함해주세요.';
    hint.className = 'form-hint error';
    valid.pw = false;
  } else {
    el.classList.remove('is-error');
    el.classList.add('is-ok');
    hint.textContent = '안전한 비밀번호입니다.';
    hint.className = 'form-hint ok';
    valid.pw = true;
  }

  if (document.getElementById('userPwConfirm').value) {
    validatePwConfirm();
  }
}

function validatePwConfirm() {
  var el = document.getElementById('userPwConfirm');
  var hint = document.getElementById('pwConfirmHint');
  var pw = document.getElementById('userPw').value;
  var v = el.value;

  if (!v) {
    el.classList.remove('is-ok', 'is-error');
    hint.textContent = '';
    hint.className = 'form-hint';
    valid.pwConfirm = false;
    return;
  }

  if (v === pw) {
    el.classList.remove('is-error');
    el.classList.add('is-ok');
    hint.textContent = '비밀번호가 일치합니다.';
    hint.className = 'form-hint ok';
    valid.pwConfirm = true;
  } else {
    el.classList.remove('is-ok');
    el.classList.add('is-error');
    hint.textContent = '비밀번호가 일치하지 않습니다.';
    hint.className = 'form-hint error';
    valid.pwConfirm = false;
  }
}

/* ═══════════════════════════════════════
   닉네임
═══════════════════════════════════════ */

/** 닉네임 입력 시 (형식 검증 + 중복확인 초기화) */
function onNicknameInput() {
  var el = document.getElementById('nickname');
  var hint = document.getElementById('nicknameHint');
  var btn = document.getElementById('btnCheckNickname');
  var v = el.value.trim();
  var re = /^[가-힣a-zA-Z0-9]{2,20}$/;

  // 값이 바뀌면 중복확인 초기화
  if (v !== lastChecked.nickname) {
    checked.nickname = false;
    btn.classList.remove('verified');
    btn.textContent = '중복확인';
  }

  if (!v) {
    el.classList.remove('is-ok', 'is-error');
    hint.textContent = '';
    hint.className = 'form-hint';
    valid.nickname = false;
    return;
  }

  if (!re.test(v)) {
    el.classList.remove('is-ok');
    el.classList.add('is-error');
    hint.textContent = '2~20자, 한글/영문/숫자만 사용 가능합니다.';
    hint.className = 'form-hint error';
    valid.nickname = false;
    return;
  }

  // 형식은 OK, 중복확인 미완료
  if (!checked.nickname) {
    el.classList.remove('is-ok', 'is-error');
    hint.textContent = '닉네임 중복확인을 해주세요.';
    hint.className = 'form-hint';
    valid.nickname = false;
  }
}

/** 닉네임 중복확인 (금지어 + 중복) AJAX */
function checkNickname() {
  var el = document.getElementById('nickname');
  var hint = document.getElementById('nicknameHint');
  var btn = document.getElementById('btnCheckNickname');
  var v = el.value.trim();
  var re = /^[가-힣a-zA-Z0-9]{2,20}$/;

  if (!v) {
    hint.textContent = '닉네임을 입력하세요.';
    hint.className = 'form-hint error';
    el.focus();
    return;
  }
  if (!re.test(v)) {
    hint.textContent = '2~20자, 한글/영문/숫자만 사용 가능합니다.';
    hint.className = 'form-hint error';
    el.focus();
    return;
  }

  btn.textContent = '확인 중...';
  btn.disabled = true;

  fetch(CTX + '/member/check-nickname?nickname=' + encodeURIComponent(v))
    .then(function(res) { return res.json(); })
    .then(function(data) {
      if (data.available) {
        el.classList.remove('is-error');
        el.classList.add('is-ok');
        hint.textContent = data.message;
        hint.className = 'form-hint ok';
        valid.nickname = true;
        checked.nickname = true;
        lastChecked.nickname = v;
        btn.classList.add('verified');
        btn.textContent = '확인완료';
      } else {
        el.classList.remove('is-ok');
        el.classList.add('is-error');
        hint.textContent = data.message;
        hint.className = 'form-hint error';
        valid.nickname = false;
        checked.nickname = false;
        btn.classList.remove('verified');
        btn.textContent = '중복확인';
      }
      btn.disabled = false;
    })
    .catch(function() {
      hint.textContent = '서버 오류가 발생했습니다.';
      hint.className = 'form-hint error';
      btn.textContent = '중복확인';
      btn.disabled = false;
    });
}

/* ═══════════════════════════════════════
   회원가입 제출
═══════════════════════════════════════ */

function handleRegister(e) {
  e.preventDefault();

  // 전체 유효성 재검증
  if (!valid.email || !checked.email) {
    alert('이메일 중복확인을 해주세요.');
    document.getElementById('email').focus();
    return false;
  }

  validatePw();
  validatePwConfirm();

  if (!valid.pw) {
    alert('비밀번호를 확인해주세요.');
    document.getElementById('userPw').focus();
    return false;
  }
  if (!valid.pwConfirm) {
    alert('비밀번호 확인을 해주세요.');
    document.getElementById('userPwConfirm').focus();
    return false;
  }

  if (!valid.nickname || !checked.nickname) {
    alert('닉네임 중복확인을 해주세요.');
    document.getElementById('nickname').focus();
    return false;
  }

  var btn = document.getElementById('btnRegister');
  btn.disabled = true;
  btn.textContent = '가입 처리 중...';

  var formData = new FormData(document.getElementById('registerForm'));

  fetch(CTX + '/member/register', {
    method: 'POST',
    body: formData
  })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.success) {
      document.getElementById('registerCard').parentElement.style.display = 'none';
      document.getElementById('completeWrap').style.display = 'flex';
      window.scrollTo(0, 0);
    } else {
      alert(data.message || '회원가입에 실패했습니다.');
      btn.disabled = false;
      btn.textContent = '가입하기';
    }
  })
  .catch(function() {
    alert('서버와 통신 중 오류가 발생했습니다.');
    btn.disabled = false;
    btn.textContent = '가입하기';
  });

  return false;
}
</script>

<%@ include file="/WEB-INF/views/common/scripts.jsp" %>
</body>
</html>
