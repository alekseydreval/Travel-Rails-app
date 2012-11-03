$(".fileupload, .user_form").validate
  errorClass: "input-validation-error"
  highlight: (element, errorClass) ->
    $(element).addClass errorClass

  unhighlight: (element, errorClass) ->
    $(element).removeClass errorClass

#File uploading window pop up
$(".dropzone").click ->
  $("input[type=file]").trigger "click"

#Open pop up when clicking on the avatar
# $('#user_file_avatar').change ->
#     readURL(this);
