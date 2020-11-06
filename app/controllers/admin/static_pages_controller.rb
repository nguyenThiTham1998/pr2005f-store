class Admin::StaticPagesController < Admin::ApplicationController 
  def home
  	val = "newest"
  	@products = Product.all.includes([:image_attachments, :product_details]).order_by_time.take(Settings.limit_product)
  	@orders = Order.all.order_by_time(val).includes([:order_details]).take(Settings.limit_dashboard_order)
  	@monthly_orders = Order.group('date(created_at)').where('created_at >=?', 1.month.ago)
  end
end
