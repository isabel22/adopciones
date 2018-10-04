# frozen_string_literal: true

class AnimalForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_reference :animals, :animal_breeds, index: true, foreign_key: true
  end
end
