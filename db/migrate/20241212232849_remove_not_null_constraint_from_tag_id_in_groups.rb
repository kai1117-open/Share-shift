class RemoveNotNullConstraintFromTagIdInGroups < ActiveRecord::Migration[6.1]
  def change
    change_column_null :groups, :tag_id, true
  end
end
