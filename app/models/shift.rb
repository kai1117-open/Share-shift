class Shift < ApplicationRecord
  belongs_to :user

  validates :shift_start_time, presence: true
  validates :shift_end_time, presence: true
  validates :user_id, presence: true
  validate :end_time_after_start_time

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
  private

  def end_time_after_start_time
    if shift_end_time.present? && shift_start_time.present? && shift_end_time <= shift_start_time
      errors.add(:shift_end_time, "は開始時間より後に設定してください。")
    end
  end
end
