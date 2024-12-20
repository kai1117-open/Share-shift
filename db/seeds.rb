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

Prefecture.create!([
  { name: '北海道' }, { name: '青森県' }, { name: '岩手県' }, { name: '宮城県' }, { name: '秋田県' }, 
  { name: '山形県' }, { name: '福島県' }, { name: '茨城県' }, { name: '栃木県' }, { name: '群馬県' },
  { name: '埼玉県' }, { name: '千葉県' }, { name: '東京都' }, { name: '神奈川県' }, { name: '新潟県' },
  { name: '富山県' }, { name: '石川県' }, { name: '福井県' }, { name: '山梨県' }, { name: '長野県' },
  { name: '岐阜県' }, { name: '静岡県' }, { name: '愛知県' }, { name: '三重県' }, { name: '滋賀県' },
  { name: '京都府' }, { name: '大阪府' }, { name: '兵庫県' }, { name: '奈良県' }, { name: '和歌山県' },
  { name: '鳥取県' }, { name: '島根県' }, { name: '岡山県' }, { name: '広島県' }, { name: '山口県' },
  { name: '徳島県' }, { name: '香川県' }, { name: '愛媛県' }, { name: '高知県' }, { name: '福岡県' },
  { name: '佐賀県' }, { name: '長崎県' }, { name: '熊本県' }, { name: '大分県' }, { name: '宮崎県' },
  { name: '鹿児島県' }, { name: '沖縄県' }
])

# ユーザーの作成
users = [
  { email: '000@000', password: '000000', name: '山田花太郎', leader: true, prefecture_id: Prefecture.first.id, role: 1 },
  { email: 'user1@example.com', password: 'password', name: 'ユーザー1', leader: true, prefecture_id: Prefecture.second.id, role: 0 },
  { email: 'user2@example.com', password: 'password', name: 'ユーザー2', leader: false, prefecture_id: Prefecture.third.id, role: 2 }
]

User.create!(users)

# グループの作成
groups = [
  { name: 'グループA', address: '東京都渋谷区', leader_id: User.first.id, prefecture_id: Prefecture.first.id },
  { name: 'グループB', address: '大阪府大阪市', leader_id: User.second.id, prefecture_id: Prefecture.second.id }
]


Group.create!(groups)

# グループメンバーシップの作成
group_memberships = [
  { user_id: User.first.id, group_id: Group.first.id },
  { user_id: User.second.id, group_id: Group.first.id },
  { user_id: User.third.id, group_id: Group.second.id }
]

GroupMembership.create!(group_memberships)

# シフトの作成
shifts = [
  { user_id: User.first.id, shift_start_time: '2024-12-21 09:00:00', shift_end_time: '2024-12-21 17:00:00', status: 0, comment: '午前中は会議' },
  { user_id: User.second.id, shift_start_time: '2024-12-22 10:00:00', shift_end_time: '2024-12-22 18:00:00', status: 1, comment: '午後は外出' }
]

Shift.create!(shifts)

# 投稿の作成
posts = [
  { user_id: User.first.id, title: '初めての投稿', content: 'これは管理者からの最初の投稿です。' },
  { user_id: User.second.id, title: '新しい予定', content: '2024年の予定について話しましょう。' }
]

Post.create!(posts)

# 投稿コメントの作成
post_comments = [
  { user_id: User.second.id, post_id: Post.first.id, content: '素晴らしい投稿ですね！' },
  { user_id: User.first.id, post_id: Post.second.id, content: 'ありがとう！頑張りましょう。' }
]

PostComment.create!(post_comments)

# チャットルームの作成
rooms = [
  {}
]

Room.create!(rooms)

# ユーザーとルームの関連付け
user_rooms = [
  { user_id: User.first.id, room_id: Room.first.id },
  { user_id: User.second.id, room_id: Room.first.id }
]

UserRoom.create!(user_rooms)

# チャットメッセージの作成
chats = [
  { user_id: User.first.id, room_id: Room.first.id, message: 'お疲れ様です！' },
  { user_id: User.second.id, room_id: Room.first.id, message: 'お疲れ様です！どうですか？' }
]

Chat.create!(chats)

# イベントの作成
events = [
  { group_id: Group.first.id, subject: '新しいイベント', content: '2024年1月のイベントについての話し合い' , sent_at: '2024-12-20 10:00:00' },
  { group_id: Group.second.id, subject: 'チームミーティング', content: '2月に予定しているチームミーティング' , sent_at: '2024-12-21 14:00:00' }
]

Event.create!(events)

# グループタグの作成
group_tags = [
  { tag_name: '自動釣銭機', group_id: Group.first.id, content: '新硬貨対応済み' },
  { tag_name: 'セミセルフレジ', group_id: Group.second.id, content: '5台あり' }
]

GroupTag.create!(group_tags)

# グループシフトの作成
group_shifts = [
  { group_id: Group.first.id, shift_start_time: '2024-12-21 09:00:00', shift_end_time: '2024-12-21 17:00:00', status: 0, comment: 'チーム全体での開発時間' },
  { group_id: Group.second.id, shift_start_time: '2024-12-22 10:00:00', shift_end_time: '2024-12-22 18:00:00', status: 1, comment: '営業活動時間' }
]

GroupShift.create!(group_shifts)