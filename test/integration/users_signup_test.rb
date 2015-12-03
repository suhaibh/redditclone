require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	
	test "user signup with invalid information" do
		assert_no_difference 'User.count' do
			post user_registration_path, user: 	{name: "",
											 	 email: "",
											 	 password: "",
											 	 password_confirmation: ""}
		end
		assert_template user_registration_path
	end

	test "user sigunup with valid information" do
		assert_difference 'User.count', 1 do
			post user_registration_path, user: { name:  				"Obi Wan Kenobi",
												 email: 				"obiwankenobi@gmail.com",
												 password: 				"password",
												 password_confirmation: "password" }
		end
		assert_redirected_to root_path
	end

	test "signup should be valid without email" do
		assert_difference 'User.count', 1 do
			post user_registration_path, user: { name:					"Obi Wan Kenobi",
												 email: 				"",
												 password: 				"password",
												 password_confirmation: "password"}
		end
		assert_redirected_to root_path
	end

end
