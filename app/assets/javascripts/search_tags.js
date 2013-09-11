$(document).ready(function() {

  $('nav').on("click", "#search", function() {
    $("#search-holder").foundation('reveal', 'open');
    populateTags();
  });

  $("body").on("click", ".close-reveal-modal", function() {
    $(".token-input-list-facebook").remove();
  });

});

function populateTags() {
  $('#tag_tokens').tokenInput('/stories.json', {
    theme: 'facebook'
  });
}