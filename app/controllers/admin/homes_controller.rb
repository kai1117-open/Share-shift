class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.order(created_at: :desc).limit(5)  # 新着5件のユーザー
    @active_users = User.where(status: true).order(created_at: :desc).limit(5)  # 新着5件のアクティブユーザー
    @inactive_users = User.where(status: false).order(created_at: :desc).limit(5)  # 新着5件の非アクティブユーザー
    @groups = Group.order(created_at: :desc).limit(5)  # 新着5件のグループ
    @leader_groups = Group.joins(:leader).where(leader_id: User.where(leader: true).pluck(:id)).order(created_at: :desc).limit(5)  # 新着5件のリーダーグループ
    @posts = Post.order(created_at: :desc).limit(5)  # 新着5件の投稿
  end
end
