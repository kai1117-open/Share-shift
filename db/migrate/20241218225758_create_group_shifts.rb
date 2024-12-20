class CreateGroupShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :group_shifts do |t|
      t.references :group, null: false, foreign_key: true
      t.datetime :shift_start_time, null: false
      t.datetime :shift_end_time, null: false
      t.integer :status
      t.string :comment

      t.timestamps
    end
    add_index :group_shifts, :shift_start_time
  end
end