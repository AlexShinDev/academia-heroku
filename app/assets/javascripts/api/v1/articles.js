let content = "";
$(function() {
  // enter
  $("#searchTerm").keypress(function(e){
    if (e.keyCode === 13) {
      var searchTerm = $("#searchTerm").val();
      var url = "https://en.wikipedia.org/w/api.php?action=opensearch&search=" + searchTerm + "&format=json&callback=?"; 
      $.ajax({
        url: url,
        type: 'GET',
        contentType: "application/json; charset=utf-8",
        async: false,
        dataType: "json",
        success: function(data, status, jqXHR) {
          $("html, body").animate({ scrollTop: 780 }, 500);
          $("#output").html();
          for (var i = 0;i < data[1].length;i++) {
            $("#output").prepend("<div><div class='well search-article'><a href='http://localhost:3000/api/v1/articles/" + data[1][i] + "'><h2>" + data[1][i] + "</h2>" + "<p>" + data[2][i] + "</p></a></div></div>");
          }
        }
      });
    }
  });
  // click ajax call
  $("#search").on("click", function() {
    var searchTerm = $("#searchTerm").val();
    var url = "https://en.wikipedia.org/w/api.php?action=opensearch&search="+ searchTerm +"&format=json&callback=?"; 
    $.ajax({
      url: url,
      type: 'GET',
      contentType: "application/json; charset=utf-8",
      async: false,
      dataType: "json",
      // plop data
      success: function(data, status, jqXHR) {
        $("html, body").animate({ scrollTop: 780 }, 500);
        $("#output").html("");
        for (var i = 0;i < data[1].length;i++) {
          $("#output").prepend("<div><div class='well search-article'><a href='http://localhost:3000/api/v1/articles/" + data[1][i] + "'><h2>" + data[1][i] + "</h2>" + "<p>" + data[2][i] + "</p></a></div></div>");
        }
      }
    });  
  });
});