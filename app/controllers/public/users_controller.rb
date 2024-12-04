class Public::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to public_user_path(@user), notice: 'ユーザー情報が更新されました。'
    else
      render :edit
    end
  end

  private

  # ユーザーを設定するための共通メソッド
  def set_user
    @user = User.find(params[:id])
  end

  # ユーザー情報の強いパラメーター
  def user_params
    params.require(:user).permit(:name, :email, :address, :transportation, :role)
  end

end
