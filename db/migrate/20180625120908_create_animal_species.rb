# frozen_string_literal: true

class CreateAnimalSpecies < ActiveRecord::Migration[5.2]
  def change
    create_table :animal_species do |t|
      t.string :name

      t.timestamps
    end
  end
end
