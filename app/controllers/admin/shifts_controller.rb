class Admin::ShiftsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # 基本のクエリ
    @shifts = Shift.includes(:user).order(shift_start_time: :desc)

    # グループ名で検索
    if params[:user_name].present?
      @shifts = @shifts.joins(:user).where('users.name LIKE ?', "%#{params[:user_name]}%")
    end

    # ステータスで検索
    if params[:status].present?
      @shifts = @shifts.where(status: params[:status])
    end

    # 都道府県で検索
    if params[:prefecture_id].present?
      @shifts = @shifts.joins(user: :prefecture).where(prefectures: { id: params[:prefecture_id] })
    end
  end
end
