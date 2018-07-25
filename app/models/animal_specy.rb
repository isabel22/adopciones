class AnimalSpecy < ApplicationRecord
  validates :name, uniqueness: true
end
