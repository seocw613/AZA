// (C : 커뮤니티, B : 사진 자랑, A : 숙소, F : 주의식품, R : 레시피, Q : 문의사항, M : 펫 모임, Mb : 멤버)
const pListObj = {}; // 사진 정보를 담을 리스트를 담을 리스트
const mainArr = ["B", "A", "F", "R", "M"]; // 대표사진을 설정하는 게시판 배열
const onlyOneArr = ["Mb", "R"]; // 사진을 하나만 등록하는 게시판
let deleteUuid = ""; // 삭제할 사진의 UUID를 임시 저장
let addPhotoBtn = ""; // 마지막에 누른 addPhotoBtn을 저장
let deletePhotoBtn = ""; // 마지막에 누른 deletePhotoBtn을 저장
let photoBox = ""; // 전체 PhotoBox 중 마지막에 누른 addPhotoBtn을 포함한 PhotoBox
let photoWrapper = "";
let index = -1; // photoBox의 index
let detail = false; // 상세페이지인 경우 jsp에서 true로 변경
let checkDelete = false; // 등록, 수정 페이지인 경우 jsp에서 true로 변경
let savedPListObj = {}; // 수정 전 저장되어 있던 사진 리스트
let starPhoto = {}; // 대표 사진을 담을 객체

// 사진 상세보기 관련 변수
const photoBg = document.getElementById('photoBg'); // 사진 상세보기 배경
let detailPhoto = ''; // 상세보기하는 사진
let photoBtnBox = ''; // 사진 상세보기에서 버튼을 담을 요소
let deactBtn = ''; // 사진 상세보기 종료 버튼
let enlargeBtn = ''; // 사진 상세보기 확대 버튼
let reduceBtn = ''; // 사진 상세보기 축소 버튼
let detailPhotoScale = 1; // 상세보기 사진 크기비율
let startX = 0;
let startY = 0;
let lastX = 0;
let lastY = 0;

// 경고창
let updateAlert = false;

// 정규표현식을 이용하여 등록 가능한 파일 제한
const regExp = new RegExp(".(jpg|jpeg|png|gif)$",'i'); // 등록 가능한 파일
const maxSize = 1024 * 1024 * 2; // 최대 파일 용량 2 MB

// file 형식 제한
function fileSizeValidation(fileName, fileSize) {
    if (!regExp.test(fileName)) {
        alert("jpg, jpeg, png, gif 형식의 사진 파일만 등록 가능합니다.");
        return false;
    } else if (fileSize > maxSize) {
        alert("용량이 2 MB를 초과하는 파일은 등록할 수 없습니다.");
        return false;
    } else return true;
}

document.addEventListener("click", (e) => {
    // 파일 추가
    if (e.target.classList.contains("addPhotoBtn")) {
        document.getElementById('files').click();
        checkPhotoBoxIndex(e.target);
    }

    // 파일 삭제
    if (e.target.classList.contains("deletePhotoBtn")) {
        let photo = e.target.closest('div');
        let deletePhoto = {uuid: photo.dataset.uuid, file_name: photo.dataset.file_name};
        deleteUuid = deletePhoto.uuid;
        let photoZone = photo.parentNode;
        photoBox = photoZone.parentNode;
        photoWrapper = photoBox.parentNode;
        document.querySelectorAll('.photoZone').forEach((el, i) => {if (el == photoZone) index = i;});
        // 컨트롤러로 보내서 파일 삭제
        $.ajax({
            url: "/photo/deleteFile", // 컨트롤러 URL
            data: JSON.stringify(deletePhoto),
            dataType: "text",
            processData: false,
            contentType: "application/json; charset=utf-8",
            type: "delete",
            success: function (response) { // 삭제가 된 경우
                pListObj[index].splice(pListObj[index].findIndex(checkUuid),1); // pList에서 해당 사진 정보 삭제
                callPhotoZone(photoZone);
                if (onlyOneArr.indexOf(type) != -1 || (mainArr.indexOf(type) != -1 && index == "0")) {
                    photoZone.innerHTML += `<button type="button" class="photoBtn addPhotoBtn">+</button>`;
                }
            },
            error: function (jqXHR) {
                alert(jqXHR.responseText);
            },
        });
    }

    // 글 수정
    if (e.target.id == "updateBtn") {
        if (mainArr.indexOf(type) != -1 && (pListObj[0] == undefined || pListObj[0].length == 0)) {
            alert('대표 사진을 선택하세요!');
            return;
        }
        if (requestUpdateInPhoto) requestUpdate();
    }

    // 글 삭제
    if (e.target.id == "deleteBtn") requestDelete();

    // 대표 사진 선택
    if (e.target.name == "star-outline") {
        document.getElementsByName("star-outline").forEach((el) => {el.name = "star-outline";});
        e.target.name = "star";
    } else if (e.target.name == "star") {e.target.name = "star-outline";}

    if (e.target.id == "updateProfileGetBtn") {
        if (e.target.classList.contains("on")) {
            detail = true;
            checkDelete = false;
            callPhotoZone(document.querySelector(".photoZone"));
        }else {
            detail = false;
            checkDelete = true;
            insertProfile(sessionID);
        }
    }
})

