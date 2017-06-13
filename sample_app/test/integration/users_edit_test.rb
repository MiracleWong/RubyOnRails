require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:xieguoliang)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: {name: "",
        email: "hello@126.com",
        password: "foo",
        password_confirmation: "bar"} }
    assert_template "users/edit"
  end
end
