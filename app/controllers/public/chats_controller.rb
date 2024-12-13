class Public::ChatsController < ApplicationController
  # チャットルームの表示
  def show
    # チャット相手のユーザーを取得
    @user = User.find(params[:id])
  
    # 現在のユーザーが参加しているチャットルームの一覧を取得
    rooms = current_user.user_rooms.pluck(:room_id)
  
    # 相手ユーザーとの共有チャットルームが存在するか確認
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
  
    unless user_rooms.nil?
      # 共有チャットルームが存在する場合、そのチャットルームを表示
      @room = user_rooms.room
    else
      # 共有チャットルームが存在しない場合、新しいチャットルームを作成
      @room = Room.create
      # チャットルームに現在のユーザーと相手ユーザーを追加
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
  
    # チャットルームに関連付けられたメッセージを取得
    @chats = @room.chats
  
    # 新しいメッセージを作成するための空のChatオブジェクトを生成
    @chat = Chat.new(room_id: @room.id)
  end
  
  # チャットメッセージの送信
  def create
    @chat = current_user.chats.new(chat_params)
    
    if @chat.save
      # チャット送信後、元のチャットルームにリダイレクト
      redirect_to public_chat_path(@chat.room.id)
    else
      flash.now[:alert] = "メッセージを入力してください。"
    
      # showアクションで必要な変数を再設定
      @room = Room.find(params[:chat][:room_id])
      @user = @room.user_rooms.where.not(user_id: current_user.id).first.user
      @chats = @room.chats
      @chat = Chat.new(room_id: @room.id)
    
      redirect_to public_chat_path(@chat.room.id)
    end
  end
  
  private
  
  # フォームから送信されたパラメータを安全に取得
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
