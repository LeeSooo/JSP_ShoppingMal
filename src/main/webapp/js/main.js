/* 화면 축소 시 상단헤더 버튼의 이벤트 처리 (2022-11-18 이수) */
const toggleBtn = document.querySelector('.navbar_toggleBtn');
const menu = document.querySelector('.navbar_centermenu');

toggleBtn.addEventListener('click', () => {
    menu.classList.toggle('active');
});