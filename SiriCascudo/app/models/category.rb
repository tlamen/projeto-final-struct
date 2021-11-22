class Category < ApplicationRecord
    has_many :meals, dependent: :destroy
    
    validates :name, presence: true
    validates_uniqueness_of :name
end
