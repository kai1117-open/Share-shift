class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :shift_start_time, null: false
      t.datetime :shift_end_time, null: false
      t.integer :status
      t.string :comment
      t.timestamps
    end

    add_index :shifts, :shift_date
  end
end
