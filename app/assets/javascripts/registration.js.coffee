readURL = (input) ->
  if input.files and input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      $("#avatar").attr "src", e.target.result

    reader.readAsDataURL input.files[0]

#Open pop up when clicking on the avatar default pic
$("#avatar").click ->
  $("input[type=file]").trigger "click"

$("#user_file_avatar").change ->
  readURL this
