require 'test_helper'

class LinksInterfaceTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:luke)
		@subreddit = subreddits(:subreddit_one)
		@link = links(:link_one)
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
		get new_user_session_path
		assert_select 'h2', "Log in"
		assert_select 'input[value=?]', "Log in"
		post user_session_path, user: { name: @user.name,
								  		password: 'password' }
		assert_redirected_to root_path
		follow_redirect!
		assert_select 'a[href=?]', destroy_user_session_path
		assert_difference 'Link.count', 1 do
			post subreddit_links_path subreddit_id: @subreddit, link: { title: 			"Title",
																		url: 			"https://www.example.com",
																		description: 	"Link description" }
		end
	end

	test "non-logged in user should be able to see link page" do
		get subreddit_link_path(@link.subreddit, @link)
		assert_response :success
		assert_select "p", "Title: #{@link.title}"
		assert_select "a[href=?]", user_path(@link.user.name)
	end
end
