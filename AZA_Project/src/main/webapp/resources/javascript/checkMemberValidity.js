function checkMemberValidity(f){
	id = f.id.value;
	pw = f.pw.value;
	nick_name = f.nick_name.value;
    
    if(!checkIDValidity(id)){
		alert("아이디 규칙을 확인해주세요.");
    	return false;
    }else if(!checkPWValidity(pw)){
		alert("비밀번호 규칙을 확인해주세요.");
    	return false;
    }else if(!checkNick_nameValidity(nick_name)){
		alert("닉네임 규칙을 확인해주세요.");
    	return false;
    }

    return true;
}

function checkIDValidity(data){
    const regex = /^[a-zA-Z0-9]{6,16}$/; // 영어 대소문자, 숫자만을 포함한 6~16글자
	return regex.test(data);
}
function checkPWValidity(data){
    const regex = /^[a-zA-Z0-9@$!%*#?&]{6,20}$/;
	return regex.test(data);
}
function checkNick_nameValidity(data){
    const regex = /^[a-zA-Z0-9\_\-!☆★ㄱ-ㅎ가-힣]{2,10}$/; // 영어 대소문자, 한글, 숫자, _, -, ☆, ★만을 포함한 2~10글자
	return regex.test(data);
}

$("input[name='id']").on("input", function(){
	value = $(this).val();
	inputStatus = $(this).siblings(".inputStatus");
	if(checkIDValidity(value)){
		inputStatus.addClass("on");
	}else inputStatus.removeClass("on");
})

$("input[name='pw']").on("input", function(){
	value = $(this).val();
	inputStatus = $(this).siblings(".inputStatus");
	if(checkPWValidity(value)){
		inputStatus.addClass("on");
	}else inputStatus.removeClass("on");
})

$("input[name='nick_name']").on("input", function(){
	value = $(this).val();
	inputStatus = $(this).siblings(".inputStatus");
	if(checkNick_nameValidity(value)){
		inputStatus.addClass("on");
	}else inputStatus.removeClass("on");
})