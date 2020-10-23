class Admin::StaticPagesController < Admin::ApplicationController 
  def home
  	val = "newest"
  	@products = Product.all.includes([:image_attachments, :product_details]).order_by_time.take(Settings.limit_product)
  	@orders = Order.all.order_by_time(val).includes([:order_details])
  end
end
