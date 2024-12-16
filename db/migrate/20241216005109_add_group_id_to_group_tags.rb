class AddGroupIdToGroupTags < ActiveRecord::Migration[6.1]
  def change
    add_column :group_tags, :group_id, :integer
    add_index :group_tags, :group_id # インデックスの追加（必要に応じて）
  end
end
