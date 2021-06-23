var nIntervId;
var url;

function interval(url) {
    nIntervId = setInterval(statusCheck, 2000, url);
}

function statusCheck(url) {

    var stat = null;

    $.ajax( {
        url : url,
        method : "get",
        success: function(respond){
            if( respond.message === "started")
            {
                console.log("Check-log, message: ", respond.message);
                console.log("Check-log, status: ", respond.status);
                clearInterval(nIntervId);
                interval(respond.url);
            }
            else {
                    if (respond.status === "complete") {
                        console.log("Check-log, message: ", respond.message);
                        console.log("Check-log, status: ", respond.status);
                        console.log("Check-log, url: ", respond.url);
                        var url = respond.url;

                        $.ajax( {
                            url : url,
                            method : "get",
                            success: function(respond)
                            {
                                console.log("Pdf is ready, local server url : ", respond.pdf_url);
                                url = respond.url;
                                pdf_url = respond.pdf_url;
                                pdf_name = respond.pdf_name;
                                $.ajax( {
                                    url : url,
                                    method : "post",
                                    data: {"pdf_url": pdf_url, "pdf_name": pdf_name},
                                    success: function(respond) {
                                        window.open('/download/'+pdf_name,'_blank');
                                    },
                                    error: function() { console.log("Error log, data : ", $(this).respond);}});

                            },
                            error: function() { console.log("Error log, data : ", $(this).respond);}});

                        clearInterval(nIntervId);
                    }
                    else {
                        console.log("Check-log, message: ", respond.message);
                        console.log("Check-log, status: ", respond.status);
                    }
                }
            },
        error: function() {
            console.log("Error log, data : ", $(this).respond);
        }
    });



}