document.addEventListener("change", (e) => {
    // 파일 임시 저장
    if (e.target.id == "files"){ // change이므로 같은 파일을 재선택하면 실행되지 않음
        if(e.target.files[0] == undefined) return; // 파일이 선택되지 않은 경우 실행 X
        const fileObject = e.target.files;
        // 사진을 하나만 등록해야 하는 게시판에 다수의 파일을 선택한 경우 경고창
        if ((onlyOneArr.indexOf(type) != -1 && fileObject.length > 1)
            || (mainArr.indexOf(type) != -1 && index == "0" && fileObject.length > 1)) alert('하나의 파일만 선택하세요.');
        else{
            console.log(document.getElementsByTagName('form'));
            const form = new FormData(document.getElementsByTagName('form')[0]); // form 정보 가져오기
            let validResult = true;
            // 파일 형식, 용량 유효성 검사
            for (let file of fileObject) validResult *= fileSizeValidation(file.name, file.size);
            if(validResult) {
                // 임시 폴더에 파일 저장
                $.ajax({
                    url: "/photo/tmpRegister", // 컨트롤러 URL
                    data: form,
                    dataType: "json",
                    processData: false,
                    contentType: false,
                    type: "post",
                    success: function (response) { // 저장이 된 경우
                        response.forEach((el) => {
                            if (onlyOneArr.indexOf(type) != -1) {
                                let tmpPList = [el];
                                pListObj[index] = tmpPList; // 사진을 하나만 등록하는 게시판에서는 파일 정보 변경
                            }else pListObj[index].push(el); // 파일 정보 누적
                            console.log("pList >> "+JSON.stringify(pListObj));
                            callPhotoZone(photoBox.querySelector('.photoZone'));
                        });
                    },
                    error: function (jqXHR) {
                        alert(jqXHR.responseText);
                    },
                });
            }
        }
    }
});

// 사진 표시
function callPhotoZone(photoZone) {
    console.log("callPhotoZone("+photoZone+")");

    photoZone.innerHTML = "";
    if (!(mainArr.indexOf(type) != -1 && index == "0") && pListObj[index].length == 0) {
        photoWrapper.querySelector('.photoQty').innerText = `(0)`;
        let photoScroll = photoBox.querySelectorAll('.photoScroll');
        photoScroll.forEach((el) => {
            el.remove();
        })
    }
    pListObj[index].forEach((el) => {
        let div = document.createElement('div');
        div.setAttribute('data-uuid', `${el.uuid}`);
        div.setAttribute('data-file_name', `${el.file_name}`);
        if (detail){
            let img = document.createElement('img');
            img.setAttribute('alt', '사진이 없습니다.');
            img.setAttribute('src', `${el.save_dir}/${el.uuid}_${el.file_name}`);
            if (mainArr.indexOf(type) != -1 && index == "0") img.setAttribute('class', 'mainPhoto');
            else img.setAttribute('class', 'photo');
            // img.setAttribute('style', 'max-width: 1280px; max-height: 720px;');
            div.appendChild(img);
        }else{
            div.setAttribute('class', 'thumbnail');
            div.setAttribute('style', `width: 180px; height: 180px;
	            background-image: url('${el.save_dir}/${el.uuid}_th_${el.file_name}');
	            background-repeat: no-repeat;
	            background-position: center;
	            background-size: cover;`);
	        div.setAttribute('title', `${el.file_name}`);
        }
        if (checkDelete){
            // if (mainArr.indexOf(type) != -1) div.innerHTML = `<ion-icon name="star-outline" class="star" style="cursor: pointer;"></ion-icon>`;
            div.innerHTML += `<button type="button" class="photoBtn deletePhotoBtn">-</button>`;
            console.log(photoWrapper);
            photoWrapper.querySelector('.photoTitle').querySelector('.photoQty').innerText = `(${pListObj[index].length})`;
        }
        photoZone.appendChild(div);
    })
    console.log("checkDelete >> "+checkDelete);
    console.log("not onlyOne >> "+(onlyOneArr.indexOf(type) == -1));
    console.log("mainArr >> "+(mainArr.indexOf(type) != -1));
    console.log("index not 0? >> "+(index != "0"));
    if (checkDelete && (onlyOneArr.indexOf(type) == -1 && 
    ((mainArr.indexOf(type) != -1 && index != "0") || (mainArr.indexOf(type) == -1)))){
        console.log("add addPhotoBtn");
        photoZone.innerHTML += `<button type="button" class="photoBtn addPhotoBtn">+</button>`;
        // addPhotoBtn = document.getElementsByClassName('addPhotoBtn')[index];
        // addPhotoBtn.remove();
    }
    let prevPhoto = `<div class="photoScroll prevPhoto" onclick="scrPhoto('prev')"><ion-icon name="chevron-back-outline"></ion-icon></div>`;
    let nextPhoto = `<div class="photoScroll nextPhoto" onclick="scrPhoto('next')"><ion-icon name="chevron-forward-outline"></ion-icon></div>`;
    if (!(onlyOneArr.indexOf(type) != -1 || ((mainArr.indexOf(type) != -1 && index == "0")))
    && pListObj[index].length > 0 && photoZone.previousSibling.classList == undefined && checkDelete) {
        $(photoZone).before(prevPhoto);
        $(photoZone).after(nextPhoto);
    }
}

