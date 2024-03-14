class CreateFollowBlockFollowers < ActiveRecord::Migration[7.0]
  def change
    create_table :follow_block_followers do |t|
      t.integer :follower_id
      t.integer :following_id

      t.timestamps
    end
  end
end
