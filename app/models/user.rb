class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable


  validates :name, presence: true

  has_many :posts
  has_many :post_comments, dependent: :destroy

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
  # transportationの選択肢を返すメソッド
  def self.transportation_options
    transportations.keys.map { |key| [I18n.t("#{key}"), key] }
  end



  # 役職メニュー
  enum role: { part_time: 0, part: 1, employee: 2 }

end
