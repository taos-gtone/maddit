<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- ===== 게시판 섹션 ===== -->
<section class="boards-wrap">

  <!-- 만들어 주세요 -->
  <div class="board-panel">
    <div class="board-panel-header">
      <h2 class="board-panel-title">✏️ 만들어 주세요</h2>
      <div class="board-panel-actions">
        <a href="${pageContext.request.contextPath}/board/request/write" class="btn-write">
          <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
          글쓰기
        </a>
        <a href="${pageContext.request.contextPath}/board/request" class="view-all">전체보기 ›</a>
      </div>
    </div>
    <ul class="board-list">
      <li class="board-item">
        <div class="board-item-body">
          <div class="board-item-title">자동으로 폴더 날짜별 정리해주는 프로그램 있나요?</div>
          <div class="board-item-meta">홍길동 &middot; 10분 전 &middot; <span class="reply-cnt">💬 5</span></div>
        </div>
      </li>
      <li class="board-item">
        <div class="board-item-body">
          <div class="board-item-title">카카오톡 메시지 예약발송 프로그램 만들어주실 수 있나요</div>
          <div class="board-item-meta">익명 &middot; 1시간 전 &middot; <span class="reply-cnt">💬 12</span></div>
        </div>
      </li>
      <li class="board-item">
        <div class="board-item-body">
          <div class="board-item-title">엑셀 중복 데이터 자동 삭제 매크로 부탁드립니다</div>
          <div class="board-item-meta">user123 &middot; 3시간 전 &middot; <span class="reply-cnt">💬 3</span></div>
        </div>
      </li>
      <li class="board-item">
        <div class="board-item-body">
          <div class="board-item-title">웹사이트 이미지 일괄 다운로드 툴 요청드려요</div>
          <div class="board-item-meta">김철수 &middot; 어제 &middot; <span class="reply-cnt">💬 8</span></div>
        </div>
      </li>
      <li class="board-item">
        <div class="board-item-body">
          <div class="board-item-title">PDF 여러 파일 합치는 간단한 프로그램 만들어 주세요</div>
          <div class="board-item-meta">lee_dev &middot; 2일 전 &middot; <span class="reply-cnt">💬 17</span></div>
        </div>
      </li>
    </ul>
  </div>

  <!-- 자유게시판 -->
  <div class="board-panel">
    <div class="board-panel-header">
      <h2 class="board-panel-title">💬 자유게시판</h2>
      <div class="board-panel-actions">
        <a href="${pageContext.request.contextPath}/board/free/write" class="btn-write">
          <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
          글쓰기
        </a>
        <a href="${pageContext.request.contextPath}/board/free" class="view-all">전체보기 ›</a>
      </div>
    </div>
    <ul class="board-list">
      <li class="board-item">
        <div class="board-item-body">
          <div class="board-item-title">ClipBoard++ 쓰고나서 진짜 생산성 올랐어요 후기</div>
          <div class="board-item-meta">개발자K &middot; 30분 전 &middot; <span class="reply-cnt">💬 9</span></div>
        </div>
      </li>
      <li class="board-item">
        <div class="board-item-body">
          <div class="board-item-title">이런 사이트 너무 필요했어요. 감사합니다 ㅠㅠ</div>
          <div class="board-item-meta">newbie_j &middot; 2시간 전 &middot; <span class="reply-cnt">💬 6</span></div>
        </div>
      </li>
      <li class="board-item">
        <div class="board-item-body">
          <div class="board-item-title">FocusTimer Windows 11에서 안켜지는 분 있나요?</div>
          <div class="board-item-meta">win11user &middot; 5시간 전 &middot; <span class="reply-cnt">💬 4</span></div>
        </div>
      </li>
      <li class="board-item">
        <div class="board-item-body">
          <div class="board-item-title">프로그래머 아닌데 여기서 배우면서 만들 수 있나요?</div>
          <div class="board-item-meta">궁금해요 &middot; 어제 &middot; <span class="reply-cnt">💬 11</span></div>
        </div>
      </li>
      <li class="board-item">
        <div class="board-item-body">
          <div class="board-item-title">PassVault 소스코드 공개 예정 있나요?</div>
          <div class="board-item-meta">opensource_fan &middot; 2일 전 &middot; <span class="reply-cnt">💬 7</span></div>
        </div>
      </li>
    </ul>
  </div>

</section>
