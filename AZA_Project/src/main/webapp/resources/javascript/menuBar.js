$("#menuBtn").click(() => {
    $("#menuBar").toggleClass("on");
})

$("#menuBar ul li").hover(
    function(e){
        $("#menuBar ul li").addClass("off");
        $(e.target).closest("li").addClass("on").removeClass("off");
    },() => $("#menuBar ul li").removeClass("on").removeClass("off")
)