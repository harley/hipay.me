class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :user
      t.string :name
      t.integer :amount
      t.text :description
      t.text :token

      t.timestamps
    end
    add_index :invoices, :user_id
  end
end
