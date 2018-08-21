        $(document).ready(function () {            

            var sessionTimer = 1140000;
            //var sessionTimer = 10000;
            
            var timeoutAlgorithm = function () {
                var TimeLeft = 60; //seconds
                $("#TimeoutRemainingTime").text(TimeLeft);
                //$("#TimeoutPopup").show();
                //$("#GreyoutDiv").show();
                document.getElementById("TimeoutPopup").style.display = "block";
                document.getElementById("GreyoutDiv").style.display = "block";
                startCountDown(TimeLeft);
            }


            var startCountDown = function (TimeLeft) {                
                var sessionInterval = setInterval(function () {                    
                    if (TimeLeft > 0) {
                        TimeLeft = TimeLeft - 1;
                        $("#TimeoutRemainingTime").text(TimeLeft);
                    }
                    else {                        
                        CloseSessionPopup()                        
                        clearInterval(sessionInterval);                        
                        EndDotNetSession();
                        //__doPostBack('ctl00$loginbox$EndSessionLnkBtn', '');
                    }
                }, 1000);

                //Keep Session Alive Link
                $("#KeepSessionAliveLnkBtn").click(function () {
                    KeepSessionAndStartOver();
                });

                //End Session Link
                $("#EndSessionLnkBtn").click(function () {
                    EndDotNetSession();
                })
            }

            var CloseSessionPopup = function () {
                //$("#TimeoutPopup").hide();
                //$("#GreyoutDiv").hide();
                document.getElementById("TimeoutPopup").style.display = "none";
                document.getElementById("GreyoutDiv").style.display = "none";
            }

            var KeepSessionAndStartOver = function () {
                $("#TimeoutPopup").hide();
                $("#GreyoutDiv").hide();
                clearInterval(sessionInterval);
                RefreshDotNetSession();
                setTimeout(timeoutAlgorithm, sessionTimer);
            }

            var RefreshDotNetSession = function () {
                $.ajax({
                    type: "POST",
                    url: "/login/refreshSession.aspx",
                    contentType: "application/json; charset=utf-8",
                    dataType: "text",
                    success: function (response) {
                        var data = $.parseJSON(response);
                        console.log(".NET Refreshed: " + data.session_refreshed + ", Date: " + data.session_time);
                    },
                    error: function (response) {
                        alert("Logging out.  Error occurred");
                        __doPostBack('ctl00$loginbox$EndSessionLnkBtn', '');
                    }
                });
            }

            var EndDotNetSession = function () {
                $.ajax({
                    type: "POST",
                    url: "/up/end-session.aspx",
                    contentType: "application/json; charset=utf-8",
                    dataType: "text",
                    success: function(){
                        window.location("/up/holder-reporting/");
                    },
                    error: function(response){
                        alert("Error signing out.");
                    }
                });
            }

            setTimeout(timeoutAlgorithm, sessionTimer);
        });//ready function() End