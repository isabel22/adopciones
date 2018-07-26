class AddBreedReferences < ActiveRecord::Migration[5.2]
  def change
    add_reference :animal_breeds, :animal_species, index: true, foreign_key: true
    remove_reference :animal_breeds, :animal_species, index: true, foreign_key: true
  end
end
