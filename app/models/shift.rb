class Shift < ApplicationRecord
  belongs_to :user

  validates :shift_start_time, presence: true
  validates :shift_end_time, presence: true
  validates :user_id, presence: true


  enum status: { unavailable: 0, available: 1, desired: 2 }

  def status_name
    case status
    when "unavailable"
      "出勤不可"
    when "available"
      "出勤可能"
    when "desired"
      "出勤希望"
    else
      "不明"
    end
  end

end
