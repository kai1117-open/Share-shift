class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # リーダー判定メソッド
  def leader?
    self.leader
  end

 # アカウント状態判定メソッド
  def active?
    self.status
  end


  # 交通手段メニュー
  enum transportation: {
    walking: 0,   # 徒歩
    bicycle: 1,   # 自転車
    car: 2,       # 自動車
    train: 3      # 電車
  }


end
