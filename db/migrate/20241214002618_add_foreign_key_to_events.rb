class AddForeignKeyToEvents < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :events, :groups
  end
end
