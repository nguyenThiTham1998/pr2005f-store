
$(document).on('turbolinks:load', function(){
  
    const formatter = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'VND',
    minimumFractionDigits: 2
  })

  $(".add-key").click(function(){
 
  var iddetail = $(this).data('iddetail');
    var price = parseInt(document.getElementById("unit-price-" + iddetail).innerHTML);
    var a = parseInt($(".quantity-"+iddetail).val());
    
    a += 1;
    var total = a*price;
    $(".quantity-"+ iddetail).val(a);
    document.getElementById("cart_total_price-" + iddetail).innerHTML= formatter.format(a*price);
  });


  $(".minus-key").click(function(){

  var iddetail = $(this).data('iddetail');
    var price = parseInt(document.getElementById("unit-price-" + iddetail).innerHTML);
    var a = parseInt($(".quantity-"+ iddetail).val());
    if(a >1){
      a -= 1;
      $(".quantity-"+ iddetail).val(a);

    }
     document.getElementById("cart_total_price-" + iddetail).innerHTML= formatter.format(a*price);
  });
  

});

$(document).on('turbolinks:load', function(){
  $(".delete-product").click(function(){
    var id = $(this).data('id');
    $.ajax({

      url: '/add_products_to_carts/'+id ,
      type: 'DELETE',
      data: {
         authenticity_token: $('[name="csrf-token"]')[0].content,
        _method: 'DELETE',
        id: id,
        
      },
      success: function(data) {
        $(".xoa-"+id).remove();
        alert('xoa thanh cong');
      }  
    
    });
  });
});



$(document).on('turbolinks:load', function(){

  const formatter = new Intl.NumberFormat('VN', {
    style: 'currency',
    currency: 'VND',
    minimumFractionDigits: 3
  })
  $( ".add-key" ).mouseout(function() {
    
    var id = $(this).data('idproduct');
    var iddetail = $(this).data('iddetail');
  
     $.ajax({
        url: '/add_products_to_carts/'+id,
        data: {

            authenticity_token: $('[name="csrf-token"]')[0].content,

            quantity: $(".quantity-"+iddetail).val(),
            color: document.getElementById("color-" + iddetail).innerHTML,
            size: $(".value-size-" + iddetail).val(),
            cart_identy: 1
        },
        datatype: "json",
        type: 'put',
      
        success: function(data) {
                $(".quantity-"+iddetail).html(data.quantity);
        }  
       
      });
  });


  $( ".minus-key" ).mouseout(function() {
    
    var id = $(this).data('idproduct');
    var iddetail = $(this).data('iddetail');
  
     $.ajax({
        url: '/add_products_to_carts/'+id,
        data: {

            authenticity_token: $('[name="csrf-token"]')[0].content,
            quantity: $(".quantity-"+iddetail).val(),
            color: document.getElementById("color-" + iddetail).innerHTML,
            size: $(".value-size-" + iddetail).val(),
            cart_identy: 1
        },
        datatype: "json",
        type: 'put',
      
        success : function(data) {
                $(".quantity-"+iddetail).html();
        }  
       
      });
  });

});


  $(document).on('turbolinks:load', function(){
    $(".dia_chi").click(function(){

        $("#add-login").click();
    });
  });

