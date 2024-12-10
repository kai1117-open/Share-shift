class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!  # ログイン必須

  # コメント作成
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.post_comments.new(post_comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to public_post_path(@post), notice: 'コメントを追加しました。'
    else
      redirect_to public_post_path(@post), alert: 'コメントの追加に失敗しました。'
    end
  end

  # コメント削除
  def destroy
    @comment = PostComment.find(params[:id])
    if @comment.user == current_user  # 現在のユーザーとコメントの作成者が一致するかチェック
      @comment.destroy
      redirect_to public_post_path(@comment.post), notice: 'コメントを削除しました。'
    else
      redirect_to public_post_path(@comment.post), alert: '削除権限がありません。'
    end
  end

  private

  # 投稿コメントのパラメーターを許可
  def post_comment_params
    params.require(:post_comment).permit(:content)
  end
end
