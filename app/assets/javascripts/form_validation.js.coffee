v = $(".fileupload, .user_form").validate
  errorClass: "input-validation-error"
  highlight: (element, errorClass) ->
    $(element).addClass errorClass

  unhighlight: (element, errorClass) ->
    $(element).removeClass errorClass
if v
  v.showErrors "place[coords]": "Please set the place location on the map",
            

#File uploading window popup
$(".dropzone").click ->
  $("input[type=file]").trigger "click"

#Open pop up when clicking on the avatar
# $('#user_file_avatar').change ->
#     readURL(this);
