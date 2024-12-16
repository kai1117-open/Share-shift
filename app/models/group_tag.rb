class GroupTag < ApplicationRecord
  belongs_to :group
  validates :tag_name, presence: { message: "タグ名を入力してください" }
  validates :content, presence: true, allow_blank: true  # 空白も許可
  validates :group_id, presence: true, allow_blank: true  # 空白も許可
end
