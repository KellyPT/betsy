class OrdersController < ApplicationController
  before_action :get_order, only: [:show]
  skip_before_action :require_login

  # orders_path	GET	/orders(.:format)
  # anticpate this will be used to show a Merchant all of their pending orders when logged in.
  def index
    merchant = Merchant.find(session[:merchant_id])
    @orders = merchant.orders
  end

  def create
    if in_stock?
      require_order
      save_order
      save_order_item
      redirect_to order_order_items_path(@order)
    else
      flash[:error] = "Product is out of stock"
      redirect_to product_path(@product)
    end
  end

=begin
 Are not using these methods yet -- need to think about:
  how to change order status on purchase --> update or edit
  how to cancel an order --> delete
  def update
    if @order.update(order_params)
      redirect_to @order
    else
      render :edit
    end
  end

  # not sure where this will come from, probably a separate route
  # same question as with orders - separate route or pass something through the params that lets us decide, and just use that update method with modle methods?
  def purchase
    @order.purchase_order
    if @order.save
      redirect_to order_path(@order)
    else
      flash[:error] = "Could not purchase order"
      redirect_to root
    end

    sessions[:order_id] = nil

  end

  def cancel
    @order.cancel_order
    if @order.save
      redirect_to order_path(@order)
    else
      flash[:error] = "Could not cancel order"
      redirect_to root
    end

    sessions[:order_id] = nil
  end

  # # order_path DELETE /orders/:id(.:format)
  # def destroy
  #   @order.destroy
  #   redirect_to orders_url
  # end
=end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_order
      @order = Order.find(params[:id])
    end

     # Before create action, check if there is a cart.  If there is, it is assined in "current_order." If not, we make a new order.
    def current_order
      @order ||= Order.find(session[:order_id]) if session[:order_id]
    end

    def require_order
      @order = Order.build_order if current_order.nil?
    end

    def in_stock?
      @product = Product.find(session[:product_id])
      @product.update_quantity(-1)
    end

    def save_order
      if @order.save
        session[:order_id] = @order.id
      else
        flash[:error] = "Something went really wrong!"
      end
    end

    def save_order_item
      order_item = OrderItem.add_order_item_to_order(@order.id, session[:product_id])
      (flash[:error] = "Couldn't add product to cart") unless order_item.save
    end

end
