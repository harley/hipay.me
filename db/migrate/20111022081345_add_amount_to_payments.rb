class AddAmountToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :amount, :decimal, :precision => 8, :scale => 2
  end
end
