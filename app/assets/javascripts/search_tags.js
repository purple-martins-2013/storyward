$(document).ready(function() {

  $('nav').on("click", "#search", function() {
    $("#search-holder").foundation('reveal', 'open');
    populateTags();
  });

});

function populateTags() {
  $('#tag_tokens').tokenInput('/stories.json', {
    theme: 'facebook'
  });
}