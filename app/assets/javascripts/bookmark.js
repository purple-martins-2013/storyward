$(document).ready(function() {
  $('div').on('ajax:success', '#unbookmarked_icon', function(e, data, response, xhr){
    e.preventDefault();
    $(this).replaceWith(data);
  });

  $('div').on('ajax:success', '#bookmarked_icon', function(e, data, response, xhr){
    e.preventDefault();
    $(this).replaceWith(data);
  });
});