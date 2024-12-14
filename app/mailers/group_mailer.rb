class GroupMailer < ApplicationMailer
  def send_notification(member, event)
    @group = event[:group]
    @subject = event[:subject]
    @content = event[:content]
    @mail = GroupMailer.new()
    mail(
      from: ENV['MAIL_ADDRESS'],
      to:   member.email,
      subject: 'New Event Notice!!'
    )
  end
  def self.send_notifications_to_group(event)
    group = event[:group]
    group.users.each do |member|
      GroupMailer.send_notification(member, event).deliver_now
    end
  end
end