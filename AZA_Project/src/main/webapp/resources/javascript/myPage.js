// 회원 수정
document.addEventListener("click", (e) => {
    if(e.target.classList.contains("updateMemberGetBtn")){
        console.log("get click");
        nickName = $("#memberInfoText .nickName");
        console.log(nickName);
        span = nickName.children("span");
        input = $("<input>")
            .prop("type", "text")
            .val(span.text());
		console.log(input);

        span.remove();
        nickName.append(input);
    
        $(e.target).addClass("updateMemberPutBtn").removeClass("updateMemberGetBtn");
    }else if(e.target.classList.contains("updateMemberPutBtn")){
    	const regexNickName = /^[a-zA-Z0-9\_\-!☆★ㄱ-ㅎ가-힣]{2,10}$/; // 영어 대소문자, 한글, 숫자, _, -, ☆, ★만을 포함한 2~10글자
    
        console.log("put click");
        nickName = $("#memberInfoText .nickName");
        input = nickName.children("input");

        if(input.val().length == 0){
            alert("내용이 없습니다.");
            return;
        }else if(!regexNickName.test(input.val())){
        	alert("닉네임 규칙을 확인해주세요.");
        	return;
        }
        
        data = {
        	id: sessionID,
        	nick_name: input.val()
        }
        updateMemberPut(data).then(result => {
    		if(result > 0){
		        span = $("<span>")
		            .text(input.val());
		    
		        input.remove();
		        nickName.append(span);
		    
		        $(e.target).addClass("updateMemberGetBtn").removeClass("updateMemberPutBtn");
    		}else alert("중복된 닉네임입니다.");
        });
    }
})

async function updateMemberPut(data){
    try{
        const url = "/member/update";
        const config = {
            method : 'put',
            headers : {
            	'content-type' : 'application/json; charset=utf-8'
            },
            body: JSON.stringify(data)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    }catch(error){
        console.log(error);
    }
}


