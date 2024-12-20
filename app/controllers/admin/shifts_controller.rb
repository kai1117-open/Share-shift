class Admin::ShiftsController < ApplicationController
  def index
    # 基本のクエリ
    @shifts = Shift.includes(:user).order(shift_start_time: :asc)

    # グループ名で検索
    if params[:group_name].present?
      @shifts = @shifts.joins(:user).where('users.name LIKE ?', "%#{params[:user_name]}%")
    end

    # ステータスで検索
    if params[:status].present?
      @shifts = @shifts.where(status: params[:status])
    end

  end

end
