Rails.application.routes.draw do

  namespace :admin do
    resources :homes, only: [:index]  # 管理者用のホーム画面
  
    # ユーザー管理（検索機能を追加）
    resources :users, except: [:new, :create] do
      collection do
        get 'search'  # ユーザー検索機能を追加
      end
    end
  
    # コメント管理（投稿に依存しないすべてのコメント管理）
    resources :post_comments, only: [:index, :destroy] do
      collection do
        get 'search'  # コメント検索機能
      end
    end
  
    # 投稿管理（コメント管理をネスト）
    resources :posts, except: [:new, :create] do
      resources :post_comments, only: [:index, :destroy, :edit, :update] do
        collection do
          get 'search'  # コメント検索機能
        end
      end
    end
  end

  # その他のルーティング設定（顧客用やdeviseなど）
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :public do

    resources :users, only: [:index, :show, :edit, :update] do
      post 'withdraw', on: :member
    end
    
    resources :posts do
      collection do
        get 'search'
      end
      resources :post_comments, only: [:create, :destroy]
    end

  end

  root to: 'homes#top' # トップページをルートに設定
  get 'about', to: 'homes#about', as: 'about' # Aboutページのルートを設定
end
