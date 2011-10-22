class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :invoice
      t.string :email
      t.string :last4
      t.boolean :live_mode, :default => false
      t.text :stripe_response

      t.timestamps
    end
    add_index :payments, :invoice_id
  end
end
