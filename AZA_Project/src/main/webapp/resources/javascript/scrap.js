document.addEventListener("click", (e) => {
	data = {
		type: type,
		post_no: post_no,
		member_id: sessionID
	};
	if($(e.target).hasClass("scrap")) {
		if($(e.target).hasClass("insert")) insertScrap(data);
		if($(e.target).hasClass("delete")) deleteScrap(data);
	}
})

function insertScrap(data){
	insertScrapPost(data).then(result => {
		if(result>0){
			alert("스크랩!");
            window.location.reload();
		}
	})
}

async function insertScrapPost(data){
    try{
        const url = "/scrap/";
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

function deleteScrap(data){
	deleteScrapDelete(data).then(result => {
		if(result>0) window.location.reload();
	})
}

async function deleteScrapDelete(data){
    try{
        const url = "/scrap/";
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

function isScrap(data){
	isScrapPost(data).then(result => {
        result = Number(result);
		if(result > 0){
            $(".scrap").removeClass("insert").addClass("delete");
		}else{
            $(".scrap").removeClass("delete").addClass("insert");
        } 
	})
}

async function isScrapPost(data){
    try{
        const url = "/scrap/isScrap"; 
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