// pList에서 uuid index 검색에 사용하는 콜백함수
function checkUuid(el){if(el.uuid == deleteUuid) return true;}

function checkPhotoBoxIndex(btn) {
    console.log("checkPhotoBoxIndex("+btn+")");
	
	console.log("classList : "+btn.classList);
    photoBox = btn.parentNode.parentNode;
    photoWrapper = photoBox.parentNode;
    console.log("photoBox?? >> "+photoBox.innerHTML);
    Array.prototype.forEach.call(document.querySelectorAll('.photoBox'), (el, i) => {
        if (el == photoBox) index = i;
    })

    if (pListObj[index] == null) pListObj[index] = [];
    console.log(pListObj);
    console.log("index : "+index);
}

// 사진 등록 함수
function insertPhoto() {
    console.log("insertPhoto()");
    if (mainArr.indexOf(type) != -1 && (pListObj[0] == undefined || pListObj[0].length == 0)) {
        alert('대표 사진을 선택하세요!');
        return;
    }
    // 사진 파일 정식 저장
    $.ajax({
        url: "/photo/register", // 컨트롤러 URL
        // data: JSON.stringify(combindList),
        data: JSON.stringify(pListObj),
        dataType: "text",
        processData: false,
        contentType: "application/json; charset=utf-8",
        type: "post",
        success: function (response) { // 저장이 된 경우
            console.log("사진 저장 완료");
            document.getElementById("form").submit();
        },
        error: function (jqXHR) {
            alert(jqXHR.responseText);
        },
    });
}

// 레시피 게시판 사진 등록 함수
function insertRecipePhoto() {
    console.log("insertRecipePhoto()");

    if (pListObj[0] == undefined || pListObj[0].length == 0) {
        alert('대표 사진을 선택하세요!');
        return false;
    }
    // 사진 파일 정식 저장
    $.ajax({
        url: "/photo/register", // 컨트롤러 URL
        data: JSON.stringify(pListObj),
        dataType: "text",
        processData: false,
        contentType: "application/json; charset=utf-8",
        type: "post",
        success: function (response) { // 저장이 된 경우
            console.log("사진 저장 완료");
        },
        error: function (jqXHR) {
            alert(jqXHR.responseText);
            return false;
        },
    });
    return true;
}

function insertProfile(id) {
    console.log("insertProfile("+id+")");

    // 프로필 사진 정식 저장
    $.ajax({
        url: "/photo/registerProfile/"+id, // 컨트롤러 URL
        data: JSON.stringify(pListObj),
        dataType: "text",
        processData: false,
        contentType: "application/json; charset=utf-8",
        type: "post",
        success: function (response) { // 저장이 된 경우
            console.log("프로필 사진 저장 완료");
            document.getElementById("form").submit();
        },
        error: function (jqXHR) {
            alert(jqXHR.responseText);
        },
    });
}

