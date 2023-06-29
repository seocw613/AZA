let animalAll = document.getElementById("animalAll");
let animalDog = document.getElementById("animalDog");
let animalCat = document.getElementById("animalCat");
let animalElse = document.getElementById("animalElse");

function getAnimalInfo(animal){
	// 기존의 animal 정보를 받아와서 옵션들의 체크를 제어
    if(animal.includes("1")) animalDog.checked=true;
    if(animal.includes("2")) animalCat.checked=true;
    if(animal.includes("3")) animalElse.checked=true;
    is_checked_all();
}

animalAll.addEventListener("click", (e) => {
	// 전체 옵션 클릭 이벤트 핸들러
	// 전체 옵션의 체크 여부에 따라서 다른 항목들의 체크를 제어 
    if (e.target.checked) {
        animalDog.checked = true;
        animalCat.checked = true;
        animalElse.checked = true;
    } else {
        animalDog.checked = false;
        animalCat.checked = false;
        animalElse.checked = false;
    }
    saveAnimalValue();
});

function is_checked_all() {
	// 전체 옵션 체크 제어 함수
	// 항목들의 체크 여부를 확인하여 전체 옵션의 체크를 제어 
    if(animalDog.checked && animalCat.checked && animalElse.checked) {
        animalAll.checked = true;
    }else animalAll.checked = false;
    saveAnimalValue();
}

function saveAnimalValue() {
	// input태그의 value에 체크된 옵션들의 값을 모아서 넣어주는 함수
    const animalArr = document.querySelectorAll(".animal");
    let animalValue = "";
    animalArr.forEach(el => {if(el.checked) animalValue += el.value;});
    document.getElementById("animal").value = animalValue;
}

animalDog.addEventListener("click", () => is_checked_all());
animalCat.addEventListener("click", () => is_checked_all());
animalElse.addEventListener("click", () => is_checked_all());