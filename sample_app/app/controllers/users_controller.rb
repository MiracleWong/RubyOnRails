class UsersController < ApplicationController
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
      flash[:success] = "Welcome to the simple App! "
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
end
