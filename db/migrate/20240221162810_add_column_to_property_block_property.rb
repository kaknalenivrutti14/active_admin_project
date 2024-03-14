class AddColumnToPropertyBlockProperty < ActiveRecord::Migration[7.0]
  def change
    add_column :property_block_properties, :is_sold, :boolean, default: false
  end
end
