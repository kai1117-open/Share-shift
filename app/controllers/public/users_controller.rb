class Public::UsersController < ApplicationController
  before_action :authenticate_user!  # 非ログイン時のアクセスを防ぐ
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authorize_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit, :update]

  # ユーザー一覧
  def index
    @users = User.includes(:groups) # ユーザーと関連するグループを取得
    @users = @users.where.not(email: 'guest@example.com')
    # 検索条件があればフィルタリング
    if params[:search].present?
      @users = @users.where('users.name LIKE ?', "%#{params[:search]}%") # ユーザー名のみで検索
    end
  end

  # ユーザー詳細
  def show
  end

  # ユーザー編集フォーム
  def edit
    # ログインユーザーと編集対象ユーザーが一致しない場合、リダイレクト
    if current_user != @user
      redirect_to public_user_path(current_user), alert: '他のユーザーの情報は編集できません。'
    end

    @is_leader_in_any_group = user_leader_in_any_group?(@user)
    @leader_groups = Group.where(leader_id: @user.id)

  end

  def user_leader_in_any_group?(user)
    Group.exists?(leader_id: user.id)
  end

  # ユーザー更新処理
  def update
    # ログインユーザーと編集対象ユーザーが一致しない場合、リダイレクト
    if current_user != @user
      redirect_to public_user_path(current_user), alert: '他のユーザーの情報は編集できません。'
    elsif @user.update(user_params)
      redirect_to public_user_path(@user), notice: 'ユーザー情報が更新されました。'
    else
      render :edit
    end
  end

  def withdraw
    @user = current_user # 現在のログインユーザーを取得

    # status を false に設定して退会処理
    @user.update(status: false) # 退会済みとしてマーク

    # ログアウト処理
    sign_out @user

    # セッションのリセット
    reset_session

    # フラッシュメッセージを設定して、トップページにリダイレクト
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  # ユーザーを設定するための共通メソッド
  def set_user
    @user = User.find(params[:id])
  end

  # ユーザー情報の強いパラメーター
  def user_params
    params.require(:user).permit(:name, :email, :address, :transportation, :role, :prefecture_id)
  end

  # ログインユーザーが管理者または自分の情報のみ編集できるように制限
  def authorize_user
    # 現在のユーザーが編集対象のユーザーまたは管理者でない場合
    if current_user != @user && current_user.role != 'admin'
      redirect_to public_user_path(current_user), alert: '他のユーザーの情報は編集できません。'
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to public_user_path(current_user), notice: "ゲストユーザーは遷移できません。"
    end
  end
end
