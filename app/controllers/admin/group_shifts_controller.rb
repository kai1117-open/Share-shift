class Admin::GroupShiftsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # 基本のクエリ
    @group_shifts = GroupShift.includes(:group)
                              .order(shift_start_time: :desc)

    # グループ名で検索
    if params[:group_name].present?
      @group_shifts = @group_shifts.joins(:group)
                                   .where('groups.name LIKE ?', "%#{params[:group_name]}%")
    end

    # 都道府県で検索
    if params[:prefecture_id].present?
      @group_shifts = @group_shifts.joins(:group)
                                   .where(groups: { prefecture_id: params[:prefecture_id] })
    end

    # ステータスで検索
    if params[:status].present?
      @group_shifts = @group_shifts.where(status: params[:status])
    end
  end
end
