
$(document).ready(function () {

    //for google book suggestion
    var minlength = 3;
    var req = null;

    $("#book_title").keyup(function () {

        var that = this,
        value = $(this).val();         

        if (value.length < minlength) { $('#google_books_result').hide(); }

        else if(value.length >= minlength)  {

            $('#google_books_result').show();

            //value = value.replace(/ /g, '').toLowerCase() 

            if (req != null) req.abort();

            req = $.ajax({
            url: '/static_pages?dummy=' + 'a',
            success: function(data) {
              //$("#google_books_result").html($(data).find("#google_books_resp")); 
              //$("#google_books_result").html(data);                            

              $('#google_books_result').html('<img src="/assets/spinner.gif" />');
              $('#google_books_result').load('/google_books_api?value=' + value + ' #google_books_resp',
                    function (responseText, textStatus, req) {
                        if (textStatus == "error") {
                            $('#google_books_result').html("<div class='noresp_padding'>No suggestions were found</div>");
                           }
                 }); 
               }
            /*error: function(XMLHttpRequest, textStatus, errorThrown) {
              //$("#google_books_result").html($(data).find("#google_books_resp")); 
              //$("#google_books_result").html(data);                            

              alert("error");//$('#google_books_result').html('<p>No suggestion</p>');
            }*/
          });
        }
    });
    //for google book suggestion


    $("#google_books_result").on("click", ".book_resp",function() {
    
        var value = $(this).find('.google_title').html();
        value = value.trim();
        $("#book_title").val(value);
        
        var value = $(this).find('.google_authors').html();
        value = value.trim().replace(/\s+/g, " ");
        $("#authors").val(value);

        var value = $(this).find('.google_description').html();
        value = value.trim().replace(/\s+/g, " ");
        $("#Description").val(value);

        var value = $(this).find('.google_publisher').html();
        value = value.trim().replace(/\s+/g, " ");
        $("#Publisher").val(value);

        var value = $(this).find('.google_isbn').html();
        value = value.trim();
        $("#ISBN").val(value);

        $('#google_books_result').hide();

        /*$('#book_title').blur(function() {
            $('#google_books_result').hide();
            //alert("hello");
        });*/

        
    });
/*$(".btitle").live("blur", function(event){
    $('#google_books_result').hide();
});*.
    
   

  /* $("#search").keyup(function () {

        var that = this,
        value = $(this).val().trim();    

        if (value.length < minlength) { $('#search_result').hide(); }

        else if(value.length >= minlength)  {

            $('#search_result').show();

            value = value.replace(/ /g, '').toLowerCase() 

            if (req != null) req.abort();

            req = $.ajax({
            url: '/static_pages?dummy=' + 'a',
            success: function(data) {                        

              $('#search_result').html('<img src="/assets/spinner.gif" />');
              $('#search_result').load('/books?value=' + value + ' #search_resp', 
                   function (responseText, textStatus, req) {
                        if (textStatus == "error") {
                            $('#search_result').html('<span class="noresp_padding">No suggestions were found</span>');
                           }
                 }); 
            }
          });
        }
    });*/

    
       
    //Code to toggle Search bar
    if (location.pathname == "/") {
        $(window).load(function () {
            $('#slider').nivoSlider({
                effect: 'fade',
                animSpeed: 500,
                pauseTime: 10000,
                manualAdvance: true,
                pauseOnHover: true
            });
        });
    }
    else if (location.pathname == "/users/login" || location.pathname == "/users/signup" || location.pathname == "/users/password/edit"
                || location.pathname == "/thankyou" || location.pathname == "/users/password" || location.pathname == "/users" || location.pathname == "/cart" || location.pathname == "/list" || location.pathname == "/users/password/new") {
        $('#SearchBar').hide();
        $('#Rent').on('click', function (event) {
            $("#SearchBar").toggle('slide', { direction: "up" }, 700);
        });
    }
    else {
        $('#Rent').on('click', function (event) {
            $("#SearchBar").toggle('slide', { direction: "up" }, 700);
        });
    }
    //End Code to toggle Search bar

   

    // Hide Other Category and Condition
    $("#otherCategory").hide();
    $("#Category").change(function () {
        if ($(this).val() == "27") {
            $("#otherCategory").show("fast");
        } else {
            $("#otherCategory").hide();
        }
    });
    $("#ConditionNotes").hide();
    $("#Condition").change(function () {
        if ($(this).val() == "1" || $(this).val() == "2" || $(this).val() == "3" || $(this).val() == "4" || $(this).val() == "5") {
            $("#ConditionNotes").show("fast");
        } else {
            $("#ConditionNotes").hide();
        }
    });
    // End Hide Other Category and Condition


    //for book photos
    $(".fancybox").fancybox();      
    $('.element').tooltip();
    
    //$(".alert").hide();
    //$(".alert").alert();

    //For form validation
    /*$("#settingsForm1").validVal();
    $("#settingsForm2").validVal();
    $("#paymentSettings").validVal();
    $("#payoutForm").validVal({
       onSubmit: false
   });
   $("#loginForm").validVal();
   $("#signupForm").validVal();
   $("#resetForm").validVal();*/
    //End Form validation

});
