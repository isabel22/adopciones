# frozen_string_literal: true

class AddAnimalProfilePicture < ActiveRecord::Migration[5.2]
  def change
    add_column :animals, :profile_picture, :string
  end
end
