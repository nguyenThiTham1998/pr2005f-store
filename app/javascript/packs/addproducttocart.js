var a = 1;
$(document).on('turbolinks:load', function(){
 
  $("#add").click(function(){
  	 a += 1;
    $("#result_quantity").val(a);
  });
});


$(document).on('turbolinks:load', function(){
 
  $("#reduce").click(function(){
  	if(a>1){
	  	 a -= 1;
	    $("#result_quantity").val(a);
	  }
  });
});

$(document).on('turbolinks:load', function(){
  var url = window.location.pathname;
    var product_id = url.substring(url.lastIndexOf('/') + 1);
  $(document).on('click', '.color-button', function(){

    var color_id = $(this).data('id');
     
    if ($('#color-' + color_id).is(':checked')) {

      $.ajax({
        url: '/products/' + product_id ,
        type: 'get',
        dataType: 'json',
        data: {
          authenticity_token: $('[name="csrf-token"]')[0].content,
          color: $('#color-' + color_id).val(),
          product_id: product_id
        },
        success: function(data){  
          var grepsize = new Array();  
          grepsize = $.grep(data.data_all, function(item){
            return $.inArray(item, data.data_color) < 0
          });
          for (i = 0;i < grepsize.length; i++){
            $('#size-'+grepsize[i]).hide()  
          }
          for (i = 0; i< data.data_color.length; i++){
            $('#size-'+data.data_color[i]).show()
          }
        }
      })
    }
  });
  
  $(document).on('click', '.button-cart', function(){
    $.ajax({
      url: '/add_products_to_carts/'+ product_id,
      data: {
              authenticity_token: $('[name="csrf-token"]')[0].content,
              quantity: $("#result_quantity").val(),
              color: $('.color-button:checked').val(),
              size: $('.size-button:checked').val(),
          },
          datatype: "json",
          type: 'put',
          error: function(){ 
              alert(I18n.t("evaluators.alert.login"));
            
              $("#add-login").click();
          },
          success : function(data) { 
              if(!data.success&& !data.quantity){
                $("#notice-select").html(data.errors[0].message); 
               
              } else if(data.success){
                
                alert(I18n.t("evaluators.alert.cart"));
              }
          } 

    })

  })
});

