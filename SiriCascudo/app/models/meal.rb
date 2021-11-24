class Meal < ApplicationRecord
  belongs_to :category
  has_many :favorites, dependent: :destroy
  
  validates_uniqueness_of :name
  validates :name, :description, :price, presence: true

  has_one_attached :picture
end
