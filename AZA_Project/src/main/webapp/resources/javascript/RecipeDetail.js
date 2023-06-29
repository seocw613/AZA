
console.log(typeof content);
setContentArr(content);

function setContentArr(content){
    const contentArr1= content.substring(6).split("@&amp;");
    console.log(contentArr1);
    spreadContent(contentArr1);

}

function spreadContent(contentArr1){
    let ol = document.getElementById("recipeList");
    let li="";
    for(let i=0;i<contentArr1.length;i++){
        li+= `<li class="contentOne"><div class="contentNum">${i+1}.</div>
            <div class="recipeOne">${contentArr1[i]}</div>
            <div class="photoBox">
                <div class="photoZone"></div>
            </div></li>`;
    }
    ol.innerHTML+=li;
}