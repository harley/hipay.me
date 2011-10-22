class AddLiveModeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :live_mode, :boolean, :default => false
  end
end
