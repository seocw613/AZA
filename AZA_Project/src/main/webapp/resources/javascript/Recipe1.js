const textArr = [];
arrSpread();


document.getElementById("insertBtn").addEventListener("click",()=>{

    let isOk=true;
    let title = document.getElementById("title").value;
    let writer = document.getElementById("writer").value;
    let animal = document.getElementById("animal").value;
    let material = document.getElementById("material").value;
    let content="";
    arrGet();
    textArr.forEach(e =>{
        if(e.length==0){
            isOk=false;
            alert("조리순서 내용이 비어있습니다.")
        }
        content+="@&";
        content+=e;
    })

    if(title.length==0){
        alert("제목을 입력하세요.");
        isOk=false;
    }else if(animal.length==0){
        alert("동물을 선택하세요.");
        isOk=false;
    }else if(material.length==0){
        alert("준비물 및 재료를 입력하세요.");
        isOk=false;
    }else if(content.length==2){
        alert("조리 순서를 입력하세요.");
        isOk=false;
    }

    if(isOk == true){
        let recipeData = {
            title: title,
            writer: writer,
            animal: animal,
            material: material,
            content: content
        };
        
        if(!insertRecipePhoto()) return;
        
        setTimeout(()=>{
            registerRecipe(recipeData).then(result => {
                console.log(result);
                if(result>0){
                    location.href="/recipe/list?insert_msg=1";
            
                }
            })
        },100);

    }
    

})


async function registerRecipe(recipeData){
    try {
        const url = '/recipe/register';
        const config ={
            method:"post",
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




document.addEventListener('click',(e)=>{
    if(e.target.classList.contains("add")){
        let li = e.target.closest("li");
        let no = Number(li.dataset.number);
        console.log(no);
        arrGet();
        textArr.splice(no,0,"");

        console.log("arrGet textArr>> "+textArr);
        console.log(textArr.toString);
        arrSpread();
        addPhotos(no);
    }else if(e.target.classList.contains("del")){
        let li = e.target.closest("li");
        let no = Number(li.dataset.number);
        deletePhoto(no);
        li.remove();
        arrGet();
        arrSpread();
        photoSpread();
    }
})


function arrGet(){
    textArr.length=0;
    const textArr1 = document.querySelectorAll(".insertContent");
    textArr1.forEach((t)=>{
        textArr.push(t.value);
    }) 
    console.log("arrGet textArr>> "+textArr);

}

function arrSpread(){
    let ol = document.getElementById("recipeList");
    const text1 = textArr.length == 0? "":textArr[0];
    let li = `<li data-number="1" class="contentOne"><div class="contentNum">1.</div>
        <textarea rows="2" cols="30" placeholder="내용을 입력하세요." class="insertContent">${text1}</textarea>
        <div class="fileBtn"><div id="photoWrapper"><span class="photoTitle">
        <span class="photo">사진</span><span class="photoQty onePhoto">(0)</span></span>
        <div class="photoBox"><div class="photoZone" data-index="0">
		<button type="button" class="photoBtn addPhotoBtn">+</button></div></div></div>
    <button type="button" class="insertContentBtn add">+</button></li>`;
    for(let i =1;i<textArr.length;i++){
        li += `<li data-number="${i+1}" class="contentOne"><div class="contentNum">${i+1}.</div>
        <textarea rows="2" cols="30" placeholder="내용을 입력하세요." class="insertContent">${textArr[i]}</textarea>
        <div class="fileBtn"><div id="photoWrapper"><span class="photoTitle">
        <span class="photo">사진</span><span class="photoQty onePhoto">(0)</span></span>
        <div class="photoBox"><div class="photoZone" data-index="${i+1}">
		<button type="button" class="photoBtn addPhotoBtn">+</button></div></div></div>
        <button type="button" class="delContentBtn del">-</button></div>
        <button type="button" class="insertContentBtn add">+</button></li>`;
    }
    ol.innerHTML=li;
}



