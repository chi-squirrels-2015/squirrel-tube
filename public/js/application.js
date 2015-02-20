$(document).ready(function() {

  $(".btn-default").click(function(event){
    event.preventDefault();

    var request = $.ajax({
      url:"/search",
      type:"post",
      data: $(this).closest("form").serialize()
    });

    request.done(function(response){
      $("#search-results").html(response);
    })

  });

  $("#search-results").on("click", "a", function(event){
    event.preventDefault();

    var url = $(this).attr('href');
    $(this).attr("class", "active");

    $(this).closest(".links").append("<iframe height='315' width='559' id='player' src="+url+"></iframe>");

  });

  $("#search-results").on("click", "a.active", function(event){
    event.preventDefault();

    var url = $(this).attr('href');
    $(this).siblings("iframe").remove();
    $(this).removeClass("active");
  });

  $("#search-results").on("click", ".add-link", function(event) {
    event.preventDefault();

    var request = $.ajax({
      url:"/videos",
      type:"post",
      data: $(this).closest("form").serialize()
    });

    request.done(function(response) {
      $("#playlist-table").html(response)
    })

  })

  $("#playlist-table").on("click", ".videos", function(event){
    event.preventDefault();

    $(this).attr("class", "success");

    var request = $.ajax({
      url:"/votes",
      type:"post",
      data: {vidId: $(this).data("vid-id")}
    });

    request.done(function(response){
      $("#playlist-table").html(response);
    });

  });

  var duration = 1;
  setInterval(function(){

  }, duration)

});
