class MerchantsController < ApplicationController
  before_action :get_merchant, only: [:show, :edit, :update, :destroy]

  # merchants_path	GET	/merchants
  def index
    @merchants = Merchant.all
  end

  # merchant_path	GET	/merchants/:id
  def show; end

  # new_merchant_path	GET	/merchants/new
  def new
    @merchant = Merchant.new
  end

  # edit_merchant_path	GET	/merchants/:id/edit
  def edit; end

  # merchants_path	POST	/merchants
  def create
  #  I think the params come from our factory/authenticaiton...
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      redirect_to @merchant
    else
      render :new
    end
  end

  # merchant_path	PATCH/PUT	/merchants/:id
  def update
    if @merchant.update(merchant_params)
      redirect_to @merchant
    else
      render :edit
    end
  end

  # merchant_path	DELETE	/merchants/:id
  def destroy
    @merchant.destroy
    redirect_to merchants_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_merchant
      @merchant = Merchant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #  I think we get these from our factory...
    # def merchant_params
    #   params.require(:merchant).permit(:email, :username)
    # end
end
