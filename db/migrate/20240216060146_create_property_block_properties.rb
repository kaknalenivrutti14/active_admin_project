class CreatePropertyBlockProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :property_block_properties do |t|
      t.string :property_name
      t.string :size
      t.float :cost
      t.string :location

      t.timestamps
    end
  end
end
