class CreateFavoriteBlockFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_block_favorites do |t|
      t.bigint :user_id, null: false
      t.bigint :property_id, null: false

      t.timestamps
    end
  end
end
