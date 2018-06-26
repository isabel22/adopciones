# # Add Dog breeds
# dog = AnimalSpecy.where(name: 'Perro').first
# dog_id = dog.id
require 'csv'

namespace :db do
  namespace :seed do
    desc "Seed Dogs from /db/seeds/dogs.csv"
    task :dogs => :environment do
      db_seed_dogs
    end
  end
end


private

def db_seed_dogs
  csv_text = File.read(Rails.root.join('db', 'seeds', 'dogs.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  dog = AnimalSpecy.where(name: 'Perro').first
  dog_id = dog.id
  csv.each do |row|
    breed = row['breed']
    unless (AnimalBreed.where(name: breed, animal_species_id: dog_id).count > 0)
      AnimalBreed.create(name: breed, animal_species_id: dog_id)
    end
  end
end
