callMemberWrapper();

async function insertMeetingMember() {
    try {
        const url = "/meetingMember/" + no;
        const config = {
            method: "post",
            headers: {
                "content-type": "application/json; charset=utf-8",
            },
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        callMemberWrapper();
        return result;
    } catch (error) {
        console.log(error);
    }
}

async function deleteMeetingMember() {
    try {
        const url = "/meetingMember/" + no;
        const config = {
            method: "delete",
            headers: {
                "content-type": "application/json; charset=utf-8",
            },
            body: thisMember,
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        callMemberWrapper();
        return result;
    } catch (error) {
        console.log(error);
    }
}

async function selectMemberList() {
    try {
        const resp = await fetch("/meetingMember/" + no);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

function callMemberWrapper() {
    let isJoin = 0;
    const memberWrapper = document.getElementById("memberWrapper");
    selectMemberList().then((result) => {
        let list = "";
        for (let member of result) {
            list += `<div class="meetingMember"><span>${member.member_nick_name}</span></div>`;
            if (member.member_nick_name == thisMember) isJoin = 1;
        }
        if (isJoin == 1) {
            if (detail) memberWrapper.innerHTML =
                `<div class="meetingTop"><div class="meetingTopLeft"><span>펫 모임 명단</span></div>
                <button type="button" id="deleteMemberBtn">참여 취소</button></div><hr class="meetingLine">`;
            // detail이 아닌 경우의 구문을 위에 먼저 쓰는 경우 meetingTop div가 자동으로 닫혀서 아래에 작성함
            else memberWrapper.innerHTML = `<div class="meetingTop"><div class="meetingTopLeft"><span>펫 모임 명단</span></div>`;
            memberWrapper.innerHTML += list;
        } else {
            if (detail) {
                memberWrapper.innerHTML = 
                	`<button type="button" id="insertMemberBtn">
                    <ion-icon name="paw" class="insertMemberBtn"></ion-icon>
                    <span class="insertMemberBtn">모임 참여</span>
                    </button>`;
            }
        }
    });
}

document.addEventListener("click", (e) => {
    let targetId = e.target.id;
    let classList = e.target.classList
    if (targetId == "insertMemberBtn" || classList.contains('insertMemberBtn')) {
        if (thisMember == "") alert("로그인 후 이용하세요");
        else insertMeetingMember();
    }
    if (targetId == "deleteMemberBtn") deleteMeetingMember();
});
