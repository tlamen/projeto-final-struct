class Meal < ApplicationRecord
  belongs_to :category
  has_many :favorites, dependent: :destroy

  validates :name, :description, :price, presence: true
end
