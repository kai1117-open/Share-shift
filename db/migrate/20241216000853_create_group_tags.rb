class CreateGroupTags < ActiveRecord::Migration[6.1]
  def change
    create_table :group_tags do |t|
      t.integer :group_id
      t.string :tag_name, null: false

      t.timestamps
    end
  end
end
