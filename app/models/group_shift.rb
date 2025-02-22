class GroupShift < ApplicationRecord
  belongs_to :group
  validates :shift_start_time, presence: true
  validates :shift_end_time, presence: true
  validates :status, presence: true
  validate :end_time_after_start_time
  enum status: { unavailable: 0, desired: 1, overstaffed: 2 }

  def status_name
    case status
    when "unavailable"
      "営業不可"
    when "desired"
      "応援希望"
    when "overstaffed"
      "人員過多"
    else
      "不明"
    end
  end

  def end_time_after_start_time
    if shift_end_time.present? && shift_start_time.present? && shift_end_time <= shift_start_time
      errors.add(:shift_end_time, "は開始時間より後に設定してください。")
    end
  end


end
