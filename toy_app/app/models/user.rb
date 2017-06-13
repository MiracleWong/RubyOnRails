class User < ApplicationRecord
  # dependent 的作用是在用户被删除的时候，把这个用户发布的微博也删除
  has_many :microposts, dependent: :destroy
end
