require 'test_helper'

class CommentTest < ActiveSupport::TestCase
 def setup
		@user = users(:luke)
		@micropost = @user.comments.build(body: "comment body")
	end

	test "comment should be valid" do
		assert @micropost.valid?
	end

	test "comment should have body" do
		@micropost.body = ""
		assert @micropost.invalid?
	end

	test "comments should be less than 10000 characters" do
		@micropost.body = "a" * 10001
		assert @micropost.invalid?
	end
end
