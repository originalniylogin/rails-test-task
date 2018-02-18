class EventHandler < ApplicationRecord

  has_many :events, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :ordered_by_date, -> { order(created_at: :desc) }

end
