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

/* ── 인기순 / 최신순 정렬 토글 (AJAX) ── */
var _currentSort = 'latest';
function setSort(mode) {
  _currentSort = mode;
  document.getElementById('btn-popular').classList.toggle('active', mode === 'popular');
  document.getElementById('btn-latest').classList.toggle('active',  mode === 'latest');

  // 현재 선택된 카테고리
  var activeChip = document.querySelector('#chipsBar .chip.active');
  var cat = activeChip ? (activeChip.getAttribute('data-cat') || '') : '';

  if (typeof filterByCategory === 'function' && typeof _currentSort !== 'undefined') {
    // index.jsp에서 정의된 filterByCategory 재활용
    _fetchPrograms(cat, mode);
  }
}
function _fetchPrograms(cat, sort) {
  var ctxP = '';
  try { ctxP = document.querySelector('meta[name="ctx"]') ? document.querySelector('meta[name="ctx"]').content : ''; } catch(e) {}
  // index.jsp의 ctxPath 변수 사용
  var base = (typeof ctxPath !== 'undefined') ? ctxPath : ctxP;
  var url = base + '/api/programs?sort=' + (sort || _currentSort || 'latest') + (cat ? '&boardCatGbnCd=' + cat : '');

  fetch(url).then(function(r) { return r.json(); }).then(function(list) {
    var grid = document.querySelector('#prog-wrap .prog-grid');
    if (!grid) return;
    _renderProgGrid(grid, list, base);
  });
}
function _renderProgGrid(grid, list, base) {
  var gradients = [
    'linear-gradient(135deg,#4facfe,#00f2fe)', 'linear-gradient(135deg,#667eea,#764ba2)',
    'linear-gradient(135deg,#11998e,#38ef7d)', 'linear-gradient(135deg,#f7971e,#ffd200)',
    'linear-gradient(135deg,#f093fb,#f5576c)', 'linear-gradient(135deg,#43e97b,#38f9d7)',
    'linear-gradient(135deg,#fa709a,#fee140)', 'linear-gradient(135deg,#a18cd1,#fbc2eb)',
    'linear-gradient(135deg,#30cfd0,#330867)', 'linear-gradient(135deg,#ff9a9e,#fecfef)',
    'linear-gradient(135deg,#fd746c,#ff9068)', 'linear-gradient(135deg,#2c3e50,#4ca1af)'
  ];
  grid.innerHTML = '';
  if (list.length === 0) {
    grid.innerHTML = '<div style="grid-column:1/-1;text-align:center;padding:40px;color:#999;">등록된 프로그램이 없습니다.</div>';
    return;
  }
  var d = document.createElement('div');
  list.forEach(function(p, i) {
    var grad = gradients[i % gradients.length];
    var hasThumb = p.thumbFilePath && p.thumbFilePath.length > 0;
    var thumbStyle = hasThumb ? 'background:#f0f2f5;padding:0;' : 'background:' + grad;
    var thumbInner = hasThumb
      ? '<img src="' + base + '/upload' + _esc(p.thumbFilePath) + '" alt="" style="width:100%;height:100%;object-fit:cover;" onerror="this.style.display=\'none\';this.parentNode.style.background=\'' + grad + '\';this.parentNode.innerHTML=\'<span class=thumb-icon>💻</span>\';">'
      : '<span class="thumb-icon">💻</span>';
    var catHtml = p.catNm ? '<span class="prog-cat">' + _esc(p.catNm) + '</span>' : '';
    grid.insertAdjacentHTML('beforeend',
      '<div class="prog-card" onclick="location.href=\'' + base + '/program/' + p.postNo + '\'">'
      + '<div class="prog-thumb" style="' + thumbStyle + '">' + thumbInner + '</div>'
      + '<div class="prog-meta"><div class="prog-info">'
      + '<div class="prog-title">' + _esc(p.title) + '</div>'
      + '<div class="prog-stats">' + catHtml
      + '<span class="prog-stat-item">👁 ' + p.viewCnt + '</span>'
      + '<span class="prog-stat-item"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" style="vertical-align:-1px"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg> ' + p.totalDownloadCnt + '</span>'
      + '<span class="prog-stat-item">💬 ' + (p.commentCnt || 0) + '</span>'
      + '</div></div></div></div>');
  });
}
function _esc(s) { if(!s) return ''; var d=document.createElement('div'); d.textContent=s; return d.innerHTML; }
(function() {
  var btnP = document.getElementById('btn-popular');
  var btnL = document.getElementById('btn-latest');
  if (btnP && btnL) {
    var initSort = Math.random() < 0.5 ? 'popular' : 'latest';
    _currentSort = initSort;
    btnP.classList.toggle('active', initSort === 'popular');
    btnL.classList.toggle('active', initSort === 'latest');
    // 초기 데이터를 랜덤 정렬로 로드
    setTimeout(function() { _fetchPrograms('', initSort); }, 100);
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
