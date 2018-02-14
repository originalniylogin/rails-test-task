class Admin < ApplicationRecord

  validates :login,
            presence: true,
            length: { maximum: 32 },
            uniqueness: true

  has_secure_password
  validates :password,
            presence: true

  def Admin.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

end
