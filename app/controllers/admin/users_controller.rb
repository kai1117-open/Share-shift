class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!  # 管理者がログインしているか確認




  # ユーザー一覧
  def index
    @users = User.all
  end

  # ユーザー詳細
  def show
    @user = User.find(params[:id])
  end

  # ユーザー編集フォーム
  def edit
    @user = User.find(params[:id])
  end

  # ユーザー情報更新
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'ユーザー情報を更新しました。'
    else
      render :edit
    end
  end

  # ユーザー削除
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: 'ユーザーを削除しました。'
  end


  def search
    @users = User.all

    # 名前で検索
    if params[:name].present?
      @users = @users.where("name LIKE ?", "%#{params[:name]}%")
    end

    # 役職で検索
    if params[:role].present?
      @users = @users.where(role: params[:role])
    end

    # リーダーで検索
    if params[:leader].present?
      @users = @users.where(leader: params[:leader])
    end

    @users = @users.order(created_at: :desc)  # 作成日順に並べ替え（オプション）
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :role, :leader, :address, :transportation, :status)
  end
end
