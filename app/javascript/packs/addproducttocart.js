var a = 1;
$(document).ready(function(){
 
  $("#add").click(function(){
  	 a += 1;
    $("#result_quantity").val(a);
  });
});



$(document).ready(function(){
 
  $("#reduce").click(function(){
  	if(a>1){
	  	 a -= 1;
	    $("#result_quantity").val(a);
	}
  });
});


$(document).ready(function(){


  $("#medium").click(function(){
    $("#medium").css("background" ,"#FF7F50");
    $("#large").css("background" ,"white");
    $("#xlarge").css("background" ,"white");
    $("#size_result").val(1);
    $("#notice-select").remove();
  });
});




$(document).ready(function(){
   
 
  $("#large").click(function(){
   $("#large").css("background" ,"#FF7F50");
   $("#xlarge").css("background" ,"white");
   $("#medium").css("background" ,"white");
    $("#size_result").val(2);
    $("#notice-select").remove();
  });
});




$(document).ready(function(){
 
  $("#xlarge").click(function(){
    $("#xlarge").css("background" ,"#FF7F50");
   $("#medium").css("background" ,"white");
   $("#large").css("background" ,"white");
    $("#size_result").val(3);
    $("#notice-select").remove();
  });
});

$(document).ready(function(){
  
  $("#color_blue").click(function(){
    $("#color_blue").css("background" ,"#FF7F50");
    $("#color_white").css("background" ,"white");
    $("#color_result").val("blue");
    $("#notice-select").remove();
  });
});


$(document).ready(function(){

  $("#color_white").click(function(){
    $("#color_white").css("background" ,"#FF7F50");
    $("#color_blue").css("background" ,"white");
    $("#color_result").val("White");
    $("#notice-select").remove();
  });
});

$(document).ready(function(){

  $("#add-buton").click(function(){
  
     var url = window.location.pathname;
     var id = url.substring(url.lastIndexOf('/') + 1);
     $.ajax({
        url: '/add_products_to_carts/'+id,
        data: {
            authenticity_token: $('[name="csrf-token"]')[0].content,
            quantity: $("#result_quantity").val(),
            color: $("#color_result").val(),
             size: $("#size_result").val()
        },
        datatype: "json",
        type: 'put',
       
        error: function(){ 
          alert("vui long dang nhap");
          
          $("#add-login").click();
        },
       
        success : function(data) { 
            if(!data.success&& !data.quantity){
              $("#notice-select").html(data.errors[0].message); 
             
            } else if(data.success){
              
              alert("them gio hang thanh cong");
            }
        } 
      });
  });
});