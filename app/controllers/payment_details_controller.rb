class PaymentDetailsController < ApplicationController
    before_action :get_payment_details, only: [:show]
    skip_before_action :require_login

  def show; end

  def new
    @payment_details = PaymentDetail.new
  end

  def create
    @payment_details = PaymentDetail.new(payment_details_params)
    @payment_details.time_placed = Time.now
    if @payment_details.save
      session[:order_id] = nil
      session[:product_id] = nil
      redirect_to @payment_details
    else
       render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_payment_details
      @payment_details = PaymentDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_details_params
      params.require(:payment_details).permit(:buyer_name, :email, :cc_expiration_date, :cc_four_digits, :city, :email, :state, :street, :zip, :order_id)
    end
end
