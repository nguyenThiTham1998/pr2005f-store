class Admin::SearchsController < Admin::ApplicationController
	  before_action :check_keyword, only: %i(index)

  def index
    # products = Product.includes(:image_attachments).ransack(params[:q]).result
    # users = User.ransack(params[:q]).result
    # @items = products + users
     @products = @q.result(distinct: true)
      # render json: {
      #   data_search: render_to_string(@products)
      # }, status: :ok
  end 
  private
 

  def check_keyword
    @keyword = params[:q].values.first if params[:q]
    return unless @keyword.blank?

    flash[:danger] =  "empty"
    redirect_to root_path
  end
end