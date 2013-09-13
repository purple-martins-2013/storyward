$(document).ready(function() {
  if (document.getElementById("show-user")) {
    new miniGraph("#show-user")
  }
});

function miniGraph(container) {

  var curElement, timeoutCounter;

  $(container).on("mouseenter", ".viewer-box", function() {

    curElement = this;

    timeoutCounter = setTimeout(function() {
      $(".viewer-box").removeClass("select-entry");
      $(curElement).addClass("select-entry");
      forceGraph("#story-viewer");
    }, 500);
  });

  $(container).on("mouseleave", ".viewer-box", function() {
    if (timeoutCounter) {
      clearTimeout(timeoutCounter);
    }
  });
}