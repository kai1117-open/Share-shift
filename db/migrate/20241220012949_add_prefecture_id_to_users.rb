class AddPrefectureIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :prefecture_id, :integer, null: false
    add_foreign_key :users, :prefectures
  end
end