class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :meal
  validates_uniqueness_of :meal_id, scope: :user_id
end
