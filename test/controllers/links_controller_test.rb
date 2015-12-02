require 'test_helper'

class LinksControllerTest < ActionController::TestCase

# Add tests for the rest, including sign in
	def setup
		@user = users(:luke)
		@link_one = links(:link_one)
		@subreddit = subreddits(:subreddit_one)
	end
	
	test "should get new" do
		sign_in @user
		get :new, subreddit_id: @subreddit
		assert_response :success
	end

	test "should redirect to link on create" do
		sign_in @user
		@new_link = {title: "Link title", url:"www.example.com", description: "This is a new link"}
		post :create, subreddit_id: @subreddit, link: @new_link
		assert_redirected_to subreddit_link_path(@subreddit, assigns(:link))
	end

	test "should redirect new to sign in when not signed in" do
		get :new, subreddit_id: @subreddit
		assert_redirected_to new_user_session_path
	end

	test "should get links index" do
  		get :index
  		assert_response :success
  	end

  	test "should get link" do
  		get :show, subreddit_id: @link_one.subreddit, id: @link_one
  		assert_response :success
  	end

  	test "should get edit" do
  		sign_in @user
  		get :edit, subreddit_id: @link_one.subreddit, id: @link_one
  		assert_response :success
  	end

  	test "should render edit when passed invalid information" do
  		sign_in @user
  		patch :edit, subreddit_id: @link_one.subreddit, id: @link_one, link: {title: "", url: "", description: ""}
  		assert_template :edit
  	end

  	test "should redirect edit to sign in when not signed in " do
  		get :edit, subreddit_id: @link_one.subreddit, id: @link_one
  		assert_redirected_to new_user_session_path
  	end
end
