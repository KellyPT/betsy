class ReviewsController < ApplicationController
  before_action :get_review, only: [:show, :edit, :update, :destroy]

  # product_reviews_path	GET	/products/:product_id/reviews
  def index
    @reviews = Review.all
  end

  # product_review_path	GET	/products/:product_id/reviews/:id
  def show; end

  # new_product_review_path	GET	/products/:product_id/reviews/new
  def new
    @review = Review.new
  end

  # edit_product_review_path	GET	/products/:product_id/reviews/:id/edit
  def edit; end

  # product_review_path POST	/products/:product_id/reviews(.:format)
  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to @review
    else
      render :new
    end
  end

  # product_reivew_path PATCH/PUT /products/:product_id/reviews/:id
  def update
    if @review.update(review_params)
       redirect_to @review
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
