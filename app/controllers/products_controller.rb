class ProductsController < ApplicationController
  before_action :get_product, only: [:show, :edit, :update, :destroy]

  before_action :require_login, only: [:new, :create, :edit, :update]

  # products_path	GET	/products
  # merchant_products_path	GET	/merchants/:merchant_id/products
  def index
    if params[:category_id] != nil
      category = Category.find(params[:category_id])
      @products = category.products
    elsif params[:merchant_id] != nil
      @merchant = Merchant.find(params[:merchant_id])
      @products = @merchant.products
    else
      @products = Product.all
    end
  end

  # product_path	GET	/products/:id
  # merchant_product_path	GET	/merchants/:merchant_id/products/:id
  def show
    session[:product_id] = @product.id
    @review = Review.new
    @reviews = Review.where product_id: @product.id
  end

  # new_merchant_product_path	GET	/merchants/:merchant_id/products/new
  def new
    @merchant_product = @current_merchant.products.new
  end


  # merchant_products_path POST	/merchants/:merchant_id/products
  def create
    @merchant_product = @current_merchant.products.new(product_params)
    if @merchant_product.save
      redirect_to merchant_products_path
    else
      render :new
    end
  end

  # edit_merchant_product_path	GET	/merchants/:merchant_id/products/:id/edit
  def edit
    if @product.merchant_id == session[:merchant_id]
      @merchant_product = @product
    else
      render :no_show
    end
  end

  # merchant_product_path PATCH/PUT /merchants/:merchant_id/products/:id
  def update
    if @product.merchant_id == session[:merchant_id]
      @merchant_product = @product
    else
      render :no_show
    end

    if @merchant_product.update(product_params)
      redirect_to merchant_product_path(@current_merchant, @merchant_product.id)
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :quantity, :image, category_ids: [])
    end
end
