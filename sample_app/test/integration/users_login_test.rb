require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:jinzhenli)
  end
  
  ###------ 下面的内容是进行登录功能和闪现消息的测试------###
  # 1. 访问登录页面; 
  # 2. 确认正确渲染了登录表单;
  # 3. 提交无效的params散列，向登录路径发起post请求; 
  # 4. 确认重新渲染了登录表单，而且显示了一个闪现消息; 
  # 5. 访问其他页面(例如首页);
  # 6. 确认这个页面中没显示前面那个闪现消息
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  ###------ 下面的内容是进行登录功能和闪现消息的测试------###
  # 1. 访问登录页面;
  # 2. 通过post请求发送有效的登录信息; 
  # 3. 确认登录链接消失了;
  # 4. 确认出现了退出链接;
  # 5. 确认出现了资料页面链接。
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to @user  # 检查重定向的地址是否正确
    follow_redirect!            # 访问重定向的地址
    assert_template 'sessions/show'
    assert_select "a[href=?]", login_path, count: 0 # 确认项目中有零个登录链接
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
end
