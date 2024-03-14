class CreateUserBlockEmailOtps < ActiveRecord::Migration[7.0]
  def change
    create_table :user_block_email_otps do |t|
      t.integer :pin
      t.datetime :expire_at
      t.bigint :user_id, null: false

      t.timestamps
    end
  end
end
