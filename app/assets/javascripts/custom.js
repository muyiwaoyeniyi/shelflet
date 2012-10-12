
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

            value = value.replace(/ /g, '');   

            if (req != null) req.abort();

            req = $.ajax({
            url: 'user_books', //google_books_api?value=' + value,
            success: function(data) {
              //$("#google_books_result").html($(data).find("#google_books_resp")); 
              //$("#google_books_result").html(data);                            

              $('#google_books_result').html('<img src="/assets/spinner.gif" />');
              $('#google_books_result').load('/google_books_api?value=' + value + ' #google_books_resp'); 
            }
          });
        }
    });
    //for google book suggestion

    
   // $('#abook_resp').click(function () {

       //var b = this.$('.title_resp').html();
       //var vav = $(".title_resp").html(); 
      // $('#book_title').val('vav');
     //   alert('hello');

    //});

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
                || location.pathname == "/thankyou" || location.pathname == "/cart" || location.pathname == "/list" || location.pathname == "/users/password/new") {
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


    //*****************for book photos*************
    // $(".fancybox").fancybox();      

    

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
