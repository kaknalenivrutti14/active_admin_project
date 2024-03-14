class CreateOrderBlockOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :order_block_orders do |t|
      t.string :order_id
      t.string :currency, default: "INR"
      t.belongs_to :user, null: false 
      t.belongs_to :property, null: false

      t.timestamps
    end
  end
end
