class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin! # 管理者の認証
  before_action :set_group, only: [:show, :edit, :update, :destroy, :leave]

  # グループ一覧
  def index
    @groups = Group.all
  end

  def show
    # 詳細ページに表示するための処理
  end

  def edit
    @users = User.where(leader: true)
  end

  def update
    if @group.update(group_params)
      redirect_to admin_group_path(@group), notice: 'グループが更新されました。'
    else
      render :edit
    end
  end

  # グループ作成フォーム
  def new
    @group = Group.new
    @users = User.where(leader: true)
  end

  # グループ作成処理
  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to admin_groups_path, notice: 'グループが作成されました。'
    else
      @users = User.all
      flash.now[:alert] = 'グループの作成に失敗しました。'
      render :new
    end
  end

  # グループ検索
  def search
    if params[:keyword].present?
      @groups = Group.where('name LIKE ?', "%#{params[:keyword]}%")
    else
      @groups = Group.all
    end
    render :index
  end

  # 退会アクション
  def leave
    @group = Group.find(params[:id])
    @user = User.find(params[:user_id])
    
    if @group.users.delete(@user)
      redirect_to admin_group_path(@group), notice: "#{@user.name} さんは退会しました。"
    else
      redirect_to admin_group_path(@group), alert: '退会に失敗しました。'
    end
  end

  private

  # ストロングパラメータ
  def group_params
    params.require(:group).permit(:name, :address, :leader_id)
  end

  # グループを設定
  def set_group
    @group = Group.find(params[:id]) # グループを取得
  end
end