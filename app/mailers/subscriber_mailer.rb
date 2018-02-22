class SubscriberMailer < ApplicationMailer
  include SendGrid

  def notification_email(subscriber, event)
    @event = event
    mail(to: subscriber.email, subject: event.name)
  end

  def test_email(subscriber)
    mail(to: subscriber.email, subject: 'Test')
  end
end
