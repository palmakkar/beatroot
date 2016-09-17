class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :bio, length: { maximum: 2000 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                          format: { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
  
  #relationships
	has_many :posts, dependent: :destroy

	has_many :likes, foreign_key: "liker_id", dependent: :destroy
	has_many :liked_posts, through: :likes, source: :liked

	has_many :follows, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :follows, source: :followed

  # Returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