// 서버에서 가져오는 pList를 위치에 따라 분류 후 사진 뿌리기
function savePList() {
    console.log("savePList()");

    pList.forEach((el)=>{
        index = el.file_name.substring(0,el.file_name.indexOf("_"));
        // el.file_name = el.file_name.substring(el.file_name.indexOf("_")+1);
        if (onlyOneArr.indexOf(type) != -1) {
            let tmpPList = [el];
            let tmpSavedPList = [el];
            pListObj[index] = tmpPList; // 사진을 하나만 등록하는 게시판에서는 파일 정보 변경
            savedPListObj[index] = tmpSavedPList; // 글 수정 시 pListObj랑 비교할 객체
        }else {
            if (pListObj[index] == undefined){ // 해당 index가 없는 경우 새 배열 추가
                let tmpPList = [el];
                let tmpSavedPList = [el];
                pListObj[index] = tmpPList;
                savedPListObj[index] = tmpSavedPList;
            }else {
                pListObj[index].push(el); // 파일 정보 누적
                savedPListObj[index].push(el);
            }
        }
        photoBox = document.getElementsByClassName('photoBox')[index];
        photoWrapper = photoBox.parentNode;
        callPhotoZone(photoBox.querySelector('.photoZone'));
    })
}

// 글 수정 함수
function requestUpdate(){
    console.log("requestUpdate()");

    let no = document.getElementsByName('no')[0].value; // 글 번호
    let combindList = {pListObj, savedPListObj};
    // 사진 파일 저장
    $.ajax({
        url: "/photo/update"+no, // 컨트롤러 URL
        data: JSON.stringify(combindList),
        dataType: "text",
        processData: false,
        contentType: "application/json; charset=utf-8",
        type: "put",
        success: function (response) { // 저장이 된 경우
            console.log("사진 수정 완료");
            if(updateAlert) alert('글이 수정되었습니다.');
            if (requestUpdateInPhoto) document.getElementById("form").submit(); // form 제출
        },
        error: function (jqXHR) {
            alert(jqXHR.responseText);
        },
    });
}

// photoBox 순서에 맞게 사진을 뿌려주는 함수
function addPhotos(no) {
    console.log("addPhotos("+no+")");

    index = no;
    console.log(JSON.stringify(pListObj));
    if (index > -1) {
        let keyList = [];
        for (let key in pListObj) {
            keyList.unshift(Number(key));
        }
        keyList.forEach((key) => { 
            if (key > index) {
                pListObj[key+1] = pListObj[key];
                delete pListObj[key];
            }
        });
    }
    for (let key in pListObj){
        index = key;
        photoBox = document.querySelectorAll('.photoBox')[index];
        callPhotoZone(photoBox.querySelector('.photoZone'));

    }

}

// 레시피에서 순서를 삭제하는 함수
function deletePhoto(no){
    console.log("deletePhoto("+no+")");

    index = no;
    let photoZoneArray = Array.from(document.querySelectorAll('.photoZone'));
    let photoZone = photoZoneArray[no];
	let photo = photoZone.querySelector('.thumbnail');
    
    // 사진 순서 변경
    delete pListObj[index];
    let keyList = [];
    for (let key in pListObj) {
        keyList.push(Number(key));
    }
    keyList.forEach((key) => {
        if (key > index) {
        	pListObj[key-1] = pListObj[key];
        	delete pListObj[key];
        }
    });
    
    console.log(photoZone);
    if(photo == null) return;
    let deletePhoto = {uuid: photo.dataset.uuid, file_name: photo.dataset.file_name};
    
    // 컨트롤러로 보내서 파일 삭제
    $.ajax({
        url: "/photo/deleteFile", // 컨트롤러 URL
        data: JSON.stringify(deletePhoto),
        dataType: "text",
        processData: false,
        contentType: "application/json; charset=utf-8",
        type: "delete",
        success: function (response) { // 삭제가 된 경우
        	console.log("file deleted");
        },
        error: function (jqXHR) {
            alert(jqXHR.responseText);
        },
    });
}

// 페이지의 모든 사진을 표시
function photoSpread(){
    for (let key in pListObj){
    	console.log("key : "+key);
        index = key;
        photoBox = document.querySelectorAll('.photoBox')[index];
        callPhotoZone(photoBox.querySelector('.photoZone'));
    }
}

