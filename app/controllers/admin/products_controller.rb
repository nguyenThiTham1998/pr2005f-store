class Admin::ProductsController < Admin::ApplicationController
    before_action :find_product, only: [:edit, :update, :destroy, :show]

	def index
        if params[:type]=="deleted"
            @products = Product.includes([:product_details, :image_attachments]).only_deleted 
            @type = "deleted"
        else       
            @products = Product.includes([:product_details, :image_attachments]).all 
        end

	end

    def new       
    	@product = Product.new
    	@product_detail = @product.product_details.build       
    end

    def create 
        pr = product_params.merge(classify: product_params[:classify].to_i, product_type:  product_params[:classify].to_i ) 
        @product = Product.new(pr)
        @product.image.attach(params[:product][:image])
        if @product.save!
            redirect_to admin_products_path
        else
            render 'new'
        end
    end
    def show
        if params[:type] == "deleted"
           @product = Product.only_deleted.find(params[:id])
        else
            @product_details = @product.product_details
            if @product_details.empty?
                flash[:danger] = ''
                redirect_to admin_products_path
            end
        end    
    end    
    def edit
    end

    def update
        if params[:type] == "restore"
            Product.restore(params[:id].to_i, recursive: true)
            redirect_to admin_products_path
        else 
            pr = product_params.merge(classify: product_params[:classify].to_i, product_type:  product_params[:classify].to_i )    
            @product.image.attach(params[:product][:image])
            if @product.update(pr)
                flash[:success] = t ".Product_updated"
                redirect_to admin_products_path
            end
        end
    end

    def destroy
       
        if @product.destroy
            flash[:success] = "Product deleted"
            redirect_to admin_products_path
        end
    end 

    private

    def product_params
        params.require(:product).permit(:name, :classify, :product_type, :image, 
                                        product_details_attributes: [:id, :color, :price, :size, :_destroy])
        
    end

    def find_product
        @product = Product.find_by(slug: params[:id])
    end 
  	

end
