class User < ApplicationRecord
  # dependent 的作用是在用户被删除的时候，把这个用户发布的微博也删除
  has_many :microposts, dependent: :destroy
  attr_accessor :activation_token
  before_save :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true, length: { maximum: 50} 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 返回指定的字符串的哈希摘要
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 返回一个随机令牌
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 如果指定的令牌和摘要匹配，返回true
  def authenticated?(remember_token)
    ## 在记忆摘要的值为nil的时候，authenticated?返回值为false
    return false if remember_token.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  ## 忘记用户
  def forget
    update_attribute(:remember_digest, nil)
  end

  private
    # 将电子邮件地址转换成小写
    def downcase_email
      self.email = email.downcase
    end

    # 创建并赋值激活令牌和摘要
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
