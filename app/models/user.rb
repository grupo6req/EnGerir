class User < ActiveRecord::Base
	has_secure_password
	has_many :tasks
	belongs_to :area

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Password.create(string, cost: cost)
  end
end
