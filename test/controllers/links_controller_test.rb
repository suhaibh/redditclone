require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  test "should get links index" do
  	get :index
  	assert_response :success
  end
end
