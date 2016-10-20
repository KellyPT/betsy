class CategoriesController < ApplicationController
  before_action :get_category, only: [:show, :edit, :update, :destroy]

  # categories GET    /categories
  def index
    @categories = Category.all
  end

  # new_category GET    /categories/new
  def show
    @products = @category.products
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # def edit; end

  # categories POST   /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category
    else
      render :new
    end
  end


  # def update
  #   respond_to do |format|
  #     if @category.update(category_params)
  #       format.html { redirect_to @category, notice: 'Category was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @category }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @category.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # catergory DELETE /categories/:id
  def destroy
    @category.destroy
    redirect_to categories_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # I don't think we should be able to edit catergories, only add so I don't think we need this
    # def category_params
    #   params.require(:category).permit(:name)
    # end
end
