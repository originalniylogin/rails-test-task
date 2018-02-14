class Admin < ApplicationRecord

  validates :login,
            presence: true,
            length: { maximum: 32 },
            uniqueness: true

  validates :password,
            presence: true

  has_secure_password

end
