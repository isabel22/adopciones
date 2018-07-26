class AnimalBreed < ApplicationRecord
  belongs_to :animal_specy
  validates :name, uniqueness: { scope: :animal_specy_id,
    message: "already has this breed" }
end
