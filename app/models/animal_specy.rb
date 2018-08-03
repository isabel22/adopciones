class AnimalSpecy < ApplicationRecord
  has_many :animal_breeds
  validates :name, uniqueness: true
end
