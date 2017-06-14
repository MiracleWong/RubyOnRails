class SayController < ApplicationController
  def hello
    @hello = Hello.new
    if params[:user]
        render :json => @hello.to_json(params[:user])
    else
        render :json => @hello.to_json("Rails")
    end
  end
  def login
    @hello = Hello.new
    @user = User.new
    if params[:username]
      if @user.login(params[:username])
        render :json => @hello.to_json("登录成功")
      end
      
      # @user.login(params[:username], params[:password])
      
    else
      render :json => @hello.to_json("参数错误，从而导致登录失败")
    end
    
  end
end
