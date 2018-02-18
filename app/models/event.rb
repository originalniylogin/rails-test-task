class Event < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :starts_at, presence: true

  has_attached_file :image,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "event_default/default_:style.png"
  validates_attachment_content_type :image,
                                    content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/,
                                    message: 'Неверный формат (только jpg/png)'

  belongs_to :event_handler

  scope :ordered_by_date, -> { order(created_at: :desc) }
  scope :name_search,
        -> (name) { where "lower(name) like ?", "%#{name.downcase}%" }
  scope :location_search,
        -> (location) { where "lower(location) like ?", "%#{location.downcase}%" }
  scope :event_handler_search,
        -> (event_handler) {
          joins(:event_handler).merge(EventHandler.where("lower(event_handlers.name) like ?", "%#{event_handler.downcase}%" ))
        }
  scope :before_now,
        -> (starts_at) { where "starts_at < ?", "#{starts_at}"}
  scope :after_now,
        -> (starts_at) { where "starts_at >= ?", "#{starts_at}"}

  after_save do
    if self.starts_at_changed? && self.starts_at > DateTime.now
      subs = Subscriber.all
      time_left = self.starts_at - DateTime.now
      delay =  time_left < 1.days ? 0 : time_left - 1.days

      subs.each do |sub|
        SubscriberMailer.delay_for(delay).notification_email(sub, self)
      end
    end
  end

end
