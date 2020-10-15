$(document).ready(function(){
  
   
  $(".add-key").click(function(){
 
  var iddetail = $(this).data('iddetail');
    var price = parseInt(document.getElementById("unit-price-" + iddetail).innerHTML);
    var a = parseInt($(".quantity-"+iddetail).val());
    
    a += 1;
    var total = a*price;
    $(".quantity-"+ iddetail).val(a);
    document.getElementById("cart_total_price-" + iddetail).innerHTML= a*price;
  });


  $(".minus-key").click(function(){

  var iddetail = $(this).data('iddetail');
    var price = parseInt(document.getElementById("unit-price-" + iddetail).innerHTML);
    var a = parseInt($(".quantity-"+ iddetail).val());
    if(a >1){
      a -= 1;
      $(".quantity-"+ iddetail).val(a);

    }
     document.getElementById("cart_total_price-" + iddetail).innerHTML= a*price;
  });
  

});

$(document).ready(function(){
  $(".delete-product").click(function(){
    var id = $(this).data('id');
    $.ajax({
      url: '/add_products_to_carts/'+id ,
      type: 'DELETE',
      data: {
        _method: 'DELETE',
        id: id,
        
      },
      success: function(data) {
        $(".xoa-"+id).remove();
        alert("xoa thanh cong");
      }  
    
    });
  });
});



$(document).ready(function(){
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
                $(".quantity-"+iddetail).html(data.quantity);
        }  
       
      });
  });

});


