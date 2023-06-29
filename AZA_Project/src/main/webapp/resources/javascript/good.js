document.addEventListener("click", (e) => {
	data = {
		type: type,
		post_no: post_no,
		member_id: sessionID
	};
	console.log(e.target.classList);
	if($(e.target).hasClass("good")) {
		if($(e.target).hasClass("insert")) insertGood(data);
		if($(e.target).hasClass("delete")) deleteGood(data);
	}
})


function insertGood(data){
	insertGoodPost(data).then(result => {
		if(result>0){
			alert("추천!");
            window.location.reload();
		}
	})
}

async function insertGoodPost(data){
    try{
        const url = "/good/";
        const config = {
            method : 'post',
            headers : {
            	'content-type' : 'application/json; charset=utf-8'
            },
            body: JSON.stringify(data)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    }catch(error){
        console.log(error);
    }
}

function deleteGood(data){
	deleteGoodDelete(data).then(result => {
		if(result>0) window.location.reload();
	})
}

async function deleteGoodDelete(data){
    try{
        const url = "/good/";
        const config = {
            method : 'delete',
            headers : {
            	'content-type' : 'application/json; charset=utf-8'
            },
            body: JSON.stringify(data)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    }catch(error){
        console.log(error);
    }
}

function isGood(data){
	isGoodPost(data).then(result => {
        result = Number(result);
		if(result > 0){
            $(".good").removeClass("insert").addClass("delete");
		}else{
            $(".good").removeClass("delete").addClass("insert");
        } 
	})
}

async function isGoodPost(data){
    try{
        const url = "/good/isGood"; 
        const config = {
            method : 'post',
            headers : {
            	'content-type' : 'application/json; charset=utf-8'
            },
            body: JSON.stringify(data)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    }catch(error){
        console.log(error);
    }
}