class Public::HomesController < ApplicationController
  before_action :authenticate_user!

  def index
    # 新着投稿の取得（最新5件）
    @recent_posts = Post.order(created_at: :desc).limit(5)

    # ユーザーが所属しているグループ（複数の場合も考慮）
    @user_groups = current_user.groups if current_user.groups.any?
  end

  private


end