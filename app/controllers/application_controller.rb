class ApplicationController < ActionController::Base

  before_action :set_locale
	include SessionsHelper
  include OrdersHelper
	  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_action :set_search

  include ProductsHelper

  protect_from_forgery 
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :set_locale

  def logged_in_user
    unless user_signed_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def set_search
    @q = Product.includes(:image_attachments).ransack(params[:q])
  end
 
  protected
  def configure_permitted_parameters
    added_attrs = [:fullname,:username, :address, :phone, :email, :password, :password_confirmation, :remember_me,:image]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
  
  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  def default_url_options
    {locale: I18n.locale}
  end

end
