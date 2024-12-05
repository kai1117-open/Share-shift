# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 管理者ユーザーの作成
admin_user = Admin.create!(
  email: '000@000',
  password: '000000',
  password_confirmation: '000000',
)

# 一般ユーザーの作成
user1 = User.create!(
  name: 'テスト太郎',
  email: 'user1@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  leader: false,  # 一般ユーザー
  address: '大阪府大阪市',
  transportation: 2,  # 交通手段（例：2 = バス）
  status: true  # アカウントの状態
)

user2 = User.create!(
  name: 'テスト山田',
  email: 'user2@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  leader: true,  # リーダー
  address: '福岡県福岡市',
  transportation: 3,  # 交通手段（例：3 = 自転車）
  status: true  # アカウントの状態
)