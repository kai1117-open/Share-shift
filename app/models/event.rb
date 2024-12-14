class Event < ApplicationRecord
  belongs_to :group
  validates :subject, presence: true
  validates :content, presence: true
end
