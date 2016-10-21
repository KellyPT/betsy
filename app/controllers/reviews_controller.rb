class ReviewsController < ApplicationController
  before_action :get_review, only: [:show, :edit, :update, :destroy]

  # Kelly: I don't know how to use controller filter here yet. So I will temporarily skip authentication requirements.
  skip_before_action :require_login

  # product_reviews_path	GET	/products/:product_id/reviews
  def index
    # @reviews = Review.all
    @product = Product.find(params[:product_id])
  end

  # product_review_path	GET	/products/:product_id/reviews/:id
  def show; end

  # new_product_review_path	GET	/products/:product_id/reviews/new
  def new
    # @review = Review.new
    product = Product.find(params[:product_id])
    @product_review = product.review.build

  end

  # edit_product_review_path	GET	/products/:product_id/reviews/:id/edit
  def edit; end

  # product_review_path POST	/products/:product_id/reviews(.:format)
  def create
    product = Product.find(params[:product_id])
    @review_product = product.reviews.create(review_params)
    redirect_to product_reviews_path(product.id)

  end

  # product_reivew_path PATCH/PUT /products/:product_id/reviews/:id
  def update
    @product = Product.find(params[:product_id])
    if @review.update(review_params)
       redirect_to product_path(@product)
    else
      render :edit
    end
  end

  # product_review_path DELETE	/products/:product_id/reviews/:id
  def destroy
    @review.destroy
    redirect_to reviews_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :description)
    end
end
