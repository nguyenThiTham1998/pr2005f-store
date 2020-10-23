$(document).on('turbolinks:load', function() {
  $('#checkAll').click(function () {    
    $('input:checkbox').prop('checked', this.checked);   
  });
});

$(document).on('turbolinks:load', function(){
  $('.update-status').click(function () { 

    alert("Update the status of these orders");

    var order_status_id = $(this).data('id');
    var order_ids = new Array();
    $("input[name='order']:checked").each(function(){
          order_ids.push(this.value);
    });
    $.ajax({
      url: '/admin/orders/'+ order_ids,
      type: 'POST',
      dataType: 'json',
      data:{
        _method: 'patch',
        authenticity_token: $('[name="csrf-token"]')[0].content,
        order_status: order_status_id
      },

      success: function(data){
        order_ids.forEach(function(item, index){
          $('#append-order-status-'+item).text(data.update_data_order);
          $('#append-order-status-'+item).attr('class', '');
          $('#append-order-status-'+item).addClass('label '+data.update_data_order);
          $('.checkItem').prop('checked', false);
        });                                               
      }
    });               
  });
});
