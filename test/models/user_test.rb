require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(name: "EXAMPLEUSER", email: "exampleuser@example.com", password: "password")
  end

  test "user should be valid" do
  	assert @user.valid?
  end

  test "user without name should be invalid" do
  	@user.name = ""
  	assert @user.invalid?
  end

  test "email should be optional" do
  	@user.email = ""
  	assert @user.valid?
  end

  test "user name should be downcased" do
  	@user.save
  	assert_equal("exampleuser", @user.name)
  end


end
