// 비번입력해야 상세페이지 open

function inputPw(insertPassword) {


var goodURL  = "/question/detail/"+insertPassword   //이곳에 인증이 되었을때 이동할 페이지  입력
    alert("올바른 비밀번호를 입력해주세요.")

var password =  prompt("비밀번호 입력","")

    if (password == null)  {
        alert("비밀번호를 입력해주세요.")
        location.href  = "/question/list"        // location  = "실패시 이동 주소url 입력"  //history.back();를 넣어도 됨
    }
    else  {
        var  combo =  password;
        var  total =  combo.toLowerCase();

        if  (total == "1234")  {                // 비밀번호
            alert("비밀글을 열람합니다.")
            location.href  =  goodURL;
        }
        else  {
            alert("틀린 비밀번호 입니다.")
            location.href  = "/question/list";
        }
    }
}

//문의글 빈항목 존재시 오류메세지 출력후, 빈항목으로 커서이동 
function regCheck(){

    var p1 = document.getElementById('insertPassword').value;
    var p2 = document.getElementById('checkPassword').value;

    
    if (frm.title.value.length==0) {
        alert('제목이 입력되지 않았습니다');
        frm.title.focus()
        return false;
    }        

    else if (frm.writer.value.length==0) {
        alert('작성자가 입력되지 않았습니다');
        frm.writer.focus();        
        return false;
    }

       
    else if (frm.content.value.length==0) {
        alert('내용이 입력되지 않았습니다');
        frm.content.focus()
        return false;
    }
        
    else if (frm.pw.value.length==0) {
        alert('비밀번호가 입력되지 않았습니다');
        frm.pw.focus()
        return false;
    }

    else if (frm.pw2.value.length==0) {
        alert('확인 비밀번호가 입력되지 않았습니다');
        frm.pw2.focus()
        return false;
    }
        
    else if (p1.length < 4) {
        alert('비밀번호는 4자 이상 입력해주세요');
        frm.pw.focus()
        return false;
    }
    
    else if (p1 != p2) {
        alert('비밀번호가 일치하지 않습니다');
        frm.pw.focus()
        return false;
    }
    
    else if (frm.is_lock == "") {
        alert('비밀글 동의여부를 체크해주세요');
        frm.is_lock.focus();        
        return false;
    }

    else {
        alert('등록완료!!');
        frm.writer.focus();
        insertPhoto();
    }
}
    