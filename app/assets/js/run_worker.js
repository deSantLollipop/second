$(function () {
$(".js-run-worker").on("click",function(event){
    // alert('clicked');
    _this = $(this);
    var uri = $(this).data('url');

    event.preventDefault();
    console.log("Check log, data : ", uri);

    $.ajax({
        url: uri,
        type: 'post',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(respond){
            _this_url = uri;
            console.log("Succes log, data : ",_this.data('url'));
            interval(uri);
        },
        error: function() {
        console.log("Error log, data : ", $(this).data('url'));
    }
    })
});
//console.log("RUN WORKER ; is this even getting executed ");

});