class Admin::StaticPagesController < Admin::ApplicationController 
  def home
  	@admin_displays = Product.all.order_by_time.take(Settings.limit_product)
  end
end
