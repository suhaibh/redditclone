require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
	def setup
		@user = users(:luke)
		@micropost = @user.comments.build(body: "comment body")
	end

	test "comment should be valid" do
		assert @micropost.valid?
	end
end
