class Public::ChatsController < ApplicationController
  # チャットルームの表示
  def show
    @user = User.find(params[:id])
  
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
  
    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.create
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
  
    @chats = @room.chats
    Rails.logger.debug "チャット一覧: #{@chats.inspect}" # 追加
  
    @chat = Chat.new(room_id: @room.id)
  end
  
  # チャットメッセージの送信
  def create
    @chat = current_user.chats.new(chat_params)
    
    if @chat.save
      # チャット送信後、元のチャットルームにリダイレクト
      @room = Room.find(@chat.room_id)
      @user = @room.user_rooms.where.not(user_id: current_user.id).first.user

      redirect_to public_chat_path(@user.id)
    else
      flash.now[:alert] = "メッセージを入力してください。"
    
      # showアクションで必要な変数を再設定
      @room = Room.find(params[:chat][:room_id])
      @user = @room.user_rooms.where.not(user_id: current_user.id).first.user
      @chats = @room.chats
      @chat = Chat.new(room_id: @room.id)
  
      redirect_to public_chat_path(@user.id)
    end
  end
  
  private
  
  # フォームから送信されたパラメータを安全に取得
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
