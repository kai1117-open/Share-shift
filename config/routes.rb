Rails.application.routes.draw do
  # Public Namespaced Routes
  namespace :public do
    # Events Routes
    get 'events/new'
    get 'events/create'

    # Group Tags Routes
    resources :group_tags, only: [:show]

    # Homes Routes
    resources :homes, only: [:index]

    # Users Routes
    resources :users, only: [:index, :show, :edit, :update] do
      post 'withdraw', on: :member

      # Shifts Routes
      resources :shifts do
        # カレンダーのシフトを取得するルート
        collection do
          get 'calendar_shifts'
        end
      end
    end

    # Groups Routes
    resources :groups, only: [:index, :show] do
      collection do
        get 'search'  # 検索用ルート
      end
      post 'join', on: :member  # グループ参加用のルート
      delete 'leave', on: :member

      # Events Routes
      resources :events, only: [:new, :create, :show, :index]

      # Group Shifts Routes
      resources :group_shifts
    end

    # Posts Routes
    resources :posts do
      collection do
        get 'search'
      end

      # Post Comments Routes
      resources :post_comments, only: [:create, :destroy]
    end

    # Chats Routes
    resources :chats, only: [:index, :show, :create, :destroy]
  end

  # Admin Namespaced Routes
  namespace :admin do
    # Homes Routes
    resources :homes, only: [:index]  # 管理者用のホーム画面

    # Events Routes
    resources :events, only: [:index, :show]

    # Group Tags Routes
    resources :group_tags

    # Group Shifts Routes
    resources :group_shifts, only: [:index]

    # Shifts Routes
    resources :shifts, only: [:index]

    # Groups Routes
    resources :groups do
      collection do
        get 'search'  # 管理者用検索ルート
      end
      member do
        # グループからユーザーが退会するルートを定義
        delete 'leave/:user_id', to: 'groups#leave', as: 'leave_user'
      end

      # Events Routes for Groups
      resources :events, only: [:index]
    end

    # Users Routes
    resources :users, except: [:new, :create] do
      collection do
        get 'search'  # ユーザー検索機能を追加
      end
    end

    # Post Comments Routes
    resources :post_comments, only: [:index, :destroy] do
      collection do
        get 'search'  # コメント検索機能
      end
    end

    # Posts Routes
    resources :posts, except: [:new, :create] do
      # Post Comments Routes nested
      resources :post_comments, only: [:index, :destroy, :edit, :update]
    end
  end

  # Devise Routes
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in', as: :users_guest_sign_in
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # Root Route
  root to: 'homes#top'  # トップページをルートに設定

  # About Route
  get 'about', to: 'homes#about', as: 'about'  # Aboutページのルートを設定
end
