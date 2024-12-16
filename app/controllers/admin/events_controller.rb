class Admin::EventsController < ApplicationController
  before_action :authenticate_admin!  # 管理者専用の認証

  def index
    sort_order = params[:sort] || 'sent_at_asc'
    
    # グループ名での検索と送信日時でのソート
    @events = Event.joins(:group)  # GroupテーブルとJOIN
                   .where('groups.name LIKE ?', "%#{params[:search]}%")  # グループ名でフィルタリング
                   .order(
                     sort_order == 'sent_at_asc' ? 'events.sent_at ASC' : 'events.sent_at DESC'
                   )
  end


  def show
    @group = Group.find(params[:group_id])
    @events = @group.events
  end

end
