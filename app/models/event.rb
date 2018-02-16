class Event < ApplicationRecord
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
end
