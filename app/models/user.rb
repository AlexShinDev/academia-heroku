class User < ApplicationRecord
  has_secure_password
  has_many :articles
  has_many :highlights, through: :articles
  has_many :highlights

  def user_articles
    article.where(user_id: current_user.id)
  end
end
