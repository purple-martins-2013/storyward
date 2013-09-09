$(document).ready(function() {
  if (document.getElementById("show-story")) {
    new storyTime("#show-story");
  }
});

function storyTime(container) {

  $(container).on("mouseenter", ".node-title", function() {
    $(this).find("h5").show(400);
  });

  $(container).on("mouseleave", ".node-title", function() {
    var curElement = this;
    setTimeout(function() {
      $(curElement).find("h5").hide(400);
    }, 1000);
  });
}