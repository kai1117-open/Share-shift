class Group < ApplicationRecord
  belongs_to :leader, class_name: 'User', foreign_key: :leader_id # リーダーとなるユーザー
  has_many :group_memberships, dependent: :destroy
  has_many :members, through: :group_memberships, source: :user  # メンバーを取得
  has_many :users, through: :group_memberships, source: :user
  has_many :events, dependent: :destroy  # グループに関連するイベントを取得するための関連付け
  
  validates :name, presence: true
end
