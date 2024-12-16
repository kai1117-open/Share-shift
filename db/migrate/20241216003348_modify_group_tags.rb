class ModifyGroupTags < ActiveRecord::Migration[6.1]
  def change
    # group_idカラムの削除
    remove_column :group_tags, :group_id, :integer

    # contentカラムの追加
    add_column :group_tags, :content, :string
  end
end
