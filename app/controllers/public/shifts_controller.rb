class Public::ShiftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user

  def index
    @user = User.find(params[:user_id]) 
    @shifts = Shift.where(user_id: current_user.id).map do |shift|
      shift.attributes.merge(status_name: shift.status_name)  # status_nameを追加
    end
  end

  def show
    @shift = Shift.find(params[:id]) # 個別のシフトを取得
  end

  def edit
    @user = User.find(params[:user_id])  # ユーザーIDを取得
    @shift = @user.shifts.find(params[:id])  # 指定されたシフトIDを取得
  end

  def new
    @shift = @user.shifts.new
  end

  def create
    # 日時を適切に設定
    @shift = @user.shifts.build(shift_params)

    if @shift.save
      redirect_to public_user_shifts_path(@user), notice: 'シフトが正常に作成されました。'
    else
      render :index
    end
  end

  def update
    @user = User.find(params[:user_id])  # ユーザーIDを取得
    @shift = @user.shifts.find(params[:id])  # 指定されたシフトIDを取得
  
    if @shift.update(shift_params)
      redirect_to public_user_shift_path(@user.id, @shift.id), notice: 'シフトが更新されました'
    else
      render :edit
    end
  end

  def destroy
    @shift.destroy
    redirect_to public_user_shifts_path(@user), notice: 'シフトが削除されました。'
  end

  def calendar_shifts
    @shifts = @user.shifts.where('shift_start_time >= ? AND shift_start_time < ?', Date.current.beginning_of_month, Date.current.end_of_month)

    render json: @shifts.map { |shift| { date: shift.shift_start_time.to_date.to_s, start_time: shift.shift_start_time.strftime('%H:%M'), end_time: shift.shift_end_time.strftime('%H:%M'), comment: shift.comment } }
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_shift
    @shift = @user.shifts.find(params[:id])
  end

  def shift_params
    # :shift_dateを削除し、:shift_start_time, :shift_end_time, :status, :commentを許可
    params.require(:shift).permit(:shift_start_time, :shift_end_time, :status, :comment, :user_id)
  end

  def authorize_user
    # @shift が nil でない場合にユーザーの確認を行う
    if @shift && @shift.user != current_user
      redirect_to public_user_path(@user), alert: '権限がありません。'
    end
  end

end