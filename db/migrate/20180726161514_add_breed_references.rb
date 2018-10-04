# frozen_string_literal: true

class AddBreedReferences < ActiveRecord::Migration[5.2]
  def change
    remove_reference :animal_breeds, :animal_species, index: true, foreign_key: true
    add_reference :animal_breeds, :animal_specy, foreign_key: true
  end
end
