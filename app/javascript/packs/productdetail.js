$(document).on('turbolinks:load', function(){
	$(document).on('click', '#product-detail-cart', function(){
			product_id = $('#productdetail-product-id').val();
		      $.ajax({
		        url: '/add_products_to_carts/'+ product_id,
		        data: {
		                authenticity_token: $('[name="csrf-token"]')[0].content,
		                quantity: $("#result_quantity").val(),
		                color: $('#select_color').val(),
		                size: $('#select_size').val(),
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


$(document).on('turbolinks:load', function(){
	$(document).on('click', '.search-admin', function(){
        $.ajax({
          url: '/admin/search',
          type: 'get',
          dataType: 'json',
          data: {    
            search: $("#search-admin").val()
          },
          success: function(data){
          }
        })
      })
    });