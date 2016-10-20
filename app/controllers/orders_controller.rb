class OrdersController < ApplicationController
  before_action :get_order, only: [:show, :edit, :update, :destroy]

  # Kelly: I don't know how to use controller filter here yet. So I will temporarily skip authentication requirements.
  skip_before_action :require_login
  
  # orders_path	GET	/orders(.:format)
  def index
    @orders = Order.all
  end

  # order_path	GET	/orders/:id(.:format)
  def show; end

  # new_order_path	GET	/orders/new(.:format)
  def new
    @order = Order.new
  end

  # edit_order_path	GET	/orders/:id/edit(.:format)
  def edit; end

  # orders_path POST	/orders
  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order
    else
      render :new
    end
  end

  # order_path PATCH/PUT /orders/:id(.:format)
  def update
    if @order.update(order_params)
      redirect_to @order
    else
      render :edit
    end
  end

  # order_path DELETE /orders/:id(.:format)
  def destroy
    @order.destroy
    redirect_to orders_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:buyer_name, :cc_expiration_date, :cc_four_digits, :city, :email, :state, :street, :zip)
    # other fields to be set in methods order_status shipped time_placed
    end
end
