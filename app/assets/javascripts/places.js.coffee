# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


#Upload a picture
$(".fileupload").fileupload
  dataType: "json"
  add: (e, data) ->
    if valid(data["files"][0])
      data.submit()
      $("#pic_bar").css "width", "0%"
    else
      alert "Allowed types: jpg, png, gif, svg"

  done: (e, data) ->
    $.each data.result, (index, file) ->
      template = _.template($("#pic_template").html())(
        id: file.id
        full_url: file.full
        prev_url: file.prev
      )
      $("ul.thumbnails li").prepend $(template).fadeIn()


  progressall: (e, data) ->
    progress = parseInt(data.loaded / data.total * 100, 10)
    $("#pic_bar").css "width", progress + "%"


#Delete a picture    
$(".pic_delete_link").click ->
  self = $(this)
  id = self.attr("pic_id")
  $.ajax
    url: "/pictures/" + id
    type: "post"
    data:
      _method: "delete"

    statusCode:
      200: ->
        $(self).parent().fadeOut()

      204: ->
        console.log "can't delete"


#Add nested fields(ExLinks)
window.add_fields = (link, association, content) ->
  new_id = new Date().getTime()
  regexp = new RegExp("new_" + association, "g")
  $(link).after content.replace(regexp, new_id)
  console.log $(link).parent()

#UTILS
valid = (file) ->
  true  if _.contains(ALLOWED_TYPES, file.type)

ALLOWED_TYPES = ["image/gif",
               "image/jpeg",
               "image/pjpeg",
               "image/png",
               "image/svg+xml",
               "image/tiff" ];

_.templateSettings = interpolate: /\{\{(.+?)\}\}/g
               