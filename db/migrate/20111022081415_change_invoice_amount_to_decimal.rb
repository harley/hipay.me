class ChangeInvoiceAmountToDecimal < ActiveRecord::Migration
  def up
    change_column :invoices, :amount, :decimal
  end

  def down
    change_column :invoices, :amount, :integer
  end
end
