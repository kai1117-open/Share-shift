class AddPrefectureIdToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :prefecture_id, :integer, null: false
    add_foreign_key :groups, :prefectures
  end
end
