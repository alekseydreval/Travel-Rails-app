# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('.new_reply').toggle(
	-> $(this).siblings('form').show(),
	-> $(this).siblings('form').hide() 
)

window.remove_comment = (el, id) -> 
	$.post "/comments/#{id}",
	       _method: "delete",
	       -> location.reload()

