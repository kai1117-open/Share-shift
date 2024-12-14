class Admin::EventsController < ApplicationController
  before_action :authenticate_admin!  # 管理者専用の認証

  def index
    @events = Event.all.includes(:group)  # 全てのイベントを取得（グループ名も一緒に取得）
  end

  def show
    @group = Group.find(params[:group_id])
    @events = @group.events
  end

end
