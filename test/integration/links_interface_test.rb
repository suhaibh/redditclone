require 'test_helper'

class LinksInterfaceTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:luke)
		@subreddit = subreddits(:subreddit_one)
	end

	test "user should be logged in to post link" do
		assert_no_difference 'Link.count' do
			post subreddit_links_path subreddit_id: @subreddit.id, link: {  title: 			"Title",
																			url: 			"www.example.com",
																			description: 	"Description"}
		end
		assert_redirected_to new_user_session_path
	end

	test "logged in user should be able to post link" do
		post user_session_path, user: { name: 'Luke_skywalker',
										password: 'password'}
		assert_difference 'Link.count', 1 do
			post subreddit_links_path subreddit_id: @subreddit, link: { title: 			"Title",
																		url: 			"www.example.com",
																		description: 	"Link description" }
		end
	end
end
