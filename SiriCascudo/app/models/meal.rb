class Meal < ApplicationRecord
  belongs_to :category
  has_many :favorites, dependent: :destroy
  
  validates_uniqueness_of :name
  validates :name, :description, :price, presence: true
  validates :name, length: {minimum:2, maximum:35}
  validates :description, length: {minimum: 3, maximum: 136}
  validates :price, numericality: { greater_than: 0 }

  has_one_attached :picture
end
