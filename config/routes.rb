Rails.application.routes.draw do
  namespace :public do
    resources :users, only: [:index, :show, :edit, :update] do
      # 退会処理のルートを追加
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

  # 顧客用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
end
