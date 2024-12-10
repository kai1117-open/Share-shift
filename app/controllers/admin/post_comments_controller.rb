class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:index, :search, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]

  # コメント一覧
  def index
    # 全てのコメントを取得
    @post_comments = PostComment.all

    # 検索があればそれに基づいてコメントを絞り込む
    if params[:q].present?
      @post_comments = PostComment.where('content LIKE ?', "%#{params[:q]}%")
    end
  end

  # コメント検索
  def search
    if params[:q].present?
      @post_comments = PostComment.where("content LIKE ?", "%#{params[:q]}%")
    else
      @post_comments = PostComment.all
    end
  end

  # コメント編集フォーム
  def edit
  end

  # コメント更新
  def update
    if @comment.update(comment_params)
      redirect_to admin_post_post_comments_path(@post), notice: 'コメントが更新されました'
    else
      render :edit
    end
  end

  # コメント削除
  def destroy
    @comment.destroy
    redirect_to admin_post_comments_path, notice: 'コメントが削除されました'
  end

  private

  # 投稿の設定
  def set_post
    @post = Post.find(params[:post_id]) if params[:post_id]
  end

  # コメントの設定
  def set_comment
    @comment = PostComment.find(params[:id])
  end

  # コメントパラメータ
  def comment_params
    params.require(:post_comment).permit(:content)
  end
end
