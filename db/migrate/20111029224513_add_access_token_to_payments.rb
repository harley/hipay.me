class AddAccessTokenToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :access_token, :string
  end
end
