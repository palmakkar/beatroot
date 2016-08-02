class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
  validates :first_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                          format: { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
  # def User.digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  #                                                 BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  # end
  
	has_many :posts, dependent: :destroy

	has_many :likes, foreign_key: "liker_id", dependent: :destroy
	has_many :liked_posts, through: :likes, source: :liked

	has_many :follows, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :follows, source: :followed
end
