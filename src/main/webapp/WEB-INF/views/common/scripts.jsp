<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
(function () {
  /* ── 페이지 로딩 바 ── */
  var bar = document.getElementById('pg-bar');
  var tid, cur = 0;
  function inc() {
    var step = cur < 20 ? 8 : cur < 60 ? 4 : cur < 90 ? 1 : 0;
    if (!step) return;
    cur += step;
    if (bar) bar.style.width = cur + '%';
    tid = setTimeout(inc, 300);
  }
  window.Progress = {
    start: function() {
      clearTimeout(tid); cur = 0;
      if (!bar) return;
      bar.style.transition = 'none'; bar.style.width = '0%'; bar.style.opacity = '1';
      setTimeout(function(){ bar.style.transition = 'width 0.3s ease'; inc(); }, 10);
    },
    done: function() {
      clearTimeout(tid);
      if (!bar) return;
      bar.style.width = '100%';
      setTimeout(function(){ bar.style.opacity = '0'; setTimeout(function(){ cur=0; bar.style.width='0%'; }, 300); }, 200);
    }
  };
  document.addEventListener('click', function(e) {
    var a = e.target.closest('a[href]');
    if (!a || e.ctrlKey || e.metaKey || e.shiftKey) return;
    var href = a.getAttribute('href');
    if (!href || /^(#|javascript:|mailto:|tel:)/.test(href) || a.target === '_blank') return;
    try {
      var url = new URL(href, location.href);
      if (url.origin !== location.origin) return;
    } catch(ex) { return; }
    Progress.start();
  });
})();

/* ── 햄버거 + 사이드바 ── */
(function() {
  var menuBtn  = document.getElementById('menuBtn');
  var sidebar  = document.getElementById('sidebar');
  var overlay  = document.getElementById('overlay');

  function openMenu()  { sidebar.classList.add('open'); overlay.classList.add('show'); document.body.style.overflow='hidden'; }
  function closeMenu() { sidebar.classList.remove('open'); overlay.classList.remove('show'); document.body.style.overflow=''; }

  if (menuBtn)  menuBtn.addEventListener('click',   openMenu);
  if (overlay)  overlay.addEventListener('click',   closeMenu);

  /* 960px 이상에서는 body-overflow 해제 */
  window.addEventListener('resize', function() {
    if (window.innerWidth >= 960) { document.body.style.overflow=''; }
  });
})();

/* ── 인기순 / 최신순 정렬 토글 ── */
function setSort(mode) {
  document.getElementById('btn-popular').classList.toggle('active', mode === 'popular');
  document.getElementById('btn-latest').classList.toggle('active',  mode === 'latest');

  var grid = document.querySelector('#prog-wrap .prog-grid');
  if (!grid) return;

  var cards = Array.from(grid.querySelectorAll('.prog-card'));
  if (mode === 'popular') {
    cards.sort(function(a, b) {
      return parseInt(b.dataset.dl || 0) - parseInt(a.dataset.dl || 0);
    });
  } else {
    cards.sort(function(a, b) {
      return (b.dataset.date || '').localeCompare(a.dataset.date || '');
    });
  }

  cards.forEach(function(c) { grid.appendChild(c); });
}
(function() {
  if (document.getElementById('prog-wrap')) {
    setSort(Math.random() < 0.5 ? 'popular' : 'latest');
  }
})();

/* ── 카테고리 칩 활성화 ── */
document.querySelectorAll('.chip').forEach(function(chip) {
  chip.addEventListener('click', function() {
    document.querySelectorAll('.chip').forEach(function(c){ c.classList.remove('active'); });
    chip.classList.add('active');
  });
});

/* ── 사이드바 트리 메뉴 토글 ── */
function toggleTree(parentEl) {
  var childrenId = parentEl.id + 'Children';
  var iconId     = parentEl.id + 'Icon';
  var children   = document.getElementById(childrenId);
  var icon       = document.getElementById(iconId);
  if (!children) return;
  var isOpen = children.classList.contains('open');
  if (isOpen) {
    children.classList.remove('open');
    parentEl.classList.add('collapsed');
    if (icon) icon.textContent = '+';
  } else {
    children.classList.add('open');
    parentEl.classList.remove('collapsed');
    if (icon) icon.textContent = '−';
  }
}

/* ── 현재 경로 기준 사이드바 + 하단 네비 활성화 ── */
(function() {
  var path = location.pathname;
  document.querySelectorAll('.snav-item, .mbn-item').forEach(function(a) {
    a.classList.remove('active');
    try {
      var href = a.getAttribute('href');
      if (!href) return;
      var u = new URL(href, location.href);
      if (u.pathname === path || (u.pathname !== '/' && path.startsWith(u.pathname))) {
        a.classList.add('active');
      } else if (u.pathname === '/' && path === '/') {
        a.classList.add('active');
      }
    } catch(e) {}
  });
})();
</script>
