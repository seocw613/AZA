document.getElementById("insertBtn").addEventListener("click", () => {
    let f = document.getElementById("form");
	if(f.title.value.length == 0) alert("제목을 입력해주세요.");
    else insertPhoto();
});