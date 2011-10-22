class AddStripeKeysToUsers < ActiveRecord::Migration
  def change
    add_column :users, :test_stripe_public_key, :string
    add_column :users, :test_stripe_private_key, :string
    add_column :users, :live_stripe_public_key, :string
    add_column :users, :live_stripe_private_key, :string
  end
end
