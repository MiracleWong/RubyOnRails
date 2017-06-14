require 'json'

class User
  # def to_json(username, password)
  #   return JSON.parse("登录成功")
  # end
  def login(username)
    if username=="wr"
      return true
    end
  end
end