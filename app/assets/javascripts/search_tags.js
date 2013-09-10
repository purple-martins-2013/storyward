$(document).ready(function() {

  $('nav').on("click", "#search", function() {
    $("#search-holder").replaceWith("<div id='search-holder' class='small-9-columns reveal-modal'><form><label for='tag_tokens'>Search by Tag:</label><input type='text' name='tag_tokens' id='tag_tokens' /><label for='search_bar'>Search by title, keyword or author:</label><input type='text' name='search_bar' id='search_bar' /><input type='submit' value='Search!' /></form><a class='close-reveal-modal'>&#215;</a></div>");
    $("#search-holder").foundation('reveal', 'open');
    populateTags();
  });
});

function populateTags() {
  $('#tag_tokens').tokenInput('/stories.json', {
    theme: 'facebook'
  });
}