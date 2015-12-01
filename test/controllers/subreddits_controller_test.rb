require 'test_helper'

class SubredditsControllerTest < ActionController::TestCase

  def setup
    @subreddit = subreddits(:subreddit_one)
    @user = users(:luke)
  end

  test "should get new" do
    sign_in @user
    get :new
    assert_response :success
  end

  test "should get show" do
    get :show, id: @subreddit
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @subreddit
    assert_response :success
  end

end
