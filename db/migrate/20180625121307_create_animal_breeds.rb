# frozen_string_literal: true

class CreateAnimalBreeds < ActiveRecord::Migration[5.2]
  def change
    create_table :animal_breeds do |t|
      t.string :name
      t.references :animal_species, foreign_key: true

      t.timestamps
    end
  end
end
