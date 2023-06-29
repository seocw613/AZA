const textArr=[];

document.getElementById("updateBtn").addEventListener("click",()=>{
    let no=noVal;
    let title=document.getElementById("title").value;
    let writer=document.getElementById("writer").value;
    let animal=document.getElementById("animal").value;
    let material=document.getElementById("material").value;
    let content="";
    getArr();
    for(let value of textArr){
        content+="@&";
        content+=value;
    }
    
    requestUpdate();
    let recipeData = {
        no:no,
        title:title,
        writer:writer,
        animal:animal,
        material:material,
        content:content
    }
    registerRecipe(recipeData).then(result=>{
        if(result>0){
            location.href="/recipe/detail?no="+no+"&update_msg=1";

        }
    })
})

async function registerRecipe(recipeData){
    try {
        const url='/recipe/update';
        const config={
            method: 'put',
            headers: {
                'content-type': 'application/json; charset=utf-8'
            },
            body:JSON.stringify(recipeData)
        };

        const resp = await fetch(url, config);
        const result = await resp.text() ;
        return result;
        
    } catch (error) {
        console.log(error);
    }
}


getContent(content);
function getContent(content){
    const contentArr=content.substring(6).split("@&amp;");
    for(let value of contentArr ){
        textArr.push(value);
    }
    console.log(contentArr);
    spreadContent(contentArr);

}

function spreadContent(contentArr){
    let ol=document.getElementById("recipeList");
    ol.innerHTML="";
    let li="";
    li+=  `<li data-number="1" class="contentOne"><div class="contentNum">1.</div>
        <textarea rows="2" cols="30" class="insertContent">${contentArr[0]}</textarea>
        <div class="fileBtn"><div id="photoWrapper"><span class="photoTitle">
        <span class="photo">사진</span><span class="photoQty onePhoto">(0)</span></span>
        <div class="photoBox"><div class="photoZone" data-index="1">
		<button type="button" class="photoBtn addPhotoBtn">+</button></div></div></div><div>
        <button type="button" class="insertContentBtn add">+</button></li>`;
    for(let i=1;i<contentArr.length;i++){
        li+=  `<li data-number="${i+1}" class="contentOne"><div class="contentNum">${i+1}.</div>
        <textarea rows="2" cols="30" class="insertContent">${contentArr[i]}</textarea>
        <div class="fileBtn"><div id="photoWrapper"><span class="photoTitle">
        <span class="photo">사진</span><span class="photoQty onePhoto">(0)</span></span>
        <div class="photoBox"><div class="photoZone" data-index="${i+1}">
		<button type="button" class="photoBtn addPhotoBtn">+</button></div></div></div>
        <button type="button" class="delContentBtn del">-</button></div>
        <button type="button" class="insertContentBtn add">+</button></li>`;
    }
    ol.innerHTML+=li;
}


document.addEventListener("click",(e)=>{
    if(e.target.classList.contains("add")){
        let li=e.target.closest("li");
        let no=li.dataset.number;
        getArr();
        console.log(no);
        console.log(textArr);
        textArr.splice(no,0,"");
        spreadContent(textArr);
        console.log(textArr);    
        addPhotos(no);   
    }else if(e.target.classList.contains("del")){
        let li=e.target.closest("li");
        let no=li.dataset.number;
        deletePhoto(no);
        li.remove();
        getArr();
        spreadContent(textArr);
        photoSpread();
    }
})
function getArr(){
    textArr.length=0;
    const getArr=document.querySelectorAll(".insertContent");
    getArr.forEach((e)=>{
        console.log(e.value);
        textArr.push(e.value);
    })
    console.log(textArr);
}