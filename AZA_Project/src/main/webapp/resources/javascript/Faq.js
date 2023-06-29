// List Button 방식 FAQ 위아래 변경 JS 코드

(function(){
    const doms = document.getElementsByClassName('dom');
    for(let dom of doms){
        dom.addEventListener('click', on_click_dom);
    }
})();
 
function on_click_dom(e){
    e = e || window.event;
    const target = e.target;
    switch(target.tagName){
        case "LI" :
            add_on_li(target);
            break;
        case "BUTTON" :
            set_up_down(target);
            break;
        default :
            break;
    }//switch
}//on_click_dom
 
function add_on_li(target){
    if(!target){return;}
    const parent = target.parentElement;
    const all_child = parent.children;
    const siblings = Array.prototype.filter.call(all_child, li => li != target);
    
    for(let li of siblings){li.classList.remove('on');}
 
    target.classList.toggle('on');
}//add_on_li
 
function set_up_down(target){
    //선택된 li가 없으면 early return
    const this_ul = target.parentElement.nextElementSibling;
    const all_li = this_ul.children;
    const liON = this_ul.getElementsByClassName('on')[0];
    if(!liON){return}
 
    //선택된 li의 index를 가져온다.
    const idx = get_li_idx(all_li,liON);
 
    //복사한 li
    const copyLI = copy_li_on(liON);
 
    //선택한 버튼에 따라 복사하고
    const final_idx = apply_li_on(target,idx,all_li,copyLI);
 
    //원본은 지운다
    delete_original(final_idx,liON,this_ul);
 
    //li.on 다시 붙임
    add_on_li(all_li[final_idx]);
 
}//set_up_down
 
function get_li_idx(all_li,liON){
    const li_idx = Array.prototype.indexOf.call(all_li, liON);
    return li_idx;
}//get_li_idx
 
function copy_li_on(liON){
    const copyLI = document.createElement('LI');
    copyLI.innerHTML = liON.innerHTML;
    return copyLI;    
}//copy_li_on
 
function apply_li_on(target,idx,all_li,copyLI){
    if(target.classList.contains('btn_up')){
        const final_idx = idx - 1;
        if(final_idx < 0){return;}
        all_li[final_idx].before(copyLI);
        return final_idx;
    }else{
        const final_idx = idx + 1;
        if(final_idx >= all_li.length){return;}
        all_li[final_idx].after(copyLI);
        return final_idx;
    }//if
}//apply_li_on
 
function delete_original(final_idx,liON,this_ul){
    if(final_idx == undefined || final_idx == null){return;}
    this_ul.removeChild(liON);
}//delete_original



//FAQ 기본적인 CRUD 이벤트 
function regCheck(){
    alert("추가완료!!");
}

function upCheck(){
    alert("수정완료!!");
}

function delCheck(){    
       
    var result = confirm("정말 삭제하시겠습니까?");
	
	if(result == true) {
		alert("삭제 하였습니다");
        return true;
	} 
	else {
		alert("취소 하였습니다");
        return false;
	}    
}   
