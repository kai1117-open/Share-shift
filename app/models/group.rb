class Group < ApplicationRecord
  belongs_to :leader, class_name: 'User', foreign_key: :leader_id # リーダーとなるユーザー
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships

  validates :name, presence: true
end
