class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
     t.belongs_to :order, index: true
     t.belongs_to :product, index: true
     t.integer :quantity
     
     t.timestamps
    end
  end
end
