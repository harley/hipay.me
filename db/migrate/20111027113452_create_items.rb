class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :invoice
      t.decimal :amount, :precision => 8, :scale => 2
      t.text :note

      t.timestamps
    end
  end
end
