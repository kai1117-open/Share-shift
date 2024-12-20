class AddForeignKeyToEvents < ActiveRecord::Migration[6.1]
  def change
    change_column :events, :group_id, :bigint
    add_foreign_key :events, :groups
  end
end
