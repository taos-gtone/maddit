<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.maddit.vo.ProgramVO, java.util.List" %>
<%
  List<ProgramVO> popularList = (List<ProgramVO>) request.getAttribute("popularList");
  String[] rankClass = {"rank-1","rank-2","rank-3","rank-4","rank-5"};
%>

<!-- ===== 인기 프로그램 ===== -->
<section class="prog-section">
  <div class="prog-grid">
    <% if (popularList != null && !popularList.isEmpty()) {
         for (int i = 0; i < popularList.size(); i++) {
           ProgramVO p = popularList.get(i);
           String dlFmt  = String.format("%,d", p.getDownloadCnt());
           String rClass = (i < rankClass.length) ? rankClass[i] : "rank-5";
    %>
    <div class="prog-card" data-dl="<%= p.getDownloadCnt() %>" data-date="<%= p.getRegDate() %>" onclick="location.href='${pageContext.request.contextPath}/program/<%= p.getProgNo() %>'">
      <div class="prog-thumb" style="background:<%= p.getProgColor() %>">
        <span class="thumb-icon"><%= p.getProgIcon() %></span>
      </div>
      <div class="prog-meta">
        <div class="prog-avatar" style="background:<%= p.getProgColor() %>"><%= p.getProgIcon() %></div>
        <div class="prog-info">
          <div class="prog-title"><%= p.getProgName() %></div>
          <div class="prog-desc"><%= p.getProgDesc() %></div>
          <div class="prog-stats">
            <span class="prog-cat"><%= p.getProgCategory() %></span>
            <span class="prog-dl">⬇ <%= dlFmt %></span>
          </div>
        </div>
      </div>
    </div>
    <% } } else { %>
    <!-- ── 샘플 데이터 (DB 연동 전) ── -->
    <div class="prog-card" data-dl="5601" data-date="2026-03-22" onclick="">
      <div class="prog-thumb" style="background:linear-gradient(135deg,#4facfe,#00f2fe)">
        <span class="thumb-icon">📋</span>
      </div>
      <div class="prog-meta">
        <div class="prog-avatar" style="background:#e0f4ff">📋</div>
        <div class="prog-info">
          <div class="prog-title">ClipBoard++ — 클립보드 히스토리 관리</div>
          <div class="prog-desc">복사한 내용을 자동 저장, 검색, 재사용</div>
          <div class="prog-stats"><span class="prog-cat">생산성</span><span class="prog-dl">⬇ 5,601</span></div>
        </div>
      </div>
    </div>
    <div class="prog-card" data-dl="4330" data-date="2026-03-21" onclick="">
      <div class="prog-thumb" style="background:linear-gradient(135deg,#2c3e50,#4ca1af)">
        <span class="thumb-icon">🔐</span>

      </div>
      <div class="prog-meta">
        <div class="prog-avatar" style="background:#e8f0f4">🔐</div>
        <div class="prog-info">
          <div class="prog-title">PassVault — 로컬 암호화 비밀번호 관리</div>
          <div class="prog-desc">오프라인 AES-256 암호화 패스워드 저장소</div>
          <div class="prog-stats"><span class="prog-cat">보안</span><span class="prog-dl">⬇ 4,330</span></div>
        </div>
      </div>
    </div>
    <div class="prog-card" data-dl="3820" data-date="2026-03-20" onclick="">
      <div class="prog-thumb" style="background:linear-gradient(135deg,#11998e,#38ef7d)">
        <span class="thumb-icon">🗂️</span>

      </div>
      <div class="prog-meta">
        <div class="prog-avatar" style="background:#e0fff4">🗂️</div>
        <div class="prog-info">
          <div class="prog-title">FileOrganizer — 폴더 자동 정리 유틸리티</div>
          <div class="prog-desc">확장자·날짜 기준 파일 자동 분류 및 이동</div>
          <div class="prog-stats"><span class="prog-cat">파일관리</span><span class="prog-dl">⬇ 3,820</span></div>
        </div>
      </div>
    </div>
    <div class="prog-card" data-dl="2110" data-date="2026-03-19" onclick="">
      <div class="prog-thumb" style="background:linear-gradient(135deg,#f7971e,#ffd200)">
        <span class="thumb-icon">⏱️</span>

      </div>
      <div class="prog-meta">
        <div class="prog-avatar" style="background:#fff8e0">⏱️</div>
        <div class="prog-info">
          <div class="prog-title">FocusTimer — 포모도로 집중 타이머</div>
          <div class="prog-desc">25/5분 주기 집중 타이머 + 작업 통계 차트</div>
          <div class="prog-stats"><span class="prog-cat">생산성</span><span class="prog-dl">⬇ 2,110</span></div>
        </div>
      </div>
    </div>
    <div class="prog-card" data-dl="1850" data-date="2026-03-18" onclick="">
      <div class="prog-thumb" style="background:linear-gradient(135deg,#667eea,#764ba2)">
        <span class="thumb-icon">📊</span>

      </div>
      <div class="prog-meta">
        <div class="prog-avatar" style="background:#e8e8ff">📊</div>
        <div class="prog-info">
          <div class="prog-title">DataViz Pro — 엑셀 데이터 시각화 툴</div>
          <div class="prog-desc">드래그앤드롭으로 차트·그래프 즉시 생성</div>
          <div class="prog-stats"><span class="prog-cat">데이터</span><span class="prog-dl">⬇ 1,850</span></div>
        </div>
      </div>
    </div>
    <div class="prog-card" data-dl="1720" data-date="2026-03-17" onclick="">
      <div class="prog-thumb" style="background:linear-gradient(135deg,#43e97b,#38f9d7)">
        <span class="thumb-icon">📝</span>

      </div>
      <div class="prog-meta">
        <div class="prog-avatar" style="background:#e0fff0">📝</div>
        <div class="prog-info">
          <div class="prog-title">MarkPad — 마크다운 실시간 메모장</div>
          <div class="prog-desc">좌우 분할 실시간 미리보기 마크다운 편집기</div>
          <div class="prog-stats"><span class="prog-cat">메모</span><span class="prog-dl">⬇ 1,720</span></div>
        </div>
      </div>
    </div>
    <div class="prog-card" data-dl="1560" data-date="2026-03-16" onclick="">
      <div class="prog-thumb" style="background:linear-gradient(135deg,#f093fb,#f5576c)">
        <span class="thumb-icon">🎨</span>

      </div>
      <div class="prog-meta">
        <div class="prog-avatar" style="background:#fde8f5">🎨</div>
        <div class="prog-info">
          <div class="prog-title">ColorPicker X — 화면 색상 추출기</div>
          <div class="prog-desc">화면 어디서나 픽셀 색상 추출 및 코드 복사</div>
          <div class="prog-stats"><span class="prog-cat">디자인</span><span class="prog-dl">⬇ 1,560</span></div>
        </div>
      </div>
    </div>
    <div class="prog-card" data-dl="1340" data-date="2026-03-15" onclick="">
      <div class="prog-thumb" style="background:linear-gradient(135deg,#a18cd1,#fbc2eb)">
        <span class="thumb-icon">🖼️</span>

      </div>
      <div class="prog-meta">
        <div class="prog-avatar" style="background:#f0e8ff">🖼️</div>
        <div class="prog-info">
          <div class="prog-title">ImageBatch — 이미지 일괄 변환 도구</div>
          <div class="prog-desc">JPEG·PNG·WebP 포맷 일괄 변환 및 리사이즈</div>
          <div class="prog-stats"><span class="prog-cat">이미지</span><span class="prog-dl">⬇ 1,340</span></div>
        </div>
      </div>
    </div>
    <div class="prog-card" data-dl="1180" data-date="2026-03-14" onclick="">
      <div class="prog-thumb" style="background:linear-gradient(135deg,#ff9a9e,#fecfef)">
        <span class="thumb-icon">🔔</span>

      </div>
      <div class="prog-meta">
        <div class="prog-avatar" style="background:#ffe8f0">🔔</div>
        <div class="prog-info">
          <div class="prog-title">NotiMate — 윈도우 스케줄 알림 앱</div>
          <div class="prog-desc">반복 일정 알림 + 시스템 트레이 상주</div>
          <div class="prog-stats"><span class="prog-cat">알림</span><span class="prog-dl">⬇ 1,180</span></div>
        </div>
      </div>
    </div>
    <div class="prog-card" data-dl="980" data-date="2026-03-13" onclick="">
      <div class="prog-thumb" style="background:linear-gradient(135deg,#fa709a,#fee140)">
        <span class="thumb-icon">🚀</span>

      </div>
      <div class="prog-meta">
        <div class="prog-avatar" style="background:#fff0e0">🚀</div>
        <div class="prog-info">
          <div class="prog-title">QuickLauncher — 키보드 앱 빠른 실행</div>
          <div class="prog-desc">단축키 하나로 앱·파일·웹 URL 즉시 실행</div>
          <div class="prog-stats"><span class="prog-cat">생산성</span><span class="prog-dl">⬇ 980</span></div>
        </div>
      </div>
    </div>
    <div class="prog-card" data-dl="870" data-date="2026-03-12" onclick="">
      <div class="prog-thumb" style="background:linear-gradient(135deg,#30cfd0,#330867)">
        <span class="thumb-icon">💾</span>

      </div>
      <div class="prog-meta">
        <div class="prog-avatar" style="background:#e0f8ff">💾</div>
        <div class="prog-info">
          <div class="prog-title">DiskMap — 디스크 사용량 시각화</div>
          <div class="prog-desc">트리맵으로 폴더별 디스크 점유율 한눈에 확인</div>
          <div class="prog-stats"><span class="prog-cat">파일관리</span><span class="prog-dl">⬇ 870</span></div>
        </div>
      </div>
    </div>
    <div class="prog-card" data-dl="750" data-date="2026-03-11" onclick="">
      <div class="prog-thumb" style="background:linear-gradient(135deg,#fd746c,#ff9068)">
        <span class="thumb-icon">📸</span>

      </div>
      <div class="prog-meta">
        <div class="prog-avatar" style="background:#ffe8e8">📸</div>
        <div class="prog-info">
          <div class="prog-title">WinSnap+ — 화면 캡처 + 주석 도구</div>
          <div class="prog-desc">영역·창·전체 캡처 후 화살표·텍스트 주석 추가</div>
          <div class="prog-stats"><span class="prog-cat">유틸리티</span><span class="prog-dl">⬇ 750</span></div>
        </div>
      </div>
    </div>
    <% } %>
  </div>
</section>
