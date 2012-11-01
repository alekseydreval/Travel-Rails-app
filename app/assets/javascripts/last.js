$(function(){

ALLOWED_TYPES = ["image/gif",
                 "image/jpeg",
                 "image/pjpeg",
                 "image/png",
                 "image/svg+xml",
                 "image/tiff" ];

_.templateSettings = {
  interpolate : /\{\{(.+?)\}\}/g
};

$('.form-horizontal').on('click', '.js_delete',
	function() {
        // console.log($(this));//.prevAll(".text_field"))
        $(this).prev("input[type=hidden]").val("1");
        $(this).prevAll(".text_field").fadeOut();
        $(this).prevAll(".field_with_errors").fadeOut();
        $(this).hide();
	});

$(".dropzone, #avatar").click(function(){
      $('input[type=file]').trigger('click');
    });

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).after(content.replace(regexp, new_id));
  console.log($(link).parent());
}

$('.fileupload').fileupload({
    dataType: 'json',
    add: function(e, data){
      // console.log(data);

      if(valid(data['files'][0]))
      {
        data.submit();
        $('#pic_bar').css('width', '0%');
      }
      else
      {
        alert('Allowed types: jpg, png, gif, svg');
      }

    },
    done: function (e, data) {
      console.log(data);
      
        $.each(data.result, function (index, file) {
          var template = _.template($('#pic_template').html())(
                                   {id: file.id,
                                    full_url: file.full,
                                    prev_url: file.prev}
                                    );
          $('ul.thumbnails li').prepend($(template).fadeIn());
        });
        
    },
    progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $('#pic_bar').css(
            'width',
            progress + '%'
        );
    }
});

$('.fileupload, .user_form').validate({
  errorClass: "input-validation-error",
  highlight: function(element, errorClass){
    $(element).addClass(errorClass);
  },
  unhighlight: function(element, errorClass){
    $(element).removeClass(errorClass);
  }
});


function remove_pic(self, id){
  $.ajax({
    url: '/pictures/' + id,
    type: 'post',
    data: { '_method': 'delete'},
    statusCode: {
      200: function(){
        $(self).parent().fadeOut();
      },
      204: function(){
        console.log('can\'t delete');
      }
    }
  });
}

function valid(file){
  if(_.contains(ALLOWED_TYPES, file.type))
    return true;
}

function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#avatar').attr('src', e.target.result);
                };

                reader.readAsDataURL(input.files[0]);
            }
        }

$('#pic_template').on('click', '.added_pic', function(e){
  //window.open(e.src);
  e.preventDefault();
});
});