
document.addEventListener('click',(e)=>{
    if(e.target.classList.contains("delete")){
        if(confirm("해당 게시글을 삭제하시겠습니까?")==true){
            let a = e.target.closest('a');
            if(type=='B'){
                a.href=`/boast/delete?no=${post_no}`;
            }else if(type=='R'){
                a.href=`/recipe/delete?no=${post_no }`;
            }

        }
    }
})

