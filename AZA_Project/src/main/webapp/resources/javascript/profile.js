let files = document.getElementById('files');

// 정규표현식을 이용하여 등록 가능한 파일 제한
const regExp = new RegExp(".(jpg|jpeg|png)$",'i'); // 등록 가능한 파일
const maxSize = 1024 * 1024 * 2; // 최대 파일 용량 2 MB

// file 형식 제한
function fileValidation(fileName, fileSize) {
    if (!regExp.test(fileName)) {
        alert("jpg, jpeg, png 형식의 사진 파일만 등록 가능합니다.");
        return false;
    } else if (fileSize > maxSize) {
        alert("용량이 2 MB를 초과하는 파일은 등록할 수 없습니다.");
        return false;
    } else return true;
}

// 프로필사진이 없는 경우 기본사진 출력
if(document.querySelector('.profile').getAttribute('src') == "/_") {
	document.querySelector('.profile').setAttribute('src', '/resources/image/bird.jpg');
}

// 프로필사진 변경
document.getElementById('updateProfileBtn').addEventListener('click',()=>{
	files.click();
});

// 
files.addEventListener('change',()=>{
	// 파일이 선택되지 않은 경우 실행 X
    if(event.target.files[0] == undefined) return;
    
    // 다수의 파일을 선택한 경우 등록 취소
    if(event.target.files.length > 1) {
    	alert('하나의 파일만 선택하세요.');
    	return;
    }
    
    const fileObject = event.target.files[0];
    
    // 파일 형식, 크기 검사
    let validResult = fileValidation(fileObject.name, fileObject.size);
    
    if(validResult) {
    	// 정보를 담을 객체
    	var formData = new FormData();
    	
    	formData.append('profile', fileObject);
    	formData.append('member_id', sessionID);
    
        $.ajax({
            url: "/profile/register", // 컨트롤러 URL
            data: formData,
            dataType: "json",
            processData: false,
            contentType: false,
            type: "post",
            success: function (response) { // 저장이 된 경우
                alert("프로필사진이 변경되었습니다.");
				location.reload();
            },
            error: function (jqXHR) {
                alert("프로필사진이 변경되지 못했습니다.");
                if(profile == "") document.querySelector('.profile').setAttribute('src', '/resources/image/bird.jpg');
            },
        });
   	}
});