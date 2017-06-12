class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "欢迎来到自动化运维平台"
      redirect_to @user
    else
      render 'new'  
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 处理更新后的情况
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
    
  end

  private
    # 使用到的参数，需要单独进行定义
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # 前置过滤器
    
    # 确保用户已经登录
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    # 确保是正确的用户
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
