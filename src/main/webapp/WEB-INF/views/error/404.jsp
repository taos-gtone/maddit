<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="theme-color" content="#0a0a0a">
  <title>404 - 페이지를 찾을 수 없습니다 | Maddit</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable-dynamic-subset.min.css">
  <style>
    *,*::before,*::after { margin:0; padding:0; box-sizing:border-box; }
    html { font-size:16px; }
    body {
      font-family:'Pretendard Variable','Pretendard','Inter',-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif;
      background:#fafafa; color:#0a0a0a;
      min-height:100vh; display:flex; flex-direction:column;
      -webkit-font-smoothing:antialiased;
    }

    /* Header */
    .error-header {
      background:#ffffff; border-bottom:1px solid #e0e0e0;
    }
    .error-header-inner {
      display:flex; align-items:center; justify-content:center;
      height:64px; padding:0 24px;
    }
    .error-header a { display:flex; align-items:center; }
    .error-header img { height:32px; }
    .error-header-bar { height:3px; background:#dc2626; }

    /* Content */
    .error-body {
      flex:1; display:flex; align-items:center; justify-content:center;
      padding:40px 24px;
    }
    .error-card {
      text-align:center; max-width:420px; width:100%;
      background:#ffffff; border:1px solid #0a0a0a;
      overflow:hidden;
    }

    /* Card top red line */
    .error-card-bar { height:3px; background:#dc2626; }

    /* Card body */
    .error-card-body { padding:48px 36px 44px; }

    /* Big number */
    .error-code {
      font-size:120px; font-weight:900; line-height:1;
      color:#dc2626; letter-spacing:-4px;
    }

    .error-title {
      font-size:20px; font-weight:800; color:#0a0a0a;
      margin:24px 0 8px;
    }
    .error-desc {
      font-size:14px; color:#888888; line-height:1.7;
      margin-bottom:36px;
    }

    /* Buttons */
    .error-actions { display:flex; gap:10px; justify-content:center; flex-wrap:wrap; }
    .btn-home {
      display:inline-flex; align-items:center; gap:6px;
      padding:12px 28px; background:#dc2626; color:#ffffff;
      font-size:14px; font-weight:700; text-decoration:none;
      border:none; transition:all .15s;
    }
    .btn-home:hover { background:#b91c1c; }
    .btn-home svg { flex-shrink:0; }

    .btn-back {
      display:inline-flex; align-items:center; gap:6px;
      padding:12px 28px; background:#ffffff; color:#0a0a0a;
      font-size:14px; font-weight:600; text-decoration:none;
      border:1px solid #e0e0e0; cursor:pointer; transition:all .15s;
    }
    .btn-back:hover { border-color:#dc2626; color:#dc2626; }

    /* Footer */
    .error-footer {
      padding:20px 24px; text-align:center;
      font-size:12px; color:#888888; border-top:1px solid #e0e0e0;
    }

    @media (max-width:480px) {
      .error-code { font-size:88px; letter-spacing:-3px; }
      .error-card-body { padding:40px 24px 36px; }
      .error-title { font-size:18px; }
    }
  </style>
</head>
<body>

  <header class="error-header">
    <div class="error-header-inner">
      <a href="${pageContext.request.contextPath}/">
        <img src="${pageContext.request.contextPath}/images/maddit_logo3.png" alt="MADDIT" />
      </a>
    </div>
    <div class="error-header-bar"></div>
  </header>

  <div class="error-body">
    <div class="error-card">
      <div class="error-card-bar"></div>
      <div class="error-card-body">
        <div class="error-code">404</div>
        <div class="error-title">페이지를 찾을 수 없습니다</div>
        <div class="error-desc">요청하신 페이지가 존재하지 않거나 이동되었습니다.<br>주소를 다시 확인해 주세요.</div>
        <div class="error-actions">
          <a href="${pageContext.request.contextPath}/" class="btn-home">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
            홈으로
          </a>
          <button class="btn-back" onclick="history.back()">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="19" y1="12" x2="5" y2="12"/><polyline points="12 19 5 12 12 5"/></svg>
            이전 페이지
          </button>
        </div>
      </div>
    </div>
  </div>

  <footer class="error-footer">&copy; <%= java.time.Year.now().getValue() %> Maddit. All rights reserved.</footer>

</body>
</html>
