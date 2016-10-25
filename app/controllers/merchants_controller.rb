class MerchantsController < ApplicationController
  before_action :get_merchant, only: [:show, :edit, :update, :destroy]

  # Kelly: I don't know how to use controller filter here yet. So I will temporarily skip authentication requirements.
  skip_before_action :require_login

  # merchants GET    /merchants
  def index
    @merchants = Merchant.all
  end

  # merchant GET    /merchants/:id
  def show
    # @merchant = @current_user? authentication?
    @products = @merchant.products
  end

  # new_merchant GET    /merchants/new
  # def new
  #   @merchant = Merchant.new
  # end

  # mechants POST   /merchants
  # will this come through the factory? user authentication...
  # def create
  #   @merchant = Merchant.new(merchant_params)
  #   if @merchant.save
  #     redirect_to @merchant
  #   else
  #     render :new
  #   end
  # end

  # edit_merchant GET    /merchants/:id/edit
  # def edit; end

  # merchant PUT    /merchants/:id
  # i don't think users should be updated because this is their log-in
  # def update
  #   if @merchant.update(merchant_params)
  #    redirect_to @merchant
  #   else
  #    render :edit
  #   end
  # end

  # merchant DELETE /merchants/:id
  # def destroy
  #   @merchant.destroy
  #   redirect_to merchants_url
  # end

  private
  # Use callbacks to share common setup or constraints between actions.
  def get_merchant
    @merchant = Merchant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # I think this will come through the factory
  def merchant_params
    params.require(:merchant).permit(:email, :user_name, :uid, :provider)
  end
end
