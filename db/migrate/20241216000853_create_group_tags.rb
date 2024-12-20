class CreateGroupTags < ActiveRecord::Migration[6.1]
  def change
    create_table :group_tags do |t|
      t.bigint :group_id  # 修正：bigintに変更
      t.string :tag_name, null: false

      t.timestamps
    end

    add_foreign_key :group_tags, :groups  # 外部キー制約を追加
  end
end