class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :leader_id, null: false, foreign_key: true
      t.integer :tag_id, null: false, foreign_key: true
      t.string :name, null: false
      t.string :address, null: false
      t.timestamps
    end

    add_index :groups, :leader_id
    add_index :groups, :tag_id
  end
end