// 사진 스크롤
function scrPhoto(direction){
	console.log("scrPhoto("+direction+")");
	
	console.log(direction);
	
	let scrIndex = -1;
	if(mainArr.indexOf(type) != -1) scrIndex = 1;
	else scrIndex = 0;
	photoBox = document.querySelectorAll('.photoBox')[scrIndex];
	photoZone = photoBox.querySelector('.photoZone');
	console.log(photoZone);
	
	if(direction == "prev") photoZone.scrollLeft -= 816;
	else if(direction == "next") photoZone.scrollLeft += 816;
}

// 사진 상세보기
document.addEventListener('click',(photo)=>{
	if(photo.target.parentNode.parentNode.classList.contains('slidePhoto')) {
        photoBg.style.zIndex = 100;
        photoBg.style.opacity = 1;
        // 상세보기할 이미지 생성
        detailPhoto = document.createElement('img');
        detailPhoto.classList.add('detailPhoto');
        detailPhoto.setAttribute('src',photo.target.src);
        photoBg.append(detailPhoto);
        // 버튼을 담을 요소 생성
        photoBtnBox = document.createElement('div');
        photoBtnBox.classList.add('photoBtnBox');
        photoBg.append(photoBtnBox);
        // 이미지 상세보기를 종료할 버튼 생성
        deactBtn = document.createElement('div');
        deactBtn.classList.add('deactBtn');
        deactBtn.innerHTML = `<ion-icon name="close-outline"></ion-icon>`;
        photoBtnBox.append(deactBtn);
        // 상세보기 종료
        deactBtn.addEventListener('click',()=>{
            photoBtnBox.remove();
            detailPhoto.remove();
            photoBg.style.zIndex = -100;
            photoBg.style.opacity = 0;
        })
        detailPhotoScale = 1; // 최초 사진 크기
        // 축소버튼 생성
        reduceBtn = document.createElement('div');
        reduceBtn.classList.add('reduceBtn');
        reduceBtn.innerHTML = `<ion-icon name="contract-outline"></ion-icon>`;
        photoBtnBox.append(reduceBtn);
        // 이미지 축소
        reduceBtn.addEventListener('click', reduce);
        // 확대버튼 생성
        enlargeBtn = document.createElement('div');
        enlargeBtn.classList.add('enlargeBtn');
        enlargeBtn.innerHTML = `<ion-icon name="expand-outline"></ion-icon>`;
        photoBtnBox.append(enlargeBtn);
        // 이미지 확대
        enlargeBtn.addEventListener('click', enlarge)
        // 마우스로 이동
        detailPhoto.addEventListener('click',(e)=>{
            if(detailPhoto.classList.contains('active')) {
                removeMove();
                detailPhoto.classList.remove('active');
                return;
            }
            detailPhoto.classList.add('active');
            // 마우스를 처음 누른 위치값 저장
            startX = e.clientX;
            startY = e.clientY;

            photoBg.style.cursor = 'move';

            document.addEventListener('mousemove', onMove);
        })
	}
});
// 이미지 확대
function enlarge(){
    console.log('enlarge()');

    if(detailPhotoScale < 2) {
        detailPhotoScale += 0.25;
        detailPhoto.style.transform = 'scale(' + detailPhotoScale + ')';
    }
    cursorCheck();
}
// 이미지 축소
function reduce(){
    console.log('reduce()');

    if(detailPhotoScale > 1) {
        detailPhotoScale -= 0.25;
        detailPhoto.style.transform = 'scale(' + detailPhotoScale + ')';
    }
    cursorCheck();
}
// 확대 축소 커서 모양 설정
function cursorCheck(){
    if(detailPhotoScale == 1) {
        reduceBtn.style.cursor = 'auto';
        enlargeBtn.style.cursor = 'pointer';
    }else if(detailPhotoScale == 2) {
        reduceBtn.style.cursor = 'pointer';
        enlargeBtn.style.cursor = 'auto';
    }else {
        reduceBtn.style.cursor = 'pointer';
        enlargeBtn.style.cursor = 'pointer';
    }
}
// 마우스로 이미지 이동
function onMove(e){
    photoBg.style.cursor = 'move';
    lastX = startX - e.clientX;
    lastY = startY - e.clientY;
    
    startX = e.clientX;
    startY = e.clientY;

    detailPhoto.style.top = `${detailPhoto.offsetTop - lastY}px`;
    detailPhoto.style.left = `${detailPhoto.offsetLeft - lastX}px`;
}
// 
function removeMove(){
    photoBg.style.cursor = 'default';
    document.removeEventListener('mousemove', onMove);
}