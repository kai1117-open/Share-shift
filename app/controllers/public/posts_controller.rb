class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index] 
  before_action :authorize_user, only: [:edit, :update, :destroy]  # ここで認可処理を追加
  before_action :ensure_guest_user, except: [:show, :index] 

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
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
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
    @post.destroy  # ここでset_postで設定された@postを使います
    redirect_to public_posts_path, notice: '投稿が削除されました。'
  end

  # 投稿検索
  def search
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

  # ユーザーの認可
  def authorize_user
    # 現在のユーザーが投稿の所有者でない場合、アクセスを拒否
    unless @post.user == current_user
      redirect_to public_posts_path, alert: 'この投稿を編集する権限がありません。'
    end
  end

  def ensure_guest_user
    if current_user.email == "guest@example.com"
      redirect_to public_user_path(current_user), notice: "ゲストユーザーの権限では不可能です"
    end
  end 
end
