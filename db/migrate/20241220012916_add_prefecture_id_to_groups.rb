class AddPrefectureIdToGroups < ActiveRecord::Migration[6.1]
  def change
    # prefecture_idカラムの型をbigintに変更
    add_column :groups, :prefecture_id, :bigint, null: false
    add_foreign_key :groups, :prefectures
  end
end
