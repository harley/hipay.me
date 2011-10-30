class AddPayerNameToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :payer_name, :string
  end
end
