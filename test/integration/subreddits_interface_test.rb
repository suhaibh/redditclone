require 'test_helper'

class SubredditsInterfaceTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:luke)
		@obiwan = users(:obiwan)
		@subreddit = subreddits(:subreddit_one)
	end

	test "not logged in user should not create subreddit" do
		assert_no_difference 'Subreddit.count' do
			post subreddits_path, subreddit: { 	title: "A Subreddit",
												description: "A Subreddit's description"}
		end
		assert_redirected_to new_user_session_path
	end

	test "logged in user should create subreddit" do
		post new_user_session_path, user: { name: 		@user.name,
											password: 	'password'}
		assert_redirected_to root_path
		follow_redirect!
		assert_select "a[href=?]", destroy_user_session_path
		assert_difference 'Subreddit.count', 1 do
			post subreddits_path, subreddit: { 	title: 			"A subreddit",
												description: 	"A subreddit's description" }
		end
		assert_redirected_to assigns(:subreddit)
	end

	test "correct user should delete subreddit" do
		post new_user_session_path, user: { name: 		@user.name,
		 									password: 	'password'}
		 assert_redirected_to root_path
		 follow_redirect!
		 assert_select "a[href=?]", destroy_user_session_path
		 assert_difference 'Subreddit.count', -1 do
		 	delete subreddit_path(@subreddit)
		 end
		 assert_redirected_to root_path
	end

	test "incorrect user should not delete subreddit" do
		post new_user_session_path, user: { name: 		@obiwan.name,
											password: 	'password'}
		assert_redirected_to root_path
		follow_redirect!
		assert_select "a[href=?]", destroy_user_session_path
		assert_no_difference 'Subreddit.count' do
			delete subreddit_path(@subreddit)
		end
		assert_redirected_to subreddit_path(@subreddit)
	end

	test "non-logged in user should see subreddit" do
		get subreddit_path(@subreddit)
		assert_response :success
		assert_select 'a', "Log in"
		assert_select 'a[href=?]', new_user_session_path
		assert_select 'h1', @subreddit.title
		assert_select 'a[href=?]', new_subreddit_link_path(@subreddit)
	end

	test "non-logged in user should see subreddit index" do
		get subreddits_path
		assert_response :success
		assert_select 'h1', "Subreddits"
		assert_select 'h6', @subreddit.title
	end

end
