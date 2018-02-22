class Event < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :location, presence: true
  validates :starts_at, presence: true

  validate :not_passed

  has_attached_file :image,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: 'event_default/default_:style.png'
  validates_attachment_content_type :image,
                                    content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/,
                                    message: 'Неверный формат (только jpg/png)'

  belongs_to :event_handler

  scope :ordered_by_date, -> { order(created_at: :desc) }
  scope :name_search,
        ->(name) { where 'lower(name) like ?', "%#{name.downcase}%" }
  scope :location_search,
        ->(location) { where 'lower(location) like ?', "%#{location.downcase}%" }
  scope :event_handler_search,
        ->(event_handler) {
          joins(:event_handler).merge(EventHandler.where('lower(event_handlers.name) like ?', "%#{event_handler.downcase}%"))
        }
  scope :before_now,
        ->(starts_at) { where 'starts_at < ?', starts_at.to_s }
  scope :after_now,
        ->(starts_at) { where 'starts_at >= ?', starts_at.to_s }

  def not_passed
    if starts_at < DateTime.now
      errors.add(:starts_at, 'Начало мероприятия не может быть в прошлом.')
    end
  end
end
