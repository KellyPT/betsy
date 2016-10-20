class OrderItemsController < ApplicationController
  before_action :get_order_item, only: [:show, :edit, :update, :destroy]

  # order_order_items_path	GET	/orders/:order_id/order_items
  def index
    order = Order.find(params[:order_id])
    @order_items = order.order_items
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
  # should i make two separate methods or just pass a param in the button?
  def update
    add_item(@order_item)
    remove_item(@order_item)
    if @order_item.update
      redirect_to @order_item
    else
      render :edit
    end
  end

  # do we want to destroy items when removed form cart or set quantity = 0? would give vendors more information about the things that people might have ordered but "put back"
  # order_order_items_path DELETE	/orders/:order_id/order_items/:id
  def destroy
    @order_item.destroy
    redirect_to order_items_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_order_item
      @order_item = OrderItem.find(params[:id])
    end

    

    # Never trust parameters from the scary internet, only allow the white list through.
    # I don't think we actually need a param for this because we shouldn't set it through the view???
    # def order_item_params
    #   params.require(:order_item).permit(:quantity)
    # end
end
