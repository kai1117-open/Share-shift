Rails.application.routes.draw do
  namespace :admin do
    resources :homes, only: [:index]
    
    # ユーザー管理（検索機能を追加）
    resources :users, except: [:new, :create] do
      collection do
        get 'search'  # 検索機能を追加
      end
    end
    
    resources :posts, except: [:new, :create]  # 投稿管理
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
    end
  end

  root to: 'homes#top' # トップページをルートに設定
  get 'about', to: 'homes#about', as: 'about' # Aboutページのルートを設定
end
