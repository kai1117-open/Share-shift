Rails.application.routes.draw do

  namespace :public do
    get 'events/new'
    get 'events/create'
  end
  namespace :admin do
    resources :homes, only: [:index]  # 管理者用のホーム画面
    resources :events, only: [:index, :show]
    resources :group_tags
    resources :group_shifts, only: [:index]
    resources :shifts, only: [:index]
    resources :groups do
      collection do
        get 'search'  # 管理者用検索ルート
      end
      member do
        # グループからユーザーが退会するルートを定義
        delete 'leave/:user_id', to: 'groups#leave', as: 'leave_user'
      end
      resources :events, only: [:index]
    end


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
    resources :group_tags, only: [:show]
    
    resources :users, only: [:index, :show, :edit, :update] do
      post 'withdraw', on: :member
      resources :shifts do
        # カレンダーのシフトを取得するルート
        collection do
          get 'calendar_shifts'
        end
      end
    end
    
    resources :groups, only: [:index, :show] do
      collection do
        get 'search'  # 検索用ルート
      end
      post 'join', on: :member  # グループ参加用のルート
      delete 'leave', on: :member
      resources :events, only: [:new, :create, :show, :index]
      resources :group_shifts
    end

    resources :posts do
      collection do
        get 'search'
      end
      resources :post_comments, only: [:create, :destroy]
    end

    resources :chats, only: [:index, :show, :create, :destroy] 

  end

  root to: 'homes#top' # トップページをルートに設定
  get 'about', to: 'homes#about', as: 'about' # Aboutページのルートを設定
end
