class Post < ActiveRecord::Base
	validates :content, presence: :true, length: { minimum: 4, maximum: 50 }
	validates :title, presence: :true, length: { maximum: 150 }
	validates :description, length: { maximum: 2000 }



	default_scope -> { order('created_at DESC') }

	#relationships
	belongs_to :user, dependent: :destroy

  has_many :likes, foreign_key: "liked_id", dependent: :destroy
  has_many :liking_users, :through => :likes, source: :liker
end
