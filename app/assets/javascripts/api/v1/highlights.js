if (!window.Dog) {
  Dog = {};
}

Dog.Selector = {};
Dog.Selector.getSelected = function() {
  var t = '';
  if (window.getSelection) {
    t = window.getSelection();
  } else if (document.getSelection) {
    t = document.getSelection();
  } else if (document.selection) {
    t = document.selection.createRange().text;
  }
  return t;
};

Dog.Selector.mouseup = function() {
  let st = Dog.Selector.getSelected();
  if (st != "") {
    //Use regex so it can read paraentheses.
    let string = st.toString().replace(/\(/g, "\\(");
    string = string.replace(/\)/g, "\\)");
    let myRe = new RegExp("\\w*?" + string + "\\w*", "g");

    let articleContent = document.getElementById("article-content").innerHTML;
    let myArray = articleContent.match(myRe);

    st = myArray[0];
    document.getElementById("selection").innerHTML = st; 
  }
};

$ (document).ready(function() {
  $ (document).bind("mouseup", Dog.Selector.mouseup);
});
//send data to 
function sendHighlight() {
  let highlightSelection = document.getElementById('selection').innerHTML;
  let userId = parseInt(document.getElementById('showUserId').innerHTML);
  let articleId = parseInt(document.getElementById('showArticleId').innerHTML);

  $.post(
        "http://localhost:3000/api/v1/highlights",
        {
          selection: highlightSelection,
          user_id: userId,
          article_id: articleId
        },
        function() {
          $( "#refreshHighlights" ).load(window.location.href + " #refreshHighlights" );
        });
  document.getElementById("selection").innerHTML = "highlight has been saved";
}

let openingSpan = '<span class="highlight">';
let closingSpan = '</span>';
let selectedHighlight = "";

function removeHighlight() {
  let articleDiv = document.querySelector("#article-content");
  let articleContent = articleDiv.innerHTML;
  let openSpanPosition = articleContent.indexOf(openingSpan);
  let closingSpanPosition = articleContent.indexOf(closingSpan);
  selectedHighlight = articleContent.slice(openSpanPosition + openingSpan.length, closingSpanPosition);
  if (articleContent.includes(openingSpan)) {
    let replaceContent = articleContent.slice(0, openSpanPosition) + articleContent.slice(openSpanPosition + openingSpan.length, closingSpanPosition) + articleContent.slice(closingSpanPosition + closingSpan.length);
    articleDiv.innerHTML = replaceContent; 
  }

}

function searchHighlight(selectedText) {

  removeHighlight();

  let articleDiv = document.querySelector("#article-content");
  let articleContent = articleDiv.innerHTML;
  let firstMarker = articleContent.indexOf(selectedText);
  let secondMarker = firstMarker + selectedText.length;
  if (selectedHighlight === articleContent.slice(firstMarker, secondMarker)) {
    let replaceContent = articleContent.replace(openingSpan, "<span>");
    articleDiv.innerHTML = replaceContent; 
  } else {
    console.log(articleContent.slice(firstMarker, secondMarker));
    articleDiv.innerHTML = articleContent.slice(0, firstMarker) + openingSpan + articleContent.slice(firstMarker, secondMarker) + closingSpan + articleContent.slice(secondMarker);
    $('html, body').animate({
      scrollTop: $(".highlight").offset().top - $(".highlight").height() * 2
    }, 1000);
  }
}

// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
