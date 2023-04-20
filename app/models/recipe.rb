class Recipe < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 150 }
  validates :preparation_time, presence: true, numericality: true
  validates :cooking_time, presence: true, numericality: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true
end
