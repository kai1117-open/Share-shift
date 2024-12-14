class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :group_id, null: false
      t.string :subject, null: false
      t.string :content, null: false
      t.datetime :sent_at, null: false
      t.timestamps
    end

    add_index :events, :group_id
  end
end