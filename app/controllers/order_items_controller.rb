class OrderItemsController < ApplicationController
  before_action :get_order_item, only: [:show, :edit, :update, :destroy]

  # order_order_items_path	GET	/orders/:order_id/order_items
  def index
    @order_items = OrderItem.all
  end

  # order_order_item_path	GET	/orders/:order_id/order_items/:id
  def show; end

  # new_order_order_item_path	GET	/orders/:order_id/order_items/new
  def new
    @order_item = OrderItem.new
  end

  # edit_order_order_item_path	GET	/orders/:order_id/order_items/:id/edit
  def edit; end

  # order_order_items_path POST	/orders/:order_id/order_items
  def create
    @order_item = OrderItem.new(order_item_params)
    if @order_item.save
     redirect_to @order_item
    else
      render :new
    end
  end

  # order_order_items_path PATCH/PUT	/orders/:order_id/order_items/:id
  def update
    if @order_item.update(order_item_params)
      redirect_to @order_item
    else
      render :edit
    end
  end

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
