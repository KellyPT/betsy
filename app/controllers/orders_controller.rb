class OrdersController < ApplicationController
  before_action :get_order, only: [:show]
  # before_action :require_order, only: [:create]


  # # orders_path	GET	/orders(.:format)
  # def index
  #   @orders = Order.all
  # end

  # Kelly: I don't know how to use controller filter here yet. So I will temporarily skip authentication requirements.
  skip_before_action :require_login

  # orders_path	GET	/orders(.:format)
  def index
    @orders = Order.all
  end


  # order_path	GET	/orders/:id(.:format)
  # I think we will need this incase we purchase form the show page - do we want to expose the id to the user?
  def show; end
    # session[:order_id] = @order.id


  # new_order_path	GET	/orders/new(.:format)
  # def new
  #   @order = Order.new
  # end

  # # edit_order_path	GET	/orders/:id/edit(.:format)
  # def edit; end

  # orders_path POST	/orders
  def create
    if in_stock?
      require_order
      save_order
    else
      flash[:error] = "Product is out of stock"
      redirect_to product_path(@product)
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
      redirect_to new_order_order_item_path(@order)
      else
        flash[:error] = "Something went really wrong!"
        redirect_to root
      end
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:buyer_name, :cc_expiration_date, :cc_four_digits, :city, :email, :state, :street, :zip)
    # other fields to be set in methods order_status shipped time_placed
    end
end
