class MerchantsController < ApplicationController
  before_action :get_merchant, only: [:show, :edit, :update, :destroy]

  skip_before_action :require_login

  # merchants GET    /merchants
  def index
    @merchants = Merchant.all
  end

  # merchant GET    /merchants/:id
  def show
    # @merchant = @current_user? authentication?
    @products = @merchant.products.where(active: true)
  end

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
