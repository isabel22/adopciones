class Animal < ApplicationRecord
  # TODO: add different status instead of only set adopted / have control of
  # the animals history.
  has_one :animal_breed

  def other_types
    breed = AnimalBreed.find(self.animal_breeds_id)
    species_id = AnimalSpecy.find(breed.animal_species_id).id
    AnimalSpecy.where.not(id: species_id).pluck(:id, :name)
  end
end
