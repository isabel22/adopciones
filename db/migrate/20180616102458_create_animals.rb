class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :gender
      t.date :birthdate_rescuedate
      t.boolean :rescued
      t.boolean :adopted
      t.date :adoption_date

      t.timestamps
    end
  end
end
