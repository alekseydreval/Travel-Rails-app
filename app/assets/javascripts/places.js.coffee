# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


#Upload a picture
$(".fileupload").fileupload
  dataType: "json"
  add: (e, data) ->
    if valid(data["files"][0])
      data.submit()
      $("#pict_bar").show()
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
      $("#pict_bar").hide()



  progressall: (e, data) ->
    progress = parseIn.t(data.loaded / data.total * 100, 10)
    $("#pic_bar").css "width", progress + "%"


#Delete a picture    
$('body').on('click', ".pic_delete_link", ->
  self = $(this)
  id = self.attr("pic_id")
  load_bar = $(this).parent().find('.load_bar')
  load_bar.show()
  $.ajax
    url: "/pictures/" + id
    type: "post"
    data:
      _method: "delete"

    statusCode:
      200: ->
        $(self).parent().fadeOut()
        load_bar.hide()

      204: ->
        console.log "can't delete")


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
               


###Google Maps###
map_dom = document.getElementById("map_canvas")

window.mapOptions = 
          center: new google.maps.LatLng(59, 30)
          zoom: 9
          mapTypeId: google.maps.MapTypeId.TERRAIN
        
window.map = new google.maps.Map(map_dom,
            mapOptions);

m = new google.maps.Marker
m.setMap(window.map)

#show the marker
if coords = map_dom.getAttribute('coords')
  coords = coords.match /\d+(\.\d+)?/g
  latlng = new google.maps.LatLng(coords[0], coords[1])
  window.map.center = latlng
  m.setPosition(latlng)

# edit or create a marker
if !map_dom.getAttribute('show')
  google.maps.event.addListener(window.map, 'click', (coord) ->
   m.setPosition(coord.latLng)
   $('#coords_data').val(coord.latLng))