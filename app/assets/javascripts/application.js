// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.remotipart
//= require jquery-fileupload
//= require_tree .



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

$(".dropzone").click(function(){
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

$('.fileupload').validate({
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
