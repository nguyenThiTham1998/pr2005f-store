class Admin::SearchsController < Admin::ApplicationController
  before_action :check_keyword, only: :index

  def index
    @products = @q.result(distinct: true)
  end

  private

  def check_keyword
    @keyword = params[:q].values.first if params[:q]
    return unless @keyword.blank?
    redirect_to root_path
  end
end
