class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!  # 管理者がログインしているか確認
  before_action :set_post, only: [:show, :edit, :update, :destroy]  # 投稿取得の最適化

  # 投稿一覧
  def index
    @posts = if params[:q].present?
               # 検索クエリがある場合、タイトルと内容で検索
               Post.where('title LIKE ? OR content LIKE ?', "%#{params[:q]}%", "%#{params[:q]}%")
             else
               # 検索クエリがない場合、すべての投稿を表示
               Post.all
             end
  end

  # 投稿詳細
  def show
    @post_comments = @post.post_comments
  end

  # 投稿編集フォーム
  def edit; end

  # 投稿更新
  def update
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: '投稿を更新しました。'
    else
      flash.now[:alert] = '編集に失敗しました'
      render :edit
    end
  end

  # 投稿削除
  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: '投稿を削除しました。'
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
    unless @post
      redirect_to admin_posts_path, alert: '指定された投稿は存在しません。'
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :author)  # 必要なパラメータを追加
  end
end
