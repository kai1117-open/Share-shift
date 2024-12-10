class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!  # 管理者がログインしているか確認

  # 投稿一覧
  def index
    @posts = Post.all
  end

  # 投稿詳細
  def show
    @post = Post.find(params[:id])
    @post_comments = @post.post_comments
  end

  # 投稿編集フォーム
  def edit
    @post = Post.find(params[:id])
  end

  # 投稿更新
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: '投稿を更新しました。'
    else
      render :edit
    end
  end

  # 投稿削除
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: '投稿を削除しました。'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end


  def post_params
    params.require(:post).permit(:title, :content, :author)  # 必要なパラメータを追加
  end
end
