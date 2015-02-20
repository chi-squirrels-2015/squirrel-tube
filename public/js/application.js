$(document).ready(function() {

  $("#results").on("click", "a", function(event){
    event.preventDefault();

    var url = $(this).attr('href');


    $(this).closest(".links").append("<iframe src="+url+"></iframe>");
  });

});
