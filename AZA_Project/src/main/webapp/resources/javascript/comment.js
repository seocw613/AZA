// 댓글 작성 버튼 클릭
$("#commentWriteBtn").on("click", (e)=>{
    content = e.target.previousElementSibling.value;
    commentWrite(content);
});

// 클릭 이벤트 리스너
document.addEventListener("click", (e)=>{
    // 댓글 수정 불러오기 버튼 클릭
    if(e.target.classList.contains("commentModifyGet")){
        commentModifyGet(e.target.dataset.no).then(result => {
            if(result){
                commentContentDiv = $(e.target).parent().prev();
                commentContentDiv.text("");
                textarea = $("<textarea>")
                    .val(result.content);
                commentContentDiv.append(textarea);
            }
            $(e.target).addClass("commentModifyPut").removeClass("commentModifyGet");
        });
    }
    
    // 댓글 수정 전송 버튼 클릭
    if(e.target.classList.contains("commentModifyPut")){
        commentData = {
            no: e.target.dataset.no,
            content: $(e.target).parent().prev().children("textarea").val()
        }
        commentModifyPut(commentData).then(result => {
            if(result > 0){
                alert("댓글이 수정되었습니다.");
                $(e.target).parent().prev().html(commentData.content);
                $(e.target).addClass("commentModifyGet").removeClass("commentModifyPut");
            }
        });
    }

	// 댓글 삭제 버튼 클릭
    if(e.target.classList.contains("commentDelete")){
        commentDeleteDelete(e.target.dataset.no).then(result => {
            if(result > 0){
                alert("댓글이 삭제되었습니다.");
                commentList(post_no);
            }
        });
    }
})


// 댓글 작성
function commentWrite(content){
    if(content.length == 0){
        alert("작성된 댓글 내용이 없습니다.");
        return;
    }

    commentData = {
        type: type,
        post_no: post_no,
        writer: sessionNickName,
        content: content
    };
    commentWritePost(commentData).then(result => {
        if(result > 0){
            alert("댓글이 등록되었습니다.");
            $("#commentWriteBtn").prev().val("");
            commentList(post_no);
        }
    });
}

async function commentWritePost(commentData){
    try{
        const url = "/comment/";
        const config = {
            method : 'post',
            headers : {
            	'content-type' : 'application/json; charset=utf-8'
            },
            body: JSON.stringify(commentData)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    }catch(error){
        console.log(error);
    }
}


// 댓글 목록
function commentList(){
	commentData = {
        type: type,
        post_no: post_no
    };

    commentListGet(commentData).then(result => {
        if(result.length > 0){
            spreadCommentList(result);
        }else{
            document.getElementById("commentList").innerHTML = "댓글이 없습니다..";
        }
    });
}

async function commentListGet(commentData){
    try {
    	const url = "/comment/list/";
        const config = {
            method : 'post',
            headers : {
            	'content-type' : 'application/json; charset=utf-8'
            },
            body: JSON.stringify(commentData)
        };
        const response = await fetch(url, config);
        const result = await response.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

function spreadCommentList(result){
    $("#commentList").html("");
    ul = $("<ul>");
    for(i=0; i<result.length; i++){
        li = $("<li>");
        li.append($("<div>").addClass("commentProfilePhoto"));
        commentInfo = $("<div>").addClass("commentInfo");
		commentInfo.append($("<span>").addClass("writer").text(`${result[i].writer}`));
		commentInfo.append($("<span>").addClass("postDate").text(`${result[i].post_date}`));
        li.append(commentInfo);
        li.append($("<div>").addClass("commentContent").text(`${result[i].content}`));
        commentBtn = $("<div>").addClass("commentBtn");
        commentBtn.append(
            $("<button>")
            .prop("type", "button")
            .addClass("commentModifyGet")
            .text("수정")
            .attr("data-no", result[i].no));
        commentBtn.append(
            $("<button>")
            .prop("type", "button")
            .addClass("commentDelete")
            .text("삭제")
            .attr("data-no", result[i].no));
        li.append(commentBtn);
        li.append($("<br>"));
        ul.append(li);
    }
    $("#commentList").append(ul);
}


// 댓글 수정
async function commentModifyGet(no){
    try {
        const response = await fetch("/comment/modify/"+no);
        const result = await response.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

async function commentModifyPut(commentData){
    try{
        if(commentData.content.length == 0){
            alert("작성된 댓글 내용이 없습니다.");
            return;
        }
        const url = "/comment/";
        const config = {
            method : 'put',
            headers : {
            	'content-type' : 'application/json; charset=utf-8'
            },
            body: JSON.stringify(commentData)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    }catch(error){
        console.log(error);
    }
}


// 댓글 삭제
async function commentDeleteDelete(no){
    try{
        const url = "/comment/"+no;
        const config = {
            method : 'delete'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    }catch(error){
        console.log(error);
    }
}