Rails.application.routes.draw do

  root to: 'homes#top' # トップページをルートに設定
  get 'about', to: 'homes#about', as: 'about' # Aboutページのルートを設定
  
# 顧客用
# URL /customers/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
end
