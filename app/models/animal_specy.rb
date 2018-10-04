# frozen_string_literal: true

class AnimalSpecy < ApplicationRecord
  has_many :animal_breeds, dependent: :destroy
  validates :name, uniqueness: true
end
