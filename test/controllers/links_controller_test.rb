require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  test "should get links index" do
  	get :index, subreddit_id: "1"
  	assert_response :success
  end
end
