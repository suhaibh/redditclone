class Subreddit < ActiveRecord::Base
	belongs_to :user
	has_many :links
end
