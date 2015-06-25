class Link < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	acts_as_votable

	def link_score
		get_upvotes.size - get_downvotes.size
	end
end
