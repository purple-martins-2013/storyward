$(document).ready(function() {
	$('h2').on('ajax:success', '#unbookmarked_icon', function(e, data, response, xhr){
		e.preventDefault();
		$(this).replaceWith(data);
	});

	$('h2').on('ajax:success', '#bookmarked_icon', function(e, data, response, xhr){
		e.preventDefault();
		$(this).replaceWith(data);
	});
});
