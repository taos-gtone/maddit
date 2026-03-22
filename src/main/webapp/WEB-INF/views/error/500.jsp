<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>500 - 서버 오류 | Maddit</title>
  <style>
    * { margin:0; padding:0; box-sizing:border-box; }
    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
           background:#f9f9f9; display:flex; align-items:center; justify-content:center;
           min-height:100vh; }
    .box { text-align:center; padding:48px 32px; }
    .code { font-size:96px; font-weight:900; color:#e5e5e5; line-height:1; }
    .title { font-size:24px; font-weight:700; color:#0f0f0f; margin:16px 0 8px; }
    .desc  { font-size:15px; color:#606060; margin-bottom:32px; }
    .btn   { display:inline-block; padding:12px 28px; background:#e94560;
             color:#fff; border-radius:24px; font-size:15px; font-weight:600;
             text-decoration:none; }
    .btn:hover { background:#c73652; }
  </style>
</head>
<body>
  <div class="box">
    <div class="code">500</div>
    <div class="title">서버 오류가 발생했습니다</div>
    <div class="desc">일시적인 오류입니다. 잠시 후 다시 시도해 주세요.</div>
    <a href="${pageContext.request.contextPath}/" class="btn">홈으로 돌아가기</a>
  </div>
</body>
</html>
