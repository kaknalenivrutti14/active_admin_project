class CreateRatingBlockRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :rating_block_ratings do |t|
      t.integer :value
      t.belongs_to :user, null: false
      t.belongs_to :property, null: false

      t.timestamps
    end
  end
end
