
var url = window.location.pathname;
var product_id = url.substring(url.lastIndexOf('/') + 1);
$(document).on('click', '.post-comment', function() {
	var comment_id = $(this).data('id');

	$.ajax({
	  url: '/products/'+ product_id + '/comments',
	  type: 'POST',
	  dataType: 'json',
	  data: {
	  	authenticity_token: $('[name="csrf-token"]')[0].content,
	    parent_id: $('.comment_parent_id').val(),
	    product_id: $('.comment_product_id').val(),
	    content: $('.comment_content').val()
	 
	  },
	  success: function(data){
	  	
	    $('#append-comment').prepend(data.data_comment)
	    $('#count-comment').replaceWith('('+data.count_comment+')')
	    $('.comment_content').val("")
	  },
	  fail: function (){
	    alert( "error" );
		}			
	});
});


		$(document).ready(function(){
			$(document).on('click', '.delete-comment',function(){
				
				comment_id = $(this).data('id');
				var deleteComment = '#delete-comment'+comment_id;
				$('#append-comment-'+comment_id).remove();

			});	
			// update comment
			$(document).on('click', '.edit-comment',function(){
			
				comment_id = $(this).data('id');
				var editComment = '#edit'+comment_id;
				$.ajax({
					url: '/comments/'+comment_id,
					type: 'GET',
					_method: 'PATCH',
					success: function(){
						$('#edit-form'+comment_id).show();
						$('#comment_content'+comment_id).val()
					}
				})
				});	
		
			$('.update-comment').on('click', function(){
					comment_id = $(this).data('id');
					var saveComment = '#update-comment'+comment_id
					$.ajax({
					url: '/comments/'+comment_id,
					type: 'POST',
					dataType: 'json',
					data:{
						_method: 'put',
						authenticity_token: $('[name="csrf-token"]')[0].content,
						product_id: $('#comment_product_id'+comment_id).val(),
						content: $('#comment_content'+comment_id).val()
					},
					success: function(data){
						$('#append-comment-'+comment_id).replaceWith(data.update_data_comment);
					}
				})
			});					
		});			
	
			$(document).ready(function(){
				$(document).on('click','.subcomment',function(){
				comment_id = $(this).data('id');
				var	Subcomment = '#subcomment'+ comment_id;
					$('#comment-subcomment-form'+ comment_id).show();	
				}); 
				
			$('.sub-comment').click(function(){
				comment_id = $(this).data('id');
				 var subComment = '#sub-comment'+comment_id
					$.ajax({
						url:  '/comments/'+ comment_id +'/sub_comments',
						type: 'POST',
						dataType: 'json',
	          			data: {
	          				authenticity_token: $('[name="csrf-token"]')[0].content,
			            	comment_id: $('#sub_comment_comment_id'+ comment_id).val(), 
			            	content: $('#sub_comment_content'+ comment_id).val()
			        	},
				        success: function(data){
				    		          	
				            $('#comment-'+ comment_id).prepend(data.data_comment_subcomment),
				            $('#sub_comment_content'+ comment_id).val(undefined)
				            $('#comment-subcomment-form'+ comment_id).hide()
				         }		         
					})
				});		
			});

		$(document).on('click','.delete-subcomment',function(){
			sub_comment_id = $(this).data('id');
			var deleteSubComment = '#delete-subcomment'+sub_comment_id;
			$('#sub_comment-'+sub_comment_id).remove();
		});


		$(document).on('click', '.classify-click', function() {
			page_id = $(this).data('id');
			$.ajax({
				type: 'GET',
				url: '/products',
				data:{
					classify: page_id
				},
				dataType: 'json',
				success: function(data){
					$('#home').html(data.data_products);

				
				}	
			})
		});		 
		
