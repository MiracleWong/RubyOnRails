require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get signup_path
      assert_no_difference 'User.count' do
        post user_path, params: {user: {name: "",
            email: "user@valid",
            password: "foo",
            password_confirmation: "bar" }}
    end
    assert_template 'user/new'
    assert_select 'div#<CSS id for error explanation>'
    assert_select 'div.<CSS class for field with error>'
  end
end
