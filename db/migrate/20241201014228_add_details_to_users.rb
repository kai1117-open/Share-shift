class AddDetailsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :address, :string
    add_column :users, :transportation, :integer, default: 0, null: false
    add_column :users, :status, :boolean, default: true, null: false
  end
end
