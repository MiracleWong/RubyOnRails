require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "Miracle Wong", email: "cfwr1991@126.com")
  end

  test "should be valid" do
    assert @user.valid?
  end  
  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end
  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end
  test "name should not be too long" do
    @user.name = 51 * "a"
    assert_not @user.valid?
  end
  test "email should not be too long" do
    @user.email = 233 * "a" + "cfwr1991@126.com"
    assert_not @user.valid?
  end


end
