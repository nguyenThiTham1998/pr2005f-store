class ApplicationController < ActionController::Base

	include SessionsHelper
	  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :set_locale
  def logged_in_user

    unless user_signed_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
 
  protected
 
  def configure_permitted_parameters
    added_attrs = [:fullname, :email, :password, :password_confirmation, :remember_me, :image]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

	before_action :set_locale
	
  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  def default_url_options
    {locale: I18n.locale}
  end

	
end
