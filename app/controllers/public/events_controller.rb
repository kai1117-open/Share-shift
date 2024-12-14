class Public::EventsController < ApplicationController
  before_action :set_group
  before_action :check_group_leader, only: [:new, :create]
  def index
    @events = @group.events.order(created_at: :desc)  # 最新のイベントから表示
  end

  def new
    @event = Event.new
  end

  def create
    @group = Group.find(params[:group_id])
    @subject = params[:event][:subject]
    @content = params[:event][:content]
  
    # Eventオブジェクトを作成して保存
    @event = Event.new(
      group: @group,
      subject: @subject,
      content: @content,
      sent_at: Time.current
    )
  
    if @event.save
      # イベントが保存された後にメール送信
      event = {
        :group => @group,
        :subject => @subject,
        :content => @content
      }
      GroupMailer.send_notifications_to_group(event)
  
      # 成功メッセージを表示
      redirect_to public_group_events_path(@group), notice: '送信が完了しました。'
    else
      # 保存に失敗した場合はエラーメッセージを表示
      Rails.logger.error "Event save failed: #{@event.errors.full_messages.join(', ')}"
      render :new, alert: 'イベントの作成に失敗しました。'
    end
  end
  

  def show
    @event = @group.events.find(params[:id])
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end


  def check_group_leader
    unless @group.leader == current_user
      redirect_to public_group_events_path(@group), alert: 'イベント送信はグループのリーダーだけが行えます。'
    end
  end

  def event_params
    params.require(:event).permit(:subject, :content)
  end
end
