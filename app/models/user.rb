class User < ActiveRecord::Base
  
	has_many :posts, dependent: :destroy

	has_many :likes, foreign_key: "liker_id", dependent: :destroy
	has_many :liked_posts, through: :likes, source: :liked

	has_many :follows, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :follows, source: :followed
end
