$(".deleteBtn").on("click", function(e){
    if(confirm("해당 게시글을 삭제하시겠습니까?")==true){
        let a = $(e.target);
        location.href=`/community/delete/${post_no}`;
    }
})
