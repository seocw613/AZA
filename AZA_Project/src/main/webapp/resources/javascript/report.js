document.addEventListener("click", (e) => {
	data = {
		type: type,
		post_no: post_no,
		member_id: sessionID
	};
	if($(e.target).hasClass("report") && $(e.target).hasClass("insert")) insertReport(data);
})

function insertReport(data){
	insertReportPost(data).then(result => {
		if(result>0){
			alert("신고!");
            window.location.reload();
		}
	})
}

async function insertReportPost(data){
    try{
        const url = "/report/";
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

function isReport(data){
	isReportPost(data).then(result => {
        result = Number(result);
		if(result > 0){
            console.log("isReport result : "+result);
            $(".report").removeClass("insert").addClass("delete");
		}
	})
}

async function isReportPost(data){
    try{
        const url = "/report/isReport"; 
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