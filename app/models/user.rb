class User < ApplicationRecord
  has_many :recipes
  has_many :foods

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  def current_user
    User.find(params[:user_id])
  end
end
