class OrdersController < ApplicationController
  before_action :get_order, only: [:show, :edit, :update, :destroy]
  before_action :require_order, only: [:create]


  # orders_path	GET	/orders(.:format)
  def index
    @orders = Order.all
  end

  # # order_path	GET	/orders/:id(.:format)
  # def show; end

  # new_order_path	GET	/orders/new(.:format)
  # def new
  #   if sessions[]
  #   @order = Order.new
  # end

  # edit_order_path	GET	/orders/:id/edit(.:format)
  def edit; end

  # orders_path POST	/orders
  # assuming we are coming form the product page that has the product_id!....
  def create
    product = Product.find(params[:id])
    order_item = OrderItem.new(quantity: 1)
    @order.order_items << order_item
    product.order_items << order_item

    if order_item.save
      redirect_to orders_path
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

     # Before create action, check if there is a cart.  If there is, it is assined as "current_cart." If not, we make a new order.
    def current_order
      @order ||= Order.find(session[:order_id]) if session[:order_id]
    end

    def require_order
      Order.build_order if current_order.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:buyer_name, :cc_expiration_date, :cc_four_digits, :city, :email, :state, :street, :zip)
    # other fields to be set in methods order_status shipped time_placed
    end
end
