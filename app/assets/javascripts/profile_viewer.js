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
      $("#viewer-title").hide();
      $(".viewer-box").removeClass("select-entry");
      $(curElement).addClass("select-entry");
      if ($(curElement).data("type") == "node") {
        $("#viewer-title").html("<i>Map out this story!</i>");
      } else {
        $("#viewer-title").html("<i>Check out this author's books!</i>");
      }
      $("#viewer-title").fadeTo(800, 1.0);
      $("#story-viewer").addClass("animated", 800);
      $("#viewer-title").fadeTo(800, 0.4);
      $("#viewer-title").fadeTo(800, 1.0);
      $("#story-viewer").attr("data-id", $(".select-entry").data("me"));
    }, 500);
  });

  $(container).on("mouseleave", ".viewer-box", function() {
    if (timeoutCounter) {
      clearTimeout(timeoutCounter);
    }
  });

  $(container).on("click", "#story-viewer", function() {
    if ($(".select-entry").length > 0) {
      if ($(".select-entry").data("type") == "node") {
        $("#chart-holder").replaceWith("<div id='chart-holder' class='small-12 columns center-this reveal-modal' ><div id='chart' class='small-6 columns' data-node='" + $(".select-entry").data("id") + "'></div><div><a id='node-link' style='display: none'></a></div><div id='superNav'></div><a class='close-reveal-modal'>&#215;</a></div>")
        $("#chart-holder").foundation("reveal", "open");
        new forceGraph("#show-user");
        $("#story-viewer").removeClass("animated");
        $("#viewer-title").html("");
        $(".viewer-box").removeClass("select-entry");
      } else {

      }
    }
  });
}