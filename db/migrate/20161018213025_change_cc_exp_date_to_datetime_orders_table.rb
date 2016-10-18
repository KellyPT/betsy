class ChangeCcExpDateToDatetimeOrdersTable < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :cc_expiration_date, :datetime
  end
end
