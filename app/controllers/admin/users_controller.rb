class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!  # 管理者がログインしているか確認

  # ユーザー一覧
  def index
    @users = User.all
    @leader_groups = Group.joins(:leader).where(leader_id: User.where(leader: true).pluck(:id))
  end

  # ユーザー詳細
  def show
    @user = User.find(params[:id])
  end

  # ユーザー編集フォーム
  def edit
    @user = User.find_by(id: params[:id])

    if @user.nil?
      redirect_to admin_users_path, alert: '指定されたユーザーが存在しません。'
    else
      @is_leader_in_any_group = user_leader_in_any_group?(@user)
      @leader_groups = Group.where(leader_id: @user.id)
    end
  end

  def user_leader_in_any_group?(user)
    Group.exists?(leader_id: user.id)
  end

  # ユーザー情報更新
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'ユーザー情報を更新しました。'
    else
      flash.now[:alert] = '編集に失敗しました'
      render :edit
    end
  end

  # ユーザー削除
  def destroy
    @user = User.find(params[:id])

    # 対象者がグループリーダーだったら中止させる
    if @user.leader?
      redirect_to admin_users_path, alert: 'グループリーダーは削除できません。'
    else
      @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました。'
    end
  end

  # ユーザー検索
  def search
    @users = User.all

    # 名前で検索
    if params[:name].present?
      @users = @users.where("users.name LIKE ?", "%#{params[:name]}%")
    end

    # 役職で検索
    if params[:role].present?
      @users = @users.where(role: params[:role])
    end

    # リーダーで検索
    if params[:leader].present?
      @users = @users.where(leader: params[:leader])
    end

    # 所属グループで検索
    if params[:group_name].present?
      @users = @users.joins(:groups)  # グループを結合
                     .where("groups.name LIKE ?", "%#{params[:group_name]}%")
    end

    # 都道府県で検索
    if params[:prefecture_id].present?
      @users = @users.where(prefecture_id: params[:prefecture_id])  # 直接prefecture_idでフィルタリング
    end

    @users = @users.order(created_at: :desc)  # 作成日順に並べ替え（オプション）
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :role, :leader, :address, :transportation, :status, :prefecture_id)
  end
end
