class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
    t.belongs_to :product, index: true
    t.integer :rating
    t.string  :description

    t.timestamps
    end
  end
end
