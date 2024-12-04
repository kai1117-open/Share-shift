class Public::PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # 新規投稿入力フォーム
  def new
    @post = Post.new
  end

  # 投稿一覧
  def index
    @posts = Post.all
  end

  # 投稿詳細
  def show
  end

  # 投稿処理
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to public_post_path(@post), notice: '投稿が作成されました。'
    else
      render :new
    end
  end

  # 投稿編集フォーム
  def edit
  end

  # 投稿編集処理
  def update
    if @post.update(post_params)
      redirect_to public_post_path(@post), notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  # 投稿削除処理
  def destroy
    @post.destroy
    redirect_to public_posts_path, notice: '投稿が削除されました。'
  end

  # 投稿検索
  def search
    # params[:query] で検索キーワードを取得
    if params[:query].present?
      @posts = Post.where('title LIKE ? OR content LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @posts = Post.all
    end
  end

  private

  # 投稿を取得する
  def set_post
    @post = Post.find(params[:id])
  end

  # 投稿パラメーターの強いパラメーター
  def post_params
    params.require(:post).permit(:title, :content)
  end
end