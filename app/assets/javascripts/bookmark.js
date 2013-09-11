$(document).ready(function() {
	$('#unbookmarked_icon').on('ajax:success', function(e, data, response, xhr){
		e.preventDefault();
		$(this).replaceWith(data);
	});

	$('h2').on('ajax:success','#bookmarked_icon', function(e, data, response, xhr){
		e.preventDefault();
		console.log(data);
	});
});
