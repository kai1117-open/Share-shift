class Admin::GroupShiftsController < ApplicationController
  def index
    # 基本のクエリ
    @group_shifts = GroupShift.includes(:group).order(shift_start_time: :asc)

    # グループ名で検索
    if params[:group_name].present?
      @group_shifts = @group_shifts.joins(:group).where('groups.name LIKE ?', "%#{params[:group_name]}%")
    end

    # ステータスで検索
    if params[:status].present?
      @group_shifts = @group_shifts.where(status: params[:status])
    end

  end


end
