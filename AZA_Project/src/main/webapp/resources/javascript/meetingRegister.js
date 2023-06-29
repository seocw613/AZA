document.getElementById("submitBtn").addEventListener("click", () => {
    if (document.getElementById("meeting_date").value == "") alert("모임일을 입력하세요.");
    else if (document.querySelector(".title").value == "") alert("제목을 입력하세요.");
    else if (animal.value == "") alert("간식을 먹을 수 있는 동물을 선택하세요!");
    else if (document.getElementsByName('id')[0].value == '') alert("모임 장소를 선택하세요.");
    else if (document.querySelector(".content").value == "") alert("내용을 입력하세요.");
    else insertPhoto();
});
