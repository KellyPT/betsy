class OrderItemsController < ApplicationController
  before_action :get_order_item, only: [:show, :edit, :update, :destroy]

  # order_order_items_path	GET	/orders/:order_id/order_items
  def index
    @order = Order.find(params[:order_id])
    @order_items = @order.order_items
  end

  # order_order_item_path	GET	/orders/:order_id/order_items/:id
  def show; end

  # new_order_order_item_path	GET	/orders/:order_id/order_items/new
  def new
    @order_item = OrderItem.build_order_item(session[:order_id], session[:product_id] )

    if @order_item.save
      redirect_to order_order_items_path
    else
      flash[:error] = "Could not add product to cart"
      redirect_to root
    end
  end

  # edit_order_order_item_path	GET	/orders/:order_id/order_items/:id/edit
  # def edit; end

  # # order_order_items_path POST	/orders/:order_id/order_items
  # def create
  #   @order_item = OrderItem.new
  #   @order_item.order_id = seesion[:order_id]
  #   @order_tiem.product_id = session[:product_id]
  # raise
  # # see comment about order_item_params - we should add these in the model methods or controller?
  #   # @order_item = OrderItem.new(order_item_params)
  #   # if @order_item.save
  #   #  redirect_to @order_item
  #   # else
  #   #   render :new
  #   # end
  # end

  # order_order_items_path PATCH/PUT	/orders/:order_id/order_items/:id
  def update
    product = @order_item.product
    if product.update_quantity(order_item_params["quantity"])
      @order_item.update(order_item_params)
    else
      flash[:error] = "Could not increase item quantity"
    end
    redirect_to order_order_items_path(@order_item.order)
  end

  # do we want to destroy items when removed form cart or set quantity = 0? would give vendors more information about the things that people might have ordered but "put back"
  # order_order_items_path DELETE	/orders/:order_id/order_items/:id
  def destroy
    order = @order_item.order
    @order_item.destroy
    redirect_to order_order_items_path(order)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def order_item_params
      params.require(:order_item).permit(:quantity)
    end
end
