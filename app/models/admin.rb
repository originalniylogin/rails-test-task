class Admin < ApplicationRecord
  validates :login,
            presence: true,
            length: { maximum: 32 },
            uniqueness: true

  has_secure_password
  validates :password,
            presence: true

  def digest(string)
    cost =
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end

    BCrypt::Password.create(string, cost: cost)
  end
end
