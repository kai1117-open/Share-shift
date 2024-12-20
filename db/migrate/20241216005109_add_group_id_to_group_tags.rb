class AddGroupIdToGroupTags < ActiveRecord::Migration[6.1]
  def change
    add_column :group_tags, :group_id, :bigint  # 修正：bigint型に変更
    add_index :group_tags, :group_id  # インデックスの追加（必要に応じて）
  end
end