
$(document).ready(function () {

    //***********************************for google book suggestion******************************************
    var minlength = 4;
    var req;
    var timer;

    $("#book_title").keyup(function () {

        var that = this;
        value = $(this).val().replace(/ /g, '');

        if (value.length < minlength) { $('#google_books_result').hide(); }

        else if(value.length >= minlength)  {

            $('#google_books_result').show();

            value = value.toLowerCase();

            if (req) req.abort();

            clearTimeout(timer);

            timer = setTimeout(function() {

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
             }, 750);
        }
    });

    $('.wrong_cover_label').hide();
    $("#google_books_result").on("click", ".book_resp",function() {


        var value = $(this).find('.google_title').html();
        if (value) {
            value = value.trim();
            $("#book_title").val(value);
        }

        var value = $(this).find('.google_authors').html();
        if (value) {
            value = value.trim().replace(/\s+/g, " ");
            $("#authors").val(value);
        }

        var value = $(this).find('.google_description').html();
        if (value) {
            value = value.trim().replace(/\s+/g, " ");
            $("#Description").val(value);
        }

        var value = $(this).find('.google_publisher').html();
        if (value) {
            value = value.trim().replace(/\s+/g, " ");
            $("#Publisher").val(value);
        }

        var value = $(this).find('.google_isbn13').html();
        var value1 = $(this).find('.google_isbn10').html();
        var value2 = $(this).find('.google_other').html();
        if (value) { 
            value = value.trim().replace(/\s+/g, " ");
            $("#ISBN").val(value);
        }
        else if (value1)  {
            value1 = value1.trim().replace(/\s+/g, " ");
            $("#ISBN").val(value1);
        }
        else if (value2)  {
            value2 = value2.trim().replace(/\s+/g, " ");
            $("#ISBN").val(value2);
        }

        var value = $(this).find('.google_categories').html();
        if (value) {
            $("#Category").val("1000");  //27
            $("#otherCategory").show();
            value = value.trim().replace(/\s+/g, " ");
            $("#otherCategory").val(value);
        }

        //if google's cover photo is incorrect
        var google_cover = $(this).find(".google_thumbnail").attr("src");
        if (google_cover) { 
            
            $('#cover_thumbnail').attr('src', google_cover);  
            $("#cover_photo_url").val(google_cover);     
            $('.wrong_cover_label').show();
        }

        $("input#wrongCover").click(function () {
            if ($("input#wrongCover").is(':checked')) {
                $('#cover_thumbnail').attr('src', "/assets/placehold.jpg");     
                $("#cover_photo_url").val('');     
            }
            else {
                $('#cover_thumbnail').attr('src', google_cover);
                 $("#cover_photo_url").val(google_cover);     
            }
        });

    //end if google's cover photo is incorrect

       // $('#Edition').attr('style', "border: 1px solid red");

            $('#google_books_result').hide();        
        });
      

        var mouseOver = false;
        $("#google_books_result").mouseover(function() { mouseOver = true; }).mouseout(function() { mouseOver = false; });

        $(".btitle").blur(function() {
            if (mouseOver) { return; }
            $('#google_books_result').hide(); 
        });
    
   // ***************************end for google book suggestion*************************************

        $("#No_Edition").change(function () {
            if ($("#No_Edition").is(':checked')) {
                $('#Edition').attr("disabled", "disabled");    
            }
            else {
                $('#Edition').removeAttr("disabled");
            }
        });

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
   if (location.pathname == "/users/login" || location.pathname == "/users/signup" || location.pathname == "/users/password/edit"
                || location.pathname == "/thankyou" || location.pathname == "/user_books/new" || location.pathname == "/users/password" || location.pathname == "/users" || location.pathname == "/cart" || location.pathname == "/list" || location.pathname == "/users/password/new") {
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
        if ($(this).val() == "1000") {
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

    //site popovers and tooltips
    $('.element').tooltip();

    $('#Price').popover({
        title: "Pricing tip!",
        content: "Average rental price ranges between 25% - 60% of the price of a new book...", 
        trigger: focus
    });
    
    $('#Location').popover({
        title: "Location tip!",
        content: "Entering a location will increase your book's visibility to renters close to you...", 
        trigger: focus
    });

    $('#Checkbox1').tooltip({
        title: "You can select 1 or more rental periods!"
    });

    $('#Checkbox2').tooltip({
        title: "You can select 1 or more rental periods!"
    });

    $('#Checkbox3').tooltip({
        title: "You can select 1 or more rental periods!"
    });

     $('.upload_Photos').tooltip({
        title: "Adding photos can make a renter decide quickly. You can select multiple photos at the same time."
    });
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
