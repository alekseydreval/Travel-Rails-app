$ ->
	$('#new_message').toggle(
		-> $(this).siblings('#new_message_form').slideDown('fast'),
		-> $(this).siblings('#new_message_form').slideUp('fast'))

$('.autogrow').autogrow()