class Subscriber < ApplicationRecord

  before_save { self.email = email.downcase }

  validates :email, presence: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }

  after_save do
    events = Event.where(nil)
    events = events.after_now(DateTime.now)

    today_events = events.select do |event|
      event.starts_at - DateTime.now < 1.days
    end
    today_events.each do |event|
      SubscriberMailer.notification_email(self, event).deliver_later
    end


    future_events = events.select do |event|
      event.starts_at - DateTime.now > 1.days
    end
    future_events.each do |event|
      delay = event.starts_at - 1.days - DateTime.now
      SubscriberMailer.delay_for(delay).notification_email(self, event)
    end
  end

end
