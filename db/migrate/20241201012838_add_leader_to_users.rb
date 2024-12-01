class AddLeaderToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :leader, :boolean, default: false, null: false
  end
end
