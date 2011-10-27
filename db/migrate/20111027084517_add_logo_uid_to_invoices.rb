class AddLogoUidToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :logo_uid, :string
  end
end
