<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  Integer _totalPrograms = (Integer) request.getAttribute("totalPrograms");
  Integer _totalDownloads = (Integer) request.getAttribute("totalDownloads");
  Integer _totalMembers = (Integer) request.getAttribute("totalMembers");
  if (_totalPrograms == null) _totalPrograms = 0;
  if (_totalDownloads == null) _totalDownloads = 0;
  if (_totalMembers == null) _totalMembers = 0;
%>

<script>
(function() {
  if (window._heroBricksInitialized) return;
  window._heroBricksInitialized = true;

  window.addEventListener('load', function() {
    var container = document.getElementById('heroBricks');
    if (!container) return;

    var colors = ['var(--red)', 'var(--black)', 'var(--mid-gray)', 'var(--dim)', '#b91c1c', 'var(--dark-gray)'];
    var totalBricks = 60;
    var directions = [
      'translate(-80px, 0)',
      'translate(80px, 0)',
      'translate(0, -60px)',
      'translate(0, 60px)'
    ];
    var stagger = 250;

    function shuffle(arr) {
      for (var k = arr.length - 1; k > 0; k--) {
        var r = Math.floor(Math.random() * (k + 1));
        var tmp = arr[k]; arr[k] = arr[r]; arr[r] = tmp;
      }
      return arr;
    }

    function pickDir() { return directions[Math.floor(Math.random() * 4)]; }

    for (var i = 0; i < totalBricks; i++) {
      var brick = document.createElement('div');
      brick.className = 'hero-brick';
      brick.style.background = colors[Math.floor(Math.random() * colors.length)];
      brick.style.setProperty('--brick-from', pickDir());
      container.appendChild(brick);
    }

    var bricks = container.querySelectorAll('.hero-brick');

    function runPhase(className, propName, afterDone) {
      var order = [];
      for (var j = 0; j < totalBricks; j++) order.push(j);
      shuffle(order);

      order.forEach(function(idx) {
        bricks[idx].style.setProperty(propName, pickDir());
      });

      order.forEach(function(idx, seq) {
        setTimeout(function() {
          bricks[idx].classList.remove('brick-in', 'brick-out');
          void bricks[idx].offsetWidth;
          bricks[idx].classList.add(className);
        }, seq * stagger);
      });

      var totalMs = (totalBricks - 1) * stagger + 8000;
      setTimeout(afterDone, totalMs);
    }

    function cycleIn() {
      for (var c = 0; c < totalBricks; c++) {
        bricks[c].style.background = colors[Math.floor(Math.random() * colors.length)];
      }
      runPhase('brick-in', '--brick-from', function() {
        setTimeout(cycleOut, 1000);
      });
    }

    function cycleOut() {
      runPhase('brick-out', '--brick-to', function() {
        setTimeout(cycleIn, 1000);
      });
    }

    setTimeout(cycleIn, 300);
  });
})();
</script>

<!-- Hero — Bold black block -->
<div class="hero-banner">
  <div class="hero-content">
    <div class="hero-badge">FREE DOWNLOAD</div>
    <h1 class="hero-title">무료 소프트웨어, <font color="#FF0000">메딧</font>에서 다운로드 하세요</h1>
    <p class="hero-desc">생산성 도구부터 개발 유틸리티까지. 관리자가 엄선한 프로그램을 안전하게 받아보세요.</p>
    <div class="hero-stats">
      <div class="hero-stat">
        <div class="hero-stat-num"><%= String.format("%,d", _totalPrograms) %>+</div>
        <div class="hero-stat-label">PROGRAMS</div>
      </div>
      <div class="hero-stat">
        <div class="hero-stat-num"><%= String.format("%,d", _totalDownloads) %>+</div>
        <div class="hero-stat-label">DOWNLOADS</div>
      </div>
      <div class="hero-stat">
        <div class="hero-stat-num"><%= String.format("%,d", _totalMembers) %>+</div>
        <div class="hero-stat-label">USERS</div>
      </div>
    </div>
  </div>
  <div class="hero-bricks" id="heroBricks"></div>
</div>
