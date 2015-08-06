class Link < ActiveRecord::Base
	belongs_to :user
	belongs_to :subreddit
	has_many :comments
	acts_as_votable

	validates :title, 		presence: true, length: { maximum: 200 }
	validates :url, 		presence: true
	validates :description, presence: true, length: { maximum: 1000 }
	
	def link_score
		get_upvotes.size - get_downvotes.size
	end
end
