class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable


  validates :name, presence: true


  belongs_to :prefecture
  has_many :led_groups, class_name: 'Group', foreign_key: :leader_id
  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships
  has_many :shifts, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :user_rooms
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.prefecture_id = Prefecture.first.id # 任意のデフォルト値を設定
    end
  end



  # リーダー判定メソッド
  def leader?
    self.leader
  end

 # アカウント状態判定メソッド
  def active?
    self.status
  end
  
  def user_leader_in_any_group?(user)
    Group.exists?(leader_id: user.id)
  end

  # 交通手段メニュー
  enum transportation: { walking: 0, bicycle: 1, car: 2, train: 3 }

  def transportation_name
    case transportation
    when "walking"
      "徒歩"
    when "bicycle"
      "自転車"
    when "car"
      "自家用車"
    when "train"
      "公共交通機関"  
    else
      "不明"
    end
  end


  # transportationの選択肢を返すメソッド
  def self.transportation_options
    transportations.keys.map { |key| [I18n.t("#{key}"), key] }
  end



  # 役職メニュー
  enum role: { part_time: 0, part: 1, employee: 2 }

def role_name
  case role
  when "part_time"
    "アルバイト"
  when "part"
    "パート"
  when "employee"
    "社員"
  else
    "不明"
  end
end



  def self.human_enum_name(attribute, value)
    I18n.t("activerecord.attributes.user.#{attribute}.#{value}")
  end
  
end
