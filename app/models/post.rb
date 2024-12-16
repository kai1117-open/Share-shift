class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  
  validates :title, presence: { message: "を入力してください" }
  validates :content, presence: { message: "を入力してください" }
end
