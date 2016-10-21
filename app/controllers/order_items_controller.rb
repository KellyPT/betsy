class OrderItemsController < ApplicationController
  before_action :get_order_item, only: [:update, :destroy]
  skip_before_action :require_login

  def index
    @order = Order.find(params[:order_id])
    @order_items = @order.order_items
  end

  def new
  # order controller is redirected here from create (order)
  # when adding an item to the order.  Redirect through a GET
    @order_item = OrderItem.build_order_item(session[:order_id], session[:product_id] )

    if @order_item.save
      redirect_to order_order_items_path
    else
      flash[:error] = "Could not add product to cart"
      redirect_to root
    end
  end

  def update
    product = @order_item.product
    if product.check_availability(order_item_params["quantity"])
      @order_item.update(order_item_params)
    else
      flash[:error] = "Could not increase item quantity"
    end
    redirect_to order_order_items_path(@order_item.order)
  end

  def destroy
    order = @order_item.order
    @order_item.destroy
    redirect_to order_order_items_path(order)
  end

  private
    def get_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def order_item_params
      params.require(:order_item).permit(:quantity)
    end
end
