$(document).ready(function() {

    //user is sent from the back end in the index.jade template
    var sa = new SuperAwesome("superawesomegames", user, 'http://172.16.0.3');

    var number_area = $("<div />").text(Math.random()).appendTo("body");

    var status_area = $("<div />").css({
        "padding" : "10px",
        "background-color" : "gray"
    }).appendTo("body");

    var check_user = function(){

        if (sa.user == null) { //Not signed in
            status_area.empty().append(
                sa.sign_in_button()
            ).append(
                $("<button />").text("Login with new window").click(function(){
                    sa.login(function(response){
                        console.log("response: ",response);
                        if(response.error){
                            alert("SOMETHING WENT WRONG");
                        } else if(response.token){
                            document.cookie = 'sa_app_token='+response.token+'; max-age='+(60*60*24*365)+'; path=/';
                            sa.user = response.user;
                            check_user();
                        }
                    });
                })
            );

            sa.check_sign_in(function(reply) {
                if (reply.signed_in) {
                    status_area.append($("<div />").text("You already have a SuperAwesome account."))
                }
            })

        } else { //Signed in
            status_area.empty().append(
                $("<div />").text("Hello " + sa.user.username)
            ).append(
                $("<button />").text("Sign out").click(function() {
                    $.get("/sign_out",function(){
                        sa.user = null;
                        check_user();
                    })
                })
            ).append(
                $("<button />").text("Give me points").click(function() {
                    sa.award_points(7, 'EDK9racH25An0hhe5R97i8dOXHv7X3b1', function(reply) {
                        console.log(reply);
                    })
                })
            )
        }
    }

    check_user();
})