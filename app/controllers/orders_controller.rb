class OrdersController < ApplicationController
  before_action :get_order, only: [:show]
  before_action :require_order, only: [:create]


  # # orders_path	GET	/orders(.:format)
  # def index
  #   @orders = Order.all
  # end

  # order_path	GET	/orders/:id(.:format)
  # I think we will need this incase we purchase form the show page - do we want to expose the id to the user?
  def show
    session[:order_id] = @order.id
  end

  # new_order_path	GET	/orders/new(.:format)
  def new
    @order = Order.new
  end

  # # edit_order_path	GET	/orders/:id/edit(.:format)
  # def edit; end

  # orders_path POST	/orders
  def create

    if @order.save
      session[:order_id] = @order.id
      # redirect_to order_order_items_path(@order) #=> post!
      redirect_to new_order_order_item_path(@order)
    else
      flash[:error] = "Could not add product to cart"
      redirect_to root
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_order
      @order = Order.find(params[:id])
    end

     # Before create action, check if there is a cart.  If there is, it is assined as "current_cart." If not, we make a new order.
    # def current_order
    #   @order ||= Order.find(session[:order_id]) if session[:order_id]
    # end

    def require_order
      @order = Order.build_order # if current_order.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:buyer_name, :cc_expiration_date, :cc_four_digits, :city, :email, :state, :street, :zip)
    # other fields to be set in methods order_status shipped time_placed
    end
end
