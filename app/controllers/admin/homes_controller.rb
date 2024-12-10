class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.order(created_at: :desc).limit(5)  # ユーザーを新着順で5件表示
    @active_users = User.where(status: true).order(created_at: :desc).limit(5)  # アクティブユーザーを新着順で5件表示
    @inactive_users = User.where(status: false).order(created_at: :desc).limit(5)  # 非アクティブユーザーを新着順で5件表示
    @posts = Post.order(created_at: :desc).limit(5)  # 投稿を新着順で5件表示
  end
end
