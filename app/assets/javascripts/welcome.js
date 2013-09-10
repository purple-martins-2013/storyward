$(document).ready(function(){
	$('#sign_in').on('click', function(){
		$('.welcome_options').remove();
		$('.sign_in_links').show();
	});

	$('#sign_up').on('click', function(){
		$('.welcome_options').remove();
		$('.sign_up_links').show();
	});
});