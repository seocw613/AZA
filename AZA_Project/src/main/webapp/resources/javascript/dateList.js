data = {
    pageNo: 1,
    qty: 5,
    arrange: "good_count",
    date: ""
}

$("#day, #week, #month").on("click", (e) => {
	id = $(e.target).attr("id");
	communityDateList(id);
    $(".dateListBtn").removeClass("on");
    $(e.target).addClass("on");
});

function communityDateList(date){
    data.date = date;
    communityDateListPost(data).then(result => {
        if(result.length > 0){
        	$("table#dateList thead").css("display", "table-header-group");
            spreadList(result);
        }else{
    		console.log("result.length : "+result.length);
    		$("table#dateList thead").css("display", "none");
        	$("table#dateList tbody").html("글이 없습니다.");
    	}
    });
}

async function communityDateListPost(data){
    try {
    	const url = "/community/list";
        const config = {
            method : 'post',
            headers : {
            	'content-type' : 'application/json; charset=utf-8'
            },
            body: JSON.stringify(data)
        };
        const response = await fetch(url, config);
        const result = await response.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

function spreadList(result){
	tbody = $("table#dateList tbody");
    tbody.html("");
    for(i=0; i<result.length; i++){
        tr = $("<tr>");
        tr.append($("<td>").text(`${result[i].no}`));
        td = $("<td>");
        a = $("<a>").attr("href", `/community/detail/${result[i].no}`).text(`${result[i].title}`);
        td.append(a);
        tr.append(td);
        tr.append($("<td>").text(`${result[i].writer}`));
        tr.append($("<td>").text(`${result[i].read_count}`));
        tr.append($("<td>").text(`${result[i].good_count}`));
        tr.append($("<td>").text(`${result[i].post_date}`));
        tbody.append(tr);
    }
}