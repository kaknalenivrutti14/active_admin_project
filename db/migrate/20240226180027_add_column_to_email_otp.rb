class AddColumnToEmailOtp < ActiveRecord::Migration[7.0]
  def change
    add_column :user_block_email_otps, :status, :boolean, default:false
  end
end
