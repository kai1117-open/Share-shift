class Public::GroupShiftsController < ApplicationController
  before_action :set_group
  before_action :set_shift, only: [:edit, :update, :destroy, :show]
  before_action :check_group_leader, only: [:new, :create, :edit, :update]

  # シフト一覧表示
  def index
    
    # 必要なシフト情報だけを取得し、status_nameを追加
    @shifts = @group.group_shifts.map do |group_shift|
      group_shift.attributes.merge(status_name: group_shift.status_name)
    end
  end
  

  def show

  end

  # シフト作成フォーム
  def new
    @shift = @group.group_shifts.new
  end

  # シフト作成処理
  def create
    @group = Group.find(params[:group_id])
    @group_shift = @group.group_shifts.build(group_shift_params)
    if @group_shift.save
      redirect_to public_group_group_shifts_path(@group), notice: 'シフトが追加されました。'
    else
      render :new
    end
  end

  # シフト編集フォーム
  def edit
  end

  # シフト更新処理
  def update
    
    if @shift.update(shift_params)
      redirect_to public_group_group_shifts_path(@group), notice: 'シフトが更新されました。'
    else
      render :edit
    end
  end



  # シフト削除処理
  def destroy
    @shift.destroy
    redirect_to public_group_group_shifts_path(@group), notice: 'シフトが削除されました。'
  end



  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_shift
    @shift = @group.group_shifts.find(params[:id])
  end

  def group_shift_params
    params.require(:shift).permit(:shift_start_time, :shift_end_time, :status, :comment, :group_id)
  end

  def shift_params
    params.require(:group_shift).permit(:shift_start_time, :shift_end_time, :status, :comment, :group_id)
  end

  def check_group_leader
    unless @group.leader == current_user
      redirect_to public_group_group_shifts_path(@group), alert: 'シフト操作はグループのリーダーのみ行えます'
    end
  end

end
