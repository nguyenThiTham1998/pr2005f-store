
	$(document).ready(function(){
		$( ".ordered" ).click(function() {
	  		var url = window.location.pathname;
	      	var id = url.substring(url.lastIndexOf('/') + 1);
	     	$.ajax({
		        url: "/users/"+ id,
		        type: 'get',
		        data: {
		            authenticity_token: $('[name="csrf-token"]')[0].content,
		            user_id: id,
		            order_id: id
		        },
		        datatype: "json",
		        
		        success : function(data) {
	
		                $("#table-respond").html(data.data_orders);
	       		 }  
	       
	     	});
  		});

	});

$(document).ready(function(){
		$( ".address_correct" ).click(function() {
	  		var url = window.location.pathname;
	      	var id = url.substring(url.lastIndexOf('/') + 1);
	     	$.ajax({
		        url: "/users/"+ id,
		        type: 'get',
		        data: {
		            authenticity_token: $('[name="csrf-token"]')[0].content,
		            user_id: id,
		            address_id: id
		        },
		        datatype: "json",
		        
		        success : function(data) {
		                $("#table-respond").html(data.data_address);
	       		 }  
	       
	     	});
  		});

	});

$(document).ready(function(){
		$( ".account_correct" ).click(function() {
	  		var url = window.location.pathname;
	      	var id = url.substring(url.lastIndexOf('/') + 1);
	     	$.ajax({
		        url: "/users/"+ id,
		        type: 'get',
		        data: {
		            authenticity_token: $('[name="csrf-token"]')[0].content,
		            user_id: id,
		            account_id: id
		        },
		        datatype: "json",
		        
		        success : function(data) {
		                $("#table-respond").html(data.data_add);
	       		 }  
	       
	     	});
  		});

	});

$(document).ready(function(){
	$( ".cancel_order" ).click(function() {
  		var url = window.location.pathname;
      	var id = url.substring(url.lastIndexOf('/') + 1);
     	$.ajax({
	        url: "/orders/"+ id,
	        type: 'put',
	        data: {
	            authenticity_token: $('[name="csrf-token"]')[0].content,
	            order_status: $('#order_order_status'+id).val()
	        },	
	        success : function(data) {
	                $(".cancel_order").hide();
	                $(".status_order").html(data.order_status);
	                $(".staus_order_add").html(data.order_status);
       		 }  	
       
     	});
	});

});

$(document).ready(function(){

	$(document).on('click', '.cancel-order2', function() {
	      	var id = $(this).data('id');
	     	$.ajax({
		        url: "/orders/"+ id,
		        type: 'put',
		        data: {
		            authenticity_token: $('[name="csrf-token"]')[0].content,
		            order_status: $('#order_order_status'+id).val()
		        },	
		        success : function(data) {
		             $(".return-status").html(data.order_status);
	       		 	$(".cancel-order2").hide();
	       		 }  	
	       
	     });
  	});

});