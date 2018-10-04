# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.string :email
      t.string :address
      t.string :home_phone
      t.string :cellphone
      t.string :country
      t.string :job_position
      t.string :job_address
      t.string :job_phone
      t.text :references, array: true, default: []
      t.boolean :other_pets
      t.text :different_pet, array: true, default: []
      t.boolean :puppy
      t.text :family_members, array: true, default: []
      t.boolean :all_agree
      t.string :type_of_home
      t.boolean :own_home
      t.string :place_to_be
      t.string :place_to_sleep
      t.boolean :has_garden
      t.boolean :can_escape
      t.string :signature
      t.string :status
      t.references :animal

      t.timestamps
    end
  end
end
