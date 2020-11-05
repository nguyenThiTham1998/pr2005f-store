class Admin::ApplicationController < ActionController::Base
    layout "admin/application"
    before_action :check_login
  	before_action :require_admin
	before_action :set_locale
	before_action :set_search
  
  	private

	def check_login
	 	if user_signed_in? 
	 		flash[:danger] = "you are logging"
	 	else
	 		redirect_to root_url
	 	end
	end 	

	def require_admin
		unless current_user.admin?
		  redirect_to root_path
		end
	end

	def set_locale
    	I18n.locale = params[:locale] || I18n.default_locale
	end

	def default_url_options
	    {locale: I18n.locale}
	end

	def set_search
	  @q = Product.includes(:image_attachments).ransack(params[:q])
	end
  
end
