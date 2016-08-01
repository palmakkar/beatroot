class Post < ActiveRecord::Base
	belongs_to :user, dependent: :destroy
  default_scope -> { order('created_at DESC') }

  has_many :likes, foreign_key: "liked_id", dependent: :destroy
  has_many :liking_users, :through => :likes, source: :liker
end
